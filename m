Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729886D8547
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjDERxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjDERw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:52:58 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F376AC;
        Wed,  5 Apr 2023 10:52:30 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bx42so11690410oib.6;
        Wed, 05 Apr 2023 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJPRX95Pq0TPwhRdP2GRuAB3gcXMGchPHxgINwURD70=;
        b=hcKVIzrsNxzcyWyQf/GJBa0U2oqIb+9tCiQ2N3+Gt4CzgZj4djzw1r4pq5cDTkV+Sn
         XV14zBPb5qClEkqMH00ekiQFqOt9R799k+4ze4R3d5p5fxEU4+UGvzpyy5z4blw+YFPB
         jx5vRS2v5voiSjdVa/N2bKcLkPUKme1JC09aqhDe7MNf090ssEq4pIfPQ06skJaockXP
         GqU73gwUERq1Q6jOSibsJ5LTTBRR4DGKvqRpOoAfz+JhBsxLgHYOs2aWRKuONsnO7HgA
         cs7VjowL5kbcL4qXwfms+Rb0IHl2T3ouS9D78dYWl2c6BkKccwh/LekLK46E2xdoc5Zm
         rksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJPRX95Pq0TPwhRdP2GRuAB3gcXMGchPHxgINwURD70=;
        b=kU3YTdRonqCKT2dmi4Ma9yK6fLMUubC/Sl8TgwYuTQxGUOj3Im9JIO6rwZWQs+WPV5
         H/C/lPXVhMOBRw1e+qleVGyaz+w/uD/T5ADz6icGKdYM30hzD4uIyd/O26h4gq9pxfjp
         zv5dV193u71t0BYo9sbVSL1SmbIOh8B4WDe2nnnkKpWiKh/pAXDoEoRFUNv4NOPdgww+
         ddryOlH8hQjkKuhItV5hxMNqNPIpbR95o+/h3b55lPMOnpRsf6Xg7IjMJytQq0gzs/X+
         nuBG4zR9miaXE6XBI5fhBoGAEzUJZBDfD2Lr2QJ373FitgHJaLAkCA6DPMj5xPp4ZC0q
         3lwg==
X-Gm-Message-State: AAQBX9esOUO9F9DZouQSQieyk/WwlQS+d2dhAOI+eDLeZIwXHKx5OkLC
        q0b7AX+aHVdyj2nrptwhEhBPlJuiqZHy3Q==
X-Google-Smtp-Source: AKy350Zj5AW2NOZqsqgU1FEbyrE2+tYzi8kc4T+n3G/yDjtpVBZFBrg8qdGig43RD1K4QCT+9t9yRg==
X-Received: by 2002:a05:6808:1492:b0:386:cb87:d205 with SMTP id e18-20020a056808149200b00386cb87d205mr4353982oiw.47.1680717146507;
        Wed, 05 Apr 2023 10:52:26 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id w185-20020aca62c2000000b003896e31867esm6604045oib.49.2023.04.05.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:52:26 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 10/13] rust: introduce `current`
Date:   Wed,  5 Apr 2023 14:51:08 -0300
Message-Id: <20230405175111.5974-10-wedsonaf@gmail.com>
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

This allows Rust code to get a reference to the current task without
having to increment the refcount, but still guaranteeing memory safety.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: Make `current` a macro to prevent it from escaping the caller

 rust/helpers.c         |  6 +++
 rust/kernel/prelude.rs |  2 +
 rust/kernel/task.rs    | 93 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 58a194042c86..96441744030e 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -100,6 +100,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
 }
 EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
 
+struct task_struct *rust_helper_get_current(void)
+{
+	return current;
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_current);
+
 void rust_helper_get_task_struct(struct task_struct *t)
 {
 	get_task_struct(t);
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index fcdc511d2ce8..c28587d68ebc 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -36,3 +36,5 @@ pub use super::error::{code::*, Error, Result};
 pub use super::{str::CStr, ThisModule};
 
 pub use super::init::{InPlaceInit, Init, PinInit};
+
+pub use super::current;
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 8d7a8222990f..468387a5f7eb 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -5,7 +5,17 @@
 //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
 
 use crate::bindings;
-use core::{cell::UnsafeCell, ptr};
+use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, ptr};
+
+/// Returns the currently running task.
+#[macro_export]
+macro_rules! current {
+    () => {
+        // SAFETY: Deref + addr-of below create a temporary `TaskRef` that cannot outlive the
+        // caller.
+        unsafe { &*$crate::task::Task::current() }
+    };
+}
 
 /// Wraps the kernel's `struct task_struct`.
 ///
@@ -13,6 +23,42 @@ use core::{cell::UnsafeCell, ptr};
 ///
 /// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
 /// that the allocation remains valid at least until the matching call to `put_task_struct`.
+///
+/// # Examples
+///
+/// The following is an example of getting the PID of the current thread with zero additional cost
+/// when compared to the C version:
+///
+/// ```
+/// let pid = current!().pid();
+/// ```
+///
+/// Getting the PID of the current process, also zero additional cost:
+///
+/// ```
+/// let pid = current!().group_leader().pid();
+/// ```
+///
+/// Getting the current task and storing it in some struct. The reference count is automatically
+/// incremented when creating `State` and decremented when it is dropped:
+///
+/// ```
+/// use kernel::{task::Task, types::ARef};
+///
+/// struct State {
+///     creator: ARef<Task>,
+///     index: u32,
+/// }
+///
+/// impl State {
+///     fn new() -> Self {
+///         Self {
+///             creator: current!().into(),
+///             index: 0,
+///         }
+///     }
+/// }
+/// ```
 #[repr(transparent)]
 pub struct Task(pub(crate) UnsafeCell<bindings::task_struct>);
 
@@ -25,6 +71,24 @@ unsafe impl Sync for Task {}
 type Pid = bindings::pid_t;
 
 impl Task {
+    /// Returns a task reference for the currently executing task/thread.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the returned [`TaskRef`] doesn't outlive the current task/thread.
+    pub unsafe fn current<'a>() -> TaskRef<'a> {
+        // SAFETY: Just an FFI call with no additional safety requirements.
+        let ptr = unsafe { bindings::get_current() };
+
+        TaskRef {
+            // SAFETY: If the current thread is still running, the current task is valid. Given
+            // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
+            // (where it could potentially outlive the caller).
+            task: unsafe { &*ptr.cast() },
+            _not_send: PhantomData,
+        }
+    }
+
     /// Returns the group leader of the given task.
     pub fn group_leader(&self) -> &Task {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
@@ -69,3 +133,30 @@ unsafe impl crate::types::AlwaysRefCounted for Task {
         unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }
     }
 }
+
+/// A wrapper for a shared reference to [`Task`] that isn't [`Send`].
+///
+/// We make this explicitly not [`Send`] so that we can use it to represent the current thread
+/// without having to increment/decrement the task's reference count.
+///
+/// # Invariants
+///
+/// The wrapped [`Task`] remains valid for the lifetime of the object.
+pub struct TaskRef<'a> {
+    task: &'a Task,
+    _not_send: PhantomData<*mut ()>,
+}
+
+impl Deref for TaskRef<'_> {
+    type Target = Task;
+
+    fn deref(&self) -> &Self::Target {
+        self.task
+    }
+}
+
+impl From<TaskRef<'_>> for crate::types::ARef<Task> {
+    fn from(t: TaskRef<'_>) -> Self {
+        t.deref().into()
+    }
+}
-- 
2.34.1

