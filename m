Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106256E3DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjDQDE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQDEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:04:02 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0597272C;
        Sun, 16 Apr 2023 20:04:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q0Bhr3f3tz4f3yqf;
        Mon, 17 Apr 2023 11:03:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgAXODIXtzxkfzJgHA--.17426S14;
        Mon, 17 Apr 2023 11:03:58 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v3 12/19] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
Date:   Mon, 17 Apr 2023 19:06:10 +0800
Message-Id: <20230417110617.2664129-13-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAXODIXtzxkfzJgHA--.17426S14
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4rZw47WF43Jr4xXry7Wrg_yoW7tw4rpF
        9IyF1DCr43Jrnrur43W342q3WrKw109w1kGryfC345CF4ayr95WF1xKFyF9asIyFZrXFnF
        qr1Ykw4xur1fuFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several reasons to add a general function to update block
bitmap and group descriptor on disk:
1. pair behavior of alloc/free bits. For example,
ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
2. remove repeat code to read from disk, update and write back to disk.
3. reduce future unit test mocks to catch real IO to update structure
on disk.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 157 +++++++++++++++++++++++++---------------------
 1 file changed, 87 insertions(+), 70 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6d4471fd3049..ba165dc07890 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3730,6 +3730,86 @@ void ext4_exit_mballoc(void)
 	ext4_groupinfo_destroy_slabs();
 }
 
+struct ext4_mark_context {
+	struct super_block *sb;
+	int state;
+};
+
+static int
+ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
+		      ext4_grpblk_t blkoff, ext4_grpblk_t len)
+{
+	struct super_block *sb = mc->sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct buffer_head *bitmap_bh = NULL;
+	struct ext4_group_desc *gdp;
+	struct buffer_head *gdp_bh;
+	int err;
+	unsigned int i, already, changed;
+
+	bitmap_bh = ext4_read_block_bitmap(sb, group);
+	if (IS_ERR(bitmap_bh))
+		return PTR_ERR(bitmap_bh);
+
+	err = -EIO;
+	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
+	if (!gdp)
+		goto out_err;
+
+	ext4_lock_group(sb, group);
+	if (ext4_has_group_desc_csum(sb) &&
+	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
+		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
+		ext4_free_group_clusters_set(sb, gdp,
+			ext4_free_clusters_after_init(sb, group, gdp));
+	}
+
+	already = 0;
+	for (i = 0; i < len; i++)
+		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
+				mc->state)
+			already++;
+	changed = len - already;
+
+	if (mc->state) {
+		mb_set_bits(bitmap_bh->b_data, blkoff, len);
+		ext4_free_group_clusters_set(sb, gdp,
+			ext4_free_group_clusters(sb, gdp) - changed);
+	} else {
+		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
+		ext4_free_group_clusters_set(sb, gdp,
+			ext4_free_group_clusters(sb, gdp) + changed);
+	}
+
+	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
+	ext4_group_desc_csum_set(sb, group, gdp);
+	ext4_unlock_group(sb, group);
+
+	if (sbi->s_log_groups_per_flex) {
+		ext4_group_t flex_group = ext4_flex_group(sbi, group);
+		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
+					   s_flex_groups, flex_group);
+
+		if (mc->state)
+			atomic64_sub(changed, &fg->free_clusters);
+		else
+			atomic64_add(changed, &fg->free_clusters);
+	}
+
+	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+	if (err)
+		goto out_err;
+	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+	if (err)
+		goto out_err;
+
+	sync_dirty_buffer(bitmap_bh);
+	sync_dirty_buffer(gdp_bh);
+
+out_err:
+	brelse(bitmap_bh);
+	return err;
+}
 
 /*
  * Check quota and mark chosen space (ac->ac_b_ex) non-free in bitmaps
@@ -3856,15 +3936,15 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			int len, int state)
 {
-	struct buffer_head *bitmap_bh = NULL;
-	struct ext4_group_desc *gdp;
-	struct buffer_head *gdp_bh;
+	struct ext4_mark_context mc = {
+		.sb = sb,
+		.state = state,
+	};
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int i, err;
-	int already;
-	unsigned int clen, clen_changed, thisgrp_len;
+	int err;
+	unsigned int clen, thisgrp_len;
 
 	while (len > 0) {
 		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
@@ -3885,80 +3965,17 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			ext4_error(sb, "Marking blocks in system zone - "
 				   "Block = %llu, len = %u",
 				   block, thisgrp_len);
-			bitmap_bh = NULL;
 			break;
 		}
 
-		bitmap_bh = ext4_read_block_bitmap(sb, group);
-		if (IS_ERR(bitmap_bh)) {
-			err = PTR_ERR(bitmap_bh);
-			bitmap_bh = NULL;
-			break;
-		}
-
-		err = -EIO;
-		gdp = ext4_get_group_desc(sb, group, &gdp_bh);
-		if (!gdp)
-			break;
-
-		ext4_lock_group(sb, group);
-		already = 0;
-		for (i = 0; i < clen; i++)
-			if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
-					 !state)
-				already++;
-
-		clen_changed = clen - already;
-		if (state)
-			mb_set_bits(bitmap_bh->b_data, blkoff, clen);
-		else
-			mb_clear_bits(bitmap_bh->b_data, blkoff, clen);
-		if (ext4_has_group_desc_csum(sb) &&
-		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
-			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
-			ext4_free_group_clusters_set(sb, gdp,
-			     ext4_free_clusters_after_init(sb, group, gdp));
-		}
-		if (state)
-			clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
-		else
-			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
-
-		ext4_free_group_clusters_set(sb, gdp, clen);
-		ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
-		ext4_group_desc_csum_set(sb, group, gdp);
-
-		ext4_unlock_group(sb, group);
-
-		if (sbi->s_log_groups_per_flex) {
-			ext4_group_t flex_group = ext4_flex_group(sbi, group);
-			struct flex_groups *fg = sbi_array_rcu_deref(sbi,
-						   s_flex_groups, flex_group);
-
-			if (state)
-				atomic64_sub(clen_changed, &fg->free_clusters);
-			else
-				atomic64_add(clen_changed, &fg->free_clusters);
-
-		}
-
-		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
-		if (err)
-			break;
-		sync_dirty_buffer(bitmap_bh);
-		err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
-		sync_dirty_buffer(gdp_bh);
+		err = ext4_mb_mark_group_bb(&mc, group, blkoff, clen);
 		if (err)
 			break;
 
 		block += thisgrp_len;
 		len -= thisgrp_len;
-		brelse(bitmap_bh);
 		BUG_ON(len < 0);
 	}
-
-	if (err)
-		brelse(bitmap_bh);
 }
 
 /*
-- 
2.30.0

