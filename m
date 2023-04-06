Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C31E6DA517
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbjDFV6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbjDFV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:57:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42B1AD38;
        Thu,  6 Apr 2023 14:56:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F1F9266031D1;
        Thu,  6 Apr 2023 22:56:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680818202;
        bh=FegfZ3tLOugnBxUw43eQFl1qVBqSNnm9U1uA7lyIrEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbwCP/2MMMRuRUkWV+JJNYUocsBmk8GL7TDbJDRVPQ/Bv2aBgcjjuBndFy0LZHu0e
         iaUWbagp/w4FqQqCd2+vxcLvd/RRk0UtspNd3oEUWvugqhQhGLfLOc8DttnqI0Igwn
         yZ7l52dXLHhYfuCbbpCuJJMbhPGVY8TCEVZfqctmTXd3vZSloin/oseo28JD4ZCgfW
         K9k8RyD13ZY51rnqKElgFOiyEGO/iGYJ+icd/4VdDMbu6yfqh1XbBHocIi4CPXTLHN
         mwKVMly9F70Pfb6km5HFaG219J8WnvlJbOao8vB+NV/u2sS8rJ9QwtALrqBZDtv1n+
         RkEADafoYdF5Q==
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl
Cc:     Daniel Almeida <daniel.almeida@collabora.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 5/6] rust: media: add {video|v4l2}_device_register support
Date:   Thu,  6 Apr 2023 18:56:14 -0300
Message-Id: <20230406215615.122099-6-daniel.almeida@collabora.com>
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

Add {video|v4l2}_device_register support, essentially introducing
(initial) support for v4l2 drivers in Rust.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h  |   4 +
 rust/kernel/media/v4l2/dev.rs    | 369 +++++++++++++++++++
 rust/kernel/media/v4l2/device.rs | 115 ++++++
 rust/kernel/media/v4l2/ioctls.rs | 608 +++++++++++++++++++++++++++++++
 rust/kernel/media/v4l2/mod.rs    |   3 +
 5 files changed, 1099 insertions(+)
 create mode 100644 rust/kernel/media/v4l2/dev.rs
 create mode 100644 rust/kernel/media/v4l2/device.rs
 create mode 100644 rust/kernel/media/v4l2/ioctls.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3153894f426b..bf2e833e511c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -36,6 +36,10 @@
 #include <linux/uaccess.h>
 #include <linux/uio.h>
 #include <linux/videodev2.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-ioctl.h>
 #include <media/videobuf2-core.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/videobuf2-dma-sg.h>
