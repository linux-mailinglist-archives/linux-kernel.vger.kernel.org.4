Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F0E6DA516
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDFV6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbjDFV5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:57:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC0C662;
        Thu,  6 Apr 2023 14:56:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC9F266031E5;
        Thu,  6 Apr 2023 22:56:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680818199;
        bh=C96CX0gBykPcUYmkODcP4UC2eE4vLS/sM/+9ysNemDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asalYTtqDCip3hexE6lvQt+gOkLosY1QGopaolMtbfe37nTCszZafYOZGJDLmmeib
         Tgy1h2Wr17gU+xdNQlQJBqSiZPHTpstc7SfTZdo4VULy8HSJGFMq6Yf046juhiqbH+
         yXqacDzybyDX+KcI2SXuWsmEIn/PfAawCqoogtQzZ3NdFMMWfeQ+S5GdBqwVXZhhXv
         pftxSVvbRrmsiMKLOVpGmo3mrTh1iA/+u9N/H2W9BF0kLrFQOjVf0qkVQAJm4fijL5
         tn1jWOWFPhCvGUJG27w8NdcDqpF6rI7wf5vpxkk/o6rG6ILpyAy9gQFkX+AnDLjGIG
         952lc2lpvU4cg==
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl
Cc:     Daniel Almeida <daniel.almeida@collabora.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 4/6] rust: media: videobuf2: add a videobuf2 abstraction
Date:   Thu,  6 Apr 2023 18:56:13 -0300
Message-Id: <20230406215615.122099-5-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406215615.122099-1-daniel.almeida@collabora.com>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a videobuf2 abstraction. Notably, only vb2_v4l2_buffer is supported
as the subsystem-specific struct.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h     |   3 +
 rust/kernel/media/mod.rs            |   1 +
 rust/kernel/media/videobuf2/core.rs | 552 ++++++++++++++++++++++++++++
 rust/kernel/media/videobuf2/mod.rs  |   5 +
 4 files changed, 561 insertions(+)
 create mode 100644 rust/kernel/media/videobuf2/core.rs
 create mode 100644 rust/kernel/media/videobuf2/mod.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3b3d6fcf110f..3153894f426b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -36,6 +36,9 @@
 #include <linux/uaccess.h>
 #include <linux/uio.h>
 #include <linux/videodev2.h>
+#include <media/videobuf2-core.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-sg.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/media/mod.rs b/rust/kernel/media/mod.rs
index 342e66382719..95b11544af8d 100644
--- a/rust/kernel/media/mod.rs
+++ b/rust/kernel/media/mod.rs
@@ -3,3 +3,4 @@
 //! Media subsystem
 
 pub mod v4l2;
