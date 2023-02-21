Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446FD69DCB1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjBUJR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjBUJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:17:26 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459B13DC0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:17:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VcBjLWD_1676971041;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcBjLWD_1676971041)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 17:17:22 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, zhujia.zj@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] erofs: set blksize to on-disk blksize for fscache mode
Date:   Tue, 21 Feb 2023 17:17:19 +0800
Message-Id: <20230221091719.126127-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230221091719.126127-1-jefflexu@linux.alibaba.com>
References: <20230221091719.126127-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since fscache mode has supported PAGE_SIZE other than 4KB, remove the
constraint and set to on-disk blksize.

We need to initialize the fscache context for the bootstrap before
setting the initial blksize as it will also update anonymous inode's
i_blkbits for the bootstrap.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 89011a4ed274..130e0f6db3c7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -709,6 +709,17 @@ static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context
 	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
 }
 
+static bool erofs_set_block_size(struct super_block *sb, unsigned int blkszbits)
+{
+	if (!erofs_is_fscache_mode(sb))
+		return sb_set_blocksize(sb, 1 << blkszbits);
+
+	sb->s_blocksize = 1 << blkszbits;
+	sb->s_blocksize_bits = blkszbits;
+	EROFS_SB(sb)->s_fscache->inode->i_blkbits = blkszbits;
+	return true;
+}
+
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -734,11 +745,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->domain_id = ctx->domain_id;
 	ctx->domain_id = NULL;
 
-	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fscache_mode(sb)) {
-		sb->s_blocksize = PAGE_SIZE;
-		sb->s_blocksize_bits = PAGE_SHIFT;
-
 		err = erofs_fscache_register_fs(sb);
 		if (err)
 			return err;
@@ -747,29 +754,24 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (err)
 			return err;
 	} else {
-		if (!sb_set_blocksize(sb, PAGE_SIZE)) {
-			errorfc(fc, "failed to set initial blksize");
-			return -EINVAL;
-		}
-
 		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
 						  &sbi->dax_part_off,
 						  NULL, NULL);
 	}
 
+	if (!erofs_set_block_size(sb, PAGE_SHIFT)) {
+		errorfc(fc, "failed to set initial blksize");
+		return -EINVAL;
+	}
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
 
-	if (sb->s_blocksize_bits != sbi->blkszbits) {
-		if (erofs_is_fscache_mode(sb)) {
-			errorfc(fc, "unsupported blksize for fscache mode");
-			return -EINVAL;
-		}
-		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
-			errorfc(fc, "failed to set erofs blksize");
-			return -EINVAL;
-		}
+	if (sb->s_blocksize_bits != sbi->blkszbits &&
+	    !erofs_set_block_size(sb, sbi->blkszbits)) {
+		errorfc(fc, "failed to set erofs blksize");
+		return -EINVAL;
 	}
 
 	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
-- 
2.19.1.6.gb485710b

