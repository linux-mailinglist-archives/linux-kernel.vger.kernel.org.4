Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721DA6DFB17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDLQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDLQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D572BC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10873621E1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6678EC4339B;
        Wed, 12 Apr 2023 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681316249;
        bh=nB+s4y1cVa3fwfi6O40cHZ5sEurmUD9JrP46j7oa/iw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=tkNlceuD6IFLx3n848LVw7iSIM/8b59KKvDgNmk4GitWKO87cmeAKZ58AeH3oqhhx
         aIPXElT3Tziag0CttNFJjgVqHW1FP2hqaTvtei44x2jhhyt7qmQzIgRePxG3KEyn46
         EGuOE4eNt22DiOYlCxV7jIWTLJuIHKlAKyu+l75AaIX50/OLH5qen/4/+WliKyURl5
         Raax/uRBov0eNfmjkHKB1fUXwlGd6NxMaaZlhwebN3qmixBzsaC3L/ScUTaHrLIK37
         +B4v3OLfEUzRK8Mcz5TOq87iRpzl4hP9tGfpuo8TWhbxFU5xDQwmqiMaMmWpZCNWrk
         XaQDVCGZq4m9Q==
Date:   Wed, 12 Apr 2023 09:17:27 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: relax sanity check if checkpoint is corrupted
Message-ID: <ZDbZlwH5u3/nOTwL@google.com>
References: <20230407181539.4136580-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407181539.4136580-1-jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. extent_cache
 - let's drop the largest extent_cache
2. invalidate_block
 - don't show the warnings

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - add one more case to skip the error message

 fs/f2fs/checkpoint.c   | 10 ++++++++++
 fs/f2fs/extent_cache.c | 22 +++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 448ecf5000b8..64b3860f50ee 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -152,6 +152,11 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 	se = get_seg_entry(sbi, segno);
 
 	exist = f2fs_test_bit(offset, se->cur_valid_map);
+
+	/* skip data, if we already have an error in checkpoint. */
+	if (unlikely(f2fs_cp_error(sbi)))
+		return exist;
+
 	if (exist && type == DATA_GENERIC_ENHANCE_UPDATE) {
 		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
 			 blkaddr, exist);
@@ -202,6 +207,11 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 	case DATA_GENERIC_ENHANCE_UPDATE:
 		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
 				blkaddr < MAIN_BLKADDR(sbi))) {
+
+			/* Skip to emit an error message. */
+			if (unlikely(f2fs_cp_error(sbi)))
+				return false;
+
 			f2fs_warn(sbi, "access invalid blkaddr:%u",
 				  blkaddr);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 9a8153895d20..bea6ab9d846a 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -23,18 +23,26 @@ bool sanity_check_extent_cache(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct extent_tree *et = fi->extent_tree[EX_READ];
 	struct extent_info *ei;
 
-	if (!fi->extent_tree[EX_READ])
+	if (!et)
+		return true;
+
+	ei = &et->largest;
+	if (!ei->len)
 		return true;
 
-	ei = &fi->extent_tree[EX_READ]->largest;
+	/* Let's drop, if checkpoint got corrupted. */
+	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
+		ei->len = 0;
+		et->largest_updated = true;
+		return true;
+	}
 
-	if (ei->len &&
-		(!f2fs_is_valid_blkaddr(sbi, ei->blk,
-					DATA_GENERIC_ENHANCE) ||
-		!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
-					DATA_GENERIC_ENHANCE))) {
+	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
+	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
+					DATA_GENERIC_ENHANCE)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
 			  __func__, inode->i_ino,
-- 
2.40.0.577.gac1e443424-goog

