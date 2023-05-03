Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EB06F53FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjECJHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjECJHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6714C21
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f1728c2a57so48890795e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104842; x=1685696842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cH5GZPThZX1LLdPnjlMEvQzzaSHQbdfYQa3aafCtFw=;
        b=Hgz+JsybFVjncw15HasJvie2Dl4VadDcEYJtGAk4kb/RQguZRxQO+WUSHbBzCchQfK
         4fR/4HHzFj7feyZ/Ey1XOlfTNiuid/oK5BCfCTwEDhAS24mdDiPOWkT4Xnon05qvrKsI
         9DROCY4yYimdZfsorqum1Kgn1FKSyFiupk9F01cUByEOnAhbB/Zk8PwTZ8IQQh3Ysld8
         EQ/BMmUi7pFY1YFHuqo9s0suNHftuZROm2snpKuc0maQI6BsY8e6/z20fLheOG/FOaSj
         ck2bzsszlaJfYe3wOeCcoVvxNqXt9pxyYKS7bIBfx+nUkWsDba1tg8Zs6sA0UfeBQnJ9
         LT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104842; x=1685696842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cH5GZPThZX1LLdPnjlMEvQzzaSHQbdfYQa3aafCtFw=;
        b=XzCKfBOjEIIdFies9ongBrzgc+OQUsgM5g89t0OkBPHcr85XYayK5Lf5Zl2KMD1CSL
         ejx2FKftDXv09cSIA3poYOGorc3iR+71R3KbY6u4JTaaXAJ3JT/BW53YTZ6oWynUml6G
         +ZYOxslrG2qKkAcqXmd5KhGA7VKrIQm6H94RY8xHUqdPPF3m/g85DBk1mlwbUqts364b
         acdpdCo87Wme/e3X93d4G3dxTCSSXLoLGQOUtN9LX2p5eM/NGd31fhZAEMLYBjx/+fp6
         1WAXYv2ewDzL+h9Y4rQ2sRphUEiWnVSYDRHDtBNNMTbqnydRbdsNk47odvOJAQKuD+H0
         uStg==
X-Gm-Message-State: AC+VfDzIy8zBVxcQcZRH9KimAJdrRgdTa8JPliQUpP2ZQbyPoxpTjW9h
        ZchWg7IvVtG9esIxO8BREp1a+g==
X-Google-Smtp-Source: ACHHUZ4EBxDh+2FdUjZNnlPIs7Z43merWOWOdSZYBzuMbtFHhqsjGSgkNu/agPTqqGu/gJ3ZmsuWWw==
X-Received: by 2002:a7b:cb85:0:b0:3f1:7136:dd45 with SMTP id m5-20020a7bcb85000000b003f17136dd45mr14187268wmi.30.1683104842308;
        Wed, 03 May 2023 02:07:22 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003f339b2d06fsm1271659wmc.4.2023.05.03.02.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:22 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 06/11] rust: apply cache line padding for `SpinLock`
Date:   Wed,  3 May 2023 11:07:03 +0200
Message-Id: <20230503090708.2524310-7-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

The kernel `struct spinlock` is 4 bytes on x86 when lockdep is not enabled. The
structure is not padded to fit a cache line. The effect of this for `SpinLock`
is that the lock variable and the value protected by the lock will share a cache
line, depending on the alignment requirements of the protected value. Aligning
the lock variable and the protected value to a cache line yields a 20%
performance increase for the Rust null block driver for sequential reads to
memory backed devices at 6 concurrent readers.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/cache_padded.rs       | 33 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs                |  2 ++
 rust/kernel/sync/lock.rs          |  9 ++++++---
 rust/kernel/sync/lock/spinlock.rs | 13 ++++++++----
 4 files changed, 50 insertions(+), 7 deletions(-)
 create mode 100644 rust/kernel/cache_padded.rs

