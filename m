Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B638F6F1396
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbjD1IwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbjD1Ivb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:51:31 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D432E4C18;
        Fri, 28 Apr 2023 01:51:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q75td4kcyz4f3jYw;
        Fri, 28 Apr 2023 16:51:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAGiUtkh9RFIQ--.49176S11;
        Fri, 28 Apr 2023 16:51:23 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, vishal.l.verma@intel.com, dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 07/10] block/badblocks: factor out a helper to merge badblocks
Date:   Fri, 28 Apr 2023 16:50:17 +0800
Message-Id: <20230428085020.2283981-8-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230428085020.2283981-1-linan666@huaweicloud.com>
References: <20230428085020.2283981-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLAGiUtkh9RFIQ--.49176S11
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45WFyUZFW8uw1UuFykXwb_yoWrXFyxpr
        1ay3WS9FyUXF47W3Z8JF4DKr1rKayfXr4UAFWfA3ykuF18CrZIqF1v9ryruFy09rZxWFn0
        q3WYgry29as8C3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add a helper badblocks_merge() to merge badblocks, it makes code more
readable. No functional change.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 143 +++++++++++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 64 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 3cb8513cbd7f..f498fae201a1 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -144,6 +144,80 @@ static void badblocks_update_acked(struct badblocks *bb)
 		bb->unacked_exist = false;
 }
 
+/*
+ * try to merge new range with lo and hi.
+ * if s is within lo, merge with lo.
+ * if s + sectors > start of hi, merge with hi.
+ *
+ * Return:
+ *  Number of merged sectors
+ */
+static int badblocks_merge(struct badblocks *bb, sector_t s, int sectors,
+			int acknowledged, int *lo, int *hi, bool *changed)
+{
+	u64 *p = bb->page;
+	sector_t a = BB_OFFSET(p[*lo]);
+	sector_t e = a + BB_LEN(p[*lo]);
+	int merged_sectors = 0, ack = acknowledged;
+
+	if (a > s) {
+		*hi = *lo;
+	} else if (e >= s) {
+		/* we can merge with a previous range */
+		if (s > a || s + sectors < e)
+			ack = ack && BB_ACK(p[*lo]);
+
+		if (e < s + sectors)
+			e = s + sectors;
+		if (e - a <= BB_MAX_LEN) {
+			s = e;
+		} else {
+			/*
+			 * does not all fit in one range,
+			 * make p[lo] maximal
+			 */
+			s = a + BB_MAX_LEN;
+		}
+		if (s - a != BB_LEN(p[*lo]) || ack != BB_ACK(p[*lo])) {
+			p[*lo] = BB_MAKE(a, s - a, ack);
+			*changed = true;
+		}
+		merged_sectors += sectors - e + s;
+		sectors = e - s;
+	}
+	if (sectors && *hi < bb->count) {
+		/*
+		 * 'hi' points to the first range that starts after 's'.
+		 * Maybe we can merge with the start of that range
+		 */
+		a = BB_OFFSET(p[*hi]);
+		e = a + BB_LEN(p[*hi]);
+		ack = acknowledged;
+
+		if (a <= s + sectors) {
+			/* merging is possible */
+			if (e <= s + sectors) {
+				/* full overlap */
+				e = s + sectors;
+			} else
+				ack = ack && BB_ACK(p[*hi]);
+
+			a = s;
+			if (e - a <= BB_MAX_LEN)
+				s = e;
+			else
+				s = a + BB_MAX_LEN;
+			p[*hi] = BB_MAKE(a, s-a, ack);
+
+			merged_sectors += sectors - e + s;
+			*changed = true;
+			*lo = *hi;
+			*hi += 1;
+		}
+	}
+	return merged_sectors;
+}
+
 /**
  * badblocks_set() - Add a range of bad blocks to the table.
  * @bb:		the badblocks structure that holds all badblock information
@@ -191,6 +265,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 		sector_t a;
 		sector_t e;
 		int ack;
+		int merged_sectors;
 
 		/* Find the last range that starts at-or-before 's' */
 		while (hi - lo > 1) {
@@ -203,70 +278,10 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 				hi = mid;
 		}
 
-		/* we found a range that might merge with the start
-		 * of our new range
-		 */
-		a = BB_OFFSET(p[lo]);
-		e = a + BB_LEN(p[lo]);
-		ack = BB_ACK(p[lo]);
-
-		if (a > s) {
-			hi = lo;
-		} else if (e >= s) {
-			/* Yes, we can merge with a previous range */
-			if (s == a && s + sectors >= e)
-				/* new range covers old */
-				ack = acknowledged;
-			else
-				ack = ack && acknowledged;
-
-			if (e < s + sectors)
-				e = s + sectors;
-			if (e - a <= BB_MAX_LEN) {
-				s = e;
-			} else {
-				/* does not all fit in one range,
-				 * make p[lo] maximal
-				 */
-				s = a + BB_MAX_LEN;
-			}
-			if (s - a != BB_LEN(p[lo]) || ack != BB_ACK(p[lo])) {
-				p[lo] = BB_MAKE(a, s - a, ack);
-				changed = true;
-			}
-			sectors = e - s;
-		}
-		if (sectors && hi < bb->count) {
-			/* 'hi' points to the first range that starts after 's'.
-			 * Maybe we can merge with the start of that range
-			 */
-			a = BB_OFFSET(p[hi]);
-			e = a + BB_LEN(p[hi]);
-			ack = BB_ACK(p[hi]);
-
-			if (a <= s + sectors) {
-				/* merging is possible */
-				if (e <= s + sectors) {
-					/* full overlap */
-					e = s + sectors;
-					ack = acknowledged;
-				} else
-					ack = ack && acknowledged;
-
-				a = s;
-				if (e - a <= BB_MAX_LEN) {
-					p[hi] = BB_MAKE(a, e-a, ack);
-					s = e;
-				} else {
-					p[hi] = BB_MAKE(a, BB_MAX_LEN, ack);
-					s = a + BB_MAX_LEN;
-				}
-				sectors = e - s;
-				lo = hi;
-				hi++;
-				changed = true;
-			}
-		}
+		merged_sectors = badblocks_merge(bb, s, sectors, acknowledged,
+						 &lo, &hi, &changed);
+		s += merged_sectors;
+		sectors -= merged_sectors;
 		if (sectors == 0 && hi < bb->count) {
 			/* we might be able to combine lo and hi */
 			/* Note: 's' is at the end of 'lo' */
-- 
2.31.1

