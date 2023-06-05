Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6180A723236
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjFEV1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjFEV1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:27:36 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA2B102;
        Mon,  5 Jun 2023 14:27:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686000451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64nBgUt3LBbi5bWI/fY2KRwa2hIpN2JjgSvVArYkQXY=;
        b=GO7qJyFfJziW7NO3+ly+zQdGPNDFzNs6wUx+mMV5KBn6Hdh8a6kn7v9WflySnUJq0s+cyx
        Hd3JqNVgVQKYN0mmpoPIwwcpT/TaNdx3byLRqkfIS4KTNyzYjo9HXrEYd44p4RtnG0u8z4
        bL/4oUftEfdgPC7IgUvnkCPZYLg7U3w=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 3/5] block: Add documentation for bio iterator macros
Date:   Mon,  5 Jun 2023 17:27:15 -0400
Message-Id: <20230605212717.2570570-3-kent.overstreet@linux.dev>
In-Reply-To: <20230605212717.2570570-1-kent.overstreet@linux.dev>
References: <20230605212717.2570570-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've now got 3x2 interfaces for iterating over bios: by page, by bvec,
or by folio, and variants that iterate over what bi_iter points to, or
the entire bio as created by the filesystem/originator.

This adds more detailed kerneldoc comments for each variant.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
---
 include/linux/bio.h | 54 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4b197ea83c..f599bcf15e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -97,9 +97,14 @@ static inline void bio_iter_all_advance(const struct bio *bio,
 		((bvl = bio_iter_all_peek(bio, &iter)), true);		\
 	     bio_iter_all_advance((bio), &iter, bvl.bv_len))
 
-/*
- * drivers should _never_ use the all version - the bio may have been split
- * before it got to the driver and the driver won't own all of it
+/**
+ * bio_for_each_segment_all - iterate over single pages in a bio
+ *
+ * Like other _all versions, this is for the filesystem, or the owner/creator of
+ * a bio; it iterates over the original contents of a bio.
+ *
+ * Drivers that are working with bios that were submitted to them should not use
+ * the _all version.
  */
 #define bio_for_each_segment_all(bvl, bio, iter)			\
 	for (bvec_iter_all_init(&iter);					\
@@ -160,6 +165,13 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
 		((bvl = bio_iter_iovec((bio), (iter))), 1);		\
 	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
 
+/**
+ * bio_for_each_segment - iterate over single pages in a bio
+ *
+ * Like other non-_all versions, this iterates over what bio->bi_iter currently
+ * points to. This version is for drivers, where the bio may have previously
+ * been split or cloned.
+ */
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
@@ -200,6 +212,13 @@ static inline struct folio_seg bio_iter_iovec_folio(struct bio *bio,
 		((fs = bio_iter_iovec_folio((bio), (iter))), 1);	\
 	     bio_advance_iter_single((bio), &(iter), (fs).fs_len))
 
+/**
+ * bio_for_each_folio - iterate over folios within a bio
+ *
+ * Like other non-_all versions, this iterates over what bio->bi_iter currently
+ * points to. This version is for drivers, where the bio may have previously
+ * been split or cloned.
+ */
 #define bio_for_each_folio(fs, bio, iter)				\
 	__bio_for_each_folio(fs, bio, iter, (bio)->bi_iter)
 
@@ -209,13 +228,30 @@ static inline struct folio_seg bio_iter_iovec_folio(struct bio *bio,
 		((bvl = mp_bvec_iter_bvec((bio)->bi_io_vec, (iter))), 1); \
 	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
 
-/* iterate over multi-page bvec */
+/**
+ * bio_for_each_bvec - iterate over bvecs within a bio
+ *
+ * This version iterates over entire bio_vecs, which will be a range of
+ * contiguous pages.
+ *
+ * Like other non-_all versions, this iterates over what bio->bi_iter currently
+ * points to. This version is for drivers, where the bio may have previously
+ * been split or cloned.
+ */
 #define bio_for_each_bvec(bvl, bio, iter)			\
 	__bio_for_each_bvec(bvl, bio, iter, (bio)->bi_iter)
 
 /*
- * Iterate over all multi-page bvecs. Drivers shouldn't use this version for the
- * same reasons as bio_for_each_segment_all().
+ * bio_for_each_bvec_all - iterate over bvecs within a bio
+ *
+ * This version iterates over entire bio_vecs, which will be a range of
+ * contiguous pages.
+ *
+ * Like other _all versions, this is for the filesystem, or the owner/creator of
+ * a bio; it iterates over the original contents of a bio.
+ *
+ * Drivers that are working with bios that were submitted to them should not use
+ * the _all version.
  */
 #define bio_for_each_bvec_all(bvl, bio, i)		\
 	for (i = 0, bvl = bio_first_bvec_all(bio);	\
@@ -321,6 +357,12 @@ static inline struct folio_seg bio_folio_iter_all_peek(const struct bio *bio,
  * bio_for_each_folio_all - Iterate over each folio in a bio.
  * @fi: struct bio_folio_iter_all which is updated for each folio.
  * @bio: struct bio to iterate over.
+ *
+ * Like other _all versions, this is for the filesystem, or the owner/creator of
+ * a bio; it iterates over the original contents of a bio.
+ *
+ * Drivers that are working with bios that were submitted to them should not use
+ * the _all version.
  */
 #define bio_for_each_folio_all(fs, bio, iter)				\
 	for (bvec_iter_all_init(&iter);					\
-- 
2.40.1

