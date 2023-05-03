Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80196F5405
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjECJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjECJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5574ED7
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f1950f5676so50210595e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104848; x=1685696848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHrN32lBaAC78cOIMsVaenJPrzKJjknoApgieLS2EVM=;
        b=oA2PVI7kXpD5OIbFur9s7uaOC1Nh/L72pwK/S62AuuQQaQp4WS6rCh6e1Qiu311wQM
         i+tmijmYwryRpAB+BQXDD6we65meeLaoR7RiUgcCodh6T1WdeG3rXHU3aZ7RyUOXMl3G
         TpBB2cGgmPdRWJt4X4inUYYm8i6bJcsAq9WphlZqTjKnuQu0J21VXA/d2UN7hiTp+25Y
         oBFKxT3L7/ViA4VeKCx5UI0YHrZqbgbOXKdIaytdI7oCcrlH1MOqviwi9jouVUUIxAd6
         bxkaj0/ygyyrL74KdQ1C3LsOjbhlUrt5uX0Z8rNBRK89XnyS3Fh7uD9pLe/0c96ZDAgH
         tviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104848; x=1685696848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHrN32lBaAC78cOIMsVaenJPrzKJjknoApgieLS2EVM=;
        b=KzphisuLEcRclMB6+xTWlDPMwybULwS6iq9yyPiCalxDSE25y27Y2IT2J2r4Q0LJyo
         hRkiEshUifdaEBUbf1nW62rkGr1TLi7SHxMhL/KHamlIvrLx74iPcJM9znxRpESgDtMc
         YJ1lG7OOMnH8mdU7FqsOxgBEpkZDJaHLOXQdLHQRQcn1jSIax7t/V8Z6VsBW8QkkGj4L
         BzU4IIjoLXmksLoFgWJUA4xufTecsjeRAdaqBqlv2y8D6mkp3FoqTXEi8NyoI7NF1Tqb
         9fLeg6S+QqhnZsSJVZme6bIhRnWf0i1yJZk27/wYV8k8GB1MQOxdgJUlt1MEE+hfORof
         b58g==
X-Gm-Message-State: AC+VfDx1GS4VOJh7UImD9N7t8aFbF97J87RR7tvf7Ajz9VVhfaC3/Qj/
        8J6q3ZXndDZ7COG4eUCEgFaGXA==
X-Google-Smtp-Source: ACHHUZ7P6M/jU8n50FGEjgTSgEYAcUdKtRM+n+M8XLe9UPXqN9jUX6WcfyARZKzQxoFqI3CdjYYuxQ==
X-Received: by 2002:a05:6000:11c5:b0:2fb:600e:55bd with SMTP id i5-20020a05600011c500b002fb600e55bdmr15479168wrx.39.1683104848425;
        Wed, 03 May 2023 02:07:28 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id e22-20020a5d5956000000b003012030a0c6sm33106775wri.18.2023.05.03.02.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:28 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 11/11] rust: inline a number of short functions
Date:   Wed,  3 May 2023 11:07:08 +0200
Message-Id: <20230503090708.2524310-12-nmi@metaspace.dk>
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

From: Andreas Hindborg <a.hindborg@samsung.com>

The rust compiler will not inline functions that live in vmlinux when
building modules. Add inline directives to these short functions to ensure that
they are inlined when building modules.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/sync/lock.rs          | 2 ++
 rust/kernel/sync/lock/mutex.rs    | 2 ++
 rust/kernel/sync/lock/spinlock.rs | 2 ++
 rust/kernel/types.rs              | 6 ++++++
 4 files changed, 12 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index bb21af8a8377..4bfc2f5d9841 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -101,6 +101,7 @@ impl<T: ?Sized, B: IrqSaveBackend> Lock<T, B> {
     /// Before acquiring the lock, it disables interrupts. When the guard is dropped, the interrupt
     /// state (either enabled or disabled) is restored to its state before
     /// [`lock_irqsave`](Self::lock_irqsave) was called.
+    #[inline(always)]
     pub fn lock_irqsave(&self) -> Guard<'_, T, B> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
@@ -210,6 +211,7 @@ impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
 }
 
 impl<T: ?Sized, B: Backend> Drop for Guard<'_, T, B> {
+    #[inline(always)]
     fn drop(&mut self) {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 923472f04af4..5e8096811b98 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -104,12 +104,14 @@ unsafe impl super::Backend for MutexBackend {
         unsafe { bindings::__mutex_init(ptr, name, key) }
     }
 
+    #[inline(always)]
     unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
         // memory, and that it has been initialised before.
         unsafe { bindings::mutex_lock(ptr) };
     }
 
+    #[inline(always)]
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
         // caller is the owner of the mutex.
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 50b8775bb49d..23a973dab85c 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -122,6 +122,7 @@ unsafe impl super::Backend for SpinLockBackend {
         None
     }
 
+    #[inline(always)]
     unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState) {
         match guard_state {
             // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that
@@ -141,6 +142,7 @@ unsafe impl super::Backend for SpinLockBackend {
 // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
 // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
 unsafe impl super::IrqSaveBackend for SpinLockBackend {
+    #[inline(always)]
     unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
         // memory, and that it has been initialised before.
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 98e71e96a7fc..7be1f64bbde9 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -70,10 +70,12 @@ pub trait ForeignOwnable: Sized {
 impl<T: 'static> ForeignOwnable for Box<T> {
     type Borrowed<'a> = &'a T;
 
+    #[inline(always)]
     fn into_foreign(self) -> *const core::ffi::c_void {
         Box::into_raw(self) as _
     }
 
+    #[inline(always)]
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
@@ -82,6 +84,7 @@ impl<T: 'static> ForeignOwnable for Box<T> {
         unsafe { &*ptr.cast() }
     }
 
+    #[inline(always)]
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
@@ -92,12 +95,15 @@ impl<T: 'static> ForeignOwnable for Box<T> {
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
+    #[inline(always)]
     fn into_foreign(self) -> *const core::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
+    #[inline(always)]
     unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
 
+    #[inline(always)]
     unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 }
 
-- 
2.40.0

