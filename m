Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6B73D0D0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjFYMRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjFYMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:17:38 -0400
Received: from out0-212.mail.aliyun.com (out0-212.mail.aliyun.com [140.205.0.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5CAE6E;
        Sun, 25 Jun 2023 05:17:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TdJk.ax_1687695435;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TdJk.ax_1687695435)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 20:17:15 +0800
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
Subject: [RFC PATCH 2/8] rust: kernel: add `request` related TargetOperations
Date:   Sun, 25 Jun 2023 20:16:51 +0800
Message-Id: <20230625121657.3631109-3-changxian.cqs@antgroup.com>
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

- Add `request` related and end_io TargetOperations.
- Add a dummy `request` wrapper and `blk_status_t`.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/kernel/device_mapper.rs | 199 +++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/rust/kernel/device_mapper.rs b/rust/kernel/device_mapper.rs
index 28286b373b59..153bae3aad79 100644
--- a/rust/kernel/device_mapper.rs
+++ b/rust/kernel/device_mapper.rs
@@ -31,6 +31,39 @@ pub trait TargetOperations: Sized {
     /// Map block IOs. Return [`MapState`] to indicate how to handle the `bio`
     /// later (end or resubmit).
     fn map(t: &mut Target<Self>, bio: Pin<&mut Bio>) -> MapState;
+
+    /// Map `request`. Return [`MapState`] and the optional cloned `request`.
+    #[allow(unused)]
+    fn clone_and_map_rq<'a>(
+        t: &mut Target<Self>,
+        rq: Pin<&mut Request>,
+        map_ctx: &mut MapInfo,
+    ) -> (MapState, Option<Pin<&'a mut Request>>) {
+        unimplemented!()
+    }
+
+    /// Release the cloned `request`.
+    #[allow(unused)]
+    fn release_clone_rq(rq: Pin<&mut Request>, map_ctx: &mut MapInfo) {
+        unimplemented!()
+    }
+
+    /// End the `bio`. Return [`EndState`] and [`BlkStatus`].
+    #[allow(unused)]
+    fn end_io(t: &mut Target<Self>, bio: Pin<&mut Bio>) -> (EndState, BlkStatus) {
+        unimplemented!()
+    }
+
+    /// End the `request`. Return [`EndState`].
+    #[allow(unused)]
+    fn rq_end_io(
+        t: &mut Target<Self>,
+        rq: Pin<&mut Request>,
+        map_ctx: &mut MapInfo,
+        err: BlkStatus,
+    ) -> EndState {
+        unimplemented!()
+    }
 }
 
 /// Wrap the kernel struct `target_type`.
@@ -85,6 +118,18 @@ pub fn register<T: TargetOperations>(
                     (HAS_CTR, ctr, dm_ctr_fn),
                     (HAS_DTR, dtr, dm_dtr_fn),
                     (HAS_MAP, map, dm_map_fn),
+                    (
+                        HAS_CLONE_AND_MAP_RQ,
+                        clone_and_map_rq,
+                        dm_clone_and_map_request_fn
+                    ),
+                    (
+                        HAS_RELEASE_CLONE_RQ,
+                        release_clone_rq,
+                        dm_release_clone_request_fn
+                    ),
+                    (HAS_END_IO, end_io, dm_endio_fn),
+                    (HAS_RQ_END_IO, rq_end_io, dm_request_endio_fn),
                 );
 
                 to_result(bindings::dm_register_target(tt))
@@ -148,6 +193,64 @@ impl TargetType {
             T::map(t, bio) as _
         }
     }
