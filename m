Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C2A68D9B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBGNvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjBGNv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:51:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B01E1D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:51:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A004161408
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE599C433D2;
        Tue,  7 Feb 2023 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675777887;
        bh=EZKYBpYclv2eyaC70CMbiuy4/z/DP/rVT2+COP6B7k4=;
        h=From:To:Cc:Subject:Date:From;
        b=H9NN8tCu7JU0D8HHeLsn4x7AQrUS0UMDr+gbWOveIWZQu3Mcaw0QL8enNqhV7rfM4
         fTrxPUwPgECH1whC0b5FELUb43G1/cKOgDLc4Hsgd1JPNo7iTqYljE1iJgj5LlLV4U
         Ur6XPUNoF2OousCijZ7cyey/VQ2uSFgy852BXKCUuRzZR/nWV+8WQoi+ZePQgur9d7
         F1Rzm/f6VIV+T3tTuRvHb6hRCayfWrq3fi9NOjkPxE0vEZObmrT5al9uYnUBg5afuW
         nMeHH5PkVbQ8Gg8LhPHESmYGjIO8WsBCWAMQx77VsGEwtCRSZmbtp3fp/viI3yhM7o
         l9N//kjNLMvgw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to do sanity check on extent cache correctly
Date:   Tue,  7 Feb 2023 21:48:08 +0800
Message-Id: <20230207134808.1827869-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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

In do_read_inode(), sanity check for extent cache should be called after
f2fs_init_read_extent_tree(), fix it.

Fixes: 72840cccc0a1 ("f2fs: allocate the extent_cache by default")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- just relocate sanity check on extent cache.
 fs/f2fs/extent_cache.c | 25 +++++++++++++++++++++++++
 fs/f2fs/f2fs.h         |  1 +
 fs/f2fs/inode.c        | 22 ++++++----------------
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 1daf8c88c09b..d93fcb082c31 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -19,6 +19,31 @@
 #include "node.h"
 #include <trace/events/f2fs.h>
 
+bool sanity_check_extent_cache(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct extent_info *ei;
+
+	if (!fi->extent_tree[EX_READ])
+		return true;
+
+	ei = &fi->extent_tree[EX_READ]->largest;
+
+	if (ei->len &&
+		(!f2fs_is_valid_blkaddr(sbi, ei->blk,
+					DATA_GENERIC_ENHANCE) ||
+		!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
+					DATA_GENERIC_ENHANCE))) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
+			  __func__, inode->i_ino,
+			  ei->blk, ei->fofs, ei->len);
+		return false;
+	}
+	return true;
+}
+
 static void __set_extent_info(struct extent_info *ei,
 				unsigned int fofs, unsigned int len,
 				block_t blk, bool keep_clen,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f3c5f7740c1a..8148aeabab03 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4136,6 +4136,7 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
 /*
  * extent_cache.c
  */
+bool sanity_check_extent_cache(struct inode *inode);
 struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 				struct rb_entry *cached_re, unsigned int ofs);
 struct rb_node **f2fs_lookup_rb_tree_ext(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 01b9e6f85f6b..164779c561f9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -262,22 +262,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
-	if (fi->extent_tree[EX_READ]) {
-		struct extent_info *ei = &fi->extent_tree[EX_READ]->largest;
-
-		if (ei->len &&
-			(!f2fs_is_valid_blkaddr(sbi, ei->blk,
-						DATA_GENERIC_ENHANCE) ||
-			!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
-						DATA_GENERIC_ENHANCE))) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
-				  __func__, inode->i_ino,
-				  ei->blk, ei->fofs, ei->len);
-			return false;
-		}
-	}
-
 	if (f2fs_sanity_check_inline_data(inode)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_data, run fsck to fix",
@@ -482,6 +466,12 @@ static int do_read_inode(struct inode *inode)
 	f2fs_init_read_extent_tree(inode, node_page);
 	f2fs_init_age_extent_tree(inode);
 
+	if (!sanity_check_extent_cache(inode)) {
+		f2fs_put_page(node_page, 1);
+		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
+		return -EFSCORRUPTED;
+	}
+
 	f2fs_put_page(node_page, 1);
 
 	stat_inc_inline_xattr(inode);
-- 
2.25.1

