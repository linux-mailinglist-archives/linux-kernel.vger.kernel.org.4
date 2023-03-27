Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF9A6CAC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjC0Ro0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjC0RoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:44:19 -0400
Received: from out-13.mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BEB199E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:44:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679939053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BsEUbP/OeIjmK6tZrRWYo4fhiTFDJfTPL+qUDS3/tW0=;
        b=NKhtzBRT+ZR/buXbf1sWKyZ7/BLjp2zxLVG5zaZIWb4uM2k+amjegX0no0rJG5ppO8TPtS
        9QnKCF0RGGcGP63lUJLAw2VxJOsMSrpla2lz0cv/62nhjSptfOLcvcZW19nCQ9CiNstRp6
        EfjO7mckJG/YieBMcd5wAnjvUzg8Wco=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, willy@infradead.org,
        axboe@kernel.dk, Ming Lei <ming.lei@redhat.com>,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 1/2] block: Rework bio_for_each_segment_all()
Date:   Mon, 27 Mar 2023 13:44:01 -0400
Message-Id: <20230327174402.1655365-2-kent.overstreet@linux.dev>
In-Reply-To: <20230327174402.1655365-1-kent.overstreet@linux.dev>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
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

This patch reworks bio_for_each_segment_all() to be more inline with how
the other bio iterators work:

 - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
   one in the iterator and pass a pointer to it - bad. This way makes it
   clearer what's a constructed value vs. a reference to something
   pre-existing, and it also will help with cleaning up and
   consolidating code with bio_for_each_folio_all().

 - We now provide bio_for_each_segment_all_continue(), for squashfs:
   this makes their code clearer.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Phillip Lougher <phillip@squashfs.org.uk>
---
 block/bio.c               | 38 ++++++++++++------------
 block/blk-map.c           | 38 ++++++++++++------------
 block/bounce.c            | 12 ++++----
 drivers/md/bcache/btree.c |  8 ++---
 drivers/md/dm-crypt.c     | 10 +++----
 drivers/md/raid1.c        |  4 +--
 fs/btrfs/disk-io.c        | 10 +++----
 fs/btrfs/extent_io.c      | 52 ++++++++++++++++-----------------
 fs/btrfs/inode.c          |  8 ++---
 fs/btrfs/raid56.c         | 18 ++++++------
 fs/crypto/bio.c           |  8 ++---
 fs/erofs/zdata.c          |  4 +--
 fs/ext4/page-io.c         |  8 ++---
 fs/ext4/readpage.c        |  4 +--
 fs/f2fs/data.c            | 20 ++++++-------
 fs/gfs2/lops.c            | 10 +++----
 fs/gfs2/meta_io.c         |  8 ++---
 fs/mpage.c                |  4 +--
 fs/squashfs/block.c       | 48 ++++++++++++++++--------------
 fs/squashfs/lz4_wrapper.c | 17 ++++++-----
 fs/squashfs/lzo_wrapper.c | 17 ++++++-----
 fs/verity/verify.c        |  4 +--
 include/linux/bio.h       | 31 +++++++++++++++-----
 include/linux/bvec.h      | 61 ++++++++++++++++++++++-----------------
 24 files changed, 239 insertions(+), 203 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ab59a491a8..8d3abe249e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1170,13 +1170,13 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	struct bvec_iter_all iter_all;
