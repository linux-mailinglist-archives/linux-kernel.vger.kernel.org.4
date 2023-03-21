Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E061F6C3AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCUTu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCUTuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:50:55 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B6A58B7F;
        Tue, 21 Mar 2023 12:50:22 -0700 (PDT)
Date:   Tue, 21 Mar 2023 19:50:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679428218; x=1679687418;
        bh=SSvQe9S1lWzR2BDPdkFkw4Ie3E5mE+jtFZ616l94XVg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=aHuL763qiCM64KjGDG2fxvrqbhoZNuROdVqJfHnMB+wI+3yuHRk8QnOW8EEt5ftbm
         VpfBg/HHcl+U7uL25bAoG46Hh7r2n8+I7GfzHSv+0OBZMY/TdY/h28PRcTfhlY4vHH
         Skbhn1PVTXiUOAjFT3yTms3L17K2RMkSVU01SCxfhfTKN5HazQDhqFFg1hVUOXjAaF
         8iKsNoTXayeL4hC6I5KUR9+xhb8TtROgHZ9Q7CMGzM2K3LuVCHk+U/QeBOcGIxebQK
         77lh695DM+3piO+nsLw5a7r8obzzfIXLkHIHZS86xxWhAOVWU1yuKZCf/6qWeyD70/
         tA84f4lTBCnwg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 3/5] rust: add pin-init API
Message-ID: <20230321194934.908891-4-y86-dev@protonmail.com>
In-Reply-To: <20230321194934.908891-1-y86-dev@protonmail.com>
References: <20230321194934.908891-1-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This API is used to facilitate safe pinned initialization of structs. It
replaces cumbersome `unsafe` manual initialization with elegant safe macro
invocations.

--

In this section the problem that the new pin-init API solves is outlined.
For a more granular explanation and additional information on pinning and
this issue, view [1].

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
invariants, another macro attribute `#[pinned_drop]` is needed.

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
 rust/kernel/init.rs        | 1428 ++++++++++++++++++++++++++++++++++++
 rust/kernel/init/macros.rs |  481 ++++++++++++
 rust/kernel/lib.rs         |    7 +
 rust/kernel/prelude.rs     |    6 +-
 rust/kernel/sync/arc.rs    |   25 +-
 rust/kernel/types.rs       |    8 +
 rust/macros/lib.rs         |   78 ++
 rust/macros/pin_data.rs    |   79 ++
 rust/macros/pinned_drop.rs |   49 ++
 scripts/Makefile.build     |    2 +-
 10 files changed, 2160 insertions(+), 3 deletions(-)
 create mode 100644 rust/kernel/init.rs
 create mode 100644 rust/kernel/init/macros.rs
 create mode 100644 rust/macros/pin_data.rs
 create mode 100644 rust/macros/pinned_drop.rs

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
new file mode 100644
index 000000000000..895845db6f2b
--- /dev/null
+++ b/rust/kernel/init.rs
@@ -0,0 +1,1428 @@
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
+//! - a memory location that can hold your `struct` (this can be the [stac=
k], an [`Arc<T>`],
+//!   [`UniqueArc<T>`], [`Box<T>`] or any other smart pointer that impleme=
nts [`InPlaceInit`]).
+//!
+//! To get an in-place constructor there are generally three options:
+//! - directly creating an in-place constructor using the [`pin_init!`] ma=
cro,
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
+//! # Examples
+//!
+//! ## Using the [`pin_init!`] macro
+//!
+//! If you want to use [`PinInit`], then you will have to annotate your `s=
truct` with
+//! `#[`[`pin_data`]`]`. It is a macro that uses `#[pin]` as a marker for
+//! [structurally pinned fields]. After doing this, you can then create an=
 in-place constructor via
+//! [`pin_init!`]. The syntax is almost the same as normal `struct` initia=
lizers. The difference is
+//! that you need to write `<-` instead of `:` for fields that you want to=
 initialize in-place.
+//!
+//! ```rust
+//! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+//! use kernel::{prelude::*, sync::Mutex, new_mutex};
+//! # use core::pin::Pin;
+//! #[pin_data]
+//! struct Foo {
+//!     #[pin]
+//!     a: Mutex<usize>,
+//!     b: u32,
+//! }
+//!
+//! let foo =3D pin_init!(Foo {
+//!     a <- new_mutex!(42, "Foo::a"),
+//!     b: 24,
+//! });
+//! ```
+//!
+//! `foo` now is of the type [`impl PinInit<Foo>`]. We can now use any sma=
rt pointer that we like
+//! (or just the stack) to actually initialize a `Foo`:
+//!
+//! ```rust
+//! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+//! # use kernel::{prelude::*, sync::Mutex, new_mutex};
+//! # use core::pin::Pin;
+//! # #[pin_data]
+//! # struct Foo {
+//! #     #[pin]
+//! #     a: Mutex<usize>,
+//! #     b: u32,
+//! # }
+//! # let foo =3D pin_init!(Foo {
+//! #     a <- new_mutex!(42, "Foo::a"),
+//! #     b: 24,
+//! # });
+//! let foo: Result<Pin<Box<Foo>>> =3D Box::pin_init(foo);
+//! ```
+//!
+//! For more information see the [`pin_init!`] macro.
+//!
+//! ## Using a custom function/macro that returns an initializer
+//!
+//! Many types from the kernel supply a function/macro that returns an ini=
tializer, because the
+//! above method only works for types where you can access the fields.
+//!
+//! ```rust
+//! # use kernel::{new_mutex, sync::{Arc, Mutex}};
+//! let mtx: Result<Arc<Mutex<usize>>> =3D Arc::pin_init(new_mutex!(42, "e=
xample::mtx"));
+//! ```
+//!
+//! To declare an init macro/function you just return an [`impl PinInit<T,=
 E>`]:
+//!
+//! ```rust
+//! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+//! # use kernel::{sync::Mutex, prelude::*, new_mutex, init::PinInit, try_=
pin_init};
+//! #[pin_data]
+//! struct DriverData {
+//!     #[pin]
+//!     status: Mutex<i32>,
+//!     buffer: Box<[u8; 1_000_000]>,
+//! }
+//!
+//! impl DriverData {
+//!     fn new() -> impl PinInit<Self, Error> {
+//!         try_pin_init!(Self {
+//!             status <- new_mutex!(0, "DriverData::status"),
+//!             buffer: Box::init(kernel::init::zeroed())?,
+//!         })
+//!     }
+//! }
+//! ```
+//!
+//! ## Manual creation of an initializer
+//!
+//! Often when working with primitives the previous approaches are not suf=
ficient. That is where
+//! [`pin_init_from_closure()`] comes in. This `unsafe` function allows yo=
u to create a
+//! [`impl PinInit<T, E>`] directly from a closure. Of course you have to =
ensure that the closure
+//! actually does the initialization in the correct way. Here are the thin=
gs to look out for
+//! (we are calling the parameter to the closure `slot`):
+//! - when the closure returns `Ok(())`, then it has completed the initial=
ization successfully, so
+//!   `slot` now contains a valid bit pattern for the type `T`,
+//! - when the closure returns `Err(e)`, then the caller may deallocate th=
e memory at `slot`, so
+//!   you need to take care to clean up anything if your initialization fa=
ils mid-way,
+//! - you may assume that `slot` will stay pinned even after the closure r=
eturns until `drop` of
+//!   `slot` gets called.
+//!
+//! ```rust
+//! use kernel::init::{PinInit, self};
+//! use core::{ptr::addr_of_mut, marker::PhantomPinned};
+//! # mod bindings {
+//! #     pub struct foo;
+//! #     pub unsafe fn init_foo(_ptr: *mut foo) {}
+//! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
+//! #     pub unsafe fn enable_foo(_ptr: *mut foo, _flags: u32) -> i32 { 0=
 }
+//! # }
+//! /// # Invariants
+//! ///
+//! /// `foo` is always initialized
+//! pub struct RawFoo {
+//!     foo: Opaque<bindings::foo>,
+//!     _p: PhantomPinned,
+//! }
+//!
+//! impl RawFoo {
+//!     pub fn new(flags: u32) -> impl PinInit<Self, Error> {
+//!         // SAFETY:
+//!         // - when the closure returns `Ok(())`, then it has successful=
ly initialized and
+//!         //   enabled `foo`,
+//!         // - when it returns `Err(e)`, then it has cleaned up before
+//!         unsafe {
+//!             init::pin_init_from_closure(move |slot: *mut Self| {
+//!                 // `slot` contains uninit memory, avoid creating a ref=
erence.
+//!                 let foo =3D addr_of_mut!((*slot).foo);
+//!
+//!                 // Initialize the `foo`
+//!                 bindings::init_foo(Opaque::raw_get(foo));
+//!
+//!                 // Try to enable it.
+//!                 let err =3D bindings::enable_foo(Opaque::raw_get(foo),=
 flags);
+//!                 if err !=3D 0 {
+//!                     // Enabling has failed, first clean up the foo and=
 then return the error.
+//!                     bindings::destroy_foo(Opaque::raw_get(foo));
+//!                     return Err(Error::from_kernel_errno(err));
+//!                 }
+//!
+//!                 // All fields of `RawFoo` have been initialized, since=
 `_p` is a ZST.
