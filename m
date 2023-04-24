Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FD26CF66A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjC2WeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjC2Wd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:33:59 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD56A42
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:33:29 -0700 (PDT)
Date:   Wed, 29 Mar 2023 22:33:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680129205; x=1680388405;
        bh=Be4B0kp3WGDQSZ2PnxwZg09K0ABthR83Sbe7bP+DeJo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=gAyLUAJHsw7gv5iA32NdAQvvBuzVpjCv/5qhHaqLnN8MQPYAxuEuSvseBJhPW2LTF
         2oBwdnXMWhSgz2C058nyb3Iyugac0KwjKh6PmSDYh2hRHGRTPVoYm3qPBemYGGEE7d
         WRoCUX7GbopBiFHeBj5+QJndX07V81ssQjtnOAlUShZzEgktUCcOGGOoJjrm4ZeO09
         mGUCyQab54YiNYF7xl5rhA2/OeWTlqLTtxF6a2typSU0e8cwG2t9yf/SfiumEYYLs4
         NPXBBOVTECnV/+0DSJLkBIWWq12n4VsaFoX8Som5qf4yvYmOX8tbgsjkXZJMi121c7
         O0A8p8zXzjI8A==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v3 04/13] rust: add pin-init API core
Message-ID: <20230329223239.138757-5-y86-dev@protonmail.com>
In-Reply-To: <20230329223239.138757-1-y86-dev@protonmail.com>
References: <20230329223239.138757-1-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benno Lossin <y86-dev@protonmail.com>

This API is used to facilitate safe pinned initialization of structs. It
replaces cumbersome `unsafe` manual initialization with elegant safe macro
invocations.

Due to the size of this change it has been split into six commits:
1. This commit introducing the basic public interface: traits and
   functions to represent and create initializers.
2. Adds the `#[pin_data]`, `pin_init!`, `try_pin_init!`, `init!` and
   `try_init!` macros along with their internal types.
3. Adds the `InPlaceInit` trait that allows using an initializer to create
   an object inside of a `Box<T>` and other smart pointers.
4. Adds the `PinnedDrop` trait and adds macro support for it in
   the `#[pin_data]` macro.
5. Adds the `stack_pin_init!` macro allowing to pin-initialize a struct on
   the stack.
6. Adds the `Zeroable` trait and `init::zeroed` function to initialize
   types that have `0x00` in all bytes as a valid bit pattern.

--

In this section the problem that the new pin-init API solves is outlined.
This message describes the entirety of the API, not just the parts
introduced in this commit. For a more granular explanation and additional
information on pinning and this issue, view [1].

Pinning is Rust's way of enforcing the address stability of a value. When a
value gets pinned it will be impossible for safe code to move it to another
location. This is done by wrapping pointers to said object with `Pin<P>`.
This wrapper prevents safe code from creating mutable references to the
object, preventing mutable access, which is needed to move the value.
`Pin<P>` provides `unsafe` functions to circumvent this and allow
modifications regardless. It is then the programmer's responsibility to
uphold the pinning guarantee.

Many kernel data structures require a stable address, because there are
foreign pointers to them which would get invalidated by moving the
structure. Since these data structures are usually embedded in structs to
use them, this pinning property propagates to the container struct.
Resulting in most structs in both Rust and C code needing to be pinned.

So if we want to have a `mutex` field in a Rust struct, this struct also
needs to be pinned, because a `mutex` contains a `list_head`. Additionally
initializing a `list_head` requires already having the final memory
location available, because it is initialized by pointing it to itself. But
this presents another challenge in Rust: values have to be initialized at
all times. There is the `MaybeUninit<T>` wrapper type, which allows
handling uninitialized memory, but this requires using the `unsafe` raw
pointers and a casting the type to the initialized variant.

This problem gets exacerbated when considering encapsulation and the normal
safety requirements of Rust code. The fields of the Rust `Mutex<T>` should
not be accessible to normal driver code. After all if anyone can modify
the fields, there is no way to ensure the invariants of the `Mutex<T>` are
upheld. But if the fields are inaccessible, then initialization of a
`Mutex<T>` needs to be somehow achieved via a function or a macro. Because
the `Mutex<T>` must be pinned in memory, the function cannot return it by
value. It also cannot allocate a `Box` to put the `Mutex<T>` into, because
that is an unnecessary allocation and indirection which would hurt
performance.

