Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732E06DD202
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDKFqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDKFqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:37 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AD73598;
        Mon, 10 Apr 2023 22:46:20 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bf5so4751548oib.8;
        Mon, 10 Apr 2023 22:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pv6qNRZHA9f9WsLjADdwd+ymESG3pRy2ih0fvHz3LhE=;
        b=ideeZghkQv4t9L4zEwczcldNB4KwoSCk6uFQ9dPWym9BzryvfJwYPw2XLs/OyWaZo2
         QUInsoujXxznDtWvKrE0r/T8lbdoNHenhYMy/CR6TEO8jaUjKzI2eBxOaEfOt2bwPWJV
         R7JTTeNcdb2Mw5WJz5Me/vESsHQJVorJ3lgQUI8gk4xWU+1pBV2xtQdDXUpESzmw2gO7
         LvjuE+n7uI2li1sxOt21l80x28UOsCkXhrPF+SZg47OHuObeAnTnsnaDJenmGiM2GGZV
         iqziTxvPKGMFTZdCetaLj5lI5mbLwRcyLxGzw9BZz0gnxVB5fpsOrsg5TMS6bx+bH4/9
         YrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pv6qNRZHA9f9WsLjADdwd+ymESG3pRy2ih0fvHz3LhE=;
        b=eoEkFGqDRSzQd68D66KTrqvCYpxEq5cxvw2kmFlqDpiUKEPu7DwLCrpJqP3Wv/k0F1
         QpaxGH4kajdxwCJnM9QXPayd1vmd2wPG+g5fDQdUt+chstqhLWBgVRrZY/PgJxhvK1Qq
         sX6HHBNvnwantlAEK05MHJC/0JOyhSoBpjhn2JdT6X4Yz6rPiQ63zKBmc/Qvg7vzM5GT
         fSODy5gl8TdGI24DZJmkoCqjs3HZxXb09oFti2yrSUlrD36R5KbmVMb1DvNSc9O7FQf9
         gErcPLiDvOc3LOLn8E2Nl2SnUxzu7uYwRt8KP30//y3XsoeAEZY8OFJJEmv/9x9Rd98j
         na0Q==
X-Gm-Message-State: AAQBX9eKpTZT1g3XMV4A1xtMIkqaiQ1Jh2RTQRU72f56M1T0rItoumRJ
        ytEI/h5Y8RX0mYsqoql+Er836je7LMY=
X-Google-Smtp-Source: AKy350ZlmmcnYNf6PXqv56GbHajDcw4g5tcRTcuH7BamNBiz8Fr0CtLHuwMghHLwvfpMPLo7U8offQ==
X-Received: by 2002:a05:6808:3a85:b0:386:a2fd:398e with SMTP id fb5-20020a0568083a8500b00386a2fd398emr9927600oib.18.1681191979391;
        Mon, 10 Apr 2023 22:46:19 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:46:19 -0700 (PDT)
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
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 07/13] rust: lock: implement `IrqSaveBackend` for `SpinLock`
Date:   Tue, 11 Apr 2023 02:45:37 -0300
Message-Id: <20230411054543.21278-7-wedsonaf@gmail.com>
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

This allows Rust code to use the `lock_irqsave` variant of spinlocks.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: No changes
v3 -> v4: No changes

 rust/helpers.c                    | 16 +++++++++++++
 rust/kernel/sync/lock/spinlock.rs | 38 ++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 141308a78775..efd5b1e86f6e 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -60,6 +60,22 @@ void rust_helper_spin_unlock(spinlock_t *lock)
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

