Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976C574EAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGKJjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjGKJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:39:09 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE3610D4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:38:37 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-518676b6d09so3259222a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689068316; x=1691660316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBgmP0PJ2iUxFozvmmmYwZcxD6aJZ5z3cAsE+Xf1as4=;
        b=ZW2z8hOF1WRo80QrafK0JkXI57zkP9C7rM4fPyaa1AxBIiYredVLSA46iO2WpKHuUc
         +geNJaQzzi4cADrIqii2oBP5uLE/koheH+H1dMZyW8g5P9DFudIKPnlIzlwxlbWP54xt
         x6BbXLcZAVMRHMd+S6GmIEOg64evUP91Wj0dubwkkXgIVikM48pkRssOCeOwdeiI6bvT
         Jd1XfA7QMJ5YTREszwAJD9SPurKXk6nAfSemFpFTVlt9+TveOlmzcZxNfHAc1HQzr5pc
         s+HBC/OZwUOw33LF1YhiwJbMowsX/6i0a4QjDkKySJUXnHVTvlV6uJVuyzYybavzJcs7
         a3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689068316; x=1691660316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBgmP0PJ2iUxFozvmmmYwZcxD6aJZ5z3cAsE+Xf1as4=;
        b=Rs1hvq14Vnk2xKLr17AcXhkkYICSblx1mbotHjE6gIK5uHuPGWswvnYPygbmEOT0yL
         sHjKQl5k0ZVZM4u8UNxAKBK6g9sBkQylKsPzmXUoMFLXssJennCmBUy1aSudMMZzMn7V
         wR6I73hqqviVU4lRpBA07Ystf9Nph3oCjMGyRTiM3Rws7uLg/Ys3TBt1F66ALzmga2WF
         3h/T1z+K0y6B6MtTxWQ9OvsMtBl/TUfkoxK+ua5+UcEw0PUOwrKKvvib+TiAhMUUjliT
         HPUwHnVMybEuZeEhDTXCgnxkVSrD68fnAARJOw7acNoR3g8mThTSbD9cq/9NUSrIo2E7
         YBlQ==
X-Gm-Message-State: ABy/qLYLY5Kdw+xn/Y2lsS70yZSiHBKJDKYAczsFlKsAaYbcUakKGpWz
        D/GYFYFJiLnucaTnlgDUnsB3iZlFPR1GJyw=
X-Google-Smtp-Source: APBJJlHRkdAxXDJOzU6GNe5HqX7AK0yIjF3AgFRk6eKq/3smS8Hc+PazHrra3a28syJBLWIV2m+lLAmY5hhiBQU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:a047:b0:98e:4e80:f0e3 with SMTP
 id gz7-20020a170907a04700b0098e4e80f0e3mr50726ejc.9.1689068316182; Tue, 11
 Jul 2023 02:38:36 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:32:56 +0000
In-Reply-To: <20230711093303.1433770-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230711093303.1433770-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711093303.1433770-3-aliceryhl@google.com>
Subject: [PATCH v3 2/9] rust: sync: add `Arc::{from_raw, into_raw}`
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

These methods can be used to turn an `Arc` into a raw pointer and back,
in a way that preserves the metadata for fat pointers.

This is done using the unstable ptr_metadata feature [1]. However, it
could also be done using the unstable pointer_byte_offsets feature [2],
which is likely to have a shorter path to stabilization than
ptr_metadata.

Link: https://github.com/rust-lang/rust/issues/81513 [1]
Link: https://github.com/rust-lang/rust/issues/96283 [2]
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
v2 -> v3:
 * Use `transmute_copy` to convert metadata.
 * Use `add` instead of `wrapping_add`.
 * Dropped Reviewed-by from Martin and Benno due to changes.

 rust/kernel/lib.rs      |  1 +
 rust/kernel/sync/arc.rs | 49 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 788914fd935f..6963d11092c4 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -17,6 +17,7 @@
 #![feature(const_refs_to_cell)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
+#![feature(ptr_metadata)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
 
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index a89843cacaad..4046b534e53b 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -24,13 +24,13 @@
 };
 use alloc::boxed::Box;
 use core::{
-    alloc::AllocError,
+    alloc::{AllocError, Layout},
     fmt,
     marker::{PhantomData, Unsize},
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
     pin::Pin,
-    ptr::NonNull,
+    ptr::{NonNull, Pointee},
 };
 use macros::pin_data;
 
@@ -212,6 +212,51 @@ unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
         }
     }
 
+    /// Convert the [`Arc`] into a raw pointer.
+    ///
+    /// The raw pointer has ownership of the refcount that this Arc object owned.
+    pub fn into_raw(self) -> *const T {
+        let ptr = self.ptr.as_ptr();
+        core::mem::forget(self);
+        // SAFETY: The pointer is valid.
+        unsafe { core::ptr::addr_of!((*ptr).data) }
+    }
+
+    /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
+    ///
+    /// This code relies on the `repr(C)` layout of structs as described in
+    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
+    /// can only be called once for each previous call to [`Arc::into_raw`].
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        let refcount_layout = Layout::new::<bindings::refcount_t>();
+        // SAFETY: The caller guarantees that the pointer is valid.
+        let val_layout = Layout::for_value(unsafe { &*ptr });
+        // SAFETY: We're computing the layout of a real struct that existed when compiling this
+        // binary, so its layout is not so large that it can trigger arithmetic overflow.
+        let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
+
+        let metadata: <T as Pointee>::Metadata = core::ptr::metadata(ptr);
+        // SAFETY: The metadata of `T` and `ArcInner<T>` is the same because `ArcInner` is a struct
+        // with `T` as its last field.
+        //
+        // This is documented at:
+        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
+        let metadata: <ArcInner<T> as Pointee>::Metadata =
+            unsafe { core::mem::transmute_copy(&metadata) };
+        // SAFETY: The pointer is in-bounds of an allocation both before and after offsetting the
+        // pointer, since it originates from a previous call to `Arc::into_raw` and is still valid.
+        let ptr = unsafe { (ptr as *mut u8).sub(val_offset) as *mut () };
+        let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
+
+        // SAFETY: By the safety requirements we know that `ptr` came from `Arc::into_raw`, so the
+        // reference count held then will be owned by the new `Arc` object.
+        unsafe { Self::from_inner(NonNull::new_unchecked(ptr)) }
+    }
+
     /// Returns an [`ArcBorrow`] from the given [`Arc`].
     ///
     /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
-- 
2.41.0.255.g8b1d071c50-goog

