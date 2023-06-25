Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B3C73D0D1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjFYMRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjFYMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:17:39 -0400
Received: from out0-195.mail.aliyun.com (out0-195.mail.aliyun.com [140.205.0.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869AE48;
        Sun, 25 Jun 2023 05:17:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047206;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TdJuHZE_1687695439;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TdJuHZE_1687695439)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 20:17:20 +0800
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
Subject: [RFC PATCH 3/8] rust: kernel: add some hook TargetOperations
Date:   Sun, 25 Jun 2023 20:16:52 +0800
Message-Id: <20230625121657.3631109-4-changxian.cqs@antgroup.com>
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

- Add hooks when suspend or resume a target.
- Add operation to check if a target is busy.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/kernel/device_mapper.rs | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/rust/kernel/device_mapper.rs b/rust/kernel/device_mapper.rs
index 153bae3aad79..aeda12245171 100644
--- a/rust/kernel/device_mapper.rs
+++ b/rust/kernel/device_mapper.rs
@@ -64,6 +64,42 @@ fn rq_end_io(
     ) -> EndState {
         unimplemented!()
     }
+
+    /// Hook presuspend.
+    #[allow(unused)]
+    fn presuspend(t: &mut Target<Self>) {
+        unimplemented!()
+    }
+
+    /// Hook presuspend_undo.
+    #[allow(unused)]
+    fn presuspend_undo(t: &mut Target<Self>) {
+        unimplemented!()
+    }
+
+    /// Hook postsuspend.
+    #[allow(unused)]
+    fn postsuspend(t: &mut Target<Self>) {
+        unimplemented!()
+    }
+
+    /// Hook preresume.
+    #[allow(unused)]
+    fn preresume(t: &mut Target<Self>) -> Result {
+        unimplemented!()
+    }
+
+    /// Hook resume.
+    #[allow(unused)]
+    fn resume(t: &mut Target<Self>) {
+        unimplemented!()
+    }
+
+    /// Check if target is busy.
+    #[allow(unused)]
+    fn busy(t: &mut Target<Self>) -> bool {
+        unimplemented!()
+    }
 }
 
 /// Wrap the kernel struct `target_type`.
@@ -130,6 +166,12 @@ pub fn register<T: TargetOperations>(
                     ),
                     (HAS_END_IO, end_io, dm_endio_fn),
                     (HAS_RQ_END_IO, rq_end_io, dm_request_endio_fn),
+                    (HAS_PRESUSPEND, presuspend, dm_presuspend_fn),
+                    (HAS_PRESUSPEND_UNDO, presuspend_undo, dm_presuspend_undo_fn),
+                    (HAS_POSTSUSPEND, postsuspend, dm_postsuspend_fn),
+                    (HAS_PRERESUME, preresume, dm_preresume_fn),
+                    (HAS_RESUME, resume, dm_resume_fn),
+                    (HAS_BUSY, busy, dm_busy_fn),
                 );
 
                 to_result(bindings::dm_register_target(tt))
@@ -251,6 +293,40 @@ impl TargetType {
             T::rq_end_io(t, rq, map_ctx, (error as u32).into()) as _
         }
     }
+    unsafe extern "C" fn dm_presuspend_fn<T: TargetOperations>(ti: *mut bindings::dm_target) {
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+        T::presuspend(t);
+    }
+    unsafe extern "C" fn dm_presuspend_undo_fn<T: TargetOperations>(ti: *mut bindings::dm_target) {
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+        T::presuspend_undo(t);
+    }
+    unsafe extern "C" fn dm_postsuspend_fn<T: TargetOperations>(ti: *mut bindings::dm_target) {
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+        T::postsuspend(t);
+    }
+    unsafe extern "C" fn dm_preresume_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+        T::preresume(t).map_or_else(|e| e.to_errno(), |_| 0)
+    }
+    unsafe extern "C" fn dm_resume_fn<T: TargetOperations>(ti: *mut bindings::dm_target) {
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+        T::resume(t);
+    }
+    unsafe extern "C" fn dm_busy_fn<T: TargetOperations>(
+        ti: *mut bindings::dm_target,
+    ) -> core::ffi::c_int {
+        // SAFETY: the kernel should pass valid `dm_target` pointer.
+        let t = unsafe { Target::borrow_mut(ti) };
+        T::busy(t) as _
+    }
 }
 
 /// Wrap the kernel struct `dm_target`.
-- 
2.40.1

