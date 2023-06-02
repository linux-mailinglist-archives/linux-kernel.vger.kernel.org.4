Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3A71FED1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjFBKSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjFBKSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:18:45 -0400
Received: from out0-199.mail.aliyun.com (out0-199.mail.aliyun.com [140.205.0.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBF4198;
        Fri,  2 Jun 2023 03:18:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TJMsjA9_1685701117;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TJMsjA9_1685701117)
          by smtp.aliyun-inc.com;
          Fri, 02 Jun 2023 18:18:38 +0800
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
Subject: [PATCH v2 2/3] rust: kernel: implement iterators for ScatterList
Date:   Fri, 02 Jun 2023 18:18:18 +0800
Message-Id: <20230602101819.2134194-3-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
References: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 rust/kernel/scatterlist.rs | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index 8d6a34afb191..292fcb63a329 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -277,4 +277,54 @@ impl ScatterList<'_> {
         // SAFETY: By the type invariant, we know that `self.opaque` is valid.
         unsafe { bindings::sg_nents(self.opaque.get()) as _ }
     }
+
+    /// Get an iterator for immutable references.
+    pub fn iter(&self) -> Iter<'_> {
+        Iter(ScatterList::as_ref(self.opaque.get()))
+    }
+
+    /// Get an iterator for mutable references.
+    pub fn iter_mut(&mut self) -> IterMut<'_> {
+        IterMut(ScatterList::as_mut(self.opaque.get()))
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
+        if self.0.is_none() {
+            return None;
+        }
+        let ptr = self.0.as_ref().unwrap().opaque.get();
+        // SAFETY: `ptr` is from `self.opaque`, it is valid by the type invariant.
+        let next = unsafe { bindings::sg_next(ptr) };
+        self.0 = ScatterList::as_ref(next);
+        ScatterList::as_ref(ptr)
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
+        if self.0.is_none() {
+            return None;
+        }
+        let ptr = self.0.as_ref().unwrap().opaque.get();
+        // SAFETY: `ptr` is from `self.opaque`, it is valid by the type invariant.
+        let next = unsafe { bindings::sg_next(ptr) };
+        self.0 = ScatterList::as_mut(next);
+        ScatterList::as_mut(ptr)
+    }
 }
-- 
2.40.1

