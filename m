Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92633686222
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjBAIxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjBAIxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:53:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03DB1EFD7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:53:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FF7BB82151
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86101C433D2;
        Wed,  1 Feb 2023 08:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675241584;
        bh=bZR5dqM0wjHCquD3EtHxUWoP8ci01PMdB093XjUMwZY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mI+Zpv5YhPDmzM+6/GUSF52juc8yDu/rCM9Ug9XLv37Mfda1xIy3G/JPdlHP0GFDR
         Gf5eeu+uKfPY4WefM01ro+qxHmVh8vUb7Ppvc9w4LPJqHj0p9+ltOoDe/cemTSt517
         Di2YLelPWA4is7EVZ5TPS9ryL8LdKDsGowt+ewcoUALvFAcHbqIULF8UMZjxtEljCX
         y0fAzqYvBJZ1oiMz1kw9odBPj+3RubfnfM3dTyg8QyxVCu3TjprbMrxxnkfPw6OXFW
         rryQMjkM8Efcop14vcfiOhc7eSi5Cw7gWvfGbwdRVs0BrEnTr/HIFGjPiUVS2Qp08Z
         DSnuazG6rqlaw==
Message-ID: <a27b1135-757f-9609-1511-7c6738887472@kernel.org>
Date:   Wed, 1 Feb 2023 16:53:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] f2fs: clean up __update_extent_tree_range()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230131144701.34418-1-chao@kernel.org>
 <Y9lkeVCMRA9goN2E@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y9lkeVCMRA9goN2E@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/1 2:56, Jaegeuk Kim wrote:
> I wanted to avoid a deep if/else statement.

So how about this:

 From 418b408420367ac5491c97a7c4d26e3d0e68ea57 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Tue, 31 Jan 2023 22:46:59 +0800
Subject: [PATCH v2] f2fs: clean up __update_extent_tree_range()

Introduce __update_read_extent_cache() and __update_age_extent_cache()
to clean up __update_extent_tree_range(), no logic change.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2
- introduce __update_read_extent_cache() and __update_age_extent_cache()
to avoid a deep if/else statement in __update_extent_tree_range().
  fs/f2fs/extent_cache.c | 116 +++++++++++++++++++++++++++--------------
  1 file changed, 77 insertions(+), 39 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index d70ad6a44cbf..887b0b2898b9 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -666,6 +666,75 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
  	return en;
  }

+static inline bool __update_read_extent_cache(struct inode *inode,
+					struct extent_info *tei,
+					struct extent_info *ei,
+					struct extent_info *dei,
+					struct extent_info *prev,
+					unsigned int fofs, unsigned int len,
+					struct extent_node *prev_en,
+					struct extent_node *next_en,
+					struct rb_node **insert_p,
+					struct rb_node *insert_parent,
+					bool leftmost)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_READ];
+
+	if (!tei->blk)
+		return false;
+
+	__set_extent_info(ei, fofs, len, tei->blk, false,
+			  0, 0, EX_READ);
+	if (!__try_merge_extent_node(sbi, et, ei,
+					prev_en, next_en))
+		__insert_extent_tree(sbi, et, ei,
+			insert_p, insert_parent, leftmost);
+
+	/* give up read extent cache, if split and small updates happen */
+	if (dei->len >= 1 &&
+			prev->len < F2FS_MIN_EXTENT_LEN &&
+			et->largest.len < F2FS_MIN_EXTENT_LEN) {
+		et->largest.len = 0;
+		et->largest_updated = true;
+		set_inode_flag(inode, FI_NO_EXTENT);
+	}
+
+	if (is_inode_flag_set(inode, FI_NO_EXTENT))
+		__free_extent_tree(sbi, et);
+
+	if (et->largest_updated) {
+		et->largest_updated = false;
+		return true;
+	}
+
+	return false;
+}
+
+static inline void __update_age_extent_cache(struct inode *inode,
+					struct extent_info *tei,
+					struct extent_info *ei,
+					unsigned int fofs, unsigned int len,
+					struct extent_node *prev_en,
+					struct extent_node *next_en,
+					struct rb_node **insert_p,
+					struct rb_node *insert_parent,
+					bool leftmost)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_BLOCK_AGE];
+
+	if (!tei->last_blocks)
+		return;
+
+	__set_extent_info(ei, fofs, len, 0, false,
+		tei->age, tei->last_blocks, EX_BLOCK_AGE);
+	if (!__try_merge_extent_node(sbi, et, ei,
+					prev_en, next_en))
+		__insert_extent_tree(sbi, et, ei,
+			insert_p, insert_parent, leftmost);
+}
+
  static void __update_extent_tree_range(struct inode *inode,
  			struct extent_info *tei, enum extent_type type)
  {
@@ -782,47 +851,16 @@ static void __update_extent_tree_range(struct inode *inode,
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
+	if (type == EX_READ)
+		updated = __update_read_extent_cache(inode, tei, &ei, &dei,
+					&prev, fofs, len, prev_en, next_en,
  					insert_p, insert_parent, leftmost);
-
-		/* give up extent_cache, if split and small updates happen */
-		if (dei.len >= 1 &&
-				prev.len < F2FS_MIN_EXTENT_LEN &&
-				et->largest.len < F2FS_MIN_EXTENT_LEN) {
-			et->largest.len = 0;
-			et->largest_updated = true;
-			set_inode_flag(inode, FI_NO_EXTENT);
-		}
-	}
-
-	if (is_inode_flag_set(inode, FI_NO_EXTENT))
-		__free_extent_tree(sbi, et);
-
-	if (et->largest_updated) {
-		et->largest_updated = false;
-		updated = true;
-	}
-	goto out_read_extent_cache;
-update_age_extent_cache:
-	if (!tei->last_blocks)
-		goto out_read_extent_cache;
-
-	__set_extent_info(&ei, fofs, len, 0, false,
-			tei->age, tei->last_blocks, EX_BLOCK_AGE);
-	if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
-		__insert_extent_tree(sbi, et, &ei,
+	else if (type == EX_BLOCK_AGE)
+		__update_age_extent_cache(inode, tei, &ei,
+					fofs, len, prev_en, next_en,
  					insert_p, insert_parent, leftmost);
-out_read_extent_cache:
+
  	write_unlock(&et->lock);

  	if (updated)
-- 
2.25.1

Thanks,
