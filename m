Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523A45B6CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiIMMKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiIMMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4C541D04
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98590B80E18
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 12:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1856C433C1;
        Tue, 13 Sep 2022 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663071017;
        bh=lUXTbzsYAvwyCD0dj6BBjjENOOHKM/L/iDGBcLQnHK8=;
        h=From:To:Cc:Subject:Date:From;
        b=C/LVvayC2S+B0QT5NE9QNjThqh3t1Bxfr12IsSefVMSpzrIQBioFgwy09LY+UzYFM
         fRbhVh8UCf9lTDEBwSdqCXXNX4qn6OrFTv8lJnid7oluYpHVGA7aNWyobvdHwT0uFP
         7+MHkn+IER5ldvsvXbfYe9NE+LzGrSTIxceiEX6+V2r5wNgeuPhDzx+DO8Y76COpYa
         zEOxQ1Amiab5J2a5OdlzoGSyFz5q7eZADf26js+zdOqoeC9N9mdydPEyrgu3YOuoFY
         QjJJv8DpeRjUEbudwOCjM3Kpr3cL43s2VXtLPurtRkb5/tELP1Vh28Pt25cRl3Hh8h
         bop2KSEphs8cQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [RFC PATCH] f2fs: record need_fsck in super_block
Date:   Tue, 13 Sep 2022 20:09:37 +0800
Message-Id: <20220913120937.2407940-1-chao@kernel.org>
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

Once CP_ERROR_FLAG is set, checkpoint is disallowed to be triggered to
persist CP_FSCK_FLAG, fsck won't repair the image due to lack of
CP_FSCK_FLAG.

This patch proposes to persist newly introduced SB_NEED_FSCK flag into
super block if CP_ERROR_FLAG and SBI_NEED_FSCK is set, later, once fsck
detect this flag, it can check and repair corrupted image in time.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c    |  6 +++++-
 fs/f2fs/f2fs.h          |  1 +
 fs/f2fs/inode.c         |  2 ++
 fs/f2fs/super.c         | 26 ++++++++++++++++++++++++++
 include/linux/f2fs_fs.h |  5 ++++-
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c3119e4c890c..0836fce40394 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -30,8 +30,12 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
 	f2fs_build_fault_attr(sbi, 0, 0);
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
-	if (!end_io)
+	if (!end_io) {
 		f2fs_flush_merged_writes(sbi);
+
+		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+			f2fs_update_sb_flags(sbi, SB_NEED_FSCK);
+	}
 }
 
 /*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dee7b67a17a6..1960a98c7555 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3556,6 +3556,7 @@ int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
 int f2fs_quota_sync(struct super_block *sb, int type);
 loff_t max_file_blocks(struct inode *inode);
 void f2fs_quota_off_umount(struct super_block *sb);
+void f2fs_update_sb_flags(struct f2fs_sb_info *sbi, unsigned int flag);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
 int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1baac6056733..0e38787bf35b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -706,6 +706,8 @@ void f2fs_update_inode_page(struct inode *inode)
 	struct page *node_page;
 retry:
 	node_page = f2fs_get_node_page(sbi, inode->i_ino);
+	f2fs_put_page(node_page, 1);
+	node_page = ERR_PTR(-EFSCORRUPTED);
 	if (IS_ERR(node_page)) {
 		int err = PTR_ERR(node_page);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b8e5fe244596..c99ba840593d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3846,6 +3846,32 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	return err;
 }
 
+void f2fs_update_sb_flags(struct f2fs_sb_info *sbi, unsigned int flag)
+{
+	unsigned short s_flags;
+	int err;
+
+	if (le16_to_cpu(F2FS_RAW_SUPER(sbi)->s_flags) & SB_NEED_FSCK)
+		return;
+
+	f2fs_down_write(&sbi->sb_lock);
+
+	s_flags = le16_to_cpu(F2FS_RAW_SUPER(sbi)->s_flags);
+
+	if (s_flags & SB_NEED_FSCK)
+		goto out_unlock;
+
+	F2FS_RAW_SUPER(sbi)->s_flags = cpu_to_le16(s_flags | SB_NEED_FSCK);
+
+	err = f2fs_commit_super(sbi, false);
+	if (err) {
+		f2fs_warn(sbi, "f2fs_commit_super fails to persist flag: %u, err:%d", flag, err);
+		F2FS_RAW_SUPER(sbi)->s_flags = s_flags;
+	}
+out_unlock:
+	f2fs_up_write(&sbi->sb_lock);
+}
+
 static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d445150c5350..124176e2a42c 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -73,6 +73,8 @@ struct f2fs_device {
 	__le32 total_segments;
 } __packed;
 
+#define SB_NEED_FSCK			0x00000001	/* need fsck */
+
 struct f2fs_super_block {
 	__le32 magic;			/* Magic Number */
 	__le16 major_ver;		/* Major Version */
@@ -116,7 +118,8 @@ struct f2fs_super_block {
 	__u8 hot_ext_count;		/* # of hot file extension */
 	__le16  s_encoding;		/* Filename charset encoding */
 	__le16  s_encoding_flags;	/* Filename charset encoding flags */
-	__u8 reserved[306];		/* valid reserved region */
+	__le16 s_flags;			/* super block flags */
+	__u8 reserved[304];		/* valid reserved region */
 	__le32 crc;			/* checksum of superblock */
 } __packed;
 
-- 
2.25.1