diff --git a/rust/kernel/cache_padded.rs b/rust/kernel/cache_padded.rs
new file mode 100644
index 000000000000..758678e71f50
--- /dev/null
+++ b/rust/kernel/cache_padded.rs
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#[repr(align(64))]
+pub struct CachePadded<T: ?Sized> {
+    value: T,
+}
+
+unsafe impl<T: Send> Send for CachePadded<T> {}
+unsafe impl<T: Sync> Sync for CachePadded<T> {}
+
+impl<T> CachePadded<T> {
+    /// Pads and aligns a value to 64 bytes.
+    #[inline(always)]
+    pub(crate) const fn new(t: T) -> CachePadded<T> {
+        CachePadded::<T> { value: t }
+    }
+}
+
+impl<T: ?Sized> core::ops::Deref for CachePadded<T> {
+    type Target = T;
+
+    #[inline(always)]
+    fn deref(&self) -> &T {
+        &self.value
+    }
+}
+
+impl<T: ?Sized> core::ops::DerefMut for CachePadded<T> {
+    #[inline(always)]
+    fn deref_mut(&mut self) -> &mut T {
+        &mut self.value
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a0bd0b0e2aef..426e2dea0da6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -37,6 +37,7 @@ extern crate self as kernel;
 mod allocator;
 pub mod block;
 mod build_assert;
+mod cache_padded;
 pub mod error;
 pub mod init;
 pub mod ioctl;
@@ -56,6 +57,7 @@ pub mod types;
 
 #[doc(hidden)]
 pub use bindings;
+pub(crate) use cache_padded::CachePadded;
 pub use macros;
 pub use uapi;
 
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index a2216325632d..1c584b1df30d 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,7 +6,9 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
 use super::LockClassKey;
-use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
+use crate::{
+    bindings, init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard, CachePadded,
+};
 use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
 use macros::pin_data;
 
@@ -87,7 +89,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
     _pin: PhantomPinned,
 
     /// The data protected by the lock.
-    pub(crate) data: UnsafeCell<T>,
+    pub(crate) data: CachePadded<UnsafeCell<T>>,
 }
 
 // SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
@@ -102,7 +104,7 @@ impl<T, B: Backend> Lock<T, B> {
     #[allow(clippy::new_ret_no_self)]
     pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
         pin_init!(Self {
-            data: UnsafeCell::new(t),
+            data: CachePadded::new(UnsafeCell::new(t)),
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
             // static lifetimes so they live indefinitely.
@@ -115,6 +117,7 @@ impl<T, B: Backend> Lock<T, B> {
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {
     /// Acquires the lock and gives the caller access to the data protected by it.
+    #[inline(always)]
     pub fn lock(&self) -> Guard<'_, T, B> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 979b56464a4e..e39142a8148c 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -4,7 +4,10 @@
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
 
+use core::ops::DerefMut;
+
 use crate::bindings;
+use crate::CachePadded;
 
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
 ///
@@ -90,7 +93,7 @@ pub struct SpinLockBackend;
 // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
 // default implementation that always calls the same locking method.
 unsafe impl super::Backend for SpinLockBackend {
-    type State = bindings::spinlock_t;
+    type State = CachePadded<bindings::spinlock_t>;
     type GuardState = ();
 
     unsafe fn init(
@@ -100,18 +103,20 @@ unsafe impl super::Backend for SpinLockBackend {
     ) {
         // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
         // `key` are valid for read indefinitely.
-        unsafe { bindings::__spin_lock_init(ptr, name, key) }
+        unsafe { bindings::__spin_lock_init((&mut *ptr).deref_mut(), name, key) }
     }
 
+    #[inline(always)]
     unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
         // memory, and that it has been initialised before.
-        unsafe { bindings::spin_lock(ptr) }
+        unsafe { bindings::spin_lock((&mut *ptr).deref_mut()) }
     }
 
+    #[inline(always)]
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
         // caller is the owner of the mutex.
-        unsafe { bindings::spin_unlock(ptr) }
+        unsafe { bindings::spin_unlock((&mut *ptr).deref_mut()) }
     }
 }
-- 
2.40.0

