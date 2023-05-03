Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69D66F53F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjECJHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjECJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:07:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE53B4C08
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:07:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3063433fa66so1615333f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683104840; x=1685696840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hg9EF+CTDGGAsWt0N5WyI6rk7QsJ8yExmPcN8MX0qQ=;
        b=d+lWf2ETGwZ6l0kF5yoMkucYwDf2kDuSHvqzafoL6LSaWDyChZFeb/y3Ask+uZL3ub
         Crm1FWg7HSXUUHQu4aZsOctpyLqbz0tvhgPgilALIxNAKTgLG9YZ5O7UUoSFUznFtAd7
         8OtJqUv7m3XxiwrPol077Wc7De84xWLwlJ9zH1FgVk7LrKu7kj7KMolcbNdrGquUbXHA
         gx1o+RI6ewKReUGP7O57duA5S2sDgZdoARg8MtGBlJBT45+yVJtwMrDiwgD1CJt2xVPz
         ns0renNS1R/Xu68zuPNBQGUcpB38HrRkV/8/C94FuyxzQvT6lrnKR7AKdmaNVmf1WOts
         FeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683104840; x=1685696840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Hg9EF+CTDGGAsWt0N5WyI6rk7QsJ8yExmPcN8MX0qQ=;
        b=Vpl/kCTWml/uHg5/3waZ0shiVT9tqUMg97FXQQSSIPKBEBAzzu/8I+FScCzXAO5AJp
         bgLDjwtWPXst9nyU7GsDev67/DNUxfJYSH2vkkSI4sks3pMOh+rcxs+tBL3nt1UA4EXU
         V1+eOmeitXvMfTeLiVdtn7+4ml7iO8TJjD39nzqrvBvJgVwHyu84566SjeOd48/GaDRc
         c+wKOMXwMbULanwFH4TTYFtpB2302Dn1AsPINfrP4sU4dxKDOKr+jidzIBGspKPhKCrP
         RBmmyGoJonU8b9ZvyPhuBL71XL4jfUwTr1sNEABYzP3W5D7hqGiQpx310Glc1WFNOd+P
         BivA==
X-Gm-Message-State: AC+VfDzqb0m+w/YPRS/qZ8uXbwBdStDwm+l7ns9GWDxwRh5OiC1LkVFG
        jigK8G6/HGj15huqtcUeKwn7ig==
X-Google-Smtp-Source: ACHHUZ6T2y7vjejoAr+gXXz7fkMQ4wlDgEasl/1jBzVe1iLoMPS+zptIdaYP9DejgMdUNDfXGrvBNg==
X-Received: by 2002:adf:e484:0:b0:306:320b:5dbd with SMTP id i4-20020adfe484000000b00306320b5dbdmr5824254wrm.71.1683104840210;
        Wed, 03 May 2023 02:07:20 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id v12-20020adfe28c000000b0030497b3224bsm20046305wri.64.2023.05.03.02.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:07:19 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kernel@vger.kernel.org (open list), gost.dev@samsung.com
Subject: [RFC PATCH 04/11] rust: block: introduce `kernel::block::bio` module
Date:   Wed,  3 May 2023 11:07:01 +0200
Message-Id: <20230503090708.2524310-5-nmi@metaspace.dk>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Add abstractions for working with `struct bio`.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/block.rs            |   1 +
 rust/kernel/block/bio.rs        |  93 ++++++++++++++++
 rust/kernel/block/bio/vec.rs    | 181 ++++++++++++++++++++++++++++++++
 rust/kernel/block/mq/request.rs |  16 +++
 4 files changed, 291 insertions(+)
 create mode 100644 rust/kernel/block/bio.rs
 create mode 100644 rust/kernel/block/bio/vec.rs

diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 4c93317a568a..1797859551fd 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -2,4 +2,5 @@
 
 //! Types for working with the block layer
 
+pub mod bio;
 pub mod mq;
