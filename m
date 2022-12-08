Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAA647144
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLHODC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLHOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:02:48 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230D565F2;
        Thu,  8 Dec 2022 06:02:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NSbSp6BTnz4f3lGh;
        Thu,  8 Dec 2022 22:02:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgBXAbB77pFjF4YRBw--.33249S6;
        Thu, 08 Dec 2022 22:02:38 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: [PATCH 4/4] sbitmap: add sbitmap_find_bit to remove repeat code in __sbitmap_get/__sbitmap_get_shallow
Date:   Fri,  9 Dec 2022 06:01:47 +0800
Message-Id: <20221208220147.3315388-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221208220147.3315388-1-shikemeng@huaweicloud.com>
References: <20221208220147.3315388-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXAbB77pFjF4YRBw--.33249S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4UCF1xGF1DWF1UCw17KFg_yoW5Kw4fpF
        4FqFyxK3s5tryUuw4DtFyrAF9xGw4fJ3ZxJayfXr1ruF4UGFs3KrZ5KFySqa47CFWDZFWD
        Xa15Xr18GF1jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3XTQUUUUU
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

