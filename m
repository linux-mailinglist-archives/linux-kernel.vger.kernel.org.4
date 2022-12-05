Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5426430D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiLESzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiLESy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:54:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF14209B6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 10:54:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 006A961303
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56943C433B5;
        Mon,  5 Dec 2022 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670266491;
        bh=fMxo9Pxt/+eOWzK6Fcoy958VZcVnlQSUEaPKF5uGEAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZdpIlaifDi264JqIhfee++q1eEVwJxU0McwmHRefkSjBeqP5qJsVJbS1qHTHPYxh
         pdDR58Dl5wcnSgDmOVkBUj4KMuGZDJLR2Ypo56Qm/UaDB2srETKx6SVzXOckbPZ5qD
         nTbBY1oiHOzhNqrqnc244Aol3HCJaJw3MFKaJI66glujl8TwNh7IHgFZm5sIUA/LqC
         XivtIAQSlfrjfQPpQ1UCYsHgwuTB2JNWjrqb5J8xB/Dcmi45EX42ZUhk2pLIJZ/fYu
         uiDFUQcYxJWBlnYqfQ+SvXYvxgpnSFIVrgdZXVOAlZzk2f6snVg6yd76840X2ULINV
         Wa5+CIX+o7J5w==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] f2fs: remove unnecessary __init_extent_tree
Date:   Mon,  5 Dec 2022 10:54:30 -0800
Message-Id: <20221205185433.3479699-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221205185433.3479699-1-jaegeuk@kernel.org>
References: <20221205185433.3479699-1-jaegeuk@kernel.org>
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

Added into the caller.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 2a8e31e6d518..c6810347e205 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -386,21 +386,6 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 	return et;
 }
 
-static struct extent_node *__init_extent_tree(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_info *ei)
-{
-	struct rb_node **p = &et->root.rb_root.rb_node;
-	struct extent_node *en;
-
-	en = __attach_extent_node(sbi, et, ei, NULL, p, true);
-	if (!en)
-		return NULL;
-
-	et->largest = en->ei;
-	et->cached_en = en;
-	return en;
-}
-
 static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 					struct extent_tree *et)
 {
@@ -460,8 +445,12 @@ static void __f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
 	if (atomic_read(&et->node_cnt))
 		goto out;
 
-	en = __init_extent_tree(sbi, et, &ei);
+	en = __attach_extent_node(sbi, et, &ei, NULL,
+				&et->root.rb_root.rb_node, true);
 	if (en) {
+		et->largest = en->ei;
+		et->cached_en = en;
+
 		spin_lock(&sbi->extent_lock);
 		list_add_tail(&en->list, &sbi->extent_list);
 		spin_unlock(&sbi->extent_lock);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

