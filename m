Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E56AE02A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCGNRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCGNRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:17:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B417DAA;
        Tue,  7 Mar 2023 05:16:29 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 93F6E6602087;
        Tue,  7 Mar 2023 13:03:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678194232;
        bh=rmhvxOf7SbgXNNKNg6PoejG+FlzAfv0HupzI0+PLvdU=;
        h=From:To:Cc:Subject:Date:From;
        b=cEaSIFvgxC8xAywMv36z1r0JRqUA1gMuzOV/Req6Zbd7LLu8b5tcQdg3xJZtwKM1z
         vM6IrY0ZJeGW56Xq+A4F/Q0xoQ1XrYyEMFZ4qs2BZsNiEiJw+dDJJz81YrvBOjUDWM
         LfW6XB5URvJthJwbsRVrQyTlnOrWuhvRc8J3wYnzoYtGFGaswSRG+hWOslFtzUXS7w
         8uvAdo0OwFevWOr9K5v/n1y++bWUNk/+OyTslr+hdb7bY78mbeHf6Xvync44O2RBgq
         flOmk5wv7f7pahAq1NGwAZXxozOYDfeNOkWV3YIqahMFxaXABYS+7s+Hvl18Xi1yTP
         8mCLlnIRTTwOQ==
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     wedsonaf@gmail.com, ojeda@kernel.org
Cc:     Daniel Almeida <daniel.almeida@collabora.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Subject: [PATCH] rust: virtio: add virtio support
Date:   Tue,  7 Mar 2023 10:03:32 -0300
Message-Id: <20230307130332.53029-1-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds virtIO support to the rust crate. This includes the
capability to create a virtIO driver (through the module_virtio_driver
macro and the respective Driver trait) as well as initial virtqueue
support.

A sample virtIO module is included for conveninence.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---

Ok so this is my first Rust contribution here. It's part of a virtIO
driver I was originally writing. Both the probing and the virtqueue
support in here were confirmed as working in said prototype driver, and
the pieces were picked separately into this patch.

Feel free to point me to the best practices around Rust patch
submission, as the C stuff like checkpatch etc probably does not apply
yet. I did take care to run clippy though.

---
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |  18 +++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/virtio.rs           | 217 ++++++++++++++++++++++++++++++++
 rust/kernel/virtio/virtqueue.rs | 110 ++++++++++++++++
 samples/rust/Kconfig            |  10 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_virtio.rs     |  54 ++++++++
 8 files changed, 414 insertions(+)
 create mode 100644 rust/kernel/virtio.rs
 create mode 100644 rust/kernel/virtio/virtqueue.rs
 create mode 100644 samples/rust/rust_virtio.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 048bae2197ac..e5bf6f4c3188 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -34,6 +34,8 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/uaccess.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
 #include <linux/uio.h>
 
 /* `bindgen` gets confused at certain things. */
diff --git a/rust/helpers.c b/rust/helpers.c
index bf790f46c763..28cd97228c14 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -39,6 +39,8 @@
 #include <linux/skbuff.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -655,6 +657,22 @@ int rust_helper_fs_parse(struct fs_context *fc,
 }
 EXPORT_SYMBOL_GPL(rust_helper_fs_parse);
 
+struct virtqueue *rust_helper_virtio_find_single_vq(struct virtio_device *vdev,
+						    vq_callback_t *c,
+						    const char *n)
+{
+	return virtio_find_single_vq(vdev, c, n);
+}
+
+EXPORT_SYMBOL_GPL(rust_helper_virtio_find_single_vq);
+
+void rust_helper_virtio_del_vqs(struct virtio_device *vdev)
+{
+	vdev->config->del_vqs(vdev);
+}
+
+EXPORT_SYMBOL_GPL(rust_helper_virtio_del_vqs);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c20b37e88ab2..324ff45f825d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -73,6 +73,8 @@ pub mod power;
 pub mod revocable;
 pub mod security;
 pub mod task;
+#[cfg(CONFIG_VIRTIO)]
+pub mod virtio;
 pub mod workqueue;
 
 pub mod linked_list;
