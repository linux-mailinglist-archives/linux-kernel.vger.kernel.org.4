Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584B56DB968
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjDHHzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDHHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:54:42 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A8DFF1F;
        Sat,  8 Apr 2023 00:54:20 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id g26-20020a4adc9a000000b0053b9059edd5so101149oou.3;
        Sat, 08 Apr 2023 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpFbdZW6Pxs9oGadShmf3bb76khn+lS3nRvJuJ63DD0=;
        b=dIU1A+nMC99Mw/TCI+3ztwstU57Nl2JuzV3JEDMAiZU0C2mRTMt1HryblDXwlVIueV
         Qofw33OMnSkvEB7CS+UoM1o9a2uQN7Ajp4/8Cghfxe5/c41+dpsRgWuHJWwcbEUrmX0b
         FcOIEUpowOsDXTOFDiK+gbbkNhe6fUsokP9LjDi1VhXeq11SqSgcZv0LiMmGaDPIbrIq
         oDJMWoQof0Om8rrG/sAGQO6FvSjfZZqUFxw78zNEV1jGlpHz1oCWG+tw0r6NTkkWytTU
         1J7bdoyO5xZcPY95KhWSLogDNXd2FsD7e4841nkxDx6LwYtOjpTCoKV2w8kOHIhQ80AO
         N1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpFbdZW6Pxs9oGadShmf3bb76khn+lS3nRvJuJ63DD0=;
        b=RnSIAhyyl9K1xOBufXiu/c2FKP0CAU+0dLxDBTSTBRC66d71ReS3S55dl5Xx+tuNTA
         ihsu2iGGyIU8Ir8a0/D/O5FbHELEpCmDhnqRz6xDHvr+8Oco2q5f1e4mfTXjchMsNp+G
         5DczyCmEv+aA2Fx9lXDcDoYzm5XNNVte3vKuocUWi2cmB+j6jFpc13hpLtg2PG0moXdX
         nnyPeRygkmzoBcv0b0z+9DCpVAxcVAQPMVTAjf/rUUfb1zNzH5K5mKb4B1rnd+gJJ6mg
         S+bYhIDW5qy2WYAEBTwghZPo3bVCOAjjRuT9CPI6uCPPIIg6gtoLp1Zc6mG5iZoTxXDT
         EoCA==
X-Gm-Message-State: AAQBX9fN8FEmiR7qr6ujWjs26arCcLWl0GmptdrsJuxZAzk5ozU0GuC0
        1yE3q421nsY+5KoOWO5fVtjZ4M39yrc=
X-Google-Smtp-Source: AKy350Zw6rXRMrO3wk5tXcrveCg8embkQDmrGpkMiemd4wOUNoEkRL9aBmSolGay0fgtfD/RoUJauA==
X-Received: by 2002:a4a:d62e:0:b0:538:57d4:2d62 with SMTP id n14-20020a4ad62e000000b0053857d42d62mr2164321oon.2.1680940460231;
        Sat, 08 Apr 2023 00:54:20 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:54:20 -0700 (PDT)
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
Subject: [PATCH v3 09/13] rust: add basic `Task`
Date:   Sat,  8 Apr 2023 04:53:36 -0300
Message-Id: <20230408075340.25237-9-wedsonaf@gmail.com>
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

It is an abstraction for C's `struct task_struct`. It implements
`AlwaysRefCounted`, so the refcount of the wrapped object is managed
safely on the Rust side.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: Wrap task_struct with `Opaque` instead of `UnsafeCell`

 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 19 +++++++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/task.rs             | 75 +++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
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
index 2d7606135ef6..ee27e10da479 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,6 +44,7 @@ mod static_assert;
 pub mod std_vendor;
 pub mod str;
 pub mod sync;
+pub mod task;
 pub mod types;
 
 #[doc(hidden)]
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
new file mode 100644
index 000000000000..d70cad131956
--- /dev/null
+++ b/rust/kernel/task.rs
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Tasks (threads and processes).
+//!
+//! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
+
+use crate::{bindings, types::Opaque};
+use core::ptr;
+
+/// Wraps the kernel's `struct task_struct`.
+///
+/// # Invariants
+///
+/// All instances are valid tasks created by the C portion of the kernel.
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
+/// that the allocation remains valid at least until the matching call to `put_task_struct`.
+#[repr(transparent)]
+pub struct Task(pub(crate) Opaque<bindings::task_struct>);
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
+        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
+        // have a valid group_leader.
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
+        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
+        // have a valid pid.
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

