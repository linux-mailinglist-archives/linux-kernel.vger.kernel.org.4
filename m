Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E78A5B8929
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiINN27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiINN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:28:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F29D726AF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE57461D49
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 13:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1AEC433D6;
        Wed, 14 Sep 2022 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663162131;
        bh=E4CG/uVxqLXXkaNtctKrymdDq/k2+WAbudBecN2Fbfo=;
        h=From:To:Cc:Subject:Date:From;
        b=VwnBEbuzZuQBkQc4CKSsLQqaKS0BUAz5wtDdp4fKwabqqZZJp07/5BEV9bXnz9JJ2
         mjRK5XalLA8ORgzytLsW611ZYyAPWFIhSJy7Lct7Hb5O4bqySxV84c7e6Lt6NkccVJ
         xSRi5F4TBDtMdkwEHyCtkjcXUft7TkmWYt/KFkWfd6e0M/0z8/0QAlCV3OH+QgcwCI
         O+lbNRd4QqOYOBcZTZ6zyMfZrVrF37kRbGiC6XZI7ws537bGnKdg5LWerzUvLlY0Is
         XcQcnWSPvgb8w0CYazUtudHRnY86cmjy9VkuxHVVlqDe0JO9MJJRK7FVpgUFEbkja5
         TpVTLevNzQ+Vw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to account FS_CP_DATA_IO correctly
Date:   Wed, 14 Sep 2022 21:28:46 +0800
Message-Id: <20220914132846.3035147-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_inode_info.cp_task was introduced for FS_CP_DATA_IO accounting
since commit b0af6d491a6b ("f2fs: add app/fs io stat").

However, cp_task usage coverage has been increased due to below
commits:
commit 040d2bb318d1 ("f2fs: fix to avoid deadloop if data_flush is on")
commit 186857c5a14a ("f2fs: fix potential recursive call when enabling data_flush")

So that, if data_flush mountoption is on, when data flush was
triggered from background, the IO from data flush will be accounted
as checkpoint IO type incorrectly.

In order to fix this issue, this patch splits cp_task into two:
a) cp_task: used for IO accounting
b) wb_task: used to avoid deadlock

Fixes: commit 040d2bb318d1 ("f2fs: fix to avoid deadloop if data_flush is on")
Fixes: commit 186857c5a14a ("f2fs: fix potential recursive call when enabling data_flush")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 13 +++++++++----
 fs/f2fs/data.c       |  4 ++--
 fs/f2fs/f2fs.h       |  4 +++-
 fs/f2fs/segment.c    |  2 +-
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0b0e0cc7801e..f9e53ece0442 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1066,7 +1066,8 @@ void f2fs_remove_dirty_inode(struct inode *inode)
 	spin_unlock(&sbi->inode_lock[type]);
 }
 
-int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
+int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
+						bool from_cp)
 {
 	struct list_head *head;
 	struct inode *inode;
@@ -1101,11 +1102,15 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 	if (inode) {
 		unsigned long cur_ino = inode->i_ino;
 
-		F2FS_I(inode)->cp_task = current;
+		if (from_cp)
+			F2FS_I(inode)->cp_task = current;
+		F2FS_I(inode)->wb_task = current;
 
 		filemap_fdatawrite(inode->i_mapping);
 
-		F2FS_I(inode)->cp_task = NULL;
+		F2FS_I(inode)->wb_task = NULL;
+		if (from_cp)
+			F2FS_I(inode)->cp_task = NULL;
 
 		iput(inode);
 		/* We need to give cpu to another writers. */
@@ -1234,7 +1239,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	/* write all the dirty dentry pages */
 	if (get_pages(sbi, F2FS_DIRTY_DENTS)) {
 		f2fs_unlock_all(sbi);
-		err = f2fs_sync_dirty_inodes(sbi, DIR_INODE);
+		err = f2fs_sync_dirty_inodes(sbi, DIR_INODE, true);
 		if (err)
 			return err;
 		cond_resched();
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6cd29a575105..c2ad0c375710 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2856,7 +2856,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	}
 	unlock_page(page);
 	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode) &&
-			!F2FS_I(inode)->cp_task && allow_balance)
+			!F2FS_I(inode)->wb_task && allow_balance)
 		f2fs_balance_fs(sbi, need_balance_fs);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -3156,7 +3156,7 @@ static inline bool __should_serialize_io(struct inode *inode,
 					struct writeback_control *wbc)
 {
 	/* to avoid deadlock in path of data flush */
-	if (F2FS_I(inode)->cp_task)
+	if (F2FS_I(inode)->wb_task)
 		return false;
 
 	if (!S_ISREG(inode->i_mode))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1960a98c7555..4e5fadcdccaf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -786,6 +786,7 @@ struct f2fs_inode_info {
 	unsigned int clevel;		/* maximum level of given file name */
 	struct task_struct *task;	/* lookup and create consistency */
 	struct task_struct *cp_task;	/* separate cp/wb IO stats*/
+	struct task_struct *wb_task;	/* indicate inode is in context of writeback */
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
 	loff_t	last_disk_size;		/* lastly written file size */
 	spinlock_t i_size_lock;		/* protect last_disk_size */
@@ -3747,7 +3748,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi);
 int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi);
 void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio);
 void f2fs_remove_dirty_inode(struct inode *inode);
-int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type);
+int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
+								bool from_cp);
 void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type);
 u64 f2fs_get_sectors_written(struct f2fs_sb_info *sbi);
 int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7a5ddfd71223..5b59be62b97d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -476,7 +476,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 		mutex_lock(&sbi->flush_lock);
 
 		blk_start_plug(&plug);
-		f2fs_sync_dirty_inodes(sbi, FILE_INODE);
+		f2fs_sync_dirty_inodes(sbi, FILE_INODE, false);
 		blk_finish_plug(&plug);
 
 		mutex_unlock(&sbi->flush_lock);
-- 
2.25.1