+pub mod videobuf2;
diff --git a/rust/kernel/media/videobuf2/core.rs b/rust/kernel/media/videobuf2/core.rs
new file mode 100644
index 000000000000..40ab06475a8e
--- /dev/null
+++ b/rust/kernel/media/videobuf2/core.rs
@@ -0,0 +1,552 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Video Buffer 2 Core Framework
+//!
+//! C header: [`include/media/videobuf2-core.h`](../../../../include/media/videobuf2-core.h)
+
+use core::cell::UnsafeCell;
+use core::marker::PhantomData;
+use core::ops::Deref;
+
+use alloc::slice;
+
+use crate::device::RawDevice;
+use crate::error::from_kernel_result;
+use crate::media::v4l2::{enums, mmap};
+use crate::prelude::*;
+use crate::sync::ffi_mutex::FfiMutex;
+use crate::sync::Arc;
+use crate::ForeignOwnable;
+
+/// The queue operations to be implemented by drivers.
+#[vtable]
+pub trait QueueOperations {
+    /// The subsystem-specific data, usually bindings::vb2_v4l2_buffer.
+    type SubsystemSpecificData = bindings::vb2_v4l2_buffer;
+    /// The driver specific data.
+    type DriverSpecificData;
+    /// The private data held in the queue.
+    type PrivateData: ForeignOwnable
+        + Deref<Target = PrivateData<Self::SubsystemSpecificData, Self::DriverSpecificData>>;
+
+    // Note: alloc_devs is TODO
+
+    /// Called as part of the queue_setup() queue operation.
+    fn queue_setup(
+        queue: &QueueRef,
+        private_data: &mut Self::PrivateData,
+        num_buffers: &mut u32,
+        num_planes: &mut u32,
+        sizes: &mut [u32],
+    ) -> Result;
+
+    /// Called as part of the wait_prepare() queue operation.
+    fn wait_prepare(_queue: &QueueRef, _private_data: &mut Self::PrivateData) {}
+
+    /// Called as part of the wait_finish() queue operation.
+    fn wait_finish(_queue: &QueueRef, _private_data: &mut Self::PrivateData) {}
+
+    /// Optional. Called as part of the buf_out_validate() queue operation.
+    fn buf_out_validate(_buffer: &Buffer, _private_data: &mut Self::PrivateData) -> Result {
+        Ok(())
+    }
+
+    /// Called as part of the buf_init() queue operation.
+    fn buf_init(_buffer: &Buffer, _private_data: &mut Self::PrivateData) -> Result;
+    /// Called as part of the buf_prepare() queue operation.
+    fn buf_prepare(_buffer: &Buffer, _private_data: &mut Self::PrivateData) -> Result;
+    /// Called as part of the buf_finish() queue operation.
+    fn buf_finish(_buffer: &Buffer, _private_data: &mut Self::PrivateData) {}
+    /// Called as part of the buf_cleanup() queue operation.
+    fn buf_cleanup(_buffer: &Buffer, _private_data: &mut Self::PrivateData);
+
+    /// Called as part of the prepare_streaming() queue operation.
+    fn prepare_streaming(_queue: &QueueRef, _private_data: &mut Self::PrivateData) -> Result {
+        Ok(())
+    }
+    /// Called as part of the start_streaming() queue operation.
+    fn start_streaming(
+        _queue: &QueueRef,
+        _private_data: &mut Self::PrivateData,
+        _count: u32,
+    ) -> Result;
+
+    /// Called as part of the unprepare_streaming() queue operation.
+    fn unprepare_streaming(_queue: &QueueRef, _private_data: &mut Self::PrivateData) {}
+    /// Called as part of the stop_streaming() queue operation.
+    fn stop_streaming(_queue: &QueueRef, _private_data: &mut Self::PrivateData);
+    /// Called as part of the buf_queue() queue operation.
+    fn buf_queue(_buffer: &Buffer, _private_data: &mut Self::PrivateData);
+    /// Called as part of the buf_request_complete() queue operation.
+    fn buf_request_complete(_buffer: &Buffer, _private_data: &mut Self::PrivateData) {}
+}
+
+type AsPrivateData<T> = <T as QueueOperations>::PrivateData;
+
+struct Vb2OperationsVtable<T: QueueOperations>(PhantomData<T>);
+
+impl<T: QueueOperations> Vb2OperationsVtable<T> {
+    unsafe extern "C" fn queue_setup_callback(
+        q: *mut bindings::vb2_queue,
+        num_buffers: *mut core::ffi::c_uint,
+        num_planes: *mut core::ffi::c_uint,
+        sizes: *mut core::ffi::c_uint,
+        _alloc_devs: *mut *mut bindings::device,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            // SAFETY: `q` is a pointer returned by the kernel and outlives the
+            // QueueRef as QueueRef is dropped by the end of this function
+            let queue = unsafe { QueueRef::from_ptr(q) };
+
+            // SAFETY: into_foreign() was called in Queue::new() and this
+            // function is called because we set the ops during Queue::new().
+            // Furthermore, from_pointer() is only called when Queue is dropped,
+            // at which point we cannot be called anymore because we will have
+            // called vb2_queue_release. There are no other concurrent uses of
+            // the pointer until the guard is dropped.
+            let mut private_data = unsafe { T::PrivateData::borrow_mut((*q).drv_priv) };
+
+            // SAFETY: sizes is known to be of size bindings::VB2_MAX_PLANES as
+            // per videobuf2-core.c::vb2_core_reqbufs()
+            let sizes = unsafe { slice::from_raw_parts_mut(sizes as _, bindings::VB2_MAX_PLANES as usize) };
+
+            // SAFETY: these are both safe, since they're initialized in
+            // videobuf2-core.c::vb2_core_reqbufs() and they are not read from any
+            // other pointer while the reference exists, since they live in the
+            // stack of vb2_core_reqbufs().
+            let num_buffers = unsafe { num_buffers.as_mut().ok_or(EINVAL) }?;
+            let num_planes = unsafe { num_planes.as_mut().ok_or(EINVAL) }?;
+
+            T::queue_setup(&queue, &mut private_data, num_buffers, num_planes, sizes)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn wait_prepare_callback(q: *mut bindings::vb2_queue) {
+        // SAFETY: QueueRef has a shorter lifetime if compared to the lifetime
+        // of q. The pointer is passed in by the kernel and thus it is assumed
+        // valid.
+        let queue = unsafe { QueueRef::from_ptr(q) };
+        // Same safety comments from queue_setup_callback apply.
+        let mut private_data = unsafe { T::PrivateData::borrow_mut((*q).drv_priv) };
+        T::wait_prepare(&queue, &mut private_data);
+    }
+
+    unsafe extern "C" fn wait_finish_callback(q: *mut bindings::vb2_queue) {
+        // Same safety comment from wait_prepare_callback applies.
+        let queue = unsafe { QueueRef::from_ptr(q) };
+        // Same safety comments from queue_setup_callback apply.
+        let mut private_data = unsafe { T::PrivateData::borrow_mut((*q).drv_priv) };
+        T::wait_finish(&queue, &mut private_data);
+    }
+
+    unsafe extern "C" fn buf_out_validate_callback(
+        vb: *mut bindings::vb2_buffer,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            // SAFETY: Buffer has a shorter lifetime if compared to the lifetime
+            // of vb. The pointer is passed in by the kernel and thus it is assumed
+            // valid.
+            let buf = unsafe { Buffer::from_ptr(vb) };
+            let queue_ptr = buf.queue_ptr();
+
+            // Same safety comments from queue_setup_callback apply.
+            let mut private_data = unsafe { T::PrivateData::borrow_mut((*queue_ptr).drv_priv) };
+
+            T::buf_out_validate(&buf, &mut private_data)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn buf_init_callback(vb: *mut bindings::vb2_buffer) -> core::ffi::c_int {
+        from_kernel_result! {
+            // SAFETY: Buffer has a shorter lifetime if compared to the lifetime
+            // of vb. The pointer is passed in by the kernel and thus it is assumed
+            // valid.
+            let buf = unsafe { Buffer::from_ptr(vb) };
+            let queue_ptr = buf.queue_ptr();
+
+            // Same safety comments from queue_setup_callback apply.
+            let mut private_data = unsafe { T::PrivateData::borrow_mut((*queue_ptr).drv_priv) };
+
+            T::buf_init(&buf, &mut private_data)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn buf_prepare_callback(vb: *mut bindings::vb2_buffer) -> core::ffi::c_int {
+        from_kernel_result! {
+            // SAFETY: Buffer has a shorter lifetime if compared to the lifetime
+            // of vb. The pointer is passed in by the kernel and thus it is assumed
+            // valid.
+            let buf = unsafe { Buffer::from_ptr(vb) };
+            let queue_ptr = buf.queue_ptr();
+
+            // Same safety comments from queue_setup_callback apply.
+            let mut private_data = unsafe { T::PrivateData::borrow_mut((*queue_ptr).drv_priv) };
+
+            T::buf_prepare(&buf, &mut private_data)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn buf_finish_callback(vb: *mut bindings::vb2_buffer) {
+        // SAFETY: Buffer has a shorter lifetime if compared to the lifetime
+        // of vb. The pointer is passed in by the kernel and thus it is assumed
+        // valid.
+        let buf = unsafe { Buffer::from_ptr(vb) };
+        let queue_ptr = buf.queue_ptr();
+
+        // Same safety comments from queue_setup_callback apply.
+        let mut private_data = unsafe { T::PrivateData::borrow_mut((*queue_ptr).drv_priv) };
+
+        T::buf_finish(&buf, &mut private_data);
+    }
+
+    unsafe extern "C" fn buf_cleanup_callback(vb: *mut bindings::vb2_buffer) {
+        // SAFETY: Buffer has a shorter lifetime if compared to the lifetime
+        // of vb. The pointer is passed in by the kernel and thus it is assumed
+        // valid.
+        let buf = unsafe { Buffer::from_ptr(vb) };
+        let queue_ptr = buf.queue_ptr();
+
+        // Same safety comments from queue_setup_callback apply.
+        let mut private_data = unsafe { T::PrivateData::borrow_mut((*queue_ptr).drv_priv) };
+
+        T::buf_cleanup(&buf, &mut private_data);
+    }
+
+    unsafe extern "C" fn prepare_streaming_callback(
+        q: *mut bindings::vb2_queue,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            // SAFETY: QueueRef has a shorter lifetime if compared to the lifetime
+            // of q. The pointer is passed in by the kernel and thus it is assumed
+            // valid.
+            let queue = unsafe { QueueRef::from_ptr(q) };
+            // Same safety comments from queue_setup_callback apply.
+            let mut private_data = unsafe { T::PrivateData::borrow_mut((*q).drv_priv) };
+            T::prepare_streaming(&queue, &mut private_data)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn start_streaming_callback(
+        q: *mut bindings::vb2_queue,
+        count: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            // Same safety comments from queue_setup() apply.
+            let queue = unsafe { QueueRef::from_ptr(q) };
+        let mut private_data = unsafe { T::PrivateData::borrow_mut((*q).drv_priv) };
+            T::start_streaming(&queue, &mut private_data, count)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn stop_streaming_callback(q: *mut bindings::vb2_queue) {
+        // Same safety comments from queue_setup() apply.
+        let queue = unsafe { QueueRef::from_ptr(q) };
+        let mut private_data = unsafe { T::PrivateData::borrow_mut((*q).drv_priv) };
+        T::stop_streaming(&queue, &mut private_data);
+    }
+
+    unsafe extern "C" fn unprepare_streaming_callback(q: *mut bindings::vb2_queue) {
+        // SAFETY: QueueRef has a shorter lifetime if compared to the lifetime
+        // of q. The pointer is passed in by the kernel and thus it is assumed
+        // valid.
+        let queue = unsafe { QueueRef::from_ptr(q) };
+        // Same safety comments from queue_setup_callback apply.
+        let mut private_data = unsafe { T::PrivateData::borrow_mut((*q).drv_priv) };
+        T::unprepare_streaming(&queue, &mut private_data);
+    }
+
+    unsafe extern "C" fn buf_queue_callback(vb: *mut bindings::vb2_buffer) {
+        // SAFETY: Buffer has a shorter lifetime if compared to the lifetime
+        // of vb. The pointer is passed in by the kernel and thus it is assumed
+        // valid.
+        let buf = unsafe { Buffer::from_ptr(vb) };
+        let queue_ptr = buf.queue_ptr();
+
+        // Same safety comments from queue_setup_callback apply.
+        let mut private_data = unsafe { T::PrivateData::borrow_mut((*queue_ptr).drv_priv) };
+
+        T::buf_queue(&buf, &mut private_data);
+    }
+
+    unsafe extern "C" fn buf_request_complete_callback(vb: *mut bindings::vb2_buffer) {
+        // SAFETY: Buffer has a shorter lifetime if compared to the lifetime
+        // of vb. The pointer is passed in by the kernel and thus it is assumed
+        // valid.
+        let buf = unsafe { Buffer::from_ptr(vb) };
+        let queue_ptr = buf.queue_ptr();
+
+        // Same safety comments from queue_setup_callback apply.
+        let mut private_data = unsafe { T::PrivateData::borrow_mut((*queue_ptr).drv_priv) };
+
+        T::buf_request_complete(&buf, &mut private_data);
+    }
+
+    const VTABLE: bindings::vb2_ops = bindings::vb2_ops {
+        queue_setup: Some(Self::queue_setup_callback),
+        wait_prepare: if T::HAS_WAIT_PREPARE {
+            Some(Self::wait_prepare_callback)
+        } else {
+            None
+        },
+        wait_finish: if T::HAS_WAIT_FINISH {
+            Some(Self::wait_finish_callback)
+        } else {
+            None
+        },
+        buf_out_validate: if T::HAS_BUF_OUT_VALIDATE {
+            Some(Self::buf_out_validate_callback)
+        } else {
+            None
+        },
+        buf_init: Some(Self::buf_init_callback),
+        buf_prepare: Some(Self::buf_prepare_callback),
+        buf_finish: if T::HAS_BUF_FINISH {
+            Some(Self::buf_finish_callback)
+        } else {
+            None
+        },
+        buf_cleanup: Some(Self::buf_cleanup_callback),
+        start_streaming: Some(Self::start_streaming_callback),
+        stop_streaming: Some(Self::stop_streaming_callback),
+        buf_queue: Some(Self::buf_queue_callback),
+        buf_request_complete: if T::HAS_BUF_REQUEST_COMPLETE {
+            Some(Self::buf_request_complete_callback)
+        } else {
+            None
+        },
+        prepare_streaming: if T::HAS_PREPARE_STREAMING {
+            Some(Self::prepare_streaming_callback)
+        } else {
+            None
+        },
+        unprepare_streaming: if T::HAS_UNPREPARE_STREAMING {
+            Some(Self::unprepare_streaming_callback)
+        } else {
+            None
+        },
+    };
+
+    fn build() -> &'static bindings::vb2_ops {
+        &Self::VTABLE
+    }
+}
+
+/// The IO modes as defined by `struct vb2_io_mode::VB2_*`.
+#[allow(missing_docs)]
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub enum IoModes {
+    Mmap = bindings::vb2_io_modes_VB2_MMAP as isize,
+    UserPtr = bindings::vb2_io_modes_VB2_USERPTR as isize,
+    Read = bindings::vb2_io_modes_VB2_READ as isize,
+    Write = bindings::vb2_io_modes_VB2_WRITE as isize,
+    DmaBuf = bindings::vb2_io_modes_VB2_DMABUF as isize,
+}
+
+/// Controls the value assigned to the `mem_ops` member.
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub enum MemOps {
+    /// Sets `bindings::vb2_dma_sg_memops`.
+    DmaSg,
+}
+
+/// Represents the driver-specific buffer structure. This must contain the
+/// subsystem-specific structure as its first member. For now, only `struct
+/// vb2_v4l2_buffer` is supported as the subsystem-specific structure.
+#[repr(C)]
+pub struct PrivateData<T, U> {
+    subsystem_specific: T,
+    driver_specific: U,
+}
+
+impl<T, U> PrivateData<T, U> {
+    /// Returns the size of the driver-specific struct.
+    pub fn driver_data_size(&self) -> usize {
+        core::mem::size_of_val(&self.driver_specific)
+    }
+
+    /// Returns the subsystem-specific struct.
+    pub fn subsystem_specific(&self) -> &T {
+        &self.subsystem_specific
+    }
+
+    /// Returns the driver-specific struct.
+    pub fn driver_specific_mut(&mut self) -> &mut U {
+        &mut self.driver_specific
+    }
+}
+
+impl<U> PrivateData<bindings::vb2_v4l2_buffer, U> {
+    /// Creates a new instance.
+    pub fn new(data: U) -> Self {
+        Self {
+            subsystem_specific: Default::default(),
+            driver_specific: data,
+        }
+    }
+}
+
+/// A struct containing the parameters for queue creation.
+#[allow(missing_docs)]
+pub struct QueueCreateInfo<'a, T: QueueOperations, U: RawDevice> {
+    pub buf_type: enums::BufType,
+    pub io_modes: &'a [IoModes],
+    pub dev: Arc<U>,
+    pub timestamp_flags: &'a [mmap::BufferFlag],
+    pub lock: Option<Pin<Box<FfiMutex>>>,
+    pub min_buffers_needed: usize,
+    pub gfp_flags: u32,
+    pub mem_ops: MemOps,
+    pub requires_requests: bool,
+    pub supports_requests: bool,
+    pub private_data: Option<T::PrivateData>,
+}
+
+/// An owned wrapper over `struct vb2_queue`.
+pub struct Queue<T: QueueOperations> {
+    inner: UnsafeCell<bindings::vb2_queue>,
+    has_private_data: bool,
+    _lock: Option<Pin<Box<FfiMutex>>>,
+    _p1: PhantomData<T>,
+}
+
+impl<T: QueueOperations> Queue<T> {
+    /// Creates a new queue.
+    pub fn new<U: RawDevice>(create_info: QueueCreateInfo<'_, T, U>) -> Result<Self> {
+        let QueueCreateInfo {
+            buf_type,
+            io_modes,
+            dev,
+            timestamp_flags,
+            mut lock,
+            min_buffers_needed,
+            gfp_flags,
+            mem_ops,
+            requires_requests,
+            supports_requests,
+            private_data,
+        } = create_info;
+
+        let mut io_modes_val = 0;
+        for io_mode in io_modes {
+            io_modes_val |= *io_mode as u32;
+        }
+
+        let mut timestamp_flags_val = 0;
+        for timestamp_flag in timestamp_flags {
+            timestamp_flags_val |= *timestamp_flag as u32;
+        }
+
+        let (buf_struct_size, drv_priv, has_private_data) = if let Some(private_data) = private_data
+        {
+            (
+                private_data.driver_data_size(),
+                private_data.into_foreign() as *mut _,
+                true,
+            )
+        } else {
+            (0, core::ptr::null_mut(), false)
+        };
+
+        let mut inner = bindings::vb2_queue {
+            type_: buf_type as _,
+            io_modes: io_modes_val,
+            dev: dev.raw_device(),
+            ..Default::default()
+        };
+
+        if let Some(ref mut lock) = lock {
+            let raw_lock = unsafe { lock.as_mut().raw() };
+            inner.lock = raw_lock;
+        }
+
+        inner.drv_priv = drv_priv;
+        inner.buf_struct_size = buf_struct_size as u32;
+        inner.timestamp_flags = timestamp_flags_val;
+        inner.gfp_flags = gfp_flags;
+        inner.min_buffers_needed = min_buffers_needed as u32;
+
+        inner.set_requires_requests(requires_requests as u32);
+        inner.set_supports_requests(supports_requests as u32);
+
+        inner.ops = Vb2OperationsVtable::<T>::build();
+
+        inner.mem_ops = match mem_ops {
+            // SAFETY: this will be called by the C code.
+            MemOps::DmaSg => unsafe { &bindings::vb2_dma_sg_memops as _ },
+        };
+
+        // SAFETY: just a FFI call and we have just initialized `inner`.
+        unsafe {
+            bindings::vb2_queue_init(&mut inner as _);
+        }
+
+        let inner = UnsafeCell::new(inner);
+
+        Ok(Self {
+            inner,
+            has_private_data,
+            _p1: PhantomData,
+            _lock: lock,
+        })
+    }
+}
+
+impl<T: QueueOperations> Drop for Queue<T> {
+    fn drop(&mut self) {
+        if self.has_private_data {
+            // SAFETY: into_pointer() was previously called during new() and
+            // `self.has_private_data` was set accordingly.
+            unsafe {
+                AsPrivateData::<T>::from_foreign(self.inner.get_mut().drv_priv);
+            }
+        }
+
+        // SAFETY: just a FFI call and we have initialized `inner` during new().
+        unsafe {
+            bindings::vb2_queue_release(self.inner.get());
+        }
+    }
+}
+
+// SAFETY: This is a wrapper over the `struct vb2_queue` C type, which can be
+// used from any thread.
+unsafe impl<T: QueueOperations> Send for Queue<T> {}
+
+/// A wrapper over a pointer to `struct vb2_queue`.
+pub struct QueueRef {
+    _ptr: *mut bindings::vb2_queue,
+}
+
+impl QueueRef {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`QueueRef`] instance.
+    unsafe fn from_ptr(ptr: *mut bindings::vb2_queue) -> Self {
+        Self { _ptr: ptr }
+    }
+}
+
+/// A wrapper over a pointer to `struct vb2_buffer`.
+pub struct Buffer {
+    ptr: *mut bindings::vb2_buffer,
+}
+
+impl Buffer {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`Buffer`] instance.
+    pub(crate) unsafe fn from_ptr(ptr: *mut bindings::vb2_buffer) -> Self {
+        Self { ptr }
+    }
+
+    pub(crate) fn queue_ptr(&self) -> *mut bindings::vb2_queue {
+        // SAFETY: self.ptr should be valid according to the safety requirements in `from_raw()`.
+        unsafe { (*self.ptr).vb2_queue }
+    }
+}
diff --git a/rust/kernel/media/videobuf2/mod.rs b/rust/kernel/media/videobuf2/mod.rs
new file mode 100644
index 000000000000..6b0be2c7a14d
--- /dev/null
+++ b/rust/kernel/media/videobuf2/mod.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Videobuf2 Framework
+
+pub mod core;
-- 
2.40.0

