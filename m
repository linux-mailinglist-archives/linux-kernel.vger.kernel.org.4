Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E975B73D0D2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjFYMR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjFYMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:17:44 -0400
Received: from out0-196.mail.aliyun.com (out0-196.mail.aliyun.com [140.205.0.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F388E51;
        Sun, 25 Jun 2023 05:17:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TdJk.cz_1687695444;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TdJk.cz_1687695444)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 20:17:25 +0800
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
Subject: [RFC PATCH 4/8] rust: kernel: add some info handler TargetOperations
Date:   Sun, 25 Jun 2023 20:16:53 +0800
Message-Id: <20230625121657.3631109-5-changxian.cqs@antgroup.com>
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

- Add `status`/`message` to retrieve info of targets.
- Add `report_zones` to propagate report zones command
  to underlying devices.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/kernel/device_mapper.rs | 149 ++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/device_mapper.rs b/rust/kernel/device_mapper.rs
index aeda12245171..9a62208fda56 100644
--- a/rust/kernel/device_mapper.rs
+++ b/rust/kernel/device_mapper.rs
@@ -10,7 +10,7 @@
 
 use crate::error::to_result;
 use crate::prelude::*;
-use crate::str::CStr;
+use crate::str::{CStr, CString};
 use crate::types::Opaque;
 
 /// Declare operations that a device mapper target can do.
@@ -100,6 +100,24 @@ fn resume(t: &mut Target<Self>) {
     fn busy(t: &mut Target<Self>) -> bool {
         unimplemented!()
     }
+
+    /// Return the target status.
+    #[allow(unused)]
+    fn status(t: &mut Target<Self>, type_: StatusType, flags: StatusFlags) -> Option<CString> {
+        unimplemented!()
+    }
+
+    /// Handle messages to the target.
+    #[allow(unused)]
+    fn message(t: &mut Target<Self>, args: Args) -> Result<CString> {
+        unimplemented!()
+    }
+
+    /// Propagate report zones command to underlying devices.
+    #[allow(unused)]
+    fn report_zones(t: &mut Target<Self>, args: &mut [ReportZonesArgs]) -> Result {
+        unimplemented!()
+    }
 }
 
 /// Wrap the kernel struct `target_type`.
@@ -172,6 +190,9 @@ pub fn register<T: TargetOperations>(
                     (HAS_PRERESUME, preresume, dm_preresume_fn),
                     (HAS_RESUME, resume, dm_resume_fn),
                     (HAS_BUSY, busy, dm_busy_fn),
+                    (HAS_STATUS, status, dm_status_fn),
+                    (HAS_MESSAGE, message, dm_message_fn),
+                    (HAS_REPORT_ZONES, report_zones, dm_report_zones_fn),
                 );
 
                 to_result(bindings::dm_register_target(tt))
@@ -327,6 +348,69 @@ impl TargetType {
         let t = unsafe { Target::borrow_mut(ti) };
         T::busy(t) as _
     }
+    unsafe extern "C" fn dm_status_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        status_type: bindings::status_type_t,
+        status_flags: core::ffi::c_uint,
+        result: *mut core::ffi::c_char,
+        maxlen: core::ffi::c_uint,
+    ) {
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+        if let Some(s) = T::status(t, status_type.into(), status_flags.into()) {
+            let count = s.len_with_nul().min(maxlen as _);
+            // SAFETY: the kernel should pass valid `result` pointer, and
+            // `count` is not greater than `maxlen`.
+            unsafe {
+                core::ptr::copy(s.as_char_ptr(), result, count);
+            }
+        }
+    }
+    unsafe extern "C" fn dm_message_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        argc: core::ffi::c_uint,
+        argv: *mut *mut core::ffi::c_char,
+        result: *mut core::ffi::c_char,
+        maxlen: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel splits arguments by `dm_split_args`, then pass
+        // suitable `argc` and `argv` to `dm_ctr_fn`. If `argc` is not zero,
+        // `argv` is non-null and valid.
+        let args = unsafe { Args::new(argc, argv) };
+
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+        T::message(t, args).map_or_else(
+            |e| e.to_errno(),
+            // SAFETY: the kernel should pass valid `result` pointer, and
+            // `count` is not greater than `maxlen`.
+            |ret| unsafe {
+                let count = ret.len_with_nul().min(maxlen as _);
+                core::ptr::copy(ret.as_char_ptr(), result, count);
+                0
+            },
+        )
+    }
+    unsafe extern "C" fn dm_report_zones_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        args: *mut bindings::dm_report_zones_args,
+        nr_zones: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+
+        let args = if nr_zones > 0 {
+            // SAFETY: the kernel should pass valid `args`, if `nr_zones`
+            // is not zero.
+            unsafe {
+                let first = ReportZonesArgs::borrow_mut(args);
+                core::slice::from_raw_parts_mut(first as _, nr_zones as _)
+            }
+        } else {
+            &mut []
+        };
+        T::report_zones(t, args).map_or_else(|e| e.to_errno(), |_| 0)
+    }
 }
 
 /// Wrap the kernel struct `dm_target`.
@@ -511,6 +595,69 @@ unsafe fn borrow_mut<'a>(ptr: *mut bindings::map_info) -> &'a mut Self {
     }
 }
 
+/// Define target status types.
+#[repr(u32)]
+pub enum StatusType {
+    /// Request for some general info.
+    Info,
+
+    /// Request for more detailed info.
+    Table,
+
+    /// Request for some integrity info.
+    Ima,
+
+    /// Undefined.
+    Undefined,
+}
+
+impl From<u32> for StatusType {
+    fn from(value: u32) -> Self {
+        match value {
+            bindings::status_type_t_STATUSTYPE_INFO => Self::Info,
+            bindings::status_type_t_STATUSTYPE_TABLE => Self::Table,
+            bindings::status_type_t_STATUSTYPE_IMA => Self::Ima,
+            _ => Self::Undefined,
+        }
+    }
+}
+
+/// Define target status flags.
+#[repr(u32)]
+pub enum StatusFlags {
+    /// See `DM_STATUS_NOFLUSH_FLAG`.
+    NoFlush = 1 << 0,
+
+    /// Undefined.
+    Undefined,
+}
+
+impl From<u32> for StatusFlags {
+    fn from(value: u32) -> Self {
+        match value {
+            0 => Self::NoFlush,
+            _ => Self::Undefined,
+        }
+    }
+}
+
+/// Wrap the kernel struct `dm_report_zones_args`.
+pub struct ReportZonesArgs(Opaque<bindings::dm_report_zones_args>);
+
+impl ReportZonesArgs {
+    unsafe fn borrow_mut<'a>(ptr: *mut bindings::dm_report_zones_args) -> &'a mut Self {
+        // SAFETY: the caller should pass a valid `ptr`.
+        unsafe { &mut *(ptr as *mut Self) }
+    }
+
+    /// Return the next sector.
+    pub fn next_sector(&self) -> usize {
+        // SAFETY: `self.0` is borrowed form foreign pointer,
+        // should be valid.
+        unsafe { (*self.0.get()).next_sector as _ }
+    }
+}
+
 /// Wrap the `c_char` arguments, which yields `CStr`.
 pub struct Args {
     argc: core::ffi::c_uint,
-- 
2.40.1

