Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A862D694E88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjBMR7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjBMR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:59:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC3C1EFFB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A583DB81662
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42477C433EF;
        Mon, 13 Feb 2023 17:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676311145;
        bh=4TNAbVL+S8I0w9YW/3y8y9MsZXwnOgdDxamCrv1+fAQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=r+Rh7D4IKpcPe+H5JuK1VEsd/oLc7SSmKDkSwry0ktsXpNDB3HsJN5TFRff/IPFyB
         4dfJX8H3GKvY1Dc0FsxOKa4vB31RUcw7KHCCRFwHyIrzQMuwave9wWZc+gE1CsaTPk
         pT3pfptDQJkskGf2hzmI0Kk31vlAdVv4qydszlgMH/t3S/hS9YoDikdLP+/eloJNEL
         Lh2dRxq0zgu8l0HtzsuhatouupTM6IpBjrjKuW6fJCAASl4s0BOLIT3G9XDFFhCS9M
         Zt96lw6w6Veygy5cV8RJvUxOmXwZQw4aO5dhrLvWduES3jWvisNyZ7MCzVFwsdUHCP
         ONsgWR63bsq5Q==
Date:   Mon, 13 Feb 2023 09:59:03 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: fix wrong segment count
Message-ID: <Y+p6ZwXxzlRCdfG2@google.com>
References: <20230210213250.3471246-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210213250.3471246-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAIN_SEGS is for data area, while TOTAL_SEGS includes data and metadata.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - replace check_seg_range with valid_main_segno to avoid confusion.

 fs/f2fs/segment.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 92c8be00d396..efdb7fc3b797 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -719,9 +719,10 @@ static inline unsigned char curseg_alloc_type(struct f2fs_sb_info *sbi,
 	return curseg->alloc_type;
 }
 
-static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
+static inline bool valid_main_segno(struct f2fs_sb_info *sbi,
+		unsigned int segno)
 {
-	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
+	return segno <= (MAIN_SEGS(sbi) - 1);
 }
 
 static inline void verify_fio_blkaddr(struct f2fs_io_info *fio)
@@ -776,7 +777,7 @@ static inline int check_block_count(struct f2fs_sb_info *sbi,
 
 	/* check segment usage, and check boundary of a given segment number */
 	if (unlikely(GET_SIT_VBLOCKS(raw_sit) > usable_blks_per_seg
-					|| segno > TOTAL_SEGS(sbi) - 1)) {
+					|| !valid_main_segno(sbi, segno))) {
 		f2fs_err(sbi, "Wrong valid blocks %d or segno %u",
 			 GET_SIT_VBLOCKS(raw_sit), segno);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -793,7 +794,7 @@ static inline pgoff_t current_sit_addr(struct f2fs_sb_info *sbi,
 	unsigned int offset = SIT_BLOCK_OFFSET(start);
 	block_t blk_addr = sit_i->sit_base_addr + offset;
 
-	check_seg_range(sbi, start);
+	f2fs_bug_on(sbi, !valid_main_segno(sbi, start));
 
 #ifdef CONFIG_F2FS_CHECK_FS
 	if (f2fs_test_bit(offset, sit_i->sit_bitmap) !=
-- 
2.39.1.581.gbfd45094c4-goog

