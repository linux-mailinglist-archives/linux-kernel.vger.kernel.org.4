Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4806D2A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjCaVz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjCaVzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:55:13 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2146265AB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:54:17 -0700 (PDT)
Date:   Fri, 31 Mar 2023 21:53:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680299627; x=1680558827;
        bh=wWMSdMXkhquoaO8JuT4ULTJBxQfocMe/i+cefmRTwNo=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=DLWY1cUAYrYeRSDxwzBcd8T3SkLcYBMF/6mt3iGYecHC5+Tk1egjcvR4u3m62L25E
         y1ytgOIY7Ynx5RFVR8/bMaddCB0CTrjF+E8VI8hwyswuikBZ/0ssXLoisUgkVey/K2
         8GgINcElY3sbAcF8V7bAGro/u1cIbuWYGcclHwEn86XJWgMMFebE0wq81AnTBdGsMZ
         mdSj24C7ZDqq9uN+TnCQW0RsIBAZUbYZpHCFMmzKAEbZKkEXFAU0Qmul5ECqXZpSIF
         xLDR5+eLPcjC4GBoXbcHfxrx2xduKLuZJd0Z1RkzDWO1yquL3wOfN/u7SiI7oYM0FS
         omY4a7gJuVLqg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v4 09/15] rust: init: add `PinnedDrop` trait and macros
Message-ID: <20230331215053.585759-10-y86-dev@protonmail.com>
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

The `PinnedDrop` trait that facilitates destruction of pinned types.
It has to be implemented via the `#[pinned_drop]` macro, since the
`drop` function should not be called by normal code, only by other
destructors. It also only works on structs that are annotated with
`#[pin_data(PinnedDrop)]`.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/init.rs            | 111 ++++++++++++++
 rust/kernel/init/__internal.rs |  15 ++
 rust/kernel/init/macros.rs     | 264 +++++++++++++++++++++++++++++++++
 rust/macros/lib.rs             |  49 ++++++
 rust/macros/pinned_drop.rs     |  49 ++++++
 5 files changed, 488 insertions(+)
 create mode 100644 rust/macros/pinned_drop.rs

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index cf2b9ee6ce0e..a507536f1724 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -104,6 +104,78 @@
 //! }
 //! ```
 //!
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
+//! use kernel::{prelude::*, init};
+//! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
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
+//! #[pin_data(PinnedDrop)]
+//! pub struct RawFoo {
+//!     #[pin]
+//!     foo: Opaque<bindings::foo>,
+//!     #[pin]
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
+//! #[pinned_drop]
+//! impl PinnedDrop for RawFoo {
+//!     fn drop(self: Pin<&mut Self>) {
+//!         // SAFETY: Since `foo` is initialized, destroying is safe.
+//!         unsafe { bindings::destroy_foo(self.foo.get()) };
+//!     }
+//! }
+//! ```
+//!
 //! [`sync`]: kernel::sync
 //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
 //! [structurally pinned fields]:
@@ -1083,3 +1155,42 @@ impl<T> InPlaceInit<T> for UniqueArc<T> {
         Ok(unsafe { this.assume_init() })
     }
 }
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
+pub unsafe trait PinnedDrop: __internal::HasPinData {
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
+    fn drop(self: Pin<&mut Self>, only_call_from_drop: __internal::OnlyCal=
lFromDrop);
+}
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.r=
s
index 0105290250f8..4d13d0ef3b5e 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -167,3 +167,18 @@ impl<T: ?Sized> Drop for DropGuard<T> {
         }
     }
 }
