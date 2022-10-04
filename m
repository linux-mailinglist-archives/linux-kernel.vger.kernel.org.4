Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21385F3B09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 03:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJDBlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 21:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJDBlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 21:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A200E27B2E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 18:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D35260F97
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51611C433D6;
        Tue,  4 Oct 2022 01:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664847668;
        bh=SViozrtHpxa4Fp3tUE+OJWXx+CBtzHe8unuMcforS/A=;
        h=From:To:Cc:Subject:Date:From;
        b=QWHXY2+cJbinaPnmP2PnDWwBv9EcIWPFtiBAOOE9c5E5xlnYcY8cm04KtryGAqdJK
         Oq76MdzgAQ+czQ8cXvY03S5zGyL92mvyZ3eKSbmZgzcUl0vHwgDsIOVLol61ilwZaH
         gUyfegfnnBTuhYmkpdUUO+aun+YAZIlXflAtz4OgJktkO4s/MtnXbzB/hKYkv35O1x
         UNENjhBt82tDgccRfziumN9/GXp/tCw72ZcmxeU/ssacQIDSzeCPZfOdfiHiAFYHd+
         6o8pPMlXRHvU0IW/64Xf7zSTSEfj1qQCGyMxbhIO9IZ5yUPB8QM7YxRw8S6T2jFMzI
         Y0fvk+ZNiq6qQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: change to use atomic_t type form sbi.atomic_files
Date:   Tue,  4 Oct 2022 09:41:02 +0800
Message-Id: <20221004014102.974213-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inode_lock[ATOMIC_FILE] was used for protecting sbi->atomic_files,
update atomic_files variable's type to atomic_t instead of unsigned
int, then inode_lock[ATOMIC_FILE] can be obsoleted.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/debug.c   |  3 ++-
 fs/f2fs/f2fs.h    | 11 ++++++++---
 fs/f2fs/file.c    |  4 +---
 fs/f2fs/segment.c |  5 +----
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 7a9dd2319155..a216dcdf6941 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -91,7 +91,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
 	si->nquota_files = sbi->nquota_files;
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
-	si->aw_cnt = sbi->atomic_files;
+	si->aw_cnt = atomic_read(&sbi->atomic_files);
 	si->max_aw_cnt = atomic_read(&sbi->max_aw_cnt);
 	si->nr_dio_read = get_pages(sbi, F2FS_DIO_READ);
 	si->nr_dio_write = get_pages(sbi, F2FS_DIO_WRITE);
@@ -611,6 +611,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	atomic_set(&sbi->compr_inode, 0);
 	atomic64_set(&sbi->compr_blocks, 0);
 	atomic_set(&sbi->swapfile_inode, 0);
+	atomic_set(&sbi->atomic_files, 0);
 	atomic_set(&sbi->inplace_count, 0);
 	for (i = META_CP; i < META_MAX; i++)
 		atomic_set(&sbi->meta_count[i], 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a0b2c8626a75..fba7cd5cc201 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1259,7 +1259,6 @@ enum inode_type {
 	DIR_INODE,			/* for dirty dir inode */
 	FILE_INODE,			/* for dirty regular/symlink inode */
 	DIRTY_META,			/* for all dirtied inode metadata */
-	ATOMIC_FILE,			/* for all atomic files */
 	NR_INODE_TYPE,
 };
 
@@ -1741,7 +1740,6 @@ struct f2fs_sb_info {
 	unsigned int gc_urgent_high_remaining;	/* remaining trial count for GC_URGENT_HIGH */
 
 	/* for skip statistic */
-	unsigned int atomic_files;		/* # of opened atomic file */
 	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
 
 	/* threshold for gc trials on pinned files */
@@ -1773,6 +1771,7 @@ struct f2fs_sb_info {
 	atomic_t compr_inode;			/* # of compressed inodes */
 	atomic64_t compr_blocks;		/* # of compressed blocks */
 	atomic_t swapfile_inode;		/* # of swapfile inodes */
+	atomic_t atomic_files;			/* # of opened atomic file */
 	atomic_t max_aw_cnt;			/* max # of atomic writes */
 	unsigned int io_skip_bggc;		/* skip background gc for in-flight IO */
 	unsigned int other_skip_bggc;		/* skip background gc for other reasons */
@@ -3972,6 +3971,10 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		(atomic_inc(&F2FS_I_SB(inode)->swapfile_inode))
 #define stat_dec_swapfile_inode(inode)					\
 		(atomic_dec(&F2FS_I_SB(inode)->swapfile_inode))
+#define stat_inc_atomic_inode(inode)					\
+			(atomic_inc(&F2FS_I_SB(inode)->atomic_files))
+#define stat_dec_atomic_inode(inode)					\
+			(atomic_dec(&F2FS_I_SB(inode)->atomic_files))
 #define stat_inc_meta_count(sbi, blkaddr)				\
 	do {								\
 		if (blkaddr < SIT_I(sbi)->sit_base_addr)		\
@@ -3991,7 +3994,7 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		(atomic_inc(&(sbi)->inplace_count))
 #define stat_update_max_atomic_write(inode)				\
 	do {								\
-		int cur = F2FS_I_SB(inode)->atomic_files;	\
+		int cur = atomic_read(&F2FS_I_SB(inode)->atomic_files);	\
 		int max = atomic_read(&F2FS_I_SB(inode)->max_aw_cnt);	\
 		if (cur > max)						\
 			atomic_set(&F2FS_I_SB(inode)->max_aw_cnt, cur);	\
@@ -4058,6 +4061,8 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #define stat_sub_compr_blocks(inode, blocks)		do { } while (0)
 #define stat_inc_swapfile_inode(inode)			do { } while (0)
 #define stat_dec_swapfile_inode(inode)			do { } while (0)
+#define stat_inc_atomic_inode(inode)			do { } while (0)
+#define stat_dec_atomic_inode(inode)			do { } while (0)
 #define stat_update_max_atomic_write(inode)		do { } while (0)
 #define stat_inc_meta_count(sbi, blkaddr)		do { } while (0)
 #define stat_inc_seg_type(sbi, curseg)			do { } while (0)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index df5e7ad80096..e4b6e51086a3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2061,9 +2061,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	}
 	f2fs_i_size_write(fi->cow_inode, isize);
 
-	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
-	sbi->atomic_files++;
-	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+	stat_inc_atomic_inode(inode);
 
 	set_inode_flag(inode, FI_ATOMIC_FILE);
 	set_inode_flag(fi->cow_inode, FI_COW_FILE);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5619f2916335..79ec215a7ec6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -187,7 +187,6 @@ bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
 
 void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	if (!f2fs_is_atomic_file(inode))
@@ -203,9 +202,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	release_atomic_write_cnt(inode);
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
 
-	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
-	sbi->atomic_files--;
-	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+	stat_dec_atomic_inode(inode);
 }
 
 static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
-- 
2.25.1

