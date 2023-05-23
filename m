Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA60670DCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjEWMfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjEWMfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6605118
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 595E0631B1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996DFC433EF;
        Tue, 23 May 2023 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684845328;
        bh=5URJ0niupsFX+DKwvQymh4lC2dqDWe3nA3EpbyGLCMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BavkA/EXyBhl+LzyUGOz7k0/foOqHh6AVOumTFGjo8pIFxeBJG6j6mfZ1Y57sOeft
         BGq9k0WlLazMd/LvKexUp0/uOIsoU36fAfgZNY3qIpN6wlwbPh+jxkfHU/VbYqSZz3
         bOw6/H3H9n3f4UIy1MjlKISHausqPgXUiblgcfusfsZs/aIN8xzvxD+9A+08sdYNJm
         3g5JCx1fuxpIeyFxNNBke/AF4dkWbFOQDDZGB9WqHW0S/XZVmapz/oBL6NJRFaJoPE
         rIbOBLpWzHibC6ejzpz3XM1oxZosBy9PbsOUUG1cGnUeKAjOPaAmUHu4ejD6dFAxAA
         a5mjuJMXqDy/A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: clean up w/ sbi->log_sectors_per_block
Date:   Tue, 23 May 2023 20:35:21 +0800
Message-Id: <20230523123521.67656-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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

Use sbi->log_sectors_per_block to clean up below calculated one:

unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 43d537d29b52..9282399cc810 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4768,17 +4768,17 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 {
 	unsigned int wp_segno, wp_blkoff, zone_secno, zone_segno, segno;
 	block_t zone_block, wp_block, last_valid_block;
-	unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
 	int i, s, b, ret;
 	struct seg_entry *se;
 
 	if (zone->type != BLK_ZONE_TYPE_SEQWRITE_REQ)
 		return 0;
 
-	wp_block = fdev->start_blk + (zone->wp >> log_sectors_per_block);
+	wp_block = fdev->start_blk + (zone->wp >> sbi->log_sectors_per_block);
 	wp_segno = GET_SEGNO(sbi, wp_block);
 	wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
-	zone_block = fdev->start_blk + (zone->start >> log_sectors_per_block);
+	zone_block = fdev->start_blk + (zone->start >>
+						sbi->log_sectors_per_block);
 	zone_segno = GET_SEGNO(sbi, zone_block);
 	zone_secno = GET_SEC_FROM_SEG(sbi, zone_segno);
 
@@ -4824,7 +4824,7 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 			    "pointer. Reset the write pointer: wp[0x%x,0x%x]",
 			    wp_segno, wp_blkoff);
 		ret = __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_block,
-					zone->len >> log_sectors_per_block);
+				zone->len >> sbi->log_sectors_per_block);
 		if (ret)
 			f2fs_err(sbi, "Discard zone failed: %s (errno=%d)",
 				 fdev->path, ret);
@@ -4885,7 +4885,6 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	struct blk_zone zone;
 	unsigned int cs_section, wp_segno, wp_blkoff, wp_sector_off;
 	block_t cs_zone_block, wp_block;
-	unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
 	sector_t zone_sector;
 	int err;
 
@@ -4897,8 +4896,8 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 		return 0;
 
 	/* report zone for the sector the curseg points to */
-	zone_sector = (sector_t)(cs_zone_block - zbd->start_blk)
-		<< log_sectors_per_block;
+	zone_sector = (sector_t)(cs_zone_block - zbd->start_blk) <<
+						sbi->log_sectors_per_block;
 	err = blkdev_report_zones(zbd->bdev, zone_sector, 1,
 				  report_one_zone_cb, &zone);
 	if (err != 1) {
@@ -4910,10 +4909,10 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	if (zone.type != BLK_ZONE_TYPE_SEQWRITE_REQ)
 		return 0;
 
-	wp_block = zbd->start_blk + (zone.wp >> log_sectors_per_block);
+	wp_block = zbd->start_blk + (zone.wp >> sbi->log_sectors_per_block);
 	wp_segno = GET_SEGNO(sbi, wp_block);
 	wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
-	wp_sector_off = zone.wp & GENMASK(log_sectors_per_block - 1, 0);
+	wp_sector_off = zone.wp & GENMASK(sbi->log_sectors_per_block - 1, 0);
 
 	if (cs->segno == wp_segno && cs->next_blkoff == wp_blkoff &&
 		wp_sector_off == 0)
@@ -4940,8 +4939,8 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	if (!zbd)
 		return 0;
 
-	zone_sector = (sector_t)(cs_zone_block - zbd->start_blk)
-		<< log_sectors_per_block;
+	zone_sector = (sector_t)(cs_zone_block - zbd->start_blk) <<
+						sbi->log_sectors_per_block;
 	err = blkdev_report_zones(zbd->bdev, zone_sector, 1,
 				  report_one_zone_cb, &zone);
 	if (err != 1) {
@@ -4959,7 +4958,7 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 			    "Reset the zone: curseg[0x%x,0x%x]",
 			    type, cs->segno, cs->next_blkoff);
 		err = __f2fs_issue_discard_zone(sbi, zbd->bdev,	cs_zone_block,
-					zone.len >> log_sectors_per_block);
+					zone.len >> sbi->log_sectors_per_block);
 		if (err) {
 			f2fs_err(sbi, "Discard zone failed: %s (errno=%d)",
 				 zbd->path, err);
-- 
2.40.1

