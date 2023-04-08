Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF1A6DB96D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDHHyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDHHye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:54:34 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE204FF39;
        Sat,  8 Apr 2023 00:54:15 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e9so367457oig.7;
        Sat, 08 Apr 2023 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBxUeM8crjQUn0jyMS6RnqsghfeEHmI+/co92h1YSAk=;
        b=l+eOLhyIOXbDPYc+MMNtiUiw/U72JUbsHkAopXReimehmfMU4o2ydiiZd7ufpKdK9f
         zZhiUB0hGWmcEJcFhNRImfT/GmX7CVEWCfgDPUpwSMoKQxOPjljK3e6VvlrwSrrfq5i9
         4+hQMfEeO12aXDEDRRNzHSU4WVE/1UplKV96axp5Fvk0JyzN0N64tYtgij+P4s6vn5vT
         boKZF6PCb9M7if2o0T0ap1ZSF53DLBWcaOmJbsaLlMuFTihmBdqwjsY/6J5LaddKxlFK
         4PTdOuIT2D4aUboHDnd/wA50h2qaX9gTy8uYOuSdDQpvDJL5XeZBRCmszXFhpRif2Zro
         izWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBxUeM8crjQUn0jyMS6RnqsghfeEHmI+/co92h1YSAk=;
        b=VSzsxVIeIx5aibyYKeLOzSbqxII1PtQXaULT0Z2rzKD2oW7Lq2FyXo/NdinS/QujS9
         2WznpOXMCw3I2KWOI1gECXIT/4Ep7lYPF2Tk+6vkW35HzkIXsyRi8MmUn7E5SawjVDDN
         pSfnSAVpw0Ubkh6Y2RuRro6v8geGd11NqGS6B6rpX9owAf8bDfZ9+UpSudUs9eV6jUzx
         CUBCKlM9ebs2r6l2P+iehOlXoHRVhYCHPkA1V1UA70E3znhC0m0T011ivDoSjLzL9HgF
         62jgKzdB1rPuM4K+1hnc9wanZ9JN/QGhmYCs/nekw4dTUugs7CFNeiVsE64v8uVGPUBJ
         dSFw==
X-Gm-Message-State: AAQBX9eb/sjMlee2hS/fOzIdxNcMw7PqoEFo3cIBLtBu9ZHWezSY6V0/
        jmhFYFeMMTJIfuiyV/mnlPluCCL19v22Pg==
X-Google-Smtp-Source: AKy350Zaz9hiixp4oGyPkzDpJ7mv0VsFxW8o4OKvSNmczoAR1lNS/c5kil/oVoc6qvGWDvvUtgYhpw==
X-Received: by 2002:a05:6808:aba:b0:38b:8d27:ff52 with SMTP id r26-20020a0568080aba00b0038b8d27ff52mr2016970oij.53.1680940454290;
        Sat, 08 Apr 2023 00:54:14 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:54:14 -0700 (PDT)
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
Subject: [PATCH v3 07/13] rust: lock: implement `IrqSaveBackend` for `SpinLock`
Date:   Sat,  8 Apr 2023 04:53:34 -0300
Message-Id: <20230408075340.25237-7-wedsonaf@gmail.com>
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

This allows Rust code to use the `lock_irqsave` variant of spinlocks.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: No changes

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

