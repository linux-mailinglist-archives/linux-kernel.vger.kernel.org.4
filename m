Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDCF6CFA55
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjC3EmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjC3Elv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:41:51 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408387295;
        Wed, 29 Mar 2023 21:41:25 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17683b570b8so18516016fac.13;
        Wed, 29 Mar 2023 21:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaygZpxwnfzBcLtVwosxyCaJLz/HPg5F8ZKIQhWNoz4=;
        b=FXwYLvrIzNZooIRqEXJqa42IDRe+8JDe2VQoZkMZuHOEcfRdn08oqkv775h8AUEPhr
         VZOsHttuI0VIspAYJOPt+At7ZMsiWn6j0wNa43Av9xDCqbJet7GunO0Wa4jrQ4rm0mfP
         4U7FZGZYhIBZCmpV8m108tEsQViHPoE+fUU7a5b1/B6/k5MQRcI+6GtnaFurUZA+AjBx
         JnEmRrtLnioJ51uu2QXp1WJ8ziQF53zY2xaCGEcOAAU5lwY2OXqWlVtpVjbfIfdIcynU
         CrT1EgHq9/TV1c8no5FMUS9cLfZLNDV10Wq2g2VJ0M9tK6NoQdzqmfoR1fyEf6/8x7hp
         BvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaygZpxwnfzBcLtVwosxyCaJLz/HPg5F8ZKIQhWNoz4=;
        b=llVRs/xwipp41Ff97GxmACqOzcnvkUqvj/RzRdw38IAR74HXyJ2qBzfsRSnFCH+fel
         sLDgKCxkmd14fcbuhyvvzboZ9hnxLPlZHY/Ypewbj2ztAAykteusvh2etXvrlNC1VR1W
         kW7EXLuKA+w8Cr8D/NhF19uy+PVSB0uT7BugLX6iwz7twbRcpuEVWbo7VEXLFykmmdP4
         pg9Ku/4zKF87i6Ph4rJWqotdRTYcb21oqm58zwCORV+1SGtudkEERMFdf5uoVFEpuMNP
         wGXLfPE63lWJQ7CnzQkgQOZWB0vaSt2GP0Wlc6LrsySQGDOgijtVkKGjSHVBhJSETHVd
         f0Kw==
X-Gm-Message-State: AO0yUKUFC65PnvCx0qN4lmiSagHswUuVBRFm89F3IQ364PG9RzZM8tqW
        hTkrCLt7gge4BWVegUiDAma+SknuEYcyJw==
X-Google-Smtp-Source: AK7set+eOnFbB94Hz3P+ztcnE3+thRBZ3RrZe/glRuFzYzPzFGQHWHwaLEhh4j9fC5uvv3Z7vZpj4w==
X-Received: by 2002:a05:6870:459f:b0:177:9b62:6b7e with SMTP id y31-20020a056870459f00b001779b626b7emr14014751oao.24.1680151284471;
        Wed, 29 Mar 2023 21:41:24 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:41:24 -0700 (PDT)
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
Subject: [PATCH 10/13] rust: introduce `Task::current`
Date:   Thu, 30 Mar 2023 01:39:51 -0300
Message-Id: <20230330043954.562237-10-wedsonaf@gmail.com>
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

This allows Rust code to get a reference to the current task without
having to increment the refcount, but still guaranteeing memory safety.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c      |  6 ++++
 rust/kernel/task.rs | 83 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

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
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 8d7a8222990f..8b2b56ba9c6d 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
 
 use crate::bindings;
-use core::{cell::UnsafeCell, ptr};
+use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, ptr};
 
 /// Wraps the kernel's `struct task_struct`.
 ///
@@ -13,6 +13,46 @@ use core::{cell::UnsafeCell, ptr};
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
+/// use kernel::task::Task;
+///
+/// let pid = Task::current().pid();
+/// ```
+///
+/// Getting the PID of the current process, also zero additional cost:
+///
+/// ```
+/// use kernel::task::Task;
+///
+/// let pid = Task::current().group_leader().pid();
+/// ```
+///
+/// Getting the current task and storing it in some struct. The reference count is automatically
+/// incremented when creating `State` and decremented when it is dropped:
+///
+/// ```
+/// use kernel::{task::Task, ARef};
+///
+/// struct State {
+///     creator: ARef<Task>,
+///     index: u32,
+/// }
+///
+/// impl State {
+///     fn new() -> Self {
+///         Self {
+///             creator: Task::current().into(),
+///             index: 0,
+///         }
+///     }
+/// }
+/// ```
 #[repr(transparent)]
 pub struct Task(pub(crate) UnsafeCell<bindings::task_struct>);
 
@@ -25,6 +65,20 @@ unsafe impl Sync for Task {}
 type Pid = bindings::pid_t;
 
 impl Task {
+    /// Returns a task reference for the currently executing task/thread.
+    pub fn current<'a>() -> TaskRef<'a> {
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
@@ -69,3 +123,30 @@ unsafe impl crate::types::AlwaysRefCounted for Task {
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

