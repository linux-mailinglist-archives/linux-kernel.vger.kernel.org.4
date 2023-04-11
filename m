Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298826DD1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDKFqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDKFqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A50C1;
        Mon, 10 Apr 2023 22:46:01 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bh10so4801020oib.1;
        Mon, 10 Apr 2023 22:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8+XEPg91zVw8lsPU7tB81XapT1ATQXK+ygjS31ezwI=;
        b=HiI60g+TR7h+Zk491FJ4+7OI5HacUOvConv8u+tLNyBDwI8sAaFdGRbZHHFjDAl59/
         bzcZnPC8oPNhN0WLK2m/FoCSOjHUXvOOPQLqCuMzeKnM/hLSBtdhkvF+U2ztnKtnRiG4
         YAlRW3wJFD19edadU9aDF3E3PGn+ICAjDciAi5U1hJg08xD6r/cobj/bzEQ6JS43tMUD
         WKwIqo9lC71qIdd4WUV+QSuy9YhdCNSAKR64CSlG/U78Kj0w4NjATXVUQL+LtNOxnonP
         pzYbenIusDdITw2e+M06XOOutaEox0yb/s/e73gVHHJXic+rULbsfYNpHCaWT5GoNYQF
         CIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8+XEPg91zVw8lsPU7tB81XapT1ATQXK+ygjS31ezwI=;
        b=CuVcu891OMiqp7fMluBJukg5MjgVzXd60QObkLNaf6G4PVOR9fmHFNQx5799DpQjvJ
         ilk2w3WZXMlIZbgQ3ws/ItPcj6GdccNQ/aG7ZlDoNEBh5ZlS2peDFZC3FmSSDU2Ka/gE
         P/NDUGJ3xw4T/k8ZrJDatdqzwKh4mCfXfxYaASsS9ULLh8Lve76s8SdAaIYOV8sRkAPE
         EXWY2fH49vKn7a4LA+0VAbjEMSJ4waJgz0APEWjJLM2XKcsQwh4BtJ69RPX8ONIL5/47
         AA8h8mTGNrtNcJdVqN6PYIdGrJ5dXiKnF+k6cUI3qDDYS2w893Ny7hCW+C0FXUcBFkYb
         SX1g==
X-Gm-Message-State: AAQBX9e91cAINyKt7kytrqkUSdiRTW1pZl0N3rh8BTcBIMVXIok8JbCz
        xiAWR3TlC4hsEjAZ0gUGDuAqr299Wsc=
X-Google-Smtp-Source: AKy350aiTcdHv9lmy0IesZMyVVxpqTR3QN1T5Jbun4X5UsIRnl4YUrNfn23On+Ccdcl/2vqseFn1uA==
X-Received: by 2002:a05:6808:3087:b0:389:791e:1401 with SMTP id bl7-20020a056808308700b00389791e1401mr7300695oib.7.1681191960655;
        Mon, 10 Apr 2023 22:46:00 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:46:00 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 02/13] rust: sync: introduce `Lock` and `Guard`
Date:   Tue, 11 Apr 2023 02:45:32 -0300
Message-Id: <20230411054543.21278-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411054543.21278-1-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
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

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: Use new Opaque::ffi_init from Benno's series
v3 -> v4: Fixed name of parameter in Lock comment

 rust/kernel/sync.rs      |   2 +-
 rust/kernel/sync/lock.rs | 162 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/lock.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 541d235ffbeb..81b0998eaa18 100644
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
index 000000000000..1a8ecccf4f24
--- /dev/null
+++ b/rust/kernel/sync/lock.rs
@@ -0,0 +1,162 @@
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
+/// specified as the generic parameter `B`.
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
+            // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
+            // static lifetimes so they live indefinitely.
+            state <- Opaque::ffi_init(|slot| unsafe {
+                B::init(slot, name.as_char_ptr(), key.as_ptr())
+            }),
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

