Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF86A1AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjBXKyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBXKyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:54:10 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0449B60D5E;
        Fri, 24 Feb 2023 02:53:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6C3BA424B9;
        Fri, 24 Feb 2023 10:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677236035;
        bh=NrVqIiH3X9XgjWiOPXyb08yMiHXA6hAq3CWoGWegOsU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=z4ncFNu82ujl536rci+ZwNDWUFh+JpOeYiio+n69Y/NI3cGdn8gq9c4GuZ7EP8q1I
         fCBLp8gKeCGt/Ct4n1TYKG3e6vlFlVOg1uDBXKV0GdEkW66azHhCxeYqsK8Y6+bCdl
         DhxNz2rI1SMRMUju5sZ3mDOr/I7w8HeEDd5O74wraZZjc901j++oKL0iZdGG2QFo66
         Bx2ZTiqEOE8oJaPUC6z6ESMDqG5EoE4OyLG6lxdjJFjaJPg8xfpreQq95VSjWD1usy
         LaIasHjZ9vUE1y6eX5ptPIozRvnzOZTCdY1AOXbAc8yLCLBYKbFXScR0wDMhp2wUpR
         Yq+vIzcKu/9SQ==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 19:53:15 +0900
Subject: [PATCH 3/5] rust: io_pgtable: Add io_pgtable abstraction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-iopt-rtkit-v1-3-49ced3391295@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677236013; l=13923;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=NrVqIiH3X9XgjWiOPXyb08yMiHXA6hAq3CWoGWegOsU=;
 b=P9OJjQ7AsUwVWHlKKVuH9K+Qw3x4Twvm2E2HX6B8xsfUWQmjTKpiewnwJRmHi+HwymNy1/Yy2
 tw0/4bjOLl6BFLJbQJeWSGJXE4wU2Dxn/nVewsuULTqRppTxiCZDFF7
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

The io_pgtable subsystem implements page table management for various
IOMMU page table formats. This abstraction allows Rust drivers for
devices with an embedded MMU to use this shared code directly.

Gather structures are not implemented yet, since we don't have a
consumer for that functionality. That can be added and refactored when
someone needs it.

