Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759DB73D0D3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjFYMR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjFYMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:17:47 -0400
Received: from out0-219.mail.aliyun.com (out0-219.mail.aliyun.com [140.205.0.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E3210F6;
        Sun, 25 Jun 2023 05:17:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TdJuHaw_1687695449;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TdJuHaw_1687695449)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 20:17:29 +0800
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
        <rust-for-linux@vger.kernel.org>
Subject: [RFC PATCH 5/8] rust: kernel: add underlying device related TargetOperations
Date:   Sun, 25 Jun 2023 20:16:54 +0800
Message-Id: <20230625121657.3631109-6-changxian.cqs@antgroup.com>
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

- Add `prepare_ioctl` to pass ioctls to underlying device.
- Add `iterate_devices` to iterate underlying devices.
- Add `io_hints` to setup target request queue limits.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/kernel/device_mapper.rs | 101 +++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/rust/kernel/device_mapper.rs b/rust/kernel/device_mapper.rs
index 9a62208fda56..ba13294f2d0b 100644
--- a/rust/kernel/device_mapper.rs
+++ b/rust/kernel/device_mapper.rs
@@ -118,6 +118,24 @@ fn message(t: &mut Target<Self>, args: Args) -> Result<CString> {
     fn report_zones(t: &mut Target<Self>, args: &mut [ReportZonesArgs]) -> Result {
         unimplemented!()
     }
+
+    /// Pass on ioctl to the underlying device.
+    #[allow(unused)]
+    fn prepare_ioctl(t: &mut Target<Self>) -> (i32, Option<NonNull<TargetDevice<Self>>>) {
+        unimplemented!()
+    }
+
+    /// Iterate the underlying devices.
+    #[allow(unused)]
+    fn iterate_devices(t: &mut Target<Self>) -> Result<Box<dyn Iterator<Item = IterDevice<Self>>>> {
+        unimplemented!()
+    }
+
+    /// Setup target request queue limits.
+    #[allow(unused)]
+    fn io_hints(t: &mut Target<Self>, limits: &mut QueueLimits) {
+        unimplemented!()
+    }
 }
 
 /// Wrap the kernel struct `target_type`.
@@ -193,6 +211,9 @@ pub fn register<T: TargetOperations>(
                     (HAS_STATUS, status, dm_status_fn),
                     (HAS_MESSAGE, message, dm_message_fn),
                     (HAS_REPORT_ZONES, report_zones, dm_report_zones_fn),
+                    (HAS_PREPARE_IOCTL, prepare_ioctl, dm_prepare_ioctl_fn),
+                    (HAS_ITERATE_DEVICES, iterate_devices, dm_iterate_devices_fn),
+                    (HAS_IO_HINTS, io_hints, dm_io_hints_fn),
                 );
 
                 to_result(bindings::dm_register_target(tt))
@@ -411,6 +432,68 @@ impl TargetType {
         };
         T::report_zones(t, args).map_or_else(|e| e.to_errno(), |_| 0)
     }
+    unsafe extern "C" fn dm_prepare_ioctl_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        bdev: *mut *mut bindings::block_device,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+
+        match T::prepare_ioctl(t) {
+            (err, None) => err,
+            // SAFETY: `td` and `dev` is `NonNull`, both of them are valid.
+            (ret, Some(td)) => unsafe {
+                let dm_dev = td.as_ref().dev.as_ptr();
+                let block_dev = (*dm_dev).bdev;
+                *bdev = block_dev;
+                ret
+            },
+        }
+    }
+    unsafe extern "C" fn dm_iterate_devices_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        fn_: bindings::iterate_devices_callout_fn,
+        data: *mut core::ffi::c_void,
+    ) -> core::ffi::c_int {
+        let Some(fn_) = fn_ else {
+            pr_warn!("Invalid iterate_devices_callout_fn, skipped!");
+            return 0;
+        };
+
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+        let devices = match T::iterate_devices(t) {
+            Err(e) => return e.to_errno(),
+            Ok(devices) => devices,
+        };
+
+        let mut ret = 0;
+        for (target_device, start, len) in devices {
+            // SAFETY: `target_device` is `NonNull`, it is also valid.
+            // `fn_` is checked above, it is non-null, and the kernel
+            // should pass valid `iterate_devices_callout_fn`.
+            unsafe {
+                let dev = target_device.as_ref().dev.as_ptr();
+                ret = fn_(ti, dev, start as _, len as _, data);
+                if ret != 0 {
+                    break;
+                }
+            }
+        }
+        ret
+    }
+    unsafe extern "C" fn dm_io_hints_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        limits: *mut bindings::queue_limits,
+    ) {
+        // SAFETY: the kernel should pass valid `dm_target` and `queue_limits`
+        // pointers.
+        unsafe {
+            let t = Target::borrow_mut(ti);
+            let limits = QueueLimits::borrow_mut(limits);
+            T::io_hints(t, limits);
+        }
+    }
 }
 
 /// Wrap the kernel struct `dm_target`.
@@ -549,6 +632,12 @@ fn drop(&mut self) {
     }
 }
 
+/// Gather info about underlying device of target.
+///
+/// The first is the [`TargetDevice`], the second is the start sector of
+/// the device, and the third is the length (in sectors) of the device.
+pub type IterDevice<T> = (NonNull<TargetDevice<T>>, usize, usize);
+
 /// The return values of target map function, i.e., [`TargetOperations::map`].
 #[repr(u32)]
 pub enum MapState {
@@ -802,3 +891,15 @@ fn from(value: u32) -> Self {
         }
     }
 }
+
+/// Wrap the kernel struct `queue_limits`.
+///
+/// Dummy.
+pub struct QueueLimits(Opaque<bindings::queue_limits>);
+
+impl QueueLimits {
+    unsafe fn borrow_mut<'a>(ptr: *mut bindings::queue_limits) -> &'a mut Self {
+        // SAFETY: the caller should pass a valid `ptr`.
+        unsafe { &mut *(ptr as *mut Self) }
+    }
+}
-- 
2.40.1

