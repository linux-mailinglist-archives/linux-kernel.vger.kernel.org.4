Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9108163E921
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLAEzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLAEy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:54:59 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647BFA055A;
        Wed, 30 Nov 2022 20:54:57 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NN3cj6nwbzHwNG;
        Thu,  1 Dec 2022 12:53:41 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 1 Dec
 2022 12:54:13 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huaweicloud.com>, <linfeilong@huawei.com>,
        <liuzhiqiang@huawei.com>
Subject: [PATCH 5/5] sbitmap: add sbitmap_find_bit to remove repeat code in __sbitmap_get/__sbitmap_get_shallow
Date:   Thu, 1 Dec 2022 12:54:08 +0800
Message-ID: <20221201045408.21908-6-shikemeng@huawei.com>
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

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 lib/sbitmap.c | 72 +++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index b6a2cdb9bdaf..93e7db484b96 100644
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

