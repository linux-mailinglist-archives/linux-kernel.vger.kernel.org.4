Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E626CFA57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjC3Emu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjC3EmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:42:04 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A755B5;
        Wed, 29 Mar 2023 21:41:34 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-17e140619fdso18534762fac.11;
        Wed, 29 Mar 2023 21:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDQ1ux1FFIBKnkm5RT1u4Ss2PCKeYkPgmEuTF41v1l0=;
        b=DgeyASSUgCjM7B4AF4Gy3TxTUn2cRFAxrwsWNWo/UfzJwf0k0+k+dc20KPZ8TkWs59
         goYODEOXSs/MSO2xy/C9BSrGk7djZ51qqxIjXbB4UkysVENSsbon+jXm984jB9kvHbVB
         2zhsFhkN7rSxlpOUeCXAvhscvtl1xM1yAlfr3czxXDd1bwHzao3VBoW+F2Oywspo68OP
         yXjp/s2tRogjJ9/7MVabmZmQNOZrvL4oeeaIlPEIhkrk2n+EPv3DgiNCK+XVxx+4+wFS
         tWHcmLT/CfxC2sj0cbJIQtXr6oDWFoCsUiA6yh+oqKajnRK2f4+GabA2oW/+eHn6XbGC
         +0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDQ1ux1FFIBKnkm5RT1u4Ss2PCKeYkPgmEuTF41v1l0=;
        b=b05CQ22bif3tlY/Sct1nQiRg2eK3g5zWQK9Jo9nHC5mu5/cZ+8CfVoBCUMsbNrdwER
         kfnZyggGhaDd3WAGu93xcDak/6Q4R24c8t5ExZL0LF8f0JwIHUheh4ewOp/RSnmS55KA
         HFAtoorAQ/T3k6XHTXGf84JYnBFz4++w59q+rIb7ls7wNtdyDjdHI+e0mHtYWbD4UpsR
         nXHdjxj68LdkNraifWXp2iUJP93nLZFEInErf5D/0cSpI4XrvITdvRAZPA8bs7GqlQ1a
         BbPt6DK0dRrjfKDQIUdIh8HLSv3wYs7G967AAw4nKbQm+Qj/0z+ipRdo4+wLv9omVcu7
         OYjw==
X-Gm-Message-State: AAQBX9ftO9Rlcnj+A8tp5y19eC9Lps0htoHJYbnF+xWN4pms88mKIcqA
        bN9zBlg50GWf3eYQ0yhfGfjOtsEZWZ5BNg==
X-Google-Smtp-Source: AKy350YhqABHRLL40ZeYYdG9zZ2N5FUipMxVWk3PMCpmpWG0UgZ0kdcjBFWaxxNANxHe7g0cFeWTew==
X-Received: by 2002:a05:6870:e313:b0:180:1faa:7c1c with SMTP id z19-20020a056870e31300b001801faa7c1cmr60006oad.46.1680151293686;
        Wed, 29 Mar 2023 21:41:33 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:41:33 -0700 (PDT)
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
Subject: [PATCH 12/13] rust: sync: introduce `CondVar`
Date:   Thu, 30 Mar 2023 01:39:53 -0300
Message-Id: <20230330043954.562237-12-wedsonaf@gmail.com>
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

This is the traditional condition variable or monitor synchronisation
primitive. It is implemented with C's `wait_queue_head_t`.

It allows users to release a lock and go to sleep while guaranteeing
that notifications won't be missed. This is achieved by enqueuing a wait
entry before releasing the lock.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |   7 ++
 rust/kernel/sync.rs             |   2 +
 rust/kernel/sync/condvar.rs     | 178 ++++++++++++++++++++++++++++++++
 rust/kernel/sync/lock.rs        |   1 -
 5 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/condvar.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 03656a44a83f..50e7a76d5455 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,6 +8,7 @@
 
 #include <linux/slab.h>
 #include <linux/refcount.h>
+#include <linux/wait.h>
 #include <linux/sched.h>
 
 /* `bindgen` gets confused at certain things. */
diff --git a/rust/helpers.c b/rust/helpers.c
index 96441744030e..8ff2559c1572 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -24,6 +24,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/sched/signal.h>
+#include <linux/wait.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -76,6 +77,12 @@ void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
 
