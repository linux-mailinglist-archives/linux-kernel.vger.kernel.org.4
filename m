Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C906F139E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbjD1IwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345398AbjD1Ivc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:51:32 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D1468F;
        Fri, 28 Apr 2023 01:51:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q75tc5vsQz4f3mJk;
        Fri, 28 Apr 2023 16:51:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAGiUtkh9RFIQ--.49176S10;
        Fri, 28 Apr 2023 16:51:22 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, vishal.l.verma@intel.com, dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 06/10] block/badblocks: check bb->count instead of 'hi > lo'
Date:   Fri, 28 Apr 2023 16:50:16 +0800
Message-Id: <20230428085020.2283981-7-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230428085020.2283981-1-linan666@huaweicloud.com>
References: <20230428085020.2283981-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLAGiUtkh9RFIQ--.49176S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW7XFykXw1DKw17KFyxGrg_yoWrZryxpw
        4SyaySgFy8WF4S9rn8JF4DGF15KayxZr48JF15Jw1xCF1vkr9I9FnFyw10gFWvkFZ3XFn0
        qw1rWFyIyFZxAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x0262
        8vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1lksDUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

'hi > lo' only holds when bb->count is 0. Check it is complicated after
dichotomy. Check bb->count instead. And this will make future fix more
convenient.

No functional change intended.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 155 +++++++++++++++++++++++-----------------------
 1 file changed, 79 insertions(+), 76 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index c11eb869f2f3..3cb8513cbd7f 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -187,28 +187,32 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 	p = bb->page;
 	lo = 0;
 	hi = bb->count;
