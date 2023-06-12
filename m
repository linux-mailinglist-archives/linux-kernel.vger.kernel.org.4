Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9597A72D051
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjFLUQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjFLUQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:16:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2089310CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1698620F0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A04C433EF;
        Mon, 12 Jun 2023 20:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686600990;
        bh=IFNcl3Qr1j61HWEFzbLwNkndMDHFIaUy4E04xrmndB0=;
        h=From:To:Cc:Subject:Date:From;
        b=IsYOGsxQ+G+xE05S99c1FUqdnyA5A0r8/EhbCRuw0sMxfM3FubILmfAFyp76cq/P7
         zptzsxHFMYtBoVTdMsHEzTlfx5nOMGpzYDZcOMVuSxFFO5qlaafRO4cvD+Ur51UHCo
         LMWALzfw00GkhIrmQLLs1p5fPwVgIX3+bTK4aDMtLrHrv6YubXRfuZkdHHVs8cqYhn
         mkyexby7SIRqonCAREHNet3KtO304KOyHvkgKcEFngMWEDGSqFTiwpwM/91mFPhBOw
         Zsf9bKzZE5+ui8xZwBp3TqLbUgLiilTi+xgKwcO6Q/WXX98y57cbfJB49ar+ASFgGf
         WCFL45smMkm8g==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: assign default compression level
Date:   Mon, 12 Jun 2023 13:16:26 -0700
Message-ID: <20230612201626.3768393-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
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

Let's avoid any confusion from assigning compress_level=0 for LZ4HC and ZSTD.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c |  3 +--
 fs/f2fs/f2fs.h     |  2 ++
 fs/f2fs/super.c    | 12 +++++++-----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1132d3cd8f33..438af59d3571 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -317,8 +317,6 @@ static const struct f2fs_compress_ops f2fs_lz4_ops = {
 #endif
 
 #ifdef CONFIG_F2FS_FS_ZSTD
-#define F2FS_ZSTD_DEFAULT_CLEVEL	1
-
 static int zstd_init_compress_ctx(struct compress_ctx *cc)
 {
 	zstd_parameters params;
@@ -327,6 +325,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	unsigned int workspace_size;
 	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
 
+	/* Need to remain this for backward compatibility */
 	if (!level)
 		level = F2FS_ZSTD_DEFAULT_CLEVEL;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4b249716ae7b..c61f728e1116 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1440,6 +1440,8 @@ struct compress_data {
 
 #define F2FS_COMPRESSED_PAGE_MAGIC	0xF5F2C000
 
+#define F2FS_ZSTD_DEFAULT_CLEVEL	1
+
 #define	COMPRESS_LEVEL_OFFSET	8
 
 /* compress context */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fd23caa1ed9..7162e55c4eb4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -589,14 +589,12 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 {
 #ifdef CONFIG_F2FS_FS_LZ4HC
 	unsigned int level;
-#endif
 
 	if (strlen(str) == 3) {
-		F2FS_OPTION(sbi).compress_level = 0;
+		F2FS_OPTION(sbi).compress_level = LZ4HC_DEFAULT_CLEVEL;
 		return 0;
 	}
 
-#ifdef CONFIG_F2FS_FS_LZ4HC
 	str += 3;
 
 	if (str[0] != ':') {
@@ -614,6 +612,10 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 	F2FS_OPTION(sbi).compress_level = level;
 	return 0;
 #else
+	if (strlen(str) == 3) {
+		F2FS_OPTION(sbi).compress_level = 0;
+		return 0;
+	}
 	f2fs_info(sbi, "kernel doesn't support lz4hc compression");
 	return -EINVAL;
 #endif
@@ -627,7 +629,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 	int len = 4;
 
 	if (strlen(str) == len) {
-		F2FS_OPTION(sbi).compress_level = 0;
+		F2FS_OPTION(sbi).compress_level = F2FS_ZSTD_DEFAULT_CLEVEL;
 		return 0;
 	}
 
@@ -640,7 +642,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 	if (kstrtouint(str + 1, 10, &level))
 		return -EINVAL;
 
-	if (!level || level > zstd_max_clevel()) {
+	if (level < zstd_min_clevel() || level > zstd_max_clevel()) {
 		f2fs_info(sbi, "invalid zstd compress level: %d", level);
 		return -EINVAL;
 	}
-- 
2.41.0.162.gfafddb0af9-goog

