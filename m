Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF9F68037A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjA3BUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3BU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:20:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACD415C84
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 17:20:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96E65B80DD3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2E7C433EF;
        Mon, 30 Jan 2023 01:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675041625;
        bh=/LdlnZLafbb8r9iszLz7XEPV/RToyYsM0QbXk0IBXL4=;
        h=From:To:Cc:Subject:Date:From;
        b=Irjh3ataYAzB8xrhAKN9BVrXmZAtrOU+PnAcb7SCd6akfMuXlzh1xbU5zPrCqPm2q
         4x1w9HM0tB/zhXZGrY1G57TYar4P7eqvGS3AXQel3QfICmZMGaHuUQ9CemgoHfb2CX
         T9TQ6ty02gYhMs6j79mWhgKJxLR/0AQLyOE8hWxBCWEPhKv++qgnAmT3jNTNrfV1f5
         XCMGIWQycfzweDgmzjrrJUDxEQc1NJT4FJ7bBen2PsqQ6o+ussCm2x9dUz532Upckf
         zbJRe5rKcYitfhMM4YyKbTIgMRv8dItlW6lxxZJJ41ELYWM/sZaSICMcmkpftk3TYn
         UDZsn3CsLyEjg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: reduce stack memory cost by using bitfield in struct f2fs_io_info
Date:   Mon, 30 Jan 2023 09:20:12 +0800
Message-Id: <20230130012012.2078978-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to use bitfield in struct f2fs_io_info to improve
memory usage.

struct f2fs_io_info {
...
	int need_lock:8;	/* indicate we need to lock cp_rwsem */
	int version:8;		/* version of the node */
	int submitted:1;	/* indicate IO submission */
	int in_list:1;		/* indicate fio is in io_list */
	int is_por:1;		/* indicate IO is from recovery or not */
	int retry:1;		/* need to reallocate block address */
	int encrypted:1;	/* indicate file is encrypted */
	int post_read:1;	/* require post read */
...
};

After this patch, size of struct f2fs_io_info reduces from 136 to 120.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix compile warning caused by assigning bool type value to bitfield variable.
 fs/f2fs/checkpoint.c |  6 +++---
 fs/f2fs/compress.c   |  5 +++--
 fs/f2fs/data.c       | 10 +++++-----
 fs/f2fs/f2fs.h       | 16 ++++++++--------
 fs/f2fs/gc.c         |  8 ++++----
 fs/f2fs/node.c       |  2 +-
 fs/f2fs/segment.c    |  6 +++---
 7 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b442e72fcefd..359b245920e1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -67,7 +67,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		.old_blkaddr = index,
 		.new_blkaddr = index,
 		.encrypted_page = NULL,
-		.is_por = !is_meta,
+		.is_por = !is_meta ? 1 : 0,
 	};
 	int err;
 
@@ -234,8 +234,8 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.op = REQ_OP_READ,
 		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
-		.in_list = false,
-		.is_por = (type == META_POR),
+		.in_list = 0,
+		.is_por = (type == META_POR) ? 1 : 0,
 	};
 	struct blk_plug plug;
 	int err;
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 365ee074d3b3..89b344e28ca6 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1237,10 +1237,11 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		.page = NULL,
 		.encrypted_page = NULL,
 		.compressed_page = NULL,
-		.submitted = false,
+		.submitted = 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
-		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode),
+		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode) ?
+									1 : 0,
 	};
 	struct dnode_of_data dn;
 	struct node_info ni;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 04a7bb4d4cdf..bcb88ae84fa8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -992,7 +992,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		bio_page = fio->page;
 
 	/* set submitted = true as a return value */
-	fio->submitted = true;
+	fio->submitted = 1;
 
 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
 
@@ -1008,7 +1008,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 				(fio->type == DATA || fio->type == NODE) &&
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
 			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
-			fio->retry = true;
+			fio->retry = 1;
 			goto skip;
 		}
 		io->bio = __bio_alloc(fio, BIO_MAX_VECS);
@@ -2792,10 +2792,10 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.old_blkaddr = NULL_ADDR,
 		.page = page,
 		.encrypted_page = NULL,
-		.submitted = false,
+		.submitted = 0,
 		.compr_blocks = compr_blocks,
 		.need_lock = LOCK_RETRY,
-		.post_read = f2fs_post_read_required(inode),
+		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
 		.bio = bio,
@@ -2916,7 +2916,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	}
 
 	if (submitted)
-		*submitted = fio.submitted ? 1 : 0;
+		*submitted = fio.submitted;
 
 	return 0;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bd22f8fd09ef..71d864854802 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1212,19 +1212,19 @@ struct f2fs_io_info {
 	struct page *encrypted_page;	/* encrypted page */
 	struct page *compressed_page;	/* compressed page */
 	struct list_head list;		/* serialize IOs */
-	bool submitted;		/* indicate IO submission */
-	int need_lock;		/* indicate we need to lock cp_rwsem */
-	bool in_list;		/* indicate fio is in io_list */
-	bool is_por;		/* indicate IO is from recovery or not */
-	bool retry;		/* need to reallocate block address */
 	int compr_blocks;	/* # of compressed block addresses */
-	bool encrypted;		/* indicate file is encrypted */
-	bool post_read;		/* require post read */
+	int need_lock:8;	/* indicate we need to lock cp_rwsem */
+	int version:8;		/* version of the node */
+	int submitted:1;	/* indicate IO submission */
+	int in_list:1;		/* indicate fio is in io_list */
+	int is_por:1;		/* indicate IO is from recovery or not */
+	int retry:1;		/* need to reallocate block address */
+	int encrypted:1;	/* indicate file is encrypted */
+	int post_read:1;	/* require post read */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
 	struct bio **bio;		/* bio for ipu */
 	sector_t *last_block;		/* last block number in bio */
-	unsigned char version;		/* version of the node */
 };
 
 struct bio_entry {
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d2f27b15287d..8f2224e1dc61 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1156,8 +1156,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.encrypted_page = NULL,
-		.in_list = false,
-		.retry = false,
+		.in_list = 0,
+		.retry = 0,
 	};
 	int err;
 
@@ -1245,8 +1245,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.encrypted_page = NULL,
-		.in_list = false,
-		.retry = false,
+		.in_list = 0,
+		.retry = 0,
 	};
 	struct dnode_of_data dn;
 	struct f2fs_summary sum;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fbd1d25fecc2..19a1fee88a36 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1586,7 +1586,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		.op_flags = wbc_to_write_flags(wbc),
 		.page = page,
 		.encrypted_page = NULL,
-		.submitted = false,
+		.submitted = 0,
 		.io_type = io_type,
 		.io_wbc = wbc,
 	};
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a007f5084e84..660196b52ae5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3344,10 +3344,10 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		struct f2fs_bio_info *io;
 
 		if (F2FS_IO_ALIGNED(sbi))
-			fio->retry = false;
+			fio->retry = 0;
 
 		INIT_LIST_HEAD(&fio->list);
-		fio->in_list = true;
+		fio->in_list = 1;
 		io = sbi->write_io[fio->type] + fio->temp;
 		spin_lock(&io->io_lock);
 		list_add_tail(&fio->list, &io->io_list);
@@ -3428,7 +3428,7 @@ void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 		.new_blkaddr = page->index,
 		.page = page,
 		.encrypted_page = NULL,
-		.in_list = false,
+		.in_list = 0,
 	};
 
 	if (unlikely(page->index >= MAIN_BLKADDR(sbi)))
-- 
2.25.1

