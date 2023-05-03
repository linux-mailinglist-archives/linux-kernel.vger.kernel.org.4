Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B976F53FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjECJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjECJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A70149EC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f178da21b5so31755925e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104839; x=1685696839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTm6JqVuE+nMnHE8FtSNpIwMZXEBmyO5CLHkBrzqYiM=;
        b=y8ejhwlgPFRLA58nqaLi6rcO3cTM2Bfu5R3HefR0o7cV9HTZoOxGUPasuvY46ZCwRh
         Sieo0Nw1Hzb4wY/iGDsNeHNIVg922qi3pacnA1K1Se735gJ7tsTrShXrb9Q3Tud15qCH
         pSi0ybeIHv49VuB2OI3rl+J+JTSb+9Q6ggrpcJFtEdi5YM3IsSttMHyzuBP0ZuAFksoN
         vicg6hsE+vaLEKi9gFV/LC2GyxdFyAnbn301c0wlUyeORPMq2Ykn/8QtIJHJeargKiXo
         g6ZYJxIn2Ojk9efoIi4W30BLPTSKqbSu7FqbbaUdRjKDx6DSjir7twQZkzXbwUjeKM5j
         +eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104839; x=1685696839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTm6JqVuE+nMnHE8FtSNpIwMZXEBmyO5CLHkBrzqYiM=;
        b=ARgkB/7wsNnBfz8kp/2VCBhWoa4VU8Ed7NhzzWXJECFz8XggMQPfTIRIuWLlyEYlkl
         EGKBnDUvqd18jFHbQo3Z9DvOimHjUd9cXsP+L5PBB/QREOIA9qg7gbO7sF8vJtPXCrL1
         Vxh7e36XAZ6kYRvgZTb4+I701eUFfXI8/hMEDS4LatItkKblGCKucp08Z+DrlQ2SbMca
         t2Th6fHQ86sxBKzfgfnJAfjqCq1sSinjPSNsJHveg/7SQdm9vNNe3MuRCV5Xs21Q4IMi
         7uK6waXtgcf2sSTq91jxnjBY98Z1TF+b5EPvAwCEhpeZHZmRjbDiJJnK4mHwm21JgiZl
         5Wgw==
X-Gm-Message-State: AC+VfDz8yJE8aheqOJXSHWKiSfLGu6LuVN33p/ZGeV09yStMglDida7C
        hvyKRiWisvvk6jdxgL/CBONYWg==
X-Google-Smtp-Source: ACHHUZ7NYkY5wjU5kOgvBlYNkrutaPEK/czR704t4GtHEI0ibjC9b/NRGmiwBmTmJwdWADfymkFv2Q==
X-Received: by 2002:a7b:c383:0:b0:3f3:3a81:334 with SMTP id s3-20020a7bc383000000b003f33a810334mr6690102wmj.29.1683104839156;
        Wed, 03 May 2023 02:07:19 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003f1733feb3dsm1305041wmc.0.2023.05.03.02.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:18 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 03/11] rust: block: introduce `kernel::block::mq` module
Date:   Wed,  3 May 2023 11:07:00 +0200
Message-Id: <20230503090708.2524310-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Add initial abstractions for working with blk-mq.

This patch is a maintained, refactored subset of code originally published by
Wedson Almeida Filho <wedsonaf@gmail.com> [1].

[1] https://github.com/wedsonaf/linux/tree/f2cfd2fe0e2ca4e90994f96afe268bbd4382a891/rust/kernel/blk/mq.rs

Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/bindings/bindings_helper.h    |   2 +
 rust/helpers.c                     |  22 +++
 rust/kernel/block.rs               |   5 +
 rust/kernel/block/mq.rs            |  15 ++
 rust/kernel/block/mq/gen_disk.rs   | 133 +++++++++++++++
 rust/kernel/block/mq/operations.rs | 260 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  30 ++++
 rust/kernel/block/mq/request.rs    |  71 ++++++++
 rust/kernel/block/mq/tag_set.rs    |  92 ++++++++++
 rust/kernel/error.rs               |   4 +
 rust/kernel/lib.rs                 |   1 +
 11 files changed, 635 insertions(+)
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 52834962b94d..86c07eeb1ba1 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,8 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/radix-tree.h>
+#include <linux/blk_types.h>
+#include <linux/blk-mq.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/helpers.c b/rust/helpers.c
index 9bd9d95da951..a59341084774 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -18,6 +18,7 @@
  * accidentally exposed.
  */
 
