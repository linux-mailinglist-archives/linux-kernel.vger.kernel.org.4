Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EB86DF4D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjDLMPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjDLMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:15:01 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC2130C8;
        Wed, 12 Apr 2023 05:14:53 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1842df7cb53so13536922fac.10;
        Wed, 12 Apr 2023 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681301692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uiqDAcpDbm3LWcuzi55KjMvH2NOjaDMDvdDPxCg5sgo=;
        b=mWc/QZ1jnDB/TFevIji1BKcQT0kHUiw+14j0FjmVrbwRQcU/szbV+jYRbblWvfEELt
         pwjgUUkZh5TJGOoi02zC6j+qMOhYFhOBKj5kUZAdQ3sPbYnXl5Mbi5yquhyx6W62E80R
         xtEYlC4LwnJzLn2cZ6ZvzeaQ2+dJEcDTrfLM81OvuEs6ny+FgZmOidDVrR3nQMHccnne
         Uu61Fh8BPr9UfgX5nuaVBE9DuCr0fvKkce3/0O2XctwntA+xijobgXgKxa/RxZK7pssd
         LRNtlBF4vGaihttrvNYYZcfqW2zi1q7XbfSsKRnOgUNhL3eTaLswnu3Nrqw7vhKUQufs
         e7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681301692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiqDAcpDbm3LWcuzi55KjMvH2NOjaDMDvdDPxCg5sgo=;
        b=OFfHXCUlMnMGZAnXGk1fbQQoYeHZaX0kPv4cprInAbz2ZJ/7Gbx4yjKNpNo2MT3T+O
         YnAWPb2LCb5WKxEKh3U25GAGjUnNh4dSJzHFBGMVqTY/+4vvO2qym2Xx1tepXrtuAGrH
         33E5SxMUBgoaMqWzKGtvsQfIJOHM4cpXp/YSvLTqQtkRV4PzB8sGQXRPY2QoQN1FoD+r
         aTQqHjsUWHuXejYrMav8yNZ2Rp1YsRd54A7Vw+bcGrjAORumg9fRTnSKPS1/47m9GBeX
         mf1t3+et67N2QUaUiRon1tfJScLg8+g7iF3Syb+494ON1IqqWvxTCMw6g9DCToiyOmiO
         eS4Q==
X-Gm-Message-State: AAQBX9eLZIjKV/qQ4syDDRH/zV2e+yAX30vbWlfoDfi8Yg3v9GB7+qrI
        5ginI8rVnwvmZyOjZ0FOWuUw8SUotgQ=
X-Google-Smtp-Source: AKy350YkvsrWoWA1hmR6zPHbpWFsEdnVvSNMvB4saWDLEiKdana2r5Tv4kG59+50tW8UkW66BHrRhA==
X-Received: by 2002:a05:6870:332a:b0:185:ef7d:429f with SMTP id x42-20020a056870332a00b00185ef7d429fmr1331931oae.57.1681301692390;
        Wed, 12 Apr 2023 05:14:52 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id x17-20020a4a97d1000000b00541cb3cf2d2sm3681937ooi.13.2023.04.12.05.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:14:52 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4.1] rust: lock: add `Guard::do_unlocked`
Date:   Wed, 12 Apr 2023 09:14:31 -0300
Message-Id: <20230412121431.41627-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: No changes
v3 -> v4: No changes
v4 -> v4.1:
- Use ScopeGuard to relock
- Fix parameter name in `relock` documentation

 rust/kernel/sync/lock.rs          | 30 +++++++++++++++++++++++++++++-
 rust/kernel/sync/lock/spinlock.rs | 17 +++++++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 819b8ea5ba2b..ff2c2a0e2830 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,7 +6,7 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
 use super::LockClassKey;
-use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
+use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
 use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
 use macros::pin_data;
 
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
+    /// Callers must ensure that `guard_state` comes from a previous call to [`Backend::lock`] (or
+    /// variant) that has been unlocked with [`Backend::unlock`] and will be relocked now.
+    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
+        // SAFETY: The safety requirements ensure that the lock is initialised.
+        *guard_state = unsafe { Self::lock(ptr) };
+    }
 }
 
 /// The "backend" of a lock that supports the irq-save variant.
@@ -164,6 +178,20 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
 // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
 unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
 
+impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
+    #[allow(dead_code)]
+    pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
+        // SAFETY: The caller owns the lock, so it is safe to unlock it.
+        unsafe { B::unlock(self.lock.state.get(), &self.state) };
+
+        // SAFETY: The lock was just unlocked above and is being relocked now.
+        let _relock =
+            ScopeGuard::new(|| unsafe { B::relock(self.lock.state.get(), &mut self.state) });
+
+        cb();
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

