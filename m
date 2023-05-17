Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DA2706AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEQOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjEQOSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:18:40 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1FB10EC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684333116;
  x=1715869116;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=pjJ40Zh0zL8d8RK+1Myo3bydEhaUBV+ip13pGDQyEI8=;
  b=ix57kg1LpUcAoXAtw2CQyREkoRLQEsjylmXO8csyfGbwUPesDBj6KiCy
   o5npf26ZNZuzD/JLb8LVLsykdRRo8weFCuYpZWJwTQCc4ZW42uEe0bz87
   qSbPC21ctPu89M8bfm83LgjzxlTZ2baFE+98e1mg/p4zP1e7LLmwpa/Zn
   Lv3dst0h6URwQ6pz6mquWX/hxrPDOP0wkwGqRI8lhhEXqgxGK5AX9+H9D
   oaGS52xECCFmolVoF6qJPnWwROX0JNBZ57wEmBK1UE6mpQNCmFET9bDdh
   pPgYW9aklOdHACg7LD2NEkAB8NlD+mXC4NsJ9mTq+mqXiK0/Pvis/uwEO
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Wed, 17 May 2023 16:18:19 +0200
Subject: [PATCH v4] squashfs: cache partial compressed blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230510-squashfs-cache-v4-1-3bd394e1ee71@axis.com>
X-B4-Tracking: v=1; b=H4sIACriZGQC/33OwQ7CIAwG4FcxnMUAHVvmyfcwHgorwsFNqS4zZ
 u8u82CMiR7/5v/aPgRTTsRiu3qITGPiNPQlVOuV8BH7I8nUlSyMMqCsVpIvN+QYWHr0kWSD4Fp
 qwFqvRUEOmaTL2Pu4sHe73oB0aeClc84U0vQ6uj+UHBNfh3x//TDqZfrz3KilluBq5xQ1XWvND
 qfEGz+cxLJpNP+1KboyaJVG3di6/dLwX0PRbbB1CF0FQcGHnuf5Cfta27dLAQAA
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <squashfs-devel@lists.sourceforge.net>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 93e72b3c612adcaca1 ("squashfs: migrate from ll_rw_block
usage to BIO"), compressed blocks read by squashfs were cached in the
page cache, but that is not the case after that commit.  That has lead
to squashfs having to re-read a lot of sectors from disk/flash.

For example, the first sectors of every metadata block need to be read
twice from the disk.  Once partially to read the length, and a
second time to read the block itself.  Also, in linear reads of large
files, the last sectors of one data block are re-read from disk when
reading the next data block, since the compressed blocks are of variable
sizes and not aligned to device blocks.  This extra I/O results in a
degrade in read performance of, for example, ~16% in one scenario on my
ARM platform using squashfs with dm-verity and NAND.

Since the decompressed data is cached in the page cache or squashfs'
internal metadata and fragment caches, caching _all_ compressed pages
would lead to a lot of double caching and is undesirable.  But make the
code cache any disk blocks which were only partially requested, since
these are the ones likely to include data which is needed by other file
system blocks.  This restores read performance in my test scenario.

The compressed block caching is only applied when the disk block size is
equal to the page size, to avoid having to deal with caching sub-page
reads.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
Changes in v4:
- Store pointer to address_space instead of pointer to inode in
  super_block.
- Use __bio_add_page() unconditionally.
- Link to v3: https://lore.kernel.org/r/20230510-squashfs-cache-v3-1-9f56ffd43f03@axis.com

Changes in v3:
- Drop Philippe Liard <pliard@google.com> from Cc since the address is
  bouncing.
- Tweak formatting of long argument list.
- Clone the bio so that the bio_vec can be reused.
- Link to v2: https://lore.kernel.org/r/20230510-squashfs-cache-v2-1-42a501a17569@axis.com

Changes in v2:
- Do not remove static from squashfs_bio_read()
- Link to v1: https://lore.kernel.org/r/20230510-squashfs-cache-v1-1-3b6bb0e7d952@axis.com
---
 fs/squashfs/block.c          | 114 ++++++++++++++++++++++++++++++++++++++++---
 fs/squashfs/squashfs_fs_sb.h |   1 +
 fs/squashfs/super.c          |  17 +++++++
 3 files changed, 126 insertions(+), 6 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index bed3bb8b27fa..928cda5a13ab 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -76,10 +76,99 @@ static int copy_bio_to_actor(struct bio *bio,
 	return copied_bytes;
 }
 
+static int squashfs_bio_read_cached(struct bio *fullbio,
+		struct address_space *cache_mapping, u64 index, int length,
+		u64 read_start, u64 read_end, int page_count)
+{
+	struct page *head_to_cache = NULL, *tail_to_cache = NULL;
+	struct block_device *bdev = fullbio->bi_bdev;
+	int start_idx = 0, end_idx = 0;
+	struct bvec_iter_all iter_all;
+	struct bio *bio = NULL;
+	struct bio_vec *bv;
+	int idx = 0;
+	int err = 0;
+
+	bio_for_each_segment_all(bv, fullbio, iter_all) {
+		struct page *page = bv->bv_page;
+
+		if (page->mapping == cache_mapping && PageUptodate(page)) {
+			idx++;
+			continue;
+		}
+
+		/*
+		 * We only use this when the device block size is the same as
+		 * the page size, so read_start and read_end cover full pages.
+		 *
+		 * Compare these to the original required index and length to
+		 * only cache pages which were requested partially, since these
+		 * are the ones which are likely to be needed when reading
+		 * adjacent blocks.
+		 */
+		if (idx == 0 && index != read_start)
+			head_to_cache = page;
+		else if (idx == page_count - 1 && index + length != read_end)
+			tail_to_cache = page;
+
+		if (!bio || idx != end_idx) {
+			struct bio *new = bio_alloc_clone(bdev, fullbio,
+							  GFP_NOIO, &fs_bio_set);
+
+			if (bio) {
+				bio_trim(bio, start_idx * PAGE_SECTORS,
+					 (end_idx - start_idx) * PAGE_SECTORS);
+				bio_chain(bio, new);
+				submit_bio(bio);
+			}
+
+			bio = new;
+			start_idx = idx;
+		}
+
+		idx++;
+		end_idx = idx;
+	}
+
+	if (bio) {
+		bio_trim(bio, start_idx * PAGE_SECTORS,
+			 (end_idx - start_idx) * PAGE_SECTORS);
+		err = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+
+	if (err)
+		return err;
+
+	if (head_to_cache) {
+		int ret = add_to_page_cache_lru(head_to_cache, cache_mapping,
+						read_start, GFP_NOIO);
+
+		if (!ret) {
+			SetPageUptodate(head_to_cache);
+			unlock_page(head_to_cache);
+		}
+
+	}
+
+	if (tail_to_cache) {
+		int ret = add_to_page_cache_lru(tail_to_cache, cache_mapping,
+						read_end - PAGE_SIZE, GFP_NOIO);
+
+		if (!ret) {
+			SetPageUptodate(tail_to_cache);
+			unlock_page(tail_to_cache);
+		}
+	}
+
+	return 0;
+}
+
 static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 			     struct bio **biop, int *block_offset)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	struct address_space *cache_mapping = msblk->cache_mapping;
 	const u64 read_start = round_down(index, msblk->devblksize);
 	const sector_t block = read_start >> msblk->devblksize_log2;
 	const u64 read_end = round_up(index + length, msblk->devblksize);
@@ -99,21 +188,34 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 	for (i = 0; i < page_count; ++i) {
 		unsigned int len =
 			min_t(unsigned int, PAGE_SIZE - offset, total_len);
-		struct page *page = alloc_page(GFP_NOIO);
+		struct page *page = NULL;
+
+		if (cache_mapping)
+			page = find_get_page(cache_mapping,
+					     read_start + i * PAGE_SIZE);
+		if (!page)
+			page = alloc_page(GFP_NOIO);
 
 		if (!page) {
 			error = -ENOMEM;
 			goto out_free_bio;
 		}
-		if (!bio_add_page(bio, page, len, offset)) {
-			error = -EIO;
-			goto out_free_bio;
-		}
+
+		/*
+		 * Use the __ version to avoid merging since we need each page
+		 * to be separate when we check for and avoid cached pages.
+		 */
+		__bio_add_page(bio, page, len, offset);
 		offset = 0;
 		total_len -= len;
 	}
 
-	error = submit_bio_wait(bio);
+	if (cache_mapping)
+		error = squashfs_bio_read_cached(bio, cache_mapping, index,
+						 length, read_start, read_end,
+						 page_count);
+	else
+		error = submit_bio_wait(bio);
 	if (error)
 		goto out_free_bio;
 
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index 72f6f4b37863..c01998eec146 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -47,6 +47,7 @@ struct squashfs_sb_info {
 	struct squashfs_cache			*block_cache;
 	struct squashfs_cache			*fragment_cache;
 	struct squashfs_cache			*read_page;
+	struct address_space			*cache_mapping;
 	int					next_meta_index;
 	__le64					*id_table;
 	__le64					*fragment_index;
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index e090fae48e68..22e812808e5c 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -329,6 +329,19 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto failed_mount;
 	}
 
+	if (msblk->devblksize == PAGE_SIZE) {
+		struct inode *cache = new_inode(sb);
+
+		if (cache == NULL)
+			goto failed_mount;
+
+		set_nlink(cache, 1);
+		cache->i_size = OFFSET_MAX;
+		mapping_set_gfp_mask(cache->i_mapping, GFP_NOFS);
+
+		msblk->cache_mapping = cache->i_mapping;
+	}
+
 	msblk->stream = squashfs_decompressor_setup(sb, flags);
 	if (IS_ERR(msblk->stream)) {
 		err = PTR_ERR(msblk->stream);
@@ -454,6 +467,8 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	squashfs_cache_delete(msblk->block_cache);
 	squashfs_cache_delete(msblk->fragment_cache);
 	squashfs_cache_delete(msblk->read_page);
+	if (msblk->cache_mapping)
+		iput(msblk->cache_mapping->host);
 	msblk->thread_ops->destroy(msblk);
 	kfree(msblk->inode_lookup_table);
 	kfree(msblk->fragment_index);
@@ -572,6 +587,8 @@ static void squashfs_put_super(struct super_block *sb)
 		squashfs_cache_delete(sbi->block_cache);
 		squashfs_cache_delete(sbi->fragment_cache);
 		squashfs_cache_delete(sbi->read_page);
+		if (sbi->cache_mapping)
+			iput(sbi->cache_mapping->host);
 		sbi->thread_ops->destroy(sbi);
 		kfree(sbi->id_table);
 		kfree(sbi->fragment_index);

---
base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
change-id: 20230510-squashfs-cache-7a3b9e7355c1

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

