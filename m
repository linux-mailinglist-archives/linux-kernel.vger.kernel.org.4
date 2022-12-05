Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494556430D2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiLESzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiLESyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:54:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84CC1FF87
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 10:54:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F1FB61260
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F784C4347C;
        Mon,  5 Dec 2022 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670266490;
        bh=GWLnt4Hpfc9of2Zu1Cv4iHRoSVmDRpLn3t9QCM1g0vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XEArKJECeifxlCS/uezFz28NIu+J/6VveiECr5cV53wpZqo+rqROZu5avQnOcnVJB
         Aj4GY0DDrdWmdw/NcbMUKFpSxTdXLfMsZX9HEh5YtxXDdbf6TFbroKE2tOXTkZvQjP
         saOXiAsJzgrGUHQ2aOzXAIaHBnoAv5nikfIJ4lbMhci65vr2Efw4Tyiu9167EIrs+t
         IcLte5j1hp4/62ieOOf1sZzqMteLhFcPmMrtk4RCJnFpBENMBi1bo3KJ7vcTxGFqUc
         ghb3cZpjJA9zQeg2oBLbBZeFWkcS4avx85HEObikD3co9SYlKletxW5pWSTk9gmHLA
         mAOo34P7F7cgA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/6] f2fs: move internal functions into extent_cache.c
Date:   Mon,  5 Dec 2022 10:54:29 -0800
Message-Id: <20221205185433.3479699-2-jaegeuk@kernel.org>
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

No functional change.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 88 +++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/f2fs.h         | 69 +--------------------------------
 2 files changed, 81 insertions(+), 76 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 8cd87aee0292..2a8e31e6d518 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -15,6 +15,77 @@
 #include "node.h"
 #include <trace/events/f2fs.h>
 
