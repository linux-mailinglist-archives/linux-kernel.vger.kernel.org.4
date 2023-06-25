Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDCD73D0D4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjFYMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjFYMSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:18:00 -0400
Received: from out0-216.mail.aliyun.com (out0-216.mail.aliyun.com [140.205.0.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E82CE67;
        Sun, 25 Jun 2023 05:17:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.TdIoyYF_1687695455;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TdIoyYF_1687695455)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 20:17:35 +0800
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Qingsong Chen" <changxian.cqs@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        <rust-for-linux@vger.kernel.org>
Subject: [RFC PATCH 6/8] rust: kernel: add DAX related TargetOperations
Date:   Sun, 25 Jun 2023 20:16:55 +0800
Message-Id: <20230625121657.3631109-7-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
References: <20230625121657.3631109-1-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add `direct_access` to translate `pgoff` to `pfn`.
- Add `dax_zero_page_range` to zero page range.
- Add `dax_recovery_write` to recover a poisoned range.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/device_mapper.rs    | 139 +++++++++++++++++++++++++++++++-
 2 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 807fc9cf41b8..edda3a9173dd 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/device-mapper.h>
+#include <linux/dax.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/device_mapper.rs b/rust/kernel/device_mapper.rs
index ba13294f2d0b..d2c9d0a5bcd5 100644
--- a/rust/kernel/device_mapper.rs
+++ b/rust/kernel/device_mapper.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/linux/device-mapper.h`](../../../../include/linux/device-mapper.h)
 
 use core::marker::PhantomData;
-use core::ops::Index;
+use core::ops::{Index, Range};
 use core::ptr::{addr_of, NonNull};
 
 use crate::error::to_result;
@@ -136,6 +136,39 @@ fn iterate_devices(t: &mut Target<Self>) -> Result<Box<dyn Iterator<Item = IterD
     fn io_hints(t: &mut Target<Self>, limits: &mut QueueLimits) {
         unimplemented!()
     }
+
+    /// Translate a device-relative logical-page-offset into an
+    /// absolute physical pfn.
+    ///
+    /// Return the `addr` and the `pages` available for `DAX` at
+    /// that pfn, if success.
+    #[allow(unused)]
+    fn direct_access(
+        t: &mut Target<Self>,
+        pgoff: usize,
+        nr_pages: usize,
+        mode: DaxMode,
+    ) -> Result<(usize, Range<usize>)> {
+        unimplemented!()
+    }
+
+    /// Zero page range.
+    #[allow(unused)]
+    fn dax_zero_page_range(t: &mut Target<Self>, pgoff: usize, nr_pages: usize) -> Result {
+        unimplemented!()
+    }
+
+    /// Recover a poisoned range by DAX device driver capable of
+    /// clearing poison.
+    #[allow(unused)]
+    fn dax_recovery_write(
+        t: &mut Target<Self>,
+        iov_iter: Pin<&mut IovIter>,
+        pgoff: usize,
+        region: Range<usize>,
+    ) -> usize {
+        unimplemented!()
+    }
 }
 
 /// Wrap the kernel struct `target_type`.
@@ -214,6 +247,17 @@ pub fn register<T: TargetOperations>(
                     (HAS_PREPARE_IOCTL, prepare_ioctl, dm_prepare_ioctl_fn),
                     (HAS_ITERATE_DEVICES, iterate_devices, dm_iterate_devices_fn),
                     (HAS_IO_HINTS, io_hints, dm_io_hints_fn),
+                    (HAS_DIRECT_ACCESS, direct_access, dm_dax_direct_access_fn),
+                    (
+                        HAS_DAX_ZERO_PAGE_RANGE,
+                        dax_zero_page_range,
+                        dm_dax_zero_page_range_fn
+                    ),
+                    (
+                        HAS_DAX_RECOVERY_WRITE,
+                        dax_recovery_write,
+                        dm_dax_recovery_write_fn
+                    ),
                 );
 
                 to_result(bindings::dm_register_target(tt))
@@ -494,6 +538,60 @@ impl TargetType {
             T::io_hints(t, limits);
         }
     }
+    unsafe extern "C" fn dm_dax_direct_access_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        pgoff: core::ffi::c_ulong,
+        nr_pages: core::ffi::c_long,
+        mode: bindings::dax_access_mode,
+        kaddr: *mut *mut core::ffi::c_void,
+        pfn: *mut bindings::pfn_t,
+    ) -> core::ffi::c_long {
+        // SAFETY: the kernel should pass valid `dm_target`, `kaddr` and
+        // `pfn` pointers.
+        unsafe {
+            let t = Target::borrow_mut(ti);
+            match T::direct_access(t, pgoff as _, nr_pages as _, mode.into()) {
+                Ok((addr, pages)) => {
+                    *kaddr = addr as _;
+                    (*pfn).val = pages.start as _;
+                    pages.len() as _
+                }
+                Err(e) => e.to_errno() as _,
+            }
+        }
+    }
+    unsafe extern "C" fn dm_dax_zero_page_range_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        pgoff: core::ffi::c_ulong,
+        nr_pages: usize,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        unsafe {
+            let t = Target::borrow_mut(ti);
+            T::dax_zero_page_range(t, pgoff as _, nr_pages as _)
+                .map_or_else(|e| e.to_errno(), |_| 0)
+        }
+    }
+    unsafe extern "C" fn dm_dax_recovery_write_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        pgoff: core::ffi::c_ulong,
+        addr: *mut core::ffi::c_void,
+        bytes: usize,
+        i: *mut bindings::iov_iter,
+    ) -> usize {
+        let region = Range {
+            start: addr as usize,
+            end: (addr as usize) + bytes,
+        };
+
+        // SAFETY: the kernel should pass valid `dm_target` and `iov_iter`
+        // pointers.
+        unsafe {
+            let t = Target::borrow_mut(ti);
+            let iov_iter = IovIter::from_raw(i);
+            T::dax_recovery_write(t, iov_iter, pgoff as _, region)
+        }
+    }
 }
 
 /// Wrap the kernel struct `dm_target`.
@@ -903,3 +1001,42 @@ unsafe fn borrow_mut<'a>(ptr: *mut bindings::queue_limits) -> &'a mut Self {
         unsafe { &mut *(ptr as *mut Self) }
     }
 }
+
+/// Define dax direct_access mode.
+pub enum DaxMode {
+    /// Normal dax access.
+    Access,
+
+    /// Recovery write.
+    RecoveryWrite,
+
+    /// Undefined.
+    Undefined,
+}
+
+impl From<i32> for DaxMode {
+    fn from(value: i32) -> Self {
+        match value {
+            bindings::dax_access_mode_DAX_ACCESS => Self::Access,
+            bindings::dax_access_mode_DAX_RECOVERY_WRITE => Self::RecoveryWrite,
+            _ => Self::Undefined,
+        }
+    }
+}
+
+/// Wrap the kernel struct `iov_iter`.
+///
+/// Dummy.
+#[allow(dead_code)]
+#[pin_data]
+pub struct IovIter {
+    #[pin]
+    opaque: Opaque<bindings::iov_iter>,
+}
+
+impl IovIter {
+    unsafe fn from_raw<'a>(ptr: *mut bindings::iov_iter) -> Pin<&'a mut Self> {
+        // SAFETY: the caller should pass a valid `ptr`.
+        unsafe { Pin::new_unchecked(&mut *(ptr as *mut Self)) }
+    }
+}
-- 
2.40.1