+#include <linux/bio.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/err.h>
@@ -28,6 +29,8 @@
 #include <linux/wait.h>
 #include <linux/radix-tree.h>
 #include <linux/highmem.h>
+#include <linux/blk-mq.h>
+#include <linux/blkdev.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -130,6 +133,25 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+struct bio_vec rust_helper_req_bvec(struct request *rq)
+{
+	return req_bvec(rq);
+}
+EXPORT_SYMBOL_GPL(rust_helper_req_bvec);
+
+void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
+{
+	return blk_mq_rq_to_pdu(rq);
+}
+EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_to_pdu);
+
+void rust_helper_bio_advance_iter_single(const struct bio *bio,
+                                         struct bvec_iter *iter,
+                                         unsigned int bytes) {
+  bio_advance_iter_single(bio, iter, bytes);
+}
+EXPORT_SYMBOL_GPL(rust_helper_bio_advance_iter_single);
+
 void rust_helper_init_radix_tree(struct xarray *tree, gfp_t gfp_mask)
 {
 	INIT_RADIX_TREE(tree, gfp_mask);
diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
new file mode 100644
index 000000000000..4c93317a568a
--- /dev/null
+++ b/rust/kernel/block.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with the block layer
+
+pub mod mq;
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
new file mode 100644
index 000000000000..5b40f6a73c0f
--- /dev/null
+++ b/rust/kernel/block/mq.rs
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides types for implementing drivers that interface the
+//! blk-mq subsystem
+
+mod gen_disk;
+mod operations;
+mod raw_writer;
+mod request;
+mod tag_set;
+
+pub use gen_disk::GenDisk;
+pub use operations::Operations;
+pub use request::Request;
+pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
new file mode 100644
index 000000000000..50496af15bbf
--- /dev/null
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! GenDisk abstraction
+//!
+//! C header: [`include/linux/blkdev.h`](../../include/linux/blkdev.h)
+//! C header: [`include/linux/blk_mq.h`](../../include/linux/blk_mq.h)
+
+use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
+use crate::{
+    bindings, error::from_err_ptr, error::Result, sync::Arc, types::ForeignOwnable,
+    types::ScopeGuard,
+};
+use core::fmt::{self, Write};
+
+/// A generic block device
+///
+/// # Invariants
+///
+///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
+pub struct GenDisk<T: Operations> {
+    _tagset: Arc<TagSet<T>>,
+    gendisk: *mut bindings::gendisk,
+}
+
+// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
+// `TagSet` It is safe to send this to other threads as long as T is Send.
+unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
+
+impl<T: Operations> GenDisk<T> {
+    /// Try to create a new `GenDisk`
+    pub fn try_new(tagset: Arc<TagSet<T>>, queue_data: T::QueueData) -> Result<Self> {
+        let data = queue_data.into_foreign();
+        let recover_data = ScopeGuard::new(|| {
+            // SAFETY: T::QueueData was created by the call to `into_foreign()` above
+            unsafe { T::QueueData::from_foreign(data) };
+        });
+
+        let lock_class_key = crate::sync::LockClassKey::new();
+
+        // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
+        let gendisk = from_err_ptr(unsafe {
+            bindings::__blk_mq_alloc_disk(tagset.raw_tag_set(), data as _, lock_class_key.as_ptr())
+        })?;
+
+        const TABLE: bindings::block_device_operations = bindings::block_device_operations {
+            submit_bio: None,
+            open: None,
+            release: None,
+            ioctl: None,
+            compat_ioctl: None,
+            check_events: None,
+            unlock_native_capacity: None,
+            getgeo: None,
+            set_read_only: None,
+            swap_slot_free_notify: None,
+            report_zones: None,
+            devnode: None,
+            alternative_gpt_sector: None,
+            get_unique_id: None,
+            owner: core::ptr::null_mut(),
+            pr_ops: core::ptr::null_mut(),
+            free_disk: None,
+            poll_bio: None,
+        };
+
+        // SAFETY: gendisk is a valid pointer as we initialized it above
+        unsafe { (*gendisk).fops = &TABLE };
+
+        recover_data.dismiss();
+        Ok(Self {
+            _tagset: tagset,
+            gendisk,
+        })
+    }
+
+    /// Set the name of the device
+    pub fn set_name(&self, args: fmt::Arguments<'_>) -> Result {
+        let mut raw_writer = RawWriter::from_array(unsafe { &mut (*self.gendisk).disk_name });
+        raw_writer.write_fmt(args)?;
+        raw_writer.write_char('\0')?;
+        Ok(())
+    }
+
+    /// Register the device with the kernel. When this function return, the
+    /// device is accessible from VFS. The kernel may issue reads to the device
+    /// during registration to discover partition infomation.
+    pub fn add(&self) -> Result {
+        crate::error::to_result(unsafe {
+            bindings::device_add_disk(core::ptr::null_mut(), self.gendisk, core::ptr::null_mut())
+        })
+    }
+
+    /// Call to tell the block layer the capcacity of the device
+    pub fn set_capacity(&self, sectors: u64) {
+        unsafe { bindings::set_capacity(self.gendisk, sectors) };
+    }
+
+    /// Set the logical block size of the device
+    pub fn set_queue_logical_block_size(&self, size: u32) {
+        unsafe { bindings::blk_queue_logical_block_size((*self.gendisk).queue, size) };
+    }
+
+    /// Set the physical block size of the device
+    pub fn set_queue_physical_block_size(&self, size: u32) {
+        unsafe { bindings::blk_queue_physical_block_size((*self.gendisk).queue, size) };
+    }
+
+    /// Set the rotational media attribute for the device
+    pub fn set_rotational(&self, rotational: bool) {
+        if !rotational {
+            unsafe {
+                bindings::blk_queue_flag_set(bindings::QUEUE_FLAG_NONROT, (*self.gendisk).queue)
+            };
+        } else {
+            unsafe {
+                bindings::blk_queue_flag_clear(bindings::QUEUE_FLAG_NONROT, (*self.gendisk).queue)
+            };
+        }
+    }
+}
+
+impl<T: Operations> Drop for GenDisk<T> {
+    fn drop(&mut self) {
+        let queue_data = unsafe { (*(*self.gendisk).queue).queuedata };
+
+        unsafe { bindings::del_gendisk(self.gendisk) };
+
+        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
+        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
+        // `ForeignOwnable::from_foreign()` is only called here.
+        let _queue_data = unsafe { T::QueueData::from_foreign(queue_data) };
+    }
+}
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
new file mode 100644
index 000000000000..fb1ab707d1f0
--- /dev/null
+++ b/rust/kernel/block/mq/operations.rs
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides an interface for blk-mq drivers to implement.
+//!
+//! C header: [`include/linux/blk-mq.h`](../../include/linux/blk-mq.h)
+
+use crate::{
+    bindings,
+    block::mq::{tag_set::TagSetRef, Request},
+    error::{from_result, Result},
+    types::ForeignOwnable,
+};
+use core::{marker::PhantomData, pin::Pin};
+
+/// Implement this trait to interface blk-mq as block devices
+#[macros::vtable]
+pub trait Operations: Sized {
+    /// Data associated with a request. This data is located next to the request
+    /// structure.
+    type RequestData;
+
+    /// Data associated with the `struct request_queue` that is allocated for
+    /// the `GenDisk` associated with this `Operations` implementation.
+    type QueueData: ForeignOwnable;
+
+    /// Data associated with a dispatch queue. This is stored as a pointer in
+    /// `struct blk_mq_hw_ctx`.
+    type HwData: ForeignOwnable;
+
+    /// Data associated with a tag set. This is stored as a pointer in `struct
+    /// blk_mq_tag_set`.
+    type TagSetData: ForeignOwnable;
+
+    /// Called by the kernel to allocate a new `RequestData`. The structure will
+    /// eventually be pinned, so defer initialization to `init_request_data()`
+    fn new_request_data(
+        _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+    ) -> Result<Self::RequestData>;
+
+    /// Called by the kernel to initialize a previously allocated `RequestData`
+    fn init_request_data(
+        _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+        _data: Pin<&mut Self::RequestData>,
+    ) -> Result {
+        Ok(())
+    }
+
+    /// Called by the kernel to queue a request with the driver. If `is_last` is
+    /// `false`, the driver is allowed to defer commiting the request.
+    fn queue_rq(
+        hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
+        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
+        rq: &Request<Self>,
+        is_last: bool,
+    ) -> Result;
+
+    /// Called by the kernel to indicate that queued requests should be submitted
+    fn commit_rqs(
+        hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
+        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
+    );
+
+    /// Called by the kernel when the request is completed
+    fn complete(_rq: &Request<Self>);
+
+    /// Called by the kernel to allocate and initialize a driver specific hardware context data
+    fn init_hctx(
+        tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+        hctx_idx: u32,
+    ) -> Result<Self::HwData>;
+
+    /// Called by the kernel to poll the device for completed requests. Only used for poll queues.
+    fn poll(_hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>) -> i32 {
+        unreachable!()
+    }
+
+    /// Called by the kernel to map submission queues to CPU cores.
+    fn map_queues(_tag_set: &TagSetRef) {
+        unreachable!()
+    }
+
+    // There is no need for exit_request() because `drop` will be called.
+}
+
+pub(crate) struct OperationsVtable<T: Operations>(PhantomData<T>);
+
+impl<T: Operations> OperationsVtable<T> {
+    // # Safety
+    //
+    // The caller of this function must ensure that `hctx` and `bd` are valid
+    // and initialized. The pointees must outlive this function. Further
+    // `hctx->driver_data` must be a pointer created by a call to
+    // `Self::init_hctx_callback()` and the pointee must outlive this function.
+    // This function must not be called with a `hctx` for which
+    // `Self::exit_hctx_callback()` has been called.
+    unsafe extern "C" fn queue_rq_callback(
+        hctx: *mut bindings::blk_mq_hw_ctx,
+        bd: *const bindings::blk_mq_queue_data,
+    ) -> bindings::blk_status_t {
+        // SAFETY: `bd` is valid as required by the safety requirement for this function.
+        let rq = unsafe { (*bd).rq };
+
+        // SAFETY: The safety requirement for this function ensure that
+        // `(*hctx).driver_data` was returned by a call to
+        // `Self::init_hctx_callback()`. That function uses
+        // `PointerWrapper::into_pointer()` to create `driver_data`. Further,
+        // the returned value does not outlive this function and
+        // `from_foreign()` is not called until `Self::exit_hctx_callback()` is
+        // called. By the safety requirement of this function and contract with
+        // the `blk-mq` API, `queue_rq_callback()` will not be called after that
+        // point.
+        let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
+
+        // SAFETY: `hctx` is valid as required by this function.
+        let queue_data = unsafe { (*(*hctx).queue).queuedata };
+
+        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
+        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
+        // `ForeignOwnable::from_foreign()` is only called when the tagset is
+        // dropped, which happens after we are dropped.
+        let queue_data = unsafe { T::QueueData::borrow(queue_data) };
+
+        // SAFETY: `bd` is valid as required by the safety requirement for this function.
+        let ret = T::queue_rq(
+            hw_data,
+            queue_data,
+            &unsafe { Request::from_ptr(rq) },
+            unsafe { (*bd).last },
+        );
+        if let Err(e) = ret {
+            e.to_blk_status()
+        } else {
+            bindings::BLK_STS_OK as _
+        }
+    }
+
+    unsafe extern "C" fn commit_rqs_callback(hctx: *mut bindings::blk_mq_hw_ctx) {
+        let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
+
+        // SAFETY: `hctx` is valid as required by this function.
+        let queue_data = unsafe { (*(*hctx).queue).queuedata };
+
+        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()` with a
+        // call to `ForeignOwnable::into_pointer()` to create `queuedata`.
+        // `ForeignOwnable::from_foreign()` is only called when the tagset is
+        // dropped, which happens after we are dropped.
+        let queue_data = unsafe { T::QueueData::borrow(queue_data) };
+        T::commit_rqs(hw_data, queue_data)
+    }
+
+    unsafe extern "C" fn complete_callback(rq: *mut bindings::request) {
+        T::complete(&unsafe { Request::from_ptr(rq) });
+    }
+
+    unsafe extern "C" fn poll_callback(
+        hctx: *mut bindings::blk_mq_hw_ctx,
+        _iob: *mut bindings::io_comp_batch,
+    ) -> core::ffi::c_int {
+        let hw_data = unsafe { T::HwData::borrow((*hctx).driver_data) };
+        T::poll(hw_data)
+    }
+
+    unsafe extern "C" fn init_hctx_callback(
+        hctx: *mut bindings::blk_mq_hw_ctx,
+        tagset_data: *mut core::ffi::c_void,
+        hctx_idx: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            let tagset_data = unsafe { T::TagSetData::borrow(tagset_data) };
+            let data = T::init_hctx(tagset_data, hctx_idx)?;
+            unsafe { (*hctx).driver_data = data.into_foreign() as _ };
+            Ok(0)
+        })
+    }
+
+    unsafe extern "C" fn exit_hctx_callback(
+        hctx: *mut bindings::blk_mq_hw_ctx,
+        _hctx_idx: core::ffi::c_uint,
+    ) {
+        let ptr = unsafe { (*hctx).driver_data };
+        unsafe { T::HwData::from_foreign(ptr) };
+    }
+
+    unsafe extern "C" fn init_request_callback(
+        set: *mut bindings::blk_mq_tag_set,
+        rq: *mut bindings::request,
+        _hctx_idx: core::ffi::c_uint,
+        _numa_node: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The tagset invariants guarantee that all requests are allocated with extra memory
+            // for the request data.
+            let pdu = unsafe { bindings::blk_mq_rq_to_pdu(rq) } as *mut T::RequestData;
+            let tagset_data = unsafe { T::TagSetData::borrow((*set).driver_data) };
+
+            let v = T::new_request_data(tagset_data)?;
+
+            // SAFETY: `pdu` memory is valid, as it was allocated by the caller.
+            unsafe { pdu.write(v) };
+
+            let tagset_data = unsafe { T::TagSetData::borrow((*set).driver_data) };
+            // SAFETY: `pdu` memory is valid and properly initialised.
+            T::init_request_data(tagset_data, unsafe { Pin::new_unchecked(&mut *pdu) })?;
+
+            Ok(0)
+        })
+    }
+
+    unsafe extern "C" fn exit_request_callback(
+        _set: *mut bindings::blk_mq_tag_set,
+        rq: *mut bindings::request,
+        _hctx_idx: core::ffi::c_uint,
+    ) {
+        // SAFETY: The tagset invariants guarantee that all requests are allocated with extra memory
+        // for the request data.
+        let pdu = unsafe { bindings::blk_mq_rq_to_pdu(rq) } as *mut T::RequestData;
+
+        // SAFETY: `pdu` is valid for read and write and is properly initialised.
+        unsafe { core::ptr::drop_in_place(pdu) };
+    }
+
+    unsafe extern "C" fn map_queues_callback(tag_set_ptr: *mut bindings::blk_mq_tag_set) {
+        let tag_set = unsafe { TagSetRef::from_ptr(tag_set_ptr) };
+        T::map_queues(&tag_set);
+    }
+
+    const VTABLE: bindings::blk_mq_ops = bindings::blk_mq_ops {
+        queue_rq: Some(Self::queue_rq_callback),
+        queue_rqs: None,
+        commit_rqs: Some(Self::commit_rqs_callback),
+        get_budget: None,
+        put_budget: None,
+        set_rq_budget_token: None,
+        get_rq_budget_token: None,
+        timeout: None,
+        poll: if T::HAS_POLL {
+            Some(Self::poll_callback)
+        } else {
+            None
+        },
+        complete: Some(Self::complete_callback),
+        init_hctx: Some(Self::init_hctx_callback),
+        exit_hctx: Some(Self::exit_hctx_callback),
+        init_request: Some(Self::init_request_callback),
+        exit_request: Some(Self::exit_request_callback),
+        cleanup_rq: None,
+        busy: None,
+        map_queues: if T::HAS_MAP_QUEUES {
+            Some(Self::map_queues_callback)
+        } else {
+            None
+        },
+        #[cfg(CONFIG_BLK_DEBUG_FS)]
+        show_rq: None,
+    };
+
+    pub(crate) const unsafe fn build() -> &'static bindings::blk_mq_ops {
+        &Self::VTABLE
+    }
+}
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
new file mode 100644
index 000000000000..25c16ee0b1f7
--- /dev/null
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -0,0 +1,30 @@
+use core::fmt::{self, Write};
+
+pub(crate) struct RawWriter {
+    ptr: *mut u8,
+    len: usize,
+}
+
+impl RawWriter {
+    unsafe fn new(ptr: *mut u8, len: usize) -> Self {
+        Self { ptr, len }
+    }
+
+    pub(crate) fn from_array<const N: usize>(a: &mut [core::ffi::c_char; N]) -> Self {
+        unsafe { Self::new(&mut a[0] as *mut _ as _, N) }
+    }
+}
+
+impl Write for RawWriter {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        let bytes = s.as_bytes();
+        let len = bytes.len();
+        if len > self.len {
+            return Err(fmt::Error);
+        }
+        unsafe { core::ptr::copy_nonoverlapping(&bytes[0], self.ptr, len) };
+        self.ptr = unsafe { self.ptr.add(len) };
+        self.len -= len;
+        Ok(())
+    }
+}
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
new file mode 100644
index 000000000000..e95ae3fd71ad
--- /dev/null
+++ b/rust/kernel/block/mq/request.rs
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides a wrapper for the C `struct request` type.
+//!
+//! C header: [`include/linux/blk-mq.h`](../../include/linux/blk-mq.h)
+
+use crate::{
+    bindings,
+    block::mq::Operations,
+    error::{Error, Result},
+};
+use core::marker::PhantomData;
+
+/// A wrapper around a blk-mq `struct request`. This represents an IO request.
+pub struct Request<T: Operations> {
+    ptr: *mut bindings::request,
+    _p: PhantomData<T>,
+}
+
+impl<T: Operations> Request<T> {
+    pub(crate) unsafe fn from_ptr(ptr: *mut bindings::request) -> Self {
+        Self {
+            ptr,
+            _p: PhantomData,
+        }
+    }
+
+    /// Get the command identifier for the request
+    pub fn command(&self) -> u32 {
+        unsafe { (*self.ptr).cmd_flags & ((1 << bindings::REQ_OP_BITS) - 1) }
+    }
+
+    /// Call this to indicate to the kernel that the request has been issued by the driver
+    pub fn start(&self) {
+        unsafe { bindings::blk_mq_start_request(self.ptr) };
+    }
+
+    /// Call this to indicate to the kernel that the request has been completed without errors
+    // TODO: Consume rq so that we can't use it after ending it?
+    pub fn end_ok(&self) {
+        unsafe { bindings::blk_mq_end_request(self.ptr, bindings::BLK_STS_OK as _) };
+    }
+
+    /// Call this to indicate to the kernel that the request completed with an error
+    pub fn end_err(&self, err: Error) {
+        unsafe { bindings::blk_mq_end_request(self.ptr, err.to_blk_status()) };
+    }
+
+    /// Call this to indicate that the request completed with the status indicated by `status`
+    pub fn end(&self, status: Result) {
+        if let Err(e) = status {
+            self.end_err(e);
+        } else {
+            self.end_ok();
+        }
+    }
+
+    /// Call this to schedule defered completion of the request
+    // TODO: Consume rq so that we can't use it after completing it?
+    pub fn complete(&self) {
+        if !unsafe { bindings::blk_mq_complete_request_remote(self.ptr) } {
+            T::complete(&unsafe { Self::from_ptr(self.ptr) });
+        }
+    }
+
+    /// Get the target sector for the request
+    #[inline(always)]
+    pub fn sector(&self) -> usize {
+        unsafe { (*self.ptr).__sector as usize }
+    }
+}
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
new file mode 100644
index 000000000000..d122db7f6d0e
--- /dev/null
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides the `TagSet` struct to wrap the C `struct blk_mq_tag_set`.
+//!
+//! C header: [`include/linux/blk-mq.h`](../../include/linux/blk-mq.h)
+
+use crate::{
+    bindings,
+    block::mq::{operations::OperationsVtable, Operations},
+    error::{Error, Result},
+    sync::Arc,
+    types::ForeignOwnable,
+};
+use core::{cell::UnsafeCell, convert::TryInto, marker::PhantomData};
+
+/// A wrapper for the C `struct blk_mq_tag_set`
+pub struct TagSet<T: Operations> {
+    inner: UnsafeCell<bindings::blk_mq_tag_set>,
+    _p: PhantomData<T>,
+}
+
+impl<T: Operations> TagSet<T> {
+    /// Try to create a new tag set
+    pub fn try_new(
+        nr_hw_queues: u32,
+        tagset_data: T::TagSetData,
+        num_tags: u32,
+        num_maps: u32,
+    ) -> Result<Arc<Self>> {
+        let tagset = Arc::try_new(Self {
+            inner: UnsafeCell::new(bindings::blk_mq_tag_set::default()),
+            _p: PhantomData,
+        })?;
+
+        // SAFETY: We just allocated `tagset`, we know this is the only reference to it.
+        let inner = unsafe { &mut *tagset.inner.get() };
+
+        inner.ops = unsafe { OperationsVtable::<T>::build() };
+        inner.nr_hw_queues = nr_hw_queues;
+        inner.timeout = 0; // 0 means default which is 30 * HZ in C
+        inner.numa_node = bindings::NUMA_NO_NODE;
+        inner.queue_depth = num_tags;
+        inner.cmd_size = core::mem::size_of::<T::RequestData>().try_into()?;
+        inner.flags = bindings::BLK_MQ_F_SHOULD_MERGE;
+        inner.driver_data = tagset_data.into_foreign() as _;
+        inner.nr_maps = num_maps;
+
+        // SAFETY: `inner` points to valid and initialised memory.
+        let ret = unsafe { bindings::blk_mq_alloc_tag_set(inner) };
+        if ret < 0 {
+            // SAFETY: We created `driver_data` above with `into_foreign`
+            unsafe { T::TagSetData::from_foreign(inner.driver_data) };
+            return Err(Error::from_errno(ret));
+        }
+
+        Ok(tagset)
+    }
+
+    /// Return the pointer to the wrapped `struct blk_mq_tag_set`
+    pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
+        self.inner.get()
+    }
+}
+
+impl<T: Operations> Drop for TagSet<T> {
+    fn drop(&mut self) {
+        let tagset_data = unsafe { (*self.inner.get()).driver_data };
+
+        // SAFETY: `inner` is valid and has been properly initialised during construction.
+        unsafe { bindings::blk_mq_free_tag_set(self.inner.get()) };
+
+        // SAFETY: `tagset_data` was created by a call to
+        // `ForeignOwnable::into_foreign` in `TagSet::try_new()`
+        unsafe { T::TagSetData::from_foreign(tagset_data) };
+    }
+}
+
+/// A tag set reference. Used to control lifetime and prevent drop of TagSet references passed to
+/// `Operations::map_queues()`
+pub struct TagSetRef {
+    ptr: *mut bindings::blk_mq_tag_set,
+}
+
+impl TagSetRef {
+    pub(crate) unsafe fn from_ptr(tagset: *mut bindings::blk_mq_tag_set) -> Self {
+        Self { ptr: tagset }
+    }
+
+    pub fn ptr(&self) -> *mut bindings::blk_mq_tag_set {
+        self.ptr
+    }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 5f4114b30b94..421fef677321 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -107,6 +107,10 @@ impl Error {
         self.0
     }
 
+    pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
+        unsafe { bindings::errno_to_blk_status(self.0) }
+    }
+
     /// Returns the error encoded as a pointer.
     #[allow(dead_code)]
     pub(crate) fn to_ptr<T>(self) -> *mut T {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 8bef6686504b..cd798d12d97c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,7 @@ extern crate self as kernel;
 #[cfg(not(test))]
 #[cfg(not(testlib))]
 mod allocator;
+pub mod block;
 mod build_assert;
 pub mod error;
 pub mod init;
-- 
2.40.0

