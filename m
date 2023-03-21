Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFB46C3E50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCUXMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCUXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:12:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9070D58C3D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:12:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48ECDB81A3C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D9EC433EF;
        Tue, 21 Mar 2023 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679440319;
        bh=LqxLIrrbcTEUIKFvohX7QfSRI4ssWYPirw+0Jq92hLU=;
        h=From:To:Cc:Subject:Date:From;
        b=Tkh2eSZreiY8+7oliQ0G8kMG6ypRH6+TNgCwx5nG6STgajOVdzd206T8D4nk8sNdN
         uf1nRhzKtFrK8dpDNFZZWQcoD8mcOvt6b3yhggXUVKEP7au7sks2r+X6oG084I7hDi
         dVrgVkpE4lHPZzBOzwqzLV5qy90q5iosHHKkOrQtvkpBn8KUVgMZFTlKvf8IabZIjZ
         QZlc5KQCnS5tO8Xw8A/NnWPSaYXXJoV6KgRycpny5H95BaNhUxXdFx01EjqbtTvwAK
         j7Sfn89zHnVbfjb+SCMaiBFYq4UHPz0U7joBxP6QAwZctVD44SkmG3g98HcBMsSfrw
         vId62QZBaaLng==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: apply zone capacity to all zone type
Date:   Tue, 21 Mar 2023 16:11:57 -0700
Message-Id: <20230321231157.963598-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we manage the zone capacity per zone type, it'll break the GC assumption.
And, the current logic complains valid block count mismatch.
Let's apply zone capacity to all zone type, if specified.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 65 +++--------------------------------------------
 fs/f2fs/segment.h |  3 +++
 2 files changed, 7 insertions(+), 61 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 055e70e77aa2..6c11789da884 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4999,48 +4999,6 @@ int f2fs_check_write_pointer(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-static bool is_conv_zone(struct f2fs_sb_info *sbi, unsigned int zone_idx,
-						unsigned int dev_idx)
-{
-	if (!bdev_is_zoned(FDEV(dev_idx).bdev))
-		return true;
-	return !test_bit(zone_idx, FDEV(dev_idx).blkz_seq);
-}
-
-/* Return the zone index in the given device */
-static unsigned int get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
-					int dev_idx)
-{
-	block_t sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
-
-	return (sec_start_blkaddr - FDEV(dev_idx).start_blk) >>
-						sbi->log_blocks_per_blkz;
-}
-
-/*
- * Return the usable segments in a section based on the zone's
- * corresponding zone capacity. Zone is equal to a section.
- */
-static inline unsigned int f2fs_usable_zone_segs_in_sec(
-		struct f2fs_sb_info *sbi, unsigned int segno)
-{
-	unsigned int dev_idx, zone_idx;
-
-	dev_idx = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
-	zone_idx = get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno), dev_idx);
-
-	/* Conventional zone's capacity is always equal to zone size */
-	if (is_conv_zone(sbi, zone_idx, dev_idx))
-		return sbi->segs_per_sec;
-
-	if (!sbi->unusable_blocks_per_sec)
-		return sbi->segs_per_sec;
-
-	/* Get the segment count beyond zone capacity block */
-	return sbi->segs_per_sec - (sbi->unusable_blocks_per_sec >>
-						sbi->log_blocks_per_seg);
-}
-
 /*
  * Return the number of usable blocks in a segment. The number of blocks
  * returned is always equal to the number of blocks in a segment for
@@ -5053,23 +5011,13 @@ static inline unsigned int f2fs_usable_zone_blks_in_seg(
 			struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
-	unsigned int zone_idx, dev_idx, secno;
-
-	secno = GET_SEC_FROM_SEG(sbi, segno);
-	seg_start = START_BLOCK(sbi, segno);
-	dev_idx = f2fs_target_device_index(sbi, seg_start);
-	zone_idx = get_zone_idx(sbi, secno, dev_idx);
-
-	/*
-	 * Conventional zone's capacity is always equal to zone size,
-	 * so, blocks per segment is unchanged.
-	 */
-	if (is_conv_zone(sbi, zone_idx, dev_idx))
-		return sbi->blocks_per_seg;
+	unsigned int secno;
 
 	if (!sbi->unusable_blocks_per_sec)
 		return sbi->blocks_per_seg;
 
+	secno = GET_SEC_FROM_SEG(sbi, segno);
+	seg_start = START_BLOCK(sbi, segno);
 	sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
 	sec_cap_blkaddr = sec_start_blkaddr + CAP_BLKS_PER_SEC(sbi);
 
@@ -5103,11 +5051,6 @@ static inline unsigned int f2fs_usable_zone_blks_in_seg(struct f2fs_sb_info *sbi
 	return 0;
 }
 
-static inline unsigned int f2fs_usable_zone_segs_in_sec(struct f2fs_sb_info *sbi,
-							unsigned int segno)
-{
-	return 0;
-}
 #endif
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
 					unsigned int segno)
@@ -5122,7 +5065,7 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 					unsigned int segno)
 {
 	if (f2fs_sb_has_blkzoned(sbi))
-		return f2fs_usable_zone_segs_in_sec(sbi, segno);
+		return CAP_SEGS_PER_SEC(sbi);
 
 	return sbi->segs_per_sec;
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index efdb7fc3b797..babb29a1c034 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -104,6 +104,9 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define CAP_BLKS_PER_SEC(sbi)					\
 	((sbi)->segs_per_sec * (sbi)->blocks_per_seg -		\
 	 (sbi)->unusable_blocks_per_sec)
+#define CAP_SEGS_PER_SEC(sbi)					\
+	((sbi)->segs_per_sec - ((sbi)->unusable_blocks_per_sec >>\
+	(sbi)->log_blocks_per_seg))
 #define GET_SEC_FROM_SEG(sbi, segno)				\
 	(((segno) == -1) ? -1: (segno) / (sbi)->segs_per_sec)
 #define GET_SEG_FROM_SEC(sbi, secno)				\
-- 
2.40.0.rc1.284.g88254d51c5-goog