diff --git a/rust/kernel/virtio.rs b/rust/kernel/virtio.rs
new file mode 100644
index 000000000000..57894af4f5ba
--- /dev/null
+++ b/rust/kernel/virtio.rs
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+#![allow(missing_docs)]
+
+///! Virtio abstractions
+///!
+///! C header: [`include/linux/virtio.h`](../../../../include/media/virtio.h)
+use crate::{
+    device, driver,
+    error::{self, from_kernel_result},
+    prelude::*,
+    str::CStr,
+    to_result, ForeignOwnable, ThisModule,
+};
+
+pub mod virtqueue;
+
+#[derive(Copy, Clone, Debug, PartialEq, PartialOrd)]
+pub struct DeviceId {
+    pub device: u32,
+    pub vendor: u32,
+}
+
+unsafe impl const crate::driver::RawDeviceId for DeviceId {
+    type RawType = bindings::virtio_device_id;
+
+    const ZERO: Self::RawType = bindings::virtio_device_id {
+        device: 0,
+        vendor: 0,
+    };
+
+    // No `data` pointer.
+    fn to_rawid(&self, _offset: isize) -> Self::RawType {
+        bindings::virtio_device_id {
+            device: self.device,
+            vendor: self.vendor,
+        }
+    }
+}
+
+#[macro_export]
+macro_rules! define_virtio_id_table {
+    ($data_type:ty, $($t:tt)*) => {
+        $crate::define_id_table!(ID_TABLE, $crate::virtio::DeviceId, $data_type, $($t)*);
+    };
+}
+
+/// A registration of a virtio driver.
+pub type Registration<T> = driver::Registration<Adapter<T>>;
+
+/// An adapter for the registration of virtio drivers.
+pub struct Adapter<T: Driver>(T);
+
+impl<T: Driver> driver::DriverOps for Adapter<T> {
+    type RegType = bindings::virtio_driver;
+
+    unsafe fn register(
+        reg: *mut bindings::virtio_driver,
+        name: &'static CStr,
+        _module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: By the safety requirements of this function `reg` is non-null
+        // and valid.
+        let virtio_driver = unsafe { &mut *reg };
+
+        virtio_driver.driver.name = name.as_char_ptr();
+        virtio_driver.probe = Some(Self::probe_callback);
+        virtio_driver.remove = Some(Self::remove_callback);
+        if let Some(t) = T::ID_TABLE {
+            virtio_driver.id_table = t.as_ref();
+        }
+
+        to_result(unsafe { bindings::register_virtio_driver(reg) })
+    }
+
+    unsafe fn unregister(reg: *mut bindings::virtio_driver) {
+        // SAFETY: By the safety requirements of this function `reg` was passed
+        // (and updated) by a previous successful call to
+        // `register_virtio_driver`.
+        unsafe { bindings::unregister_virtio_driver(reg) };
+    }
+}
+
+impl<T: Driver> Adapter<T> {
+    extern "C" fn probe_callback(virtio_device: *mut bindings::virtio_device) -> core::ffi::c_int {
+        from_kernel_result! {
+            // SAFETY: `virtio_device` is valid by the contract with the C code.
+            // `dev` is alive only for the duration of this call, so it is
+            // guaranteed to remain alive for the lifetime of `virtio_device`.
+            let mut dev = unsafe { Device::from_ptr(virtio_device) };
+            let data = T::probe(&mut dev)?;
+
+            unsafe { (*virtio_device).priv_ = data.into_foreign() as _ }
+            Ok(0)
+        }
+    }
+
+    // Note, this type is a wrapper over a kernel pointer, meaning that we
+    // cannot be sure that the pointee is actually going away when the wrapper
+    // is dropped. Thus, release resources here instead, since the kernel will
+    // call this when the actual pointee is to be removed.
+    extern "C" fn remove_callback(virtio_device: *mut bindings::virtio_device) {
+        // SAFETY: `virtio_device` is guaranteed to be a valid, non-null
+        // pointer. `priv_` was set on probe().
+        let ptr = unsafe { (*virtio_device).priv_ };
+        // SAFETY:
+        //   - we allocated this pointer using `T::Data::into_foreign`,
+        //     so it is safe to turn back into a `T::Data`.
+        //   - the allocation happened in `probe`, no-one freed the memory,
+        //     `remove` is the canonical kernel location to free driver data. so OK
+        //     to convert the pointer back to a Rust structure here.
+        let data = unsafe { T::Data::from_foreign(ptr) };
+        T::remove(&data);
+
+        // SAFETY: just a couple of FFI call with a valid pointer.
+        unsafe {
+            bindings::virtio_del_vqs(virtio_device);
+            bindings::virtio_reset_device(virtio_device);
+        }
+        <T::Data as driver::DeviceRemoval>::device_remove(&data);
+    }
+}
+
+/// A virtio driver.
+pub trait Driver {
+    /// Data stored on device by driver in virtio_device.priv
+    type Data: ForeignOwnable + Send + Sync + driver::DeviceRemoval = ();
+
+    /// The table of device ids supported by the driver.
+    const ID_TABLE: Option<driver::IdTable<'static, DeviceId, ()>> = None;
+    /// The virtio features offered. This depends on the specifics of the given
+    /// virtio protocol for the device and can be empty.
+    const FEATURES: &'static [i32] = &[];
+
+    /// Virtio driver probe.
+    ///
+    /// Called when a new virtio device is added or discovered.
+    /// Implementers should attempt to initialize the device here.
+    fn probe(dev: &mut Device) -> Result<Self::Data>;
+
+    /// Virtio driver remove.
+    ///
+    /// Called when a virtio device is removed.
+    /// Implementers should prepare the device for complete removal here.
+    fn remove(_data: &Self::Data) {}
+}
+
+/// A virtio device.
+///
+/// # Invariants
+///
+/// The field `ptr` is non-null and valid for the lifetime of the object.
+pub struct Device {
+    ptr: *mut bindings::virtio_device,
+}
+
+impl Device {
+    /// Creates a new device from the given pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be non-null and valid. It must remain valid for the lifetime of the returned
+    /// instance.
+    pub unsafe fn from_ptr(ptr: *mut bindings::virtio_device) -> Self {
+        // INVARIANT: The safety requirements of the function ensure the lifetime invariant.
+        Self { ptr }
+    }
+
+    /// Returns id of the virtio device.
+    pub fn id(&self) -> i32 {
+        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
+        unsafe { (*self.ptr).id.device as _ }
+    }
+
+    pub fn find_virtqueue<T: virtqueue::Operations>(
+        &self,
+        name: &CStr,
+    ) -> Result<virtqueue::Virtqueue<T>> {
+        let callback = if T::HAS_CALLBACK {
+            Some(virtqueue::Virtqueue::<T>::vq_callback as _)
+        } else {
+            None
+        };
+
+        // SAFETY: ptr is valid due to the type invariant, callback points to a
+        // valid address and the pointer passed in is passed in by the kernel,
+        // so it is assumed to be valid.
+        let vq = unsafe { bindings::virtio_find_single_vq(self.ptr, callback, name.as_char_ptr()) };
+        let vq = error::from_kernel_err_ptr(vq)?;
+
+        // SAFETY: vq is checked with `from_kernel_err_ptr`
+        Ok(unsafe { virtqueue::Virtqueue::from_ptr(vq) })
+    }
+
+    pub fn data<T: Driver>(&self) -> <T::Data as ForeignOwnable>::Borrowed<'_> {
+        unsafe { <T::Data as ForeignOwnable>::borrow((*self.ptr).priv_) }
+    }
+
+    pub fn raw_device(&self) -> *mut bindings::virtio_device {
+        self.ptr
+    }
+}
+
+// SAFETY: The device returned by `raw_device` is the raw virtio device.
+unsafe impl device::RawDevice for Device {
+    fn raw_device(&self) -> *mut bindings::device {
+        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
+        unsafe { &mut (*self.ptr).dev }
+    }
+}
+
+/// Declares a kernel module that exposes a single virtio driver.
+#[macro_export]
+macro_rules! module_virtio_driver {
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::virtio::Adapter<T>, { $($f)* });
+    };
+}
diff --git a/rust/kernel/virtio/virtqueue.rs b/rust/kernel/virtio/virtqueue.rs
new file mode 100644
index 000000000000..b842e0f0da41
--- /dev/null
+++ b/rust/kernel/virtio/virtqueue.rs
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+// #![allow(missing_docs)]
+
+///! Virtqueue abstractions
+///!
+///! C header: [`include/linux/virtio.h`](../../../../include/linux/virtio.h)
+use core::marker::PhantomData;
+
+use crate::error;
+use crate::prelude::*;
+use crate::virtio;
+use crate::ForeignOwnable;
+
+#[vtable]
+pub trait Operations: Sized {
+    /// Data passed into the callback.
+    type PrivateData: ForeignOwnable;
+
+    /// The virtqueue callback.
+    fn callback(virtqueue: Virtqueue<Self>);
+}
+
+pub struct Virtqueue<T: Operations> {
+    ptr: *mut bindings::virtqueue,
+    phantom: PhantomData<T>,
+}
+
+impl<T: Operations> Virtqueue<T> {
+    /// # Safety
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`Virtqueue`] instance.
+    ///
+    /// Caller must ensure that get_buf() returns None before the Virtqueue is
+    /// dropped, so that ownership of the passed in T::PrivateData can be
+    /// retrieved.
+    pub unsafe fn from_ptr(ptr: *mut bindings::virtqueue) -> Self {
+        Self {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+
+    /// A wrapper over virtqueue_add_sgs()
+    pub fn add_sgs(
+        &mut self,
+        scatterlists: &mut [*mut bindings::scatterlist],
+        num_out: usize,
+        num_in: usize,
+        data: T::PrivateData,
+        gfp: u32,
+    ) -> Result {
+        if num_out + num_in > scatterlists.len() {
+            return Err(EINVAL);
+        }
+
+        let res = unsafe {
+            bindings::virtqueue_add_sgs(
+                self.ptr,
+                scatterlists.as_mut_ptr(),
+                num_out as u32,
+                num_in as u32,
+                data.into_foreign() as _,
+                gfp,
+            )
+        };
+
+        error::to_result(res)
+    }
+
+    /// A wrapper over virtqueue_kick()
+    pub fn kick(&mut self) -> Result {
+        let res = unsafe { bindings::virtqueue_kick(self.ptr) };
+        error::to_result(res as i32)
+    }
+
+    /// Returns the underlying virtio::Device.
+    pub fn virtio_device(&self) -> virtio::Device {
+        // SAFETY: The virtio framework places a pointer to the virtio device
+        // when creating the virtqueue
+        unsafe { virtio::Device::from_ptr((*self.ptr).vdev) }
+    }
+
+    /// A wrapper over virtqueue_get_buf().
+    pub fn get_buf(&mut self) -> Option<(T::PrivateData, u32)> {
+        let mut len = 0;
+
+        let data = unsafe {
+            let buf = bindings::virtqueue_get_buf(self.ptr, &mut len as _);
+
+            if buf.is_null() {
+                return None;
+            } else {
+                // SAFETY: if there is a buffer token, it came from
+                // into_foreign() as called in add_sgs.
+                <T::PrivateData as ForeignOwnable>::from_foreign(buf)
+            }
+        };
+
+        Some((data, len))
+    }
+
+    pub(crate) unsafe extern "C" fn vq_callback(vq: *mut bindings::virtqueue) {
+        // SAFETY: the caller should guarantee that vq is valid for the lifetime
+        // of Self.
+        let virtqueue = unsafe { Self::from_ptr(vq) };
+        T::callback(virtqueue);
+    }
+}
+
+unsafe impl<T: Operations> Send for Virtqueue<T> {}
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 189c10ced6d4..0507c57170ec 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -163,4 +163,14 @@ config SAMPLE_RUST_SELFTESTS
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_VIRTIO
+	tristate "Virtio"
+	help
+	  This option builds the Rust virtio module sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_minimal.
+
+	  If unsure, say N.
+
 endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 420bcefeb082..24059795480f 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -15,5 +15,6 @@ obj-$(CONFIG_SAMPLE_RUST_NETFILTER)		+= rust_netfilter.o
 obj-$(CONFIG_SAMPLE_RUST_ECHO_SERVER)		+= rust_echo_server.o
 obj-$(CONFIG_SAMPLE_RUST_FS)			+= rust_fs.o
 obj-$(CONFIG_SAMPLE_RUST_SELFTESTS)		+= rust_selftests.o
+obj-$(CONFIG_SAMPLE_RUST_VIRTIO)		+= rust_virtio.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_virtio.rs b/samples/rust/rust_virtio.rs
new file mode 100644
index 000000000000..8dbae35e99a8
--- /dev/null
+++ b/samples/rust/rust_virtio.rs
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust virtio device driver sample.
+
+use kernel::bindings;
+use kernel::module_virtio_driver;
+use kernel::prelude::*;
+use kernel::sync::Arc;
+use kernel::virtio::virtqueue;
+
+module_virtio_driver! {
+    type: Driver,
+    name: "rust_virtio",
+    license: "GPL",
+}
+
+struct Driver;
+
+impl kernel::driver::DeviceRemoval for Driver {
+    fn device_remove(&self) {}
+}
+
+impl kernel::virtio::Driver for Driver {
+    type Data = Arc<Self>;
+
+    kernel::define_virtio_id_table! {(), [
+         (kernel::virtio::DeviceId {
+            device: 0, // The protocol ID.
+            vendor: bindings::VIRTIO_DEV_ANY_ID,
+         }, None),
+    ]}
+
+    fn probe(_: &mut kernel::virtio::Device) -> Result<Self::Data> {
+        // To get an actual virtqueue you need VMM support, an example is left
+        // below.
+        //
+        // let virtqueue = virtio_dev.find_virtqueue::<VirtqueueCallback>(kernel::c_str!(""))?;
+        Arc::try_new(Self {})
+    }
+}
+
+pub(crate) struct VirtqueueCallback;
+
+#[vtable]
+impl virtqueue::Operations for VirtqueueCallback {
+    type PrivateData = Arc<Self>;
+
+    fn callback(vq: virtqueue::Virtqueue<Self>) {
+        let vdev = vq.virtio_device();
+        let data = vdev.data::<Driver>();
+        let _data = &*data;
+        // Usually some work is enqueued here to be processed later.
+    }
+}
-- 
2.39.2

