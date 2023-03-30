Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0946CFA54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC3EmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjC3Elq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:41:46 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234EB6E85;
        Wed, 29 Mar 2023 21:41:20 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-17e140619fdso18534384fac.11;
        Wed, 29 Mar 2023 21:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAQl24uzq/qZWkhqH1HEWNCra09kYwVNNfNYBWyzFHM=;
        b=c7DhaZZtXvNu6XNyp2FpwbhUnTBCh5j2kl0MvRgvUaucf3SOtXT2Zso06U+9WU6N71
         GutSJ/y0hGfHiHkX6C56QJx92QIqI6V87rjiKMMo+GVFyyxux9Mt9V7P9QA1Oa8tM5vB
         k6Ro6gFWBJLRI/TEdwkR9Og0XKpy++cn3rlXtXA5PSsHT8mQt8id1ByOBAl7ouBBLHET
         UEXog1W1s9WBJHFjZFnRytAznRonVGYRv4tA1+mIgai4Br5Ba5arMXxSUyfwH2v4N68T
         r/k2DKFipjJ5ScrTfRDd3TUdXzDXJoF+5eOjZwE8yBtXNAws0oCS3+0wqQEA/xqA4ym2
         e7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAQl24uzq/qZWkhqH1HEWNCra09kYwVNNfNYBWyzFHM=;
        b=Y2FQAN02G5I3Pm4Y0fhVDnb9ckvk+4LNRNafkHEbylnShiLKLU4ktozoVU3QLGrGy5
         e1VzDznAkb5qP7BT55mJ9cb4GWAyJjTjVsua4wx4rIXY4zLLloP++PUBgIvdq94wf/el
         v7bqgTH0/hsLuI/USmvQaoRe5SA35/k/OiZWblsUrBE9LeuUEK6qo6hEZpNKPZam65lj
         rE1V4mP+0aIRV23qK0FOg0KyyEroSp0BnlQD+H5YXdmSMUo1Tw1TDqCJQwsVeI5qe4gq
         j97SPDZKqznv4nIqT4QltVpyPSYugE7agKnFLKOcMIZw2JbQN8Xfmzpwibib5UHHUyPG
         IXsQ==
X-Gm-Message-State: AAQBX9ecyGCLQmY9msBSCpiXJoklwEo2pS7pP+RPmG9EzqOsNp4YY+G7
        dEb2rG+8EyP9p66J0aO/r0tgaC3gp16s3w==
X-Google-Smtp-Source: AK7set/7niKzCep7Te3mkuWxsyYOcN5wMxsptqPzrXMhs3yexEz/aFPb1V4/UdKTLx0iwqYXr9tLpA==
X-Received: by 2002:a05:6870:899c:b0:17b:1a4f:adfe with SMTP id f28-20020a056870899c00b0017b1a4fadfemr12302843oaq.10.1680151279864;
        Wed, 29 Mar 2023 21:41:19 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:41:19 -0700 (PDT)
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
Subject: [PATCH 09/13] rust: add basic `Task`
Date:   Thu, 30 Mar 2023 01:39:50 -0300
Message-Id: <20230330043954.562237-9-wedsonaf@gmail.com>
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

It is an abstraction for C's `struct task_struct`. It implements
`AlwaysRefCounted`, so the refcount of the wrapped object is managed
safely on the Rust side.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
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

