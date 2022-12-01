Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73B963E922
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiLAEzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLAEy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:54:59 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C82A0576;
        Wed, 30 Nov 2022 20:54:57 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NN3ch3FKyzHwJt;
        Thu,  1 Dec 2022 12:53:40 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 1 Dec
 2022 12:54:12 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huaweicloud.com>, <linfeilong@huawei.com>,
        <liuzhiqiang@huawei.com>
Subject: [PATCH 4/5] sbitmap: rewrite sbitmap_find_bit_in_index to reduce repeat code
Date:   Thu, 1 Dec 2022 12:54:07 +0800
Message-ID: <20221201045408.21908-5-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221201045408.21908-1-shikemeng@huawei.com>
References: <20221201045408.21908-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 lib/sbitmap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 70b62b1e40a1..b6a2cdb9bdaf 100644
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