+//!                 Ok(())
+//!             })
+//!         }
+//!     }
+//! }
+//!
+//! impl Drop for RawFoo {
+//!     fn drop(&mut self) {
+//!         // SAFETY: Since `foo` is initialized, destroying is safe.
+//!         unsafe { bindings::destroy_foo(self.foo.get()) };
+//!     }
+//! }
+//! ```
+//!
+//! For the special case where initializing a field is a single FFI-functi=
on call that cannot fail,
+//! there exist helper functions in [`kernel::init::common`]. These functi=
ons initialize a single
+//! [`Opaque`] field by just delegating to the FFI-function. You can use t=
hese in combination with
+//! [`pin_init!`].
+//!
+//! For more information on how to use [`pin_init_from_closure()`], take a=
 look at the uses inside
+//! the `kernel` crate. The [`sync`] module is a good starting point.
+//!
+//! [`sync`]: kernel::sync
+//! [pinning]: https://doc.rust-lang.org/std/pin/index.html
+//! [structurally pinned fields]:
+//!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural=
-for-field
+//! [stack]: crate::stack_pin_init
+//! [`Arc<T>`]: crate::sync::Arc
+//! [`impl PinInit<Foo>`]: PinInit
+//! [`impl PinInit<T, E>`]: PinInit
+//! [`impl Init<T, E>`]: Init
+//! [`Opaque`]: kernel::types::Opaque
+//! [`pin_data`]: ::macros::pin_data
+
+use crate::{
+    error::{self, Error},
+    sync::UniqueArc,
+};
+use alloc::boxed::Box;
+use core::{
+    cell::Cell,
+    convert::Infallible,
+    marker::{PhantomData, Unpin},
+    mem::MaybeUninit,
+    pin::Pin,
+    ptr,
+};
+
+#[doc(hidden)]
+pub mod macros;
+
+/// Initialize and pin a type directly on the stack.
+///
+/// # Examples
+///
+/// ```rust
+/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # use kernel::{init, pin_init, stack_pin_init, init::*, sync::Mutex, n=
ew_mutex};
+/// # use macros::pin_data;
+/// # use core::pin::Pin;
+/// #[pin_data]
+/// struct Foo {
+///     #[pin]
+///     a: Mutex<usize>,
+///     b: Bar,
+/// }
+///
+/// #[pin_data]
+/// struct Bar {
+///     x: u32,
+/// }
+///
+/// let a =3D new_mutex!(42, "Foo::a");
+///
+/// stack_pin_init!(let foo =3D? pin_init!(Foo {
+///     a,
+///     b: Bar {
+///         x: 64,
+///     },
+/// }));
+/// let foo: Pin<&mut Foo> =3D foo;
+/// # Ok::<(), core::convert::Infallible>(())
+/// ```
+///
+/// # Syntax
+///
+/// A normal `let` binding with optional type annotation. The expression i=
s expected to implement
+/// [`PinInit`]. Additionally a `?` can be put after the `=3D`, this will =
assign `Pin<&mut T>` to the
+/// variable instead of `Result<Pin<&mut T>, E>`.
+#[macro_export]
+macro_rules! stack_pin_init {
+    (let $var:ident $(: $t:ty)? =3D $val:expr) =3D> {
+        let mut $var =3D $crate::init::StackInit$(::<$t>)?::uninit();
+        let mut $var =3D {
+            let val =3D $val;
+            unsafe { $crate::init::StackInit::init(&mut $var, val) }
+        };
+    };
+    (let $var:ident $(: $t:ty)? =3D? $val:expr) =3D> {
+        let mut $var =3D $crate::init::StackInit$(::<$t>)?::uninit();
+        let mut $var =3D {
+            let val =3D $val;
+            unsafe { $crate::init::StackInit::init(&mut $var, val)? }
+        };
+    };
+}
+
+/// Construct an in-place, pinned initializer for `struct`s.
+///
+/// This macro defaults the error to [`Infallible`]. If you need [`Error`]=
, then use
+/// [`try_pin_init!`].
+///
+/// The syntax is almost identical to that of a normal `struct` initialize=
r:
+///
+/// ```rust
+/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # use kernel::{init, pin_init, macros::pin_data, init::*};
+/// # use core::pin::Pin;
+/// #[pin_data]
+/// struct Foo {
+///     a: usize,
+///     b: Bar,
+/// }
+///
+/// #[pin_data]
+/// struct Bar {
+///     x: u32,
+/// }
+///
+/// # fn demo() -> impl PinInit<Foo> {
+/// let a =3D 42;
+///
+/// let initializer =3D pin_init!(Foo {
+///     a,
+///     b: Bar {
+///         x: 64,
+///     },
+/// });
+/// # initializer }
+/// # Box::pin_init(demo()).unwrap();
+/// ```
+///
+/// Arbitrary Rust expressions can be used to set the value of a variable.
+///
+/// # Init-functions
+///
+/// When working with this API it is often desired to let others construct=
 your types without
+/// giving access to all fields. This is where you would normally write a =
plain function `new`
+/// that would return a new instance of your type. With this API that is a=
lso possible.
+/// However, there are a few extra things to keep in mind.
+///
+/// To create an initializer function, simply declare it like this:
+///
+/// ```rust
+/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # use kernel::{init, pin_init, prelude::*, init::*};
+/// # use core::pin::Pin;
+/// # #[pin_data]
+/// # struct Foo {
+/// #     a: usize,
+/// #     b: Bar,
+/// # }
+/// # #[pin_data]
+/// # struct Bar {
+/// #     x: u32,
+/// # }
+///
+/// impl Foo {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             a: 42,
+///             b: Bar {
+///                 x: 64,
+///             },
+///         })
+///     }
+/// }
+/// ```
+///
+/// Users of `Foo` can now create it like this:
+///
+/// ```rust
+/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # use kernel::{init, pin_init, macros::pin_data, init::*};
+/// # use core::pin::Pin;
+/// # #[pin_data]
+/// # struct Foo {
+/// #     a: usize,
+/// #     b: Bar,
+/// # }
+/// # #[pin_data]
+/// # struct Bar {
+/// #     x: u32,
+/// # }
+/// # impl Foo {
+/// #     fn new() -> impl PinInit<Self> {
+/// #         pin_init!(Self {
+/// #             a: 42,
+/// #             b: Bar {
+/// #                 x: 64,
+/// #             },
+/// #         })
+/// #     }
+/// # }
+/// let foo =3D Box::pin_init(Foo::new());
+/// ```
+///
+/// They can also easily embed it into their own `struct`s:
+///
+/// ```rust
+/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # use kernel::{init, pin_init, macros::pin_data, init::*};
+/// # use core::pin::Pin;
+/// # #[pin_data]
+/// # struct Foo {
+/// #     a: usize,
+/// #     b: Bar,
+/// # }
+/// # #[pin_data]
+/// # struct Bar {
+/// #     x: u32,
+/// # }
+/// # impl Foo {
+/// #     fn new() -> impl PinInit<Self> {
+/// #         pin_init!(Self {
+/// #             a: 42,
+/// #             b: Bar {
+/// #                 x: 64,
+/// #             },
+/// #         })
+/// #     }
+/// # }
+/// #[pin_data]
+/// struct FooContainer {
+///     #[pin]
+///     foo1: Foo,
+///     #[pin]
+///     foo2: Foo,
+///     other: u32,
+/// }
+///
+/// impl FooContainer {
+///     fn new(other: u32) -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             foo1 <- Foo::new(),
+///             foo2 <- Foo::new(),
+///             other,
+///         })
+///     }
+/// }
+/// ```
+///
+/// Here we see that when using `pin_init!` with `PinInit`, one needs to w=
rite `<-` instead of `:`.
+/// This signifies that the given field is initialized in-place. As with `=
struct` initializers, just
+/// writing the field (in this case `other`) without `:` or `<-` means `ot=
her: other,`.
+///
+/// # Syntax
+///
+/// As already mentioned in the examples above, inside of `pin_init!` a `s=
truct` initializer with
+/// the following modifications is expected:
+/// - Fields that you want to initialize in-place have to use `<-` instead=
 of `:`.
+/// - In front of the initializer you can write `&this in` to have access =
to a [`NonNull<Self>`]
+///   pointer named `this` inside of the initializer.
+///
+/// For instance:
+///
+/// ```rust
+/// # use kernel::pin_init;
+/// # use macros::pin_data;
+/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
+/// #[pin_data]
+/// struct Buf {
+///     ptr: *mut u8,
+///     buf: [u8; 64],
+///     #[pin]
+///     pin: PhantomPinned,
+/// }
+/// pin_init!(&this in Buf {
+///     buf: [0; 64],
+///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
+///     pin: PhantomPinned,
+/// });
+/// ```
+///
+/// [`try_pin_init!`]: kernel::try_pin_init
+/// [`NonNull<Self>`]: core::ptr::NonNull
+#[macro_export]
+macro_rules! pin_init {
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }) =3D> {
+        $crate::try_pin_init!(
+            @this($($this)?),
+            @type_name($t),
+            @typ($t $(<$($generics),*>)?),
+            @fields($($fields)*),
+            @error(::core::convert::Infallible),
+        )
+    };
+}
+
+/// Construct an in-place, fallible pinned initializer for `struct`s.
+///
+/// If the initialization can complete without error (or [`Infallible`]), =
then use [`pin_init!`].
+///
+/// You can use the `?` operator or use `return Err(err)` inside the initi=
alizer to stop
+/// initialization and return the error.
+///
+/// IMPORTANT: if you have `unsafe` code inside of the initializer you hav=
e to ensure that when
+/// initialization fails, the memory can be safely deallocated without any=
 further modifications.
