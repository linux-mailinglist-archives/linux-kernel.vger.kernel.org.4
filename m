Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B2572AAF3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 12:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjFJKtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjFJKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 06:49:35 -0400
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8E35BC;
        Sat, 10 Jun 2023 03:49:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TQGLBah_1686394167;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TQGLBah_1686394167)
          by smtp.aliyun-inc.com;
          Sat, 10 Jun 2023 18:49:28 +0800
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
Subject: [PATCH v3 2/3] rust: kernel: implement iterators for ScatterList
Date:   Sat, 10 Jun 2023 18:49:08 +0800
Message-Id: <20230610104909.3202958-3-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610104909.3202958-1-changxian.cqs@antgroup.com>
References: <20230610104909.3202958-1-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ScatterList could be transmuted from raw pointers of a valid
`sg_table`. Then we can use those iterators to access the
following normal entries.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/kernel/scatterlist.rs | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index 7fb8f3326ff3..41e268b93c9e 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -290,4 +290,62 @@ impl ScatterList<'_> {
         // SAFETY: By the type invariant, we know that `self.opaque` is valid.
         unsafe { bindings::sg_nents(self.opaque.get()) as _ }
     }
+
+    /// Get an iterator for immutable references.
+    pub fn iter(&self) -> Iter<'_> {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe { Iter(ScatterList::as_ref(self.opaque.get())) }
+    }
+
+    /// Get an iterator for mutable references.
+    pub fn iter_mut(&mut self) -> IterMut<'_> {
+        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
+        unsafe { IterMut(ScatterList::as_mut(self.opaque.get())) }
+    }
+}
+
+/// An iterator that yields [`Pin<&ScatterList>`].
+///
+/// Only iterate normal scatterlist entries, chainable entry will be skipped.
+pub struct Iter<'a>(Option<Pin<&'a ScatterList<'a>>>);
+
+impl<'a> Iterator for Iter<'a> {
+    type Item = Pin<&'a ScatterList<'a>>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        let ptr = match &self.0 {
+            None => return None,
+            Some(sgl) => sgl.opaque.get(),
+        };
+        // SAFETY: `ptr` is from `self.opaque`, it is valid by the type invariant.
+        // And `next` is null, or the next valid scatterlist entry.
+        unsafe {
+            let next = bindings::sg_next(ptr);
+            self.0 = ScatterList::as_ref(next);
+            ScatterList::as_ref(ptr)
+        }
+    }
+}
+
+/// An iterator that yields [`Pin<&mut ScatterList>`].
+///
+/// Only iterate normal scatterlist entries, chainable entry will be skipped.
+pub struct IterMut<'a>(Option<Pin<&'a mut ScatterList<'a>>>);
+
+impl<'a> Iterator for IterMut<'a> {
+    type Item = Pin<&'a mut ScatterList<'a>>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        let ptr = match &self.0 {
+            None => return None,
+            Some(sgl) => sgl.opaque.get(),
+        };
+        // SAFETY: `ptr` is from `self.opaque`, it is valid by the type invariant.
+        // And `next` is null, or the next valid scatterlist entry.
+        unsafe {
+            let next = bindings::sg_next(ptr);
+            self.0 = ScatterList::as_mut(next);
+            ScatterList::as_mut(ptr)
+        }
+    }
 }
-- 
2.40.1

