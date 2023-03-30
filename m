Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29406CFA4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjC3Elb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjC3ElR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:41:17 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2705B8E;
        Wed, 29 Mar 2023 21:41:05 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-177ca271cb8so18568051fac.2;
        Wed, 29 Mar 2023 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwVPaXw5dJAdR236vc9B5esZBTUOYR4MIU5q912I8Co=;
        b=YHZJ+DH+gFhYhXOL4EpuCUuWZVtRNTCJph5XrenpP2LCq0jE9aH1dzWVPUbQjW7lmZ
         ZZuS2+JzZeof2xWJStF6El/p4Il6N6N88Ym/ij84pr7osfsFJ6RgkGsM1Srct/sE+dFm
         F1MbzymrD7D6fji7iLVw4NUYLHt9r3O1Cn6pMuTfDlu40Mlav+SWHvWcvIKjqucMaJf2
         VNJXx9PT3pHzCCRlPYTspPyJKEzDziVSHhEo0i99FmSEk0IKbUdKx7INk2kLQkZeiLb0
         jLOsIN4Qv+/JMj5nNdT/vSDconDDc0H/FAeh8hIGf0PLlG7i7uScQy0ZHVAgK+svvc5f
         DVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwVPaXw5dJAdR236vc9B5esZBTUOYR4MIU5q912I8Co=;
        b=BTgq6xNhaAH+3d6ffmDVSsKbuaRr6K+iuJcl7S3Fkiej5DCvWkWs0VfJvIMm2671pW
         UiOYzP3op4HzlvICSPUXeRuSn3cWIIqJsHdD7o9Cbm3yWrl/IbNlZQxMUXsTgpdwH1g0
         UbYoEiTY0qG+S7ubeCKkD4TG7uTFFz/igJLwp3oCQkCHI9VHRn7zlnIwuIaSLoCW0Lh1
         WLP2ANcTwZkErHbs3pymSiksJaM+nbFIIVBHCDx2KT149r03UqfToRaSd1E9SZ7+jjnO
         GeH2DNdcJ4PkuanqACIswQll5WoaX8x9/SpzqFwBvWWhmFxb6A+B+PbYpSNv0oYL1wGc
         Ot3w==
X-Gm-Message-State: AAQBX9dDm3UEJVcp3bj/gyw+WEquudyb0wPRyEApaO7U18exz4hWClJz
        +vzZQEVJ9vPiSW34JA0JBg18ZDKbyYm+zg==
X-Google-Smtp-Source: AKy350YRbWd1IBhI7RHxlHuDrYR02brFJjBSuJyaNGO0QYYloz/GXjG/98/oUgrjExdl9C6wU73ieQ==
X-Received: by 2002:a05:6870:d1c2:b0:177:b8a2:5854 with SMTP id b2-20020a056870d1c200b00177b8a25854mr15439158oac.45.1680151264383;
        Wed, 29 Mar 2023 21:41:04 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:41:04 -0700 (PDT)
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
Subject: [PATCH 05/13] rust: lock: introduce `SpinLock`
Date:   Thu, 30 Mar 2023 01:39:46 -0300
Message-Id: <20230330043954.562237-5-wedsonaf@gmail.com>
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

This is the `spinlock_t` lock backend and allows Rust code to use the
kernel spinlock idiomatically.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c                    |  24 +++++++
 rust/kernel/sync.rs               |   2 +-
 rust/kernel/sync/lock.rs          |   1 +
 rust/kernel/sync/lock/spinlock.rs | 116 ++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/lock/spinlock.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 3010a2ec26e2..05694e3f8f70 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -22,6 +22,7 @@
 #include <linux/build_bug.h>
 #include <linux/refcount.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -35,6 +36,29 @@ void rust_helper_mutex_lock(struct mutex *lock)
 }
 EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
 
+void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
+				  struct lock_class_key *key)
+{
+#ifdef CONFIG_DEBUG_SPINLOCK
+	spin_lock_init_with_key(lock, name, key);
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
index 9ff116b2eebe..ed07437d7d55 100644
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
index cec1d68bab86..bca9af2a9a5a 100644
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

