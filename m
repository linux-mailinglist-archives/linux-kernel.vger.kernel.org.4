Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3858C719EDD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjFANxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFANxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:53:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E97119
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:53:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacd408046cso1313040276.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685627597; x=1688219597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=emM0vnYZP8ovSB9/0L28X7xu1W1tC2o+UTrpcckUn6I=;
        b=xiQpeTApD8EOPRLGvqOEbGnwk5VdgbS481DnQDIEFxEdsz/On6iBdKRYTdwC4GSgKB
         ph6LBgaidNw+WGSeSHFktPPsUZz32+fyRaDVJAIFfZN/e98wVfiftPu+6Uks3ZrG/Wbm
         qYQSoWdlUuUSFuYtP5XYH42+XrgljkWS1ibSt+8a48D1yXNfxUsbCgVXQcRA1QlmnIjo
         DJdJK+53Kf/Rf7wXCzRaWFXdwIBLvTbOxI3Iofy7tLQ5FmIGaCokuy9i65leoDsK3Jb1
         vHup+pJUEoS+DZOCrHTg5fJDr1NpU8/R+Ig1RUYXj7GDgRTXdO1bvBdOXfCNqJXcUIMb
         lzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627597; x=1688219597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emM0vnYZP8ovSB9/0L28X7xu1W1tC2o+UTrpcckUn6I=;
        b=CY31pES92B2l8WBq3ocb1nVUa7yUGARnUfJg0s4f8jZDj3miMboTQQe/rA7znpdVfN
         m+OK7qHuq7oSuH+nnlN4VOyWa51ML+u689lxiPzBoqdQ+KAQyY5S97unJBRPoV8YEo6b
         GJ9ABsOG4e/0A6EeICY07XQNCH/tWrkGaGoV7fL2YhXEIJIe2f/9RqmNVgGmpzP4mSAg
         J6CbQW5u4Duc34RCnqiAPlUDjGRmE3eSa/wgZ1HpM6IVwY1l5zpSayy4Xtb994BAZbHj
         HIMynEXA9k8iInj6XzURw5iNjQSc0bcmlg510PzkzmDzUlcHlsY7lKEpPj3O+ERh7TwD
         JdbA==
X-Gm-Message-State: AC+VfDxDEPKWVHQXyZoO0Nfj/DkVWBzbI3DPDrkNw0NTMmoVc7bmqE30
        MvIIwd2raHcFdKqO2lagw/GjrTQtb0x+EYc=
X-Google-Smtp-Source: ACHHUZ6D9pKmfatjre8+3n+W1GuZF8ZhsQLF+BiTz9FLkUqyRuqeWMNbDcq1x6MUBFd9q5UdZjwDyQhhHBy0eaU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:a8e:b0:b1d:5061:98e3 with SMTP
 id cd14-20020a0569020a8e00b00b1d506198e3mr5275183ybb.6.1685627597196; Thu, 01
 Jun 2023 06:53:17 -0700 (PDT)
Date:   Thu,  1 Jun 2023 13:49:41 +0000
In-Reply-To: <20230601134946.3887870-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230601134946.3887870-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601134946.3887870-4-aliceryhl@google.com>
Subject: [PATCH v2 3/8] rust: sync: add `Arc::{from_raw, into_raw}`
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 rust/kernel/lib.rs      |  1 +
 rust/kernel/sync/arc.rs | 42 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7ea777b731e6..ad9142928fb1 100644
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
index a89843cacaad..684be9f73aca 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -24,7 +24,7 @@
 };
 use alloc::boxed::Box;
 use core::{
-    alloc::AllocError,
+    alloc::{AllocError, Layout},
     fmt,
     marker::{PhantomData, Unsize},
     mem::{ManuallyDrop, MaybeUninit},
@@ -212,6 +212,46 @@ unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
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
+        let val_layout = unsafe { Layout::for_value(&*ptr) };
+        // SAFETY: We're computing the layout of a real struct that existed when compiling this
+        // binary, so its layout is not so large that it can trigger arithmetic overflow.
+        let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
+
+        // This preserves the metadata in the pointer, if any.
+        //
+        // Note that `*const T` and `*const ArcInner<T>` have the same metadata as documented at
+        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
+        let metadata = core::ptr::metadata(ptr as *const ArcInner<T>);
+        let ptr = (ptr as *mut u8).wrapping_sub(val_offset) as *mut ();
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
2.41.0.rc0.172.g3f132b7071-goog

