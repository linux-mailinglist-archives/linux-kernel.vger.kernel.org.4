Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA56C2BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCUIKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCUIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:09:33 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F33CE10;
        Tue, 21 Mar 2023 01:09:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pgklm5M73z4f3vf9;
        Tue, 21 Mar 2023 16:09:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbEzZhlk+NQhFw--.4478S7;
        Tue, 21 Mar 2023 16:09:26 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ojaswin@linux.ibm.com, shikemeng@huaweicloud.com
Subject: [PATCH 5/8] ext4: treat stripe in block unit
Date:   Wed, 22 Mar 2023 00:12:17 +0800
Message-Id: <20230321161220.418652-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230321161220.418652-1-shikemeng@huaweicloud.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbEzZhlk+NQhFw--.4478S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWfXr15ZFW3Cw4rAFy8uFg_yoWrJw43pr
        1fAa1UtF1UWr1v9a17Wwn8Wr1fK3y8uryUJ3yxur1UWry2qFWfCF9Fq3WYyF97Xrs7WFyS
        v3yqvw17GrZrK3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stripe is misused in block unit and in cluster unit in different code
paths. User awared of stripe maybe not awared of bigalloc feature, so
treat stripe only in block unit to fix this.
Besides, it's hard to get stripe aligned blocks (start and length are both
aligned with stripe) if stripe is not aligned with cluster, just disable
stripe and alert user in this case to simpfy the code and avoid
unecessary work to get stripe aligned blocks which likely to be failed.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 18 +++++++++++-------
 fs/ext4/super.c   | 13 +++++++++++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9a40e165e7d2..b963111eeec6 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2178,7 +2178,8 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 			     ac->ac_g_ex.fe_len, &ex);
 	ex.fe_logical = 0xDEADFA11; /* debug value */
 
-	if (max >= ac->ac_g_ex.fe_len && ac->ac_g_ex.fe_len == sbi->s_stripe) {
+	if (max >= ac->ac_g_ex.fe_len &&
+	    ac->ac_g_ex.fe_len == EXT4_B2C(sbi, sbi->s_stripe)) {
 		ext4_fsblk_t start;
 
 		start = ext4_grp_offs_to_block(ac->ac_sb, &ex);
@@ -2343,7 +2344,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 	struct ext4_free_extent ex;
 	ext4_fsblk_t first_group_block;
 	ext4_fsblk_t a;
-	ext4_grpblk_t i;
+	ext4_grpblk_t i, stripe;
 	int max;
 
 	BUG_ON(sbi->s_stripe == 0);
@@ -2355,10 +2356,12 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 	do_div(a, sbi->s_stripe);
 	i = (a * sbi->s_stripe) - first_group_block;
 
+	stripe = EXT4_B2C(sbi, sbi->s_stripe);
+	i = EXT4_B2C(sbi, i);
 	while (i < EXT4_CLUSTERS_PER_GROUP(sb)) {
 		if (!mb_test_bit(i, bitmap)) {
-			max = mb_find_extent(e4b, i, sbi->s_stripe, &ex);
-			if (max >= sbi->s_stripe) {
+			max = mb_find_extent(e4b, i, stripe, &ex);
+			if (max >= stripe) {
 				ac->ac_found++;
 				ex.fe_logical = 0xDEADF00D; /* debug value */
 				ac->ac_b_ex = ex;
@@ -2366,7 +2369,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 				break;
 			}
 		}
-		i += sbi->s_stripe;
+		i += stripe;
 	}
 }
 
@@ -2727,7 +2730,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if (cr == 0)
 				ext4_mb_simple_scan_group(ac, &e4b);
 			else if (cr == 1 && sbi->s_stripe &&
-					!(ac->ac_g_ex.fe_len % sbi->s_stripe))
+				 !(ac->ac_g_ex.fe_len %
+				 EXT4_B2C(sbi, sbi->s_stripe)))
 				ext4_mb_scan_aligned(ac, &e4b);
 			else
 				ext4_mb_complex_scan_group(ac, &e4b);
@@ -3441,7 +3445,7 @@ int ext4_mb_init(struct super_block *sb)
 	 */
 	if (sbi->s_stripe > 1) {
 		sbi->s_mb_group_prealloc = roundup(
-			sbi->s_mb_group_prealloc, sbi->s_stripe);
+			sbi->s_mb_group_prealloc, EXT4_B2C(sbi, sbi->s_stripe));
 	}
 
 	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f226f8ab469b..0a5bf375df5c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5231,6 +5231,19 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount3;
 
 	sbi->s_stripe = ext4_get_stripe_size(sbi);
+	/*
+	 * It's hard to get stripe aligned blocks if stripe is not aligned with
+	 * cluster, just disable stripe and alert user to simpfy code and avoid
+	 * stripe aligned allocation which will rarely successes.
+	 */
+	if (sbi->s_stripe > 0 && sbi->s_cluster_ratio > 1 &&
+	    sbi->s_stripe % sbi->s_cluster_ratio != 0) {
+		ext4_msg(sb, KERN_WARNING,
+			 "stripe (%lu) is not aligned with cluster size (%u), "
+			 "stripe is disabled",
+			 sbi->s_stripe, sbi->s_cluster_ratio);
+		sbi->s_stripe = 0;
+	}
 	sbi->s_extent_max_zeroout_kb = 32;
 
 	/*
-- 
2.30.0