+///
+/// This macro defaults the error to [`Error`].
+///
+/// The syntax is identical to [`pin_init!`] with the following exception:=
 you can append `? $type`
+/// after the `struct` initializer to specify the error type you want to u=
se.
+///
+/// # Examples
+///
+/// ```rust
+/// use kernel::{init::PinInit, error::Error};
+/// struct BigBuf {
+///     big: Box<[u8; 1024 * 1024 * 1024]>,
+///     small: [u8; 1024 * 1024],
+///     ptr: *mut u8,
+/// }
+///
+/// impl BigBuf {
+///     fn new() -> impl PinInit<Self, Error> {
+///         try_pin_init!(Self {
+///             big: {
+///                 let zero =3D Box::try_new_zeroed()?;
+///                 unsafe { zero.assume_init() }
+///             },
+///             small: [0; 1024 * 1024],
+///             ptr: core::ptr::null_mut(),
+///         }? Error)
+///     }
+/// }
+/// ```
+#[macro_export]
+macro_rules! try_pin_init {
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }) =3D> {
+        $crate::try_pin_init!(
+            @this($($this)?),
+            @type_name($t),
+            @typ($t $(<$($generics),*>)?),
+            @fields($($fields)*),
+            @error($crate::error::Error),
+        )
+    };
+    ($(&$this:ident in)? $t:ident $(<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }? $err:ty) =3D> {
+        $crate::try_pin_init!(
+            @this($($this)?),
+            @type_name($t),
+            @typ($t $(<$($generics),*>)?),
+            @fields($($fields)*),
+            @error($err),
+        )
+    };
+    (
+        @this($($this:ident)?),
+        @type_name($t:ident),
+        @typ($ty:ty),
+        @fields($($fields:tt)*),
+        @error($err:ty),
+    ) =3D> {{
+        // We do not want to allow arbitrary returns, so we declare this t=
ype as the `Ok` return
+        // type and shadow it later when we insert the arbitrary user code=
. That way there will be
+        // no possibility of returning without `unsafe`.
+        struct __InitOk;
+        let init =3D move |slot: *mut $ty| -> ::core::result::Result<__Ini=
tOk, $err> {
+            {
+                // Shadow the structure so it cannot be used to return ear=
ly.
+                struct __InitOk;
+                // Create the `this` so it can be referenced by the user i=
nside of the expressions
+                // creating the individual fields.
+                $(let $this =3D unsafe { ::core::ptr::NonNull::new_uncheck=
ed(slot) };)?
+                // Initialize every field.
+                $crate::try_pin_init!(init_slot:
+                    @typ($ty),
+                    @slot(slot),
+                    @munch_fields($($fields)*,),
+                );
+                // We use unreachable code to ensure that all fields have =
been mentioned exactly
+                // once, this struct initializer will still be type-checke=
d and complain with a
+                // very natural error message if a field is forgotten/ment=
ioned more than once.
+                #[allow(unreachable_code, clippy::diverging_sub_expression=
)]
+                if false {
+                    $crate::try_pin_init!(make_initializer:
+                        @typ($ty),
+                        @type_name($t),
+                        @munch_fields($($fields)*,),
+                        @acc(),
+                    );
+                }
+                // Forget all guards, since initialization was a success.
+                $crate::try_pin_init!(forget_guards:
+                    @munch_fields($($fields)*,),
+                );
+            }
+            Ok(__InitOk)
+        };
+        let init =3D move |slot: *mut $ty| -> ::core::result::Result<(), $=
err> {
+            init(slot).map(|__InitOk| ())
+        };
+        let init =3D unsafe { $crate::init::pin_init_from_closure::<$ty, $=
err>(init) };
+        init
+    }};
+    (init_slot:
+        @typ($ty:ty),
+        @slot($slot:ident),
+        @munch_fields($(,)?),
+    ) =3D> {
+        // Endpoint of munching, no fields are left.
+    };
+    (init_slot:
+        @typ($ty:ty),
+        @slot($slot:ident),
+        // In-place initialization syntax.
+        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+    ) =3D> {
+        let $field =3D $val;
+        // Call the initializer.
+        //
+        // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
+        // return when an error/panic occurs.
+        // We also use the `__PinData` to request the correct trait (`Init=
` or `PinInit`).
+        unsafe {
+            <$ty as $crate::init::__PinData>::__PinData::$field(
+                ::core::ptr::addr_of_mut!((*$slot).$field),
+                $field,
+            )?;
+        }
+        // Create the drop guard.
+        //
+        // We only give access to `&DropGuard`, so it cannot be forgotten =
via safe code.
+        //
+        // SAFETY: We forget the guard later when initialization has succe=
eded.
+        let $field =3D &unsafe {
+            $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$slot=
).$field))
+        };
+
+        $crate::try_pin_init!(init_slot:
+            @typ($ty),
+            @slot($slot),
+            @munch_fields($($rest)*),
+        );
+    };
+    (init_slot:
+        @typ($ty:ty),
+        @slot($slot:ident),
+        // Direct value init, this is safe for every field.
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+    ) =3D> {
+        $(let $field =3D $val;)?
+        // Call the initializer.
+        //
+        // SAFETY: The memory at `slot` is uninitialized.
+        unsafe { ::core::ptr::addr_of_mut!((*$slot).$field).write($field) =
};
+        // Create the drop guard:
+        //
+        // We only give access to `&DropGuard`, so it cannot be accidental=
ly forgotten.
+        //
+        // SAFETY: We forget the guard later when initialization has succe=
eded.
+        let $field =3D &unsafe {
+            $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$slot=
).$field))
+        };
+
+        $crate::try_pin_init!(init_slot:
+            @typ($ty),
+            @slot($slot),
+            @munch_fields($($rest)*),
+        );
+    };
+    (make_initializer:
+        @typ($ty:ty),
+        @type_name($t:ident),
+        @munch_fields($(,)?),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        // Endpoint, nothing more to munch.
+        let _: $ty =3D $t {
+            $($acc)*
+        };
+    };
+    (make_initializer:
+        @typ($ty:ty),
+        @type_name($t:ident),
+        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        $crate::try_pin_init!(make_initializer:
+            @typ($ty),
+            @type_name($t),
+            @munch_fields($($rest)*),
+            @acc($($acc)* $field: ::core::panic!(),),
+        );
+    };
+    (make_initializer:
+        @typ($ty:ty),
+        @type_name($t:ident),
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        $crate::try_pin_init!(make_initializer:
+            @typ($ty),
+            @type_name($t),
+            @munch_fields($($rest)*),
+            @acc($($acc)* $field: ::core::panic!(),),
+        );
+    };
+    (forget_guards:
+        @munch_fields($(,)?),
+    ) =3D> {
+        // Munching finished.
+    };
+    (forget_guards:
+        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+    ) =3D> {
+        unsafe { $crate::init::DropGuard::forget($field) };
+
+        $crate::try_pin_init!(forget_guards:
+            @munch_fields($($rest)*),
+        );
+    };
+    (forget_guards:
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+    ) =3D> {
+        unsafe { $crate::init::DropGuard::forget($field) };
+
+        $crate::try_pin_init!(forget_guards:
+            @munch_fields($($rest)*),
+        );
+    };
+}
+
+/// Construct an in-place initializer for `struct`s.
+///
+/// This macro defaults the error to [`Infallible`]. If you need [`Error`]=
, then use
+/// [`try_init!`].
+///
+/// The syntax is identical to [`pin_init!`].
+///
+/// This initializer is for initializing data in-place that might later be=
 moved. If you want to
+/// pin-initialize, use [`pin_init!`].
+#[macro_export]
+macro_rules! init {
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }) =3D> {
+        $crate::try_init!(
+            @this($($this)?),
+            @type_name($t),
+            @typ($t $(<$($generics),*>)?),
+            @fields($($fields)*),
+            @error(::core::convert::Infallible),
+        )
+    }
+}
+
+/// Construct an in-place fallible initializer for `struct`s.
+///
+/// This macro defaults the error to [`Error`]. If you need [`Infallible`]=
, then use
+/// [`init!`].
+///
+/// The syntax is identical to [`try_pin_init!`]. If you want to specify a=
 custom error,
+/// append `? $type` after the `struct` initializer.
+///
+/// # Examples
+///
+/// ```rust
+/// use kernel::{init::PinInit, error::Error};
+/// struct BigBuf {
+///     big: Box<[u8; 1024 * 1024 * 1024]>,
+///     small: [u8; 1024 * 1024],
+/// }
+///
+/// impl BigBuf {
+///     fn new() -> impl Init<Self, Error> {
+///         try_init!(Self {
+///             big: {
+///                 let zero =3D Box::try_new_zeroed()?;
+///                 unsafe { zero.assume_init() }
+///             },
+///             small: [0; 1024 * 1024],
+///         }? Error)
+///     }
+/// }
+/// ```
+#[macro_export]
+macro_rules! try_init {
+    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }) =3D> {
+        $crate::try_init!(
+            @this($($this)?),
+            @type_name($t),
+            @typ($t $(<$($generics),*>)?),
+            @fields($($fields)*),
+            @error($crate::error::Error),
+        )
+    };
+    ($(&$this:ident in)? $t:ident $(<$($generics:ty),* $(,)?>)? {
+        $($fields:tt)*
+    }? $err:ty) =3D> {
+        $crate::try_init!(
+            @this($($this)?),
+            @type_name($t),
+            @typ($t $(<$($generics),*>)?),
+            @fields($($fields)*),
+            @error($err),
+        )
+    };
+    (
+        @this($($this:ident)?),
+        @type_name($t:ident),
+        @typ($ty:ty),
+        @fields($($fields:tt)*),
+        @error($err:ty),
+    ) =3D> {{
+        // We do not want to allow arbitrary returns, so we declare this t=
ype as the `Ok` return
+        // type and shadow it later when we insert the arbitrary user code=
. That way there will be
+        // no possibility of returning without `unsafe`.
+        struct __InitOk;
+        let init =3D move |slot: *mut $ty| -> ::core::result::Result<__Ini=
tOk, $err> {
+            {
+                // Shadow the structure so it cannot be used to return ear=
ly.
+                struct __InitOk;
+                // Create the `this` so it can be referenced by the user i=
nside of the expressions
+                // creating the individual fields.
+                $(let $this =3D unsafe { ::core::ptr::NonNull::new_uncheck=
ed(slot) };)?
+                // Initialize every field.
+                $crate::try_init!(init_slot:
+                    @typ($ty),
+                    @slot(slot),
+                    @munch_fields($($fields)*,),
+                );
+                // We use unreachable code to ensure that all fields have =
been mentioned exactly
+                // once, this struct initializer will still be type-checke=
d and complain with a
+                // very natural error message if a field is forgotten/ment=
ioned more than once.
+                #[allow(unreachable_code, clippy::diverging_sub_expression=
)]
+                if false {
+                    $crate::try_init!(make_initializer:
+                        @typ($ty),
+                        @type_name($t),
+                        @munch_fields($($fields)*,),
+                        @acc(),
+                    );
+                }
+                // Forget all guards, since initialization was a success.
+                $crate::try_init!(forget_guards:
+                    @munch_fields($($fields)*,),
+                );
+            }
+            Ok(__InitOk)
+        };
+        let init =3D move |slot: *mut $ty| -> ::core::result::Result<(), $=
err> {
+            init(slot).map(|__InitOk| ())
+        };
+        let init =3D unsafe { $crate::init::init_from_closure::<$ty, $err>=
(init) };
+        init
+    }};
+    (init_slot:
+        @typ($ty:ty),
+        @slot($slot:ident),
+        @munch_fields( $(,)?),
+    ) =3D> {
+        // Endpoint of munching, no fields are left.
+    };
+    (init_slot:
+        @typ($ty:ty),
+        @slot($slot:ident),
+        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+    ) =3D> {
+        let $field =3D $val;
+        // Call the initializer.
+        //
+        // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
+        // return when an error/panic occurs.
+        unsafe {
+            $crate::init::Init::__init($field, ::core::ptr::addr_of_mut!((=
*$slot).$field))?;
+        }
+        // Create the drop guard.
+        //
+        // We only give access to `&DropGuard`, so it cannot be accidental=
ly forgotten.
+        //
+        // SAFETY: We forget the guard later when initialization has succe=
eded.
+        let $field =3D &unsafe {
+            $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$slot=
).$field))
+        };
+
+        $crate::try_init!(init_slot:
+            @typ($ty),
+            @slot($slot),
+            @munch_fields($($rest)*),
+        );
+    };
+    (init_slot:
+        @typ($ty:ty),
+        @slot($slot:ident),
+        // Direct value init.
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+    ) =3D> {
+        $(let $field =3D $val;)?
+        // Call the initializer.
+        //
+        // SAFETY: The memory at `slot` is uninitialized.
+        unsafe { ::core::ptr::addr_of_mut!((*$slot).$field).write($field) =
};
+        // Create the drop guard.
+        //
+        // We only give access to `&DropGuard`, so it cannot be accidental=
ly forgotten.
+        //
+        // SAFETY: We forget the guard later when initialization has succe=
eded.
+        let $field =3D &unsafe {
+            $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$slot=
).$field))
+        };
+
+        $crate::try_init!(init_slot:
+            @typ($ty),
+            @slot($slot),
+            @munch_fields($($rest)*),
+        );
+    };
+    (make_initializer:
+        @typ($ty:ty),
+        @type_name($t:ident),
+        @munch_fields( $(,)?),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        // Endpoint, nothing more to munch.
+        let _: $ty =3D $t {
+            $($acc)*
+        };
+    };
+    (make_initializer:
+        @typ($ty:ty),
+        @type_name($t:ident),
+        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        $crate::try_init!(make_initializer:
+            @typ($ty),
+            @type_name($t),
+            @munch_fields($($rest)*),
+            @acc($($acc)*$field: ::core::panic!(),),
+        );
+    };
+    (make_initializer:
+        @typ($ty:ty),
+        @type_name($t:ident),
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        $crate::try_init!(make_initializer:
+            @typ($ty),
+            @type_name($t),
+            @munch_fields($($rest)*),
+            @acc($($acc)*$field: ::core::panic!(),),
+        );
+    };
+    (forget_guards:
+        @munch_fields($(,)?),
+    ) =3D> {
+        // Munching finished.
+    };
+    (forget_guards:
+        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+    ) =3D> {
+        unsafe { $crate::init::DropGuard::forget($field) };
+
+        $crate::try_init!(forget_guards:
+            @munch_fields($($rest)*),
+        );
+    };
+    (forget_guards:
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+    ) =3D> {
+        unsafe { $crate::init::DropGuard::forget($field) };
+
+        $crate::try_init!(forget_guards:
+            @munch_fields($($rest)*),
+        );
+    };
+}
+
+/// A pinned initializer for `T`.
+///
+/// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`s=
tack_pin_init!`]). Use the
+/// [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc::pin_=
init`] on this.
+///
+/// Also see the [module description](self).
+///
+/// # Safety
+///
+/// When implementing this type you will need to take great care. Also the=
re are probably very few
+/// cases where a manual implementation is necessary. Use [`from_value`] a=
nd
+/// [`pin_init_from_closure`] where possible.
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
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`s=
tack_pin_init!`]). Use the
+/// `init` function of a smart pointer like [`Box::init`] on this. Because=
 [`PinInit<T, E>`] is a
