Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19A56DD206
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjDKFrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjDKFqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:55 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF772359F;
        Mon, 10 Apr 2023 22:46:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bf5so4751729oib.8;
        Mon, 10 Apr 2023 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaXy46x7GR5XrSzVHQC7SvsfS2kUsSvNQ00pK7ZlJKE=;
        b=UJLg+Vs59cCQxvgXFa0R/s2/3v6HTFoRsrG7JRs6qN2ByOGN0VWBkXMrs7MXStX3Yb
         z+swJtuQTgsm8GL26/3D6foDwZlhExpvKItRwG/WjKwjr7O/aenzMS/Q3XEuxQL/aDM9
         m0VB2YmR16oQUIafVzMct0GKJUuMheRK800QUR1ZSrBW+P7iAejmOjlWuOl2qMnVMzT6
         qBQZ8Dc2M5twSX3EDsjvFUl6MaL2ZAkmAOSk0R8b1k3HvGB7H3nPrpYDsEg86rXq//9z
         zDlU+Yuh/rEEWTpaD5KyqzrDxblHI6yVm1ybOz2zhpEteqxF2StSb7axrNuBtwdB+1H+
         kdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaXy46x7GR5XrSzVHQC7SvsfS2kUsSvNQ00pK7ZlJKE=;
        b=Y0n8I0aXDFGq558+vH6xm+yzRhfCHlDRMfM0Jo/yzK17OJAb9JuOXZXlJ3gNo3JwgP
         0Hufk3GTvKgvZHDNh0id+Ugk2bw2GZ2sUUa2maPRn5hdIyHrEjunkLw3qebePBONGlJi
         OjLw+Y2X7vskDd6fPBajyluLi1DlTwG5G8cTx8GyoL9Y4CUA4XS8Us3Qk/D9bPNaHUUF
         qRJJYWAYJpTAqWXdRvnqnuB3wU7SS+8TmV5lSVz1ueyA2iEvjyZQf0MqOcVZzjcro9Ne
         Pk7OP34jm3gfMOjp811xb/hUnU1DLIeSU7v7vzsDSerGQe27yRjlPQuTcRRb3qaM/wyL
         5dYA==
X-Gm-Message-State: AAQBX9cR4u0Gp/gsY4Wl9SC0J/gsZ4+KWB13c0k+TwHM1gNJeG83FeB8
        ey+1TVNoP9fLpIjuLcoLc6vvwqLUah4=
X-Google-Smtp-Source: AKy350ZEv7gym/Mhpk2f3yJACMDsFI1Qp/rJ5BUrBsjuC6O/+8HfX0u7NkpPMG04P2i3Wqc+zv789A==
X-Received: by 2002:a05:6808:4092:b0:389:607:f41f with SMTP id db18-20020a056808409200b003890607f41fmr643215oib.4.1681191992528;
        Mon, 10 Apr 2023 22:46:32 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:46:32 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 11/13] rust: lock: add `Guard::do_unlocked`
Date:   Tue, 11 Apr 2023 02:45:41 -0300
Message-Id: <20230411054543.21278-11-wedsonaf@gmail.com>
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

 rust/kernel/sync/lock.rs          | 25 +++++++++++++++++++++++++
 rust/kernel/sync/lock/spinlock.rs | 17 +++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 819b8ea5ba2b..cde57756795f 100644
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

