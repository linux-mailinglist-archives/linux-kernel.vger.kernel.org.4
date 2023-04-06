Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784376DA518
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbjDFV6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbjDFV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:57:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1863AF3A;
        Thu,  6 Apr 2023 14:56:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EF76666031F2;
        Thu,  6 Apr 2023 22:56:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680818205;
        bh=GNp7AViZIGE3DK9wiwiWUEJC1nCGATb7ALyHIa7a9B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpIGYfCsaJRyOC8eRp5YeEPoPe/m0+JQp4xIuVbCmbz3cDkoATTSuzVyjASAmxw98
         NhD1w/cu5YVIII8bjiu3pmrDKGfe0pKgvNZ/Mo7/M7HspPpC8AIBkOlZNTM6tqcpUj
         b+rdSCZnQ7Lo/N8l/5u7ZxMWt8/qU6N6KyhuFvtBbpg3OUbeiMZxdVDLjuqDe0BYP5
         +Mx5LEzM2NfCuQ64U3S79QvlaJtifHrRunS6UyMoYftG6MqZsksV29HIKm2tAbbyx5
         kp0LOD3NNbtQ8vGmZAMQBXTKdvlWZogvvcUV9jlGMOoDjqpoabCbvYSWr9Imp05SOR
         /FZM5IbtatfvQ==
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl
Cc:     Daniel Almeida <daniel.almeida@collabora.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 6/6] rust: media: add v4l2 rust sample
Date:   Thu,  6 Apr 2023 18:56:15 -0300
Message-Id: <20230406215615.122099-7-daniel.almeida@collabora.com>
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

Add a v4l2 rust sample. The sample driver showcases the current support
available in the media module. It also proves that the device will
indeed probe by printing a message to the terminal indicating that
no error took place.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 samples/rust/Kconfig      |  11 ++
 samples/rust/Makefile     |   1 +
 samples/rust/rust_v4l2.rs | 403 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 415 insertions(+)
 create mode 100644 samples/rust/rust_v4l2.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 189c10ced6d4..4bdea8210ae0 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -163,4 +163,15 @@ config SAMPLE_RUST_SELFTESTS
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_V4L2
+	tristate "V4L2 driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV
+	select VIDEOBUF2_DMA_SG
+
+	help
+	  This option builds the V4L2 example.
+
+	  If unsure, say N.
+
 endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 420bcefeb082..5ffa621f3968 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -15,5 +15,6 @@ obj-$(CONFIG_SAMPLE_RUST_NETFILTER)		+= rust_netfilter.o
 obj-$(CONFIG_SAMPLE_RUST_ECHO_SERVER)		+= rust_echo_server.o
 obj-$(CONFIG_SAMPLE_RUST_FS)			+= rust_fs.o
 obj-$(CONFIG_SAMPLE_RUST_SELFTESTS)		+= rust_selftests.o
