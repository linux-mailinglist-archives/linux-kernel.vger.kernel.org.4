Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557786CFA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjC3ElK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjC3ElC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:41:02 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5F35A2;
        Wed, 29 Mar 2023 21:40:50 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-177b78067ffso18553689fac.7;
        Wed, 29 Mar 2023 21:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10KpFBgmcYjxGutew/HixzYci2huFC433d/siDnSI3w=;
        b=p3L6KaFwzj5ReZbQLFB/rh0O4XgPbhVbtIZMNsJ+R+HzG4sy+260NgHjyQk3e6uy48
         fx4XHfoTtNqB6V0FS4d4Xs/UuXm5Nrtg16C4F6No21uHUbm2lxix3+k1kQ+dWrXfoxTu
         E/QoxxtRmQly/r6Tbz0zTk2Bp0KnNmfp7hK743WObspfwWIVeJb5CZgMN+O2yq8GSyNd
         0ZPMOyzzYAZhPQ5fp2yZIVVedVt84oCEi79S/tpa0aMNOLt1bkQVJjzE1xYo679upaGn
         zNPFAqq3mNklonGw0OhQp6agTMFn8bapk92w9Y5kB8Zp5Gr7heErliGEELxorzn/CzCA
         PfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10KpFBgmcYjxGutew/HixzYci2huFC433d/siDnSI3w=;
        b=XNeolKMhEy+IyVulUVzw1xJ8ak8TrXn6SqSWBbmq+kNVv3gv7Bnrsab3yT2oYIJfbQ
         BoaqZkCryhiYFNdiTCsD+Bc9u2V+uhMkUVc751hiIapgSQ31S52HqjukKSBfkESN1eTK
         /IBXJshjZpgDANjjG5MEgyYVpsZnbi/Z+fx/yermAF7r1rPtwdSVb0q7f26WWsLwtSk9
         J1YsWhtgmYiNo9HG1Yf7WvnCx59zz4s0JZ4C7t88NkgQwOe8OSQZf4SRUm3DN2q+RBca
         q9J0Xa5BFoa57m0zKU5ehw0y3UFZTWuhWDwU5N7/spAqnOMbfDC/W6O8/+3bOX8yaDDF
         CVwQ==
X-Gm-Message-State: AAQBX9f2aO+lsXfuAqQN51dXNHg18QiRlBQcANNnm3znloIhXeckp5PP
        Ms12igmoP6/D3jUA9VnLuCSBTYMgr+Nrdw==
X-Google-Smtp-Source: AK7set+wsaIz3Ajv7Qvy1qKYDIQn8jKhLl2Av+vPbvtRYUiyQOO+4iwM3MlprXNzXXYn29SOwilHcA==
X-Received: by 2002:a05:6870:24a1:b0:177:9ede:bcc6 with SMTP id s33-20020a05687024a100b001779edebcc6mr13580475oaq.14.1680151249348;
        Wed, 29 Mar 2023 21:40:49 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:40:49 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 02/13] rust: sync: introduce `Lock` and `Guard`
Date:   Thu, 30 Mar 2023 01:39:43 -0300
Message-Id: <20230330043954.562237-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330043954.562237-1-wedsonaf@gmail.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

They are generic Rust implementations of a lock and a lock guard that
contain code that is common to all locks. Different backends will be
introduced in subsequent commits.

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/sync.rs      |   2 +-
 rust/kernel/sync/lock.rs | 160 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/lock.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 84a4b560828c..bf088b324af4 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -8,6 +8,7 @@
 use crate::types::Opaque;
 
 mod arc;
+pub mod lock;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 
@@ -25,7 +26,6 @@ impl LockClassKey {
         Self(Opaque::uninit())
     }
 