The current solution was to split this function into two parts:

1. A `new` function that returns a partially initialized `Mutex<T>`,
2. An `init` function that requires the `Mutex<T>` to be pinned and that
   fully initializes the `Mutex<T>`.

Both of these functions have to be marked `unsafe`, since a call to `new`
needs to be accompanied with a call to `init`, otherwise using the
`Mutex<T>` could result in UB. And because calling `init` twice also is not
safe. While `Mutex<T>` initialization cannot fail, other structs might
also have to allocate memory, which would result in conditional successful
initialization requiring even more manual accommodation work.

Combine this with the problem of pin-projections -- the way of accessing
fields of a pinned struct -- which also have an `unsafe` API, pinned
initialization is riddled with `unsafe` resulting in very poor ergonomics.
Not only that, but also having to call two functions possibly multiple
lines apart makes it very easy to forget it outright or during refactoring.

Here is an example of the current way of initializing a struct with two
synchronization primitives (see [2] for the full example):

    struct SharedState {
        state_changed: CondVar,
        inner: Mutex<SharedStateInner>,
    }

    impl SharedState {
        fn try_new() -> Result<Arc<Self>> {
            let mut state =3D Pin::from(UniqueArc::try_new(Self {
                // SAFETY: `condvar_init!` is called below.
                state_changed: unsafe { CondVar::new() },
                // SAFETY: `mutex_init!` is called below.
                inner: unsafe {
                    Mutex::new(SharedStateInner { token_count: 0 })
                },
            })?);

            // SAFETY: `state_changed` is pinned when `state` is.
            let pinned =3D unsafe {
                state.as_mut().map_unchecked_mut(|s| &mut s.state_changed)
            };
            kernel::condvar_init!(pinned, "SharedState::state_changed");

            // SAFETY: `inner` is pinned when `state` is.
            let pinned =3D unsafe {
                state.as_mut().map_unchecked_mut(|s| &mut s.inner)
            };
            kernel::mutex_init!(pinned, "SharedState::inner");

            Ok(state.into())
        }
    }

The pin-init API of this patch solves this issue by providing a
comprehensive solution comprised of macros and traits. Here is the example
from above using the pin-init API:

    #[pin_data]
    struct SharedState {
        #[pin]
        state_changed: CondVar,
        #[pin]
        inner: Mutex<SharedStateInner>,
    }

    impl SharedState {
        fn new() -> impl PinInit<Self> {
            pin_init!(Self {
                state_changed <- new_condvar!("SharedState::state_changed")=
,
                inner <- new_mutex!(
                    SharedStateInner { token_count: 0 },
                    "SharedState::inner",
                ),
            })
        }
    }

Notably the way the macro is used here requires no `unsafe` and thus comes
with the usual Rust promise of safe code not introducing any memory
violations. Additionally it is now up to the caller of `new()` to decide
the memory location of the `SharedState`. They can choose at the moment
`Arc<T>`, `Box<T>` or the stack.

--

The API has the following architecture:
1. Initializer traits `PinInit<T, E>` and `Init<T, E>` that act like
   closures.
2. Macros to create these initializer traits safely.
3. Functions to allow manually writing initializers.

The initializers (an `impl PinInit<T, E>`) receive a raw pointer pointing
to uninitialized memory and their job is to fully initialize a `T` at that
location. If initialization fails, they return an error (`E`) by value.

This way of initializing cannot be safely exposed to the user, since it
relies upon these properties outside of the control of the trait:
- the memory location (slot) needs to be valid memory,
- if initialization fails, the slot should not be read from,
- the value in the slot should be pinned, so it cannot move and the memory
  cannot be deallocated until the value is dropped.

This is why using an initializer is facilitated by another trait that
ensures these requirements.

