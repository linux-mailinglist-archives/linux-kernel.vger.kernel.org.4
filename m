Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D336DB2A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjDGSPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjDGSPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:15:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB4BAF0D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 441A16501B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 18:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA6BC433EF;
        Fri,  7 Apr 2023 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680891340;
        bh=R5IaRXJ/Qg+3iB9RW4lmo1YHb1AE43YUn4zUM2xxs5Q=;
        h=From:To:Cc:Subject:Date:From;
        b=XZSmTYiLruss9ev7G0liNfXg96G6RieiR1TRsz+uc4Yy2YHHH5b+rLEm+1YnER5f+
         Yc+n0589V28eQQt+G3JCEmMCFgmA35Qe0ArA8rhK3Do//6bXQr7JK/wOPndJrXAu0O
         aweOd1uGbGOkxOl9jk7Vqffx6peJUeGxsxYMLuk+uMw/lySagLuw0xxC4rhEGdSlhn
         vaqP/MsxalJx2qMggmJ7xVZgdMrqnS1OFSIYg23IJRmY5ByQoEMa47/QhXTY0xk7Gd
         ukFNpLvAtdz4yqSPjveFQoGohvyAj2h1PPdT0TqXSfkgKE7hoTswm7S/plXvUaGvoi
         8U7vcNLMHOooQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: relax sanity check if checkpoint is corrupted
Date:   Fri,  7 Apr 2023 11:15:39 -0700
Message-Id: <20230407181539.4136580-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
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

1. extent_cache
 - let's drop the largest extent_cache
2. invalidate_block
 - don't show the warnings

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c   |  5 +++++
 fs/f2fs/extent_cache.c | 22 +++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5774076d7ca3..73ae4e85e70d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -152,6 +152,11 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 	se = get_seg_entry(sbi, segno);
 
 	exist = f2fs_test_bit(offset, se->cur_valid_map);
+
+	/* skip, if we already have an error in checkpoint. */
+	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG))
+		return exist;
+
 	if (exist && type == DATA_GENERIC_ENHANCE_UPDATE) {
 		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
 			 blkaddr, exist);
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