diff --git a/rust/kernel/media/v4l2/dev.rs b/rust/kernel/media/v4l2/dev.rs
new file mode 100644
index 000000000000..32a7573f3439
--- /dev/null
+++ b/rust/kernel/media/v4l2/dev.rs
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! V4L2 Driver Helper API
+//!
+//! C header: [`include/media/v4l2-dev.h`](../../../../include/media/v4l2-dev.h)
+
+use core::marker::PhantomData;
+use core::pin::Pin;
+
+use crate::device;
+use crate::media::v4l2::capabilities;
+use crate::media::v4l2::device::V4l2Device;
+use crate::prelude::*;
+use crate::sync::smutex::Mutex;
+use crate::sync::Arc;
+use crate::ForeignOwnable;
+use crate::Result;
+use crate::ThisModule;
+
+/// The driver trait to be implemented by driver authors.
+pub trait Driver: crate::media::v4l2::ioctls::Operations<PrivateData = Self::DriverData> {
+    /// The driver's private data.
+    type DriverData: ForeignOwnable + Sync + Send;
+}
+
+/// VflDevNodeTypes as described by `VFL_TYPE_*` constants.
+#[allow(missing_docs)]
+pub enum VflDevNodeType {
+    Video = bindings::vfl_devnode_type_VFL_TYPE_VIDEO as isize,
+    Vbi = bindings::vfl_devnode_type_VFL_TYPE_VBI as isize,
+    Radio = bindings::vfl_devnode_type_VFL_TYPE_RADIO as isize,
+    Subdev = bindings::vfl_devnode_type_VFL_TYPE_SUBDEV as isize,
+    Sdr = bindings::vfl_devnode_type_VFL_TYPE_SDR as isize,
+    Touch = bindings::vfl_devnode_type_VFL_TYPE_TOUCH as isize,
+}
+
+/// A Video Device.
+pub struct VideoDevice<T> {
+    /// A raw pointer to `struct video_device` in C.
+    pub(crate) device: bindings::video_device,
+    /// A phantom for T. We need T to access the associated constants set by
+    /// drivers.
+    pub(crate) _phantom: PhantomData<T>,
+    /// Associated V4l2Device that must be kept alive while the VideoDevice is
+    /// in use.
+    _v4l2_device: Arc<Mutex<V4l2Device>>,
+}
+
+impl<T> VideoDevice<T> {
+    fn new(v4l2_device: Arc<Mutex<V4l2Device>>) -> Result<Self> {
+        let mut device = bindings::video_device::default();
+
+        let mut guard = v4l2_device.as_ref().lock();
+        let inner = &mut *guard;
+        let v4l2_device_ptr = inner.device_mut() as *mut bindings::v4l2_device;
+
+        device.v4l2_dev = v4l2_device_ptr;
+        drop(guard);
+
+        Ok(Self {
+            device,
+            _v4l2_device: v4l2_device,
+            _phantom: PhantomData,
+        })
+    }
+
+    fn _raw(&self) -> &bindings::video_device {
+        &self.device
+    }
+
+    fn raw_mut(&mut self) -> &mut bindings::video_device {
+        &mut self.device
+    }
+}
+
+impl<T> Drop for VideoDevice<T> {
+    fn drop(&mut self) {
+        unsafe { bindings::video_device_release(self.raw_mut()) }
+    }
+}
+
+/// Functions to be passed to the `fops` member.
+#[derive(Default)]
+#[allow(missing_docs)]
+pub struct V4l2FileOperations {
+    pub read: Option<
+        unsafe extern "C" fn(
+            arg1: *mut bindings::file,
+            arg2: *mut core::ffi::c_char,
+            arg3: usize,
+            arg4: *mut bindings::loff_t,
+        ) -> isize,
+    >,
+    pub poll: Option<
+        unsafe extern "C" fn(
+            arg1: *mut bindings::file,
+            arg2: *mut bindings::poll_table_struct,
+        ) -> bindings::__poll_t,
+    >,
+    pub mmap: Option<
+        unsafe extern "C" fn(
+            arg1: *mut bindings::file,
+            arg2: *mut bindings::vm_area_struct,
+        ) -> core::ffi::c_int,
+    >,
+    pub open: Option<unsafe extern "C" fn(arg1: *mut bindings::file) -> core::ffi::c_int>,
+}
+
+/// Functions to be passed to the `ioctl` member.
+#[derive(Default)]
+#[allow(missing_docs)]
+pub struct V4l2IoctlOperations {
+    pub reqbufs: Option<
+        unsafe extern "C" fn(
+            file: *mut bindings::file,
+            fh: *mut core::ffi::c_void,
+            b: *mut bindings::v4l2_requestbuffers,
+        ) -> core::ffi::c_int,
+    >,
+    pub querybuf: Option<
+        unsafe extern "C" fn(
+            file: *mut bindings::file,
+            fh: *mut core::ffi::c_void,
+            b: *mut bindings::v4l2_buffer,
+        ) -> core::ffi::c_int,
+    >,
+    pub qbuf: Option<
+        unsafe extern "C" fn(
+            file: *mut bindings::file,
+            fh: *mut core::ffi::c_void,
+            b: *mut bindings::v4l2_buffer,
+        ) -> core::ffi::c_int,
+    >,
+    pub expbuf: Option<
+        unsafe extern "C" fn(
+            file: *mut bindings::file,
+            fh: *mut core::ffi::c_void,
+            e: *mut bindings::v4l2_exportbuffer,
+        ) -> core::ffi::c_int,
+    >,
+    pub dqbuf: Option<
+        unsafe extern "C" fn(
+            file: *mut bindings::file,
+            fh: *mut core::ffi::c_void,
+            b: *mut bindings::v4l2_buffer,
+        ) -> core::ffi::c_int,
+    >,
+    pub create_bufs: Option<
+        unsafe extern "C" fn(
+            file: *mut bindings::file,
+            fh: *mut core::ffi::c_void,
+            b: *mut bindings::v4l2_create_buffers,
+        ) -> core::ffi::c_int,
+    >,
+    pub prepare_buf: Option<
+        unsafe extern "C" fn(
+            file: *mut bindings::file,
+            fh: *mut core::ffi::c_void,
+            b: *mut bindings::v4l2_buffer,
+        ) -> core::ffi::c_int,
+    >,
+    pub streamon: Option<
+        unsafe extern "C" fn(
+            file: *mut bindings::file,
+            fh: *mut core::ffi::c_void,
+            i: bindings::v4l2_buf_type,
+        ) -> core::ffi::c_int,
+    >,
+    pub streamoff: Option<
+        unsafe extern "C" fn(
+            file: *mut bindings::file,
+            fh: *mut core::ffi::c_void,
+            i: bindings::v4l2_buf_type,
+        ) -> core::ffi::c_int,
+    >,
+}
+
+/// The video registration struct. See `video_device_register!`.
+pub struct VideoRegistration<T: Driver> {
+    device: VideoDevice<T>,
+    registered: bool,
+    fops: bindings::v4l2_file_operations,
+    ioctls: bindings::v4l2_ioctl_ops,
+}
+
+impl<T: Driver> VideoRegistration<T> {
+    /// Creates a new `VideoRegistration`. The driver can manually choose
+    /// alternate ioctl implementations using the `ioctl_operations` argument.
+    pub fn new(
+        _parent: &dyn device::RawDevice,
+        v4l2_device: Arc<Mutex<V4l2Device>>,
+        file_operations: V4l2FileOperations,
+        ioctl_operations: V4l2IoctlOperations,
+    ) -> Result<Self> {
+        let video_device = VideoDevice::new(v4l2_device)?;
+
+        let fops = bindings::v4l2_file_operations {
+            owner: core::ptr::null_mut(),
+            read: file_operations.read,
+            write: None,
+            poll: file_operations.poll,
+            unlocked_ioctl: Some(bindings::video_ioctl2),
+            compat_ioctl32: None,
+            get_unmapped_area: None,
+            mmap: file_operations.mmap,
+            open: file_operations.open,
+            //file_operations::release() is not mandatory, let's try to release things on drop.
+            release: None,
+        };
+
+        let mut ioctls = *crate::media::v4l2::ioctls::OperationsVtable::<T>::build();
+
+        if let Some(op) = &ioctl_operations.reqbufs {
+            ioctls.vidioc_reqbufs = Some(*op);
+        }
+
+        if let Some(op) = &ioctl_operations.querybuf {
+            ioctls.vidioc_querybuf = Some(*op);
+        }
+
+        if let Some(op) = &ioctl_operations.qbuf {
+            ioctls.vidioc_qbuf = Some(*op);
+        }
+
+        if let Some(op) = &ioctl_operations.expbuf {
+            ioctls.vidioc_expbuf = Some(*op);
+        }
+
+        if let Some(op) = &ioctl_operations.dqbuf {
+            ioctls.vidioc_dqbuf = Some(*op);
+        }
+
+        if let Some(op) = &ioctl_operations.create_bufs {
+            ioctls.vidioc_create_bufs = Some(*op);
+        }
+
+        if let Some(op) = &ioctl_operations.prepare_buf {
+            ioctls.vidioc_prepare_buf = Some(*op)
+        }
+
+        if let Some(op) = &ioctl_operations.streamon {
+            ioctls.vidioc_streamon = Some(*op);
+        }
+
+        if let Some(op) = &ioctl_operations.streamoff {
+            ioctls.vidioc_streamoff = Some(*op);
+        }
+
+        Ok(Self {
+            device: video_device,
+            registered: false,
+            fops,
+            ioctls,
+        })
+    }
+
+    /// Registers a video device with the rest of the kernel.
+    ///
+    /// Users are encouraged to use the [`video_device_register`] macro because it automatically
+    /// picks up THIS_MODULE.
+    pub fn register(
+        self: Pin<&mut Self>,
+        data: T::DriverData,
+        vfl_devnode_type: VflDevNodeType,
+        nr: i32,
+        module: &'static ThisModule,
+        capabilities: &[capabilities::Capabilities],
+    ) -> Result {
+        if self.registered {
+            // Already registered.
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We never move out of `this` in this method.
+        let this = unsafe { self.get_unchecked_mut() };
+        let video_device = this.device.raw_mut();
+
+        let mut caps = 0;
+        for capability in capabilities {
+            caps |= *capability as u32;
+        }
+
+        video_device.device_caps = caps;
+
+        // We can release our resources on drop.
+        video_device.release = Some(bindings::video_device_release_empty);
+
+        let data_pointer = <T::DriverData as ForeignOwnable>::into_foreign(data);
+
+        this.fops.owner = module.0;
+        video_device.fops = &this.fops;
+        video_device.ioctl_ops = &this.ioctls;
+
+        // SAFETY: video_device was properly allocated during video_register_device
+        // Use a single unsafe block based on the safety comment above to avoid
+        // repetition of unsafe on pointer accesses below.
+        unsafe {
+            let ret = bindings::__video_register_device(
+                video_device,
+                vfl_devnode_type as _,
+                nr,
+                1,
+                module.0,
+            );
+
+            if ret < 0 {
+                // Reassemble into ForeignOwnable so it can be dropped.
+                // SAFETY: `data_pointer` was returned by `into_foreign` above.
+                T::DriverData::from_foreign(data_pointer);
+                return Err(Error::from_kernel_errno(ret));
+            }
+
+            let video_device_parent = &mut video_device.dev;
+            video_device_parent.driver_data = data_pointer as _;
+        }
+
+        this.registered = true;
+        Ok(())
+    }
+}
+
+impl<T: Driver> Drop for VideoRegistration<T> {
+    fn drop(&mut self) {
+        if self.registered {
+            // SAFETY: device has been properly initialized as per the type invariant.
+            let video_device_parent = &mut self.device.raw_mut().dev;
+
+            // Obtain a pointer to this before freeing, so it can be assembled
+            // back into ForeignOwnable and then dropped.
+            let data_pointer = video_device_parent.driver_data;
+
+            // SAFETY: pointer was properly allocated in VideoDevice::new()
+            unsafe { bindings::video_unregister_device(self.device.raw_mut()) }
+
+            // Free data as well.
+            // SAFETY: `data_pointer` was returned by `into_foreign` during registration.
+            unsafe { <T::DriverData as ForeignOwnable>::from_foreign(data_pointer) };
+        }
+    }
+}
+
+// SAFETY: `Registration` doesn't offer any methods or access to fields when
+// shared between threads or CPUs, so it is safe to share it.
+unsafe impl<T: Driver> Sync for VideoRegistration<T> {}
+
+// SAFETY: Registration and unregistration from the v4l2 subsystem can happen
+// from any thread.  Additionally, `T::Data` (which is dropped during
+// unregistration) is `Send`, so it is ok to move `Registration` to different
+// threads.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl<T: Driver> Send for VideoRegistration<T> {}
+
+/// Registers a video device with the rest of the kernel.
+///
+/// It automatically picks up THIS_MODULE.
+#[allow(clippy::crate_in_macro_def)]
+#[macro_export]
+macro_rules! video_device_register {
+    ($reg:expr, $data:expr, $vfl_devnode_type:expr, $nr:expr, $capabilities:expr $(,)?) => {{
+        $crate::media::v4l2::dev::VideoRegistration::register(
+            $reg,
+            $data,
+            $vfl_devnode_type,
+            $nr,
+            &crate::THIS_MODULE,
+            $capabilities,
+        )
+    }};
+}
diff --git a/rust/kernel/media/v4l2/device.rs b/rust/kernel/media/v4l2/device.rs
new file mode 100644
index 000000000000..d7fafab787a6
--- /dev/null
+++ b/rust/kernel/media/v4l2/device.rs
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+#![allow(missing_docs)]
+
+//! V4L2 Device support helper.
+//!
+//! C header: [`include/media/v4l2-device.h`](../../../../include/media/v4l2-device.h)
+
+use core::cell::UnsafeCell;
+use core::pin::Pin;
+
+use crate::device;
+use crate::error;
+use crate::prelude::*;
+use crate::sync::smutex::Mutex;
+use crate::sync::Arc;
+use crate::ThisModule;
+
+/// A V4L2 device.
+pub struct V4l2Device {
+    /// The underlying `struct v4l2_device` in C.
+    device: UnsafeCell<bindings::v4l2_device>,
+}
+
+impl V4l2Device {
+    fn new() -> Self {
+        Self {
+            device: Default::default(),
+        }
+    }
+
+    pub(crate) fn device_mut(&mut self) -> &mut bindings::v4l2_device {
+        self.device.get_mut()
+    }
+}
+
+pub struct V4l2Registration {
+    device: Arc<Mutex<V4l2Device>>,
+    registered: bool,
+}
+
+impl V4l2Registration {
+    pub fn new() -> Result<Self> {
+        let device = Arc::try_new(Mutex::new(V4l2Device::new()))?;
+        Ok(Self {
+            device,
+            registered: false,
+        })
+    }
+
+    /// Registers a video device with the rest of the kernel.
+    ///
+    /// Users are encouraged to use the [`v4l2_device_register`] macro because it automatically
+    /// picks up THIS_MODULE.
+    pub fn register(
+        self: Pin<&mut Self>,
+        _module: &'static ThisModule,
+        parent: &dyn device::RawDevice,
+    ) -> Result {
+        if self.registered {
+            // Already registered.
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We never move out of `this` in this method.
+        let this = unsafe { self.get_unchecked_mut() };
+
+        let device = UnsafeCell::new(bindings::v4l2_device::default());
+
+        // SAFETY: We know that `RawDevice` is valid due to its safety
+        // requirements. Furthermore, `device` has been stack-allocated above
+        // and thus it is valid.
+        let res = unsafe { bindings::v4l2_device_register(parent.raw_device(), device.get()) };
+        error::to_result(res)?;
+
+        this.device.as_ref().lock().device = device;
+        this.registered = true;
+        Ok(())
+    }
+
+    pub fn device(&self) -> Arc<Mutex<V4l2Device>> {
+        self.device.clone()
+    }
+}
+
+impl Drop for V4l2Registration {
+    fn drop(&mut self) {
+        if self.registered {
+            let mut device = self.device.as_ref().lock();
+            let v4l2_dev = &mut *device;
+
+            unsafe { bindings::v4l2_device_unregister(v4l2_dev.device.get()) }
+        }
+    }
+}
+
+// SAFETY: The only field made available by  `Registration` is Send + Sync.
+// Other than that, it doesn't offer any methods or access to fields when shared
+// between threads or CPUs, so it is safe to share it.
+unsafe impl Sync for V4l2Registration {}
+
+// SAFETY: Registration and unregistration from the v4l2 subsystem can happen
+// from any thread.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl Send for V4l2Registration {}
+
+/// Registers a V4L2 device with the rest of the kernel.
+///
+/// It automatically picks up THIS_MODULE.
+#[allow(clippy::crate_in_macro_def)]
+#[macro_export]
+macro_rules! v4l2_device_register {
+    ($reg:expr, $parent:expr $(,)?) => {{
+        $crate::media::v4l2::device::V4l2Registration::register($reg, &crate::THIS_MODULE, $parent)
+    }};
+}
diff --git a/rust/kernel/media/v4l2/ioctls.rs b/rust/kernel/media/v4l2/ioctls.rs
new file mode 100644
index 000000000000..7c2b45c45ad6
--- /dev/null
+++ b/rust/kernel/media/v4l2/ioctls.rs
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0
+#![allow(missing_docs)]
+
+//! V4L2 Ioctls
+//!
+//! C header: [`include/media/v4l2-ioctls.h`](../../../../include/media/v4l2-ioctls.h)
+
+use bindings::*;
+use core::marker::PhantomData;
+
+use crate::error::from_kernel_result;
+use crate::media::v4l2;
+use crate::prelude::*;
+use crate::ForeignOwnable;
+
+#[vtable]
+pub trait Operations {
+    type PrivateData: ForeignOwnable;
+
+    fn vidioc_querycap(
+        _private_data: &mut Self::PrivateData,
+        _cap: v4l2::capabilities::CapabilitiesRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_enum_fmt_vid_cap(
+        _private_data: &mut Self::PrivateData,
+        _f: v4l2::format::FormatDescRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_enum_framesizes(
+        _private_data: &mut Self::PrivateData,
+        _fsize: v4l2::framesize::FrameSizeRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_g_fmt_vid_cap(
+        _private_data: &mut Self::PrivateData,
+        _f: v4l2::format::FormatRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_s_fmt_vid_cap(
+        _private_data: &mut Self::PrivateData,
+        _f: v4l2::format::FormatRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_try_fmt_vid_cap(
+        _private_data: &mut Self::PrivateData,
+        _f: v4l2::format::FormatRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_reqbufs(
+        _private_data: &mut Self::PrivateData,
+        _b: v4l2::mmap::RequestBuffersRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_querybuf(_private_data: &mut Self::PrivateData, _b: v4l2::mmap::BufferRef) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_qbuf(_private_data: &mut Self::PrivateData, _b: v4l2::mmap::BufferRef) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_expbuf(
+        _private_data: &mut Self::PrivateData,
+        _e: v4l2::mmap::ExportBufferRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_dqbuf(_private_data: &mut Self::PrivateData, _b: v4l2::mmap::BufferRef) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_create_bufs(
+        _private_data: &mut Self::PrivateData,
+        _b: v4l2::mmap::CreateBuffersRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_prepare_buf(
+        _private_data: &mut Self::PrivateData,
+        _b: v4l2::mmap::BufferRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_streamon(_private_data: &mut Self::PrivateData, _i: v4l2::enums::BufType) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_streamoff(_private_data: &mut Self::PrivateData, _i: v4l2::enums::BufType) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_enum_input(
+        _private_data: &mut Self::PrivateData,
+        _inp: v4l2::inputs::InputRef,
+    ) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_g_input(_private_data: &mut Self::PrivateData, _i: &mut u32) -> Result {
+        Ok(())
+    }
+
+    fn vidioc_s_input(_private_data: &mut Self::PrivateData, _i: u32) -> Result {
+        Ok(())
+    }
+}
+
+pub(crate) struct OperationsVtable<T: Operations>(PhantomData<T>);
+
+impl<T: Operations> OperationsVtable<T> {
+    fn private_data(file: *mut file) -> crate::ScopeGuard<T::PrivateData, fn(T::PrivateData)> {
+        // SAFETY: This was set during the video device registration process.
+        let video_device = unsafe { bindings::video_devdata(file) };
+        let data_ptr = unsafe { (*video_device).dev.driver_data };
+
+        // SAFETY: This was set during the video device registration process and
+        // now is being passed in by the kernel. We ensure exclusive access
+        // while the guard is alive.
+        unsafe { T::PrivateData::borrow_mut(data_ptr) }
+    }
+
+    unsafe extern "C" fn vidioc_querycap_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        cap: *mut v4l2_capability,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let cap = unsafe { v4l2::capabilities::CapabilitiesRef::from_ptr(cap) } ;
+            T::vidioc_querycap(&mut private_data, cap)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_enum_fmt_vid_cap_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        f: *mut v4l2_fmtdesc,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let fmt_desc = unsafe { v4l2::format::FormatDescRef::from_ptr(f) } ;
+            T::vidioc_enum_fmt_vid_cap(&mut private_data, fmt_desc)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_enum_framesizes(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        fsize: *mut v4l2_frmsizeenum,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let framesizes = unsafe { v4l2::framesize::FrameSizeRef::from_ptr(fsize) } ;
+            T::vidioc_enum_framesizes(&mut private_data, framesizes)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_g_fmt_vid_cap_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        f: *mut v4l2_format,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let fmt = unsafe { v4l2::format::FormatRef::from_ptr(f) } ;
+            T::vidioc_g_fmt_vid_cap(&mut private_data, fmt)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_s_fmt_vid_cap_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        f: *mut v4l2_format,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let fmt = unsafe { v4l2::format::FormatRef::from_ptr(f) } ;
+            T::vidioc_s_fmt_vid_cap(&mut private_data, fmt)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_try_fmt_vid_cap_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        f: *mut v4l2_format,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let fmt = unsafe { v4l2::format::FormatRef::from_ptr(f) } ;
+            T::vidioc_try_fmt_vid_cap(&mut private_data, fmt)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_reqbufs_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        b: *mut v4l2_requestbuffers,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let rb = unsafe { v4l2::mmap::RequestBuffersRef::from_ptr(b) } ;
+            T::vidioc_reqbufs(&mut private_data, rb)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_querybuf_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        b: *mut v4l2_buffer,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let buf = unsafe { v4l2::mmap::BufferRef::from_ptr(b) } ;
+            T::vidioc_querybuf(&mut private_data, buf)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_qbuf_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        b: *mut v4l2_buffer,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let buf = unsafe { v4l2::mmap::BufferRef::from_ptr(b) } ;
+            T::vidioc_qbuf(&mut private_data, buf)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_expbuf_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        e: *mut v4l2_exportbuffer,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let expbuf = unsafe { v4l2::mmap::ExportBufferRef::from_ptr(e) } ;
+            T::vidioc_expbuf(&mut private_data, expbuf)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_dqbuf_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        b: *mut v4l2_buffer,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let buf = unsafe { v4l2::mmap::BufferRef::from_ptr(b) } ;
+            T::vidioc_dqbuf(&mut private_data, buf)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_create_bufs_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        b: *mut v4l2_create_buffers,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let createbuf = unsafe { v4l2::mmap::CreateBuffersRef::from_ptr(b) } ;
+            T::vidioc_create_bufs(&mut private_data, createbuf)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_prepare_buf_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        b: *mut v4l2_buffer,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let buf = unsafe { v4l2::mmap::BufferRef::from_ptr(b) } ;
+            T::vidioc_prepare_buf(&mut private_data, buf)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_streamon_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        i: v4l2_buf_type,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let buf_type = v4l2::enums::BufType::try_from(i)?;
+            T::vidioc_streamon(&mut private_data, buf_type)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_streamoff_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        i: v4l2_buf_type,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let buf_type = v4l2::enums::BufType::try_from(i)?;
+            T::vidioc_streamoff(&mut private_data, buf_type)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_enum_input_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        inp: *mut v4l2_input,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            let input = unsafe { v4l2::inputs::InputRef::from_ptr(inp) };
+            T::vidioc_enum_input(&mut private_data, input)?;
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_g_input_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        i: *mut core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+            let mut val = 0;
+
+            T::vidioc_g_input(&mut private_data, &mut val)?;
+
+            // SAFETY: This pointer is passed in and checked by the kernel.
+            unsafe {*i = val; }
+            Ok(0)
+        }
+    }
+
+    unsafe extern "C" fn vidioc_s_input_callback(
+        file: *mut file,
+        _fh: *mut core::ffi::c_void,
+        i: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_kernel_result! {
+            let mut private_data = Self::private_data(file);
+
+            T::vidioc_s_input(&mut private_data, i)?;
+
+            Ok(0)
+        }
+    }
+
+    const VTABLE: bindings::v4l2_ioctl_ops = bindings::v4l2_ioctl_ops {
+        vidioc_querycap: if T::HAS_VIDIOC_QUERYCAP {
+            Some(Self::vidioc_querycap_callback)
+        } else {
+            None
+        },
+        vidioc_enum_fmt_vid_cap: if T::HAS_VIDIOC_ENUM_FMT_VID_CAP {
+            Some(Self::vidioc_enum_fmt_vid_cap_callback)
+        } else {
+            None
+        },
+        vidioc_enum_fmt_vid_overlay: None,
+        vidioc_enum_fmt_vid_out: None,
+        vidioc_enum_fmt_sdr_cap: None,
+        vidioc_enum_fmt_sdr_out: None,
+        vidioc_enum_fmt_meta_cap: None,
+        vidioc_enum_fmt_meta_out: None,
+        vidioc_g_fmt_vid_cap: if T::HAS_VIDIOC_G_FMT_VID_CAP {
+            Some(Self::vidioc_g_fmt_vid_cap_callback)
+        } else {
+            None
+        },
+        vidioc_g_fmt_vid_overlay: None,
+        vidioc_g_fmt_vid_out: None,
+        vidioc_g_fmt_vid_out_overlay: None,
+        vidioc_g_fmt_vbi_cap: None,
+        vidioc_g_fmt_vbi_out: None,
+        vidioc_g_fmt_sliced_vbi_cap: None,
+        vidioc_g_fmt_sliced_vbi_out: None,
+        vidioc_g_fmt_vid_cap_mplane: None,
+        vidioc_g_fmt_vid_out_mplane: None,
+        vidioc_g_fmt_sdr_cap: None,
+        vidioc_g_fmt_sdr_out: None,
+        vidioc_g_fmt_meta_cap: None,
+        vidioc_g_fmt_meta_out: None,
+        vidioc_s_fmt_vid_cap: if T::HAS_VIDIOC_S_FMT_VID_CAP {
+            Some(Self::vidioc_s_fmt_vid_cap_callback)
+        } else {
+            None
+        },
+        vidioc_s_fmt_vid_overlay: None,
+        vidioc_s_fmt_vid_out: None,
+        vidioc_s_fmt_vid_out_overlay: None,
+        vidioc_s_fmt_vbi_cap: None,
+        vidioc_s_fmt_vbi_out: None,
+        vidioc_s_fmt_sliced_vbi_cap: None,
+        vidioc_s_fmt_sliced_vbi_out: None,
+        vidioc_s_fmt_vid_cap_mplane: None,
+        vidioc_s_fmt_vid_out_mplane: None,
+        vidioc_s_fmt_sdr_cap: None,
+        vidioc_s_fmt_sdr_out: None,
+        vidioc_s_fmt_meta_cap: None,
+        vidioc_s_fmt_meta_out: None,
+        vidioc_try_fmt_vid_cap: if T::HAS_VIDIOC_TRY_FMT_VID_CAP {
+            Some(Self::vidioc_try_fmt_vid_cap_callback)
+        } else {
+            None
+        },
+        vidioc_try_fmt_vid_overlay: None,
+        vidioc_try_fmt_vid_out: None,
+        vidioc_try_fmt_vid_out_overlay: None,
+        vidioc_try_fmt_vbi_cap: None,
+        vidioc_try_fmt_vbi_out: None,
+        vidioc_try_fmt_sliced_vbi_cap: None,
+        vidioc_try_fmt_sliced_vbi_out: None,
+        vidioc_try_fmt_vid_cap_mplane: None,
+        vidioc_try_fmt_vid_out_mplane: None,
+        vidioc_try_fmt_sdr_cap: None,
+        vidioc_try_fmt_sdr_out: None,
+        vidioc_try_fmt_meta_cap: None,
+        vidioc_try_fmt_meta_out: None,
+        vidioc_reqbufs: if T::HAS_VIDIOC_REQBUFS {
+            Some(Self::vidioc_reqbufs_callback)
+        } else {
+            None
+        },
+        vidioc_querybuf: if T::HAS_VIDIOC_QUERYBUF {
+            Some(Self::vidioc_querybuf_callback)
+        } else {
+            None
+        },
+        vidioc_qbuf: if T::HAS_VIDIOC_QBUF {
+            Some(Self::vidioc_qbuf_callback)
+        } else {
+            None
+        },
+        vidioc_expbuf: if T::HAS_VIDIOC_EXPBUF {
+            Some(Self::vidioc_expbuf_callback)
+        } else {
+            None
+        },
+        vidioc_dqbuf: if T::HAS_VIDIOC_DQBUF {
+            Some(Self::vidioc_dqbuf_callback)
+        } else {
+            None
+        },
+        vidioc_create_bufs: if T::HAS_VIDIOC_CREATE_BUFS {
+            Some(Self::vidioc_create_bufs_callback)
+        } else {
+            None
+        },
+        vidioc_prepare_buf: if T::HAS_VIDIOC_PREPARE_BUF {
+            Some(Self::vidioc_prepare_buf_callback)
+        } else {
+            None
+        },
+        vidioc_overlay: None,
+        vidioc_g_fbuf: None,
+        vidioc_s_fbuf: None,
+        vidioc_streamon: if T::HAS_VIDIOC_STREAMON {
+            Some(Self::vidioc_streamon_callback)
+        } else {
+            None
+        },
+        vidioc_streamoff: if T::HAS_VIDIOC_STREAMOFF {
+            Some(Self::vidioc_streamoff_callback)
+        } else {
+            None
+        },
+        vidioc_g_std: None,
+        vidioc_s_std: None,
+        vidioc_querystd: None,
+        vidioc_enum_input: if T::HAS_VIDIOC_ENUM_INPUT {
+            Some(Self::vidioc_enum_input_callback)
+        } else {
+            None
+        },
+        vidioc_g_input: if T::HAS_VIDIOC_G_INPUT {
+            Some(Self::vidioc_g_input_callback)
+        } else {
+            None
+        },
+        vidioc_s_input: if T::HAS_VIDIOC_S_INPUT {
+            Some(Self::vidioc_s_input_callback)
+        } else {
+            None
+        },
+        vidioc_enum_output: None,
+        vidioc_g_output: None,
+        vidioc_s_output: None,
+        vidioc_queryctrl: None,
+        vidioc_query_ext_ctrl: None,
+        vidioc_g_ctrl: None,
+        vidioc_s_ctrl: None,
+        vidioc_g_ext_ctrls: None,
+        vidioc_s_ext_ctrls: None,
+        vidioc_try_ext_ctrls: None,
+        vidioc_querymenu: None,
+        vidioc_enumaudio: None,
+        vidioc_g_audio: None,
+        vidioc_s_audio: None,
+        vidioc_enumaudout: None,
+        vidioc_g_audout: None,
+        vidioc_s_audout: None,
+        vidioc_g_modulator: None,
+        vidioc_s_modulator: None,
+        vidioc_g_pixelaspect: None,
+        vidioc_g_selection: None,
+        vidioc_s_selection: None,
+        vidioc_g_jpegcomp: None,
+        vidioc_s_jpegcomp: None,
+        vidioc_g_enc_index: None,
+        vidioc_encoder_cmd: None,
+        vidioc_try_encoder_cmd: None,
+        vidioc_decoder_cmd: None,
+        vidioc_try_decoder_cmd: None,
+        vidioc_g_parm: None,
+        vidioc_s_parm: None,
+        vidioc_g_tuner: None,
+        vidioc_s_tuner: None,
+        vidioc_g_frequency: None,
+        vidioc_s_frequency: None,
+        vidioc_enum_freq_bands: None,
+        vidioc_g_sliced_vbi_cap: None,
+        vidioc_log_status: None,
+        vidioc_s_hw_freq_seek: None,
+        vidioc_enum_framesizes: if T::HAS_VIDIOC_ENUM_FRAMESIZES {
+            Some(Self::vidioc_enum_framesizes)
+        } else {
+            None
+        },
+        vidioc_enum_frameintervals: None,
+        vidioc_s_dv_timings: None,
+        vidioc_g_dv_timings: None,
+        vidioc_query_dv_timings: None,
+        vidioc_enum_dv_timings: None,
+        vidioc_dv_timings_cap: None,
+        vidioc_g_edid: None,
+        vidioc_s_edid: None,
+        vidioc_subscribe_event: None,
+        vidioc_unsubscribe_event: None,
+        vidioc_default: None,
+    };
+
+    pub(crate) fn build() -> &'static bindings::v4l2_ioctl_ops {
+        &Self::VTABLE
+    }
+}
diff --git a/rust/kernel/media/v4l2/mod.rs b/rust/kernel/media/v4l2/mod.rs
index 77864640f19e..c60083266202 100644
--- a/rust/kernel/media/v4l2/mod.rs
+++ b/rust/kernel/media/v4l2/mod.rs
@@ -3,8 +3,11 @@
 //! Abstractions for include/media/v4l2-*.h
 
 pub mod capabilities;
+pub mod dev;
+pub mod device;
 pub mod enums;
 pub mod format;
 pub mod framesize;
 pub mod inputs;
+pub mod ioctls;
 pub mod mmap;
-- 
2.40.0

