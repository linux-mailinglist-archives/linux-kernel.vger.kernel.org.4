Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA27264F67D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLQArX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiLQArK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:47:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67B4A056
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:47:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BDDDB81E50
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 00:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D72C433EF;
        Sat, 17 Dec 2022 00:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671238027;
        bh=J6kSiIexbLuWJ6COT0xoCdZpCwCFQaT/pl5/3mg1XvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lpz+tm1Q3l+aJ0nZ1Wla3h/KYYx2TsmkCxMIB49F06gZEzeZwNLqm7EGSNAYXtPh6
         Oft7043k5Wg1twT6hxG5TWkglUUB9T4mdnL5wHunomWhOzwHGWRPvW8K/LHtqoHRTN
         6OCn6hHqk9mbdCF9RiKg4YChqS7nFITzsmRMFMKDCNodC/ysncynBP75QqOnrYXoYU
         boYVwGBzFEanx7TZeGpgHrwkb7bSdRUSCKisn60EyQ0lfglYRE6FKxwDeSfh27Ab3B
         wp+7R2wTMODHahUGKdvBRBSLD1Tofnqjr6lbqDMigSwUuDlA2/G56qDjeKs3JiQald
         XgBQ1Z8kHR9Kg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: don't mix to use union values in extent_info
Date:   Fri, 16 Dec 2022 16:46:58 -0800
Message-Id: <20221217004659.2092427-3-jaegeuk@kernel.org>
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

Let's explicitly use the defined values in block_age case only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 749209005644..7bd1e1832412 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -881,7 +881,8 @@ static unsigned long long __calculate_block_age(unsigned long long new,
 }
 
 /* This returns a new age and allocated blocks in ei */
-static int __get_new_block_age(struct inode *inode, struct extent_info *ei)
+static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
+						block_t blkaddr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	loff_t f_size = i_size_read(inode);
@@ -894,7 +895,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei)
 	 * block here.
 	 */
 	if ((f_size >> PAGE_SHIFT) == ei->fofs && f_size & (PAGE_SIZE - 1) &&
-			ei->blk == NEW_ADDR)
+			blkaddr == NEW_ADDR)
 		return -EINVAL;
 
 	if (__lookup_extent_tree(inode, ei->fofs, ei, EX_BLOCK_AGE)) {
@@ -915,14 +916,14 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei)
 		return 0;
 	}
 
-	f2fs_bug_on(sbi, ei->blk == NULL_ADDR);
+	f2fs_bug_on(sbi, blkaddr == NULL_ADDR);
 
 	/* the data block was allocated for the first time */
-	if (ei->blk == NEW_ADDR)
+	if (blkaddr == NEW_ADDR)
 		goto out;
 
-	if (__is_valid_data_blkaddr(ei->blk) &&
-			!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE)) {
+	if (__is_valid_data_blkaddr(blkaddr) &&
+	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
 		f2fs_bug_on(sbi, 1);
 		return -EINVAL;
 	}
@@ -953,8 +954,7 @@ static void __update_extent_cache(struct dnode_of_data *dn, enum extent_type typ
 		else
 			ei.blk = dn->data_blkaddr;
 	} else if (type == EX_BLOCK_AGE) {
-		ei.blk = dn->data_blkaddr;
-		if (__get_new_block_age(dn->inode, &ei))
+		if (__get_new_block_age(dn->inode, &ei, dn->data_blkaddr))
 			return;
 	}
 	__update_extent_tree_range(dn->inode, &ei, type);
-- 
2.39.0.314.g84b9a713c41-goog