+
+/// Token used by `PinnedDrop` to prevent calling the function without cre=
ating this unsafely
+/// created struct. This is needed, because the `drop` function is safe, b=
ut should not be called
+/// manually.
+pub struct OnlyCallFromDrop(());
+
+impl OnlyCallFromDrop {
+    /// # Safety
+    ///
+    /// This function should only be called from the [`Drop::drop`] functi=
on and only be used to
+    /// delegate the destruction to the pinned destructor [`PinnedDrop::dr=
op`] of the same type.
+    pub unsafe fn new() -> Self {
+        Self(())
+    }
+}
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index e27c309c7ffd..7f9bf35ded3a 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -31,6 +31,26 @@
 //!         pin_init!(Self { t, x: 0 })
 //!     }
 //! }
+//!
+//! #[pin_data(PinnedDrop)]
+//! struct Foo {
+//!     a: usize,
+//!     #[pin]
+//!     b: Bar<u32>,
+//! }
+//!
+//! #[pinned_drop]
+//! impl PinnedDrop for Foo {
+//!     fn drop(self: Pin<&mut Self>) {
+//!         println!("{self:p} is getting dropped.");
+//!     }
+//! }
+//!
+//! let a =3D 42;
+//! let initializer =3D pin_init!(Foo {
+//!     a,
+//!     b <- Bar::new(36),
+//! });
 //! ```
 //!
 //! This example includes the most common and important features of the pi=
n-init API.
@@ -155,6 +175,14 @@
 //!     #[allow(drop_bounds)]
 //!     impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
 //!     impl<T> MustNotImplDrop for Bar<T> {}
+//!     // Here comes a convenience check, if one implemented `PinnedDrop`=
, but forgot to add it to
+//!     // `#[pin_data]`, then this will error with the same mechanic as a=
bove, this is not needed
+//!     // for safety, but a good sanity check, since no normal code calls=
 `PinnedDrop::drop`.
+//!     #[allow(non_camel_case_types)]
+//!     trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
+//!     impl<T: ::kernel::init::PinnedDrop>
+//!         UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T {}
+//!     impl<T> UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for B=
ar<T> {}
 //! };
 //! ```
 //!
@@ -265,6 +293,210 @@
 //!     }
 //! }
 //! ```
+//!
+//! ## `#[pin_data]` on `Foo`
+//!
+//! Since we already took a look at `#[pin_data]` on `Bar`, this section w=
ill only explain the
+//! differences/new things in the expansion of the `Foo` definition:
+//!
+//! ```rust
+//! #[pin_data(PinnedDrop)]
+//! struct Foo {
+//!     a: usize,
+//!     #[pin]
+//!     b: Bar<u32>,
+//! }
+//! ```
+//!
+//! This expands to the following code:
+//!
+//! ```rust
+//! struct Foo {
+//!     a: usize,
+//!     b: Bar<u32>,
+//! }
+//! const _: () =3D {
+//!     struct __ThePinData {
+//!         __phantom: ::core::marker::PhantomData<fn(Foo) -> Foo>,
+//!     }
+//!     impl ::core::clone::Clone for __ThePinData {
+//!         fn clone(&self) -> Self {
+//!             *self
+//!         }
+//!     }
+//!     impl ::core::marker::Copy for __ThePinData {}
+//!     #[allow(dead_code)]
+//!     impl __ThePinData {
+//!         unsafe fn b<E>(
+//!             self,
+//!             slot: *mut Bar<u32>,
+//!             // Note that this is `PinInit` instead of `Init`, this is =
because `b` is
+//!             // structurally pinned, as marked by the `#[pin]` attribut=
e.
+//!             init: impl ::kernel::init::PinInit<Bar<u32>, E>,
+//!         ) -> ::core::result::Result<(), E> {
+//!             unsafe { ::kernel::init::PinInit::__pinned_init(init, slot=
) }
+//!         }
+//!         unsafe fn a<E>(
+//!             self,
+//!             slot: *mut usize,
+//!             init: impl ::kernel::init::Init<usize, E>,
+//!         ) -> ::core::result::Result<(), E> {
+//!             unsafe { ::kernel::init::Init::__init(init, slot) }
+//!         }
+//!     }
+//!     unsafe impl ::kernel::init::__internal::HasPinData for Foo {
+//!         type PinData =3D __ThePinData;
+//!         unsafe fn __pin_data() -> Self::PinData {
+//!             __ThePinData {
+//!                 __phantom: ::core::marker::PhantomData,
+//!             }
+//!         }
+//!     }
+//!     unsafe impl ::kernel::init::__internal::PinData for __ThePinData {
+//!         type Datee =3D Foo;
+//!     }
+//!     #[allow(dead_code)]
+//!     struct __Unpin<'__pin> {
+//!         __phantom_pin: ::core::marker::PhantomData<fn(&'__pin ()) -> &=
'__pin ()>,
+//!         __phantom: ::core::marker::PhantomData<fn(Foo) -> Foo>,
+//!         // Since this field is `#[pin]`, it is listed here.
+//!         b: Bar<u32>,
+//!     }
+//!     #[doc(hidden)]
+//!     impl<'__pin> ::core::marker::Unpin for Foo where __Unpin<'__pin>: =
::core::marker::Unpin {}
+//!     // Since we specified `PinnedDrop` as the argument to `#[pin_data]=
`, we expect `Foo` to
+//!     // implement `PinnedDrop`. Thus we do not need to prevent `Drop` i=
mplementations like
+//!     // before, instead we implement it here and delegate to `PinnedDro=
p`.
+//!     impl ::core::ops::Drop for Foo {
+//!         fn drop(&mut self) {
+//!             // Since we are getting dropped, no one else has a referen=
ce to `self` and thus we
+//!             // can assume that we never move.
+//!             let pinned =3D unsafe { ::core::pin::Pin::new_unchecked(se=
lf) };
+//!             // Create the unsafe token that proves that we are inside =
of a destructor, this
+//!             // type is only allowed to be created in a destructor.
+//!             let token =3D unsafe { ::kernel::init::__internal::OnlyCal=
lFromDrop::new() };
+//!             ::kernel::init::PinnedDrop::drop(pinned, token);
+//!         }
+//!     }
+//! };
+//! ```
+//!
+//! ## `#[pinned_drop]` on `impl PinnedDrop for Foo`
+//!
+//! This macro is used to implement the `PinnedDrop` trait, since that tra=
it is `unsafe` and has an
+//! extra parameter that should not be used at all. The macro hides that p=
arameter.
+//!
+//! Here is the `PinnedDrop` impl for `Foo`:
+//!
+//! ```rust
+//! #[pinned_drop]
+//! impl PinnedDrop for Foo {
+//!     fn drop(self: Pin<&mut Self>) {
+//!         println!("{self:p} is getting dropped.");
+//!     }
+//! }
+//! ```
+//!
+//! This expands to the following code:
+//!
+//! ```rust
+//! // `unsafe`, full path and the token parameter are added, everything e=
lse stays the same.
+//! unsafe impl ::kernel::init::PinnedDrop for Foo {
+//!     fn drop(self: Pin<&mut Self>, _: ::kernel::init::__internal::OnlyC=
allFromDrop) {
+//!         println!("{self:p} is getting dropped.");
+//!     }
+//! }
+//! ```
+//!
+//! ## `pin_init!` on `Foo`
+//!
+//! Since we already took a look at `pin_init!` on `Bar`, this section wil=
l only explain the
+//! differences/new things in the expansion of `pin_init!` on `Foo`:
+//!
+//! ```rust
+//! let a =3D 42;
+//! let initializer =3D pin_init!(Foo {
+//!     a,
+//!     b <- Bar::new(36),
+//! });
+//! ```
+//!
+//! This expands to the following code:
+//!
+//! ```rust
+//! let a =3D 42;
+//! let initializer =3D {
+//!     struct __InitOk;
+//!     let data =3D unsafe {
+//!         use ::kernel::init::__internal::HasPinData;
+//!         Foo::__pin_data()
+//!     };
+//!     let init =3D ::kernel::init::__internal::PinData::make_closure::<
+//!         _,
+//!         __InitOk,
+//!         ::core::convert::Infallible,
+//!     >(data, move |slot| {
+//!         {
+//!             struct __InitOk;
+//!             unsafe { ::core::ptr::write(&raw mut (*slot).a, a) };
+//!             let a =3D &unsafe { ::kernel::init::__internal::DropGuard:=
:new(&raw mut (*slot).a) };
+//!             let b =3D Bar::new(36);
+//!             // Here we use `data` to access the correct field and requ=
ire that `b` is of type
+//!             // `PinInit<Bar<u32>, Infallible>`.
+//!             unsafe { data.b(&raw mut (*slot).b, b)? };
+//!             let b =3D &unsafe { ::kernel::init::__internal::DropGuard:=
:new(&raw mut (*slot).b) };
+//!
+//!             #[allow(unreachable_code, clippy::diverging_sub_expression=
)]
+//!             if false {
+//!                 unsafe {
+//!                     ::core::ptr::write(
+//!                         slot,
+//!                         Foo {
+//!                             a: ::core::panic!(),
+//!                             b: ::core::panic!(),
+//!                         },
+//!                     );
+//!                 };
+//!             }
+//!             unsafe { ::kernel::init::__internal::DropGuard::forget(a) =
};
+//!             unsafe { ::kernel::init::__internal::DropGuard::forget(b) =
};
+//!         }
+//!         Ok(__InitOk)
+//!     });
+//!     let init =3D move |slot| -> ::core::result::Result<(), ::core::con=
vert::Infallible> {
+//!         init(slot).map(|__InitOk| ())
+//!     };
+//!     let init =3D unsafe {
+//!         ::kernel::init::pin_init_from_closure::<_, ::core::convert::In=
fallible>(init)
+//!     };
+//!     init
+//! };
+//! ```
+
+/// Creates a `unsafe impl<...> PinnedDrop for $type` block.
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
+            fn drop($self: $st, _: $crate::init::__internal::OnlyCallFromD=
rop) {
+                $($inner)*
+            }
+        }
+    }
+}

 /// This macro first parses the struct definition such that it separates p=
