Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C756CFA56
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjC3Emp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjC3EmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:42:02 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C966EA1;
        Wed, 29 Mar 2023 21:41:30 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17ab3a48158so18578382fac.1;
        Wed, 29 Mar 2023 21:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k9eisks9FcQh4zOi/rvuQMJbaN5Xl9dCC+VIC8uz5Y=;
        b=AP2q8+v38rA/2X+C0rrBDvQNOxnLbHu6WgNvw7sEmc7k/b8sHY2cCCGjLjRmYSqvyp
         a/NOcziUWUiGlDINrXyFR84YfH1G/ZHwzznNGTqq/64LFlg6qEbABmHoNpO3kYAYX2gQ
         iHZkDrg7+Mjrtf02NO6WzuSa3WjROyWYPX0sDkDC0PfFDnnJSe8ayYjwhPRtUCB0581A
         1aQC8a910pwVPeO1cSPcJBD9hI/Lo3XRf8MVwQ2y2W5GnFm1fI8LGsrQeNC9oWejMJ1m
         Hil1MxYd1yJxzG/izFjy1Q63ucH/f4MbiqW5ll2nGbOgd+9iS67hREQCdL4/PxMM3fVP
         IjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k9eisks9FcQh4zOi/rvuQMJbaN5Xl9dCC+VIC8uz5Y=;
        b=q7GabMEnjZGIu6goyLGpZnhbkUBm29G2LFAH1sZeQYtNDj54ZVu3g60zWZVDz0C2mW
         7lq4+VhN9P9DvivANvePoJAjqBqQZfdSLtWEdHCb6M7ml3IDyOk5Eet7K/OlxP3vouAl
         6KMY41HnsEdCBsDkLgTWAp2eo1wcYJjTqcltnNyKeJHuGnTMp9+wpA9J9fcVROerl12O
         a2OtcKbNldCXBrdCtAxDquzjMcmN5JgrkzPsIAhJMIuV1aDcKjDkRni52Wi0Pl99DBgw
         lHEUkIZIjK7CeS9aiqbyr76paXOIZMc4+KU9wBGDzbTKVx7T4od8k16el4hlQomrx5u0
         yhUA==
X-Gm-Message-State: AO0yUKVGT8Vgd2U7EwmI3r+5fBqV5ltLnWu4EizGoh6YMsc6HAvfirlN
        nt+Oymh1erMYVe8GKCUYZ5vpmbuyKUxa4Q==
X-Google-Smtp-Source: AKy350aqrUt6gJXDu1j/XHDW94IdsyjAhsh6wikNTQjYOu2Rpze1Vb0rKc8F0VO5w2Ad2ugnzJsaHQ==
X-Received: by 2002:a05:6870:32cd:b0:177:ac2e:fc5 with SMTP id r13-20020a05687032cd00b00177ac2e0fc5mr14654022oac.50.1680151288678;
        Wed, 29 Mar 2023 21:41:28 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:41:28 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 11/13] rust: lock: add `Guard::do_unlocked`
Date:   Thu, 30 Mar 2023 01:39:52 -0300
Message-Id: <20230330043954.562237-11-wedsonaf@gmail.com>
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

It releases the lock, executes some function provided by the caller,
then reacquires the lock. This is preparation for the implementation of
condvars, which will sleep after between unlocking and relocking.

We need an explicit `relock` method for primitives like `SpinLock` that
have an irqsave variant: we use the guard state to determine if the lock
was originally acquired with the regular `lock` function or
`lock_irqsave`.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/sync/lock.rs          | 25 +++++++++++++++++++++++++
 rust/kernel/sync/lock/spinlock.rs | 17 +++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 491446c3a074..ae20277c39c8 100644
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
@@ -162,6 +176,17 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
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

