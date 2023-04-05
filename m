Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9D16D8544
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjDERwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDERwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:52:33 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F156E80;
        Wed,  5 Apr 2023 10:52:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id l18so27219028oic.13;
        Wed, 05 Apr 2023 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thG4ce95lzXfSBdJf4lBPCfVabPBzlVobrhWMpvttHs=;
        b=qNK/SIs8M2jkyqqxmQ/DCMtwbI3QSDnkF3limYjePtyO/x9fvjArvFmaUqnP8K82al
         J59iGA8rz000+AE2sTr833F6LQZCsP0AU+WDnCa6bRmIyXxGU+TUqu7B5cktKmX9CLWI
         +AjdbgvgkVxM8FeffK+8F9+jvCy4h/93U3OXXQT9ZiIIc8DBqaAHWfBS6Dj/c6VELm7z
         K7GSBgA7PBQiBmpRdHnI2Yy624mTwD3fM/yoTGvOIRhLeX3likGXqsol34v6OmkDik4a
         2qOFM/9dzHZZ696M/gszpspo/GZ4oA3yM+17Vzm697Ao3O+YpZtZ33YLeFprLtfhI5sI
         F92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thG4ce95lzXfSBdJf4lBPCfVabPBzlVobrhWMpvttHs=;
        b=QU3jkvQruUTq8RLwPpFHEhFpV5iMbK1Lj8VH7foSRehvx4WCqTfq53oKkvhLOWu9ep
         RO8bqllkRleVtP2rkvLAIW+vxCWyHOA3GZ9JfRMPWhtaFEle9POSyHTzpatLnBIuTevb
         5cgbaHVkfpPgFEtVDHCKp9bkno+CiOjRIEfJygsQfgXKPwN8udlMAZ99E5SwT16Wl3+V
         SQ+jI6Lcghhq75Uvx2Ta2KfQs2XG90Cw6WUrWFuoF2ppzoCfSwiRDbTxYi9oIc3k9S1V
         6mUXuYZsEAzH7i9JiC+rouzWQanfpDRwvEMWjRVpJqc2AlgBZNXy15/yNNHl/PSxvULZ
         PcxQ==
X-Gm-Message-State: AAQBX9cr7OiUSP6bM0Q0DMtBY2eMe3tyWbQ5kwvw32BkHeRNOcw/0HsB
        G0Uz9oMdmYcle8YQ3WCZ1Ei3WNZ7pWYIIQ==
X-Google-Smtp-Source: AKy350ZZmx8T1H6Tp7ZfNqJoO3cr/1mT0dagAzCuEh2oZb6NeV2956EhN8Uv2t6BKOrsmvfCjIOLQg==
X-Received: by 2002:a05:6808:2018:b0:384:8a1:c14b with SMTP id q24-20020a056808201800b0038408a1c14bmr4182868oiw.31.1680717132470;
        Wed, 05 Apr 2023 10:52:12 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id w185-20020aca62c2000000b003896e31867esm6604045oib.49.2023.04.05.10.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:52:12 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 07/13] rust: lock: implement `IrqSaveBackend` for `SpinLock`
Date:   Wed,  5 Apr 2023 14:51:05 -0300
Message-Id: <20230405175111.5974-7-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405175111.5974-1-wedsonaf@gmail.com>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
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

This allows Rust code to use the `lock_irqsave` variant of spinlocks.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes

 rust/helpers.c                    | 16 +++++++++++++
 rust/kernel/sync/lock/spinlock.rs | 38 ++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 05694e3f8f70..e42f5b446f92 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -59,6 +59,22 @@ void rust_helper_spin_unlock(spinlock_t *lock)
 }
 EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
 
+unsigned long rust_helper_spin_lock_irqsave(spinlock_t *lock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(lock, flags);
+
+	return flags;
+}
+EXPORT_SYMBOL_GPL(rust_helper_spin_lock_irqsave);
+
+void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
+{
+	spin_unlock_irqrestore(lock, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
+
 refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index a52d20fc9755..34dec09a97c0 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -61,6 +61,8 @@ macro_rules! new_spinlock {
 /// assert_eq!(e.c, 10);
 /// assert_eq!(e.d.lock().a, 20);
 /// assert_eq!(e.d.lock().b, 30);
+/// assert_eq!(e.d.lock_irqsave().a, 20);
+/// assert_eq!(e.d.lock_irqsave().b, 30);
 /// ```
 ///
 /// The following example shows how to use interior mutability to modify the contents of a struct
@@ -79,6 +81,12 @@ macro_rules! new_spinlock {
 ///     guard.a += 10;
 ///     guard.b += 20;
 /// }
+///
+/// fn example2(m: &SpinLock<Example>) {
+///     let mut guard = m.lock_irqsave();
+///     guard.a += 10;
+///     guard.b += 20;
+/// }
 /// ```
 ///
 /// [`spinlock_t`]: ../../../../include/linux/spinlock.h
@@ -90,7 +98,7 @@ pub struct SpinLockBackend;
 // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
 unsafe impl super::Backend for SpinLockBackend {
     type State = bindings::spinlock_t;
-    type GuardState = ();
+    type GuardState = Option<core::ffi::c_ulong>;
 
     unsafe fn init(
         ptr: *mut Self::State,
@@ -105,12 +113,30 @@ unsafe impl super::Backend for SpinLockBackend {
     unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
         // memory, and that it has been initialised before.
-        unsafe { bindings::spin_lock(ptr) }
+        unsafe { bindings::spin_lock(ptr) };
+        None
     }
 
-    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
-        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
-        // caller is the owner of the mutex.
-        unsafe { bindings::spin_unlock(ptr) }
+    unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState) {
+        match guard_state {
+            // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that
+            // the caller is the owner of the mutex.
+            Some(flags) => unsafe { bindings::spin_unlock_irqrestore(ptr, *flags) },
+            // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that
+            // the caller is the owner of the mutex.
+            None => unsafe { bindings::spin_unlock(ptr) },
+        }
+    }
+}
+
+// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
+// variant of the C lock acquisition functions to disable interrupts and retrieve the original
+// interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
+// in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
+unsafe impl super::IrqSaveBackend for SpinLockBackend {
+    unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
+        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
+        // memory, and that it has been initialised before.
+        Some(unsafe { bindings::spin_lock_irqsave(ptr) })
     }
 }
-- 
2.34.1

