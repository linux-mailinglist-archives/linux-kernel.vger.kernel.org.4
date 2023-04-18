Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADC16E68BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjDRP4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDRP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98AE6C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9E586360F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B6CC4339C;
        Tue, 18 Apr 2023 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681833360;
        bh=XhwoNE3hOdeXm3s+cs5zqqi+93Su9LmADaKSVChDM2I=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=PfQ9eUr/S32fmXcHSFrwvsb934TYobydU7TP+e6wnQ2EolewCWl5IA9dTA5wx1qMt
         shR08XyFA2QhXj9FIYt3zbg3KZFAhkswTdnStiypaKQxJx03lE7V4Du9eCUC735T+0
         E0pJe4GexJYeSRDZU+1jMUT9kOZhsxI8fz8g5X916YnkjQF+aOZDRppBjwqysQvtBC
         4kISwa+gwDQJYF7wKpU1TBqmTiwT3xKNqNrJR2f1rFfmpBj2Ya6BrkYAK95bOZl+4F
         k+KsAqvPphboEDB7l32GNBcuMu702NoURj9KofWQyVpvvr1xKi0xJXJrniFbasLGfi
         LttiF0fswNytA==
Date:   Tue, 18 Apr 2023 08:55:58 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: remove power-of-two limitation fo zoned device
Message-ID: <ZD69jto/SFPycuHm@google.com>
References: <20230418004049.3262659-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418004049.3262659-1-jaegeuk@kernel.org>
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

 Change log from v1:
  - fix udiv

 fs/f2fs/f2fs.h    | 3 +--
 fs/f2fs/gc.c      | 4 ++--
 fs/f2fs/segment.c | 2 +-
 fs/f2fs/super.c   | 8 ++------
 4 files changed, 6 insertions(+), 11 deletions(-)

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
index a6a0dc471b74..61c5f9d26018 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2093,8 +2093,8 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 		FDEV(last_dev).end_blk =
 				(long long)FDEV(last_dev).end_blk + blks;
 #ifdef CONFIG_BLK_DEV_ZONED
-		FDEV(last_dev).nr_blkz = (int)FDEV(last_dev).nr_blkz +
-					(int)(blks >> sbi->log_blocks_per_blkz);
+		FDEV(last_dev).nr_blkz = FDEV(last_dev).nr_blkz +
+					div_u64(blks, sbi->blocks_per_blkz);
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
index 4e53b1100b84..9f15b03037db 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3806,12 +3806,8 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 				SECTOR_TO_BLOCK(zone_sectors))
 		return -EINVAL;
 	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(zone_sectors);
-	if (sbi->log_blocks_per_blkz && sbi->log_blocks_per_blkz !=
-				__ilog2_u32(sbi->blocks_per_blkz))
-		return -EINVAL;
-	sbi->log_blocks_per_blkz = __ilog2_u32(sbi->blocks_per_blkz);
-	FDEV(devi).nr_blkz = SECTOR_TO_BLOCK(nr_sectors) >>
-					sbi->log_blocks_per_blkz;
+	FDEV(devi).nr_blkz = div_u64(SECTOR_TO_BLOCK(nr_sectors),
+					sbi->blocks_per_blkz);
 	if (nr_sectors & (zone_sectors - 1))
 		FDEV(devi).nr_blkz++;
 
-- 
2.40.0.634.g4ca3ef3211-goog