+static void __set_extent_info(struct extent_info *ei,
+				unsigned int fofs, unsigned int len,
+				block_t blk, bool keep_clen)
+{
+	ei->fofs = fofs;
+	ei->blk = blk;
+	ei->len = len;
+
+	if (keep_clen)
+		return;
+
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	ei->c_len = 0;
+#endif
+}
+
+static bool f2fs_may_extent_tree(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	/*
+	 * for recovered files during mount do not create extents
+	 * if shrinker is not registered.
+	 */
+	if (list_empty(&sbi->s_list))
+		return false;
+
+	if (!test_opt(sbi, READ_EXTENT_CACHE) ||
+			is_inode_flag_set(inode, FI_NO_EXTENT) ||
+			(is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
+			 !f2fs_sb_has_readonly(sbi)))
+		return false;
+
+	return S_ISREG(inode->i_mode);
+}
+
+static void __try_update_largest_extent(struct extent_tree *et,
+						struct extent_node *en)
+{
+	if (en->ei.len <= et->largest.len)
+		return;
+
+	et->largest = en->ei;
+	et->largest_updated = true;
+}
+
+static bool __is_extent_mergeable(struct extent_info *back,
+				struct extent_info *front)
+{
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (back->c_len && back->len != back->c_len)
+		return false;
+	if (front->c_len && front->len != front->c_len)
+		return false;
+#endif
+	return (back->fofs + back->len == front->fofs &&
+			back->blk + back->len == front->blk);
+}
+
+static bool __is_back_mergeable(struct extent_info *cur,
+				struct extent_info *back)
+{
+	return __is_extent_mergeable(back, cur);
+}
+
+static bool __is_front_mergeable(struct extent_info *cur,
+				struct extent_info *front)
+{
+	return __is_extent_mergeable(cur, front);
+}
+
 static struct rb_entry *__lookup_rb_tree_fast(struct rb_entry *cached_re,
 							unsigned int ofs)
 {
@@ -591,16 +662,16 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 
 		if (end < org_end && org_end - end >= F2FS_MIN_EXTENT_LEN) {
 			if (parts) {
-				set_extent_info(&ei, end,
-						end - dei.fofs + dei.blk,
-						org_end - end);
+				__set_extent_info(&ei,
+					end, org_end - end,
+					end - dei.fofs + dei.blk, false);
 				en1 = __insert_extent_tree(sbi, et, &ei,
 							NULL, NULL, true);
 				next_en = en1;
 			} else {
-				en->ei.fofs = end;
-				en->ei.blk += end - dei.fofs;
-				en->ei.len -= end - dei.fofs;
+				__set_extent_info(&en->ei,
+					end, en->ei.len - (end - dei.fofs),
+					en->ei.blk + (end - dei.fofs), true);
 				next_en = en;
 			}
 			parts++;
@@ -632,8 +703,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 
 	/* 3. update extent in extent cache */
 	if (blkaddr) {
-
-		set_extent_info(&ei, fofs, blkaddr, len);
+		__set_extent_info(&ei, fofs, len, blkaddr, false);
 		if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
 			__insert_extent_tree(sbi, et, &ei,
 					insert_p, insert_parent, leftmost);
@@ -692,7 +762,7 @@ void f2fs_update_extent_tree_range_compressed(struct inode *inode,
 	if (en)
 		goto unlock_out;
 
-	set_extent_info(&ei, fofs, blkaddr, llen);
+	__set_extent_info(&ei, fofs, llen, blkaddr, true);
 	ei.c_len = c_len;
 
 	if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1c39f8145b61..04fdf010bb77 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -621,7 +621,7 @@ struct rb_entry {
 struct extent_info {
 	unsigned int fofs;		/* start offset in a file */
 	unsigned int len;		/* length of the extent */
-	u32 blk;			/* start block address of the extent */
+	block_t blk;			/* start block address of the extent */
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	unsigned int c_len;		/* physical extent length of compressed blocks */
 #endif
@@ -846,17 +846,6 @@ static inline void set_raw_read_extent(struct extent_info *ext,
 	i_ext->len = cpu_to_le32(ext->len);
 }
 
-static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
-						u32 blk, unsigned int len)
-{
-	ei->fofs = fofs;
-	ei->blk = blk;
-	ei->len = len;
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	ei->c_len = 0;
-#endif
-}
-
 static inline bool __is_discard_mergeable(struct discard_info *back,
 			struct discard_info *front, unsigned int max_len)
 {
@@ -876,41 +865,6 @@ static inline bool __is_discard_front_mergeable(struct discard_info *cur,
 	return __is_discard_mergeable(cur, front, max_len);
 }
 
-static inline bool __is_extent_mergeable(struct extent_info *back,
-						struct extent_info *front)
-{
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (back->c_len && back->len != back->c_len)
-		return false;
-	if (front->c_len && front->len != front->c_len)
-		return false;
-#endif
-	return (back->fofs + back->len == front->fofs &&
-			back->blk + back->len == front->blk);
-}
-
-static inline bool __is_back_mergeable(struct extent_info *cur,
-						struct extent_info *back)
-{
-	return __is_extent_mergeable(back, cur);
-}
-
-static inline bool __is_front_mergeable(struct extent_info *cur,
-						struct extent_info *front)
-{
-	return __is_extent_mergeable(cur, front);
-}
-
-extern void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync);
-static inline void __try_update_largest_extent(struct extent_tree *et,
-						struct extent_node *en)
-{
-	if (en->ei.len > et->largest.len) {
-		et->largest = en->ei;
-		et->largest_updated = true;
-	}
-}
-
 /*
  * For free nid management
  */
@@ -2581,6 +2535,7 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
 	return le32_to_cpu(F2FS_CKPT(sbi)->cp_pack_start_sum);
 }
 
+extern void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync);
 static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
@@ -4403,26 +4358,6 @@ F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
 F2FS_FEATURE_FUNCS(compression, COMPRESSION);
 F2FS_FEATURE_FUNCS(readonly, RO);
 
-static inline bool f2fs_may_extent_tree(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
-	if (!test_opt(sbi, READ_EXTENT_CACHE) ||
-			is_inode_flag_set(inode, FI_NO_EXTENT) ||
-			(is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
-			 !f2fs_sb_has_readonly(sbi)))
-		return false;
-
-	/*
-	 * for recovered files during mount do not create extents
-	 * if shrinker is not registered.
-	 */
-	if (list_empty(&sbi->s_list))
-		return false;
-
-	return S_ISREG(inode->i_mode);
-}
-
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
 				    block_t blkaddr)
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

