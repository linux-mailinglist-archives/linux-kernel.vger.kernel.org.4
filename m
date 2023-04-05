Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8C66D8707
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjDETid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjDETiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:38:21 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F0B7ABF;
        Wed,  5 Apr 2023 12:37:48 -0700 (PDT)
Date:   Wed, 05 Apr 2023 19:36:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680723430; x=1680982630;
        bh=ZCKyMh4Cy/a8XCkX5YtgorxlPc4QWU1n5QVDMdo6GOo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=B9v+mNYE+wICOGnB1gx9G8hQz5juL8uXYdjvo0bSEZLdFjfADz11wIE2VhQDM7QNi
         x1p2Jd8LtPSnnXCxKBvT/BQMcSSVQakOn5Tu9zNq4BgJrjV36JBs1HKgQUcWdUwvcH
         CCH2wMxnRm/0j3WFa+m5L/OGsfJrk3XBKSapXCxB+bxmo6phWLX6xaeJL1oHmt/G98
         n6A7XITPBOxvkXVDKSjY9/n/d7XCpba+Ub3bBocwqugIouncNDDnV3WaPQC10uSlGe
         iUZsj3YHeyud28v8VWNcoZSfsJSJDflsjvDQ6ZrdOOqlngzdBufDuYWy3zvySFVp+H
         qvHizrikBFTig==
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
Subject: [PATCH v6 14/15] rust: sync: reduce stack usage of `UniqueArc::try_new_uninit`
Message-ID: <20230405193445.745024-15-y86-dev@protonmail.com>
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

`UniqueArc::try_new_uninit` calls `Arc::try_new(MaybeUninit::uninit())`.
This results in the uninitialized memory being placed on the stack,
which may be arbitrarily large due to the generic `T` and thus could
cause a stack overflow for large types.

Change the implementation to use the pin-init API which enables in-place
initialization. In particular it avoids having to first construct and
then move the uninitialized memory from the stack into the final location.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/lib.rs      |  1 -
 rust/kernel/sync/arc.rs | 16 +++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 821bd067151c..2d7606135ef6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -28,7 +28,6 @@
 #[cfg(not(CONFIG_RUST))]
 compile_error!("Missing kernel configuration for conditional compilation")=
;

-#[allow(unused_extern_crates)]
 // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (thi=
s crate).
 extern crate self as kernel;

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 43a53fbe175d..d05caa723718 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -18,7 +18,8 @@
 use crate::{
     bindings,
     error::{self, Error},
-    init::{InPlaceInit, Init, PinInit},
+    init::{self, InPlaceInit, Init, PinInit},
+    try_init,
     types::{ForeignOwnable, Opaque},
 };
 use alloc::boxed::Box;
@@ -30,6 +31,7 @@ use core::{
     pin::Pin,
     ptr::NonNull,
 };
+use macros::pin_data;

 /// A reference-counted pointer to an instance of `T`.
 ///
@@ -122,6 +124,7 @@ pub struct Arc<T: ?Sized> {
     _p: PhantomData<ArcInner<T>>,
 }

+#[pin_data]
 #[repr(C)]
 struct ArcInner<T: ?Sized> {
     refcount: Opaque<bindings::refcount_t>,
@@ -502,9 +505,16 @@ impl<T> UniqueArc<T> {

     /// Tries to allocate a new [`UniqueArc`] instance whose contents are =
not initialised yet.
     pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocErro=
r> {
-        Ok(UniqueArc::<MaybeUninit<T>> {
+        // INVARIANT: The refcount is initialised to a non-zero value.
+        let inner =3D Box::try_init::<AllocError>(try_init!(ArcInner {
+            // SAFETY: There are no safety requirements for this FFI call.
+            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+            data <- init::uninit::<T, AllocError>(),
+        }? AllocError))?;
+        Ok(UniqueArc {
             // INVARIANT: The newly-created object has a ref-count of 1.
-            inner: Arc::try_new(MaybeUninit::uninit())?,
+            // SAFETY: The pointer from the `Box` is valid.
+            inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
         })
     }
 }
--
2.39.2