inned and not pinned
 /// fields. Afterwards it declares the struct and implement the `PinData` =
trait safely.
@@ -653,6 +885,38 @@ macro_rules! __pin_data {
         impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
         impl<$($impl_generics)*> MustNotImplDrop for $name<$($ty_generics)=
*>
         where $($whr)* {}
+        // We also take care to prevent users from writing a useless `Pinn=
edDrop` implementation.
+        // They might implement `PinnedDrop` correctly for the struct, but=
 forget to give
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
+    // When `PinnedDrop` was specified we just implement `Drop` and delega=
te.
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
+                // SAFETY: Since this is a destructor, `self` will not mov=
e after this function
+                // terminates, since it is inaccessible.
+                let pinned =3D unsafe { ::core::pin::Pin::new_unchecked(se=
lf) };
+                // SAFETY: Since this is a drop function, we can create th=
is token to call the
+                // pinned destructor of this type.
+                let token =3D unsafe { $crate::init::__internal::OnlyCallF=
romDrop::new() };
+                $crate::init::PinnedDrop::drop(pinned, token);
+            }
+        }
     };
     // If some other parameter was specified, we emit a readable error.
     (drop_prevention:
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 4def038fe71a..86eb06f2d9fe 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -8,6 +8,7 @@ mod concat_idents;
 mod helpers;
 mod module;
 mod pin_data;
+mod pinned_drop;
 mod vtable;

 use proc_macro::TokenStream;
@@ -180,6 +181,10 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// This macro enables the use of the [`pin_init!`] macro. When pin-initia=
lizing a `struct`,
 /// then `#[pin]` directs the type of intializer that is required.
 ///
+/// If your `struct` implements `Drop`, then you need to add `PinnedDrop` =
as arguments to this
+/// macro, and change your `Drop` implementation to `PinnedDrop` annotated=
 with
+/// `#[`[`macro@pinned_drop`]`]`, since dropping pinned values requires ex=
tra care.
+///
 /// # Examples
 ///
 /// ```rust,ignore
@@ -191,9 +196,53 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// }
 /// ```
 ///
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
 /// [`pin_init!`]: ../kernel/macro.pin_init.html
 //  ^ cannot use direct link, since `kernel` is not a dependency of `macro=
s`.
 #[proc_macro_attribute]
 pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
     pin_data::pin_data(inner, item)
 }
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
--
2.39.2


