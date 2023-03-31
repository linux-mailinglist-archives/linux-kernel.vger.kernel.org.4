Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CF56D2A70
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjCaV4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjCaV4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:56:32 -0400
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F3D21ABA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:55:58 -0700 (PDT)
Date:   Fri, 31 Mar 2023 21:53:51 +0000
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="hMiLXroT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680299645; x=1680558845;
        bh=sr2JvwCQdmMvlR7/qpZ4bQwbcN/uY8dZ+qqwZJYCJHk=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=hMiLXroTIFFAz5EJ8MA6SeSM1L2VB6VfiLs7V2lXWsY0ii+BdM7PlmBNayeFk8LVx
         Y4LS4MuI23KoTGP3FQ3Ir2VazfBs6q7EUogHVabF1HEy9mA7Dwz6gg2GLGGcXQ6b83
         7OoBjlqSdnArgA6Kh3ddRWCCXjFceronO95l3FxKn76+LlBecx3DrSKHoEJ9u/Jz1e
         MFrTlBt2/HJYeacwYoaIZ6pYFHyYP8/k/i31FEJWRiD6YTVnQGJgUUQk1NtPxwc48d
         b1/GTaVFSD10CqP2/OAiLp9/eh1D4iuZ+GBMegfn3M20QIc9Op1ELnJewNuInBSg+G
         nRpN2FDRdVtOw==
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
Subject: [PATCH v4 10/15] rust: init: add `stack_pin_init!` macro
Message-ID: <20230331215053.585759-11-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benno Lossin <y86-dev@protonmail.com>

The `stack_pin_init!` macro allows pin-initializing a value on the
stack. It accepts a `impl PinInit<T, E>` to initialize a `T`. It allows
propagating any errors via `?` or handling it normally via `match`.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
Cc: Gary Guo <gary@garyguo.net>
---
 rust/kernel/init.rs            | 146 +++++++++++++++++++++++++++++++--
 rust/kernel/init/__internal.rs |  50 +++++++++++
 2 files changed, 190 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index a507536f1724..5661f30bb0e4 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -12,7 +12,8 @@
 //!
 //! To initialize a `struct` with an in-place constructor you will need tw=
o things:
 //! - an in-place constructor,
-//! - a memory location that can hold your `struct`.
+//! - a memory location that can hold your `struct` (this can be the [stac=
k], an [`Arc<T>`],
+//!   [`UniqueArc<T>`], [`Box<T>`] or any other smart pointer that impleme=
nts [`InPlaceInit`]).
 //!
 //! To get an in-place constructor there are generally three options:
 //! - directly creating an in-place constructor using the [`pin_init!`] ma=
cro,
@@ -180,6 +181,7 @@
 //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
 //! [structurally pinned fields]:
 //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural=
-for-field
+//! [stack]: crate::stack_pin_init
 //! [`Arc<T>`]: crate::sync::Arc
 //! [`impl PinInit<Foo>`]: PinInit
 //! [`impl PinInit<T, E>`]: PinInit