-    #[allow(dead_code)]
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
         self.0.get()
     }
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
new file mode 100644
index 000000000000..f5614bed2a78
--- /dev/null
+++ b/rust/kernel/sync/lock.rs
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic kernel lock and guard.
+//!
+//! It contains a generic Rust lock and guard that allow for different backends (e.g., mutexes,
+//! spinlocks, raw spinlocks) to be provided with minimal effort.
+
+use super::LockClassKey;
+use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
+use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use macros::pin_data;
+
+/// The "backend" of a lock.
+///
+/// It is the actual implementation of the lock, without the need to repeat patterns used in all
+/// locks.
+///
+/// # Safety
+///
+/// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
+/// is owned, that is, between calls to `lock` and `unlock`.
+pub unsafe trait Backend {
+    /// The state required by the lock.
+    type State;
+
+    /// The state required to be kept between lock and unlock.
+    type GuardState;
+
+    /// Initialises the lock.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be valid for write for the duration of the call, while `name` and `key` must
+    /// remain valid for read indefinitely.
+    unsafe fn init(
+        ptr: *mut Self::State,
+        name: *const core::ffi::c_char,
+        key: *mut bindings::lock_class_key,
+    );
+
+    /// Acquires the lock, making the caller its owner.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that [`Backend::init`] has been previously called.
+    #[must_use]
+    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState;
+
+    /// Releases the lock, giving up its ownership.
+    ///
+    /// # Safety
+    ///
+    /// It must only be called by the current owner of the lock.
+    unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
+}
+
+/// A mutual exclusion primitive.
+///
+/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock banckend
+/// specified as the generic parameter `T`.
+#[pin_data]
+pub struct Lock<T: ?Sized, B: Backend> {
+    /// The kernel lock object.
+    #[pin]
+    state: Opaque<B::State>,
+
+    /// Some locks are known to be self-referential (e.g., mutexes), while others are architecture
+    /// or config defined (e.g., spinlocks). So we conservatively require them to be pinned in case
+    /// some architecture uses self-references now or in the future.
+    #[pin]
+    _pin: PhantomPinned,
+
+    /// The data protected by the lock.
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
+unsafe impl<T: ?Sized + Send, B: Backend> Send for Lock<T, B> {}
+
+// SAFETY: `Lock` serialises the interior mutability it provides, so it is `Sync` as long as the
+// data it protects is `Send`.
+unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
+
+impl<T, B: Backend> Lock<T, B> {
+    /// Constructs a new lock initialiser.
+    #[allow(clippy::new_ret_no_self)]
+    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+        pin_init!(Self {
+            data: UnsafeCell::new(t),
+            _pin: PhantomPinned,
+            // SAFETY: `B::init` initialises the lock state, and both `name` and `key` have static
+            // lifetimes so they live indefinitely.
+            state <- unsafe { Opaque::manual_init2(B::init, name.as_char_ptr(), key.as_ptr()) },
+        })
+    }
+}
+
+impl<T: ?Sized, B: Backend> Lock<T, B> {
+    /// Acquires the lock and gives the caller access to the data protected by it.
+    pub fn lock(&self) -> Guard<'_, T, B> {
+        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
+        // that `init` was called.
+        let state = unsafe { B::lock(self.state.get()) };
+        // SAFETY: The lock was just acquired.
+        unsafe { Guard::new(self, state) }
+    }
+}
+
+/// A lock guard.
+///
+/// Allows mutual exclusion primitives that implement the `Backend` trait to automatically unlock
+/// when a guard goes out of scope. It also provides a safe and convenient way to access the data
+/// protected by the lock.
+#[must_use = "the lock unlocks immediately when the guard is unused"]
+pub struct Guard<'a, T: ?Sized, B: Backend> {
+    pub(crate) lock: &'a Lock<T, B>,
+    pub(crate) state: B::GuardState,
+    _not_send: PhantomData<*mut ()>,
+}
+
+// SAFETY: `Guard` is sync when the data protected by the lock is also sync.
+unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
+
+impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
+        unsafe { &*self.lock.data.get() }
+    }
+}
+
+impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
+        unsafe { &mut *self.lock.data.get() }
+    }
+}
+
+impl<T: ?Sized, B: Backend> Drop for Guard<'_, T, B> {
+    fn drop(&mut self) {
+        // SAFETY: The caller owns the lock, so it is safe to unlock it.
+        unsafe { B::unlock(self.lock.state.get(), &self.state) };
+    }
+}
+
+impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
+    /// Constructs a new immutable lock guard.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that it owns the lock.
+    pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
+        Self {
+            lock,
+            state,
+            _not_send: PhantomData,
+        }
+    }
+}
-- 
2.34.1