+void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
+{
+	init_wait(wq_entry);
+}
+EXPORT_SYMBOL_GPL(rust_helper_init_wait);
+
 int rust_helper_signal_pending(struct task_struct *t)
 {
 	return signal_pending(t);
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index ed07437d7d55..d6dd0e2c1678 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -8,9 +8,11 @@
 use crate::types::Opaque;
 
 mod arc;
+mod condvar;
 pub mod lock;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
+pub use condvar::CondVar;
 pub use lock::{mutex::Mutex, spinlock::SpinLock};
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
new file mode 100644
index 000000000000..3f528fc7fa48
--- /dev/null
+++ b/rust/kernel/sync/condvar.rs
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A condition variable.
+//!
+//! This module allows Rust code to use the kernel's [`struct wait_queue_head`] as a condition
+//! variable.
+
+use super::{lock::Backend, lock::Guard, LockClassKey};
+use crate::{bindings, init::PinInit, pin_init, str::CStr, task::Task, types::Opaque};
+use core::marker::PhantomPinned;
+use macros::pin_data;
+
+/// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
+#[macro_export]
+macro_rules! new_condvar {
+    ($($name:literal)?) => {
+        $crate::sync::CondVar::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+
+/// A conditional variable.
+///
+/// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
+/// atomically release the given lock and go to sleep. It reacquires the lock when it wakes up. And
+/// it wakes up when notified by another thread (via [`CondVar::notify_one`] or
+/// [`CondVar::notify_all`]) or because the thread received a signal. It may also wake up
+/// spuriously.
+///
+/// Instances of [`CondVar`] need a lock class and to be pinned. The recommended way to create such
+/// instances is with the [`pin_init`](crate::pin_init) and [`new_condvar`] macros.
+///
+/// # Examples
+///
+/// The following is an example of using a condvar with a mutex:
+///
+/// ```
+/// use kernel::sync::{CondVar, Mutex};
+/// use kernel::{new_condvar, new_mutex};
+///
+/// #[pin_data]
+/// pub struct Example {
+///     #[pin]
+///     value: Mutex<u32>,
+///
+///     #[pin]
+///     value_changed: CondVar,
+/// }
+///
+/// /// Waits for `e.value` to become `v`.
+/// fn wait_for_vaue(e: &Example, v: u32) {
+///     let mut guard = e.value.lock();
+///     while *guard != v {
+///         e.value_changed.wait_uninterruptible(&mut guard);
+///     }
+/// }
+///
+/// /// Increments `e.value` and notifies all potential waiters.
+/// fn increment(e: &Example) {
+///     *e.value.lock() += 1;
+///     e.value_changed.notify_all();
+/// }
+///
+/// /// Allocates a new boxed `Example`.
+/// fn new_example() -> Result<Pin<Box<Example>>> {
+///     Box::pin_init(pin_init!(Example {
+///         value <- new_mutex!(0),
+///         value_changed <- new_condvar!(),
+///     }))
+/// }
+/// ```
+///
+/// [`struct wait_queue_head`]: ../../../include/linux/wait.h
+#[pin_data]
+pub struct CondVar {
+    #[pin]
+    pub(crate) wait_list: Opaque<bindings::wait_queue_head>,
+
+    /// A condvar needs to be pinned because it contains a [`struct list_head`] that is
+    /// self-referential, so it cannot be safely moved once it is initialised.
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on any thread.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl Send for CondVar {}
+
+// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on multiple threads
+// concurrently.
+unsafe impl Sync for CondVar {}
+
+impl CondVar {
+    /// Constructs a new condvar initialiser.
+    #[allow(clippy::new_ret_no_self)]
+    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+        pin_init!(Self {
+            _pin: PhantomPinned,
+            // SAFETY: `__init_waitqueue_head` initialises the waitqueue head, and both `name` and
+            // `key` have static lifetimes so they live indefinitely.
+            wait_list <- unsafe {
+                Opaque::ffi_init2(
+                    bindings::__init_waitqueue_head,
+                    name.as_char_ptr(),
+                    key.as_ptr(),
+                )
+            },
+        })
+    }
+
+    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
+        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
+
+        // SAFETY: `wait` points to valid memory.
+        unsafe { bindings::init_wait(wait.get()) };
+
+        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        unsafe {
+            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
+        };
+
+        // SAFETY: No arguments, switches to another thread.
+        guard.do_unlocked(|| unsafe { bindings::schedule() });
+
+        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
+    }
+
+    /// Releases the lock and waits for a notification in interruptible mode.
+    ///
+    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
+    /// thread to sleep, reacquiring the lock on wake up. It wakes up when notified by
+    /// [`CondVar::notify_one`] or [`CondVar::notify_all`], or when the thread receives a signal.
+    /// It may also wake up spuriously.
+    ///
+    /// Returns whether there is a signal pending.
+    #[must_use = "wait returns if a signal is pending, so the caller must check the return value"]
+    pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
+        self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard);
+        Task::current().signal_pending()
+    }
+
+    /// Releases the lock and waits for a notification in uninterruptible mode.
+    ///
+    /// Similar to [`CondVar::wait`], except that the wait is not interruptible. That is, the
+    /// thread won't wake up due to signals. It may, however, wake up supirously.
+    pub fn wait_uninterruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
+        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard)
+    }
+
+    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
+    fn notify(&self, count: i32, flags: u32) {
+        // SAFETY: `wait_list` points to valid memory.
+        unsafe {
+            bindings::__wake_up(
+                self.wait_list.get(),
+                bindings::TASK_NORMAL,
+                count,
+                flags as _,
+            )
+        };
+    }
+
+    /// Wakes a single waiter up, if any.
+    ///
+    /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
+    /// completely (as opposed to automatically waking up the next waiter).
+    pub fn notify_one(&self) {
+        self.notify(1, 0);
+    }
+
+    /// Wakes all waiters up, if any.
+    ///
+    /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
+    /// completely (as opposed to automatically waking up the next waiter).
+    pub fn notify_all(&self) {
+        self.notify(0, 0);
+    }
+}
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index ae20277c39c8..f52ba9ab1b70 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -177,7 +177,6 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
 unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
 
 impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
-    #[allow(dead_code)]
     pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
-- 
2.34.1

