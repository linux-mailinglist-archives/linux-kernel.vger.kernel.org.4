Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72226E8096
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjDSRpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjDSRpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:45:02 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E09472A0;
        Wed, 19 Apr 2023 10:44:51 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-18777914805so297825fac.1;
        Wed, 19 Apr 2023 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681926291; x=1684518291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ROxF1m2E3+7Rhy4bCnkyAJPHzO/m6/QTfEY4C+9JAc=;
        b=AjM8E+kpHI+BtRFpFjJD8UQlP+oaY81H6l5eDMl0Zh+vOMI6VbCELcfvLZIJHrBsO9
         8tFoiW/pbq8FdbtECcdG+zZCT1DBZlGsuXLstQIEQ1S20pKtmgd3tthlBLbNT0iFPX4H
         0fJQfQAtLzuMNHTUXpo1lmey/1ThxoxRHwvcWIlBSsHKAGIwgJT4fWvCjDqkagQ9l02f
         7TmlFGkxthw0Sx3/MqCT2DyK1RBvoUzpAszVYoX5oJKo8P2P55af7/5aW8lqOI5ySlBO
         ABJWmDdMfPxx8g4aJiiA/+/i+9bDNHdm0JqNSqIvmEo6oMXceazrT+loPSgQ3ELOQW5F
         8sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681926291; x=1684518291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ROxF1m2E3+7Rhy4bCnkyAJPHzO/m6/QTfEY4C+9JAc=;
        b=E76JXRM7DUgFMKBKowpOzucLIX335nMlPM7xjznb/0xCka7XkB7ds7qoxIl6t6iU31
         cKkrpL2VJBGP9y6oL/t76Vvv6diEKcMZWj6jL/qCmPMktsUpnlTRHfb7ZRuLwYfI45GZ
         O8SCdEnhFb1nJcwzJWlqKjG7c8ZaFtvHMIloA8KEHv2CjiEmnUNfFJ76tKx09ePAJg+I
         BWdMBPgh6CFRrp0WXBzqJDHBW8jaC+kTzGP+VY6T4K4j3Uq9fiz2ufF6iLvFmM4Vg4QE
         U06eNPlW625QTMtbMgOS1TIH9GoeRYlqHrlczqm3JnJv0iM11s/wKdog5JGM2bVY4zCf
         qmSQ==
X-Gm-Message-State: AAQBX9etjOHUuoMXKxR2rm72UtKtNw2OmZkAf0eny+8K6qsXc4vw4m/y
        OgTfE2VFnmeLfS9kF6soEXP5n0PRVCk=
X-Google-Smtp-Source: AKy350YmNJ+gaYDWISkFj7OVb0ZtcGGu6qc0dfvsLYGxq02UG/b+4kbd6TPguNtreqZbDycVumqXXg==
X-Received: by 2002:a05:6870:c0d0:b0:184:4216:4cb4 with SMTP id e16-20020a056870c0d000b0018442164cb4mr232989oad.21.1681926290815;
        Wed, 19 Apr 2023 10:44:50 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id du3-20020a0568703a0300b001723a2e84b6sm6987585oab.6.2023.04.19.10.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 10:44:50 -0700 (PDT)
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
Subject: [PATCH v4.1] rust: lock: introduce `SpinLock`
Date:   Wed, 19 Apr 2023 14:44:26 -0300
Message-Id: <20230419174426.132207-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This is the `spinlock_t` lock backend and allows Rust code to use the
kernel spinlock idiomatically.

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
v4 -> v4.1:
- Use __raw_spin_lock_init instead of spin_lock_init_with_key 

 rust/helpers.c                    |  24 +++++++
 rust/kernel/sync.rs               |   2 +-
 rust/kernel/sync/lock.rs          |   1 +
 rust/kernel/sync/lock/spinlock.rs | 116 ++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/lock/spinlock.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 86af099d2d66..1af5fcbd7f72 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/refcount.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -36,6 +37,29 @@ void rust_helper_mutex_lock(struct mutex *lock)
 }
 EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
 
