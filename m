Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520B16DD200
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDKFqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjDKFqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:20 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0BA35A6;
        Mon, 10 Apr 2023 22:46:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r14so31017528oiw.12;
        Mon, 10 Apr 2023 22:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU1aIfRkJj4hN5kETMCo+xD8d0WgAtSmo7HPla12H84=;
        b=G1/S4UI7gtPWoZCbBHrwVz7Ke4W5S3Hbv0HHt358FxInQiPwkT0ezglFtX8iFxb5AX
         u2L5+WDFeh39ZcelPn+MMp40CCbyfeI/X1JygXT52yOqx+aCJH8d772nAu7VCU0XTj8x
         k7k6RwhU8uJJA5HND5IQGtmzJjLMd2jO8fshIO+JYsHzgMdxfvcM/8vn/C3OWudiC2uT
         6UMyRBqK1mwSnIeuJsjn4N54UzqsHhsVFhxRFYvoxU6yApLWYypapQfbVYxMKXvjAw48
         meoPunso7eo/IjM5nvEPFRDXFMtw3PptsKVZX0a9AB5d1fjdhhYv6rx5p52SEjhCydz6
         Pp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BU1aIfRkJj4hN5kETMCo+xD8d0WgAtSmo7HPla12H84=;
        b=TkQBGM9Em+e4p4uX03ViMGrWGhH3KMTOYAWJzyHapVQ7TjxeY7DpcWXjqFL2oihUpD
         /gbqUnlFoyH68lLARuScCJcmErRDyKmXzXL9Ds6YvkpduGJe32ejPuZBuGoTGhsh/8LU
         ojp665q+FhV2Hd3xtLYiOZqL2BHTb1mcM+Ofsn7FTowg9+ox/aMyYUW/TzHhrvbPAF7l
         nu1s5FwL6kbKbYnnClk16M4j9ZZAZE/9i2G0UQOeXrfwoJPIQlrzr+RUfHZPBfEJLDwY
         h4s9mNuMVt4R0xHZMVI0+p4nTXPM1NYy8j8ztaWSO4VWPUOLX69ZgpIyiynUt7e2Oc06
         b8Kw==
X-Gm-Message-State: AAQBX9eUtb2t0fgCC65+2kmjEZDLEbnURi29kH5Z657YhruIU2EFD6DV
        QnPFHwolXdUnPz5FOsQocLQAFvhQXRk=
X-Google-Smtp-Source: AKy350ZBOeo9nkOhf4TMBlPSNhTMFVcLuA+7uAQFVBnSxk4g/7+uwNXZFu4Y3j7mKnqQ7SoFHPctiw==
X-Received: by 2002:a05:6808:2c4:b0:384:36f2:5109 with SMTP id a4-20020a05680802c400b0038436f25109mr5153993oid.6.1681191972355;
        Mon, 10 Apr 2023 22:46:12 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:46:12 -0700 (PDT)
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
Subject: [PATCH v4 05/13] rust: lock: introduce `SpinLock`
Date:   Tue, 11 Apr 2023 02:45:35 -0300
Message-Id: <20230411054543.21278-5-wedsonaf@gmail.com>
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

 rust/helpers.c                    |  24 +++++++
 rust/kernel/sync.rs               |   2 +-
 rust/kernel/sync/lock.rs          |   1 +
 rust/kernel/sync/lock/spinlock.rs | 116 ++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/lock/spinlock.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 86af099d2d66..141308a78775 100644
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

