Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FFF6CFA51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjC3Elt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjC3Elc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:41:32 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3D255AA;
        Wed, 29 Mar 2023 21:41:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 6-20020a9d0106000000b006a177038dfeso230217otu.7;
        Wed, 29 Mar 2023 21:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cn5PpHPjbVKiTpn7S4FdRJhabCdix+uDXiUAvFeLWQ=;
        b=MLmE4Qc5UnH4btH/GC2TwCy+UCPp008eyBc8f+wKjsnmwOFtSq6B7qKG9mikCeMp0N
         5Ynr1qpJcjIRFvjedJwWLo58Y7ensDgVtTwk+0grH6s1r7EuT+t32S25JhRXMdpSz9Fx
         4LaLflnqOYvzjIeSKa5VJ5LdfO+56X3X/gxwRbRDX/251LJQFxjVUKCU2cM4qslOfzHO
         MH9cGjfjS37ZQdQCOBpUeHDexsgexJJtNUr44DRxNhlIvwO/IxJgW3+d8tkmeZ0A6sDs
         fXCvPurehpapPUZO1E9Km3uO55GeHhUeH0tdAQltEQuVvhNTMoyXkZzaudaC19cJ0/In
         svXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cn5PpHPjbVKiTpn7S4FdRJhabCdix+uDXiUAvFeLWQ=;
        b=Sdjv2PGcj44RO5p+lXIYpcQjV5zyc4zQSTTdKrCN7uFI8LQrYya6e3qsSX3hb+t5Po
         EiaikeAv51uWG2hbftGV+ffeO5Fm+JAaQqi9FJTyc3o7+xvxIWooMPwgPfPA9shHCwWc
         +F/Fups4gEXQxYI/iTlGn1KyZKUWsdxR//fN46PDSO7fUj/p7TOQ9wt7/D7J8E5grZkH
         +WI1QGchTyn1gJ9tAHc5b5pKrpUVowHbKAXA45besn1kP+Tk8GZvGRv5dZXF4xJ9YLqE
         CMgd/OkAM2jlOHpqGTeduDnTiIyvRiotj+re5T4OuZymOlhzCg2eeSKYkC5npClIxQZA
         F0XA==
X-Gm-Message-State: AO0yUKV87asP5/2UNvaHlqmFXLaKbxByEJofLnLerQOssi5x5RbcJwL2
        l32PImcALGMbhh3fkAJVIB7nPjgJr7fOtw==
X-Google-Smtp-Source: AK7set8h8uCCq6lcLgErc/YqpcSJ/dZKJUBAxcgDIUqGTznEF45OGrkov8pj674yB80XwuAmloMmcw==
X-Received: by 2002:a05:6830:1602:b0:699:f81a:14bd with SMTP id g2-20020a056830160200b00699f81a14bdmr10935792otr.30.1680151272285;
        Wed, 29 Mar 2023 21:41:12 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:41:12 -0700 (PDT)
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
Subject: [PATCH 07/13] rust: lock: implement `IrqSaveBackend` for `SpinLock`
Date:   Thu, 30 Mar 2023 01:39:48 -0300
Message-Id: <20230330043954.562237-7-wedsonaf@gmail.com>
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

This allows Rust code to use the `lock_irqsave` variant of spinlocks.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
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