These initializers can be created manually by just supplying a closure that
fulfills the same safety requirements as `PinInit<T, E>`. But this is an
`unsafe` operation. To allow safe initializer creation, the `pin_init!` is
provided along with three other variants: `try_pin_init!`, `try_init!` and
`init!`. These take a modified struct initializer as a parameter and
generate a closure that initializes the fields in sequence.
The macros take great care in upholding the safety requirements:
- A shadowed struct type is used as the return type of the closure instead
  of `()`. This is to prevent early returns, as these would prevent full
  initialization.
- To ensure every field is only initialized once, a normal struct
  initializer is placed in unreachable code. The type checker will emit
  errors if a field is missing or specified multiple times.
- When initializing a field fails, the whole initializer will fail and
  automatically drop fields that have been initialized earlier.
- Only the correct initializer type is allowed for unpinned fields. You
  cannot use a `impl PinInit<T, E>` to initialize a structurally not pinned
  field.

To ensure the last point, an additional macro `#[pin_data]` is needed. This
macro annotates the struct itself and the user specifies structurally
pinned and not pinned fields.

Because dropping a pinned struct is also not allowed to break the pinning
invariants, another macro attribute `#[pinned_drop]` is needed. This
macro is introduced in a following commit.

These two macros also have mechanisms to ensure the overall safety of the
API. Additionally, they utilize a combined proc-macro, declarative macro
design: first a proc-macro enables the outer attribute syntax `#[...]` and
does some important pre-parsing. Notably this prepares the generics such
that the declarative macro can handle them using token trees. Then the
actual parsing of the structure and the emission of code is handled by a
declarative macro.

For pin-projections the crates `pin-project` [3] and `pin-project-lite` [4]
had been considered, but were ultimately rejected:
- `pin-project` depends on `syn` [5] which is a very big dependency, around
  50k lines of code.
- `pin-project-lite` is a more reasonable 5k lines of code, but contains a
  very complex declarative macro to parse generics. On top of that it
  would require modification that would need to be maintained
  independently.

