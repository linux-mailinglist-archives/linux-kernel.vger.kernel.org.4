Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A095F3AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJDAuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDAuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:50:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D66BB3D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11180B817AE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B6EC433D6;
        Tue,  4 Oct 2022 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664844631;
        bh=TDnPq3DH3zk8jSB6ZZZuMRwdj/qsTT1hPUt6JdaiCyE=;
        h=From:To:Cc:Subject:Date:From;
        b=Y9g+eqwLI7GCV9FcUeWeoV2zC/eLaoK5KS20kRuOdIH98vVGobAcOaNPTllMj2jhv
         8zVdfjFN3m0KVJ5V3InE9X7amglCZVBzkW9qFZrquyOa2kyzsmeBJsDqFI33gZfcUC
         rmMFryJJ/PInDa8yxBKpVWtDI8jEgT8m9axuXdK9qNVZUpRl7wG4cTufFrBGRd+F8d
         OOHufKrOttJBX6CJYrrtWzFlg9xRvoCcswh1e8I49tKOaT01oqN933B4J1j0AoB6ct
         67YCYBMpU9ZIxVkVtoW6wuNNlzQvUbdRPg68tvhH0dVB3LAy++obHMtm9bXrbFMSK4
         vV9faRvtOg+hQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH v2] f2fs: account swapfile inodes
Date:   Tue,  4 Oct 2022 08:50:24 +0800
Message-Id: <20221004005024.955383-1-chao@kernel.org>
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

From: Chao Yu <chao.yu@oppo.com>

In order to check count of opened swapfile inodes.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
v2:
- fix to initialize swapfile_inode in f2fs_build_stats().
 fs/f2fs/data.c  | 2 ++
 fs/f2fs/debug.c | 4 ++++
 fs/f2fs/f2fs.h  | 9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0869fbbb5516..66f34cd559c6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3970,6 +3970,7 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (ret < 0)
 		return ret;
 
+	stat_inc_swapfile_inode(inode);
 	set_inode_flag(inode, FI_PIN_FILE);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return ret;
@@ -3979,6 +3980,7 @@ static void f2fs_swap_deactivate(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 
+	stat_dec_swapfile_inode(inode);
 	clear_inode_flag(inode, FI_PIN_FILE);
 }
 #else
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index c01471573977..0c06488143f9 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -135,6 +135,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->inline_inode = atomic_read(&sbi->inline_inode);
 	si->inline_dir = atomic_read(&sbi->inline_dir);
 	si->compr_inode = atomic_read(&sbi->compr_inode);
+	si->swapfile_inode = atomic_read(&sbi->swapfile_inode);
 	si->compr_blocks = atomic64_read(&sbi->compr_blocks);
 	si->append = sbi->im[APPEND_INO].ino_num;
 	si->update = sbi->im[UPDATE_INO].ino_num;
@@ -385,6 +386,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->inline_dir);
 		seq_printf(s, "  - Compressed Inode: %u, Blocks: %llu\n",
 			   si->compr_inode, si->compr_blocks);
+		seq_printf(s, "  - Swapfile Inode: %u\n",
+			   si->swapfile_inode);
 		seq_printf(s, "  - Orphan/Append/Update Inode: %u, %u, %u\n",
 			   si->orphans, si->append, si->update);
 		seq_printf(s, "\nMain area: %d segs, %d secs %d zones\n",
@@ -607,6 +610,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	atomic_set(&sbi->inline_dir, 0);
 	atomic_set(&sbi->compr_inode, 0);
 	atomic64_set(&sbi->compr_blocks, 0);
+	atomic_set(&sbi->atomic_files, 0);
 	atomic_set(&sbi->inplace_count, 0);
 	for (i = META_CP; i < META_MAX; i++)
 		atomic_set(&sbi->meta_count[i], 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 088c3d1574b8..408d8034ed74 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1765,6 +1765,7 @@ struct f2fs_sb_info {
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
 	atomic_t compr_inode;			/* # of compressed inodes */
 	atomic64_t compr_blocks;		/* # of compressed blocks */
+	atomic_t swapfile_inode;		/* # of swapfile inodes */
 	atomic_t max_aw_cnt;			/* max # of atomic writes */
 	unsigned int io_skip_bggc;		/* skip background gc for in-flight IO */
 	unsigned int other_skip_bggc;		/* skip background gc for other reasons */
@@ -3863,7 +3864,7 @@ struct f2fs_stat_info {
 	int nr_issued_ckpt, nr_total_ckpt, nr_queued_ckpt;
 	unsigned int cur_ckpt_time, peak_ckpt_time;
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
-	int compr_inode;
+	int compr_inode, swapfile_inode;
 	unsigned long long compr_blocks;
 	int aw_cnt, max_aw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
@@ -3952,6 +3953,10 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		(atomic64_add(blocks, &F2FS_I_SB(inode)->compr_blocks))
 #define stat_sub_compr_blocks(inode, blocks)				\
 		(atomic64_sub(blocks, &F2FS_I_SB(inode)->compr_blocks))
+#define stat_inc_swapfile_inode(inode)					\
+		(atomic_inc(&F2FS_I_SB(inode)->swapfile_inode))
+#define stat_dec_swapfile_inode(inode)					\
+		(atomic_dec(&F2FS_I_SB(inode)->swapfile_inode))
 #define stat_inc_meta_count(sbi, blkaddr)				\
 	do {								\
 		if (blkaddr < SIT_I(sbi)->sit_base_addr)		\
@@ -4036,6 +4041,8 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #define stat_dec_compr_inode(inode)			do { } while (0)
 #define stat_add_compr_blocks(inode, blocks)		do { } while (0)
 #define stat_sub_compr_blocks(inode, blocks)		do { } while (0)
+#define stat_inc_swapfile_inode(inode)			do { } while (0)
+#define stat_dec_swapfile_inode(inode)			do { } while (0)
 #define stat_update_max_atomic_write(inode)		do { } while (0)
 #define stat_inc_meta_count(sbi, blkaddr)		do { } while (0)
 #define stat_inc_seg_type(sbi, curseg)			do { } while (0)
-- 
2.25.1