+/// super trait, you can use every function that takes it as well.
+///
+/// Also see the [module description](self).
+///
+/// # Safety
+///
+/// When implementing this type you will need to take great care. Also the=
re are probably very few
+/// cases where a manual implementation is necessary. Use [`from_value`] a=
nd
+/// [`init_from_closure`] where possible.
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
+/// Trait facilitating pinned destruction.
+///
+/// Use [`pinned_drop`] to implement this trait safely:
+///
+/// ```rust
+/// # use kernel::sync::Mutex;
+/// use kernel::macros::pinned_drop;
+/// use core::pin::Pin;
+/// #[pin_data(PinnedDrop)]
+/// struct Foo {
+///     #[pin]
+///     mtx: Mutex<usize>,
+/// }
+///
+/// #[pinned_drop]
+/// impl PinnedDrop for Foo {
+///     fn drop(self: Pin<&mut Self>) {
+///         pr_info!("Foo is being dropped!");
+///     }
+/// }
+/// ```
+///
+/// # Safety
+///
+/// This trait must be implemented via the [`pinned_drop`] proc-macro attr=
ibute on the impl.
+///
+/// [`pinned_drop`]: kernel::macros::pinned_drop
+pub unsafe trait PinnedDrop: __PinData {
+    /// Executes the pinned destructor of this type.
+    ///
+    /// While this function is marked safe, it is actually unsafe to call =
it manually. For this
+    /// reason it takes an additional parameter. This type can only be con=
structed by `unsafe` code
+    /// and thus prevents this function from being called where it should =
not.
+    ///
+    /// This extra parameter will be generated by the `#[pinned_drop]` pro=
c-macro attribute
+    /// automatically.
+    fn drop(self: Pin<&mut Self>, only_call_from_drop: OnlyCallFromDrop);
+}
+
+// We need one private field, because otherwise it can be constructed.
+#[doc(hidden)]
+pub struct OnlyCallFromDrop(());
+
+impl OnlyCallFromDrop {
+    /// # Safety
+    ///
+    /// This function should only be called from the [`Drop::drop`] functi=
on and only be used to
+    /// delegate the destruction to the pinned destructor [`PinnedDrop::dr=
op`] of the same type.
+    #[doc(hidden)]
+    pub unsafe fn create() -> Self {
+        Self(())
+    }
+}
+
+/// Smart pointer that can initialize memory in-place.
+pub trait InPlaceInit<T>: Sized {
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
+    where
+        Error: From<E>;
+
+    /// Use the given initializer to in-place initialize a `T`.
+    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
+    where
+        Error: From<E>;
+}
+
+impl<T> InPlaceInit<T> for Box<T> {
+    #[inline]
+    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
+    where
+        Error: From<E>,
+    {
+        let mut this =3D Box::try_new_uninit()?;
+        let slot =3D this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved because of the `Pin::new_un=
checked`
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { Pin::new_unchecked(this.assume_init()) })
+    }
+
+    #[inline]
+    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
+    where
+        Error: From<E>,
+    {
+        let mut this =3D Box::try_new_uninit()?;
+        let slot =3D this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() })
+    }
+}
+
+impl<T> InPlaceInit<T> for UniqueArc<T> {
+    #[inline]
+    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
+    where
+        Error: From<E>,
+    {
+        let mut this =3D UniqueArc::try_new_uninit()?;
+        let slot =3D this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved because of the `Pin::new_un=
checked`.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { Pin::new_unchecked(this.assume_init()) })
+    }
+
+    #[inline]
+    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
+    where
+        Error: From<E>,
+    {
+        let mut this =3D UniqueArc::try_new_uninit()?;
+        let slot =3D this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() })
+    }
+}
+
+/// Marker trait for types that can be initialized by writing just zeroes.
+///
+/// # Safety
+///
+/// The bit pattern consisting of only zeroes is a valid bit pattern for t=
his type. In other words,
+/// this is not UB:
+///
+/// ```rust,ignore
+/// let val: Self =3D unsafe { core::mem::zeroed() };
+/// ```
+pub unsafe trait Zeroable {}
+
+/// Create a new zeroed T.
+///
+/// The returned initializer will write `0x00` to every byte of the given =
`slot`.
+#[inline]
+pub fn zeroed<T: Zeroable + Unpin>() -> impl Init<T> {
+    // SAFETY: Because `T: Zeroable`, all bytes zero is a valid bit patter=
n for `T`
+    // and because we write all zeroes, the memory is initialized.
+    unsafe {
+        init_from_closure(|slot: *mut T| {
+            slot.write_bytes(0, 1);
+            Ok(())
+        })
+    }
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
+/// Convert a value into an initializer.
+///
+/// Directly moves the value into the given `slot`.
+///
+/// Note that you can just write `field: value,` in all initializer macros=
. This function's purpose
+/// is to provide compatibility with APIs that only have `PinInit`/`Init` =
as parameters.
+#[inline]
+pub fn from_value<T>(value: T) -> impl Init<T> {
+    // SAFETY: We use the value to initialize the slot.
+    unsafe {
+        init_from_closure(move |slot: *mut T| {
+            slot.write(value);
+            Ok(())
+        })
+    }
+}
+
+unsafe impl<T> PinInit<T> for T {
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), Infallible> =
{
+        unsafe { slot.write(self) };
+        Ok(())
+    }
+}
+
+unsafe impl<T> Init<T> for T {
+    unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {
+        unsafe { slot.write(self) };
+        Ok(())
+    }
+}
+
+macro_rules! impl_zeroable {
+    ($($t:ty, )*) =3D> {
+        $(unsafe impl Zeroable for $t {})*
+    };
+}
+impl_zeroable! {
+    // SAFETY: All primitives that are allowed to be zero.
+    bool,
+    char,
+    u8, u16, u32, u64, u128, usize,
+    i8, i16, i32, i64, i128, isize,
+    f32, f64,
+    // SAFETY: There is nothing to zero.
+    core::marker::PhantomPinned, Infallible, (),
+}
+
+// SAFETY: We are allowed to zero padding bytes.
+unsafe impl<const N: usize, T: Zeroable> Zeroable for [T; N] {}
+
+// SAFETY: There is nothing to zero.
+unsafe impl<T: ?Sized> Zeroable for PhantomData<T> {}
+
+// SAFETY: `null` pointer is valid.
+unsafe impl<T: ?Sized> Zeroable for *mut T {}
+unsafe impl<T: ?Sized> Zeroable for *const T {}
+
+macro_rules! impl_tuple_zeroable {
+    ($(,)?) =3D> {};
+    ($first:ident, $($t:ident),* $(,)?) =3D> {
+        // SAFETY: All elements are zeroable and padding can be zero.
+        unsafe impl<$first: Zeroable, $($t: Zeroable),*> Zeroable for ($fi=
rst, $($t),*) {}
+        impl_tuple_zeroable!($($t),* ,);
+    }
+}
+
+impl_tuple_zeroable!(A, B, C, D, E, F, G, H, I, J);
+
+// This trait is only implemented via the `#[pin_data]` proc-macro. It is =
used to facilitate
+// the pin projections within the initializers.
+#[doc(hidden)]
+pub unsafe trait __PinData {
+    type __PinData;
+}
+
+/// Stack initializer helper type. Use [`stack_pin_init`] instead of this =
primitive.
+///
+/// # Invariants
+///
+/// If `self.1` is true, then `self.0` is initialized.
+///
+/// [`stack_pin_init`]: kernel::stack_pin_init
+#[doc(hidden)]
+pub struct StackInit<T>(MaybeUninit<T>, bool);
+
+impl<T> Drop for StackInit<T> {
+    #[inline]
+    fn drop(&mut self) {
+        if self.1 {
+            // SAFETY: As we are being dropped, we only call this once. An=
d since `self.1 =3D=3D true`,
+            // `self.0` has to be initialized.
+            unsafe { self.0.assume_init_drop() };
+        }
+    }
+}
+
+impl<T> StackInit<T> {
+    /// Creates a new [`StackInit<T>`] that is uninitialized. Use [`stack_=
pin_init`] instead of this
+    /// primitive.
+    ///
+    /// [`stack_pin_init`]: kernel::stack_pin_init
+    #[inline]
+    pub fn uninit() -> Self {
+        Self(MaybeUninit::uninit(), false)
+    }
+
+    /// Initializes the contents and returns the result.
+    ///
+    /// # Safety
+    ///
+    /// The caller ensures that `self` is on the stack and not accessible =
in any other way, if this
+    /// function returns `Ok`.
+    #[inline]
+    pub unsafe fn init<E>(&mut self, init: impl PinInit<T, E>) -> Result<P=
in<&mut T>, E> {
+        // SAFETY: The memory slot is valid and this type ensures that it =
will stay pinned.
+        unsafe { init.__pinned_init(self.0.as_mut_ptr())? };
+        self.1 =3D true;
+        // SAFETY: The slot is now pinned, since we will never give access=
 to `&mut T`.
+        Ok(unsafe { Pin::new_unchecked(self.0.assume_init_mut()) })
+    }
+}
+
+/// When a value of this type is dropped, it drops a `T`.
+///
+/// Public, but hidden type, since it should only be used by the macros of=
 this module.
+#[doc(hidden)]
+pub struct DropGuard<T: ?Sized>(*mut T, Cell<bool>);
+
+impl<T: ?Sized> DropGuard<T> {
+    /// Creates a new [`DropGuard<T>`]. It will [`ptr::drop_in_place`] `pt=
r` when it gets dropped.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer.
+    ///
+    /// It is the callers responsibility that `self` will only get dropped=
 if the pointee of `ptr`:
+    /// - has not been dropped,
+    /// - is not accessible by any other means,
+    /// - will not be dropped by any other means.
+    #[inline]
+    pub unsafe fn new(ptr: *mut T) -> Self {
+        Self(ptr, Cell::new(true))
+    }
+
+    /// Prevents this guard from dropping the supplied pointer.
+    ///
+    /// # Safety
+    ///
+    /// This function is unsafe in order to prevent safe code from forgett=
ing this guard. It should
+    /// only be called by the macros in this module.
+    #[inline]
+    pub unsafe fn forget(&self) {
+        self.1.set(false);
+    }
+}
+
+impl<T: ?Sized> Drop for DropGuard<T> {
+    #[inline]
+    fn drop(&mut self) {
+        if self.1.get() {
+            // SAFETY: A `DropGuard` can only be constructed using the uns=
afe `new` function
+            // ensuring that this operation is safe.
+            unsafe { ptr::drop_in_place(self.0) }
+        }
+    }
+}
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
new file mode 100644
index 000000000000..aec03f0b0897
--- /dev/null
+++ b/rust/kernel/init/macros.rs
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! This module provides the macros that actually implement the proc-macro=
s `pin_data` and
+//! `pinned_drop`. These macros should never be called directly, since the=
y expect their input to be
+//! in a certain format which is internal. Use the proc-macros instead.
+//!
+//! This architecture has been chosen because the kernel does not yet have=
 access to `syn` which
+//! would make matters a lot easier for implementing these as proc-macros.
+
+/// This macro creates a `unsafe impl<...> PinnedDrop for $type` block.
+///
+/// See [`PinnedDrop`] for more information.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! __pinned_drop {
+    (
+        @impl_sig($($impl_sig:tt)*),
+        @impl_body(
+            $(#[$($attr:tt)*])*
+            fn drop($self:ident: $st:ty) {
+                $($inner:stmt)*
+            }
+        ),
+    ) =3D> {
+        unsafe $($impl_sig)* {
+            // Inherit all attributes and the type/ident tokens for the si=
gnature.
+            $(#[$($attr)*])*
+            fn drop($self: $st, _: $crate::init::OnlyCallFromDrop) {
+                $($inner)*
+            }
+        }
+    }
+}
+
+/// This macro first parses the struct definition such that it separates p=
inned and not pinned
+/// fields. Afterwards it declares the struct and implement the `__PinData=
` trait safely.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! __pin_data {
+    // Proc-macro entry point, this is supplied by the proc-macro pre-pars=
ing.
+    (parse_input:
+        @args($($pinned_drop:ident)?),
+        @sig(
+            $(#[$($struct_attr:tt)*])*
+            $vis:vis struct $name:ident
+            $(where $($whr:tt)*)?
+        ),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @body({ $($fields:tt)* }),
+    ) =3D> {
+        // We now use token munching to iterate through all of the fields.=
 While doing this we
+        // identify fields marked with `#[pin]`, these fields are the 'pin=
ned fields'. The user
+        // wants these to be structurally pinned. The rest of the fields a=
re the
+        // 'not pinned fields'. Additionally we collect all fields, since =
we need them in the right
+        // order to declare the struct.
+        //
+        // In this call we also put some explaining comments for the param=
eters.
+        $crate::__pin_data!(find_pinned_fields:
+            // Attributes on the struct itself, these will just be propaga=
ted to be put onto the
+            // struct definition.
+            @struct_attrs($(#[$($struct_attr)*])*),
+            // The visibility of the struct.
+            @vis($vis),
+            // The name of the struct.
+            @name($name),
+            // The 'impl generics', the generics that will need to be spec=
ified on the struct inside
+            // of an `impl<$ty_generics>` block.
+            @impl_generics($($impl_generics)*),
+            // The 'ty generics', the generics that will need to be specif=
ied on the impl blocks.
+            @ty_generics($($ty_generics)*),
+            // The where clause of any impl block and the declaration.
+            @where($($($whr)*)?),
+            // The remaining fields tokens that need to be processed.
+            // We add a `,` at the end to ensure correct parsing.
+            @fields_munch($($fields)* ,),
+            // The pinned fields.
+            @pinned(),
+            // The not pinned fields.
+            @not_pinned(),
+            // All fields.
+            @fields(),
+            // The accumulator containing all attributes already parsed.
+            @accum(),
+            // Contains `yes` or `` to indicate if `#[pin]` was found on t=
he current field.
+            @is_pinned(),
+            // The proc-macro argument, this should be `PinnedDrop` or ``.
+            @pinned_drop($($pinned_drop)?),
+        );
+    };
+    (find_pinned_fields:
+        @struct_attrs($($struct_attrs:tt)*),
+        @vis($vis:vis),
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        // We found a PhantomPinned field, this should generally be pinned=
!
+        @fields_munch($field:ident : $($($(::)?core::)?marker::)?PhantomPi=
nned, $($rest:tt)*),
+        @pinned($($pinned:tt)*),
+        @not_pinned($($not_pinned:tt)*),
+        @fields($($fields:tt)*),
+        @accum($($accum:tt)*),
+        // This field is not pinned.
+        @is_pinned(),
+        @pinned_drop($($pinned_drop:ident)?),
+    ) =3D> {
+        ::core::compile_error!(concat!(
+            "The field `",
+            stringify!($field),
+            "` of type `PhantomPinned` only has an effect, if it has the `=
#[pin]` attribute.",
+        ));
+        $crate::__pin_data!(find_pinned_fields:
+            @struct_attrs($($struct_attrs)*),
+            @vis($vis),
+            @name($name),
+            @impl_generics($($impl_generics)*),
+            @ty_generics($($ty_generics)*),
+            @where($($whr)*),
+            @fields_munch($($rest)*),
+            @pinned($($pinned)* $($accum)* $field: ::core::marker::Phantom=
Pinned,),
+            @not_pinned($($not_pinned)*),
+            @fields($($fields)* $($accum)* $field: ::core::marker::Phantom=
Pinned,),
+            @accum(),
+            @is_pinned(),
+            @pinned_drop($($pinned_drop)?),
+        );
+    };
+    (find_pinned_fields:
+        @struct_attrs($($struct_attrs:tt)*),
+        @vis($vis:vis),
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        // We reached the field declaration.
+        @fields_munch($field:ident : $type:ty, $($rest:tt)*),
+        @pinned($($pinned:tt)*),
+        @not_pinned($($not_pinned:tt)*),
+        @fields($($fields:tt)*),
+        @accum($($accum:tt)*),
+        // This field is pinned.
+        @is_pinned(yes),
+        @pinned_drop($($pinned_drop:ident)?),
+    ) =3D> {
+        $crate::__pin_data!(find_pinned_fields:
+            @struct_attrs($($struct_attrs)*),
+            @vis($vis),
+            @name($name),
+            @impl_generics($($impl_generics)*),
+            @ty_generics($($ty_generics)*),
+            @where($($whr)*),
+            @fields_munch($($rest)*),
+            @pinned($($pinned)* $($accum)* $field: $type,),
+            @not_pinned($($not_pinned)*),
+            @fields($($fields)* $($accum)* $field: $type,),
+            @accum(),
+            @is_pinned(),
+            @pinned_drop($($pinned_drop)?),
+        );
+    };
+    (find_pinned_fields:
+        @struct_attrs($($struct_attrs:tt)*),
+        @vis($vis:vis),
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        // We reached the field declaration.
+        @fields_munch($field:ident : $type:ty, $($rest:tt)*),
+        @pinned($($pinned:tt)*),
+        @not_pinned($($not_pinned:tt)*),
+        @fields($($fields:tt)*),
+        @accum($($accum:tt)*),
+        // This field is not pinned.
+        @is_pinned(),
+        @pinned_drop($($pinned_drop:ident)?),
+    ) =3D> {
+        $crate::__pin_data!(find_pinned_fields:
+            @struct_attrs($($struct_attrs)*),
+            @vis($vis),
+            @name($name),
+            @impl_generics($($impl_generics)*),
+            @ty_generics($($ty_generics)*),
+            @where($($whr)*),
+            @fields_munch($($rest)*),
+            @pinned($($pinned)*),
+            @not_pinned($($not_pinned)* $($accum)* $field: $type,),
+            @fields($($fields)* $($accum)* $field: $type,),
+            @accum(),
+            @is_pinned(),
+            @pinned_drop($($pinned_drop)?),
+        );
+    };
+    (find_pinned_fields:
+        @struct_attrs($($struct_attrs:tt)*),
+        @vis($vis:vis),
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        // We found the `#[pin]` attr.
+        @fields_munch(#[pin] $($rest:tt)*),
+        @pinned($($pinned:tt)*),
+        @not_pinned($($not_pinned:tt)*),
+        @fields($($fields:tt)*),
+        @accum($($accum:tt)*),
+        @is_pinned($($is_pinned:ident)?),
+        @pinned_drop($($pinned_drop:ident)?),
+    ) =3D> {
+        $crate::__pin_data!(find_pinned_fields:
+            @struct_attrs($($struct_attrs)*),
+            @vis($vis),
+            @name($name),
+            @impl_generics($($impl_generics)*),
+            @ty_generics($($ty_generics)*),
+            @where($($whr)*),
+            @fields_munch($($rest)*),
+            // We do not include `#[pin]` in the list of attributes, since=
 it is not actually an
+            // attribute that is defined somewhere.
+            @pinned($($pinned)*),
+            @not_pinned($($not_pinned)*),
+            @fields($($fields)*),
+            @accum($($accum)*),
+            // Set this to `yes`.
+            @is_pinned(yes),
+            @pinned_drop($($pinned_drop)?),
+        );
+    };
+    (find_pinned_fields:
+        @struct_attrs($($struct_attrs:tt)*),
+        @vis($vis:vis),
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        // We reached the field declaration with visibility, for simplicit=
y we only munch the
+        // visibility and put it into `$accum`.
+        @fields_munch($fvis:vis $field:ident $($rest:tt)*),
+        @pinned($($pinned:tt)*),
+        @not_pinned($($not_pinned:tt)*),
+        @fields($($fields:tt)*),
+        @accum($($accum:tt)*),
+        @is_pinned($($is_pinned:ident)?),
+        @pinned_drop($($pinned_drop:ident)?),
+    ) =3D> {
+        $crate::__pin_data!(find_pinned_fields:
+            @struct_attrs($($struct_attrs)*),
+            @vis($vis),
+            @name($name),
+            @impl_generics($($impl_generics)*),
+            @ty_generics($($ty_generics)*),
+            @where($($whr)*),
+            @fields_munch($field $($rest)*),
+            @pinned($($pinned)*),
+            @not_pinned($($not_pinned)*),
+            @fields($($fields)*),
+            @accum($($accum)* $fvis),
+            @is_pinned($($is_pinned)?),
+            @pinned_drop($($pinned_drop)?),
+        );
+    };
+    (find_pinned_fields:
+        @struct_attrs($($struct_attrs:tt)*),
+        @vis($vis:vis),
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        // Some other attribute, just put it into `$accum`.
+        @fields_munch(#[$($attr:tt)*] $($rest:tt)*),
+        @pinned($($pinned:tt)*),
+        @not_pinned($($not_pinned:tt)*),
+        @fields($($fields:tt)*),
+        @accum($($accum:tt)*),
+        @is_pinned($($is_pinned:ident)?),
+        @pinned_drop($($pinned_drop:ident)?),
+    ) =3D> {
+        $crate::__pin_data!(find_pinned_fields:
+            @struct_attrs($($struct_attrs)*),
+            @vis($vis),
+            @name($name),
+            @impl_generics($($impl_generics)*),
+            @ty_generics($($ty_generics)*),
+            @where($($whr)*),
+            @fields_munch($($rest)*),
+            @pinned($($pinned)*),
+            @not_pinned($($not_pinned)*),
+            @fields($($fields)*),
+            @accum($($accum)* #[$($attr)*]),
+            @is_pinned($($is_pinned)?),
+            @pinned_drop($($pinned_drop)?),
+        );
+    };
+    (find_pinned_fields:
+        @struct_attrs($($struct_attrs:tt)*),
+        @vis($vis:vis),
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        // We reached the end of the fields, plus an optional additional c=
omma, since we added one
+        // before and the user is also allowed to put a trailing comma.
+        @fields_munch($(,)?),
+        @pinned($($pinned:tt)*),
+        @not_pinned($($not_pinned:tt)*),
+        @fields($($fields:tt)*),
+        @accum(),
+        @is_pinned(),
+        @pinned_drop($($pinned_drop:ident)?),
+    ) =3D> {
+        // Declare the struct with all fields in the correct order.
+        $($struct_attrs)*
+        $vis struct $name <$($impl_generics)*>
+        where $($whr)*
+        {
+            $($fields)*
+        }
+
+        // We put the rest into this const item, because it then will not =
be accessible to anything
+        // outside.
+        const _: () =3D {
+            // We declare this struct which will host all of the projectio=
n function for our type.
+            // it will be invariant over all generic parameters which are =
inherited from the
+            // struct.
+            $vis struct __ThePinData<$($impl_generics)*>
+            where $($whr)*
+            {
+                __phantom: ::core::marker::PhantomData<
+                    fn($name<$($ty_generics)*>) -> $name<$($ty_generics)*>
+                >,
+            }
+
+            // Make all projection functions.
+            $crate::__pin_data!(make_pin_data:
+                @pin_data(__ThePinData),
+                @impl_generics($($impl_generics)*),
+                @ty_generics($($ty_generics)*),
+                @where($($whr)*),
+                @pinned($($pinned)*),
+                @not_pinned($($not_pinned)*),
+            );
+
+            // SAFETY: We have added the correct projection functions abov=
e to `__ThePinData` and
+            // we also use the least restrictive generics possible.
+            unsafe impl<$($impl_generics)*> $crate::init::__PinData for $n=
ame<$($ty_generics)*>
+            where $($whr)*
+            {
+                type __PinData =3D __ThePinData<$($ty_generics)*>;
+            }
+
+            // This struct will be used for the unpin analysis. Since only=
 structurally pinned
+            // fields are relevant whether the struct should implement `Un=
pin`.
+            #[allow(dead_code)]
+            struct __Unpin <'__pin, $($impl_generics)*>
+            where $($whr)*
+            {
+                __phantom_pin: ::core::marker::PhantomData<fn(&'__pin ()) =
-> &'__pin ()>,
+                __phantom: ::core::marker::PhantomData<
+                    fn($name<$($ty_generics)*>) -> $name<$($ty_generics)*>
+                >,
+                // Only the pinned fields.
+                $($pinned)*
+            }
+
+            #[doc(hidden)]
+            impl<'__pin, $($impl_generics)*> ::core::marker::Unpin for $na=
me<$($ty_generics)*>
+            where
+                __Unpin<'__pin, $($ty_generics)*>: ::core::marker::Unpin,
+                $($whr)*
+            {}
+
+            // We need to disallow normal `Drop` implementation, the exact=
 behavior depends on
+            // whether `PinnedDrop` was specified as the parameter.
+            $crate::__pin_data!(drop_prevention:
+                @name($name),
+                @impl_generics($($impl_generics)*),
+                @ty_generics($($ty_generics)*),
+                @where($($whr)*),
+                @pinned_drop($($pinned_drop)?),
+            );
+        };
+    };
+    // When no `PinnedDrop` was specified, then we have to prevent impleme=
nting drop.
+    (drop_prevention:
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        @pinned_drop(),
+    ) =3D> {
+        // We prevent this by creating a trait that will be implemented fo=
r all types implementing
+        // `Drop`. Additionally we will implement this trait for the struc=
t leading to a conflict,
+        // if it also implements `Drop`
+        trait MustNotImplDrop {}
+        #[allow(drop_bounds)]
+        impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
+        impl<$($impl_generics)*> MustNotImplDrop for $name<$($ty_generics)=
*>
+        where $($whr)* {}
+        // We also take care to prevent users from writing a useless Pinne=
dDrop implementation.
+        // They might implement PinnedDrop correctly for the struct, but f=
orget to give
+        // `PinnedDrop` as the parameter to `#[pin_data]`.
+        #[allow(non_camel_case_types)]
+        trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
+        impl<T: $crate::init::PinnedDrop>
+            UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T {}
+        impl<$($impl_generics)*>
+            UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for $name=
<$($ty_generics)*>
+        where $($whr)* {}
+    };
+    // When `PinnedDrop` was specified we just implement drop and delegate=
.
+    (drop_prevention:
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        @pinned_drop(PinnedDrop),
+    ) =3D> {
+        impl<$($impl_generics)*> ::core::ops::Drop for $name<$($ty_generic=
s)*>
+        where $($whr)*
+        {
+            fn drop(&mut self) {
+                // SAFETY: since this is a destructor, `self` will not mov=
e after this function
+                // terminates, since it is inaccessible.
+                let pinned =3D unsafe { ::core::pin::Pin::new_unchecked(se=
lf) };
+                // SAFETY: since this is a drop function, we can create th=
is token to call the
+                // pinned destructor of this type.
+                let token =3D unsafe { $crate::init::OnlyCallFromDrop::cre=
ate() };
+                $crate::init::PinnedDrop::drop(pinned, token);
+            }
+        }
+    };
+    // If some other parameter was specified, we emit a readable error.
+    (drop_prevention:
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        @pinned_drop($($rest:tt)*),
+    ) =3D> {
+        compile_error!(
+            "Wrong parameters to `#[pin_data]`, expected nothing or `Pinne=
dDrop`, got '{}'.",
+            stringify!($($rest)*),
+        );
+    };
+    (make_pin_data:
+        @pin_data($pin_data:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @where($($whr:tt)*),
+        @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $p_type=
:ty),* $(,)?),
+        @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $type:t=
y),* $(,)?),
+    ) =3D> {
+        // For every field, we create a projection function according to i=
ts projection type. If a
+        // field is structurally pinned, then it must be initialized via `=
PinInit`, if it is not
+        // structurally pinned, then it can be initialized via `Init`.
+        //
+        // The functions are `unsafe` to prevent accidentally calling them=
.
+        #[allow(dead_code)]
+        impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
+        where $($whr)*
+        {
+            $(
+                $pvis unsafe fn $p_field<E>(
+                    slot: *mut $p_type,
+                    init: impl $crate::init::PinInit<$p_type, E>,
+                ) -> ::core::result::Result<(), E> {
+                    unsafe { $crate::init::PinInit::__pinned_init(init, sl=
ot) }
+                }
+            )*
+            $(
+                $fvis unsafe fn $field<E>(
+                    slot: *mut $type,
+                    init: impl $crate::init::Init<$type, E>,
+                ) -> ::core::result::Result<(), E> {
+                    unsafe { $crate::init::Init::__init(init, slot) }
+                }
+            )*
+        }
+    };
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
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 0bc1c97e5604..fcdc511d2ce8 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -18,7 +18,7 @@ pub use core::pin::Pin;
 pub use alloc::{boxed::Box, vec::Vec};

 #[doc(no_inline)]
-pub use macros::{module, vtable};
+pub use macros::{module, pin_data, pinned_drop, vtable};

 pub use super::build_assert;

@@ -27,8 +27,12 @@ pub use super::build_assert;
 pub use super::dbg;
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr=
_notice, pr_warn};

+pub use super::{init, pin_init, try_init, try_pin_init};
+
 pub use super::static_assert;

 pub use super::error::{code::*, Error, Result};

 pub use super::{str::CStr, ThisModule};
+
+pub use super::init::{InPlaceInit, Init, PinInit};
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 16ec174637b2..5b4f64dd3ac8 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -17,7 +17,8 @@

 use crate::{
     bindings,
-    error::Result,
+    error::{Error, Result},
+    init::{InPlaceInit, Init, PinInit},
     types::{ForeignOwnable, Opaque},
 };
 use alloc::boxed::Box;
@@ -163,6 +164,28 @@ impl<T> Arc<T> {
         // `Arc` object.
         Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
     }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    #[inline]
+    pub fn pin_init<E>(init: impl PinInit<T, E>) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        UniqueArc::pin_init(init).map(|u| u.into())
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// This is equivalent to [`pin_init`], since an `Arc` is always pinne=
d.
+    #[inline]
+    pub fn init<E>(init: impl Init<T, E>) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        UniqueArc::init(init).map(|u| u.into())
+    }
 }

 impl<T: ?Sized> Arc<T> {
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9d0fdbc55843..ff2b2fac951d 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -238,6 +238,14 @@ impl<T> Opaque<T> {
     pub fn get(&self) -> *mut T {
         UnsafeCell::raw_get(self.0.as_ptr())
     }
+
+    /// Gets the value behind `this`.
+    ///
+    /// This function is useful to get access to the value without creatin=
g intermediate
+    /// references.
+    pub const fn raw_get(this: *const Self) -> *mut T {
+        UnsafeCell::raw_get(this.cast::<UnsafeCell<T>>())
+    }
 }

 /// A sum type that always holds either a value of type `L` or `R`.
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 82b520f024dd..5afd88cfe124 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -7,6 +7,8 @@ mod quote;
 mod concat_idents;
 mod helpers;
 mod module;
+mod pin_data;
+mod pinned_drop;
 mod vtable;

 use proc_macro::TokenStream;
@@ -168,3 +170,79 @@ pub fn vtable(attr: TokenStream, ts: TokenStream) -> T=
okenStream {
 pub fn concat_idents(ts: TokenStream) -> TokenStream {
     concat_idents::concat_idents(ts)
 }
+
+/// Used to specify the pinning information of the fields of a struct.
+///
+/// This is somewhat similar in purpose as
+/// [pin-project-lite](https://crates.io/crates/pin-project-lite).
+/// Place this macro on a struct definition and then `#[pin]` in front of =
the attributes of each
+/// field you want to structurally pin.
+///
+/// This macro enables the use of the [`pin_init!`] macro. When pinned-ini=
tializing a `struct`,
+/// then `#[pin]` directs the type of intializer that is required.
+///
+/// If your `struct` implements `Drop`, then you need to add `PinnedDrop` =
as arguments to this
+/// macro, and change your `Drop` implementation to `PinnedDrop` annotated=
 with
+/// `#[`[`macro@pinned_drop`]`]`, since dropping pinned values requires ex=
tra care.
+///
+/// # Examples
+///
+/// ```rust,ignore
+/// #[pin_data]
+/// struct DriverData {
+///     #[pin]
+///     queue: Mutex<Vec<Command>>,
+///     buf: Box<[u8; 1024 * 1024]>,
+/// }
+/// ```
+///
+/// ```rust,ignore
+/// #[pin_data(PinnedDrop)]
+/// struct DriverData {
+///     #[pin]
+///     queue: Mutex<Vec<Command>>,
+///     buf: Box<[u8; 1024 * 1024]>,
+///     raw_info: *mut Info,
+/// }
+///
+/// #[pinned_drop]
+/// impl PinnedDrop for DriverData {
+///     fn drop(self: Pin<&mut Self>) {
+///         unsafe { bindings::destroy_info(self.raw_info) };
+///     }
+/// }
+/// ```
+///
+/// [`pin_init!`]: ../kernel/macro.pin_init.html
+//  ^ cannot use direct link, since `kernel` is not a dependency of `macro=
s`
+#[proc_macro_attribute]
+pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
+    pin_data::pin_data(inner, item)
+}
+
+/// Used to implement `PinnedDrop` safely.
+///
+/// Only works on structs that are annotated via `#[`[`macro@pin_data`]`]`=
.
+///
+/// # Examples
+///
+/// ```rust,ignore
+/// #[pin_data(PinnedDrop)]
+/// struct DriverData {
+///     #[pin]
+///     queue: Mutex<Vec<Command>>,
+///     buf: Box<[u8; 1024 * 1024]>,
+///     raw_info: *mut Info,
+/// }
+///
+/// #[pinned_drop]
+/// impl PinnedDrop for DriverData {
+///     fn drop(self: Pin<&mut Self>) {
+///         unsafe { bindings::destroy_info(self.raw_info) };
+///     }
+/// }
+/// ```
+#[proc_macro_attribute]
+pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
+    pinned_drop::pinned_drop(args, input)
+}
diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
new file mode 100644
index 000000000000..973053a0b539
--- /dev/null
+++ b/rust/macros/pin_data.rs
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use proc_macro::{Punct, Spacing, TokenStream, TokenTree};
+
+pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStre=
am {
+    // This proc-macro only does some pre-parsing and then delegates the a=
ctual parsing to
+    // `kernel::_pin_data!`.
+    //
+    // In here we only collect the generics, since parsing them in declara=
tive macros is very
+    // elaborate. We also do not need to analyse their structure, we only =
need to collect them.
+
+    // `impl_generics`, the declared generics with their bounds.
+    let mut impl_generics =3D vec![];
+    // Only the names of the generics, without any bounds.
+    let mut ty_generics =3D vec![];
+    // Tokens not related to the generics e.g. the `impl` token.
+    let mut rest =3D vec![];
+    // The current level of `<`.
+    let mut nesting =3D 0;
+    let mut toks =3D input.into_iter();
+    // if we are at the beginning of a generic parameter
+    let mut at_start =3D true;
+    for tt in &mut toks {
+        match tt.clone() {
+            TokenTree::Punct(p) if p.as_char() =3D=3D '<' =3D> {
+                if nesting >=3D 1 {
+                    impl_generics.push(tt);
+                }
+                nesting +=3D 1;
+            }
+            TokenTree::Punct(p) if p.as_char() =3D=3D '>' =3D> {
+                if nesting =3D=3D 0 {
+                    break;
+                } else {
+                    nesting -=3D 1;
+                    if nesting >=3D 1 {
+                        impl_generics.push(tt);
+                    }
+                    if nesting =3D=3D 0 {
+                        break;
+                    }
+                }
+            }
+            tt =3D> {
+                if nesting =3D=3D 1 {
+                    match &tt {
+                        TokenTree::Ident(i) if i.to_string() =3D=3D "const=
" =3D> {}
+                        TokenTree::Ident(_) if at_start =3D> {
+                            ty_generics.push(tt.clone());
+                            ty_generics.push(TokenTree::Punct(Punct::new('=
,', Spacing::Alone)));
+                            at_start =3D false;
+                        }
+                        TokenTree::Punct(p) if p.as_char() =3D=3D ',' =3D>=
 at_start =3D true,
+                        TokenTree::Punct(p) if p.as_char() =3D=3D '\'' && =
at_start =3D> {
+                            ty_generics.push(tt.clone());
+                        }
+                        _ =3D> {}
+                    }
+                }
+                if nesting >=3D 1 {
+                    impl_generics.push(tt);
+                } else if nesting =3D=3D 0 {
+                    rest.push(tt);
+                }
+            }
+        }
+    }
+    rest.extend(toks);
+    // This should be the body of the struct `{...}`.
+    let last =3D rest.pop();
+    quote!(::kernel::__pin_data! {
+        parse_input:
+        @args(#args),
+        @sig(#(#rest)*),
+        @impl_generics(#(#impl_generics)*),
+        @ty_generics(#(#ty_generics)*),
+        @body(#last),
+    })
+}
diff --git a/rust/macros/pinned_drop.rs b/rust/macros/pinned_drop.rs
new file mode 100644
index 000000000000..88fb72b20660
--- /dev/null
+++ b/rust/macros/pinned_drop.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use proc_macro::{TokenStream, TokenTree};
+
+pub(crate) fn pinned_drop(_args: TokenStream, input: TokenStream) -> Token=
Stream {
+    let mut toks =3D input.into_iter().collect::<Vec<_>>();
+    assert!(!toks.is_empty());
+    // Ensure that we have an `impl` item.
+    assert!(matches!(&toks[0], TokenTree::Ident(i) if i.to_string() =3D=3D=
 "impl"));
+    // Ensure that we are implementing `PinnedDrop`.
+    let mut nesting: usize =3D 0;
+    let mut pinned_drop_idx =3D None;
+    for (i, tt) in toks.iter().enumerate() {
+        match tt {
+            TokenTree::Punct(p) if p.as_char() =3D=3D '<' =3D> {
+                nesting +=3D 1;
+            }
+            TokenTree::Punct(p) if p.as_char() =3D=3D '>' =3D> {
+                nesting =3D nesting.checked_sub(1).unwrap();
+                continue;
+            }
+            _ =3D> {}
+        }
+        if i >=3D 1 && nesting =3D=3D 0 {
+            // Found the end of the generics, this should be `PinnedDrop`.
+            assert!(
+                matches!(tt, TokenTree::Ident(i) if i.to_string() =3D=3D "=
PinnedDrop"),
+                "expected 'PinnedDrop', found: '{:?}'",
+                tt
+            );
+            pinned_drop_idx =3D Some(i);
+            break;
+        }
+    }
+    let idx =3D pinned_drop_idx
+        .unwrap_or_else(|| panic!("Expected an `impl` block implementing `=
PinnedDrop`."));
+    // Fully qualify the `PinnedDrop`, as to avoid any tampering.
+    toks.splice(idx..idx, quote!(::kernel::init::));
+    // Take the `{}` body and call the declarative macro.
+    if let Some(TokenTree::Group(last)) =3D toks.pop() {
+        let last =3D last.stream();
+        quote!(::kernel::__pinned_drop! {
+            @impl_sig(#(#toks)*),
+            @impl_body(#last),
+        })
+    } else {
+        TokenStream::from_iter(toks)
+    }
+}
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