Link: https://rust-for-linux.com/the-safe-pinned-initialization-problem [1]
Link: https://github.com/Rust-for-Linux/linux/blob/f509ede33fc10a07eba3da14=
aa00302bd4b5dddd/samples/rust/rust_miscdev.rs [2]
Link: https://crates.io/crates/pin-project [3]
Link: https://crates.io/crates/pin-project-lite [4]
Link: https://crates.io/crates/syn [5]
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
---
 rust/kernel/init.rs    | 210 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   7 ++
 scripts/Makefile.build |   2 +-
 3 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/init.rs

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
new file mode 100644
index 000000000000..5e5e4dc6bae7
--- /dev/null
+++ b/rust/kernel/init.rs
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! API to safely and fallibly initialize pinned `struct`s using in-place =
constructors.
+//!
+//! It also allows in-place initialization of big `struct`s that would oth=
erwise produce a stack
+//! overflow.
+//!
+//! Most `struct`s from the [`sync`] module need to be pinned, because the=
y contain self-referential
+//! `struct`s from C. [Pinning][pinning] is Rust's way of ensuring data do=
es not move.
+//!
+//! # Overview
+//!
+//! To initialize a `struct` with an in-place constructor you will need tw=
o things:
+//! - an in-place constructor,
+//! - a memory location that can hold your `struct`.
+//!
+//! To get an in-place constructor there are generally two options:
+//! - a custom function/macro returning an in-place constructor provided b=
y someone else,
+//! - using the unsafe function [`pin_init_from_closure()`] to manually cr=
eate an initializer.
+//!
+//! Aside from pinned initialization, this API also supports in-place cons=
truction without pinning,
+//! the marcos/types/functions are generally named like the pinned variant=
s without the `pin`
+//! prefix.
+//!
+//! [`sync`]: kernel::sync
+//! [pinning]: https://doc.rust-lang.org/std/pin/index.html
+//! [structurally pinned fields]:
+//!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural=
-for-field
+//! [`Arc<T>`]: crate::sync::Arc
+//! [`impl PinInit<Foo>`]: PinInit
+//! [`impl PinInit<T, E>`]: PinInit
+//! [`impl Init<T, E>`]: Init
+//! [`Opaque`]: kernel::types::Opaque
+//! [`pin_data`]: ::macros::pin_data
+//! [`UniqueArc<T>`]: kernel::sync::UniqueArc
+//! [`Box<T>`]: alloc::boxed::Box
+
+use core::{convert::Infallible, marker::PhantomData, mem::MaybeUninit};
+
+/// A pinned initializer for `T`.
+///
+/// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`].
+///
+/// Also see the [module description](self).
+///
+/// # Safety
+///
+/// When implementing this type you will need to take great care. Also the=
re are probably very few
+/// cases where a manual implementation is necessary. Use [`pin_init_from_=
closure`] where possible.
+///
+/// The [`PinInit::__pinned_init`] function
+/// - returns `Ok(())` if it initialized every field of `slot`,
+/// - returns `Err(err)` if it encountered an error and then cleaned `slot=
`, this means:
+///     - `slot` can be deallocated without UB occurring,
+///     - `slot` does not need to be dropped,
+///     - `slot` is not partially initialized.
+/// - while constructing the `T` at `slot` it upholds the pinning invarian=
ts of `T`.
+///
+/// [`Arc<T>`]: crate::sync::Arc
+/// [`Arc::pin_init`]: crate::sync::Arc::pin_init
+/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
+/// [`Box<T>`]: alloc::boxed::Box
+#[must_use =3D "An initializer must be used in order to create its value."=
]
+pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: Sized {
+    /// Initializes `slot`.
+    ///
+    /// # Safety
+    ///
+    /// - `slot` is a valid pointer to uninitialized memory.
+    /// - the caller does not touch `slot` when `Err` is returned, they ar=
e only permitted to
+    ///   deallocate.
+    /// - `slot` will not move until it is dropped, i.e. it will be pinned=
.
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E>;
+}
+
+/// An initializer for `T`.
+///
+/// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Because [`PinInit<T, E>`]=
 is a super trait, you can
+/// use every function that takes it as well.
+///
+/// Also see the [module description](self).
+///
+/// # Safety
+///
+/// When implementing this type you will need to take great care. Also the=
re are probably very few
+/// cases where a manual implementation is necessary. Use [`init_from_clos=
ure`] where possible.
+///
+/// The [`Init::__init`] function
+/// - returns `Ok(())` if it initialized every field of `slot`,
+/// - returns `Err(err)` if it encountered an error and then cleaned `slot=
`, this means:
+///     - `slot` can be deallocated without UB occurring,
+///     - `slot` does not need to be dropped,
+///     - `slot` is not partially initialized.
+/// - while constructing the `T` at `slot` it upholds the pinning invarian=
ts of `T`.
+///
+/// The `__pinned_init` function from the supertrait [`PinInit`] needs to =
execute the exact same
+/// code as `__init`.
+///
+/// Contrary to its supertype [`PinInit<T, E>`] the caller is allowed to
+/// move the pointee after initialization.
+///
+/// [`Arc<T>`]: crate::sync::Arc
+/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
+/// [`Box<T>`]: alloc::boxed::Box
+#[must_use =3D "An initializer must be used in order to create its value."=
]
+pub unsafe trait Init<T: ?Sized, E =3D Infallible>: PinInit<T, E> {
+    /// Initializes `slot`.
+    ///
+    /// # Safety
+    ///
+    /// - `slot` is a valid pointer to uninitialized memory.
+    /// - the caller does not touch `slot` when `Err` is returned, they ar=
e only permitted to
+    ///   deallocate.
+    unsafe fn __init(self, slot: *mut T) -> Result<(), E>;
+}
+
+type Invariant<T> =3D PhantomData<fn(*mut T) -> *mut T>;
+// This is the module-internal type implementing `PinInit` and `Init`. It =
is unsafe to create this
+// type, since the closure needs to fulfill the same safety requirement as=
 the
+// `__pinned_init`/`__init` functions.
+struct InitClosure<F, T: ?Sized, E>(F, Invariant<(E, T)>);
+
+// SAFETY: While constructing the `InitClosure`, the user promised that it=
 upholds the
+// `__pinned_init` invariants.
+unsafe impl<T: ?Sized, F, E> PinInit<T, E> for InitClosure<F, T, E>
+where
+    F: FnOnce(*mut T) -> Result<(), E>,
+{
+    #[inline]
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+        (self.0)(slot)
+    }
+}
+
+// SAFETY: While constructing the `InitClosure`, the user promised that it=
 upholds the
+// `__init` invariants.
+unsafe impl<T: ?Sized, F, E> Init<T, E> for InitClosure<F, T, E>
+where
+    F: FnOnce(*mut T) -> Result<(), E>,
+{
+    #[inline]
+    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
+        (self.0)(slot)
+    }
+}
+
+/// Creates a new [`PinInit<T, E>`] from the given closure.
+///
+/// # Safety
+///
+/// The closure:
+/// - returns `Ok(())` if it initialized every field of `slot`,
+/// - returns `Err(err)` if it encountered an error and then cleaned `slot=
`, this means:
+///     - `slot` can be deallocated without UB occurring,
+///     - `slot` does not need to be dropped,
+///     - `slot` is not partially initialized.
+/// - may assume that the `slot` does not move if `T: !Unpin`,
+/// - while constructing the `T` at `slot` it upholds the pinning invarian=
ts of `T`.
+#[inline]
+pub const unsafe fn pin_init_from_closure<T: ?Sized, E>(
+    f: impl FnOnce(*mut T) -> Result<(), E>,
+) -> impl PinInit<T, E> {
+    InitClosure(f, PhantomData)
+}
+
+/// Creates a new [`Init<T, E>`] from the given closure.
+///
+/// # Safety
+///
+/// The closure:
+/// - returns `Ok(())` if it initialized every field of `slot`,
+/// - returns `Err(err)` if it encountered an error and then cleaned `slot=
`, this means:
+///     - `slot` can be deallocated without UB occurring,
+///     - `slot` does not need to be dropped,
+///     - `slot` is not partially initialized.
+/// - the `slot` may move after initialization.
+/// - while constructing the `T` at `slot` it upholds the pinning invarian=
ts of `T`.
+#[inline]
+pub const unsafe fn init_from_closure<T: ?Sized, E>(
+    f: impl FnOnce(*mut T) -> Result<(), E>,
+) -> impl Init<T, E> {
+    InitClosure(f, PhantomData)
+}
+
+/// An initializer that leaves the memory uninitialized.
+///
+/// The initializer is a no-op. The `slot` memory is not changed.
+#[inline]
+pub fn uninit<T>() -> impl Init<MaybeUninit<T>> {
+    // SAFETY: The memory is allowed to be uninitialized.
+    unsafe { init_from_closure(|_| Ok(())) }
+}
+
+// SAFETY: Every type can be initialized by-value.
+unsafe impl<T> PinInit<T> for T {
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), Infallible> =
{
+        unsafe { slot.write(self) };
+        Ok(())
+    }
+}
+
+// SAFETY: Every type can be initialized by-value.
+unsafe impl<T> Init<T> for T {
+    unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {
+        unsafe { slot.write(self) };
+        Ok(())
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 223564f9f0cc..3e2777d26ff5 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -16,7 +16,9 @@
 #![feature(coerce_unsized)]
 #![feature(core_ffi_c)]
 #![feature(dispatch_from_dyn)]
+#![feature(explicit_generic_args_with_impl_trait)]
 #![feature(generic_associated_types)]
+#![feature(new_uninit)]
 #![feature(receiver_trait)]
 #![feature(unsize)]

@@ -25,11 +27,16 @@
 #[cfg(not(CONFIG_RUST))]
 compile_error!("Missing kernel configuration for conditional compilation")=
;

+#[allow(unused_extern_crates)]
+// Allow proc-macros to refer to `::kernel` inside the `kernel` crate (thi=
s crate).
+extern crate self as kernel;
+
 #[cfg(not(test))]
 #[cfg(not(testlib))]
 mod allocator;
 mod build_assert;
 pub mod error;
+pub mod init;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 76323201232a..f9bdc01c8191 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ------------------------------------------------------------------------=
---

-rust_allowed_features :=3D core_ffi_c
+rust_allowed_features :=3D core_ffi_c,explicit_generic_args_with_impl_trai=
t

 rust_common_cmd =3D \
 =09RUST_MODFILE=3D$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
--
2.39.2


