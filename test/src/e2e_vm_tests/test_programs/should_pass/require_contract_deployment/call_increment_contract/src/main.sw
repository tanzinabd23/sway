script;

use increment_abi::Incrementor;
use dynamic_contract_call::*;

#[cfg(experimental_new_encoding = false)]
const CONTRACT_ID = 0x4440ac68a7f88e414ae29425ab22c6aed0434cf6632d0ee1d41ab82607923493;
#[cfg(experimental_new_encoding = true)]
const CONTRACT_ID = 0x3e74f971fb1f8e3076af8f343dd4f5191b2363f3606091e5e0cbe86e6109dd30;

fn main() -> bool {
    let the_abi = abi(Incrementor, CONTRACT_ID);

    let initial = the_abi.get();

    let result = the_abi.increment(5);
    assert(result == initial + 5);

    let result = the_abi.increment(5);
    assert(result == initial + 10);

    let result = the_abi.get();
    assert(result == initial + 10);

    log(result);

    // Call the fallback fn
    let result = dynamic_contract_call(CONTRACT_ID);
    assert(result == 444444444);

    true
}

fn log(input: u64) {
    asm(r1: input, r2: 42) {
        log r1 r2 r2 r2;
    }
}