+void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
+				  struct lock_class_key *key)
+{
+#ifdef CONFIG_DEBUG_SPINLOCK
+	 __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
+#else
+	spin_lock_init(lock);
+#endif
+}
+EXPORT_SYMBOL_GPL(rust_helper___spin_lock_init);
+
+void rust_helper_spin_lock(spinlock_t *lock)
+{
+	spin_lock(lock);
+}
+EXPORT_SYMBOL_GPL(rust_helper_spin_lock);
+
+void rust_helper_spin_unlock(spinlock_t *lock)
+{
+	spin_unlock(lock);
+}
+EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
+
 refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 693f0b7f4e4f..c997ff7e951e 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,7 +11,7 @@ mod arc;
 pub mod lock;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
-pub use lock::mutex::Mutex;
+pub use lock::{mutex::Mutex, spinlock::SpinLock};
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 98de109d9e40..08adc3747033 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -11,6 +11,7 @@ use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
 use macros::pin_data;
 
 pub mod mutex;
+pub mod spinlock;
 
 /// The "backend" of a lock.
 ///
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
new file mode 100644
index 000000000000..a52d20fc9755
--- /dev/null
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A kernel spinlock.
+//!
+//! This module allows Rust code to use the kernel's `spinlock_t`.
+
+use crate::bindings;
+
+/// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
+///
+/// It uses the name if one is given, otherwise it generates one based on the file name and line
+/// number.
+#[macro_export]
+macro_rules! new_spinlock {
+    ($inner:expr $(, $name:literal)? $(,)?) => {
+        $crate::sync::SpinLock::new(
+            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+
+/// A spinlock.
+///
+/// Exposes the kernel's [`spinlock_t`]. When multiple CPUs attempt to lock the same spinlock, only
+/// one at a time is allowed to progress, the others will block (spinning) until the spinlock is
+/// unlocked, at which point another CPU will be allowed to make progress.
+///
+/// Instances of [`SpinLock`] need a lock class and to be pinned. The recommended way to create such
+/// instances is with the [`pin_init`](crate::pin_init) and [`new_spinlock`] macros.
+///
+/// # Examples
+///
+/// The following example shows how to declare, allocate and initialise a struct (`Example`) that
+/// contains an inner struct (`Inner`) that is protected by a spinlock.
+///
+/// ```
+/// use kernel::{init::InPlaceInit, init::PinInit, new_spinlock, pin_init, sync::SpinLock};
+///
+/// struct Inner {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// #[pin_data]
+/// struct Example {
+///     c: u32,
+///     #[pin]
+///     d: SpinLock<Inner>,
+/// }
+///
+/// impl Example {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             c: 10,
+///             d <- new_spinlock!(Inner { a: 20, b: 30 }),
+///         })
+///     }
+/// }
+///
+/// // Allocate a boxed `Example`.
+/// let e = Box::pin_init(Example::new())?;
+/// assert_eq!(e.c, 10);
+/// assert_eq!(e.d.lock().a, 20);
+/// assert_eq!(e.d.lock().b, 30);
+/// ```
+///
+/// The following example shows how to use interior mutability to modify the contents of a struct
+/// protected by a spinlock despite only having a shared reference:
+///
+/// ```
+/// use kernel::sync::SpinLock;
+///
+/// struct Example {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// fn example(m: &SpinLock<Example>) {
+///     let mut guard = m.lock();
+///     guard.a += 10;
+///     guard.b += 20;
+/// }
+/// ```
+///
+/// [`spinlock_t`]: ../../../../include/linux/spinlock.h
+pub type SpinLock<T> = super::Lock<T, SpinLockBackend>;
+
+/// A kernel `spinlock_t` lock backend.
+pub struct SpinLockBackend;
+
+// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
+unsafe impl super::Backend for SpinLockBackend {
+    type State = bindings::spinlock_t;
+    type GuardState = ();
+
+    unsafe fn init(
+        ptr: *mut Self::State,
+        name: *const core::ffi::c_char,
+        key: *mut bindings::lock_class_key,
+    ) {
+        // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
+        // `key` are valid for read indefinitely.
+        unsafe { bindings::__spin_lock_init(ptr, name, key) }
+    }
+
+    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
+        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
+        // memory, and that it has been initialised before.
+        unsafe { bindings::spin_lock(ptr) }
+    }
+
+    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
+        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
+        // caller is the owner of the mutex.
+        unsafe { bindings::spin_unlock(ptr) }
+    }
+}
-- 
2.34.1