-	struct bio_vec *bvec;
+	struct bvec_iter_all iter;
+	struct bio_vec bvec;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (mark_dirty && !PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+	bio_for_each_segment_all(bvec, bio, iter) {
+		if (mark_dirty && !PageCompound(bvec.bv_page))
+			set_page_dirty_lock(bvec.bv_page);
+		put_page(bvec.bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1441,11 +1441,11 @@ EXPORT_SYMBOL(bio_copy_data);
 
 void bio_free_pages(struct bio *bio)
 {
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct bvec_iter_all iter;
+	struct bio_vec bvec;
 
-	bio_for_each_segment_all(bvec, bio, iter_all)
-		__free_page(bvec->bv_page);
+	bio_for_each_segment_all(bvec, bio, iter)
+		__free_page(bvec.bv_page);
 }
 EXPORT_SYMBOL(bio_free_pages);
 
@@ -1480,12 +1480,12 @@ EXPORT_SYMBOL(bio_free_pages);
  */
 void bio_set_pages_dirty(struct bio *bio)
 {
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct bvec_iter_all iter;
+	struct bio_vec bvec;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
+	bio_for_each_segment_all(bvec, bio, iter) {
+		if (!PageCompound(bvec.bv_page))
+			set_page_dirty_lock(bvec.bv_page);
 	}
 }
 
@@ -1528,12 +1528,12 @@ static void bio_dirty_fn(struct work_struct *work)
 
 void bio_check_pages_dirty(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct bvec_iter_all iter;
+	struct bio_vec bvec;
 	unsigned long flags;
-	struct bvec_iter_all iter_all;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+	bio_for_each_segment_all(bvec, bio, iter) {
+		if (!PageDirty(bvec.bv_page) && !PageCompound(bvec.bv_page))
 			goto defer;
 	}
 
diff --git a/block/blk-map.c b/block/blk-map.c
index 19940c978c..1daac7370a 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -45,21 +45,21 @@ static struct bio_map_data *bio_alloc_map_data(struct iov_iter *data,
  */
 static int bio_copy_from_iter(struct bio *bio, struct iov_iter *iter)
 {
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct bvec_iter_all bv_iter;
+	struct bio_vec bvec;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
+	bio_for_each_segment_all(bvec, bio, bv_iter) {
 		ssize_t ret;
 
-		ret = copy_page_from_iter(bvec->bv_page,
-					  bvec->bv_offset,
-					  bvec->bv_len,
+		ret = copy_page_from_iter(bvec.bv_page,
+					  bvec.bv_offset,
+					  bvec.bv_len,
 					  iter);
 
 		if (!iov_iter_count(iter))
 			break;
 
-		if (ret < bvec->bv_len)
+		if (ret < bvec.bv_len)
 			return -EFAULT;
 	}
 
@@ -76,21 +76,21 @@ static int bio_copy_from_iter(struct bio *bio, struct iov_iter *iter)
  */
 static int bio_copy_to_iter(struct bio *bio, struct iov_iter iter)
 {
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct bvec_iter_all bv_iter;
+	struct bio_vec bvec;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
+	bio_for_each_segment_all(bvec, bio, bv_iter) {
 		ssize_t ret;
 
-		ret = copy_page_to_iter(bvec->bv_page,
-					bvec->bv_offset,
-					bvec->bv_len,
+		ret = copy_page_to_iter(bvec.bv_page,
+					bvec.bv_offset,
+					bvec.bv_len,
 					&iter);
 
 		if (!iov_iter_count(&iter))
 			break;
 
-		if (ret < bvec->bv_len)
+		if (ret < bvec.bv_len)
 			return -EFAULT;
 	}
 
@@ -443,12 +443,12 @@ static void bio_copy_kern_endio(struct bio *bio)
 static void bio_copy_kern_endio_read(struct bio *bio)
 {
 	char *p = bio->bi_private;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct bvec_iter_all iter;
+	struct bio_vec bvec;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		memcpy_from_bvec(p, bvec);
-		p += bvec->bv_len;
+	bio_for_each_segment_all(bvec, bio, iter) {
+		memcpy_from_bvec(p, &bvec);
+		p += bvec.bv_len;
 	}
 
 	bio_copy_kern_endio(bio);
diff --git a/block/bounce.c b/block/bounce.c
index 7cfcb242f9..e701832d76 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -102,18 +102,18 @@ static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
 static void bounce_end_io(struct bio *bio)
 {
 	struct bio *bio_orig = bio->bi_private;
-	struct bio_vec *bvec, orig_vec;
+	struct bio_vec bvec, orig_vec;
 	struct bvec_iter orig_iter = bio_orig->bi_iter;
-	struct bvec_iter_all iter_all;
+	struct bvec_iter_all iter;
 
 	/*
 	 * free up bounce indirect pages used
 	 */
-	bio_for_each_segment_all(bvec, bio, iter_all) {
+	bio_for_each_segment_all(bvec, bio, iter) {
 		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
-		if (bvec->bv_page != orig_vec.bv_page) {
-			dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
-			mempool_free(bvec->bv_page, &page_pool);
+		if (bvec.bv_page != orig_vec.bv_page) {
+			dec_zone_page_state(bvec.bv_page, NR_BOUNCE);
+			mempool_free(bvec.bv_page, &page_pool);
 		}
 		bio_advance_iter(bio_orig, &orig_iter, orig_vec.bv_len);
 	}
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 147c493a98..98ce12b239 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -373,12 +373,12 @@ static void do_btree_node_write(struct btree *b)
 		       bset_sector_offset(&b->keys, i));
 
 	if (!bch_bio_alloc_pages(b->bio, __GFP_NOWARN|GFP_NOWAIT)) {
-		struct bio_vec *bv;
+		struct bio_vec bv;
 		void *addr = (void *) ((unsigned long) i & ~(PAGE_SIZE - 1));
-		struct bvec_iter_all iter_all;
+		struct bvec_iter_all iter;
 
-		bio_for_each_segment_all(bv, b->bio, iter_all) {
-			memcpy(page_address(bv->bv_page), addr, PAGE_SIZE);
+		bio_for_each_segment_all(bv, b->bio, iter) {
+			memcpy(page_address(bv.bv_page), addr, PAGE_SIZE);
 			addr += PAGE_SIZE;
 		}
 
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 2653516bcd..48798c63e6 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1709,12 +1709,12 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
 
 static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
 {
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
+	struct bvec_iter_all iter;
+	struct bio_vec bv;
 
-	bio_for_each_segment_all(bv, clone, iter_all) {
-		BUG_ON(!bv->bv_page);
-		mempool_free(bv->bv_page, &cc->page_pool);
+	bio_for_each_segment_all(bv, clone, iter) {
+		BUG_ON(!bv.bv_page);
+		mempool_free(bv.bv_page, &cc->page_pool);
 	}
 }
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d998..4f58cae37e 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2188,7 +2188,7 @@ static void process_checks(struct r1bio *r1_bio)
 		blk_status_t status = sbio->bi_status;
 		struct page **ppages = get_resync_pages(pbio)->pages;
 		struct page **spages = get_resync_pages(sbio)->pages;
-		struct bio_vec *bi;
+		struct bio_vec bi;
 		int page_len[RESYNC_PAGES] = { 0 };
 		struct bvec_iter_all iter_all;
 
@@ -2198,7 +2198,7 @@ static void process_checks(struct r1bio *r1_bio)
 		sbio->bi_status = 0;
 
 		bio_for_each_segment_all(bi, sbio, iter_all)
-			page_len[j++] = bi->bv_len;
+			page_len[j++] = bi.bv_len;
 
 		if (!status) {
 			for (j = vcnt; j-- ; ) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3aa0422431..72f3d38cfb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -798,15 +798,15 @@ bool btrfs_wq_submit_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_
 
 static blk_status_t btree_csum_one_bio(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct btrfs_root *root;
 	int ret = 0;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
-		ret = csum_dirty_buffer(root->fs_info, bvec);
+		root = BTRFS_I(bvec.bv_page->mapping->host)->root;
+		ret = csum_dirty_buffer(root->fs_info, &bvec);
 		if (ret)
 			break;
 	}
@@ -3970,12 +3970,12 @@ ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 static void btrfs_end_super_write(struct bio *bio)
 {
 	struct btrfs_device *device = bio->bi_private;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 	struct page *page;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		page = bvec->bv_page;
+		page = bvec.bv_page;
 
 		if (bio->bi_status) {
 			btrfs_warn_rl_in_rcu(device->fs_info,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3bbf8703db..6a6573a88b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -915,7 +915,7 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 {
 	struct bio *bio = &bbio->bio;
 	int error = blk_status_to_errno(bio->bi_status);
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	u64 start;
 	u64 end;
 	struct bvec_iter_all iter_all;
@@ -923,23 +923,23 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+		struct page *page = bvec.bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
 
 		/* Our read/write should always be sector aligned. */
-		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
+		if (!IS_ALIGNED(bvec.bv_offset, sectorsize))
 			btrfs_err(fs_info,
 		"partial page write in btrfs with offset %u and length %u",
-				  bvec->bv_offset, bvec->bv_len);
-		else if (!IS_ALIGNED(bvec->bv_len, sectorsize))
+				  bvec.bv_offset, bvec.bv_len);
+		else if (!IS_ALIGNED(bvec.bv_len, sectorsize))
 			btrfs_info(fs_info,
 		"incomplete page write with offset %u and length %u",
-				   bvec->bv_offset, bvec->bv_len);
+				   bvec.bv_offset, bvec.bv_len);
 
-		start = page_offset(page) + bvec->bv_offset;
-		end = start + bvec->bv_len - 1;
+		start = page_offset(page) + bvec.bv_offset;
+		end = start + bvec.bv_len - 1;
 
 		if (first_bvec) {
 			btrfs_record_physical_zoned(inode, start, bio);
@@ -948,7 +948,7 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 
 		end_extent_writepage(page, error, start, end);
 
-		btrfs_page_clear_writeback(fs_info, page, start, bvec->bv_len);
+		btrfs_page_clear_writeback(fs_info, page, start, bvec.bv_len);
 	}
 
 	bio_put(bio);
@@ -1076,7 +1076,7 @@ static struct extent_buffer *find_extent_buffer_readpage(
 static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 {
 	struct bio *bio = &bbio->bio;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct processed_extent processed = { 0 };
 	/*
 	 * The offset to the beginning of a bio, since one bio can never be
@@ -1089,7 +1089,7 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		bool uptodate = !bio->bi_status;
-		struct page *page = bvec->bv_page;
+		struct page *page = bvec.bv_page;
 		struct inode *inode = page->mapping->host;
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
@@ -1111,19 +1111,19 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 		 * for unaligned offsets, and an error if they don't add up to
 		 * a full sector.
 		 */
-		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
+		if (!IS_ALIGNED(bvec.bv_offset, sectorsize))
 			btrfs_err(fs_info,
 		"partial page read in btrfs with offset %u and length %u",
-				  bvec->bv_offset, bvec->bv_len);
-		else if (!IS_ALIGNED(bvec->bv_offset + bvec->bv_len,
+				  bvec.bv_offset, bvec.bv_len);
+		else if (!IS_ALIGNED(bvec.bv_offset + bvec.bv_len,
 				     sectorsize))
 			btrfs_info(fs_info,
 		"incomplete page read with offset %u and length %u",
-				   bvec->bv_offset, bvec->bv_len);
+				   bvec.bv_offset, bvec.bv_len);
 
-		start = page_offset(page) + bvec->bv_offset;
-		end = start + bvec->bv_len - 1;
-		len = bvec->bv_len;
+		start = page_offset(page) + bvec.bv_offset;
+		end = start + bvec.bv_len - 1;
+		len = bvec.bv_len;
 
 		mirror = bbio->mirror_num;
 		if (likely(uptodate)) {
@@ -1187,7 +1187,7 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
 			 * submit_data_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
 			 */
-			submit_data_read_repair(inode, bbio, bio_offset, bvec,
+			submit_data_read_repair(inode, bbio, bio_offset, &bvec,
 						error_bitmap);
 		} else {
 			/* Update page status and unlock */
@@ -2450,7 +2450,7 @@ static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
 {
 	struct bio *bio = &bbio->bio;
 	struct btrfs_fs_info *fs_info;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 
 	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
@@ -2458,12 +2458,12 @@ static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-		u64 bvec_start = page_offset(page) + bvec->bv_offset;
-		u64 bvec_end = bvec_start + bvec->bv_len - 1;
+		struct page *page = bvec.bv_page;
+		u64 bvec_start = page_offset(page) + bvec.bv_offset;
+		u64 bvec_end = bvec_start + bvec.bv_len - 1;
 		u64 cur_bytenr = bvec_start;
 
-		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
+		ASSERT(IS_ALIGNED(bvec.bv_len, fs_info->nodesize));
 
 		/* Iterate through all extent buffers in the range */
 		while (cur_bytenr <= bvec_end) {
@@ -2507,14 +2507,14 @@ static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
 static void end_bio_extent_buffer_writepage(struct btrfs_bio *bbio)
 {
 	struct bio *bio = &bbio->bio;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct extent_buffer *eb;
 	int done;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+		struct page *page = bvec.bv_page;
 
 		eb = (struct extent_buffer *)page->private;
 		BUG_ON(!eb);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 98a800b8bd..aa2fa925de 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10317,7 +10317,7 @@ static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
 	struct btrfs_inode *inode = priv->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u32 sectorsize = fs_info->sectorsize;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 	u32 bio_offset = 0;
 
@@ -10327,12 +10327,12 @@ static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
 	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
 		unsigned int i, nr_sectors, pgoff;
 
-		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
-		pgoff = bvec->bv_offset;
+		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
+		pgoff = bvec.bv_offset;
 		for (i = 0; i < nr_sectors; i++) {
 			ASSERT(pgoff < PAGE_SIZE);
 			if (btrfs_check_data_csum(inode, bbio, bio_offset,
-					    bvec->bv_page, pgoff))
+					    bvec.bv_page, pgoff))
 				return BLK_STS_IOERR;
 			bio_offset += sectorsize;
 			pgoff += sectorsize;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ff4b1d5837..de30399348 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1382,7 +1382,7 @@ static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
 static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
@@ -1391,9 +1391,9 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
 		struct sector_ptr *sector;
 		int pgoff;
 
-		for (pgoff = bvec->bv_offset; pgoff - bvec->bv_offset < bvec->bv_len;
+		for (pgoff = bvec.bv_offset; pgoff - bvec.bv_offset < bvec.bv_len;
 		     pgoff += sectorsize) {
-			sector = find_stripe_sector(rbio, bvec->bv_page, pgoff);
+			sector = find_stripe_sector(rbio, bvec.bv_page, pgoff);
 			ASSERT(sector);
 			if (sector)
 				sector->uptodate = 1;
@@ -1424,12 +1424,12 @@ static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio, struct bio *bi
 {
 	int total_sector_nr = get_bio_sector_nr(rbio, bio);
 	u32 bio_size = 0;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 	int i;
 
 	bio_for_each_segment_all(bvec, bio, iter_all)
-		bio_size += bvec->bv_len;
+		bio_size += bvec.bv_len;
 
 	/*
 	 * Since we can have multiple bios touching the error_bitmap, we cannot
@@ -1448,7 +1448,7 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	int total_sector_nr = get_bio_sector_nr(rbio, bio);
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 
 	/* No data csum for the whole stripe, no need to verify. */
@@ -1462,8 +1462,8 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		int bv_offset;
 
-		for (bv_offset = bvec->bv_offset;
-		     bv_offset < bvec->bv_offset + bvec->bv_len;
+		for (bv_offset = bvec.bv_offset;
+		     bv_offset < bvec.bv_offset + bvec.bv_len;
 		     bv_offset += fs_info->sectorsize, total_sector_nr++) {
 			u8 csum_buf[BTRFS_CSUM_SIZE];
 			u8 *expected_csum = rbio->csum_buf +
@@ -1474,7 +1474,7 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 			if (!test_bit(total_sector_nr, rbio->csum_bitmap))
 				continue;
 
-			ret = btrfs_check_sector_csum(fs_info, bvec->bv_page,
+			ret = btrfs_check_sector_csum(fs_info, bvec.bv_page,
 				bv_offset, csum_buf, expected_csum);
 			if (ret < 0)
 				set_bit(total_sector_nr, rbio->error_bitmap);
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 1b4403136d..d4990cf44c 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -30,13 +30,13 @@
  */
 bool fscrypt_decrypt_bio(struct bio *bio)
 {
-	struct bio_vec *bv;
+	struct bio_vec bv;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
-		int err = fscrypt_decrypt_pagecache_blocks(page, bv->bv_len,
-							   bv->bv_offset);
+		struct page *page = bv.bv_page;
+		int err = fscrypt_decrypt_pagecache_blocks(page, bv.bv_len,
+							   bv.bv_offset);
 
 		if (err) {
 			bio->bi_status = errno_to_blk_status(err);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5200bb86e2..1f077210a3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1364,11 +1364,11 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
 	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
 	blk_status_t err = bio->bi_status;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+		struct page *page = bvec.bv_page;
 
 		DBG_BUGON(PageUptodate(page));
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index beaec6d810..e7176a0420 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -99,15 +99,15 @@ static void buffer_io_error(struct buffer_head *bh)
 
 static void ext4_finish_bio(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+		struct page *page = bvec.bv_page;
 		struct page *bounce_page = NULL;
 		struct buffer_head *bh, *head;
-		unsigned bio_start = bvec->bv_offset;
-		unsigned bio_end = bio_start + bvec->bv_len;
+		unsigned bio_start = bvec.bv_offset;
+		unsigned bio_end = bio_start + bvec.bv_len;
 		unsigned under_io = 0;
 		unsigned long flags;
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index d5266932ce..616c57ba8b 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -69,11 +69,11 @@ struct bio_post_read_ctx {
 static void __read_end_io(struct bio *bio)
 {
 	struct page *page;
-	struct bio_vec *bv;
+	struct bio_vec bv;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bv, bio, iter_all) {
-		page = bv->bv_page;
+		page = bv.bv_page;
 
 		if (bio->bi_status)
 			ClearPageUptodate(page);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 97e816590c..eb628f7557 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -139,12 +139,12 @@ struct bio_post_read_ctx {
  */
 static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 {
-	struct bio_vec *bv;
+	struct bio_vec bv;
 	struct bvec_iter_all iter_all;
 	struct bio_post_read_ctx *ctx = bio->bi_private;
 
 	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
+		struct page *page = bv.bv_page;
 
 		if (f2fs_is_compressed_page(page)) {
 			if (ctx && !ctx->decompression_attempted)
@@ -189,11 +189,11 @@ static void f2fs_verify_bio(struct work_struct *work)
 	 * as those were handled separately by f2fs_end_read_compressed_page().
 	 */
 	if (may_have_compressed_pages) {
-		struct bio_vec *bv;
+		struct bio_vec bv;
 		struct bvec_iter_all iter_all;
 
 		bio_for_each_segment_all(bv, bio, iter_all) {
-			struct page *page = bv->bv_page;
+			struct page *page = bv.bv_page;
 
 			if (!f2fs_is_compressed_page(page) &&
 			    !fsverity_verify_page(page)) {
@@ -241,13 +241,13 @@ static void f2fs_verify_and_finish_bio(struct bio *bio, bool in_task)
 static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx,
 		bool in_task)
 {
-	struct bio_vec *bv;
+	struct bio_vec bv;
 	struct bvec_iter_all iter_all;
 	bool all_compressed = true;
 	block_t blkaddr = ctx->fs_blkaddr;
 
 	bio_for_each_segment_all(bv, ctx->bio, iter_all) {
-		struct page *page = bv->bv_page;
+		struct page *page = bv.bv_page;
 
 		if (f2fs_is_compressed_page(page))
 			f2fs_end_read_compressed_page(page, false, blkaddr,
@@ -329,7 +329,7 @@ static void f2fs_read_end_io(struct bio *bio)
 static void f2fs_write_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 
 	iostat_update_and_unbind_ctx(bio, 1);
@@ -341,7 +341,7 @@ static void f2fs_write_end_io(struct bio *bio)
 	}
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+		struct page *page = bvec.bv_page;
 		enum count_type type = WB_DATA_TYPE(page);
 
 		if (page_private_dummy(page)) {
@@ -585,7 +585,7 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 static bool __has_merged_page(struct bio *bio, struct inode *inode,
 						struct page *page, nid_t ino)
 {
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 
 	if (!bio)
@@ -595,7 +595,7 @@ static bool __has_merged_page(struct bio *bio, struct inode *inode,
 		return true;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *target = bvec->bv_page;
+		struct page *target = bvec.bv_page;
 
 		if (fscrypt_is_bounce_page(target)) {
 			target = fscrypt_pagecache_page(target);
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 1902413d5d..7f62fe8eb7 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -202,7 +202,7 @@ static void gfs2_end_log_write_bh(struct gfs2_sbd *sdp,
 static void gfs2_end_log_write(struct bio *bio)
 {
 	struct gfs2_sbd *sdp = bio->bi_private;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct page *page;
 	struct bvec_iter_all iter_all;
 
@@ -217,9 +217,9 @@ static void gfs2_end_log_write(struct bio *bio)
 	}
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		page = bvec->bv_page;
+		page = bvec.bv_page;
 		if (page_has_buffers(page))
-			gfs2_end_log_write_bh(sdp, bvec, bio->bi_status);
+			gfs2_end_log_write_bh(sdp, &bvec, bio->bi_status);
 		else
 			mempool_free(page, gfs2_page_pool);
 	}
@@ -395,11 +395,11 @@ static void gfs2_log_write_page(struct gfs2_sbd *sdp, struct page *page)
 static void gfs2_end_log_read(struct bio *bio)
 {
 	struct page *page;
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		page = bvec->bv_page;
+		page = bvec.bv_page;
 		if (bio->bi_status) {
 			int err = blk_status_to_errno(bio->bi_status);
 
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 3c41b864ee..ed0acf1015 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -193,15 +193,15 @@ struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, u64 blkno)
 
 static void gfs2_meta_read_endio(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct bio_vec bvec;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+		struct page *page = bvec.bv_page;
 		struct buffer_head *bh = page_buffers(page);
-		unsigned int len = bvec->bv_len;
+		unsigned int len = bvec.bv_len;
 
-		while (bh_offset(bh) < bvec->bv_offset)
+		while (bh_offset(bh) < bvec.bv_offset)
 			bh = bh->b_this_page;
 		do {
 			struct buffer_head *next = bh->b_this_page;
diff --git a/fs/mpage.c b/fs/mpage.c
index 0f8ae954a5..0f9d9468c3 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -45,11 +45,11 @@
  */
 static void mpage_end_io(struct bio *bio)
 {
-	struct bio_vec *bv;
+	struct bio_vec bv;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
+		struct page *page = bv.bv_page;
 		page_endio(page, bio_op(bio),
 			   blk_status_to_errno(bio->bi_status));
 	}
diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index bed3bb8b27..83e8b44518 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -35,30 +35,33 @@ static int copy_bio_to_actor(struct bio *bio,
 			     int offset, int req_length)
 {
 	void *actor_addr;
-	struct bvec_iter_all iter_all = {};
-	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
+	struct bvec_iter_all iter;
+	struct bio_vec bvec;
 	int copied_bytes = 0;
 	int actor_offset = 0;
+	int bytes_to_copy;
 
 	squashfs_actor_nobuff(actor);
 	actor_addr = squashfs_first_page(actor);
 
-	if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all)))
-		return 0;
+	bvec_iter_all_init(&iter);
+	bio_iter_all_advance(bio, &iter, offset);
 
-	while (copied_bytes < req_length) {
-		int bytes_to_copy = min_t(int, bvec->bv_len - offset,
+	while (copied_bytes < req_length &&
+	       iter.idx < bio->bi_vcnt) {
+		bvec = bio_iter_all_peek(bio, &iter);
+
+		bytes_to_copy = min_t(int, bvec.bv_len,
 					  PAGE_SIZE - actor_offset);
 
 		bytes_to_copy = min_t(int, bytes_to_copy,
 				      req_length - copied_bytes);
 		if (!IS_ERR(actor_addr))
-			memcpy(actor_addr + actor_offset, bvec_virt(bvec) +
-					offset, bytes_to_copy);
+			memcpy(actor_addr + actor_offset, bvec_virt(&bvec),
+			       bytes_to_copy);
 
 		actor_offset += bytes_to_copy;
 		copied_bytes += bytes_to_copy;
-		offset += bytes_to_copy;
 
 		if (actor_offset >= PAGE_SIZE) {
 			actor_addr = squashfs_next_page(actor);
@@ -66,11 +69,8 @@ static int copy_bio_to_actor(struct bio *bio,
 				break;
 			actor_offset = 0;
 		}
-		if (offset >= bvec->bv_len) {
-			if (!bio_next_segment(bio, &iter_all))
-				break;
-			offset = 0;
-		}
+
+		bio_iter_all_advance(bio, &iter, bytes_to_copy);
 	}
 	squashfs_finish_page(actor);
 	return copied_bytes;
@@ -159,8 +159,10 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		 * Metadata block.
 		 */
 		const u8 *data;
-		struct bvec_iter_all iter_all = {};
-		struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
+		struct bvec_iter_all iter;
+		struct bio_vec bvec;
+
+		bvec_iter_all_init(&iter);
 
 		if (index + 2 > msblk->bytes_used) {
 			res = -EIO;
@@ -170,21 +172,25 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		if (res)
 			goto out;
 
-		if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all))) {
+		bvec = bio_iter_all_peek(bio, &iter);
+
+		if (WARN_ON_ONCE(!bvec.bv_len)) {
 			res = -EIO;
 			goto out_free_bio;
 		}
 		/* Extract the length of the metadata block */
-		data = bvec_virt(bvec);
+		data = bvec_virt(&bvec);
 		length = data[offset];
-		if (offset < bvec->bv_len - 1) {
+		if (offset < bvec.bv_len - 1) {
 			length |= data[offset + 1] << 8;
 		} else {
-			if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all))) {
+			bio_iter_all_advance(bio, &iter, bvec.bv_len);
+
+			if (WARN_ON_ONCE(!bvec.bv_len)) {
 				res = -EIO;
 				goto out_free_bio;
 			}
-			data = bvec_virt(bvec);
+			data = bvec_virt(&bvec);
 			length |= data[0] << 8;
 		}
 		bio_free_pages(bio);
diff --git a/fs/squashfs/lz4_wrapper.c b/fs/squashfs/lz4_wrapper.c
index 49797729f1..bd0dd787d2 100644
--- a/fs/squashfs/lz4_wrapper.c
+++ b/fs/squashfs/lz4_wrapper.c
@@ -92,20 +92,23 @@ static int lz4_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	struct bio *bio, int offset, int length,
 	struct squashfs_page_actor *output)
 {
-	struct bvec_iter_all iter_all = {};
-	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
+	struct bvec_iter_all iter;
+	struct bio_vec bvec;
 	struct squashfs_lz4 *stream = strm;
 	void *buff = stream->input, *data;
 	int bytes = length, res;
 
-	while (bio_next_segment(bio, &iter_all)) {
-		int avail = min(bytes, ((int)bvec->bv_len) - offset);
+	bvec_iter_all_init(&iter);
+	bio_iter_all_advance(bio, &iter, offset);
 
-		data = bvec_virt(bvec);
-		memcpy(buff, data + offset, avail);
+	bio_for_each_segment_all_continue(bvec, bio, iter) {
+		unsigned avail = min_t(unsigned, bytes, bvec.bv_len);
+
+		memcpy(buff, bvec_virt(&bvec), avail);
 		buff += avail;
 		bytes -= avail;
-		offset = 0;
+		if (!bytes)
+			break;
 	}
 
 	res = LZ4_decompress_safe(stream->input, stream->output,
diff --git a/fs/squashfs/lzo_wrapper.c b/fs/squashfs/lzo_wrapper.c
index d216aeefa8..bccfcfa12e 100644
--- a/fs/squashfs/lzo_wrapper.c
+++ b/fs/squashfs/lzo_wrapper.c
@@ -66,21 +66,24 @@ static int lzo_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	struct bio *bio, int offset, int length,
 	struct squashfs_page_actor *output)
 {
-	struct bvec_iter_all iter_all = {};
-	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
+	struct bvec_iter_all iter;
+	struct bio_vec bvec;
 	struct squashfs_lzo *stream = strm;
 	void *buff = stream->input, *data;
 	int bytes = length, res;
 	size_t out_len = output->length;
 
-	while (bio_next_segment(bio, &iter_all)) {
-		int avail = min(bytes, ((int)bvec->bv_len) - offset);
+	bvec_iter_all_init(&iter);
+	bio_iter_all_advance(bio, &iter, offset);
 
-		data = bvec_virt(bvec);
-		memcpy(buff, data + offset, avail);
+	bio_for_each_segment_all_continue(bvec, bio, iter) {
+		unsigned avail = min_t(unsigned, bytes, bvec.bv_len);
+
+		memcpy(buff, bvec_virt(&bvec), avail);
 		buff += avail;
 		bytes -= avail;
-		offset = 0;
+		if (!bytes)
+			break;
 	}
 
 	res = lzo1x_decompress_safe(stream->input, (size_t)length,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 961ba24802..c08ff3b406 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -215,7 +215,7 @@ void fsverity_verify_bio(struct bio *bio)
 	const struct fsverity_info *vi = inode->i_verity_info;
 	const struct merkle_tree_params *params = &vi->tree_params;
 	struct ahash_request *req;
-	struct bio_vec *bv;
+	struct bio_vec bv;
 	struct bvec_iter_all iter_all;
 	unsigned long max_ra_pages = 0;
 
@@ -238,7 +238,7 @@ void fsverity_verify_bio(struct bio *bio)
 	}
 
 	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
+		struct page *page = bv.bv_page;
 		unsigned long level0_index = page->index >> params->log_arity;
 		unsigned long level0_ra_pages =
 			min(max_ra_pages, params->level0_blocks - level0_index);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c1da63f6c8..554eebd6a9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -76,22 +76,37 @@ static inline void *bio_data(struct bio *bio)
 	return NULL;
 }
 
-static inline bool bio_next_segment(const struct bio *bio,
-				    struct bvec_iter_all *iter)
+static inline struct bio_vec bio_iter_all_peek(const struct bio *bio,
+					       struct bvec_iter_all *iter)
 {
-	if (iter->idx >= bio->bi_vcnt)
-		return false;
+	BUG_ON(iter->idx >= bio->bi_vcnt);
+	return bvec_iter_all_peek(bio->bi_io_vec, iter);
+}
 
-	bvec_advance(&bio->bi_io_vec[iter->idx], iter);
-	return true;
+static inline void bio_iter_all_advance(const struct bio *bio,
+					struct bvec_iter_all *iter,
+					unsigned bytes)
+{
+	bvec_iter_all_advance(bio->bi_io_vec, iter, bytes);
+
+	BUG_ON(iter->idx > bio->bi_vcnt || (iter->idx == bio->bi_vcnt && iter->done));
 }
 
+#define bio_for_each_segment_all_continue(bvl, bio, iter)		\
+	for (;								\
+	     iter.idx < bio->bi_vcnt &&					\
+		((bvl = bio_iter_all_peek(bio, &iter)), true);		\
+	     bio_iter_all_advance((bio), &iter, bvl.bv_len))
+
 /*
  * drivers should _never_ use the all version - the bio may have been split
  * before it got to the driver and the driver won't own all of it
  */
-#define bio_for_each_segment_all(bvl, bio, iter) \
-	for (bvl = bvec_init_iter_all(&iter); bio_next_segment((bio), &iter); )
+#define bio_for_each_segment_all(bvl, bio, iter)			\
+	for (bvec_iter_all_init(&iter);					\
+	     iter.idx < bio->bi_vcnt &&					\
+		((bvl = bio_iter_all_peek(bio, &iter)), true);		\
+	     bio_iter_all_advance((bio), &iter, bvl.bv_len))
 
 static inline void bio_advance_iter(const struct bio *bio,
 				    struct bvec_iter *iter, unsigned int bytes)
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 35c25dff65..12f0e073c0 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -46,12 +46,6 @@ struct bvec_iter {
 						   current bvec */
 } __packed;
 
-struct bvec_iter_all {
-	struct bio_vec	bv;
-	int		idx;
-	unsigned	done;
-};
-
 /*
  * various member access, note that bio_data should of course not be used
  * on highmem page vectors
@@ -145,7 +139,10 @@ static inline void bvec_iter_advance_single(const struct bio_vec *bv,
 		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
 	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
 
-/* for iterating one bio from start to end */
+/*
+ * bvec_iter_all: for advancing over a bio as it was originally created, but
+ * with the usual bio_for_each_segment interface - nonstandard, do not use:
+ */
 #define BVEC_ITER_ALL_INIT (struct bvec_iter)				\
 {									\
 	.bi_sector	= 0,						\
@@ -154,33 +151,45 @@ static inline void bvec_iter_advance_single(const struct bio_vec *bv,
 	.bi_bvec_done	= 0,						\
 }
 
-static inline struct bio_vec *bvec_init_iter_all(struct bvec_iter_all *iter_all)
+/*
+ * bvec_iter_all: for advancing over individual pages in a bio, as it was when
+ * it was first created:
+ */
+struct bvec_iter_all {
+	int		idx;
+	unsigned	done;
+};
+
+static inline void bvec_iter_all_init(struct bvec_iter_all *iter_all)
 {
 	iter_all->done = 0;
 	iter_all->idx = 0;
+}
 
-	return &iter_all->bv;
+static inline struct bio_vec bvec_iter_all_peek(const struct bio_vec *bvec,
+						struct bvec_iter_all *iter)
+{
+	struct bio_vec bv = bvec[iter->idx];
+
+	bv.bv_offset	+= iter->done;
+	bv.bv_len	-= iter->done;
+
+	bv.bv_page	+= bv.bv_offset >> PAGE_SHIFT;
+	bv.bv_offset	&= ~PAGE_MASK;
+	bv.bv_len	= min_t(unsigned, PAGE_SIZE - bv.bv_offset, bv.bv_len);
+
+	return bv;
 }
 
-static inline void bvec_advance(const struct bio_vec *bvec,
-				struct bvec_iter_all *iter_all)
+static inline void bvec_iter_all_advance(const struct bio_vec *bvec,
+					 struct bvec_iter_all *iter,
+					 unsigned bytes)
 {
-	struct bio_vec *bv = &iter_all->bv;
-
-	if (iter_all->done) {
-		bv->bv_page++;
-		bv->bv_offset = 0;
-	} else {
-		bv->bv_page = bvec->bv_page + (bvec->bv_offset >> PAGE_SHIFT);
-		bv->bv_offset = bvec->bv_offset & ~PAGE_MASK;
-	}
-	bv->bv_len = min_t(unsigned int, PAGE_SIZE - bv->bv_offset,
-			   bvec->bv_len - iter_all->done);
-	iter_all->done += bv->bv_len;
+	iter->done += bytes;
 
-	if (iter_all->done == bvec->bv_len) {
-		iter_all->idx++;
-		iter_all->done = 0;
+	while (iter->done && iter->done >= bvec[iter->idx].bv_len) {
+		iter->done -= bvec[iter->idx].bv_len;
+		iter->idx++;
 	}
 }
 
-- 
2.39.2

