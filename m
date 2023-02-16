Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B862699063
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBPJrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPJrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:47:51 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D412D45
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:47:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vbo.2zn_1676540866;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vbo.2zn_1676540866)
          by smtp.aliyun-inc.com;
          Thu, 16 Feb 2023 17:47:47 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.or, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] erofs: set block size to the on-disk block size
Date:   Thu, 16 Feb 2023 17:47:45 +0800
Message-Id: <20230216094745.47868-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230216094745.47868-1-jefflexu@linux.alibaba.com>
References: <20230216094745.47868-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the block size to that specified in on-disk superblock.

Also remove the hard constraint of PAGE_SIZE block size for the
uncompressed device backend.  This constraint is temporarily remained
for compressed device and fscache backend, as there is more work needed
to handle the condition where the block size is not equal to PAGE_SIZE.

It is worth noting that the on-disk block size is read prior to
erofs_superblock_csum_verify(), as the read block size is needed in the
latter.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  2 +-
 fs/erofs/inode.c    |  3 ++-
 fs/erofs/internal.h |  8 --------
 fs/erofs/super.c    | 42 +++++++++++++++++++++++++++---------------
 4 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index dbcd24371002..5c7647d68c07 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -53,7 +53,7 @@ struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
 	__le32 checksum;        /* crc32c(super_block) */
 	__le32 feature_compat;
-	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
+	__u8 blkszbits;         /* filesystem block size */
 	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
 
 	__le16 root_nid;	/* nid of root directory */
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 90bcc5bd758e..20affdd766f8 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -291,7 +291,8 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		if (!erofs_is_fscache_mode(inode->i_sb))
+		if (!erofs_is_fscache_mode(inode->i_sb) &&
+		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
 			err = z_erofs_fill_inode(inode);
 		else
 			err = -EOPNOTSUPP;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8a85e7af5c92..a4986b91d46d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -240,14 +240,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 					VAL != EROFS_LOCKED_MAGIC);
 }
 
-/* we strictly follow PAGE_SIZE and no buffer head yet */
-#define LOG_BLOCK_SIZE		PAGE_SHIFT
-#define EROFS_BLKSIZ		(1 << LOG_BLOCK_SIZE)
-
-#if (EROFS_BLKSIZ % 4096 || !EROFS_BLKSIZ)
-#error erofs cannot be used in this platform
-#endif
-
 enum erofs_kmap_type {
 	EROFS_NO_KMAP,		/* don't map the buffer */
 	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cd5a537969e0..c54d02466f2a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -350,6 +350,14 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
+	blkszbits = dsb->blkszbits;
+	sbi->blkszbits = dsb->blkszbits;
+	if (blkszbits < 9 || blkszbits > PAGE_SHIFT) {
+		erofs_err(sb, "blkszbits %u isn't supported on this platform",
+			  blkszbits);
+		goto out;
+	}
+
 	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
 	if (erofs_sb_has_sb_chksum(sbi)) {
 		ret = erofs_superblock_csum_verify(sb, data);
@@ -358,19 +366,11 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 
 	ret = -EINVAL;
-	blkszbits = dsb->blkszbits;
-	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
-	if (blkszbits != LOG_BLOCK_SIZE) {
-		erofs_err(sb, "blkszbits %u isn't supported on this platform",
-			  blkszbits);
-		goto out;
-	}
-
 	if (!check_layout_compatibility(sb, dsb))
 		goto out;
 
 	sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
-	if (sbi->sb_size > EROFS_BLKSIZ) {
+	if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
 		erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
 			  sbi->sb_size);
 		goto out;
@@ -737,8 +737,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fscache_mode(sb)) {
-		sb->s_blocksize = EROFS_BLKSIZ;
-		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
+		sb->s_blocksize = PAGE_SIZE;
+		sb->s_blocksize_bits = PAGE_SHIFT;
 
 		err = erofs_fscache_register_fs(sb);
 		if (err)
@@ -748,8 +748,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (err)
 			return err;
 	} else {
-		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
-			erofs_err(sb, "failed to set erofs blksize");
+		if (!sb_set_blocksize(sb, PAGE_SIZE)) {
+			errorfc(fc, "failed to set initial blksize");
 			return -EINVAL;
 		}
 
@@ -762,12 +762,24 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
-		BUILD_BUG_ON(EROFS_BLKSIZ != PAGE_SIZE);
+	if (sb->s_blocksize_bits != sbi->blkszbits) {
+		if (erofs_is_fscache_mode(sb)) {
+			errorfc(fc, "unsupported blksize for fscache mode");
+			return -EINVAL;
+		}
+		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
+			errorfc(fc, "failed to set erofs blksize");
+			return -EINVAL;
+		}
+	}
 
+	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
 		if (!sbi->dax_dev) {
 			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
 			clear_opt(&sbi->opt, DAX_ALWAYS);
+		} else if (sbi->blkszbits != PAGE_SHIFT) {
+			errorfc(fc, "unsupported blocksize for DAX");
+			clear_opt(&sbi->opt, DAX_ALWAYS);
 		}
 	}
 
-- 
2.19.1.6.gb485710b

