Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D156A1AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjBXKyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjBXKyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:54:21 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8418164E16;
        Fri, 24 Feb 2023 02:54:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E917342627;
        Fri, 24 Feb 2023 10:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677236040;
        bh=s8yg5Qe3Cf1DPHC1UIkVpTHEHGDsFbQ4/QodiHzArtM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=A6Ru0K8ekFVsvGDAELnpxa6tTrj8c587gyepAco4OyLOpVCnGZFAAC8pzTvEnr8BK
         ERgbLZBGIJZOiyYEOPzwWb7HiM6Gnb+/buqxYEmBZCTjAyUKHAL3jljF9FMyC1EvdD
         Q795JgevAi5UnOrlku3tg1TYdXWnX6kb5468++fDi4o0VbLkfBEN4nPCX34XnnvcO9
         QX7UOjo47PKDFa4+uFUN4bf4lwt7021J0XN8PI57gXxiUDMt2LhCypHcqSw9oUHMwK
         ZwIz4ZOANwzmOk3L6j4WCbNzqVfi1XeGxtWC2lLies3au6RfD7cxjEXS9kW/WMZbel
         Qz4VyAEbABKEw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 19:53:16 +0900
Subject: [PATCH 4/5] rust: soc: apple: rtkit: Add Apple RTKit abstraction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-iopt-rtkit-v1-4-49ced3391295@asahilina.net>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
In-Reply-To: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677236013; l=11585;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=s8yg5Qe3Cf1DPHC1UIkVpTHEHGDsFbQ4/QodiHzArtM=;
 b=czVp61paD5NoMTz4vwcTr9lDdsqWjE73xnF7YjvYkIghtw6eScQB6OZFQccW+TpLk15O7XiLU
 mYioNvRS1+RBDOqpGHh4UMxmwD3NLQvmeW/kCm575MbOzlXnNhTeCpU
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTKit is Apple's proprietary real-time operating system framework, used
across many subdevices on Apple Silicon platforms including NVMe, system
management, GPU, etc. Add Rust abstractions for this subsystem, so that
it can be used by upcoming Rust drivers.

This API is safe under the expectation that all RTKit coprocessors
either have no unfiltered access to system memory (SMC), are behind a
DART IOMMU (DCP, etc.), or require other unsafe operations to be granted
access to arbitrary system memory (GFX, where the coprocessor page
tables need to be mutated in bootloader-allocated memory blocks in order
to map additional memory, which is a requirement to get it to do
anything interesting beyond basic startup.)

Note: Although ARM64 support is not yet merged, this can be built on amd64
with CONFIG_COMPILE_TEST=y.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/soc/apple/mod.rs    |   6 +
 rust/kernel/soc/apple/rtkit.rs  | 259 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/soc/mod.rs          |   5 +
 5 files changed, 272 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 88c65431d3ad..c920d6242e3a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/io-pgtable.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
+#include <linux/soc/apple/rtkit.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9944086d7e09..78108cbbf814 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -35,6 +35,7 @@ pub mod error;
 pub mod io_pgtable;
 pub mod prelude;
 pub mod print;
