Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D72719EEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjFAN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjFAN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:56:50 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBAEFC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:56:49 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-96faa650a3fso64714866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685627808; x=1688219808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vB1KTXT+BDPTSPss1nKfZFCllt9cnJRUrJkIndsk9bQ=;
        b=ONUw1Bi/LF6RsZlr45Sb+TKYR/o9wrpaSOn2lrXAM6QYiczLPUguB/OtTWl2nFQb/z
         QHCJFovGIHfcYE7ZKxME4rHu0QrQ4t0lkAsZaKzOuoP35MgMHVzXbqZ9Js6mYq3jSxzW
         iQhJQID+sbpuY6rX1Kr1tInXmFVQ8bpfhl7KPdzG/3nj30erauVwt9zGGqKaupzxvtkk
         zJUHWqC/9bRRmif13gTcB23wiU9s0WW2SS+C2rW0b1KB96pBbzxeXvLAmsDK+Q6B9hpm
         WC4RIxiwCa89hBCrOaMs11hNEoZ8Mf+uzlLbeKiVPw4rmcJHNzBDHeol1J09Swzd8q5c
         6l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627808; x=1688219808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vB1KTXT+BDPTSPss1nKfZFCllt9cnJRUrJkIndsk9bQ=;
        b=lo9haCHBe4Rv6oEM9rz/yWuRkLtX4NNucTR/AFkW/YrQljmNPcWujJNGDCKyMJ7x3N
         8FyRvbZxSVD/PHo4QmwX8wKZ6abWlrVSwbsnGjaxidjb+QG1L0z5dj7NQ4GuMqh+SSZ5
         pRUbgrr+K9Zkdmvy9vkUDoo3G7J14MN7afJSzgpeJhLZ+s2px0nP2NcxLwL/mosJV9rC
         UwnFBS6yZEusClaDftEJk6DMMwBD5m6CMB50QR7BQJ79IrZzJa2RcD07Wh1aB5Qw1bdm
         PefQhqNDuCVNzas1OcfoITXD8aT6yH1JRh2Rw5tQ1NtOF/H75muZhYu4oXQ0HGW7a1Ei
         OVaw==
X-Gm-Message-State: AC+VfDyj08R6iOJjfqrMALln2hzWZ8npmxFn2eReu7GES+Kok4krqcWk
        VeqNKjRBSe8NxmfKsLY9YmroykodpqnVnlI=
X-Google-Smtp-Source: ACHHUZ6wvWf7QDEiZpOYRmHr1ZokpvS+ySsWXbKzAtbGtHwYA1ojE0HCynF9ToBu5yxSIkNVCdyZ/ezhgmRDm2s=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:2cd9:b0:973:867b:399e with SMTP
 id hg25-20020a1709072cd900b00973867b399emr2256552ejc.4.1685627807883; Thu, 01
 Jun 2023 06:56:47 -0700 (PDT)
Date:   Thu,  1 Jun 2023 13:49:45 +0000
In-Reply-To: <20230601134946.3887870-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230601134946.3887870-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601134946.3887870-8-aliceryhl@google.com>
Subject: [PATCH v2 7/8] rust: workqueue: add `try_spawn` helper method
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a convenience method that lets you spawn a closure for
execution on a workqueue. This will be the most convenient way to use
workqueues, but it is fallible because it needs to allocate memory.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/workqueue.rs | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index f06a2f036d8b..c302e8b8624b 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -29,6 +29,7 @@
 //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
 
 use crate::{bindings, prelude::*, sync::Arc, types::Opaque};
+use alloc::alloc::AllocError;
 use alloc::boxed::Box;
 use core::marker::{PhantomData, PhantomPinned};
 use core::pin::Pin;
@@ -87,6 +88,44 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
             })
         }
     }
+
+    /// Tries to spawn the given function or closure as a work item.
+    ///
+    /// This method can fail because it allocates memory to store the work item.
+    pub fn try_spawn<T: 'static + Send + FnOnce()>(&self, func: T) -> Result<(), AllocError> {
+        let init = pin_init!(ClosureWork {
+            work <- Work::new(),
+            func: Some(func),
+        });
+
+        self.enqueue(Box::pin_init(init).map_err(|_| AllocError)?);
+        Ok(())
+    }
+}
+
+/// A helper type used in `try_spawn`.
+#[pin_data]
+struct ClosureWork<T> {
+    #[pin]
+    work: Work<ClosureWork<T>>,
+    func: Option<T>,
+}
+
+impl<T> ClosureWork<T> {
+    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
+        // SAFETY: The `func` field is not structurally pinned.
+        unsafe { &mut self.get_unchecked_mut().func }
+    }
+}
+
+impl<T: FnOnce()> WorkItem for ClosureWork<T> {
+    type Pointer = Pin<Box<Self>>;
+
+    fn run(mut this: Pin<Box<Self>>) {
+        if let Some(func) = this.as_mut().project().take() {
+            (func)()
+        }
+    }
 }
 
 /// A raw work item.
@@ -325,6 +364,10 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
     )*};
 }
 
+impl_has_work! {
+    impl<T> HasWork<Self> for ClosureWork<T> { self.work }
+}
+
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
 where
     T: WorkItem<ID, Pointer = Self>,
-- 
2.41.0.rc0.172.g3f132b7071-goog