+    unsafe extern "C" fn dm_clone_and_map_request_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        rq: *mut bindings::request,
+        map_context: *mut bindings::map_info,
+        clone: *mut *mut bindings::request,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel should pass valid `dm_target`, `request`
+        // and `map_info` pointers.
+        unsafe {
+            let t = Target::borrow_mut(ti);
+            let rq = Request::from_raw(rq);
+            let map_ctx = MapInfo::borrow_mut(map_context);
+            let (map_state, rq_cloned) = T::clone_and_map_rq(t, rq, map_ctx);
+            *clone = rq_cloned.map_or(core::ptr::null_mut(), |rq| rq.opaque.get());
+            map_state as _
+        }
+    }
+    unsafe extern "C" fn dm_release_clone_request_fn<T: TargetOperations>(
+        clone: *mut bindings::request,
+        map_context: *mut bindings::map_info,
+    ) {
+        // SAFETY: the kernel should pass valid `request` and `map_info` pointers.
+        unsafe {
+            let rq = Request::from_raw(clone);
+            let map_ctx = MapInfo::borrow_mut(map_context);
+            T::release_clone_rq(rq, map_ctx);
+        }
+    }
+    unsafe extern "C" fn dm_endio_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        bio: *mut bindings::bio,
+        error: *mut bindings::blk_status_t,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel should pass valid `dm_target`, `bio` and
+        // `error` pointers.
+        unsafe {
+            let t = Target::borrow_mut(ti);
+            let bio = Bio::from_raw(bio);
+            let (end_state, blk_status) = T::end_io(t, bio);
+            *error = blk_status as _;
+            end_state as _
+        }
+    }
+    unsafe extern "C" fn dm_request_endio_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+        clone: *mut bindings::request,
+        error: bindings::blk_status_t,
+        map_context: *mut bindings::map_info,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel should pass valid `dm_target`, `request`
+        // and `map_info` pointers.
+        unsafe {
+            let t = Target::borrow_mut(ti);
+            let rq = Request::from_raw(clone);
+            let map_ctx = MapInfo::borrow_mut(map_context);
+            T::rq_end_io(t, rq, map_ctx, (error as u32).into()) as _
+        }
+    }
 }
 
 /// Wrap the kernel struct `dm_target`.
@@ -305,6 +408,33 @@ pub enum MapState {
     Kill = bindings::DM_MAPIO_KILL,
 }
 
+/// The return values of target end_io function.
+#[repr(u32)]
+pub enum EndState {
+    /// Ended successfully.
+    Done = bindings::DM_ENDIO_DONE,
+
+    /// The io has still not completed (eg, multipath target might
+    /// want to requeue a failed io).
+    Incomplete = bindings::DM_ENDIO_INCOMPLETE,
+
+    /// The target wants to requeue the io.
+    Requeue = bindings::DM_ENDIO_REQUEUE,
+
+    /// The target wants to requeue the io after a delay.
+    DelayRequeue = bindings::DM_ENDIO_DELAY_REQUEUE,
+}
+
+/// Wrap the c struct `map_info`.
+pub struct MapInfo(Opaque<bindings::map_info>);
+
+impl MapInfo {
+    unsafe fn borrow_mut<'a>(ptr: *mut bindings::map_info) -> &'a mut Self {
+        // SAFETY: the caller should pass a valid `ptr`.
+        unsafe { &mut *(ptr as *mut Self) }
+    }
+}
+
 /// Wrap the `c_char` arguments, which yields `CStr`.
 pub struct Args {
     argc: core::ffi::c_uint,
@@ -380,3 +510,72 @@ pub fn is_write(&self) -> bool {
         self.op_and_flags() & bindings::req_op_REQ_OP_WRITE != 0
     }
 }
+
+/// Wrap the kernel struct `request`.
+///
+/// Dummy.
+#[pin_data]
+pub struct Request {
+    #[pin]
+    opaque: Opaque<bindings::request>,
+}
+
+impl Request {
+    unsafe fn from_raw<'a>(ptr: *mut bindings::request) -> Pin<&'a mut Self> {
+        // SAFETY: the caller should pass a valid `request` pointer.
+        unsafe { Pin::new_unchecked(&mut *(ptr as *mut Self)) }
+    }
+}
+
+/// Wrap the block error status values (see [blk_status_t]).
+///
+/// [`blk_status_t`]: ../../../../include/linux/blk_types.h
+#[repr(u32)]
+#[allow(missing_docs)]
+pub enum BlkStatus {
+    Ok,
+    NotSupp,
+    TimeOut,
+    NoSpc,
+    Transport,
+    Target,
+    Nexus,
+    Medium,
+    Protection,
+    Resource,
+    IoErr,
+    DmRequeue,
+    Again,
+    DevResource,
+    ZoneResource,
+    ZoneOpenResource,
+    ZoneActiveResource,
+    Offline,
+    Undefined,
+}
+
+impl From<u32> for BlkStatus {
+    fn from(value: u32) -> Self {
+        match value {
+            0 => Self::Ok,
+            1 => Self::NotSupp,
+            2 => Self::TimeOut,
+            3 => Self::NoSpc,
+            4 => Self::Transport,
+            5 => Self::Target,
+            6 => Self::Nexus,
+            7 => Self::Medium,
+            8 => Self::Protection,
+            9 => Self::Resource,
+            10 => Self::IoErr,
+            11 => Self::DmRequeue,
+            12 => Self::Again,
+            13 => Self::DevResource,
+            14 => Self::ZoneResource,
+            15 => Self::ZoneOpenResource,
+            16 => Self::ZoneActiveResource,
+            17 => Self::Offline,
+            _ => Self::Undefined,
+        }
+    }
+}
-- 
2.40.1

