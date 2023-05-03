Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755346F5401
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjECJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjECJHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CAF46B7
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-305f0491e62so4324421f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104844; x=1685696844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfKdjWdresPJSdXc5oUQnKkLhNP+u1b3Z6UA6/bvZEs=;
        b=zxf3V0pixeyAdrD64XjVTcoz5GBZP1Ez2NPEYfg4bJ+8OpHIgbs5IPYWoyRFF/oRls
         1HiTMTqiw5oPzKcjXk85WtG2qWppkjvU02IYtCNv/P6lilDjZ3I/tCqie+hxdHS9fI72
         TFUlh6Wb66UftjAJVkN8zXebQeRzUQEjndgJGChQSPHdwiL4EDhLk2wZR45z/mLS3qsS
         0hle1vi+M/A5q3ANxKiVAd1H1NxXbl8yRYYvbayFD9yVys1oohANbByOMWC+mJ8fu1Aq
         h3If9GnckODucwV34nms5ONfQlshxGTXJ2YdkMkaVW/TPTSFD4UmrIVnUA6QvhXfqCL+
         1Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104844; x=1685696844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfKdjWdresPJSdXc5oUQnKkLhNP+u1b3Z6UA6/bvZEs=;
        b=lftjJpWP1QyAbXWOngXxkaxwWypbOFLENowjk5U4EZaxG0arc7GNpK0/tMgVish332
         pAfoshzNNVuE+aXaEoyJZV8OIKSURQsBUHinDuHHJvRR4jtZG3RSzHu4Pz2Ax4o9QHMi
         zm8ehaJIZ6ckwBdvQ6VC8/EcPDsZiOBvLWESm+dInbsOCdkR0EHp0yi+b+xhvA22cBtS
         TP2SXP0holCznkb7oqe7HRQh1UhkkIkVWYlSgF9Tm05E9RwRfIt599JfPQNmXjjsOHyD
         RVxcec/l6RNr3ct8Lu6bRjdeuL3itb3GOE8q/IcE0jK8sMTjAB1owis/5V1NVgV1M9XP
         BN+Q==
X-Gm-Message-State: AC+VfDxzegZtZjWk2lrL40Gk4uoiMWXq0u8yEw3SrItsGS3K2hsXsZLZ
        314OSSOUjW5bLr5eR6D2fgzRvA==
X-Google-Smtp-Source: ACHHUZ5UM0xcnar/k/FZ+nJlonCpodkAJIUEXzZR9u3QQyFGMIWvcy7zXUt0eX7nCk//Wv22bv3Duw==
X-Received: by 2002:adf:ee8d:0:b0:306:42e2:5ec3 with SMTP id b13-20020adfee8d000000b0030642e25ec3mr912726wro.6.1683104844271;
        Wed, 03 May 2023 02:07:24 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id k11-20020a7bc40b000000b003f173a2b2f6sm1248839wmi.12.2023.05.03.02.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:24 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Wedson Almeida Filho <walmeida@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 08/11] rust: lock: implement `IrqSaveBackend` for `SpinLock`
Date:   Wed,  3 May 2023 11:07:05 +0200
Message-Id: <20230503090708.2524310-9-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 rust/helpers.c                    | 16 ++++++++++++
 rust/kernel/sync/lock/spinlock.rs | 41 +++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index a59341084774..7f5b95f652e1 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -203,6 +203,22 @@ struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
 
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
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index e39142a8148c..50b8775bb49d 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -64,6 +64,8 @@ macro_rules! new_spinlock {
 /// assert_eq!(e.c, 10);
 /// assert_eq!(e.d.lock().a, 20);
 /// assert_eq!(e.d.lock().b, 30);
+/// assert_eq!(e.d.lock_irqsave().a, 20);
+/// assert_eq!(e.d.lock_irqsave().b, 30);
 /// ```
 ///
 /// The following example shows how to use interior mutability to modify the contents of a struct
@@ -81,6 +83,12 @@ macro_rules! new_spinlock {
 ///     let mut guard = m.lock();
 ///     guard.a += 10;
 ///     guard.b += 20;
+///
+/// fn example2(m: &SpinLock<Example>) {
+///     let mut guard = m.lock_irqsave();
+///     guard.a += 10;
+///     guard.b += 20;
+/// }
 /// }
 /// ```
 ///
@@ -94,7 +102,7 @@ pub struct SpinLockBackend;
 // default implementation that always calls the same locking method.
 unsafe impl super::Backend for SpinLockBackend {
     type State = CachePadded<bindings::spinlock_t>;
-    type GuardState = ();
+    type GuardState = Option<core::ffi::c_ulong>;
 
     unsafe fn init(
         ptr: *mut Self::State,
@@ -110,13 +118,32 @@ unsafe impl super::Backend for SpinLockBackend {
     unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
         // memory, and that it has been initialised before.
-        unsafe { bindings::spin_lock((&mut *ptr).deref_mut()) }
+        unsafe { bindings::spin_lock((&mut *ptr).deref_mut()) };
+        None
     }
 
-    #[inline(always)]
-    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
-        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
-        // caller is the owner of the mutex.
-        unsafe { bindings::spin_unlock((&mut *ptr).deref_mut()) }
+    unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState) {
+        match guard_state {
+            // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that
+            // the caller is the owner of the mutex.
+            Some(flags) => unsafe {
+                bindings::spin_unlock_irqrestore((&mut *ptr).deref_mut(), *flags)
+            },
+            // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that
+            // the caller is the owner of the mutex.
+            None => unsafe { bindings::spin_unlock((&mut *ptr).deref_mut()) },
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
+        Some(unsafe { bindings::spin_lock_irqsave((&mut *ptr).deref_mut()) })
     }
 }
-- 
2.40.0

