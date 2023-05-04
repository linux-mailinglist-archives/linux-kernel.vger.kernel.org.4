Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2421C6F6C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjEDMuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjEDMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:49:51 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDACA46BC;
        Thu,  4 May 2023 05:49:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QBttn30SKz4f3tDr;
        Thu,  4 May 2023 20:49:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHdqVNkzuf5Ig--.27873S12;
        Thu, 04 May 2023 20:49:39 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 08/11] block/badblocks: factor out a helper to merge badblocks
Date:   Thu,  4 May 2023 20:48:25 +0800
Message-Id: <20230504124828.679770-9-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504124828.679770-1-linan666@huaweicloud.com>
References: <20230504124828.679770-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHdqVNkzuf5Ig--.27873S12
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45WFyUZFW8uw1UuFykXwb_yoWrXFyxpr
        1ay3WS9FyUXF47W3Z8JF4DKr1rKayfXr4UAFWfA3ykuF18CrZIqF1v9ryruFy09rZxWFn0
        q3WYgry29as8C3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUwZ2-UUUUU
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

