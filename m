Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C782C67F721
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjA1Kar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjA1Kap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:30:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D758E078
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:30:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D583760B54
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 10:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2420C433D2;
        Sat, 28 Jan 2023 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674901843;
        bh=OMDEsR/xB/z0SbtzmwsGz8acuqAQkyyx6epXmkF9GwY=;
        h=From:To:Cc:Subject:Date:From;
        b=RGrGAPd6O4mkxgOFiBSp20wAkKOrmkt4+9ekn5hHIokC/1X3PVHAnGrcn8qsmDZKi
         FsmaAAqlRazIdBKzBqAtP23f11k1jZNllaVyi14CCV8vRv7gLWbyB9Aj2blILKBFHq
         47uqhACpKkRIDYOnVOIetvXhgDQF1rmj3IzMNAEi23k8fXcz8Ql+QDOO4KvDHRJt9s
         wMhJ+8J7iR8OcajHT8kfbCIWO8brIOQxyZ3G6o+BKawBhOXLMePpw70hFH3NiYCLzb
         JNaNMRBegqRjLCeLzyU/ax8XaoMxgT+zLXS0KaTi1URdwKK82rfRuMJKMPxB3eTgW9
         ZviESNjvuWtTw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: clean up i_compress_flag and i_compress_level usage
Date:   Sat, 28 Jan 2023 18:30:11 +0800
Message-Id: <20230128103011.1316979-1-chao@kernel.org>
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

.i_compress_level was introduced by commit 3fde13f817e2 ("f2fs: compress:
support compress level"), but never be used.

This patch updates as below:
- load high 8-bits of on-disk .i_compress_flag to in-memory .i_compress_level
- load low 8-bits of on-disk .i_compress_flag to in-memory .i_compress_flag
- change type of in-memory .i_compress_flag from unsigned short to unsigned
char.

w/ above changes, we can avoid unneeded bit shift whenever during
.init_compress_ctx(), and shrink size of struct f2fs_inode_info.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c |  8 +++-----
 fs/f2fs/f2fs.h     |  7 +++----
 fs/f2fs/inode.c    | 16 +++++++++++++---
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 365ee074d3b3..fdfa3d7c9ebe 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -241,7 +241,7 @@ static int lz4_init_compress_ctx(struct compress_ctx *cc)
 	unsigned int size = LZ4_MEM_COMPRESS;
 
 #ifdef CONFIG_F2FS_FS_LZ4HC
-	if (F2FS_I(cc->inode)->i_compress_flag >> COMPRESS_LEVEL_OFFSET)
+	if (F2FS_I(cc->inode)->i_compress_level)
 		size = LZ4HC_MEM_COMPRESS;
 #endif
 
@@ -267,8 +267,7 @@ static void lz4_destroy_compress_ctx(struct compress_ctx *cc)
 #ifdef CONFIG_F2FS_FS_LZ4HC
 static int lz4hc_compress_pages(struct compress_ctx *cc)
 {
-	unsigned char level = F2FS_I(cc->inode)->i_compress_flag >>
-						COMPRESS_LEVEL_OFFSET;
+	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
 	int len;
 
 	if (level)
@@ -340,8 +339,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	zstd_cstream *stream;
 	void *workspace;
 	unsigned int workspace_size;
-	unsigned char level = F2FS_I(cc->inode)->i_compress_flag >>
-						COMPRESS_LEVEL_OFFSET;
+	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
 
 	if (!level)
 		level = F2FS_ZSTD_DEFAULT_CLEVEL;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b78e28928a0b..631ef653aaa5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -881,7 +881,7 @@ struct f2fs_inode_info {
 	unsigned char i_compress_algorithm;	/* algorithm type */
 	unsigned char i_log_cluster_size;	/* log of cluster size */
 	unsigned char i_compress_level;		/* compress level (lz4hc,zstd) */
-	unsigned short i_compress_flag;		/* compress flag */
+	unsigned char i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
 
 	unsigned int atomic_write_cnt;
@@ -4392,9 +4392,8 @@ static inline int set_compress_context(struct inode *inode)
 	if ((F2FS_I(inode)->i_compress_algorithm == COMPRESS_LZ4 ||
 		F2FS_I(inode)->i_compress_algorithm == COMPRESS_ZSTD) &&
 			F2FS_OPTION(sbi).compress_level)
-		F2FS_I(inode)->i_compress_flag |=
-				F2FS_OPTION(sbi).compress_level <<
-				COMPRESS_LEVEL_OFFSET;
+		F2FS_I(inode)->i_compress_level =
+				F2FS_OPTION(sbi).compress_level;
 	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
 	set_inode_flag(inode, FI_COMPRESSED_FILE);
 	stat_inc_compr_inode(inode);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index a66c5338ca67..dbf98a295a30 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -460,11 +460,17 @@ static int do_read_inode(struct inode *inode)
 					(fi->i_flags & F2FS_COMPR_FL)) {
 		if (F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
 					i_log_cluster_size)) {
+			unsigned short compress_flag;
+
 			atomic_set(&fi->i_compr_blocks,
 					le64_to_cpu(ri->i_compr_blocks));
 			fi->i_compress_algorithm = ri->i_compress_algorithm;
 			fi->i_log_cluster_size = ri->i_log_cluster_size;
-			fi->i_compress_flag = le16_to_cpu(ri->i_compress_flag);
+			compress_flag = le16_to_cpu(ri->i_compress_flag);
+			fi->i_compress_level = compress_flag >>
+						COMPRESS_LEVEL_OFFSET;
+			fi->i_compress_flag = compress_flag &
+					(BIT(COMPRESS_LEVEL_OFFSET) - 1);
 			fi->i_cluster_size = 1 << fi->i_log_cluster_size;
 			set_inode_flag(inode, FI_COMPRESSED_FILE);
 		}
@@ -686,13 +692,17 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 		if (f2fs_sb_has_compression(F2FS_I_SB(inode)) &&
 			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
 							i_log_cluster_size)) {
+			unsigned short compress_flag;
+
 			ri->i_compr_blocks =
 				cpu_to_le64(atomic_read(
 					&F2FS_I(inode)->i_compr_blocks));
 			ri->i_compress_algorithm =
 				F2FS_I(inode)->i_compress_algorithm;
-			ri->i_compress_flag =
-				cpu_to_le16(F2FS_I(inode)->i_compress_flag);
+			compress_flag = F2FS_I(inode)->i_compress_flag |
+				F2FS_I(inode)->i_compress_level <<
+						COMPRESS_LEVEL_OFFSET;
+			ri->i_compress_flag = cpu_to_le16(compress_flag);
 			ri->i_log_cluster_size =
 				F2FS_I(inode)->i_log_cluster_size;
 		}
-- 
2.25.1