diff --git a/rust/kernel/block/bio.rs b/rust/kernel/block/bio.rs
new file mode 100644
index 000000000000..6e93e4420105
--- /dev/null
+++ b/rust/kernel/block/bio.rs
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with the bio layer.
+//!
+//! C header: [`include/linux/blk_types.h`](../../include/linux/blk_types.h)
+
+use core::fmt;
+use core::ptr::NonNull;
+
+mod vec;
+
+pub use vec::BioSegmentIterator;
+pub use vec::Segment;
+
+/// A wrapper around a `struct bio` pointer
+///
+/// # Invariants
+///
+/// First field must alwyas be a valid pointer to a valid `struct bio`.
+pub struct Bio<'a>(
+    NonNull<crate::bindings::bio>,
+    core::marker::PhantomData<&'a ()>,
+);
+
+impl<'a> Bio<'a> {
+    /// Returns an iterator over segments in this `Bio`. Does not consider
+    /// segments of other bios in this bio chain.
+    #[inline(always)]
+    pub fn segment_iter(&'a self) -> BioSegmentIterator<'a> {
+        BioSegmentIterator::new(self)
+    }
+
+    /// Get a pointer to the `bio_vec` off this bio
+    #[inline(always)]
+    fn io_vec(&self) -> *const bindings::bio_vec {
+        // SAFETY: By type invariant, get_raw() returns a valid pointer to a
+        // valid `struct bio`
+        unsafe { (*self.get_raw()).bi_io_vec }
+    }
+
+    /// Return a copy of the `bvec_iter` for this `Bio`
+    #[inline(always)]
+    fn iter(&self) -> bindings::bvec_iter {
+        // SAFETY: self.0 is always a valid pointer
+        unsafe { (*self.get_raw()).bi_iter }
+    }
+
+    /// Get the next `Bio` in the chain
+    #[inline(always)]
+    fn next(&self) -> Option<Bio<'a>> {
+        // SAFETY: self.0 is always a valid pointer
+        let next = unsafe { (*self.get_raw()).bi_next };
+        Some(Self(NonNull::new(next)?, core::marker::PhantomData))
+    }
+
+    /// Return the raw pointer of the wrapped `struct bio`
+    #[inline(always)]
+    fn get_raw(&self) -> *const bindings::bio {
+        self.0.as_ptr()
+    }
+
+    /// Create an instance of `Bio` from a raw pointer. Does check that the
+    /// pointer is not null.
+    #[inline(always)]
+    pub(crate) unsafe fn from_raw(ptr: *mut bindings::bio) -> Option<Bio<'a>> {
+        Some(Self(NonNull::new(ptr)?, core::marker::PhantomData))
+    }
+}
+
+impl core::fmt::Display for Bio<'_> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "Bio {:?}", self.0.as_ptr())
+    }
+}
+
+/// An iterator over `Bio`
+pub struct BioIterator<'a> {
+    pub(crate) bio: Option<Bio<'a>>,
+}
+
+impl<'a> core::iter::Iterator for BioIterator<'a> {
+    type Item = Bio<'a>;
+
+    #[inline(always)]
+    fn next(&mut self) -> Option<Bio<'a>> {
+        if let Some(current) = self.bio.take() {
+            self.bio = current.next();
+            Some(current)
+        } else {
+            None
+        }
+    }
+}
diff --git a/rust/kernel/block/bio/vec.rs b/rust/kernel/block/bio/vec.rs
new file mode 100644
index 000000000000..acd328a6fe54
--- /dev/null
+++ b/rust/kernel/block/bio/vec.rs
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with `struct bio_vec` IO vectors
+//!
+//! C header: [`include/linux/bvec.h`](../../include/linux/bvec.h)
+
+use super::Bio;
+use crate::error::Result;
+use crate::pages::Pages;
+use core::fmt;
+use core::mem::ManuallyDrop;
+
+#[inline(always)]
+fn mp_bvec_iter_offset(bvec: *const bindings::bio_vec, iter: &bindings::bvec_iter) -> u32 {
+    (unsafe { (*bvec_iter_bvec(bvec, iter)).bv_offset }) + iter.bi_bvec_done
+}
+
+#[inline(always)]
+fn mp_bvec_iter_page(
+    bvec: *const bindings::bio_vec,
+    iter: &bindings::bvec_iter,
+) -> *mut bindings::page {
+    unsafe { (*bvec_iter_bvec(bvec, iter)).bv_page }
+}
+
+#[inline(always)]
+fn mp_bvec_iter_page_idx(bvec: *const bindings::bio_vec, iter: &bindings::bvec_iter) -> usize {
+    (mp_bvec_iter_offset(bvec, iter) / crate::PAGE_SIZE) as usize
+}
+
+#[inline(always)]
+fn mp_bvec_iter_len(bvec: *const bindings::bio_vec, iter: &bindings::bvec_iter) -> u32 {
+    iter.bi_size
+        .min(unsafe { (*bvec_iter_bvec(bvec, iter)).bv_len } - iter.bi_bvec_done)
+}
+
+#[inline(always)]
+fn bvec_iter_bvec(
+    bvec: *const bindings::bio_vec,
+    iter: &bindings::bvec_iter,
+) -> *const bindings::bio_vec {
+    unsafe { bvec.add(iter.bi_idx as usize) }
+}
+
+#[inline(always)]
+fn bvec_iter_page(
+    bvec: *const bindings::bio_vec,
+    iter: &bindings::bvec_iter,
+) -> *mut bindings::page {
+    unsafe { mp_bvec_iter_page(bvec, iter).add(mp_bvec_iter_page_idx(bvec, iter)) }
+}
+
+#[inline(always)]
+fn bvec_iter_len(bvec: *const bindings::bio_vec, iter: &bindings::bvec_iter) -> u32 {
+    mp_bvec_iter_len(bvec, iter).min(crate::PAGE_SIZE - bvec_iter_offset(bvec, iter))
+}
+
+#[inline(always)]
+fn bvec_iter_offset(bvec: *const bindings::bio_vec, iter: &bindings::bvec_iter) -> u32 {
+    mp_bvec_iter_offset(bvec, iter) % crate::PAGE_SIZE
+}
+
+/// A wrapper around a `strutct bio_vec` - a contiguous range of physical memory addresses
+///
+/// # Invariants
+///
+/// `bio_vec` must always be initialized and valid
+pub struct Segment<'a> {
+    bio_vec: bindings::bio_vec,
+    _marker: core::marker::PhantomData<&'a ()>,
+}
+
+impl Segment<'_> {
+    /// Get he lenght of the segment in bytes
+    #[inline(always)]
+    pub fn len(&self) -> usize {
+        self.bio_vec.bv_len as usize
+    }
+
+    /// Returns true if the length of the segment is 0
+    #[inline(always)]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Get the offset field of the `bio_vec`
+    #[inline(always)]
+    pub fn offset(&self) -> usize {
+        self.bio_vec.bv_offset as usize
+    }
+
+    /// Copy data of this segment into `page`.
+    #[inline(always)]
+    pub fn copy_to_page_atomic(&self, page: &mut Pages<0>) -> Result {
+        // SAFETY: self.bio_vec is valid and thus bv_page must be a valid
+        // pointer to a `struct page`. We do not own the page, but we prevent
+        // drop by wrapping the `Pages` in `ManuallyDrop`.
+        let our_page = ManuallyDrop::new(unsafe { Pages::<0>::from_raw(self.bio_vec.bv_page) });
+        let our_map = our_page.kmap_atomic();
+
+        // TODO: Checck offset is within page - what guarantees does `bio_vec` provide?
+        let ptr = unsafe { (our_map.get_ptr() as *const u8).add(self.offset()) };
+
+        unsafe { page.write_atomic(ptr, self.offset(), self.len()) }
+    }
+
+    /// Copy data from `page` into this segment
+    #[inline(always)]
+    pub fn copy_from_page_atomic(&mut self, page: &Pages<0>) -> Result {
+        // SAFETY: self.bio_vec is valid and thus bv_page must be a valid
+        // pointer to a `struct page`. We do not own the page, but we prevent
+        // drop by wrapping the `Pages` in `ManuallyDrop`.
+        let our_page = ManuallyDrop::new(unsafe { Pages::<0>::from_raw(self.bio_vec.bv_page) });
+        let our_map = our_page.kmap_atomic();
+
+        // TODO: Checck offset is within page
+        let ptr = unsafe { (our_map.get_ptr() as *mut u8).add(self.offset()) };
+
+        unsafe { page.read_atomic(ptr, self.offset(), self.len()) }
+    }
+}
+
+impl core::fmt::Display for Segment<'_> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(
+            f,
+            "Segment {:?} len: {}",
+            self.bio_vec.bv_page, self.bio_vec.bv_len
+        )
+    }
+}
+
+/// An iterator over `Segment`
+pub struct BioSegmentIterator<'a> {
+    bio: &'a Bio<'a>,
+    iter: bindings::bvec_iter,
+}
+
+impl<'a> BioSegmentIterator<'a> {
+    #[inline(always)]
+    pub(crate) fn new(bio: &'a Bio<'a>) -> BioSegmentIterator<'_> {
+        Self {
+            bio,
+            iter: bio.iter(),
+        }
+    }
+}
+
+impl<'a> core::iter::Iterator for BioSegmentIterator<'a> {
+    type Item = Segment<'a>;
+
+    #[inline(always)]
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.iter.bi_size == 0 {
+            return None;
+        }
+
+        // Macro
+        // bio_vec = bio_iter_iovec(bio, self.iter)
+        // bio_vec = bvec_iter_bvec(bio.bi_io_vec, self.iter);
+        let bio_vec_ret = bindings::bio_vec {
+            bv_page: bvec_iter_page(self.bio.io_vec(), &self.iter),
+            bv_len: bvec_iter_len(self.bio.io_vec(), &self.iter),
+            bv_offset: bvec_iter_offset(self.bio.io_vec(), &self.iter),
+        };
+
+        // Static C function
+        unsafe {
+            bindings::bio_advance_iter_single(
+                self.bio.get_raw(),
+                &mut self.iter as *mut bindings::bvec_iter,
+                bio_vec_ret.bv_len,
+            )
+        };
+
+        Some(Segment {
+            bio_vec: bio_vec_ret,
+            _marker: core::marker::PhantomData,
+        })
+    }
+}
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index e95ae3fd71ad..ccb1033b64b6 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -11,6 +11,9 @@ use crate::{
 };
 use core::marker::PhantomData;
 
+use crate::block::bio::Bio;
+use crate::block::bio::BioIterator;
+
 /// A wrapper around a blk-mq `struct request`. This represents an IO request.
 pub struct Request<T: Operations> {
     ptr: *mut bindings::request,
@@ -63,6 +66,19 @@ impl<T: Operations> Request<T> {
         }
     }
 
+    /// Get a wrapper for the first Bio in this request
+    #[inline(always)]
+    pub fn bio(&self) -> Option<Bio<'_>> {
+        let ptr = unsafe { (*self.ptr).bio };
+        unsafe { Bio::from_raw(ptr) }
+    }
+
+    /// Get an iterator over all bio structurs in this request
+    #[inline(always)]
+    pub fn bio_iter(&self) -> BioIterator<'_> {
+        BioIterator { bio: self.bio() }
+    }
+
     /// Get the target sector for the request
     #[inline(always)]
     pub fn sector(&self) -> usize {
-- 
2.40.0

