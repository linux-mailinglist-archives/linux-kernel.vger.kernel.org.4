Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3964864DB48
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLOMhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLOMhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:37:23 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C036827916;
        Thu, 15 Dec 2022 04:37:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NXsF72q7mz4f3kpR;
        Thu, 15 Dec 2022 20:37:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDHONb9FJtjOv0bCQ--.50238S7;
        Thu, 15 Dec 2022 20:37:18 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: [PATCH v2 3/5] sbitmap: rewrite sbitmap_find_bit_in_index to reduce repeat code
Date:   Fri, 16 Dec 2022 04:36:19 +0800
Message-Id: <20221215203621.3572458-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221215203621.3572458-1-shikemeng@huaweicloud.com>
References: <20221215203621.3572458-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHONb9FJtjOv0bCQ--.50238S7
X-Coremail-Antispam: 1UD129KBjvJXoWxur4kur17WFWUZryDtw1fJFb_yoW5JFWkpF
        4fJFy7K398try7uw4qqFy5AFy3Kws5GwnxJF4fW3WF9FyUJFn3GrWFgFW3ta4UCFWkZFWD
        ZF4rXw18K3Wjqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3znQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite sbitmap_find_bit_in_index as following:
1. Rename sbitmap_find_bit_in_index to sbitmap_find_bit_in_word
2. Accept "struct sbitmap_word *" directly instead of accepting
"struct sbitmap *" and "int index" to get "struct sbitmap_word *".
3. Accept depth/shallow_depth and wrap for __sbitmap_get_word from caller
to support need of both __sbitmap_get_shallow and __sbitmap_get.

With helper function sbitmap_find_bit_in_word, we can remove repeat
code in __sbitmap_get_shallow to find bit considring deferred clear.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/sbitmap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 11e75f4040fb..3f7e276a427d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -167,15 +167,16 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 	return nr;
 }
 
-static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
-				     unsigned int alloc_hint)
+static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
+				    unsigned int depth,
+				    unsigned int alloc_hint,
+				    bool wrap)
 {
-	struct sbitmap_word *map = &sb->map[index];
 	int nr;
 
 	do {
-		nr = __sbitmap_get_word(&map->word, __map_depth(sb, index),
-					alloc_hint, !sb->round_robin);
+		nr = __sbitmap_get_word(&map->word, depth,
+					alloc_hint, wrap);
 		if (nr != -1)
 			break;
 		if (!sbitmap_deferred_clear(map))
@@ -203,7 +204,8 @@ static int __sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
 		alloc_hint = 0;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		nr = sbitmap_find_bit_in_index(sb, index, alloc_hint);
+		nr = sbitmap_find_bit_in_word(&sb->map[index], __map_depth(sb, index),
+					      alloc_hint, !sb->round_robin);
 		if (nr != -1) {
 			nr += index << sb->shift;
 			break;
@@ -246,20 +248,17 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 	alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
 
 	for (i = 0; i < sb->map_nr; i++) {
-again:
-		nr = __sbitmap_get_word(&sb->map[index].word,
-					min_t(unsigned int,
-					      __map_depth(sb, index),
-					      shallow_depth),
-					alloc_hint, true);
+		nr = sbitmap_find_bit_in_word(&sb->map[index],
+					      min_t(unsigned int,
+						    __map_depth(sb, index),
+						    shallow_depth),
+					      alloc_hint, true);
+
 		if (nr != -1) {
 			nr += index << sb->shift;
 			break;
 		}
 
-		if (sbitmap_deferred_clear(&sb->map[index]))
-			goto again;
-
 		/* Jump to next index. */
 		alloc_hint = 0;
 		if (++index >= sb->map_nr)
-- 
2.30.0

