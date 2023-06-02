Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4DA71FED2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjFBKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjFBKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:18:56 -0400
Received: from out0-201.mail.aliyun.com (out0-201.mail.aliyun.com [140.205.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37790198;
        Fri,  2 Jun 2023 03:18:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TJMsjC0_1685701122;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TJMsjC0_1685701122)
          by smtp.aliyun-inc.com;
          Fri, 02 Jun 2023 18:18:43 +0800
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
Subject: [PATCH v2 3/3] rust: kernel: add SgTable abstraction
Date:   Fri, 02 Jun 2023 18:18:19 +0800
Message-Id: <20230602101819.2134194-4-changxian.cqs@antgroup.com>
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

SgTable is similar to `struct sg_table`, consisted of
scatterlist entries, and could be chained with each other.

Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
 rust/kernel/scatterlist.rs | 172 +++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index 292fcb63a329..fd30f61a9743 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -328,3 +328,175 @@ impl<'a> Iterator for IterMut<'a> {
         ScatterList::as_mut(ptr)
     }
 }
+
+/// A [`ScatterList`] table of fixed `N` entries.
+///
+/// According to the design of kernel's `struct sg_table`, the `page_link`
+/// field of one `scatterlist` may contain a pointer to another. That is,
+/// there could exist external pointers to it, making it necessary to pin
+/// this struct.
+///
+/// If the table is chainable, the last entry will be reserved for chainning.
+/// The recommended way to create such instances is with the [`pin_init`].
+///
+/// # Examples
+///
+/// The following is some use cases of [`SgTable<N>`].
+///
+/// ```rust
+/// use core::pin::pin;;
+/// # use kernel::error::Result;
+/// # use kernel::scatterlist::{ScatterList, SgTable};
+///
+/// // Prepare memory buffers.
+/// let buf0: Pin<&mut [u8]> = pin!([0u8; 512]);
+/// let buf1: Pin<&mut [u8]> = pin!([1u8; 512]);
+/// let mut entries: Vec<Pin<&mut [u8]>> = Vec::<Pin<&mut [u8]>>::new();
+/// entries.try_push(buf0)?;
+/// entries.try_push(buf1)?;
+///
+/// // Allocates an instance on stack.
+/// kernel::stack_try_pin_init!(let foo =? SgTable::new(entries.as_slice(), false));
+/// let mut foo: Pin<&mut SgTable<'_, 2>> = foo;
+/// assert_eq!(foo.count(), 2);
+///
+/// // Alloccate a chainable instance by Box::pin_init.
+/// let mut bar: Pin<Box<SgTable<'_, 3>>> = Box::pin_init(SgTable::new(entries.as_slice(), true))?;
+/// assert_eq!(bar.count(), 2);
+///
+/// // Chain two `SgTable` together.
+/// bar.chain_sgt(foo.as_mut())?;
+/// assert_eq!(bar.count(), 4);
+///
+/// // Get the immutable reference to the entry in the table.
+/// let sgl1: Pin<&ScatterList<'_>> = bar.get(1).ok_or(EINVAL)?;
+/// assert_eq!(sgl1.count(), 3);
+/// assert_eq!(sgl1.get_buf(), [1u8; 512]);
+///
+/// // Get the mutable reference to the entry in the table.
+/// let sgl2: Pin<&mut ScatterList<'_>> = bar.get_mut(2).ok_or(EINVAL)?;
+/// assert_eq!(sgl2.count(), 2);
+/// assert_eq!(sgl2.get_buf(), [0u8; 512]);
+///
+/// // Try to get a non-exist entry from the table.
+/// let sgl4 = bar.get(4);
+/// assert_eq!(sgl4.is_none(), true);
+///
+/// // Split the first table from chained scatterlist.
+/// bar.split()?;
+/// assert_eq!(bar.count(), 2);
+/// ```
+#[pin_data]
+pub struct SgTable<'a, const N: usize> {
+    #[pin]
+    entries: [ScatterList<'a>; N],
+}
+
+impl<'a, const N: usize> SgTable<'a, N> {
+    /// Construct a new initializer.
+    ///
+    /// The length of `entries` should exactly be the available size of [`SgTable<N>`].
+    /// If the table is `chainable`, the available size is `N - 1`, because one entry
+    /// should be reserved for chainning.
+    pub fn new(
+        entries: &'a [Pin<&mut [u8]>],
+        chainable: bool,
+    ) -> impl PinInit<SgTable<'a, N>, Error> {
+        build_assert!(N > 0);
+        // SAFETY: `slot` is valid while the closure is called, the `entries` are
+        // pinned and valid.
+        unsafe {
+            init::pin_init_from_closure(move |slot: *mut Self| {
+                let mut nr_entry = N;
+                if chainable {
+                    nr_entry -= 1;
+                }
+                if nr_entry == 0 || entries.len() != nr_entry {
+                    return Err(EINVAL);
+                }
+
+                for i in 0..nr_entry {
+                    let sgl = &mut (*slot).entries[i];
+                    sgl.set_buf(&entries[i]);
+                    if i + 1 == nr_entry {
+                        sgl.mark_end();
+                    }
+                }
+                Ok(())
+            })
+        }
+    }
+
+    /// Chain two [`SgTable`] together.
+    ///
+    /// Transfer the last entry of this table as a chainable pointer to the
+    /// first entry of `sgt` SgTable.
+    pub fn chain_sgt<const M: usize>(&mut self, sgt: Pin<&mut SgTable<'_, M>>) -> Result {
+        if self.count() != N - 1 {
+            return Err(EINVAL);
+        }
+        self.entries[N - 2].unmark_end();
+
+        let next = ScatterList::as_mut(sgt.entries[0].opaque.get()).ok_or(EINVAL)?;
+        self.entries[N - 1].chain_sgl(next);
+        Ok(())
+    }
+
+    /// Chain [`SgTable`] and [`ScatterList`] together.
+    ///
+    /// Transfer the last entry of this table as a chainable pointer to `sgl`
+    /// scatterlist.
+    pub fn chain_sgl(&mut self, sgl: Pin<&mut ScatterList<'_>>) -> Result {
+        if self.count() != N - 1 {
+            return Err(EINVAL);
+        }
+        self.entries[N - 2].unmark_end();
+        self.entries[N - 1].chain_sgl(sgl);
+        Ok(())
+    }
+
+    /// Split the first table from chained scatterlist.
+    pub fn split(&mut self) -> Result {
+        if !self.entries[N - 1].is_chain() {
+            return Err(EINVAL);
+        }
+        self.entries[N - 2].mark_end();
+        Ok(())
+    }
+
+    /// Return the total count of normal entries in the table.
+    ///
+    /// Allows to know how many entries are in sg, taking into account
+    /// chaining as well.
+    pub fn count(&self) -> usize {
+        // SAFETY: `self.entries` are initialized by the `new` constructor,
+        // so it's valid.
+        unsafe { bindings::sg_nents(self.entries[0].opaque.get()) as _ }
+    }
+
+    /// Get the immutable reference to `n`th entry in the table.
+    ///
+    /// Like most indexing operations, the count starts from zero. Return None
+    /// if `n` is greater than or equal to the total count of entries.
+    pub fn get(&self, n: usize) -> Option<Pin<&ScatterList<'_>>> {
+        self.iter().nth(n)
+    }
+
+    /// Get the mutable reference to `n`th entry in the table.
+    ///
+    /// Like most indexing operations, the count starts from zero. Return None
+    /// if `n` is greater than or equal to the number of total entries.
+    pub fn get_mut(&mut self, n: usize) -> Option<Pin<&mut ScatterList<'_>>> {
+        self.iter_mut().nth(n)
+    }
+
+    /// Get an iterator for immutable entries.
+    pub fn iter(&self) -> Iter<'_> {
+        Iter(ScatterList::as_ref(self.entries[0].opaque.get()))
+    }
+
+    /// Get an iterator for mutable entries.
+    pub fn iter_mut(&mut self) -> IterMut<'_> {
+        IterMut(ScatterList::as_mut(self.entries[0].opaque.get()))
+    }
+}
-- 
2.40.1

