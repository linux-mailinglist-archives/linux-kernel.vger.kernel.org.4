Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F576E55F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjDRAky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRAkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A30435BC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:40:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17AFC61272
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C10C433D2;
        Tue, 18 Apr 2023 00:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681778450;
        bh=Krcthgy/LtBAbgtwEWXCvP7D8f3/FPztsZJremvZ+pc=;
        h=From:To:Cc:Subject:Date:From;
        b=AKN4e+dc/NrZ1J0iY7FvCl3YxkSnnDvmqDcQmi9dHi0r90pQUbEvY1N8Oi+AgT+yW
         8JJ82dqNVEkZrDqenv7WTZn+L9QptitG+lZ8XsWMsQr1zu9PodE1lyKO+V9CO2rnPA
         3KgNF3Nh4ItUAFjvDbKlr6WjgZr8b3zHpXLBmwMMuaNJpPPSWtAWqrbKbeKKelQQAJ
         bAWKAtL2NagrCrRZwUP1L3NWd5KVr8omIecC0dfdQsOKGT2RWpDSDnslxM1VfoSjRI
         pp9QSSFuQKCfDYNWoI2a0621GBUtHC+Ap2gSnPzvJSeeE2u41VMzhRm7d82dykff0v
         aiHnZPqgOMkiw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: remove power-of-two limitation fo zoned device
Date:   Mon, 17 Apr 2023 17:40:49 -0700
Message-ID: <20230418004049.3262659-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs, there's no reason to force po2.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    | 3 +--
 fs/f2fs/gc.c      | 2 +-
 fs/f2fs/segment.c | 2 +-
 fs/f2fs/super.c   | 7 +------
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6cae94d51821..d8cb1dc09f9f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1523,7 +1523,6 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
-	unsigned int log_blocks_per_blkz;	/* log2 F2FS blocks per zone */
 #endif
 
 	/* for node-related operations */
@@ -4377,7 +4376,7 @@ F2FS_FEATURE_FUNCS(readonly, RO);
 static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
 				    block_t blkaddr)
 {
-	unsigned int zno = blkaddr >> sbi->log_blocks_per_blkz;
+	unsigned int zno = blkaddr / sbi->blocks_per_blkz;
 
 	return test_bit(zno, FDEV(devi).blkz_seq);
 }
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a6a0dc471b74..d69b5c7544eb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2094,7 +2094,7 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 				(long long)FDEV(last_dev).end_blk + blks;
 #ifdef CONFIG_BLK_DEV_ZONED
 		FDEV(last_dev).nr_blkz = (int)FDEV(last_dev).nr_blkz +
-					(int)(blks >> sbi->log_blocks_per_blkz);
+					(int)(blks / sbi->blocks_per_blkz);
 #endif
 	}
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c35476b3c075..641bd8cc54da 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2075,7 +2075,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 
 		if (force && start >= cpc->trim_start &&
 					(end - 1) <= cpc->trim_end)
-				continue;
+			continue;
 
 		/* Should cover 2MB zoned device for zone-based reset */
 		if (!f2fs_sb_has_blkzoned(sbi) &&
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4e53b1100b84..5e4cd0249ffd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3806,12 +3806,7 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 				SECTOR_TO_BLOCK(zone_sectors))
 		return -EINVAL;
 	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(zone_sectors);
-	if (sbi->log_blocks_per_blkz && sbi->log_blocks_per_blkz !=
-				__ilog2_u32(sbi->blocks_per_blkz))
-		return -EINVAL;
-	sbi->log_blocks_per_blkz = __ilog2_u32(sbi->blocks_per_blkz);
-	FDEV(devi).nr_blkz = SECTOR_TO_BLOCK(nr_sectors) >>
-					sbi->log_blocks_per_blkz;
+	FDEV(devi).nr_blkz = SECTOR_TO_BLOCK(nr_sectors) / sbi->blocks_per_blkz;
 	if (nr_sectors & (zone_sectors - 1))
 		FDEV(devi).nr_blkz++;
 
-- 
2.40.0.634.g4ca3ef3211-goog

