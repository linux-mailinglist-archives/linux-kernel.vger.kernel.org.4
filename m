Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EAC6C2BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjCUIJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCUIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:09:31 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE80A305D7;
        Tue, 21 Mar 2023 01:09:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pgkll5T8lz4f3tpw;
        Tue, 21 Mar 2023 16:09:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbEzZhlk+NQhFw--.4478S4;
        Tue, 21 Mar 2023 16:09:25 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ojaswin@linux.ibm.com, shikemeng@huaweicloud.com
Subject: [PATCH 2/8] ext4: fix unit mismatch in ext4_mb_new_blocks_simple
Date:   Wed, 22 Mar 2023 00:12:14 +0800
Message-Id: <20230321161220.418652-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230321161220.418652-1-shikemeng@huaweicloud.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbEzZhlk+NQhFw--.4478S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1DGw1rWFyDKr18tFW5ZFb_yoW8GF13pw
        sIyF10kr1fWr1Dua17u3ySqw1fZ34xur47XrWfu34rWrWxXryxGFs3tF1rtF1rtFZxZ3ZI
        qr15Zryruw48G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
        RNVbyUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "i" returned from mb_find_next_zero_bit is in cluster unit and we
need offset "block" corresponding to "i" in block unit. Convert "i" to
block unit to fix the unit mismatch.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6318c763a239..7f695830621a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5761,6 +5761,7 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 {
 	struct buffer_head *bitmap_bh;
 	struct super_block *sb = ar->inode->i_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
 	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
@@ -5789,7 +5790,8 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 			if (i >= max)
 				break;
 			if (ext4_fc_replay_check_excluded(sb,
-				ext4_group_first_block_no(sb, group) + i)) {
+				ext4_group_first_block_no(sb, group) +
+				EXT4_C2B(sbi, i))) {
 				blkoff = i + 1;
 			} else
 				break;
@@ -5806,7 +5808,7 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 		return 0;
 	}
 
-	block = ext4_group_first_block_no(sb, group) + i;
+	block = ext4_group_first_block_no(sb, group) + EXT4_C2B(sbi, i);
 	ext4_mb_mark_bb(sb, block, 1, 1);
 	ar->len = 1;
 
-- 
2.30.0

