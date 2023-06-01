Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17770719ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjFANu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFANux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:50:53 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE884129
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:50:51 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-94a348facbbso65753966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685627450; x=1688219450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuSvyE3H/lsB/N9LBubh06h32izpsOqcuowYerHxhqc=;
        b=FyvVJlD2CGIUJvNbQZbNEYbMCpjM2wfkXCGCXQdGdxbllqs61y+dOimrUiXITslDnr
         L0xzV3vfgwdACLzxRZt2w/DUr0I0hVp38FptQFQB6p9HI8WTeYEqxuLkrzz5udg311TU
         P31I2p4lYUs39xALew33gD26gaTMk5tNQ6oSCPSJoYX0pP5ep3b5P0RNsM1r1kT4n/fe
         iI4kk5O3HoJfozo7oHD16yShr/tg4SPDVzuEmF1fYUSe19h8vKIorMgbuPFZHd/uKeEN
         9035Iz0htSCg+0b9FgqdQzj12QUgODRxB+tsT3VI3//m07btmf13UfCNEU/ZNeURTvpq
         Knhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627450; x=1688219450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuSvyE3H/lsB/N9LBubh06h32izpsOqcuowYerHxhqc=;
        b=PphalykoE+g5objEglB5to6coQbd1WH/nF5j+JplrZ6IjNDtF30j2nNV7VPcODTt9t
         IOzLIFhyspTCpHaSrJXW9yM3ZZTyWXCR/IvmzmAibI1TMCWm90VsXsUNWCJrqCS3IGU2
         98gQnd16N6hJ/DmoAivcf6eFnu4D7uo5VUt5OyDIZ7J3smAvIfmrWjlhXLCMGhT89FMn
         LetAArXQyRA6nHpsk9bCSnW9lh1+yaAncXlp+fci8MNbhM++fBxVv2xaMtXPe8TNK5JX
         vhsWKFqgz1snlCVQStlJLd4jPd80VcG8DIpnpj7fW/H6yvQwhZjuumZbOgIrCGM+IInc
         EcXA==
X-Gm-Message-State: AC+VfDyEmreYFa+HYOnjp/C8Jvwv98XVNhEqnYAhXUcgeEQn6Hud6O4d
        KFBgLPhs+oxB3AnX8M5KezCAwPxCbav98aY=
X-Google-Smtp-Source: ACHHUZ6TR3gcEhy6cUHWUaknBY4LOpR/0VQfiptgYOtwdk6sQS7UXBw3mwnxPT2zlqGTkevpuGugbzKDFTYvcnc=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:270c:b0:96f:ddeb:9e8c with SMTP
 id w12-20020a170907270c00b0096fddeb9e8cmr3366915ejk.6.1685627450568; Thu, 01
 Jun 2023 06:50:50 -0700 (PDT)
Date:   Thu,  1 Jun 2023 13:49:39 +0000
In-Reply-To: <20230601134946.3887870-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230601134946.3887870-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601134946.3887870-2-aliceryhl@google.com>
Subject: [PATCH v2 1/8] rust: workqueue: add low-level workqueue bindings
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define basic low-level bindings to a kernel workqueue. The API defined
here can only be used unsafely. Later commits will provide safe
wrappers.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/workqueue.rs        | 107 ++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 rust/kernel/workqueue.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 50e7a76d5455..ae2e8f018268 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/workqueue.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 85b261209977..eaded02ffb01 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -43,6 +43,7 @@
 pub mod sync;
 pub mod task;
 pub mod types;
