Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE06D86FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjDEThl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjDEThZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:37:25 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813A7AAB;
        Wed,  5 Apr 2023 12:36:53 -0700 (PDT)
Date:   Wed, 05 Apr 2023 19:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680723401; x=1680982601;
        bh=3ZQiwM1XABZbv+4wYf5UKIg9BYKGoXdjFv+NSHe8dj8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=QJ53TbU83dhiUfcpdLlmYkXlNBXarqVQDXzLO62UC5E5Zv98EgHs/v1m35UZta3B6
         rhqB0y3XiKx8YJp0mvN/zIoHWWhpaqs+FfEkzNb6tj4Oqw8HEOjNgCtv0hDvxv+54C
         h83PoF00RfP7GDt/V7aV6m9D6/aTkh2s2Ct0wfg5xEvDuoWEeO6i0tFXuXe/9fYpOX
         gu80eXvaSx+M9G/S2lqR+h9dJuoZGTRa8gxUAJSAR4RFSj67SGIYKUDHRt8/z7rhEi
         8CI/KyZtweQbFa2UR/UXoBbjjFHyTV5Z4G2eGGv/VAnFA8MfsB4OmQpnLwytYqPvDW
         mNca1OizvgZlQ==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, Andreas Hindborg <nmi@metaspace.dk>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v6 10/15] rust: init: add `stack_pin_init!` macro
Message-ID: <20230405193445.745024-11-y86-dev@protonmail.com>
In-Reply-To: <20230405193445.745024-1-y86-dev@protonmail.com>
References: <20230405193445.745024-1-y86-dev@protonmail.com>
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

The `stack_pin_init!` macro allows pin-initializing a value on the
stack. It accepts a `impl PinInit<T, E>` to initialize a `T`. It allows
propagating any errors via `?` or handling it normally via `match`.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
Cc: Gary Guo <gary@garyguo.net>
---
 rust/kernel/init.rs            | 140 +++++++++++++++++++++++++++++++--
 rust/kernel/init/__internal.rs |  50 ++++++++++++
 2 files changed, 184 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 37e8159df24d..99751375e7c8 100644
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
@@ -202,6 +204,132 @@ pub mod __internal;
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
+        let val =3D $val;
+        let mut $var =3D ::core::pin::pin!($crate::init::__internal::Stack=
Init$(::<$t>)?::uninit());
+        let mut $var =3D match $crate::init::__internal::StackInit::init($=
var, val) {
+            Ok(res) =3D> res,
+            Err(x) =3D> {
+                let x: ::core::convert::Infallible =3D x;
+                match x {}
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
+        let val =3D $val;
+        let mut $var =3D ::core::pin::pin!($crate::init::__internal::Stack=
Init$(::<$t>)?::uninit());
+        let mut $var =3D $crate::init::__internal::StackInit::init($var, v=
al);
+    };
+    (let $var:ident $(: $t:ty)? =3D? $val:expr) =3D> {
+        let val =3D $val;
+        let mut $var =3D ::core::pin::pin!($crate::init::__internal::Stack=
Init$(::<$t>)?::uninit());
+        let mut $var =3D $crate::init::__internal::StackInit::init($var, v=
al)?;
+    };
+}
+
 /// Construct an in-place, pinned initializer for `struct`s.
 ///
 /// This macro defaults the error to [`Infallible`]. If you need [`Error`]=
, then use
@@ -913,8 +1041,8 @@ macro_rules! try_init {
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
@@ -949,9 +1077,9 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>:=
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
index 69be03e17c1f..600b6442c6e9 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -112,6 +112,56 @@ unsafe impl<T: ?Sized> HasInitData for T {
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
+            this.1 =3D false;
+            // SAFETY: `this.1` was true and we set it to false.
+            unsafe { this.0.assume_init_drop() };
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


