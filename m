Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA6A72323C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjFEV1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjFEV1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:27:36 -0400
Received: from out-26.mta0.migadu.com (out-26.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC48DFD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:27:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686000450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBUPx7icTiPf4Wr5wpgmuIbukMFrf9AG0c4/Eq3Swy8=;
        b=krPBhL7yUptwwBNLBoAR9pb37Q4V1E2p+jRnrLz2PeqM2A5dAa/oEhiRhMjCmsAWoXRiTk
        s5394WNxAAGIBh+suRQd+QUwzTFFN/nRzwHfNFLulymLC+mjUtSUWr6F1bLag9NUJ83E9k
        tL3UOBk/vRjmrEfoqX4mkz7fLU63/L8=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 2/5] block: Rework bio_for_each_folio_all()
Date:   Mon,  5 Jun 2023 17:27:14 -0400
Message-Id: <20230605212717.2570570-2-kent.overstreet@linux.dev>
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

This reimplements bio_for_each_folio_all() on top of the newly-reworked
bvec_iter_all, and since it's now trivial we also provide
bio_for_each_folio.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/crypto/bio.c        |  9 ++--
 fs/ext4/page-io.c      | 11 ++---
 fs/ext4/readpage.c     |  7 ++--
 fs/iomap/buffered-io.c | 14 ++++---
 fs/mpage.c             | 22 +++++-----
 fs/verity/verify.c     |  9 ++--
 include/linux/bio.h    | 95 ++++++++++++++++++++++--------------------
 include/linux/bvec.h   | 13 ++++--
 8 files changed, 99 insertions(+), 81 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 62e1a3dd83..4fed8d175c 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -30,11 +30,12 @@
  */
 bool fscrypt_decrypt_bio(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_seg fs;
 
-	bio_for_each_folio_all(fi, bio) {
-		int err = fscrypt_decrypt_pagecache_blocks(fi.folio, fi.length,
-							   fi.offset);
+	bio_for_each_folio_all(fs, bio, iter) {
+		int err = fscrypt_decrypt_pagecache_blocks(fs.fs_folio, fs.fs_len,
+							   fs.fs_offset);
 
 		if (err) {
 			bio->bi_status = errno_to_blk_status(err);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 3621f29ec6..4c2fa805b3 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -99,14 +99,15 @@ static void buffer_io_error(struct buffer_head *bh)
 
 static void ext4_finish_bio(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_seg fs;
 
-	bio_for_each_folio_all(fi, bio) {
-		struct folio *folio = fi.folio;
+	bio_for_each_folio_all(fs, bio, iter) {
+		struct folio *folio = fs.fs_folio;
 		struct folio *io_folio = NULL;
 		struct buffer_head *bh, *head;
-		size_t bio_start = fi.offset;
-		size_t bio_end = bio_start + fi.length;
+		size_t bio_start = fs.fs_offset;
+		size_t bio_end = bio_start + fs.fs_len;
 		unsigned under_io = 0;
 		unsigned long flags;
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 6f46823fba..8aa560d61c 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -68,10 +68,11 @@ struct bio_post_read_ctx {
 
 static void __read_end_io(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_seg fs;
 
-	bio_for_each_folio_all(fi, bio) {
-		struct folio *folio = fi.folio;
+	bio_for_each_folio_all(fs, bio, iter) {
+		struct folio *folio = fs.fs_folio;
 
 		if (bio->bi_status)
 			folio_clear_uptodate(folio);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77..43956529cb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -187,10 +187,11 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 static void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_seg fs;
 
-	bio_for_each_folio_all(fi, bio)
-		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
+	bio_for_each_folio_all(fs, bio, iter)
+		iomap_finish_folio_read(fs.fs_folio, fs.fs_offset, fs.fs_len, error);
 	bio_put(bio);
 }
 
@@ -1321,7 +1322,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	u32 folio_count = 0;
 
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
-		struct folio_iter fi;
+		struct bvec_iter_all iter;
+		struct folio_seg fs;
 
 		/*
 		 * For the last bio, bi_private points to the ioend, so we
@@ -1333,8 +1335,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 			next = bio->bi_private;
 
 		/* walk all folios in bio, ending page IO on them */
-		bio_for_each_folio_all(fi, bio) {
-			iomap_finish_folio_write(inode, fi.folio, fi.length,
+		bio_for_each_folio_all(fs, bio, iter) {
+			iomap_finish_folio_write(inode, fs.fs_folio, fs.fs_len,
 					error);
 			folio_count++;
 		}
diff --git a/fs/mpage.c b/fs/mpage.c
index 242e213ee0..7da2c80f71 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -45,15 +45,16 @@
  */
 static void mpage_read_end_io(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_seg fs;
 	int err = blk_status_to_errno(bio->bi_status);
 
-	bio_for_each_folio_all(fi, bio) {
+	bio_for_each_folio_all(fs, bio, iter) {
 		if (err)
-			folio_set_error(fi.folio);
+			folio_set_error(fs.fs_folio);
 		else
-			folio_mark_uptodate(fi.folio);
-		folio_unlock(fi.folio);
+			folio_mark_uptodate(fs.fs_folio);
+		folio_unlock(fs.fs_folio);
 	}
 
 	bio_put(bio);
@@ -61,15 +62,16 @@ static void mpage_read_end_io(struct bio *bio)
 
 static void mpage_write_end_io(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_seg fs;
 	int err = blk_status_to_errno(bio->bi_status);
 
-	bio_for_each_folio_all(fi, bio) {
+	bio_for_each_folio_all(fs, bio, iter) {
 		if (err) {
-			folio_set_error(fi.folio);
-			mapping_set_error(fi.folio->mapping, err);
+			folio_set_error(fs.fs_folio);
+			mapping_set_error(fs.fs_folio->mapping, err);
 		}
-		folio_end_writeback(fi.folio);
+		folio_end_writeback(fs.fs_folio);
 	}
 
 	bio_put(bio);
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index e250822275..29ebca1006 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -340,7 +340,8 @@ void fsverity_verify_bio(struct bio *bio)
 	struct inode *inode = bio_first_page_all(bio)->mapping->host;
 	struct fsverity_info *vi = inode->i_verity_info;
 	struct ahash_request *req;
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_seg fs;
 	unsigned long max_ra_pages = 0;
 
 	/* This allocation never fails, since it's mempool-backed. */
@@ -359,9 +360,9 @@ void fsverity_verify_bio(struct bio *bio)
 		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
 	}
 
-	bio_for_each_folio_all(fi, bio) {
-		if (!verify_data_blocks(inode, vi, req, fi.folio, fi.length,
-					fi.offset, max_ra_pages)) {
+	bio_for_each_folio_all(fs, bio, iter) {
+		if (!verify_data_blocks(inode, vi, req, fs.fs_folio, fs.fs_len,
+					fs.fs_offset, max_ra_pages)) {
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 39d8a1cc6e..4b197ea83c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -163,6 +163,46 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
+struct folio_seg {
+	struct folio	*fs_folio;
+	size_t		fs_offset;
+	size_t		fs_len;
+};
+
+/*
+ * Returns the initial portion of @bv that points to a single folio (or all of
+ * @bv, if it pointsn to a single folio)
+ */
+static inline struct folio_seg biovec_to_folioseg(struct bio_vec bv)
+{
+
+	struct folio *folio	= page_folio(bv.bv_page);
+	size_t offset		= (folio_page_idx(folio, bv.bv_page) << PAGE_SHIFT) +
+		bv.bv_offset;
+	size_t len = min_t(size_t, folio_size(folio) - offset, bv.bv_len);
+
+	return (struct folio_seg) {
+		.fs_folio	= folio,
+		.fs_offset	= offset,
+		.fs_len		= len,
+	};
+}
+
+static inline struct folio_seg bio_iter_iovec_folio(struct bio *bio,
+						    struct bvec_iter iter)
+{
+	return biovec_to_folioseg(bio_iter_iovec(bio, iter));
+}
+
+#define __bio_for_each_folio(fs, bio, iter, start)			\
+	for (iter = (start);						\
+	     (iter).bi_size &&						\
+		((fs = bio_iter_iovec_folio((bio), (iter))), 1);	\
+	     bio_advance_iter_single((bio), &(iter), (fs).fs_len))
+
+#define bio_for_each_folio(fs, bio, iter)				\
+	__bio_for_each_folio(fs, bio, iter, (bio)->bi_iter)
+
 #define __bio_for_each_bvec(bvl, bio, iter, start)		\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
@@ -271,59 +311,22 @@ static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
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
  * bio_for_each_folio_all - Iterate over each folio in a bio.
- * @fi: struct folio_iter which is updated for each folio.
+ * @fi: struct bio_folio_iter_all which is updated for each folio.
  * @bio: struct bio to iterate over.
  */
-#define bio_for_each_folio_all(fi, bio)				\
-	for (bio_first_folio(&fi, bio, 0); fi.folio; bio_next_folio(&fi, bio))
+#define bio_for_each_folio_all(fs, bio, iter)				\
+	for (bvec_iter_all_init(&iter);					\
+	     iter.idx < bio->bi_vcnt &&					\
+		((fs = bio_folio_iter_all_peek(bio, &iter)), true);	\
+	     bio_iter_all_advance((bio), &iter, fs.fs_len))
 
 enum bip_flags {
 	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 635fb54143..ebf8b612ba 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -205,8 +205,8 @@ static inline void bvec_iter_all_init(struct bvec_iter_all *iter_all)
 	iter_all->idx = 0;
 }
 
-static inline struct bio_vec bvec_iter_all_peek(const struct bio_vec *bvec,
-						struct bvec_iter_all *iter)
+static inline struct bio_vec __bvec_iter_all_peek(const struct bio_vec *bvec,
+						  const struct bvec_iter_all *iter)
 {
 	struct bio_vec bv = bvec[iter->idx];
 
@@ -215,8 +215,15 @@ static inline struct bio_vec bvec_iter_all_peek(const struct bio_vec *bvec,
 
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
2.40.1

