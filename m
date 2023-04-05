Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630336D8546
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjDERxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjDERw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:52:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FB37A9E;
        Wed,  5 Apr 2023 10:52:24 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y184so27232400oiy.8;
        Wed, 05 Apr 2023 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uocgwe3402X+SGxBrEAOB8aX32adol5RFJ3Rm7rkR1M=;
        b=H3b5JZrXjwVVxh77g6AfD4FgP2iz9QMuIN26A643ILL/PT2nI2gwzcwQ3aRhdCWr5h
         oMJdzkZ1ycexjNw/7i70b3yc7mqOAPNNWFVh4tNUyPb7o/SxmN4F7htwm3QHQnF8OhSM
         uoXh2V9/hpmkRz1aa28P+CDh9vDNRof/ZsLHCh/4amlnOlr1O7EtOUSK2PbTzraTBd1V
         F6QH83tfMRTdQ5To7gYPt0LKZq3XZC1Ty98eoZP9KfbxM3t94rbgOG9SV3W39n3dFHQx
         jK8ZUBaj8UZO/WCePVLvesyjnDWHSxB3jnWb7elRwj9r+HHCs8AWjS+pIAe1dWCQEgNI
         MGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uocgwe3402X+SGxBrEAOB8aX32adol5RFJ3Rm7rkR1M=;
        b=CfgFrD51/Hy+JNeEujlM+eeRnmOlj4VOw91m49F0pzhgoewT5cnLs2dxS96cO9YvWo
         4cuAU6SvvoDY5/M5+zn0gIrDEeU5I+IMNuFqND3+fr8ZVmA7gojb9NJwLyHejOQpOVly
         +ZJRIChPD3opKjU6RCLKpB8jBzVaqF64LlXbTy6P8kUxfDK9SZ7Y5E0GiINJs7H+Cw6Z
         MPbbURDDg0a4RZeB+7WHSlmVwhZOtG9LOtb2ogMnzNC8FGINuA1RDqHum4nkUFAqRMR5
         xxeHIVU9fbxw4Cend+Od+8ywdTnI1dyG30kJnKUtpH8uDFVAo+2eAfepPySj+ffezHaH
         CZ2A==
X-Gm-Message-State: AAQBX9dE9QOzuw7M3P8V4HSBYuAssMAv/oTrvauoB5HYMSjTq2ul32p+
        uQiicFRcu8OODxvkK1CujTVPXXJ2d4Ftgw==
X-Google-Smtp-Source: AKy350YdOR6XafL6LLs8EhMmE8t5N0qDjK5pFrOqE++Ms5F1Drd5aMITMimftNQFj3AuBAoNanRmyg==
X-Received: by 2002:a05:6808:b39:b0:38b:6b17:f72a with SMTP id t25-20020a0568080b3900b0038b6b17f72amr892617oij.3.1680717141396;
        Wed, 05 Apr 2023 10:52:21 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id w185-20020aca62c2000000b003896e31867esm6604045oib.49.2023.04.05.10.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:52:21 -0700 (PDT)
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
Subject: [PATCH v2 09/13] rust: add basic `Task`
Date:   Wed,  5 Apr 2023 14:51:07 -0300
Message-Id: <20230405175111.5974-9-wedsonaf@gmail.com>
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

It is an abstraction for C's `struct task_struct`. It implements
`AlwaysRefCounted`, so the refcount of the wrapped object is managed
safely on the Rust side.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes

 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 19 +++++++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/task.rs             | 71 +++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)
 create mode 100644 rust/kernel/task.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 75d85bd6c592..03656a44a83f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,6 +8,7 @@
 
 #include <linux/slab.h>
 #include <linux/refcount.h>
+#include <linux/sched.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/helpers.c b/rust/helpers.c
index e42f5b446f92..58a194042c86 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/refcount.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/sched/signal.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -75,6 +76,12 @@ void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
 
+int rust_helper_signal_pending(struct task_struct *t)
+{
+	return signal_pending(t);
+}
+EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
+
 refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
@@ -93,6 +100,18 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
 }
 EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
 
+void rust_helper_get_task_struct(struct task_struct *t)
+{
+	get_task_struct(t);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_task_struct);
+
+void rust_helper_put_task_struct(struct task_struct *t)
+{
+	put_task_struct(t);
+}
+EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index d9df77132fa2..4e1d5ba2e241 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -43,6 +43,7 @@ mod static_assert;
 pub mod std_vendor;
 pub mod str;
 pub mod sync;
+pub mod task;
 pub mod types;
 
 #[doc(hidden)]
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
new file mode 100644
index 000000000000..8d7a8222990f
--- /dev/null
+++ b/rust/kernel/task.rs
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Tasks (threads and processes).
+//!
+//! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
+
+use crate::bindings;
+use core::{cell::UnsafeCell, ptr};
+
+/// Wraps the kernel's `struct task_struct`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
+/// that the allocation remains valid at least until the matching call to `put_task_struct`.
+#[repr(transparent)]
+pub struct Task(pub(crate) UnsafeCell<bindings::task_struct>);
+
+// SAFETY: It's OK to access `Task` through references from other threads because we're either
+// accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
+// synchronised by C code (e.g., `signal_pending`).
+unsafe impl Sync for Task {}
+
+/// The type of process identifiers (PIDs).
+type Pid = bindings::pid_t;
+
+impl Task {
+    /// Returns the group leader of the given task.
+    pub fn group_leader(&self) -> &Task {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        let ptr = unsafe { *ptr::addr_of!((*self.0.get()).group_leader) };
+
+        // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
+        // and given that a task has a reference to its group leader, we know it must be valid for
+        // the lifetime of the returned task reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the PID of the given task.
+    pub fn pid(&self) -> Pid {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        unsafe { *ptr::addr_of!((*self.0.get()).pid) }
+    }
+
+    /// Determines whether the given task has pending signals.
+    pub fn signal_pending(&self) -> bool {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        unsafe { bindings::signal_pending(self.0.get()) != 0 }
+    }
+
+    /// Wakes up the task.
+    pub fn wake_up(&self) {
+        // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
+        // And `wake_up_process` is safe to be called for any valid task, even if the task is
+        // running.
+        unsafe { bindings::wake_up_process(self.0.get()) };
+    }
+}
+
+// SAFETY: The type invariants guarantee that `Task` is always ref-counted.
+unsafe impl crate::types::AlwaysRefCounted for Task {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_task_struct(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }
+    }
+}
-- 
2.34.1

