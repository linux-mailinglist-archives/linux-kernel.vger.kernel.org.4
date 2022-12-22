Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A737D654982
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLVXzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVXzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:55:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104527932
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 15:55:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EBE0B81FAD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 23:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592CFC433D2;
        Thu, 22 Dec 2022 23:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671753299;
        bh=S0IfmelM7yN+udGca+1KPF5Wdz0l5L6Avlts03bXzCo=;
        h=From:To:Cc:Subject:Date:From;
        b=K5NW/mys7QToKUfmyLIQwokRF4s8EDDmQDlS180rqsBQFMkxJVUlZHkoE90AHE6pd
         TusZw5Uy6lcMLW60VQdPlVIAZ7+PKGokMJOkn2jLnP+iv66glZn8D0gQELk4+5J8pi
         QyUIhjQOXIU3E9GqlwL/cbv2cZOREkaK90AiO8M1YexBbcWZ+0Zr80ZwVH1dKuL9K6
         zHKt+fq0Scu8X44nfkmi4tPTun1aVyHfNaoh5xN2fTGsWIpjWwA9oj9MOQKxwzM2SS
         u9/31kgjEKIjPbBp9JL7V5C/RJnybSQnwqxlIlCQ2Ddfeb0eys3mjOo/5EJvo/dxEO
         TMfv3TnFGtbXw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: let's avoid panic if extent_tree is not created
Date:   Thu, 22 Dec 2022 15:54:58 -0800
Message-Id: <20221222235458.957816-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
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

This patch avoids the below panic.

pc : __lookup_extent_tree+0xd8/0x760
lr : f2fs_do_write_data_page+0x104/0x87c
sp : ffffffc010cbb3c0
x29: ffffffc010cbb3e0 x28: 0000000000000000
x27: ffffff8803e7f020 x26: ffffff8803e7ed40
x25: ffffff8803e7f020 x24: ffffffc010cbb460
x23: ffffffc010cbb480 x22: 0000000000000000
x21: 0000000000000000 x20: ffffffff22e90900
x19: 0000000000000000 x18: ffffffc010c5d080
x17: 0000000000000000 x16: 0000000000000020
x15: ffffffdb1acdbb88 x14: ffffff888759e2b0
x13: 0000000000000000 x12: ffffff802da49000
x11: 000000000a001200 x10: ffffff8803e7ed40
x9 : ffffff8023195800 x8 : ffffff802da49078
x7 : 0000000000000001 x6 : 0000000000000000
x5 : 0000000000000006 x4 : ffffffc010cbba28
x3 : 0000000000000000 x2 : ffffffc010cbb480
x1 : 0000000000000000 x0 : ffffff8803e7ed40
Call trace:
 __lookup_extent_tree+0xd8/0x760
 f2fs_do_write_data_page+0x104/0x87c
 f2fs_write_single_data_page+0x420/0xb60
 f2fs_write_cache_pages+0x418/0xb1c
 __f2fs_write_data_pages+0x428/0x58c
 f2fs_write_data_pages+0x30/0x40
 do_writepages+0x88/0x190
 __writeback_single_inode+0x48/0x448
 writeback_sb_inodes+0x468/0x9e8
 __writeback_inodes_wb+0xb8/0x2a4
 wb_writeback+0x33c/0x740
 wb_do_writeback+0x2b4/0x400
 wb_workfn+0xe4/0x34c
 process_one_work+0x24c/0x5bc
 worker_thread+0x3e8/0xa50
 kthread+0x150/0x1b4

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index a510fa57a823..1daf8c88c09b 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -546,7 +546,8 @@ static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 	struct extent_node *en;
 	bool ret = false;
 
-	f2fs_bug_on(sbi, !et);
+	if (!et)
+		return false;
 
 	trace_f2fs_lookup_extent_tree_start(inode, pgofs, type);
 
-- 
2.39.0.314.g84b9a713c41-goog

