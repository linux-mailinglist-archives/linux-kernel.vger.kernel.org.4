Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDB4743E30
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjF3PDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjF3PDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:03:40 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4618F171E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:03:36 -0700 (PDT)
Date:   Fri, 30 Jun 2023 15:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1688137413; x=1688396613;
        bh=GOuPFgT87znF0ebWMyLwXo4ofXzgfLkd6vzl1Y3CfqA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=NrF664B6Yj0S5v0K2a8SBUlj4tguRpmjCqdIi0VDecC5Af+oGs8Jow/Z7UlUxgpU6
         sr/lRkn5WLpKUuwrJ28b9xhWvtVm92iXjHoqHgWwALy5WJK8wMWigXQKzq1J9YbtoY
         uVH5+0WMMG8zV1uDUJTmaUnY8YJ+2i+atSwnmEPX3gyffdh+XdnG+oPAq8RegM1QH+
         oayFkKeYdKuzUUuBX30Zi8Cq1uFdEhbv/o0k0GnPqXGRIPHirt2o3vNMtQIAcGGof+
         trOWTeMVgrocDBf+d+8C2bakHzV+avyR/N5Pe+Zj8MW4uCaACwlW5L00vXRO8abiIz
         EQVCjKMpULetA==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH] rust: types: make `Opaque` be `!Unpin`
Message-ID: <20230630150216.109789-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a `PhantomPinned` field to `Opaque<T>`. This removes the last Rust
guarantee: the assumption that the type `T` can be freely moved. This is
not the case for many types from the C side (e.g. if they contain a
`struct list_head`). This change removes the need to add a
`PhantomPinned` field manually to Rust structs that contain C structs
which must not be moved.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
This patch depends on the patch that swaps `UnsafeCell` with
`MaybeUninit` inside `Opaque` [1].

[1]: https://lore.kernel.org/rust-for-linux/20230614115328.2825961-1-alicer=
yhl@google.com/
---
 rust/kernel/types.rs | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index fb41635f1e1f..e664a2beef30 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -6,7 +6,7 @@
 use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
-    marker::PhantomData,
+    marker::{PhantomData, PhantomPinned},
     mem::MaybeUninit,
     ops::{Deref, DerefMut},
     ptr::NonNull,
@@ -224,17 +224,26 @@ fn drop(&mut self) {
 ///
 /// This is meant to be used with FFI objects that are never interpreted b=
y Rust code.
 #[repr(transparent)]
-pub struct Opaque<T>(UnsafeCell<MaybeUninit<T>>);
+pub struct Opaque<T> {
+    value: UnsafeCell<MaybeUninit<T>>,
+    _pin: PhantomPinned,
+}
=20
 impl<T> Opaque<T> {
     /// Creates a new opaque value.
     pub const fn new(value: T) -> Self {
-        Self(UnsafeCell::new(MaybeUninit::new(value)))
+        Self {
+            value: UnsafeCell::new(MaybeUninit::new(value)),
+            _pin: PhantomPinned,
+        }
     }
=20
     /// Creates an uninitialised value.
     pub const fn uninit() -> Self {
-        Self(UnsafeCell::new(MaybeUninit::uninit()))
+        Self {
+            value: UnsafeCell::new(MaybeUninit::uninit()),
+            _pin: PhantomPinned,
+        }
     }
=20
     /// Creates a pin-initializer from the given initializer closure.
@@ -258,7 +267,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl=
 PinInit<Self> {
=20
     /// Returns a raw pointer to the opaque data.
     pub fn get(&self) -> *mut T {
-        UnsafeCell::get(&self.0).cast::<T>()
+        UnsafeCell::get(&self.value).cast::<T>()
     }
=20
     /// Gets the value behind `this`.
--=20
2.41.0