+pub mod workqueue;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
new file mode 100644
index 000000000000..9c630840039b
--- /dev/null
+++ b/rust/kernel/workqueue.rs
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Work queues.
+//!
+//! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
+
+use crate::{bindings, types::Opaque};
+
+/// A kernel work queue.
+///
+/// Wraps the kernel's C `struct workqueue_struct`.
+///
+/// It allows work items to be queued to run on thread pools managed by the kernel. Several are
+/// always available, for example, `system`, `system_highpri`, `system_long`, etc.
+#[repr(transparent)]
+pub struct Queue(Opaque<bindings::workqueue_struct>);
+
+// SAFETY: Kernel workqueues are usable from any thread.
+unsafe impl Send for Queue {}
+unsafe impl Sync for Queue {}
+
+impl Queue {
+    /// Use the provided `struct workqueue_struct` with Rust.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the provided raw pointer is not dangling, that it points at a
+    /// valid workqueue, and that it remains valid until the end of 'a.
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::workqueue_struct) -> &'a Queue {
+        // SAFETY: The `Queue` type is `#[repr(transparent)]`, so the pointer cast is valid. The
+        // caller promises that the pointer is not dangling.
+        unsafe { &*(ptr as *const Queue) }
+    }
+
+    /// Enqueues a work item.
+    ///
+    /// This may fail if the work item is already enqueued in a workqueue.
+    ///
+    /// The work item will be submitted using `WORK_CPU_UNBOUND`.
+    pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
+    where
+        W: RawWorkItem<ID> + Send + 'static,
+    {
+        let queue_ptr = self.0.get();
+
+        // SAFETY: We only return `false` if the `work_struct` is already in a workqueue. The other
+        // `__enqueue` requirements are not relevant since `W` is `Send` and static.
+        //
+        // The call to `bindings::queue_work_on` will dereference the provided raw pointer, which
+        // is ok because `__enqueue` guarantees that the pointer is valid for the duration of this
+        // closure.
+        //
+        // Furthermore, if the C workqueue code accesses the pointer after this call to
+        // `__enqueue`, then the work item was successfully enqueued, and `bindings::queue_work_on`
+        // will have returned true. In this case, `__enqueue` promises that the raw pointer will
+        // stay valid until we call the function pointer in the `work_struct`, so the access is ok.
+        unsafe {
+            w.__enqueue(move |work_ptr| {
+                bindings::queue_work_on(bindings::WORK_CPU_UNBOUND as _, queue_ptr, work_ptr)
+            })
+        }
+    }
+}
+
+/// A raw work item.
+///
+/// This is the low-level trait that is designed for being as general as possible.
+///
+/// The `ID` parameter to this trait exists so that a single type can provide multiple
+/// implementations of this trait. For example, if a struct has multiple `work_struct` fields, then
+/// you will implement this trait once for each field, using a different id for each field. The
+/// actual value of the id is not important as long as you use different ids for different fields
+/// of the same struct. (Fields of different structs need not use different ids.)
+///
+/// Note that the id is used only to select the right method to call during compilation. It wont be
+/// part of the final executable.
+///
+/// # Safety
+///
+/// Implementers must ensure that any pointers passed to a `queue_work_on` closure by `__enqueue`
+/// remain valid for the duration specified in the documentation for `__enqueue`.
+pub unsafe trait RawWorkItem<const ID: u64> {
+    /// The return type of [`Queue::enqueue`].
+    type EnqueueOutput;
+
+    /// Enqueues this work item on a queue using the provided `queue_work_on` method.
+    ///
+    /// # Guarantees
+    ///
+    /// If this method calls the provided closure, then the raw pointer is guaranteed to point at a
+    /// valid `work_struct` for the duration of the call to the closure. If the closure returns
+    /// true, then it is further guaranteed that the pointer remains valid until someone calls the
+    /// function pointer stored in the `work_struct`.
+    ///
+    /// # Safety
+    ///
+    /// The provided closure may only return `false` if the `work_struct` is already in a workqueue.
+    ///
+    /// If the work item type is annotated with any lifetimes, then you must not call the function
+    /// pointer after any such lifetime expires. (Never calling the function pointer is okay.)
+    ///
+    /// If the work item type is not [`Send`], then the function pointer must be called on the same
+    /// thread as the call to `__enqueue`.
+    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
+    where
+        F: FnOnce(*mut bindings::work_struct) -> bool;
+}
-- 
2.41.0.rc0.172.g3f132b7071-goog