+pub mod soc;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/soc/apple/mod.rs b/rust/kernel/soc/apple/mod.rs
new file mode 100644
index 000000000000..dd69db63677d
--- /dev/null
+++ b/rust/kernel/soc/apple/mod.rs
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+//! Apple SoC drivers
+
+#[cfg(CONFIG_APPLE_RTKIT = "y")]
+pub mod rtkit;
diff --git a/rust/kernel/soc/apple/rtkit.rs b/rust/kernel/soc/apple/rtkit.rs
new file mode 100644
index 000000000000..595b9b3dda96
--- /dev/null
+++ b/rust/kernel/soc/apple/rtkit.rs
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+//! Support for Apple RTKit coprocessors.
+//!
+//! C header: [`include/linux/soc/apple/rtkit.h`](../../../../include/linux/gpio/driver.h)
+
+use crate::{
+    bindings, device,
+    error::{code::*, from_kernel_err_ptr, from_kernel_result, to_result, Result},
+    str::CStr,
+    types::{ForeignOwnable, ScopeGuard},
+};
+
+use alloc::boxed::Box;
+use core::marker::PhantomData;
+use core::ptr;
+use macros::vtable;
+
+/// Trait to represent allocatable buffers for the RTKit core.
+///
+/// Users must implement this trait for their own representation of those allocations.
+pub trait Buffer {
+    /// Returns the IOVA (virtual address) of the buffer from RTKit's point of view, or an error if
+    /// unavailable.
+    fn iova(&self) -> Result<usize>;
+
+    /// Returns a mutable byte slice of the buffer contents, or an
+    /// error if unavailable.
+    fn buf(&mut self) -> Result<&mut [u8]>;
+}
+
+/// Callback operations for an RTKit client.
+#[vtable]
+pub trait Operations {
+    /// Arbitrary user context type.
+    type Data: ForeignOwnable + Send + Sync;
+
+    /// Type representing an allocated buffer for RTKit.
+    type Buffer: Buffer;
+
+    /// Called when RTKit crashes.
+    fn crashed(_data: <Self::Data as ForeignOwnable>::Borrowed<'_>) {}
+
+    /// Called when a message was received on a non-system endpoint. Called in non-IRQ context.
+    fn recv_message(
+        _data: <Self::Data as ForeignOwnable>::Borrowed<'_>,
+        _endpoint: u8,
+        _message: u64,
+    ) {
+    }
+
+    /// Called in IRQ context when a message was received on a non-system endpoint.
+    ///
+    /// Must return `true` if the message is handled, or `false` to process it in
+    /// the handling thread.
+    fn recv_message_early(
+        _data: <Self::Data as ForeignOwnable>::Borrowed<'_>,
+        _endpoint: u8,
+        _message: u64,
+    ) -> bool {
+        false
+    }
+
+    /// Allocate a buffer for use by RTKit.
+    fn shmem_alloc(
+        _data: <Self::Data as ForeignOwnable>::Borrowed<'_>,
+        _size: usize,
+    ) -> Result<Self::Buffer> {
+        Err(EINVAL)
+    }
+
+    /// Map an existing buffer used by RTKit at a device-specified virtual address.
+    fn shmem_map(
+        _data: <Self::Data as ForeignOwnable>::Borrowed<'_>,
+        _iova: usize,
+        _size: usize,
+    ) -> Result<Self::Buffer> {
+        Err(EINVAL)
+    }
+}
+
+/// Represents `struct apple_rtkit *`.
+///
+/// # Invariants
+///
+/// The rtk pointer is valid.
+/// The data pointer is a valid pointer from T::Data::into_foreign().
+pub struct RtKit<T: Operations> {
+    rtk: *mut bindings::apple_rtkit,
+    data: *mut core::ffi::c_void,
+    _p: PhantomData<T>,
+}
+
+unsafe extern "C" fn crashed_callback<T: Operations>(cookie: *mut core::ffi::c_void) {
+    // SAFETY: cookie is always a PointerWrapper of the right type, passed in new().
+    T::crashed(unsafe { T::Data::borrow(cookie) });
+}
+
+unsafe extern "C" fn recv_message_callback<T: Operations>(
+    cookie: *mut core::ffi::c_void,
+    endpoint: u8,
+    message: u64,
+) {
+    // SAFETY: cookie is always a PointerWrapper of the right type, passed in new().
+    T::recv_message(unsafe { T::Data::borrow(cookie) }, endpoint, message);
+}
+
+unsafe extern "C" fn recv_message_early_callback<T: Operations>(
+    cookie: *mut core::ffi::c_void,
+    endpoint: u8,
+    message: u64,
+) -> bool {
+    // SAFETY: cookie is always a PointerWrapper of the right type, passed in new().
+    T::recv_message_early(unsafe { T::Data::borrow(cookie) }, endpoint, message)
+}
+
+unsafe extern "C" fn shmem_setup_callback<T: Operations>(
+    cookie: *mut core::ffi::c_void,
+    bfr: *mut bindings::apple_rtkit_shmem,
+) -> core::ffi::c_int {
+    // SAFETY: `bfr` is a valid buffer.
+    let bfr_mut = unsafe { &mut *bfr };
+
+    let buf = if bfr_mut.iova != 0 {
+        bfr_mut.is_mapped = true;
+        T::shmem_map(
+            // SAFETY: `cookie` came from a previous call to `into_foreign`.
+            unsafe { T::Data::borrow(cookie) },
+            bfr_mut.iova as usize,
+            bfr_mut.size,
+        )
+    } else {
+        bfr_mut.is_mapped = false;
+        // SAFETY: `cookie` came from a previous call to `into_foreign`.
+        T::shmem_alloc(unsafe { T::Data::borrow(cookie) }, bfr_mut.size)
+    };
+
+    from_kernel_result! {
+        let mut buf = buf?;
+        let iova = buf.iova()?;
+        let slice = buf.buf()?;
+
+        if slice.len() < bfr_mut.size {
+            return Err(ENOMEM);
+        }
+
+        bfr_mut.iova = iova as u64;
+        bfr_mut.buffer = slice.as_mut_ptr() as *mut _;
+
+        // Now box the returned buffer type and stash it in the private pointer of the
+        // `apple_rtkit_shmem` struct for safekeeping.
+        bfr_mut.private = Box::into_raw(Box::try_new(buf)?) as *mut _;
+        Ok(0)
+    }
+}
+
+unsafe extern "C" fn shmem_destroy_callback<T: Operations>(
+    _cookie: *mut core::ffi::c_void,
+    bfr: *mut bindings::apple_rtkit_shmem,
+) {
+    // SAFETY: `bfr` is a valid buffer.
+    let bfr_mut = unsafe { &mut *bfr };
+    if !bfr_mut.private.is_null() {
+        // SAFETY: Per shmem_setup_callback, this has to be a pointer to a Buffer if it is set.
+        unsafe {
+            core::mem::drop(Box::from_raw(bfr_mut.private as *mut T::Buffer));
+        }
+        bfr_mut.private = core::ptr::null_mut();
+    }
+}
+
+impl<T: Operations> RtKit<T> {
+    const VTABLE: bindings::apple_rtkit_ops = bindings::apple_rtkit_ops {
+        crashed: Some(crashed_callback::<T>),
+        recv_message: Some(recv_message_callback::<T>),
+        recv_message_early: Some(recv_message_early_callback::<T>),
+        shmem_setup: if T::HAS_SHMEM_ALLOC || T::HAS_SHMEM_MAP {
+            Some(shmem_setup_callback::<T>)
+        } else {
+            None
+        },
+        shmem_destroy: if T::HAS_SHMEM_ALLOC || T::HAS_SHMEM_MAP {
+            Some(shmem_destroy_callback::<T>)
+        } else {
+            None
+        },
+    };
+
+    /// Creates a new RTKit client for a given device and optional mailbox name or index.
+    pub fn new(
+        dev: &dyn device::RawDevice,
+        mbox_name: Option<&'static CStr>,
+        mbox_idx: usize,
+        data: T::Data,
+    ) -> Result<Self> {
+        let ptr = data.into_foreign() as *mut _;
+        let guard = ScopeGuard::new(|| {
+            // SAFETY: `ptr` came from a previous call to `into_foreign`.
+            unsafe { T::Data::from_foreign(ptr) };
+        });
+        // SAFETY: This just calls the C init function.
+        let rtk = unsafe {
+            from_kernel_err_ptr(bindings::apple_rtkit_init(
+                dev.raw_device(),
+                ptr,
+                match mbox_name {
+                    Some(s) => s.as_char_ptr(),
+                    None => ptr::null(),
+                },
+                mbox_idx.try_into()?,
+                &Self::VTABLE,
+            ))
+        }?;
+
+        guard.dismiss();
+        // INVARIANT: `rtk` and `data` are valid here.
+        Ok(Self {
+            rtk,
+            data: ptr,
+            _p: PhantomData,
+        })
+    }
+
+    /// Boots (wakes up) the RTKit coprocessor.
+    pub fn boot(&mut self) -> Result {
+        // SAFETY: `rtk` is valid per the type invariant.
+        to_result(unsafe { bindings::apple_rtkit_boot(self.rtk) })
+    }
+
+    /// Starts a non-system endpoint.
+    pub fn start_endpoint(&mut self, endpoint: u8) -> Result {
+        // SAFETY: `rtk` is valid per the type invariant.
+        to_result(unsafe { bindings::apple_rtkit_start_ep(self.rtk, endpoint) })
+    }
+
+    /// Sends a message to a given endpoint.
+    pub fn send_message(&mut self, endpoint: u8, message: u64) -> Result {
+        // SAFETY: `rtk` is valid per the type invariant.
+        to_result(unsafe {
+            bindings::apple_rtkit_send_message(self.rtk, endpoint, message, ptr::null_mut(), false)
+        })
+    }
+}
+
+// SAFETY: `RtKit` operations require a mutable reference.
+unsafe impl<T: Operations> Sync for RtKit<T> {}
+unsafe impl<T: Operations> Send for RtKit<T> {}
+
+impl<T: Operations> Drop for RtKit<T> {
+    fn drop(&mut self) {
+        // SAFETY: The pointer is valid by the type invariant.
+        unsafe { bindings::apple_rtkit_free(self.rtk) };
+
+        // Free context data.
+        //
+        // SAFETY: This matches the call to `into_foreign` from `new` in the success case.
+        unsafe { T::Data::from_foreign(self.data) };
+    }
+}
diff --git a/rust/kernel/soc/mod.rs b/rust/kernel/soc/mod.rs
new file mode 100644
index 000000000000..e3024042e74f
--- /dev/null
+++ b/rust/kernel/soc/mod.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! SoC drivers
+
+pub mod apple;

-- 
2.35.1

