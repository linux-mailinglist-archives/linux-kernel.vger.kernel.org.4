Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C691A64F67C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLQArV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLQArK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:47:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5574F674
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:47:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D450B81E51
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 00:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C6C433F1;
        Sat, 17 Dec 2022 00:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671238026;
        bh=a+6qsiRsvE8gU7rhpY2cUbwxGERZ4kE0rv1dRLXXt8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4qZGtZTVI4OgZnBDUp8Hs73pxk2e/fRcYnWXZN1RSOFeFHlfqZ8fmo4G3X0HajZ5
         4bgk0icvdnFqDgYhjvY5rCIh6BFJuMOaSEgt22qNin/pLicekF3svjYu+fMlYCz4sW
         bFumKilV+CdPhAw0FP3YMdyhYCZsQZExbS6b0ZFP8moAa1yXlVmUurV8fVISw1zEgx
         e4NBlaN6xk7f0s9e/Aw8/91uy1mNYVwwYKQz/eOgIDkmAy+2UNrLeY47PeiIwcnLCi
         YQpbsPzwH+BBMO980sH6iqsLt94sqK7S2hq3i2JXI25P5E0pXAB8+hTELdbFeNYmNe
         U41CVH2Ko84KA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: initialize extent_cache parameter
Date:   Fri, 16 Dec 2022 16:46:57 -0800
Message-Id: <20221217004659.2092427-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221217004659.2092427-1-jaegeuk@kernel.org>
References: <20221217004659.2092427-1-jaegeuk@kernel.org>
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

This can avoid confusing tracepoint values.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c         | 2 +-
 fs/f2fs/extent_cache.c | 2 +-
 fs/f2fs/file.c         | 2 +-
 fs/f2fs/segment.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 505194c8a258..5f589b8b3b5c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2191,7 +2191,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	sector_t last_block_in_file;
 	const unsigned blocksize = blks_to_bytes(inode, 1);
 	struct decompress_io_ctx *dic = NULL;
-	struct extent_info ei = {0, };
+	struct extent_info ei = {};
 	bool from_dnode = true;
 	int i;
 	int ret = 0;
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 4721f5b0d8b3..749209005644 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -938,7 +938,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei)
 
 static void __update_extent_cache(struct dnode_of_data *dn, enum extent_type type)
 {
-	struct extent_info ei;
+	struct extent_info ei = {};
 
 	if (!__may_extent_tree(dn->inode, type))
 		return;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a22677345d23..a0c0e0e9e83d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2560,7 +2560,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	struct f2fs_map_blocks map = { .m_next_extent = NULL,
 					.m_seg_type = NO_CHECK_TYPE,
 					.m_may_create = false };
-	struct extent_info ei = {0, };
+	struct extent_info ei = {};
 	pgoff_t pg_start, pg_end, next_pgofs;
 	unsigned int blk_per_seg = sbi->blocks_per_seg;
 	unsigned int total = 0, sec_num;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e2af10d8132b..f8c76ef278df 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3159,7 +3159,7 @@ static int __get_segment_type_4(struct f2fs_io_info *fio)
 static int __get_age_segment_type(struct inode *inode, pgoff_t pgofs)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_info ei;
+	struct extent_info ei = {};
 
 	if (f2fs_lookup_age_extent_cache(inode, pgofs, &ei)) {
 		if (!ei.age)
-- 
2.39.0.314.g84b9a713c41-goog

