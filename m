Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31D56D86F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjDEThA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjDETg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:36:56 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA677A89
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:36:30 -0700 (PDT)
Date:   Wed, 05 Apr 2023 19:36:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680723387; x=1680982587;
        bh=rVAoBB7j7+4TBh9MobsDHzt2EeUNSPqynZHsd5gAfKg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=sITvYNcW/8wNN+jqEHc2AmdD/t1NAKXKi/w4K7ztyz04EnTvAgAv2m8jI/BUh62DW
         IatNWMxTa3xaut/Ku5K2Sza7DQPsisDoSJHsjS1wxPwhBOpusS9wlIWZO/chyvCqcN
         R8QxtGTGnwNBrBWX3UXCptN2lBcwCXtHgyeL38UytHNp3JoYKoZnPZaMEaQ+khy+ce
         qH5PGymfp/b7+oEkJfh6OPiWdQyHUzLmkcavbVB0gGxrSfpmV126yKQUNB2oWI8+/s
         v/vdo/v1yQZeUdW4OB4W2SpBjE7hRIlPU/2f0M3KC9Pia14VmIYasVVUzzj5Q9UXhs
         pUHzcGozWLrdw==
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
Subject: [PATCH v6 08/15] rust: init/sync: add `InPlaceInit` trait to pin-initialize smart pointers
Message-ID: <20230405193445.745024-9-y86-dev@protonmail.com>
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

The `InPlaceInit` trait that provides two functions, for initializing
using `PinInit<T, E>` and `Init<T>`. It is implemented by `Arc<T>`,
`UniqueArc<T>` and `Box<T>`.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/init.rs     | 128 ++++++++++++++++++++++++++++++++++++----
 rust/kernel/sync/arc.rs |  24 ++++++++
 2 files changed, 139 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index ecef0376d726..6499cf5c9c20 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -114,10 +114,16 @@
 //! [`impl Init<T, E>`]: Init
 //! [`Opaque`]: kernel::types::Opaque
 //! [`pin_data`]: ::macros::pin_data
-//! [`UniqueArc<T>`]: kernel::sync::UniqueArc

+use crate::{
+    error::{self, Error},
+    sync::UniqueArc,
+};
 use alloc::boxed::Box;
-use core::{cell::Cell, convert::Infallible, marker::PhantomData, mem::Mayb=
eUninit, ptr};
+use core::{
+    alloc::AllocError, cell::Cell, convert::Infallible, marker::PhantomDat=
a, mem::MaybeUninit,
+    pin::Pin, ptr,
+};

 #[doc(hidden)]
 pub mod __internal;
@@ -309,7 +315,6 @@ pub mod macros;
 ///
 /// [`try_pin_init!`]: kernel::try_pin_init
 /// [`NonNull<Self>`]: core::ptr::NonNull
-/// [`Error`]: kernel::error::Error
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
@@ -363,8 +368,6 @@ macro_rules! pin_init {
 ///     }
 /// }
 /// ```
-///
-/// [`Error`]: kernel::error::Error
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
@@ -586,8 +589,6 @@ macro_rules! try_pin_init {
 ///
 /// This initializer is for initializing data in-place that might later be=
 moved. If you want to
 /// pin-initialize, use [`pin_init!`].
-///
-/// [`Error`]: kernel::error::Error
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
@@ -635,8 +636,6 @@ macro_rules! init {
 ///     }
 /// }
 /// ```
-///
-/// [`Error`]: kernel::error::Error
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
@@ -842,7 +841,8 @@ macro_rules! try_init {
 /// A pin-initializer for the type `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`].
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pi=
n_init`] function of a
+/// smart pointer like [`Arc<T>`] on this.
 ///
 /// Also see the [module description](self).
 ///
@@ -861,7 +861,6 @@ macro_rules! try_init {
 ///
 /// [`Arc<T>`]: crate::sync::Arc
 /// [`Arc::pin_init`]: crate::sync::Arc::pin_init
-/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: Sized {
     /// Initializes `slot`.
@@ -878,7 +877,8 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: =
Sized {
 /// An initializer for `T`.
 ///
 /// To use this initializer, you will need a suitable memory location that=
 can hold a `T`. This can
-/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Because [`PinInit<T, E>`]=
 is a super trait, you can
+/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::in=
it`] function of a smart
+/// pointer like [`Arc<T>`] on this. Because [`PinInit<T, E>`] is a super =
trait, you can
 /// use every function that takes it as well.
 ///
 /// Also see the [module description](self).
@@ -903,7 +903,6 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: =
Sized {
 /// move the pointee after initialization.
 ///
 /// [`Arc<T>`]: crate::sync::Arc
-/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
 #[must_use =3D "An initializer must be used in order to create its value."=
]
 pub unsafe trait Init<T: ?Sized, E =3D Infallible>: Sized {
     /// Initializes `slot`.
@@ -982,3 +981,106 @@ unsafe impl<T> Init<T> for T {
         Ok(())
     }
 }
+
+/// Smart pointer that can initialize memory in-place.
+pub trait InPlaceInit<T>: Sized {
+    /// Use the given pin-initializer to pin-initialize a `T` inside of a =
new smart pointer of this
+    /// type.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>;
+
+    /// Use the given pin-initializer to pin-initialize a `T` inside of a =
new smart pointer of this
+    /// type.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
+    where
+        Error: From<E>,
+    {
+        // SAFETY: We delegate to `init` and only change the error type.
+        let init =3D unsafe {
+            pin_init_from_closure(|slot| init.__pinned_init(slot).map_err(=
|e| Error::from(e)))
+        };
+        Self::try_pin_init(init)
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
+    where
+        E: From<AllocError>;
+
+    /// Use the given initializer to in-place initialize a `T`.
+    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
+    where
+        Error: From<E>,
+    {
+        // SAFETY: We delegate to `init` and only change the error type.
+        let init =3D unsafe {
+            init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| =
Error::from(e)))
+        };
+        Self::try_init(init)
+    }
+}
+
+impl<T> InPlaceInit<T> for Box<T> {
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this =3D Box::try_new_uninit()?;
+        let slot =3D this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() }.into())
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this =3D Box::try_new_uninit()?;
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
+impl<T> InPlaceInit<T> for UniqueArc<T> {
+    #[inline]
+    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
+    where
+        E: From<AllocError>,
+    {
+        let mut this =3D UniqueArc::try_new_uninit()?;
+        let slot =3D this.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { this.assume_init() }.into())
+    }
+
+    #[inline]
+    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
+    where
+        E: From<AllocError>,
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
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index eee7008e5e3e..43a53fbe175d 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -17,6 +17,8 @@

 use crate::{
     bindings,
+    error::{self, Error},
+    init::{InPlaceInit, Init, PinInit},
     types::{ForeignOwnable, Opaque},
 };
 use alloc::boxed::Box;
@@ -163,6 +165,28 @@ impl<T> Arc<T> {
         // `Arc` object.
         Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
     }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    #[inline]
+    pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Self>
+    where
+        Error: From<E>,
+    {
+        UniqueArc::pin_init(init).map(|u| u.into())
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// This is equivalent to [`pin_init`], since an [`Arc`] is always pin=
ned.
+    #[inline]
+    pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
+    where
+        Error: From<E>,
+    {
+        UniqueArc::init(init).map(|u| u.into())
+    }
 }

 impl<T: ?Sized> Arc<T> {
--
2.39.2