It's worth noting that although this abstraction is nominally used to
manage page tables and mapping physical memory addresses, the
abstraction API itself is not unsafe. This is because, by itself, it can
only be used to manage page tables in isolation, which have no effect on
the system. In Rust, we typically use `unsafe` to mark operations that
actually introduce the safety requirements (that is, where the
responsibilities are created). Here, that would be actually installing
the page table root pointer into a device register (the downstream iomem
abstractions are unsafe for this reason, because devices can do DMA).

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/io_pgtable.rs       | 351 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 3 files changed, 354 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3632a39a28a6..88c65431d3ad 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/io-pgtable.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 
diff --git a/rust/kernel/io_pgtable.rs b/rust/kernel/io_pgtable.rs
new file mode 100644
index 000000000000..19029b1fdfd8
--- /dev/null
+++ b/rust/kernel/io_pgtable.rs
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IOMMU page table management
+//!
+//! C header: [`include/io-pgtable.h`](../../../../include/io-pgtable.h)
+
+use crate::{
+    bindings, device,
+    error::{code::*, to_result, Result},
+    types::{ForeignOwnable, ScopeGuard},
+};
+
+use core::marker::PhantomData;
+use core::mem;
+use core::num::NonZeroU64;
+
+/// Protection flags used with IOMMU mappings.
+pub mod prot {
+    /// Read access.
+    pub const READ: u32 = bindings::IOMMU_READ;
+    /// Write access.
+    pub const WRITE: u32 = bindings::IOMMU_WRITE;
+    /// Request cache coherency.
+    pub const CACHE: u32 = bindings::IOMMU_CACHE;
+    /// Request no-execute permission.
+    pub const NOEXEC: u32 = bindings::IOMMU_NOEXEC;
+    /// MMIO peripheral mapping.
+    pub const MMIO: u32 = bindings::IOMMU_MMIO;
+    /// Privileged mapping.
+    pub const PRIV: u32 = bindings::IOMMU_PRIV;
+}
+
+/// Represents a requested io_pgtable configuration.
+pub struct Config {
+    /// Quirk bitmask (type-specific).
+    pub quirks: usize,
+    /// Valid page sizes, as a bitmask of powers of two.
+    pub pgsize_bitmap: usize,
+    /// Input address space size in bits.
+    pub ias: usize,
+    /// Output address space size in bits.
+    pub oas: usize,
+    /// IOMMU uses coherent accesses for page table walks.
+    pub coherent_walk: bool,
+}
+
+/// IOMMU callbacks for TLB and page table management.
+///
+/// Users must implement this trait to perform the TLB flush actions for this IOMMU, if
+/// required.
+pub trait FlushOps {
+    /// User-specified type owned by the IOPagetable that will be passed to TLB operations.
+    type Data: ForeignOwnable + Send + Sync;
+
+    /// Synchronously invalidate the entire TLB context.
+    fn tlb_flush_all(data: <Self::Data as ForeignOwnable>::Borrowed<'_>);
+
+    /// Synchronously invalidate all intermediate TLB state (sometimes referred to as the "walk
+    /// cache") for a virtual address range.
+    fn tlb_flush_walk(
+        data: <Self::Data as ForeignOwnable>::Borrowed<'_>,
+        iova: usize,
+        size: usize,
+        granule: usize,
+    );
+
+    /// Optional callback to queue up leaf TLB invalidation for a single page.
+    ///
+    /// IOMMUs that cannot batch TLB invalidation operations efficiently will typically issue
+    /// them here, but others may decide to update the iommu_iotlb_gather structure and defer
+    /// the invalidation until iommu_iotlb_sync() instead.
+    ///
+    /// TODO: Implement the gather argument for batching.
+    fn tlb_add_page(
+        data: <Self::Data as ForeignOwnable>::Borrowed<'_>,
+        iova: usize,
+        granule: usize,
+    );
+}
+
+/// Inner page table info shared across all table types.
+/// # Invariants
+///
+///   - [`self.ops`] is valid and non-null.
+///   - [`self.cfg`] is valid and non-null.
+#[doc(hidden)]
+pub struct IoPageTableInner {
+    ops: *mut bindings::io_pgtable_ops,
+    cfg: bindings::io_pgtable_cfg,
+    data: *mut core::ffi::c_void,
+}
+
+/// Helper trait to get the config type for a single page table type from the union.
+pub trait GetConfig {
+    /// Returns the specific output configuration for this page table type.
+    fn cfg(iopt: &impl IoPageTable) -> &Self
+    where
+        Self: Sized;
+}
+
+/// A generic IOMMU page table
+pub trait IoPageTable: crate::private::Sealed {
+    #[doc(hidden)]
+    const FLUSH_OPS: bindings::iommu_flush_ops;
+
+    #[doc(hidden)]
+    fn new_fmt<T: FlushOps>(
+        dev: &dyn device::RawDevice,
+        format: u32,
+        config: Config,
+        data: T::Data,
+    ) -> Result<IoPageTableInner> {
+        let ptr = data.into_foreign() as *mut _;
+        let guard = ScopeGuard::new(|| {
+            // SAFETY: `ptr` came from a previous call to `into_foreign`.
+            unsafe { T::Data::from_foreign(ptr) };
+        });
+
+        let mut raw_cfg = bindings::io_pgtable_cfg {
+            quirks: config.quirks.try_into()?,
+            pgsize_bitmap: config.pgsize_bitmap.try_into()?,
+            ias: config.ias.try_into()?,
+            oas: config.oas.try_into()?,
+            coherent_walk: config.coherent_walk,
+            tlb: &Self::FLUSH_OPS,
+            iommu_dev: dev.raw_device(),
+            // SAFETY: This is an output field which is fine to zero-init.
+            __bindgen_anon_1: unsafe { mem::zeroed() },
+        };
+
+        // SAFETY: FFI call, all input pointers are valid.
+        let ops = unsafe {
+            bindings::alloc_io_pgtable_ops(format as bindings::io_pgtable_fmt, &mut raw_cfg, ptr)
+        };
+
+        if ops.is_null() {
+            return Err(EINVAL);
+        }
+
+        guard.dismiss();
+        Ok(IoPageTableInner {
+            ops,
+            cfg: raw_cfg,
+            data: ptr,
+        })
+    }
+
+    /// Map a range of pages.
+    fn map_pages(
+        &mut self,
+        iova: usize,
+        paddr: usize,
+        pgsize: usize,
+        pgcount: usize,
+        prot: u32,
+    ) -> Result<usize> {
+        let mut mapped: usize = 0;
+
+        // SAFETY: FFI call, ops is valid per the type invariant.
+        to_result(unsafe {
+            (*self.inner().ops).map_pages.unwrap()(
+                self.inner().ops,
+                iova as u64,
+                paddr as u64,
+                pgsize,
+                pgcount,
+                prot as i32,
+                bindings::GFP_KERNEL,
+                &mut mapped,
+            )
+        })?;
+
+        Ok(mapped)
+    }
+
+    /// Unmap a range of pages.
+    fn unmap_pages(
+        &mut self,
+        iova: usize,
+        pgsize: usize,
+        pgcount: usize,
+        // TODO: gather: *mut iommu_iotlb_gather,
+    ) -> usize {
+        // SAFETY: FFI call, ops is valid per the type invariant.
+        unsafe {
+            (*self.inner().ops).unmap_pages.unwrap()(
+                self.inner().ops,
+                iova as u64,
+                pgsize,
+                pgcount,
+                core::ptr::null_mut(),
+            )
+        }
+    }
+
+    /// Translate an IOVA to the corresponding physical address, if mapped.
+    fn iova_to_phys(&self, iova: usize) -> Option<NonZeroU64> {
+        // SAFETY: FFI call, ops is valid per the type invariant.
+        NonZeroU64::new(unsafe {
+            (*self.inner().ops).iova_to_phys.unwrap()(self.inner().ops, iova as u64)
+        })
+    }
+
+    #[doc(hidden)]
+    fn inner(&self) -> &IoPageTableInner;
+
+    #[doc(hidden)]
+    fn raw_cfg(&self) -> &bindings::io_pgtable_cfg {
+        &self.inner().cfg
+    }
+}
+
+// SAFETY: All abstraction operations either require mutable references or are thread-safe,
+// and io_pgtable_ops objects can be passed between threads without issue.
+unsafe impl Send for IoPageTableInner {}
+unsafe impl Sync for IoPageTableInner {}
+
+unsafe extern "C" fn tlb_flush_all_callback<T: FlushOps>(cookie: *mut core::ffi::c_void) {
+    // SAFETY: The cookie is always a ForeignOwnable of the right type, per new_fmt().
+    T::tlb_flush_all(unsafe { T::Data::borrow(cookie) });
+}
+
+unsafe extern "C" fn tlb_flush_walk_callback<T: FlushOps>(
+    iova: core::ffi::c_ulong,
+    size: usize,
+    granule: usize,
+    cookie: *mut core::ffi::c_void,
+) {
+    // SAFETY: The cookie is always a ForeignOwnable of the right type, per new_fmt().
+    T::tlb_flush_walk(
+        unsafe { T::Data::borrow(cookie) },
+        iova as usize,
+        size,
+        granule,
+    );
+}
+
+unsafe extern "C" fn tlb_add_page_callback<T: FlushOps>(
+    _gather: *mut bindings::iommu_iotlb_gather,
+    iova: core::ffi::c_ulong,
+    granule: usize,
+    cookie: *mut core::ffi::c_void,
+) {
+    // SAFETY: The cookie is always a ForeignOwnable of the right type, per new_fmt().
+    T::tlb_add_page(unsafe { T::Data::borrow(cookie) }, iova as usize, granule);
+}
+
+macro_rules! iopt_cfg {
+    ($name:ident, $field:ident, $type:ident) => {
+        /// An IOMMU page table configuration for a specific kind of pagetable.
+        pub type $name = bindings::$type;
+
+        impl GetConfig for $name {
+            fn cfg(iopt: &impl IoPageTable) -> &$name {
+                // SAFETY: The type system ensures we are accessing the right union field.
+                unsafe { &iopt.raw_cfg().__bindgen_anon_1.$field }
+            }
+        }
+    };
+}
+
+impl GetConfig for () {
+    fn cfg(_iopt: &impl IoPageTable) -> &() {
+        &()
+    }
+}
+
+macro_rules! iopt_type {
+    ($type:ident, $cfg:ty, $fmt:ident) => {
+        /// Represents an IOPagetable of this type.
+        pub struct $type<T: FlushOps>(IoPageTableInner, PhantomData<T>);
+
+        impl<T: FlushOps> $type<T> {
+            /// Creates a new IOPagetable implementation of this type.
+            pub fn new(dev: &dyn device::RawDevice, config: Config, data: T::Data) -> Result<Self> {
+                Ok(Self(
+                    <Self as IoPageTable>::new_fmt::<T>(dev, bindings::$fmt, config, data)?,
+                    PhantomData,
+                ))
+            }
+
+            /// Get the configuration for this IOPagetable.
+            pub fn cfg(&self) -> &$cfg {
+                <$cfg as GetConfig>::cfg(self)
+            }
+        }
+
+        impl<T: FlushOps> crate::private::Sealed for $type<T> {}
+
+        impl<T: FlushOps> IoPageTable for $type<T> {
+            const FLUSH_OPS: bindings::iommu_flush_ops = bindings::iommu_flush_ops {
+                tlb_flush_all: Some(tlb_flush_all_callback::<T>),
+                tlb_flush_walk: Some(tlb_flush_walk_callback::<T>),
+                tlb_add_page: Some(tlb_add_page_callback::<T>),
+            };
+
+            fn inner(&self) -> &IoPageTableInner {
+                &self.0
+            }
+        }
+
+        impl<T: FlushOps> Drop for $type<T> {
+            fn drop(&mut self) {
+                // SAFETY: The pointer is valid by the type invariant.
+                unsafe { bindings::free_io_pgtable_ops(self.0.ops) };
+
+                // Free context data.
+                //
+                // SAFETY: This matches the call to `into_foreign` from `new_fmt`.
+                unsafe { T::Data::from_foreign(self.0.data) };
+            }
+        }
+    };
+}
+
+// Ew, bindgen unions really are quite messy...
+iopt_cfg!(
+    ARMLPAES1Cfg,
+    arm_lpae_s1_cfg,
+    io_pgtable_cfg__bindgen_ty_1__bindgen_ty_1
+);
+iopt_cfg!(
+    ARMLPAES2Cfg,
+    arm_lpae_s2_cfg,
+    io_pgtable_cfg__bindgen_ty_1__bindgen_ty_2
+);
+iopt_cfg!(
+    ARMv7SCfg,
+    arm_v7s_cfg,
+    io_pgtable_cfg__bindgen_ty_1__bindgen_ty_3
+);
+iopt_cfg!(
+    ARMMaliLPAECfg,
+    arm_mali_lpae_cfg,
+    io_pgtable_cfg__bindgen_ty_1__bindgen_ty_4
+);
+iopt_cfg!(
+    AppleDARTCfg,
+    apple_dart_cfg,
+    io_pgtable_cfg__bindgen_ty_1__bindgen_ty_5
+);
+
+iopt_type!(ARM32LPAES1, ARMLPAES1Cfg, io_pgtable_fmt_ARM_32_LPAE_S1);
+iopt_type!(ARM32LPAES2, ARMLPAES2Cfg, io_pgtable_fmt_ARM_32_LPAE_S2);
+iopt_type!(ARM64LPAES1, ARMLPAES1Cfg, io_pgtable_fmt_ARM_64_LPAE_S1);
+iopt_type!(ARM64LPAES2, ARMLPAES2Cfg, io_pgtable_fmt_ARM_64_LPAE_S2);
+iopt_type!(ARMv7S, ARMv7SCfg, io_pgtable_fmt_ARM_V7S);
+iopt_type!(ARMMaliLPAE, ARMMaliLPAECfg, io_pgtable_fmt_ARM_MALI_LPAE);
+iopt_type!(AMDIOMMUV1, (), io_pgtable_fmt_AMD_IOMMU_V1);
+iopt_type!(AppleDART, AppleDARTCfg, io_pgtable_fmt_APPLE_DART);
+iopt_type!(AppleDART2, AppleDARTCfg, io_pgtable_fmt_APPLE_DART2);
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index de44092718f8..9944086d7e09 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -31,6 +31,8 @@ mod allocator;
 mod build_assert;
 pub mod device;
 pub mod error;
+#[cfg(CONFIG_IOMMU_IO_PGTABLE)]
+pub mod io_pgtable;
 pub mod prelude;
 pub mod print;
 mod static_assert;

-- 
2.35.1

