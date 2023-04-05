Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4F86D8549
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjDERxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjDERw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:52:58 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864B372A6;
        Wed,  5 Apr 2023 10:52:33 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bj20so27246496oib.3;
        Wed, 05 Apr 2023 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1wZE/v6mgSkCeDVAKOm1WIZXGoTy4TNz5YfKZmJxYE=;
        b=lZ5xmw7rFK96HMotVpl+UgpAmE/at1reFhBUu+W4sxAtXLGyhABu2M8ozzEjK1BAym
         GYswSzNSuRw0VqTWrq/G8pWw/fhuSx86FqU3l53QDWuH5coqbtRA/b59PmrOcOwch6yr
         D+j3S/HWojNwVGp8WpquVHJLll2VYrh416lgBzdUu2flZx4z/dlXOrGkQK/akWwaxr/v
         KTPWbaN7vH+NtG0tCZGhvZLd/PDSXRapMg8Yp7Gl9c6YDo2tzx/rcEk4BBOnwPdPocnc
         9AEb2IVyraha6hsknEzfGgYjC8p5vNp2tODNFUArqbMaUJE3clrnUon8ULaTfFtVkN5O
         CfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1wZE/v6mgSkCeDVAKOm1WIZXGoTy4TNz5YfKZmJxYE=;
        b=NoyVd7CoUKJDxsx33lcoJkw2/BTF4gSJqYbUAWT3503d848emZznXWZUgSPl67x+KE
         RrDd1G/yGr59hvDZl0Af7Ab73Gh9uXNHW/TtehXTPPhHYJvs1Wuuv7l3cw62i+R9ldT7
         6szy1tejgX+vIgoNJorJL/I6gKtWsh/zvRrwhSHKeaKHIBGN8GvLnpNGM7+S06SmTtqG
         IWtXXzn3JIO4sh5wFjPMz9XAgjiP1qIAXMQ0bOld6ETOFK+VNeEaKb2T/CAsVCRC6TLs
         w4/V+YJQIXITSIiUWpgjQPVCyM0tHDGFvNH1haSiNgcYpvuLVDUpVgefq3tbft2CFjdK
         fQ2g==
X-Gm-Message-State: AAQBX9dM8bswktZI8nnFMlDWnE9iftWOavDMrRMKL/05wXC9jIDFTP2k
        5ObeNUPP/b0NwXUUVQj0glIA2ZsKgFw=
X-Google-Smtp-Source: AKy350Ybh22SRgC0Mv/qXMcTI0YBjJIA75d0B8Kkgjc02JVGVyUuZ4DLN6ufhko/peweVbw7LYdgmA==
X-Received: by 2002:aca:2411:0:b0:389:9c8:7734 with SMTP id n17-20020aca2411000000b0038909c87734mr3621583oic.12.1680717149903;
        Wed, 05 Apr 2023 10:52:29 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id w185-20020aca62c2000000b003896e31867esm6604045oib.49.2023.04.05.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:52:29 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 11/13] rust: lock: add `Guard::do_unlocked`
Date:   Wed,  5 Apr 2023 14:51:09 -0300
Message-Id: <20230405175111.5974-11-wedsonaf@gmail.com>
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

