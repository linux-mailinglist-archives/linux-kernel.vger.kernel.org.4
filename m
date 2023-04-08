Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F004C6DB962
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDHHyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDHHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:54:00 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0232903E;
        Sat,  8 Apr 2023 00:53:58 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1842cddca49so877298fac.1;
        Sat, 08 Apr 2023 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ty2c9HDR/6nIOmkOFdir3f2Vau2dO37PR6ULzCuywyo=;
        b=mQD2FNQM14xtdowH9iz3u9KrxtWYxuVEiLHuuONTmMgyyrzvr0SECC32EA1W0hXf0A
         Q0aJQ9U0KyozWxckkzcvoIfVqnlAmirDs9ML1dihRP7QD44WRk7u/GaBF1R4GWaf31X3
         rIpq3hGKjCh6YP6XhWpao8Or9mRlwtpbKTs2Q/t3Y8DNPYD49G4EDQQZ75U6ZRghYuCD
         kHchuY27fpbv4NVn47Zu98ou0tcbDmJqxmgJBLEfFoHzGNa1Fst2IBwoqcwOYgYJ7yvH
         zMHeEUNyQ2i8XLWjtesvoy5BIH6M6Y8/NXoFWdaI9wbEWkT7QWy8Ok01C1e7eulWLVkD
         v9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ty2c9HDR/6nIOmkOFdir3f2Vau2dO37PR6ULzCuywyo=;
        b=uh8L0dolSCRkMGK/NImylADgNkcLg+JBnLGAiZ8Efj2vkN8imi/754vH64rWOMljNM
         a901NVkcwqI4eVTnnNi5qNbWgf6OrtACT1TVZ6i9H47HQrpdVng/AhAJVI3m8zQVhraD
         qmis00EMN0fGyB1R5RG+96WBf6Ct40cGwakKPAAaYcHYm57ZX+nJEM1743vjgEszWtHF
         Tnw4WHoXQSQ2iarLthObqpB2pKyjZaQLNPGvn6XbWJ9KcL9P2h6e7L5afsVKla5i/E/L
         hKI3BQQCXyR2IexWj7ZQmTT/C88ZtGkcu+129sPLbHIVWg5lmPJ045q1wqN9JyuEnXKn
         PfyQ==
X-Gm-Message-State: AAQBX9cA17/SfMzLZPnBx/tEuhC1ajs8r1gBh7U2Gaq6XdIEhVMS/E1g
        Fe13FvU4CW6dYhSPBh4WhpxXSNyo1xY=
X-Google-Smtp-Source: AKy350aFdN0oh+SZxdB/0HKnVIzr6GNhny+/C0cFuNUq6/AY3ZWuDkT28hWGNp0scm9wOuTw00smPQ==
X-Received: by 2002:a05:6870:a793:b0:184:286b:8abc with SMTP id x19-20020a056870a79300b00184286b8abcmr850876oao.11.1680940437175;
        Sat, 08 Apr 2023 00:53:57 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:53:56 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v3 02/13] rust: sync: introduce `Lock` and `Guard`
Date:   Sat,  8 Apr 2023 04:53:29 -0300
Message-Id: <20230408075340.25237-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230408075340.25237-1-wedsonaf@gmail.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
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
v1 -> v2: No changes
v2 -> v3: Use new Opaque::ffi_init from Benno's series

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
index 000000000000..3fa4eefde740
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

