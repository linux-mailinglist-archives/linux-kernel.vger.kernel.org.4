Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806DE6DB96A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjDHHzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjDHHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:55:01 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C7BFF1E;
        Sat,  8 Apr 2023 00:54:39 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id f7-20020a4ab647000000b0054101f316c7so3442244ooo.13;
        Sat, 08 Apr 2023 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ar/TRSfKXBqi4OsSPUjagB6ioA9d9TG19jv5XSvWgTg=;
        b=fwg17W4i6+q6/L6fMc/sTiXgeft5wvoFHVT8R28tG7H7n957FzEW4I4K6Jf8JLG7d5
         NaKIDVFrK1DybXwtg2k0XT1ZG1L6hMlfgoJrfYP0wFVztQIndmUMH/616UdvvhSVUpnn
         /6GTdcfLM9f/bNz9Jt15lXVKdkEpvh5I/daYgn3CNAnduzvSNcxbzYTaOEY5VR72uxKt
         sXhjgK9Q/7ZQxNAPWq5a7ay0DmYzM39CfDYqNUTtkLMDRDQzCKeKjfewce6LTq07ZgfP
         SXlflhJIHbkKU1DTUcuNlkA0sM1kjIfVVwvMYH4eSd+Llq1UQ90AkxqkQRbWR8KhQmOY
         8a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ar/TRSfKXBqi4OsSPUjagB6ioA9d9TG19jv5XSvWgTg=;
        b=N7F+rbe1L87cwB3SV6pM+IxAXnEDIYy4tEa7VV9nNmVCHh0ZXNxhV3oB5aaPrBt7VR
         IdQHeYot5NnLlqGLYG/PgOyEfduNeoaY0VMmY8DnNq/8cI5ia+gV6k1snmjzdNQZTzPM
         eA/hf67NcbgfNKDD12bFNbdhG00DRfOEUA0jvhgBTozmcZOGgBFHb0oCPQcdEL/CubZJ
         9C+gxx5WklRs5fkmrtO+5BSRdDbI0gT7W7h6rfXUl6JrW1bCtODcfSQ8CtCIZyODlL4a
         wWa5/sYAE1dZ8oKXuKGtsgbGmw9jwJl66qGRU/Qt9lm3PNiezJxhJ3uZVkFJKw/0jvu6
         h4fQ==
X-Gm-Message-State: AAQBX9cOLdp6XtxEclq+pmfYk1zViD5cY5trXwyogW0idgGn/VAXr0XX
        X1z3StP4FeP7G4kyMgZQkYCD3hGqRVY=
X-Google-Smtp-Source: AKy350aiq/xAQmudPDIUGZOCe9tktHLW4SnbZB+frUnnnsC4d37G+Tg1uRwSdID5pkdPCUtTDtmXFg==
X-Received: by 2002:a4a:4f0d:0:b0:53b:6112:3b16 with SMTP id c13-20020a4a4f0d000000b0053b61123b16mr2148567oob.9.1680940466100;
        Sat, 08 Apr 2023 00:54:26 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:54:25 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v3 11/13] rust: lock: add `Guard::do_unlocked`
Date:   Sat,  8 Apr 2023 04:53:38 -0300
Message-Id: <20230408075340.25237-11-wedsonaf@gmail.com>
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

It releases the lock, executes some function provided by the caller,
then reacquires the lock. This is preparation for the implementation of
condvars, which will sleep after between unlocking and relocking.

We need an explicit `relock` method for primitives like `SpinLock` that
have an irqsave variant: we use the guard state to determine if the lock
was originally acquired with the regular `lock` function or
`lock_irqsave`.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: No changes

 rust/kernel/sync/lock.rs          | 25 +++++++++++++++++++++++++
 rust/kernel/sync/lock/spinlock.rs | 17 +++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 690429561f0e..a2c654ec5bd3 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -22,6 +22,9 @@ pub mod spinlock;
 ///
 /// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
 /// is owned, that is, between calls to `lock` and `unlock`.
+/// - Implementers must also ensure that `relock` uses the same locking method as the original
+/// lock operation. For example, it should disable interrupts if [`IrqSaveBackend::lock_irqsave`]
+/// is used.
 pub unsafe trait Backend {
     /// The state required by the lock.
     type State;
@@ -55,6 +58,17 @@ pub unsafe trait Backend {
     ///
     /// It must only be called by the current owner of the lock.
     unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
+
+    /// Reacquires the lock, making the caller its owner.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `state` comes from a previous call to [`Backend::lock`] (or
+    /// variant) that has been unlocked with [`Backend::unlock`] and will be relocked now.
+    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
+        // SAFETY: The safety requirements ensure that the lock is initialised.
+        *guard_state = unsafe { Self::lock(ptr) };
+    }
 }
 
 /// The "backend" of a lock that supports the irq-save variant.
@@ -164,6 +178,17 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
 // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
 unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
 
+impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
+    #[allow(dead_code)]
+    pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
+        // SAFETY: The caller owns the lock, so it is safe to unlock it.
+        unsafe { B::unlock(self.lock.state.get(), &self.state) };
+        cb();
+        // SAFETY: The lock was just unlocked above and is being relocked now.
+        unsafe { B::relock(self.lock.state.get(), &mut self.state) };
+    }
+}
+
 impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
     type Target = T;
 
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 34dec09a97c0..e2a2f68e6d93 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -4,6 +4,7 @@
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
 
+use super::IrqSaveBackend;
 use crate::bindings;
 
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
@@ -95,7 +96,8 @@ pub type SpinLock<T> = super::Lock<T, SpinLockBackend>;
 /// A kernel `spinlock_t` lock backend.
 pub struct SpinLockBackend;
 
-// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
+// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
+// same scheme as `unlock` to figure out which locking method was used originally.
 unsafe impl super::Backend for SpinLockBackend {
     type State = bindings::spinlock_t;
     type GuardState = Option<core::ffi::c_ulong>;
@@ -127,13 +129,24 @@ unsafe impl super::Backend for SpinLockBackend {
             None => unsafe { bindings::spin_unlock(ptr) },
         }
     }
+
+    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
+        let _ = match guard_state {
+            // SAFETY: The safety requiments of this function ensure that `ptr` has been
+            // initialised.
+            None => unsafe { Self::lock(ptr) },
+            // SAFETY: The safety requiments of this function ensure that `ptr` has been
+            // initialised.
+            Some(_) => unsafe { Self::lock_irqsave(ptr) },
+        };
+    }
 }
 
 // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
 // variant of the C lock acquisition functions to disable interrupts and retrieve the original
 // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
 // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
-unsafe impl super::IrqSaveBackend for SpinLockBackend {
+unsafe impl IrqSaveBackend for SpinLockBackend {
     unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
         // memory, and that it has been initialised before.
-- 
2.34.1