+obj-$(CONFIG_SAMPLE_RUST_V4L2)		+= rust_v4l2.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_v4l2.rs b/samples/rust/rust_v4l2.rs
new file mode 100644
index 000000000000..6742af36ac0a
--- /dev/null
+++ b/samples/rust/rust_v4l2.rs
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust V4L2 sample.
+
+use core::cell::UnsafeCell;
+use core::clone::Clone;
+
+use kernel::bindings;
+use kernel::error;
+use kernel::media::v4l2;
+use kernel::media::videobuf2;
+use kernel::platform;
+use kernel::prelude::*;
+use kernel::sync::smutex::Mutex;
+use kernel::sync::Arc;
+
+pub(crate) struct Driver {
+    _reg: Pin<Box<kernel::driver::Registration<kernel::platform::Adapter<Self>>>>,
+    _pdev: Pin<Box<PlatformDevice>>,
+}
+
+impl v4l2::dev::Driver for Driver {
+    type DriverData = Arc<DeviceData>;
+}
+
+pub(crate) struct Registrations {
+    video: Pin<Box<v4l2::dev::VideoRegistration<Driver>>>,
+    v4l2: Pin<Box<v4l2::device::V4l2Registration>>,
+}
+
+type DeviceData = kernel::device::Data<Registrations, (), V4l2Data>;
+
+pub(crate) struct V4l2Data {
+    pub(crate) _device: Arc<kernel::device::Device>,
+    _vb2_queue: Mutex<videobuf2::core::Queue<Driver>>,
+}
+
+#[vtable]
+impl videobuf2::core::QueueOperations for Driver {
+    type DriverSpecificData = Vb2QueueData;
+
+    type PrivateData = Box<videobuf2::core::PrivateData<bindings::vb2_v4l2_buffer, Vb2QueueData>>;
+
+    fn queue_setup(
+        _queue: &videobuf2::core::QueueRef,
+        _private_data: &mut Self::PrivateData,
+        _num_buffers: &mut u32,
+        _num_planes: &mut u32,
+        _sizes: &mut [u32],
+    ) -> Result {
+        let _vb2_queue_data = _private_data.driver_specific_mut();
+        pr_debug!("queue_setup called.\n");
+        Ok(())
+    }
+
+    fn start_streaming(
+        _queue: &videobuf2::core::QueueRef,
+        _private_data: &mut Self::PrivateData,
+        _count: u32,
+    ) -> Result {
+        pr_info!("start_streaming called.\n");
+        Ok(())
+    }
+
+    fn stop_streaming(_queue: &videobuf2::core::QueueRef, _private_data: &mut Self::PrivateData) {
+        pr_info!("stop_streaming called.\n");
+    }
+
+    fn buf_init(
+        _buffer: &videobuf2::core::Buffer,
+        _private_data: &mut Self::PrivateData,
+    ) -> Result {
+        pr_info!("buf_init called.\n");
+        Ok(())
+    }
+
+    fn buf_prepare(
+        _buffer: &videobuf2::core::Buffer,
+        _private_data: &mut Self::PrivateData,
+    ) -> Result {
+        pr_info!("buf_prepare called.\n");
+        Ok(())
+    }
+
+    fn buf_cleanup(_buffer: &videobuf2::core::Buffer, _private_data: &mut Self::PrivateData) {
+        pr_info!("buf_cleanup called.\n");
+    }
+
+    fn buf_queue(_buffer: &videobuf2::core::Buffer, _private_data: &mut Self::PrivateData) {
+        pr_info!("buf_queue called.\n");
+    }
+}
+
+pub(crate) struct Vb2QueueData {}
+
+impl platform::Driver for Driver {
+    type Data = Arc<DeviceData>;
+
+    kernel::define_of_id_table! {(), [
+         (kernel::of::DeviceId::Compatible(b"v4l2"), None),
+    ]}
+
+    fn probe(
+        pdev: &mut platform::Device,
+        _: core::option::Option<&Self::IdInfo>,
+    ) -> Result<Self::Data> {
+        let dev = kernel::device::Device::from_dev(pdev);
+
+        pr_debug!("V4L2 Rust Sample Probing!\n");
+
+        let v4l2_reg = v4l2::device::V4l2Registration::new()?;
+
+        let fops = v4l2::dev::V4l2FileOperations {
+            open: Some(bindings::v4l2_fh_open),
+            poll: Some(bindings::vb2_fop_poll),
+            mmap: Some(bindings::vb2_fop_mmap),
+            read: Some(bindings::vb2_fop_read),
+        };
+
+        let ioctls = v4l2::dev::V4l2IoctlOperations {
+            reqbufs: Some(bindings::vb2_ioctl_reqbufs),
+            querybuf: Some(bindings::vb2_ioctl_querybuf),
+            qbuf: Some(bindings::vb2_ioctl_qbuf),
+            expbuf: Some(bindings::vb2_ioctl_expbuf),
+            dqbuf: Some(bindings::vb2_ioctl_dqbuf),
+            create_bufs: Some(bindings::vb2_ioctl_create_bufs),
+            prepare_buf: Some(bindings::vb2_ioctl_prepare_buf),
+            streamon: Some(bindings::vb2_ioctl_streamon),
+            streamoff: Some(bindings::vb2_ioctl_streamoff),
+            // prepare_streaming: None,
+            // unprepare_streaming: None,
+        };
+
+        let video_reg =
+            v4l2::dev::VideoRegistration::<Driver>::new(&dev, v4l2_reg.device(), fops, ioctls)?;
+
+        let dev = Arc::try_new(dev)?;
+
+        let io_modes = [
+            videobuf2::core::IoModes::Mmap,
+            videobuf2::core::IoModes::DmaBuf,
+        ];
+
+        let timestamp_flags = [v4l2::mmap::BufferFlag::TimestampMonotonic];
+
+        let queue_data = Vb2QueueData {};
+
+        let queue_data = Box::try_new(videobuf2::core::PrivateData::new(queue_data))?;
+        let queue_data = Some(queue_data);
+
+        let vb2_mutex = unsafe { kernel::sync::ffi_mutex::FfiMutex::new() };
+        let mut vb2_mutex = Pin::from(Box::try_new(vb2_mutex)?);
+        kernel::ffi_mutex_init!(vb2_mutex.as_mut(), "Vb2Queue::lock");
+
+        let create_info = videobuf2::core::QueueCreateInfo {
+            buf_type: v4l2::enums::BufType::VideoCapture,
+            io_modes: &io_modes,
+            dev: dev.clone(),
+            timestamp_flags: &timestamp_flags,
+            lock: Some(vb2_mutex),
+            min_buffers_needed: 1,
+            gfp_flags: bindings::___GFP_DMA32,
+            mem_ops: videobuf2::core::MemOps::DmaSg,
+            requires_requests: false,
+            supports_requests: false,
+            private_data: queue_data,
+        };
+
+        let vb2_queue = videobuf2::core::Queue::<Self>::new(create_info)?;
+
+        let data = kernel::new_device_data!(
+            Registrations {
+                video: Pin::new(Box::try_new(video_reg).unwrap()),
+                v4l2: Pin::new(Box::try_new(v4l2_reg).unwrap()),
+            },
+            (),
+            V4l2Data {
+                _device: dev,
+                _vb2_queue: kernel::sync::smutex::Mutex::new(vb2_queue),
+            },
+            "V4l2::Registrations"
+        )?;
+
+        let data = Arc::<DeviceData>::from(data);
+        let capabilities = [
+            v4l2::capabilities::Capabilities::VideoCapture,
+            v4l2::capabilities::Capabilities::Streaming,
+        ];
+
+        let mut pinned_regs = data.registrations().ok_or(ENXIO)?;
+        let mut pinned_regs_mut = pinned_regs.as_pinned_mut();
+
+        let dev = kernel::device::Device::from_dev(pdev);
+        kernel::v4l2_device_register!(pinned_regs_mut.v4l2.as_mut(), &dev)?;
+        pr_debug!("Sucessfully registered v4l2 device");
+
+        kernel::video_device_register!(
+            pinned_regs_mut.video.as_mut(),
+            data.clone(),
+            v4l2::dev::VflDevNodeType::Video,
+            -1,
+            &capabilities,
+        )?;
+
+        pr_info!("V4L2 Rust Sample Probed!\n");
+        drop(pinned_regs);
+        Ok(data)
+    }
+}
+
+#[vtable]
+impl v4l2::ioctls::Operations for Driver {
+    type PrivateData = Arc<DeviceData>;
+
+    fn vidioc_querycap(
+        _private_data: &mut Self::PrivateData,
+        _cap: v4l2::capabilities::CapabilitiesRef,
+    ) -> Result {
+        pr_info!("vidioc_querycap called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_enum_fmt_vid_cap(
+        _private_data: &mut Self::PrivateData,
+        mut f: v4l2::format::FormatDescRef,
+    ) -> Result {
+        pr_info!("vidioc_enum_fmt_vid_cap called");
+        // Set NV12 to avoid spam by some apps when this module is loaded.
+        f.set_pixel_format(842094158);
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_enum_framesizes(
+        _private_data: &mut Self::PrivateData,
+        _fsize: v4l2::framesize::FrameSizeRef,
+    ) -> Result {
+        pr_info!("vidioc_enum_framesizes called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_g_fmt_vid_cap(
+        _private_data: &mut Self::PrivateData,
+        _f: v4l2::format::FormatRef,
+    ) -> Result {
+        pr_info!("vidioc_g_fmt_vid_cap called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_s_fmt_vid_cap(
+        _private_data: &mut Self::PrivateData,
+        _f: v4l2::format::FormatRef,
+    ) -> Result {
+        pr_info!("vidioc_s_fmt_vid_cap called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_try_fmt_vid_cap(
+        _private_data: &mut Self::PrivateData,
+        _f: v4l2::format::FormatRef,
+    ) -> Result {
+        pr_info!("vidioc_try_fmt_vid_cap called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_reqbufs(
+        _private_data: &mut Self::PrivateData,
+        _b: v4l2::mmap::RequestBuffersRef,
+    ) -> Result {
+        pr_info!("vidioc_reqbufs called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_querybuf(_private_data: &mut Self::PrivateData, _b: v4l2::mmap::BufferRef) -> Result {
+        pr_info!("vidioc_querybuf called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_qbuf(_private_data: &mut Self::PrivateData, _b: v4l2::mmap::BufferRef) -> Result {
+        pr_info!("vidioc_qbuf called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_expbuf(
+        _private_data: &mut Self::PrivateData,
+        _e: v4l2::mmap::ExportBufferRef,
+    ) -> Result {
+        pr_info!("vidioc_expbuf called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_dqbuf(_private_data: &mut Self::PrivateData, _b: v4l2::mmap::BufferRef) -> Result {
+        pr_info!("vidioc_dqbuf called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_create_bufs(
+        _private_data: &mut Self::PrivateData,
+        _b: v4l2::mmap::CreateBuffersRef,
+    ) -> Result {
+        pr_info!("vidioc_create_bufs called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_prepare_buf(
+        _private_data: &mut Self::PrivateData,
+        _b: v4l2::mmap::BufferRef,
+    ) -> Result {
+        pr_info!("vidioc_prepare_buf called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_streamon(_private_data: &mut Self::PrivateData, _i: v4l2::enums::BufType) -> Result {
+        pr_info!("vidioc_streamon called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_streamoff(_private_data: &mut Self::PrivateData, _i: v4l2::enums::BufType) -> Result {
+        pr_info!("vidioc_streamoff called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_enum_input(
+        _private_data: &mut Self::PrivateData,
+        _inp: v4l2::inputs::InputRef,
+    ) -> Result {
+        pr_info!("vidioc_enum_input called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_g_input(_private_data: &mut Self::PrivateData, _i: &mut u32) -> Result {
+        pr_info!("vidioc_g_input called");
+        core::result::Result::Ok(())
+    }
+
+    fn vidioc_s_input(_private_data: &mut Self::PrivateData, _i: u32) -> Result {
+        pr_info!("vidioc_s_input called");
+        core::result::Result::Ok(())
+    }
+}
+
+/// An owned platform device registered by a driver. This is useful for virtual
+/// drivers, such as this one, since they will not be probed by matching against
+/// the device tree.
+struct PlatformDevice(core::cell::UnsafeCell<bindings::platform_device>);
+
+// SAFETY: I assume _all_ devices should be OK to be moved to any thread.
+unsafe impl Send for PlatformDevice {}
+// SAFETY: Platform device does not expose its inner FFI type.
+unsafe impl Sync for PlatformDevice {}
+
+impl Drop for PlatformDevice {
+    fn drop(&mut self) {
+        // SAFETY: no references to this type are alive here.
+        let platform_device = self.0.get();
+        // SAFETY: an FFI call to a previously registered device.
+        unsafe { bindings::platform_device_unregister(platform_device) }
+    }
+}
+
+unsafe impl kernel::device::RawDevice for PlatformDevice {
+    fn raw_device(&self) -> *mut bindings::device {
+        // SAFETY: no references to this type are alive here.
+        let platform_device = self.0.get();
+        // SAFETY: pointer is valid since it was previously registered when the
+        // module was registered.
+        unsafe { &mut (*platform_device).dev as _ }
+    }
+}
+
+impl kernel::Module for Driver {
+    fn init(name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
+        // Register as platform driver
+        let reg: Pin<Box<kernel::driver::Registration<kernel::platform::Adapter<Self>>>> =
+            kernel::platform::Registration::new_pinned(name, module)?;
+
+        let mut platform_device = kernel::bindings::platform_device::default();
+        let name = kernel::c_str!("rust_v4l2");
+        platform_device.name = name.as_char_ptr();
+
+        let platform_device = Box::try_new(PlatformDevice(UnsafeCell::new(platform_device)))?;
+        let mut platform_device = Pin::from(platform_device);
+
+        let platform_device = unsafe {
+            let res = bindings::platform_device_register(platform_device.as_mut().0.get());
+
+            error::to_result(res)?;
+            platform_device
+        };
+
+        Ok(Self {
+            _reg: reg,
+            _pdev: platform_device, /* This obviously must be kept alive as well, otherwise massive faults will ensure */
+        })
+    }
+}
+
+module! {
+    type: Driver,
+    name: "rust_v4l2",
+    author: "Daniel Almeida",
+    description: "Minimal Rust V4L2 example driver",
+    license: "GPL",
+}
-- 
2.40.0

