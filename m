Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB91653C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiLVGfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiLVGfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:35:02 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7E1E726;
        Wed, 21 Dec 2022 22:35:00 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nd0sq07s5z4f3mL1;
        Thu, 22 Dec 2022 14:34:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDH5jCP+qNjzwckAQ--.30442S6;
        Thu, 22 Dec 2022 14:34:57 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jack@suse.cz, kbusch@kernel.org, shikemeng@huaweicloud.com
Subject: [PATCH RESEND v2 4/5] sbitmap: add sbitmap_find_bit to remove repeat code in __sbitmap_get/__sbitmap_get_shallow
Date:   Thu, 22 Dec 2022 22:33:52 +0800
Message-Id: <20221222143353.598042-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221222143353.598042-1-shikemeng@huaweicloud.com>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDH5jCP+qNjzwckAQ--.30442S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4UCF1xGF1DWF1UCw17KFg_yoW5Kw4fpF
        4FqFyxK3s5tryUuw4DtFyrAF9xGw4fJ3ZxJayfXr1ruF4UGFs3KrZ5KFySqa47CFWDZFWD
        Xa15Xr18GF1jva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
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

There are three differences between __sbitmap_get and
__sbitmap_get_shallow when searching free bit:
1. __sbitmap_get_shallow limit number of bit to search per word.
__sbitmap_get has no such limit.
2. __sbitmap_get_shallow always searches with wrap set. __sbitmap_get set
wrap according to round_robin.
3. __sbitmap_get_shallow always searches from first bit in first word.
__sbitmap_get searches from first bit when round_robin is not set
otherwise searches from SB_NR_TO_BIT(sb, alloc_hint).

Add helper function sbitmap_find_bit function to do common search while
accept "limit depth per word", "wrap flag" and "first bit to
search" from caller to support the need of both __sbitmap_get and
__sbitmap_get_shallow.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/sbitmap.c | 72 +++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 3f7e276a427d..b6d3bb1c3675 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -186,26 +186,22 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 	return nr;
 }
 
-static int __sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
+static int sbitmap_find_bit(struct sbitmap *sb,
+			    unsigned int depth,
+			    unsigned int index,
+			    unsigned int alloc_hint,
+			    bool wrap)
 {
-	unsigned int i, index;
+	unsigned int i;
 	int nr = -1;
 
-	index = SB_NR_TO_INDEX(sb, alloc_hint);
-
-	/*
-	 * Unless we're doing round robin tag allocation, just use the
-	 * alloc_hint to find the right word index. No point in looping
-	 * twice in find_next_zero_bit() for that case.
-	 */
-	if (sb->round_robin)
-		alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
-	else
-		alloc_hint = 0;
-
 	for (i = 0; i < sb->map_nr; i++) {
-		nr = sbitmap_find_bit_in_word(&sb->map[index], __map_depth(sb, index),
-					      alloc_hint, !sb->round_robin);
+		nr = sbitmap_find_bit_in_word(&sb->map[index],
+					      min_t(unsigned int,
+						    __map_depth(sb, index),
+						    depth),
+					      alloc_hint, wrap);
+
 		if (nr != -1) {
 			nr += index << sb->shift;
 			break;
@@ -215,11 +211,32 @@ static int __sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
 		alloc_hint = 0;
 		if (++index >= sb->map_nr)
 			index = 0;
+
 	}
 
 	return nr;
 }
 
+static int __sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
+{
+	unsigned int index;
+
+	index = SB_NR_TO_INDEX(sb, alloc_hint);
+
+	/*
+	 * Unless we're doing round robin tag allocation, just use the
+	 * alloc_hint to find the right word index. No point in looping
+	 * twice in find_next_zero_bit() for that case.
+	 */
+	if (sb->round_robin)
+		alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
+	else
+		alloc_hint = 0;
+
+	return sbitmap_find_bit(sb, UINT_MAX, index, alloc_hint,
+				!sb->round_robin);
+}
+
 int sbitmap_get(struct sbitmap *sb)
 {
 	int nr;
@@ -241,31 +258,12 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 				 unsigned int alloc_hint,
 				 unsigned long shallow_depth)
 {
-	unsigned int i, index;
-	int nr = -1;
+	unsigned int index;
 
 	index = SB_NR_TO_INDEX(sb, alloc_hint);
 	alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
 
-	for (i = 0; i < sb->map_nr; i++) {
-		nr = sbitmap_find_bit_in_word(&sb->map[index],
-					      min_t(unsigned int,
-						    __map_depth(sb, index),
-						    shallow_depth),
-					      alloc_hint, true);
-
-		if (nr != -1) {
-			nr += index << sb->shift;
-			break;
-		}
-
-		/* Jump to next index. */
-		alloc_hint = 0;
-		if (++index >= sb->map_nr)
-			index = 0;
-	}
-
-	return nr;
+	return sbitmap_find_bit(sb, shallow_depth, index, alloc_hint, true);
 }
 
 int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
-- 
2.30.0

