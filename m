Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B5270730E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjEQUbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjEQUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:31:31 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDA87AAF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:31:24 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-506a7b4f141so1508065a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684355483; x=1686947483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q2MUmGAiEMdaaQsAAxoPHDCIZoeH9n1n1GaPuiAfzA=;
        b=zKAfePblS1nd8XT33ZnJ95+8xGVLMDUS4gyMSoEOyKiGtcCNCMO8kBMGgXG8J58EN5
         HBlHGHGxQq2LEu9iNG+/RWs0ZqlG6Ek4QFwFjHg5+7YBUlFGo26Al3txqchhePqZn6Zl
         uyUTm7AR2QS+S2vtY+gm2LUM+RnnPpXFmn816h8Qw3A4HKo5eNyn1aa9yq/G9Z4VoLGh
         8AhujsdNZPagkjKj0YBFqoq+gvCPaAnE8YNM4V3kfXMge+g2bau9E8rXexTcirMqSBKo
         rFb31MR76JCgHdloKxoYVbWL3y5K/8HEYE0Bzuc64gmIsw+AodoRLJQSWZslY7lWy0RG
         VIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684355483; x=1686947483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q2MUmGAiEMdaaQsAAxoPHDCIZoeH9n1n1GaPuiAfzA=;
        b=efb6UEAgM8d5tg2lDUS7mRJbmSvqfLKaIC2ovmnSqSt92z1tTvgyxBm+VihcfUWtT5
         wnbs4XIMkaV/q7G+z2+vhOpA5vPXcXIKF3X+Clse2rBTg6ZnTlZf629XdVMnydjcIwnE
         bEoDbmi+LUQ4XtHF1kLTBMsvKg9vzOB3gDTFiX5D2kSQp9fLqnGCTUQTg1MmUDQCJ7D5
         UezKn/bvxCt2cPlF70/NORFQP+MFnkziQLXCpLVjWeFHAAcsRYwPX41Iid7mT+bthIED
         lCONbf4m1BTmNj6LTcDHPy9lSrjG7cEl3p7N9l/z5xLy4nvM3auANNlhjpGfCoD7oBhK
         tKXw==
X-Gm-Message-State: AC+VfDzryDaO25BWLb5pyPggu3D2kUHl1rVdND3uW6D/3WtxuRAQIPpd
        RhgfYuhVVXGJ4QbcSqTr3XmtCZ6ljfva6wk=
X-Google-Smtp-Source: ACHHUZ5HBFQWszLoGBLcaNy0DdhkYrWYan90ySkcSdsC2yKoTJ0iZRVUU36MhwoE+D7Z2+HOBM5F516rsgf3jlw=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:cd4b:0:b0:504:e957:2926 with SMTP id
 d11-20020a50cd4b000000b00504e9572926mr1473278edj.1.1684355483536; Wed, 17 May
 2023 13:31:23 -0700 (PDT)
Date:   Wed, 17 May 2023 20:31:13 +0000
In-Reply-To: <20230517203119.3160435-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230517203119.3160435-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230517203119.3160435-2-aliceryhl@google.com>
Subject: [PATCH v1 1/7] rust: workqueue: add low-level workqueue bindings
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define basic low-level bindings to a kernel workqueue. The API defined
here can only be used unsafely. Later commits will provide safe
wrappers.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/lib.rs       |  1 +
 rust/kernel/workqueue.rs | 99 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 rust/kernel/workqueue.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 676995d4e460..c718524056a6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -47,6 +47,7 @@ pub mod str;
 pub mod sync;
 pub mod task;
 pub mod types;
+pub mod workqueue;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
new file mode 100644
index 000000000000..e66b6b50dfae
--- /dev/null
+++ b/rust/kernel/workqueue.rs
@@ -0,0 +1,99 @@
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
+    pub fn enqueue<T: WorkItem + Send + 'static>(&self, w: T) -> T::EnqueueOutput {
+        let queue_ptr = self.0.get();
+
+        // SAFETY: There are two cases.
+        //
+        //  1. If `queue_work_on` returns false, then we failed to push the work item to the queue.
+        //     In this case, we don't touch the work item again.
+        //
+        //  2. If `queue_work_on` returns true, then we pushed the work item to the queue. The work
+        //     queue will call the function pointer in the `work_struct` at some point in the
+        //     future. We require `T` to be static, so the type has no lifetimes annotated on it.
+        //     We require `T` to be send, so there are no thread-safety issues to take care of.
+        //
+        // In either case we follow the safety requirements of `__enqueue`.
+        unsafe {
+            w.__enqueue(move |work_ptr| {
+                bindings::queue_work_on(bindings::WORK_CPU_UNBOUND as _, queue_ptr, work_ptr)
+            })
+        }
+    }
+}
+
+/// A work item.
+///
+/// This is the low-level trait that is designed for being as general as possible.
+///
+/// # Safety
+///
+/// Implementers must ensure that `__enqueue` behaves as documented.
+pub unsafe trait WorkItem {
+    /// The return type of [`Queue::enqueue`].
+    type EnqueueOutput;
+
+    /// Enqueues this work item on a queue using the provided `queue_work_on` method.
+    ///
+    /// # Safety
+    ///
+    /// Calling this method guarantees that the provided closure will be called with a raw pointer
+    /// to a `struct work_struct`. The closure should behave in the following way:
+    ///
+    ///  1. If the `struct work_struct` cannot be pushed to a workqueue because its already in one,
+    ///     then the closure should return `false`. It may not access the pointer after returning
+    ///     `false`.
+    ///  2. If the `struct work_struct` is successfully added to a workqueue, then the closure
+    ///     should return `true`. When the workqueue executes the work item, it will do so by
+    ///     calling the function pointer stored in the `struct work_struct`. The work item ensures
+    ///     that the raw pointer remains valid until that happens.
+    ///
+    /// This method may not have any other failure cases than the closure returning `false`. The
+    /// output type should reflect this, but it may also be an infallible type if the work item
+    /// statically ensures that pushing the `struct work_struct` will succeed.
+    ///
+    /// If the work item type is annotated with any lifetimes, then the workqueue must call the
+    /// function pointer before any such lifetime expires. (Or it may forget the work item and
+    /// never call the function pointer at all.)
+    ///
+    /// If the work item type is not [`Send`], then the work item must be executed on the same
+    /// thread as the call to `__enqueue`.
+    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
+    where
+        F: FnOnce(*mut bindings::work_struct) -> bool;
+}
-- 
2.40.1.606.ga4b1b128d6-goog

