Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D0B6D7055
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjDDW52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbjDDW5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:57:25 -0400
Received: from out-56.mta1.migadu.com (out-56.mta1.migadu.com [IPv6:2001:41d0:203:375::38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8D1732
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 15:57:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680649040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITU1uGqOtQcVh452ELvaud6IOsfX9T3Hjv11PY0ioW4=;
        b=xCErnriUUq+XZ9rIv8R9hwaUynWf1BZGh1Gkd6zGyL6Yt4jyxk6GM4eV9+6vok6O11wqOX
        6bxJzlO6eGpT3/PuXnuuWxlvyFypotTv6QVDeYJSav7JKl1j8W97Yj+QkOQBAJFc7QwhVB
        HJrofe8sjbASAihnLc+RZ445v2aDIz8=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, willy@infradead.org,
        phillip@squashfs.org.uk, ming.lei@redhat.com, hch@infradead.org
Subject: [PATCH v2 2/2] block: Rework bio_for_each_folio_all()
Date:   Tue,  4 Apr 2023 18:57:09 -0400
Message-Id: <20230404225709.862208-3-kent.overstreet@linux.dev>
In-Reply-To: <20230404225709.862208-1-kent.overstreet@linux.dev>
References: <20230404225709.862208-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reimplements bio_for_each_folio_all() on top of the newly-reworked
bvec_iter_all, and since it's now trivial we also provide
bio_for_each_folio.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/iomap/buffered-io.c |  14 +++---
 include/linux/bio.h    | 105 +++++++++++++++++++++++------------------
 include/linux/bvec.h   |  15 ++++--
 3 files changed, 78 insertions(+), 56 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 356193e44c..b1787795ce 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -187,10 +187,11 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 static void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_seg fv;
 
-	bio_for_each_folio_all(fi, bio)
-		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
+	bio_for_each_folio_all(fv, bio, iter)
+		iomap_finish_folio_read(fv.fv_folio, fv.fv_offset, fv.fv_len, error);
 	bio_put(bio);
 }
 
@@ -1299,7 +1300,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	u32 folio_count = 0;
 
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
-		struct folio_iter fi;
+		struct bvec_iter_all iter;
+		struct folio_seg fv;
 
 		/*
 		 * For the last bio, bi_private points to the ioend, so we
@@ -1311,8 +1313,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 			next = bio->bi_private;
 
 		/* walk all folios in bio, ending page IO on them */
-		bio_for_each_folio_all(fi, bio) {
-			iomap_finish_folio_write(inode, fi.folio, fi.length,
+		bio_for_each_folio_all(fv, bio, iter) {
+			iomap_finish_folio_write(inode, fv.fv_folio, fv.fv_len,
 					error);
 			folio_count++;
 		}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 97180f052b..3294a35736 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -170,6 +170,49 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
+struct folio_seg {
+	struct folio	*fv_folio;
+	size_t		fv_offset;
+	size_t		fv_len;
+};
+
+static inline struct folio_seg biovec_to_folioseg(struct bio_vec bv)
+{
+
+	struct folio *folio	= page_folio(bv.bv_page);
+	size_t offset		= (folio_page_idx(folio, bv.bv_page) << PAGE_SHIFT) +
+		bv.bv_offset;
+	size_t len = min_t(size_t, folio_size(folio) - offset, bv.bv_len);
+
+	return (struct folio_seg) {
+		.fv_folio	= folio,
+		.fv_offset	= offset,
+		.fv_len		= len,
+	};
+}
+
+static inline struct folio_seg bio_iter_iovec_folio(struct bio *bio,
+						    struct bvec_iter iter)
+{
+	return biovec_to_folioseg(bio_iter_iovec(bio, iter));
+}
+
+#define __bio_for_each_folio(bvl, bio, iter, start)			\
+	for (iter = (start);						\
+	     (iter).bi_size &&						\
+		((bvl = bio_iter_iovec_folio((bio), (iter))), 1);	\
+	     bio_advance_iter_single((bio), &(iter), (bvl).fv_len))
+
+/**
+ * bio_for_each_folio - Iterate over each folio in a bio.
+ *
+ * @fv: struct folio_seg which is returned at each loop iteration
+ * @bio: struct bio to iterate over.
+ * @iter: struct bvec_iter: internal iterator state
+ */
+#define bio_for_each_folio(bvl, bio, iter)				\
+	__bio_for_each_folio(bvl, bio, iter, (bio)->bi_iter)
+
 #define __bio_for_each_bvec(bvl, bio, iter, start)		\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
@@ -278,59 +321,27 @@ static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
 	return &bio->bi_io_vec[bio->bi_vcnt - 1];
 }
 
-/**
- * struct folio_iter - State for iterating all folios in a bio.
- * @folio: The current folio we're iterating.  NULL after the last folio.
- * @offset: The byte offset within the current folio.
- * @length: The number of bytes in this iteration (will not cross folio
- *	boundary).
- */
-struct folio_iter {
-	struct folio *folio;
-	size_t offset;
-	size_t length;
-	/* private: for use by the iterator */
-	struct folio *_next;
-	size_t _seg_count;
-	int _i;
-};
-
-static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
-				   int i)
+static inline struct folio_seg bio_folio_iter_all_peek(const struct bio *bio,
+						       const struct bvec_iter_all *iter)
 {
-	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
-
-	fi->folio = page_folio(bvec->bv_page);
-	fi->offset = bvec->bv_offset +
-			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
-	fi->_seg_count = bvec->bv_len;
-	fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
-	fi->_next = folio_next(fi->folio);
-	fi->_i = i;
-}
-
-static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
-{
-	fi->_seg_count -= fi->length;
-	if (fi->_seg_count) {
-		fi->folio = fi->_next;
-		fi->offset = 0;
-		fi->length = min(folio_size(fi->folio), fi->_seg_count);
-		fi->_next = folio_next(fi->folio);
-	} else if (fi->_i + 1 < bio->bi_vcnt) {
-		bio_first_folio(fi, bio, fi->_i + 1);
-	} else {
-		fi->folio = NULL;
-	}
+	return biovec_to_folioseg(__bvec_iter_all_peek(bio->bi_io_vec, iter));
 }
 
 /**
- * bio_for_each_folio_all - Iterate over each folio in a bio.
- * @fi: struct folio_iter which is updated for each folio.
+ * bio_for_each_folio_all - Iterate over each folio in a bio
+ *
+ * As with other _all variants, safe to use after submission and completion,
+ * iterates over all folios in original bio as constructed by filesystem
+ *
+ * @fv: struct folio_seg which is returned at each loop iteration
  * @bio: struct bio to iterate over.
+ * @iter: struct bvec_iter_all: internal iterator state
  */
-#define bio_for_each_folio_all(fi, bio)				\
-	for (bio_first_folio(&fi, bio, 0); fi.folio; bio_next_folio(&fi, bio))
+#define bio_for_each_folio_all(fv, bio, iter)				\
+	for (bvec_iter_all_init(&iter);					\
+	     iter.idx < bio->bi_vcnt &&					\
+		((fv = bio_folio_iter_all_peek(bio, &iter)), true);	\
+	     bio_iter_all_advance((bio), &iter, fv.fv_len))
 
 enum bip_flags {
 	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 12f0e073c0..c21a26445e 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -166,18 +166,27 @@ static inline void bvec_iter_all_init(struct bvec_iter_all *iter_all)
 	iter_all->idx = 0;
 }
 
-static inline struct bio_vec bvec_iter_all_peek(const struct bio_vec *bvec,
-						struct bvec_iter_all *iter)
+static inline struct bio_vec __bvec_iter_all_peek(const struct bio_vec *bvec,
+						  const struct bvec_iter_all *iter)
 {
 	struct bio_vec bv = bvec[iter->idx];
 
+	BUG_ON(iter->done >= bv.bv_len);
+
 	bv.bv_offset	+= iter->done;
 	bv.bv_len	-= iter->done;
 
 	bv.bv_page	+= bv.bv_offset >> PAGE_SHIFT;
 	bv.bv_offset	&= ~PAGE_MASK;
-	bv.bv_len	= min_t(unsigned, PAGE_SIZE - bv.bv_offset, bv.bv_len);
+	return bv;
+}
+
+static inline struct bio_vec bvec_iter_all_peek(const struct bio_vec *bvec,
+						const struct bvec_iter_all *iter)
+{
+	struct bio_vec bv = __bvec_iter_all_peek(bvec, iter);
 
+	bv.bv_len = min_t(unsigned, PAGE_SIZE - bv.bv_offset, bv.bv_len);
 	return bv;
 }
 
-- 
2.40.0

