Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352CC6DB969
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjDHHzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjDHHzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:55:00 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D916BFF0E;
        Sat,  8 Apr 2023 00:54:37 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w13so21006233oik.2;
        Sat, 08 Apr 2023 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRp/Oi/twJtl9aBTzuC+WObtxL9OqDuPbUJ1RtXTIfI=;
        b=R0+rGcdc6V1X+oez522zCJPvrVawIDxgxs86xe/wj1vfkFDC7N1DW0NXAtwgMp3+Vf
         RVoANubvriftXet27shk9KqP91cndUhCZpnsjDM/c33w5pemyGG8Tbwf+amF7KOlG7r0
         AefeM63JNjreEDh/teGas2knHKSup6KUnX9XkRxwJTKMjvIuZkq0cp9XqvuwwpT6j6bd
         A1kKj7KumT8XVxZ9IyqX328eKB1PGCL9ct9317CwvwXveaCXgSP50MHirVijn4j0zDQB
         l4qFUmPcmViLJHRoLpZBfiIT8LXHRAk2KUzqNcgDtHIE72esLNq3zPxKfUd9h77cyFJX
         NPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRp/Oi/twJtl9aBTzuC+WObtxL9OqDuPbUJ1RtXTIfI=;
        b=wLG3wiogwoMTq9syr66w+S/yC+3lL7epmS9oNT3md2viZmv9/Ric4Zmwsqz6mLrORO
         HFN9cz2nftrfWdvBUysG0dZBr/hcxBAwpgoSm0nvMB7axR+UxcH5DtAOYn9V8B12eGXz
         AhMUQ2JVzqlZ6s1L3ynCIokBKG3JXr1l6goUHSbTURV5IdW/XK4OGL/PqxeMEAzO7Wmi
         JZEXGFEzNr6HFcb10zs9vRXKqK5HFNZcdN3ciFJ+6GtebCDA0TBPLrx/kAYrDCCKRr/J
         jwEq4nvycI32p91AMves0JUuwaIW6Z51ab+NRJFDkcehsCiExIQ1kRAkHT6DcB9+WWgi
         rEgQ==
X-Gm-Message-State: AAQBX9fzhgaMQRv5KFmkU4WDBtqqSsayu9UJcK8+eGNhs2fZ5mdgjNX9
        BwrYcG8eEvA/Tj9Q9mWzongyxIeThsw=
X-Google-Smtp-Source: AKy350buTh+bhmz+hvu0w5SxbhLyyETFn1ixkdjrYZvxz2w1i0UCeDVJhgYrLQF2lRoJLzE0Rpxv3A==
X-Received: by 2002:a54:4402:0:b0:387:87cd:11c6 with SMTP id k2-20020a544402000000b0038787cd11c6mr526748oiw.59.1680940463390;
        Sat, 08 Apr 2023 00:54:23 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:54:23 -0700 (PDT)
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
Subject: [PATCH v3 10/13] rust: introduce `current`
Date:   Sat,  8 Apr 2023 04:53:37 -0300
Message-Id: <20230408075340.25237-10-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230408075340.25237-1-wedsonaf@gmail.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
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
v2 -> v3:
- Mention `current` macro in `Task::current`
- Hide implementation of `TaskRef` inside `Task::current`

 rust/helpers.c         |  6 +++
 rust/kernel/prelude.rs |  2 +
 rust/kernel/task.rs    | 88 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 1 deletion(-)

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
index d70cad131956..5269a562cb1b 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -5,7 +5,17 @@
 //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
 
 use crate::{bindings, types::Opaque};
-use core::ptr;
+use core::{marker::PhantomData, ops::Deref, ptr};
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
@@ -15,6 +25,42 @@ use core::ptr;
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
 pub struct Task(pub(crate) Opaque<bindings::task_struct>);
 
@@ -27,6 +73,46 @@ unsafe impl Sync for Task {}
 type Pid = bindings::pid_t;
 
 impl Task {
+    /// Returns a task reference for the currently executing task/thread.
+    ///
+    /// The recommended way to get the current task/thread is to use the
+    /// [`current`](crate::current) macro because it is safe.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the returned object doesn't outlive the current task/thread.
+    pub unsafe fn current() -> impl Deref<Target = Task> {
+        pub struct TaskRef<'a> {
+            task: &'a Task,
+            _not_send: PhantomData<*mut ()>,
+        }
+
+        impl Deref for TaskRef<'_> {
+            type Target = Task;
+
+            fn deref(&self) -> &Self::Target {
+                self.task
+            }
+        }
+
+        impl From<TaskRef<'_>> for crate::types::ARef<Task> {
+            fn from(t: TaskRef<'_>) -> Self {
+                t.deref().into()
+            }
+        }
+
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
         // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
-- 
2.34.1

