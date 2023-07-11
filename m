Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9806974EAF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGKJmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGKJmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:42:37 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDD7A8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:42:26 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-993d41cbc31so269033366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689068545; x=1691660545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f7HLpFtiTSWw0ZxSifV85XuGL1lfgvJblX5DGQd7aZg=;
        b=rn6KFEzfYPUPKzeY5cQR9Bk5tjkbVHfgCbbsmC9+vaf9B/2jTg/G+kxUDkEVhnnUKY
         6ituUWa6qX4KfIU1hTNSnYfZLeUIMvi/qwGapwmTAdLAEO9MWnWyBcvCuBZ0Vw6rwM0t
         2BpB27CEsT5oMh7hw/6OR/Da6YVFpyX2u3kMJ5BDquicAt/R+GyU1zds1crLxR/rS5CK
         jQrtdS1LcVEe/fuKqGhI5Ol27ZA/T4yb0HGT0B9XgMhFKuLj4CzwYT64EU0T1tGX5Qiu
         g5X20m+QQGmoj65d15hRUfrxcvF6pgg3a6kmqDIN9hrb9mPU82LU8N7OjiChZgfYdiUB
         6FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689068545; x=1691660545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7HLpFtiTSWw0ZxSifV85XuGL1lfgvJblX5DGQd7aZg=;
        b=Z5i+ghJODtyBiJU5B7Zx6ezPM9Dckab5nr3e6QGM/GNCfMvnDhkDtVRno873ppJM2Q
         eutKJJ0EqlMAC95ktWwXnbJZFW49ixKQF5TnmkYvdTeLe6107HCZrUtStkt459zvibCc
         200KDz4dMPuaKgMitRS61g35xGu61fV29nzvhJQ5DNM2uMJeU0+2o0phzJcO/vdYxofC
         Vsgx/pnAtuIYRYT/O1RoMD6gc9BDiTMxEuJR/ahGqihSzJk9wL8hSnpJbJu+MmgxJj0i
         JwAm9MG/cBeUNFBSuoD8CHh34QitmlKUHomXTwzKHDC1zVTfYBBcUy4MuwzkI1hJVqBS
         oEHA==
X-Gm-Message-State: ABy/qLYCAlhOCvkO2/IhcxWssfWk5EAh64SSzosgiT2r9K5R+E/yfONG
        82O98b184llcRAnA1nsEgzUJ9SV0T0W4B3U=
X-Google-Smtp-Source: APBJJlHVM3p8FBFgUsh1AAogwf8OnjJiwtgazoiqRv+wwkOPAoCVMmUM2zuYBOGgpSpw33EdVOcNf1tb1nowtSU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:9be6:b0:98e:413a:477b with SMTP
 id de38-20020a1709069be600b0098e413a477bmr55880ejc.10.1689068545276; Tue, 11
 Jul 2023 02:42:25 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:32:58 +0000
In-Reply-To: <20230711093303.1433770-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230711093303.1433770-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711093303.1433770-5-aliceryhl@google.com>
Subject: [PATCH v3 4/9] rust: workqueue: add low-level workqueue bindings
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <nmi@metaspace.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
 * Update documentation to say "guarantees section".
 * Add Reviewed-by from Martin, Andreas, Benno.

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/workqueue.rs        | 108 ++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 rust/kernel/workqueue.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3e601ce2548d..4e1c0938c8cb 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/workqueue.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6963d11092c4..6d63f4f6bb8a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -45,6 +45,7 @@
 pub mod sync;
 pub mod task;
 pub mod types;
+pub mod workqueue;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
new file mode 100644
index 000000000000..060d26dfcc7d
--- /dev/null
+++ b/rust/kernel/workqueue.rs
@@ -0,0 +1,108 @@
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
+/// remain valid for the duration specified in the guarantees section of the documentation for
+/// `__enqueue`.
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
2.41.0.255.g8b1d071c50-goog

