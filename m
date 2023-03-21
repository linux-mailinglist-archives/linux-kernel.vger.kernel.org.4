Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107516C3AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCUTuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCUTur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:50:47 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDA04BE8E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:50:24 -0700 (PDT)
Date:   Tue, 21 Mar 2023 19:50:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679428219; x=1679687419;
        bh=FNlCN3cHsJdz3JxxhBIbrUQMYy+/cKZuDeBnqnufKaQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Og5rTLKVLPegceIya3psm7F/BerxmDfAFFqiPBwcw8oflNcadzZX9R6uU+QWVPW8O
         Y9m/o1sNRQzKtYQ6BXCErgut/8YWPXIndUd81bUaiMiklBCVvQ2PvNaOBjAlKDrAFQ
         RCu1WHJOJPIObRLRMaXKupJNP7Ia66UcCPfunnI3m4HAn5nR3oemQbU+oFkqewylpG
         Znv3UBP+tMUEanZndB8AqeG3RzPo2Am0W1cNvcKQTAAk2L/8v0vqid3Um/wWSfMI1z
         3JoGgXoh/xEGgijXgNapaKTnIsq+P4ePMmTSN80lBVUADn/RYJ2V2k0Pb+5CtK1nlr
         Y2VRfX8RZylag==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 5/5] rust: sync: reduce stack usage of `UniqueArc::try_new_uninit`
Message-ID: <20230321194934.908891-6-y86-dev@protonmail.com>
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

`UniqueArc::try_new_uninit` calls `Arc::try_new(MaybeUninit::uninit())`.
This results in the uninitialized memory being placed on the stack,
which may be arbitrarily large due to the generic `T` and thus could
cause a stack overflow for large types.

Change the implementation to use the pin-init API which enables in-place
initialization. In particular it avoids having to first construct and
then move the uninitialized memory from the stack into the final location.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
---
 rust/kernel/lib.rs      |  1 -
 rust/kernel/sync/arc.rs | 12 +++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3e2777d26ff5..d9df77132fa2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -27,7 +27,6 @@
 #[cfg(not(CONFIG_RUST))]
 compile_error!("Missing kernel configuration for conditional compilation")=
;

-#[allow(unused_extern_crates)]
 // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (thi=
s crate).
 extern crate self as kernel;

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 5b4f64dd3ac8..0518ff99b6c5 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -18,6 +18,7 @@
 use crate::{
     bindings,
     error::{Error, Result},
+    init,
     init::{InPlaceInit, Init, PinInit},
     types::{ForeignOwnable, Opaque},
 };
@@ -29,6 +30,7 @@ use core::{
     pin::Pin,
     ptr::NonNull,
 };
+use macros::pin_data;

 /// A reference-counted pointer to an instance of `T`.
 ///
@@ -121,6 +123,7 @@ pub struct Arc<T: ?Sized> {
     _p: PhantomData<ArcInner<T>>,
 }

+#[pin_data]
 #[repr(C)]
 struct ArcInner<T: ?Sized> {
     refcount: Opaque<bindings::refcount_t>,
@@ -501,9 +504,16 @@ impl<T> UniqueArc<T> {

     /// Tries to allocate a new [`UniqueArc`] instance whose contents are =
not initialised yet.
     pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>> {
+        // INVARIANT: The refcount is initialised to a non-zero value.
+        let inner =3D Box::init(init!(ArcInner::<MaybeUninit<T>> {
+            // SAFETY: There are no safety requirements for this FFI call.
+            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+            data <- init::uninit(),
+        }))?;
         Ok(UniqueArc::<MaybeUninit<T>> {
             // INVARIANT: The newly-created object has a ref-count of 1.
-            inner: Arc::try_new(MaybeUninit::uninit())?,
+            // SAFETY: The pointer from the `Box` is valid.
+            inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
         })
     }
 }
--
2.39.2


