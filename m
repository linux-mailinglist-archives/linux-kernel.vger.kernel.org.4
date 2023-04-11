Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108C86DD204
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjDKFrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjDKFqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:51 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7DE3C0C;
        Mon, 10 Apr 2023 22:46:27 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id j4-20020a4adf44000000b0053e8b5524abso5075163oou.2;
        Mon, 10 Apr 2023 22:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0ZE9/PqwNMu99Q0OKeqOYCNEDEQw5CDxMBCw+OXX00=;
        b=mqGSpDZsCP5tkLznKrmzxgqdN62WfnN72WO/PfyFOmSJrUGQwMDaWi1IHJjbaqfOMa
         O5Y52+zouWSEMqwKzoh3zGloHd5rieZMJBAneMVXlP5txO6dTFkxlzkMSivTj/qG/4Et
         k9SNJgL/+Db66lMKLNac76SUYR8NQX2GcGXr1mkTpXGlyHXFUzTH/3sQSWgn5rzqPAf7
         Fa6dqupfXRrcudj0/+QrZQLGX+DaqNO1NggqVgsM6nZ75QcySN/8IBWeVCtIY2IDY/Fi
         5ULW2HAe/pWQc+/ROjaey6YRpEnwLXJwbaRa0MYjxM+96N0TIXnClFlY3vvWMe80qhNg
         zf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0ZE9/PqwNMu99Q0OKeqOYCNEDEQw5CDxMBCw+OXX00=;
        b=uIfY8UP6jGsdtWcjBEcos1rLBKjonHn1bxAjmyvi6Ae3gya7mXpeU76ztmVEOretcP
         /gX0SZdzm3MKL2rw4PUUi5SWXRFP+KWi7/3eENgw5IWF61jrZvF1ZG9x5y6A4VLToc6f
         E29T6hceKH5IWX2YJg5dZNdKpN7wno1aqLe6acL1vCEhRAWjV5XJ0JjkD5eknJtFwUMc
         Cyqt1eaJym/WftjZvlqqc7cBsc/K9W5WtGJlHasHWnUzKtzyJV5hdGMUaToAaeidIUfE
         WQMaXPdyKwdfI7J1lQEdndgORnPtRKI5s3yxmW56Lru2GirZTmenVNqWkCCGfYVVs5fi
         srLg==
X-Gm-Message-State: AAQBX9cShJ965h3LvLvw61QaCl7j2g6+nCF+7Y0QMCGoJkuUCJrztJza
        1Mnua/MBpt18ppjU/rzJRMTf0/onjP4=
X-Google-Smtp-Source: AKy350Z5U7CzoNvxPNOQjiEQSioJnxuxpFmfp8CJRlGMpr9YViozuVxMkXR/GK7v39NGTuvm5RV8YA==
X-Received: by 2002:a4a:49d1:0:b0:525:4316:7dac with SMTP id z200-20020a4a49d1000000b0052543167dacmr605537ooa.5.1681191985907;
        Mon, 10 Apr 2023 22:46:25 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:46:25 -0700 (PDT)
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
Subject: [PATCH v4 09/13] rust: add basic `Task`
Date:   Tue, 11 Apr 2023 02:45:39 -0300
Message-Id: <20230411054543.21278-9-wedsonaf@gmail.com>
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

It is an abstraction for C's `struct task_struct`. It implements
`AlwaysRefCounted`, so the refcount of the wrapped object is managed
safely on the Rust side.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: Wrap task_struct with `Opaque` instead of `UnsafeCell`
v3 -> v4: No changes

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
index efd5b1e86f6e..f545923aedd8 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -24,6 +24,7 @@
 #include <linux/refcount.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/sched/signal.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -76,6 +77,12 @@ void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
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
@@ -112,6 +119,18 @@ long rust_helper_PTR_ERR(__force const void *ptr)
 }
 EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
 
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