-	/* Find the last range that starts at-or-before 's' */
-	while (hi - lo > 1) {
-		int mid = (lo + hi) / 2;
-		sector_t a = BB_OFFSET(p[mid]);
-
-		if (a <= s)
-			lo = mid;
-		else
-			hi = mid;
-	}
-	if (hi > lo && BB_OFFSET(p[lo]) > s)
-		hi = lo;
+	if (bb->count) {
+		sector_t a;
+		sector_t e;
+		int ack;
+
+		/* Find the last range that starts at-or-before 's' */
+		while (hi - lo > 1) {
+			int mid = (lo + hi) / 2;
+
+			a = BB_OFFSET(p[mid]);
+			if (a <= s)
+				lo = mid;
+			else
+				hi = mid;
+		}
 
-	if (hi > lo) {
 		/* we found a range that might merge with the start
 		 * of our new range
 		 */
-		sector_t a = BB_OFFSET(p[lo]);
-		sector_t e = a + BB_LEN(p[lo]);
-		int ack = BB_ACK(p[lo]);
+		a = BB_OFFSET(p[lo]);
+		e = a + BB_LEN(p[lo]);
+		ack = BB_ACK(p[lo]);
 
-		if (e >= s) {
+		if (a > s) {
+			hi = lo;
+		} else if (e >= s) {
 			/* Yes, we can merge with a previous range */
 			if (s == a && s + sectors >= e)
 				/* new range covers old */
@@ -232,72 +236,71 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 			}
 			sectors = e - s;
 		}
-	}
-	if (sectors && hi < bb->count) {
-		/* 'hi' points to the first range that starts after 's'.
-		 * Maybe we can merge with the start of that range
-		 */
-		sector_t a = BB_OFFSET(p[hi]);
-		sector_t e = a + BB_LEN(p[hi]);
-		int ack = BB_ACK(p[hi]);
-
-		if (a <= s + sectors) {
-			/* merging is possible */
-			if (e <= s + sectors) {
-				/* full overlap */
-
-				e = s + sectors;
-				ack = acknowledged;
-			} else
-				ack = ack && acknowledged;
-
-			a = s;
-			if (e - a <= BB_MAX_LEN) {
-				p[hi] = BB_MAKE(a, e-a, ack);
-				s = e;
-			} else {
-				p[hi] = BB_MAKE(a, BB_MAX_LEN, ack);
-				s = a + BB_MAX_LEN;
+		if (sectors && hi < bb->count) {
+			/* 'hi' points to the first range that starts after 's'.
+			 * Maybe we can merge with the start of that range
+			 */
+			a = BB_OFFSET(p[hi]);
+			e = a + BB_LEN(p[hi]);
+			ack = BB_ACK(p[hi]);
+
+			if (a <= s + sectors) {
+				/* merging is possible */
+				if (e <= s + sectors) {
+					/* full overlap */
+					e = s + sectors;
+					ack = acknowledged;
+				} else
+					ack = ack && acknowledged;
+
+				a = s;
+				if (e - a <= BB_MAX_LEN) {
+					p[hi] = BB_MAKE(a, e-a, ack);
+					s = e;
+				} else {
+					p[hi] = BB_MAKE(a, BB_MAX_LEN, ack);
+					s = a + BB_MAX_LEN;
+				}
+				sectors = e - s;
+				lo = hi;
+				hi++;
+				changed = true;
 			}
-			sectors = e - s;
-			lo = hi;
-			hi++;
-			changed = true;
 		}
-	}
-	if (sectors == 0 && hi < bb->count) {
-		/* we might be able to combine lo and hi */
-		/* Note: 's' is at the end of 'lo' */
-		sector_t loa = BB_OFFSET(p[lo]), hia = BB_OFFSET(p[hi]);
-		sector_t hie = hia + BB_LEN(p[hi]);
-		int newlen = max(s, hie) - loa;
-		int ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
-
-		if (s >= hia) {
-			while (s >= hie) {
-				/* lo contains hi, just remove hi */
-				memmove(p + hi, p + hi + 1,
-					(bb->count - hi - 1) * 8);
-				bb->count--;
-				if (hi >= bb->count)
-					break;
-				hia = BB_OFFSET(p[hi]);
-				hie = hia + BB_LEN(p[hi]);
-			}
-			if (s >= hia && hi < bb->count) {
-				if (newlen > BB_MAX_LEN) {
-					p[lo] = BB_MAKE(loa, BB_MAX_LEN, ack);
-					p[hi] = BB_MAKE(loa + BB_MAX_LEN,
-							newlen - BB_MAX_LEN,
-							BB_ACK(p[hi]));
-				} else {
-					p[lo] = BB_MAKE(loa, newlen, ack);
+		if (sectors == 0 && hi < bb->count) {
+			/* we might be able to combine lo and hi */
+			/* Note: 's' is at the end of 'lo' */
+			sector_t loa = BB_OFFSET(p[lo]), hia = BB_OFFSET(p[hi]);
+			sector_t hie = hia + BB_LEN(p[hi]);
+			int newlen = max(s, hie) - loa;
+
+			ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
+			if (s >= hia) {
+				while (s >= hie) {
+					/* lo contains hi, just remove hi */
 					memmove(p + hi, p + hi + 1,
 						(bb->count - hi - 1) * 8);
 					bb->count--;
+					if (hi >= bb->count)
+						break;
+					hia = BB_OFFSET(p[hi]);
+					hie = hia + BB_LEN(p[hi]);
+				}
+				if (s >= hia && hi < bb->count) {
+					if (newlen > BB_MAX_LEN) {
+						p[lo] = BB_MAKE(loa, BB_MAX_LEN, ack);
+						p[hi] = BB_MAKE(loa + BB_MAX_LEN,
+								newlen - BB_MAX_LEN,
+								BB_ACK(p[hi]));
+					} else {
+						p[lo] = BB_MAKE(loa, newlen, ack);
+						memmove(p + hi, p + hi + 1,
+							(bb->count - hi - 1) * 8);
+						bb->count--;
+					}
 				}
+				changed = true;
 			}
-			changed = true;
 		}
 	}
 	while (sectors) {
-- 
2.31.1

