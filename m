Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1153B637D03
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKXP3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiKXP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:29:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573009E94C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:29:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14AD2B8284B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 15:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B535BC433C1;
        Thu, 24 Nov 2022 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669303771;
        bh=nZmcBIjikcEpAdjorTMsfW0ArzMzZX6J9glvIy0+9Yw=;
        h=From:To:Cc:Subject:Date:From;
        b=tkuxkiYOSeWe0QbVkD9Dlmy23oS/T0Tt5/2VBM58HOLromEZHVxNJV2PcqUPsdOkO
         /oyJIXaZoPTgxQegyG7pD6FU/dfKNfefVD45zuumcwYYo13g6UTTjJZ6en/A8wFOzE
         Sqz9Ff+OTiV8zo9enx8lGqlYzs/ULL1e/Ub2j+/3GI+9/RQdQDFHlWsoPRht+kvPCc
         +OXLppCW/FxuNZUC8UOKiSNW6hHVSJ/bC6YCgKoY3cU3xiU4u0THV/nbzbiqM4yeI0
         QoYB8I1ib9WADog6LGeoVN1YH/CFZ1fTEec0pjT/5nej1cyjkRWpH/qf8tuogPcY3I
         Z650TEeDglG6w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: truncate blocks in batch in __complete_revoke_list()
Date:   Wed, 23 Nov 2022 06:42:52 +0800
Message-Id: <20221122224252.73270-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use f2fs_do_truncate_blocks() to truncate all blocks in-batch in
__complete_revoke_list().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 14ece4bf7c7e..37c721e1eb03 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -262,24 +262,19 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
 					bool revoke)
 {
 	struct revoke_entry *cur, *tmp;
-	pgoff_t start_index = 0;
 	bool truncate = is_inode_flag_set(inode, FI_ATOMIC_REPLACE);
 
 	list_for_each_entry_safe(cur, tmp, head, list) {
-		if (revoke) {
+		if (revoke)
 			__replace_atomic_write_block(inode, cur->index,
 						cur->old_addr, NULL, true);
-		} else if (truncate) {
-			f2fs_truncate_hole(inode, start_index, cur->index);
-			start_index = cur->index + 1;
-		}
 
 		list_del(&cur->list);
 		kmem_cache_free(revoke_entry_slab, cur);
 	}
 
 	if (!revoke && truncate)
-		f2fs_do_truncate_blocks(inode, start_index * PAGE_SIZE, false);
+		f2fs_do_truncate_blocks(inode, 0, false);
 }
 
 static int __f2fs_commit_atomic_write(struct inode *inode)
-- 
2.36.1

