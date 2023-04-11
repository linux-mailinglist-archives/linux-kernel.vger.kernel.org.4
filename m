Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7206DD205
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDKFrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjDKFqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:55 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55030ED;
        Mon, 10 Apr 2023 22:46:33 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bf5so4751688oib.8;
        Mon, 10 Apr 2023 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUkx2cNtJ9nWEz5p2C115hP3yX3TNsqfTu3Xx0TaZoc=;
        b=pPOb333IxbtfUtBRo9n91qNlTUJCGuqiBxRAynTWiqR81UZb2LtF1gQja+MEx2fLx5
         3emHHqVnU/+xcWMwIfqZdT2+/gYDf8VBZtREnQSUIiGf0YMNJLP30JCKSasirTiD4ib0
         kyotpoA4fNA/MPcQmBOCrxoaKP8Bov79k+A2DSEbzjeG79XeK3jkhNTMTHQtIi757H3c
         KjZj/bXM+LPnYMACtpQJaVSrT9fRZ1Q5dJWd2c4PP1m9uLFBHSrElG2ZPazB8AyJfUWw
         uWxrmQpGIaKbwNgAaVTE31CefYBB/O6trikgOkxTH1TxrdKCRFU9wEbNJtKdUc6O17qc
         pAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUkx2cNtJ9nWEz5p2C115hP3yX3TNsqfTu3Xx0TaZoc=;
        b=u250c/B0ChTqXy3E6o6YIrDOwB77XzSf4tQ7kgx4hnrl+E8H+oQ23ftGyIykv/qM3X
         JV+Rov4wrYxVoZ64iOhPGcriX9Q/9WUZY8h3r3simQe9UlzCiARPfRUtch8w05mMOX7E
         pMn/csLOMWUuXhfSNJoBKwy7xlfc3yBVegmll9utc9Uaa8rvQ5tj+6Sw3Y3e5MjDI3KD
         zc12FwHz47jdozno+gbEzTRvg0KcOLWYr3LilaKUmD+v9NN7Gb2pFTHAcOhDMHHHwjAy
         UjLKSdFNGuSj41K2dXXmiUuHsZ7WQ3efzZ0S2icOdhkt73/rw66f1zYWIwJibHaDbbod
         6I5Q==
X-Gm-Message-State: AAQBX9eFzPAco6Y+HSukqZGRqqSGy4IwCOMGOLcwXx599cDtqL4Onj4m
        ZxA+BFXB17brfcmj2t1e+vA/56TFNwc=
X-Google-Smtp-Source: AKy350aIUb9ufRwwZ0Bcs1JFhYVlz1jIu/bGMzWfy4IYhf7dQtikL1NY8+pXN6v8aglt6Iw3hIAxsw==
X-Received: by 2002:a05:6808:a8b:b0:389:5164:9db2 with SMTP id q11-20020a0568080a8b00b0038951649db2mr5896169oij.48.1681191989480;
        Mon, 10 Apr 2023 22:46:29 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:46:29 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 10/13] rust: introduce `current`
Date:   Tue, 11 Apr 2023 02:45:40 -0300
Message-Id: <20230411054543.21278-10-wedsonaf@gmail.com>
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

This allows Rust code to get a reference to the current task without
having to increment the refcount, but still guaranteeing memory safety.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: Make `current` a macro to prevent it from escaping the caller
v2 -> v3:
- Mention `current` macro in `Task::current`
- Hide implementation of `TaskRef` inside `Task::current`
v3 -> v4: Remove impl of `From<TaskRef<'_>>` for `ARef<Task>`

 rust/helpers.c         |  6 ++++
 rust/kernel/prelude.rs |  2 ++
 rust/kernel/task.rs    | 82 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index f545923aedd8..fba3c62a77f1 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -119,6 +119,12 @@ long rust_helper_PTR_ERR(__force const void *ptr)
 }
 EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
 
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
index d70cad131956..526d29a0ae27 100644
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
 
@@ -27,6 +73,40 @@ unsafe impl Sync for Task {}
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
+        struct TaskRef<'a> {
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

