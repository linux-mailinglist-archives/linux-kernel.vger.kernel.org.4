Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53AD719EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjFAN4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjFAN4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:56:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3E129
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:56:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565c380565dso22593137b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685627773; x=1688219773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyRNG5KT1C+kxxh+8DvNZVfySdIBr+c+luuNQvW24B8=;
        b=rqoKpkOtbw5E7aZUP5vKjWc3Rud11Cj869FSLBYeNDUpqqAOXnkZIPl7lj5T2v5p7s
         DmMa94afp5CNZFk1ywR4ew+ffsOd7nOjrFz827+LCZEp8XI49xI9Wdw9RtCEvPkuo8im
         TbhBhsVdo138vg3Nl4AMaccmsNOCCPZENyu59Kaii+poHD6Mc9UdWgsN3jNMxvyt2W4I
         y2/H0+6GzKgtGlccHAiV83rBObv6Oqk4nXU9rcSvjnEk0GniwrycnB1qvh3JpmxgcBKs
         vNmUwJcJLMtZRaxTJ5rpjwixRZNRXubZmOhOpkg300KRq2lF92feTXVc6m+zgHMAsqIc
         FyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627773; x=1688219773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyRNG5KT1C+kxxh+8DvNZVfySdIBr+c+luuNQvW24B8=;
        b=Av8fzN6acgq9cqPKg8w5NP7W/jPbdPu86oBTUHO74Vf3sOGtJy7tgkixDikDpMuhNS
         PltCeeHMTszdkiKw8feSgiPyMqffr4+y1/oVAopS5B0vXs1/OV28kc+cFtPfgUqEbNR2
         64pDkwjkE9bfo8pyUeVBKYnqSWINJvzYNQPlqVt8+Cv1P5gWes6e3UAcSC3h5cvX0LIJ
         cGgV+HHOA3qimD6DdeANSIzV2rvNRZjoYSWA2271Nc40aHtNPEYkygV84Ggc8rPtGzl1
         ySNXBMhq00xnWpQRWjAc8NHVZPri2vtNKGbxYvhy/9+01hwfwkCl+Srz94lpj9MWinE5
         EYdg==
X-Gm-Message-State: AC+VfDyOGNxF2hk76dJER4GeGwKikfpjLujBxaRVSYoz0jGPEv/1OVkL
        A35TSaYNCGXPJH44Tiv+4JXSz8Vwf49Fgd4=
X-Google-Smtp-Source: ACHHUZ5aHph4tvkKB0c6QYrmRqC0Hw9+Se7T+ePGC68o9O2DFJVKozkWFG8onb0G18ETbUursPX9HxukD6gKR/M=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:7813:0:b0:561:ec3e:62fd with SMTP id
 t19-20020a817813000000b00561ec3e62fdmr1402978ywc.5.1685627773081; Thu, 01 Jun
 2023 06:56:13 -0700 (PDT)
Date:   Thu,  1 Jun 2023 13:49:44 +0000
In-Reply-To: <20230601134946.3887870-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230601134946.3887870-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601134946.3887870-7-aliceryhl@google.com>
Subject: [PATCH v2 6/8] rust: workqueue: implement `WorkItemPointer` for
 pointer types
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

This implements the `WorkItemPointer` trait for the pointer types that
you are likely to use the workqueue with. The `Arc` type is for
reference counted objects, and the `Pin<Box<T>>` type is for objects
where the caller has exclusive ownership of the object.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/workqueue.rs | 97 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index dbf0aab29a85..f06a2f036d8b 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -28,8 +28,10 @@
 //!
 //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
 
-use crate::{bindings, prelude::*, types::Opaque};
+use crate::{bindings, prelude::*, sync::Arc, types::Opaque};
+use alloc::boxed::Box;
 use core::marker::{PhantomData, PhantomPinned};
+use core::pin::Pin;
 
 /// A kernel work queue.
 ///
@@ -323,6 +325,99 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
     )*};
 }
 
+unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
+where
+    T: WorkItem<ID, Pointer = Self>,
+    T: HasWork<T, ID>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
+        // SAFETY: The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
+        let ptr = ptr as *mut Work<T, ID>;
+        // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
+        let ptr = unsafe { T::work_container_of(ptr) };
+        // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
+        let arc = unsafe { Arc::from_raw(ptr) };
+
+        T::run(arc)
+    }
+}
+
+unsafe impl<T, const ID: u64> RawWorkItem<ID> for Arc<T>
+where
+    T: WorkItem<ID, Pointer = Self>,
+    T: HasWork<T, ID>,
+{
+    type EnqueueOutput = Result<(), Self>;
+
+    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
+    where
+        F: FnOnce(*mut bindings::work_struct) -> bool,
+    {
+        // Casting between const and mut is not a problem as long as the pointer is a raw pointer.
+        let ptr = Arc::into_raw(self) as *mut T;
+
+        // SAFETY: Pointers into an `Arc` point at a valid value.
+        let work_ptr = unsafe { T::raw_get_work(ptr) };
+        // SAFETY: `raw_get_work` returns a pointer to a valid value.
+        let work_ptr = unsafe { Work::raw_get(work_ptr) };
+
+        if queue_work_on(work_ptr) {
+            Ok(())
+        } else {
+            // SAFETY: The work queue has not taken ownership of the pointer.
+            Err(unsafe { Arc::from_raw(ptr) })
+        }
+    }
+}
+
+unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
+where
+    T: WorkItem<ID, Pointer = Self>,
+    T: HasWork<T, ID>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
+        // SAFETY: The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
+        let ptr = ptr as *mut Work<T, ID>;
+        // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
+        let ptr = unsafe { T::work_container_of(ptr) };
+        // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
+        let boxed = unsafe { Box::from_raw(ptr) };
+        // SAFETY: The box was already pinned when it was enqueued.
+        let pinned = unsafe { Pin::new_unchecked(boxed) };
+
+        T::run(pinned)
+    }
+}
+
+unsafe impl<T, const ID: u64> RawWorkItem<ID> for Pin<Box<T>>
+where
+    T: WorkItem<ID, Pointer = Self>,
+    T: HasWork<T, ID>,
+{
+    type EnqueueOutput = ();
+
+    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
+    where
+        F: FnOnce(*mut bindings::work_struct) -> bool,
+    {
+        // SAFETY: We're not going to move `self` or any of its fields, so its okay to temporarily
+        // remove the `Pin` wrapper.
+        let boxed = unsafe { Pin::into_inner_unchecked(self) };
+        let ptr = Box::into_raw(boxed);
+
+        // SAFETY: Pointers into a `Box` point at a valid value.
+        let work_ptr = unsafe { T::raw_get_work(ptr) };
+        // SAFETY: `raw_get_work` returns a pointer to a valid value.
+        let work_ptr = unsafe { Work::raw_get(work_ptr) };
+
+        if !queue_work_on(work_ptr) {
+            // SAFETY: This method requires exclusive ownership of the box, so it cannot be in a
+            // workqueue.
+            unsafe { ::core::hint::unreachable_unchecked() }
+        }
+    }
+}
+
 /// Returns the system work queue (`system_wq`).
 ///
 /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are
-- 
2.41.0.rc0.172.g3f132b7071-goog

