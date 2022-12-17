Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5645B64F678
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLQArS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLQArK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:47:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB334F643
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:47:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C88062300
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 00:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF15C433D2;
        Sat, 17 Dec 2022 00:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671238027;
        bh=AzwJwO831ToMtkyVqdqwG2XUb0eIPd36DW9P8p2Lef0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItJS5nPxoXXc64tEoC8hOfl3x6pXx4brhOBseH0Pyxksxzz8in1nqVZnqERljNmqU
         brEIUU6hQEmXiUDL3EO7RmSQSIZ39aeG+LvjL+ndsRthYCklXmUKHKbg1ZU1/4euEv
         DdJjdXqHwWWcNokSfdY0S0YFxiPnuVTTkXUeC9dmmtwPepkh7gwmibrfwTU3/6nCZU
         hr9DCu5h1Ocig/o8lj4ISjo1vRRGvUhvMbraTdE8qMuigvKPWF1tNvzanI+Qb2U3O4
         nsjUThYrohqD37nig5b+Z6mGHivajLd5heX/wzOmPxVyim35RY649jXB+2LRCXELTn
         3g0kXPxMvVdyw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: should use a temp extent_info for lookup
Date:   Fri, 16 Dec 2022 16:46:59 -0800
Message-Id: <20221217004659.2092427-4-jaegeuk@kernel.org>
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

Otherwise, __lookup_extent_tree() will override the given extent_info which will
be used by caller.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 7bd1e1832412..a510fa57a823 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -888,6 +888,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
 	loff_t f_size = i_size_read(inode);
 	unsigned long long cur_blocks =
 				atomic64_read(&sbi->allocated_data_blocks);
+	struct extent_info tei = *ei;	/* only fofs and len are valid */
 
 	/*
 	 * When I/O is not aligned to a PAGE_SIZE, update will happen to the last
@@ -898,17 +899,17 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
 			blkaddr == NEW_ADDR)
 		return -EINVAL;
 
-	if (__lookup_extent_tree(inode, ei->fofs, ei, EX_BLOCK_AGE)) {
+	if (__lookup_extent_tree(inode, ei->fofs, &tei, EX_BLOCK_AGE)) {
 		unsigned long long cur_age;
 
-		if (cur_blocks >= ei->last_blocks)
-			cur_age = cur_blocks - ei->last_blocks;
+		if (cur_blocks >= tei.last_blocks)
+			cur_age = cur_blocks - tei.last_blocks;
 		else
 			/* allocated_data_blocks overflow */
-			cur_age = ULLONG_MAX - ei->last_blocks + cur_blocks;
+			cur_age = ULLONG_MAX - tei.last_blocks + cur_blocks;
 
-		if (ei->age)
-			ei->age = __calculate_block_age(cur_age, ei->age);
+		if (tei.age)
+			ei->age = __calculate_block_age(cur_age, tei.age);
 		else
 			ei->age = cur_age;
 		ei->last_blocks = cur_blocks;
-- 
2.39.0.314.g84b9a713c41-goog

