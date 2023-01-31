Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D611682F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjAaOrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjAaOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:47:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C1C46727
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:47:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7687661489
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2456CC4339B;
        Tue, 31 Jan 2023 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675176426;
        bh=MmOxigM59X8JlcAHThlYTmmNijEJl7O6QUjLV9hpxdU=;
        h=From:To:Cc:Subject:Date:From;
        b=WSgUT5zF8Y2q8+duHXiW8g+tcnUn16069rvwvf8xaKL8/mDJAaqVDHG0Y3JMhplgg
         tKMSGbfB1liLsTfja/zODR7ZrbxJpocaSHAxnGZ3A1sJcQe6CsKPUS+W9rnt1JPTUn
         5cYPmTkBSjaHktth2/i8hUa1AKDA+phUWfml4Gmm9GmWL6UMBxusf8ATwiw8ULjL2L
         0nFiC06B3b9LFjZCf11QuDydPeaNNz1F6H+oXiV17rlVcxTwm2+5G09fW5FZ+ao4Gv
         4whexxOWEJZxq1DI+SxxlFluyIMrPaX8LqPZ3XJajBL5OIUgFBx+yImGM5EyB+M7LW
         mGiSLhDazvA4g==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: clean up __update_extent_tree_range()
Date:   Tue, 31 Jan 2023 22:46:59 +0800
Message-Id: <20230131144701.34418-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
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

No logic change, just avoid goto statement.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/extent_cache.c | 66 ++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index d70ad6a44cbf..cf65a188d112 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -782,47 +782,43 @@ static void __update_extent_tree_range(struct inode *inode,
 		en = next_en;
 	}
 
-	if (type == EX_BLOCK_AGE)
-		goto update_age_extent_cache;
-
-	/* 3. update extent in read extent cache */
-	BUG_ON(type != EX_READ);
-
-	if (tei->blk) {
-		__set_extent_info(&ei, fofs, len, tei->blk, false,
-				  0, 0, EX_READ);
-		if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
-			__insert_extent_tree(sbi, et, &ei,
+	/* 3. update extent in extent cache */
+	if (type == EX_READ) {
+		if (tei->blk) {
+			__set_extent_info(&ei, fofs, len, tei->blk, false,
+					  0, 0, EX_READ);
+			if (!__try_merge_extent_node(sbi, et, &ei,
+							prev_en, next_en))
+				__insert_extent_tree(sbi, et, &ei,
 					insert_p, insert_parent, leftmost);
 
-		/* give up extent_cache, if split and small updates happen */
-		if (dei.len >= 1 &&
-				prev.len < F2FS_MIN_EXTENT_LEN &&
-				et->largest.len < F2FS_MIN_EXTENT_LEN) {
-			et->largest.len = 0;
-			et->largest_updated = true;
-			set_inode_flag(inode, FI_NO_EXTENT);
+			/* give up read extent cache, if split and small updates happen */
+			if (dei.len >= 1 &&
+					prev.len < F2FS_MIN_EXTENT_LEN &&
+					et->largest.len < F2FS_MIN_EXTENT_LEN) {
+				et->largest.len = 0;
+				et->largest_updated = true;
+				set_inode_flag(inode, FI_NO_EXTENT);
+			}
 		}
-	}
-
-	if (is_inode_flag_set(inode, FI_NO_EXTENT))
-		__free_extent_tree(sbi, et);
 
-	if (et->largest_updated) {
-		et->largest_updated = false;
-		updated = true;
-	}
-	goto out_read_extent_cache;
-update_age_extent_cache:
-	if (!tei->last_blocks)
-		goto out_read_extent_cache;
+		if (is_inode_flag_set(inode, FI_NO_EXTENT))
+			__free_extent_tree(sbi, et);
 
-	__set_extent_info(&ei, fofs, len, 0, false,
-			tei->age, tei->last_blocks, EX_BLOCK_AGE);
-	if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
-		__insert_extent_tree(sbi, et, &ei,
+		if (et->largest_updated) {
+			et->largest_updated = false;
+			updated = true;
+		}
+	} else if (type == EX_BLOCK_AGE) {
+		if (tei->last_blocks) {
+			__set_extent_info(&ei, fofs, len, 0, false,
+				tei->age, tei->last_blocks, EX_BLOCK_AGE);
+			if (!__try_merge_extent_node(sbi, et, &ei,
+							prev_en, next_en))
+				__insert_extent_tree(sbi, et, &ei,
 					insert_p, insert_parent, leftmost);
-out_read_extent_cache:
+		}
+	}
 	write_unlock(&et->lock);
 
 	if (updated)
-- 
2.36.1

