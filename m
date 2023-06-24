Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0B73CA15
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjFXJ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjFXJ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:26:07 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7286A2726
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:25:41 -0700 (PDT)
Date:   Sat, 24 Jun 2023 09:25:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687598739; x=1687857939;
        bh=gLSKxHqYjJDu1EPRJrKPDpLlPpYDJtCGZbauNM8TqoI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=PzF6EJxG1JQsX9+/c2QvRBGF5Cbkpnue8an6zQc9ZiqUYDUbqRR6uVPFTdYoxa/Bm
         XHmJxP2+dwnwyHf3xCVMBvycPXyKDfrpaN8Bj5tmkrE7wWjqNdcgT0DqgpmPB6vDEW
         OGo9gZ1pYvS64q4AwSnH2I155EI8c4TqhNeZjHkl+FjUKDJtx/S5blWgJzPDYobl3p
         kcKJ6g3/OTVZOVXUBEFG84CoFPxfj3wPjJYttS6dDdVYjlT29F0Ggd9yxgSjmoIx7G
         s37c8geiKJZtxmImSKsQ7OZ8+PKwY5V37EkLz4u2s8DNqh6gwCSt8tlyZ/9iSIZknp
         dohrYK9kH30KA==
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
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: [PATCH 6/7] rust: init: Add functions to create array initializers
Message-ID: <20230624092330.157338-6-benno.lossin@proton.me>
In-Reply-To: <20230624092330.157338-1-benno.lossin@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me>
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

Add two functions `pin_init_array_from_fn` and `init_array_from_fn` that
take a function that generates initializers for `T` from usize, the added
functions then return an initializer for `[T; N]` where every element is
initialized by an element returned from the generator function.

Suggested-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init.rs | 90 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 44bc3e77419a..c9ea4bf71987 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -867,6 +867,96 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> =
{
     unsafe { init_from_closure(|_| Ok(())) }
 }

+/// Initializes an array by initializing each element via the provided ini=
tializer.
+///
+/// # Examples
+///
+/// ```rust
+/// let array: Box<[usize; 1000_000_000]>=3D Box::init(init_array_from_fn(=
|i| i)).unwrap();
+/// println!("{array:?}");
+/// ```
+pub fn init_array_from_fn<I, const N: usize, T, E>(
+    mut make_init: impl FnMut(usize) -> I,
+) -> impl Init<[T; N], E>
+where
+    I: Init<T, E>,
+{
+    let init =3D move |slot: *mut [T; N]| {
+        let slot =3D slot.cast::<T>();
+        for i in 0..N {
+            let init =3D make_init(i);
+            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[T;=
 N]`.
+            let ptr =3D unsafe { slot.add(i) };
+            // SAFETY: The pointer is derived from `slot` and thus satisfi=
es the `__init`
+            // requirements.
+            match unsafe { init.__init(ptr) } {
+                Ok(()) =3D> {}
+                Err(e) =3D> {
+                    // We now free every element that has been initialized=
 before:
+                    for j in 0..i {
+                        let ptr =3D unsafe { slot.add(j) };
+                        // SAFETY: The value was initialized in a previous=
 iteration of the loop
+                        // and since we return `Err` below, the caller wil=
l consider the memory at
+                        // `slot` as uninitialized.
+                        unsafe { ptr::drop_in_place(ptr) };
+                    }
+                    return Err(e);
+                }
+            }
+        }
+        Ok(())
+    };
+    // SAFETY: The initializer above initializes every element of the arra=
y. On failure it drops
+    // any initialized elements and returns `Err`.
+    unsafe { init_from_closure(init) }
+}
+
+/// Initializes an array by initializing each element via the provided ini=
tializer.
+///
+/// # Examples
+///
+/// ```rust
+/// let array: Arc<[Mutex<usize>; 1000_000_000]>=3D
+///     Arc::pin_init(init_array_from_fn(|i| new_mutex!(i))).unwrap();
+/// println!("{array:?}");
+/// ```
+pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
+    mut make_init: impl FnMut(usize) -> I,
+) -> impl PinInit<[T; N], E>
+where
+    I: PinInit<T, E>,
+{
+    let init =3D move |slot: *mut [T; N]| {
+        let slot =3D slot.cast::<T>();
+        for i in 0..N {
+            let init =3D make_init(i);
+            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[T;=
 N]`.
+            let ptr =3D unsafe { slot.add(i) };
+            // SAFETY: The pointer is derived from `slot` and thus satisfi=
es the `__pinned_init`
+            // requirements.
+            match unsafe { init.__pinned_init(ptr) } {
+                Ok(()) =3D> {}
+                Err(e) =3D> {
+                    // We now have to free every element that has been ini=
tialized before, since we
+                    // have to abide by the drop guarantee.
+                    for j in 0..i {
+                        let ptr =3D unsafe { slot.add(j) };
+                        // SAFETY: The value was initialized in a previous=
 iteration of the loop
+                        // and since we return `Err` below, the caller wil=
l consider the memory at
+                        // `slot` as uninitialized.
+                        unsafe { ptr::drop_in_place(ptr) };
+                    }
+                    return Err(e);
+                }
+            }
+        }
+        Ok(())
+    };
+    // SAFETY: The initializer above initializes every element of the arra=
y. On failure it drops
+    // any initialized elements and returns `Err`.
+    unsafe { pin_init_from_closure(init) }
+}
+
 // SAFETY: Every type can be initialized by-value.
 unsafe impl<T, E> Init<T, E> for T {
     unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
--
2.41.0


