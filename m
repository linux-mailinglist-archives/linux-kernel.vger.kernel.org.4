Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBED6D2A63
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjCaVxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjCaVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:53:25 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55EC24AD6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:52:53 -0700 (PDT)
Date:   Fri, 31 Mar 2023 21:52:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680299544; x=1680558744;
        bh=cIYxRs7yWpZ2jDriBGlcgcMewm6UvtEXri4X8Q7xEW0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=otNFDXXlhG/gIl3RnMg0DdR5n16yctHA1VzqcPrlB7o+CsGPpwgavkyaYyKarynGQ
         6MP0mgMTeMSckx2GtHfTjFWSPIVuDj1lt1Xvbpes7Qa4GMet7B6BARbVJyMaOqH9Cg
         E+3shMdvvKd5ark4ZiS65dcSyxMsgq4T8IkY4nNuA9oCDq+fAj4gKeJG72FAQito86
         DRHbH1ZNLfrGnOBxum0t5Vk8Ziscs12OIlBBOuxnAbWNq+E0D9YmPfIMpp4f+8KGtZ
         YaGk0KGSrDjmqQ/MEouXNEeI/nLhkL9KN2aPUnB6JMTKhL3Hxb3hM5nOBgt17arcgl
         kf8jjfDp6QbGg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v4 03/15] rust: sync: change error type of constructor functions
Message-ID: <20230331215053.585759-4-y86-dev@protonmail.com>
In-Reply-To: <20230331215053.585759-1-y86-dev@protonmail.com>
References: <20230331215053.585759-1-y86-dev@protonmail.com>
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

Change the error type of the constructors of `Arc` and `UniqueArc` to be
`AllocError` instead of `Error`. This makes the API more clear as to
what can go wrong when calling `try_new` or its variants.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
Cc: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/arc.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index f2f1c83d72ba..aa7135f0f238 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -17,11 +17,11 @@

 use crate::{
     bindings,
-    error::Result,
     types::{ForeignOwnable, Opaque},
 };
 use alloc::boxed::Box;
 use core::{
+    alloc::AllocError,
     marker::{PhantomData, Unsize},
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
@@ -149,7 +149,7 @@ unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}

 impl<T> Arc<T> {
     /// Constructs a new reference counted instance of `T`.
-    pub fn try_new(contents: T) -> Result<Self> {
+    pub fn try_new(contents: T) -> Result<Self, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
         let value =3D ArcInner {
             // SAFETY: There are no safety requirements for this FFI call.
@@ -469,7 +469,7 @@ pub struct UniqueArc<T: ?Sized> {

 impl<T> UniqueArc<T> {
     /// Tries to allocate a new [`UniqueArc`] instance.
-    pub fn try_new(value: T) -> Result<Self> {
+    pub fn try_new(value: T) -> Result<Self, AllocError> {
         Ok(Self {
             // INVARIANT: The newly-created object has a ref-count of 1.
             inner: Arc::try_new(value)?,
@@ -477,7 +477,7 @@ impl<T> UniqueArc<T> {
     }

     /// Tries to allocate a new [`UniqueArc`] instance whose contents are =
not initialised yet.
-    pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>> {
+    pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocErro=
r> {
         Ok(UniqueArc::<MaybeUninit<T>> {
             // INVARIANT: The newly-created object has a ref-count of 1.
             inner: Arc::try_new(MaybeUninit::uninit())?,
--
2.39.2