@@ -202,6 +204,138 @@ pub mod __internal;
 #[doc(hidden)]
 pub mod macros;

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
+/// stack_pin_init!(let foo =3D pin_init!(Foo {
+///     a <- new_mutex!(42),
+///     b: Bar {
+///         x: 64,
+///     },
+/// }));
+/// let foo: Pin<&mut Foo> =3D foo;
+/// pr_info!("a: {}", &*foo.a.lock());
+/// ```
+///
+/// # Syntax
+///
+/// A normal `let` binding with optional type annotation. The expression i=
s expected to implement
+/// [`PinInit`]/[`Init`] with the error type [`Infallible`]. If you want t=
o use a different error
+/// type, then use [`stack_try_pin_init!`].
+#[macro_export]
+macro_rules! stack_pin_init {
+    (let $var:ident $(: $t:ty)? =3D $val:expr) =3D> {
+        let mut $var =3D ::core::pin::pin!($crate::init::__internal::Stack=
Init$(::<$t>)?::uninit());
+        let mut $var =3D {
+            let val =3D $val;
+            match $crate::init::__internal::StackInit::init($var, val) {
+                Ok(res) =3D> res,
+                Err(x) =3D> {
+                    let x: ::core::convert::Infallible =3D x;
+                    match x {}
+                }
+            }
+        };
+    };
+}
+
+/// Initialize and pin a type directly on the stack.
+///
+/// # Examples
+///
+/// ```rust
+/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mute=
x, new_mutex};
+/// # use macros::pin_data;
+/// # use core::{alloc::AllocError, pin::Pin};
+/// #[pin_data]
+/// struct Foo {
+///     #[pin]
+///     a: Mutex<usize>,
+///     b: Box<Bar>,
+/// }
+///
+/// struct Bar {
+///     x: u32,
+/// }
+///
+/// stack_try_pin_init!(let foo: Result<Pin<&mut Foo>, AllocError> =3D pin=
_init!(Foo {
+///     a <- new_mutex!(42),
+///     b: Box::try_new(Bar {
+///         x: 64,
+///     })?,
+/// }));
+/// let foo =3D foo.unwrap();
+/// pr_info!("a: {}", &*foo.a.lock());
+/// ```
+///
+/// ```rust
+/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mute=
x, new_mutex};
+/// # use macros::pin_data;
+/// # use core::{alloc::AllocError, pin::Pin};
+/// #[pin_data]
+/// struct Foo {
+///     #[pin]
+///     a: Mutex<usize>,
+///     b: Box<Bar>,
+/// }
+///
+/// struct Bar {
+///     x: u32,
+/// }
+///
+/// stack_try_pin_init!(let foo: Pin<&mut Foo> =3D? pin_init!(Foo {
+///     a <- new_mutex!(42),
+///     b: Box::try_new(Bar {
+///         x: 64,
+///     })?,
+/// }));
+/// pr_info!("a: {}", &*foo.a.lock());
+/// # Ok::<_, AllocError>(())
+/// ```
+///
+/// # Syntax
+///
+/// A normal `let` binding with optional type annotation. The expression i=
s expected to implement
+/// [`PinInit`]/[`Init`]. This macro assigns a result to the given variabl=
e, adding a `?` after the
+/// `=3D` will propagate this error.
+#[macro_export]
+macro_rules! stack_try_pin_init {
+    (let $var:ident $(: $t:ty)? =3D $val:expr) =3D> {
+        let mut $var =3D ::core::pin::pin!($crate::init::__internal::Stack=
Init$(::<$t>)?::uninit());
+        let mut $var =3D {
+            let val =3D $val;
+            $crate::init::__internal::StackInit::init($var, val)
+        };
+    };
+    (let $var:ident $(: $t:ty)? =3D? $val:expr) =3D> {
+        let mut $var =3D ::core::pin::pin!($crate::init::__internal::Stack=
Init$(::<$t>)?::uninit());
+        let mut $var =3D {
+            let val =3D $val;
+            $crate::init::__internal::StackInit::init($var, val)?
+        };
+    };
+}
+
 /// Construct an in-place, pinned initializer for `struct`s.
 ///
 /// This macro defaults the error to [`Infallible`]. If you need [`Error`]=
, then use
@@ -916,8 +1050,8 @@ macro_rules! try_init {
 /// A pin-initializer for the type `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pi=
n_init`] function of a
-/// smart pointer like [`Arc<T>`] on this.
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`s=
tack_pin_init!`]). Use the
+/// [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc<T>`] =
on this.
 ///
 /// Also see the [module description](self).
 ///
@@ -952,9 +1086,9 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>:=
 Sized {
 /// An initializer for `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::in=
it`] function of a smart
-/// pointer like [`Arc<T>`] on this. Because [`PinInit<T, E>`] is a super =
trait, you can
-/// use every function that takes it as well.
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`s=
tack_pin_init!`]). Use the
+/// [`InPlaceInit::init`] function of a smart pointer like [`Arc<T>`] on t=
his. Because
+/// [`PinInit<T, E>`] is a super trait, you can use every function that ta=
kes it as well.
 ///
 /// Also see the [module description](self).
 ///
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.r=
s
index 4d13d0ef3b5e..5f753ff324b2 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -124,6 +124,56 @@ unsafe impl<T: ?Sized> HasInitData for T {
     }
 }

+/// Stack initializer helper type. Use [`stack_pin_init`] instead of this =
primitive.
+///
+/// # Invariants
+///
+/// If `self.1` is true, then `self.0` is initialized.
+///
+/// [`stack_pin_init`]: kernel::stack_pin_init
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
+    #[inline]
+    pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Resu=
lt<Pin<&mut T>, E> {
+        // SAFETY: We never move out of `this`.
+        let this =3D unsafe { Pin::into_inner_unchecked(self) };
+        // The value is currently initialized, so it needs to be dropped b=
efore we can reuse
+        // the memory (this is a safety guarantee of `Pin`).
+        if this.1 {
+            // SAFETY: `this.1` is true and we set it to false after this.
+            unsafe { this.0.assume_init_drop() };
+            this.1 =3D false;
+        }
+        // SAFETY: The memory slot is valid and this type ensures that it =
will stay pinned.
+        unsafe { init.__pinned_init(this.0.as_mut_ptr())? };
+        this.1 =3D true;
+        // SAFETY: The slot is now pinned, since we will never give access=
 to `&mut T`.
+        Ok(unsafe { Pin::new_unchecked(this.0.assume_init_mut()) })
+    }
+}
+
 /// When a value of this type is dropped, it drops a `T`.
 ///
 /// Can be forgotton to prevent the drop.
--
2.39.2


