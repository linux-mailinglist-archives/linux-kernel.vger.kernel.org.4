Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111506F6C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjEDMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjEDMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:49:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CEB6A5A;
        Thu,  4 May 2023 05:49:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QBttp36s5z4f3v5G;
        Thu,  4 May 2023 20:49:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHdqVNkzuf5Ig--.27873S13;
        Thu, 04 May 2023 20:49:39 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 09/11] block/badblocks: factor out a helper to combine badblocks
Date:   Thu,  4 May 2023 20:48:26 +0800
Message-Id: <20230504124828.679770-10-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504124828.679770-1-linan666@huaweicloud.com>
References: <20230504124828.679770-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHdqVNkzuf5Ig--.27873S13
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWrAFyxGF15Kw4xuw4rKrg_yoW5ZFyUpw
        1Sy3Waqr1xWFWI9a1UJa1DKr13Ka97Zr4rJF4fAw1xCF18CwnI9rnrJw1Ygay8KFWfXF90
        q34rWFyjyF97GwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add a helper badblocks_combine() to combine badblocks, it makes code more
readable. No functional change.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 87 ++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index f498fae201a1..c87c68d4bcac 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -218,6 +218,51 @@ static int badblocks_merge(struct badblocks *bb, sector_t s, int sectors,
 	return merged_sectors;
 }
 
+/*
+ * try to combine lo and hi(lo + 1) if lo intersects with hi
+ */
+static void badblocks_combine(struct badblocks *bb, int lo)
+{
+	u64 *p = bb->page;
+	sector_t loe = BB_OFFSET(p[lo]) + BB_LEN(p[lo]);
+	int hi = lo + 1;
+
+	if (hi >= bb->count)
+		return;
+	/* we might be able to combine lo and hi */
+
+	if (loe >= BB_OFFSET(p[hi])) {
+		sector_t loa = BB_OFFSET(p[lo]), hia = BB_OFFSET(p[hi]);
+		sector_t hie = hia + BB_LEN(p[hi]);
+		int newlen = max(loe, hie) - loa;
+		int ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
+
+		while (loe >= hie) {
+			/* lo contains hi, just remove hi */
+			memmove(p + hi, p + hi + 1,
+				(bb->count - hi - 1) * 8);
+			bb->count--;
+			if (hi >= bb->count)
+				break;
+			hia = BB_OFFSET(p[hi]);
+			hie = hia + BB_LEN(p[hi]);
+		}
+		if (loe >= hia && hi < bb->count) {
+			if (newlen > BB_MAX_LEN) {
+				p[lo] = BB_MAKE(loa, BB_MAX_LEN, ack);
+				p[hi] = BB_MAKE(loa + BB_MAX_LEN,
+						newlen - BB_MAX_LEN,
+						BB_ACK(p[hi]));
+			} else {
+				p[lo] = BB_MAKE(loa, newlen, ack);
+				memmove(p + hi, p + hi + 1,
+					(bb->count - hi - 1) * 8);
+				bb->count--;
+			}
+		}
+	}
+}
+
 /**
  * badblocks_set() - Add a range of bad blocks to the table.
  * @bb:		the badblocks structure that holds all badblock information
@@ -262,16 +307,13 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 	lo = 0;
 	hi = bb->count;
 	if (bb->count) {
-		sector_t a;
-		sector_t e;
-		int ack;
 		int merged_sectors;
 
 		/* Find the last range that starts at-or-before 's' */
 		while (hi - lo > 1) {
 			int mid = (lo + hi) / 2;
+			int a = BB_OFFSET(p[mid]);
 
-			a = BB_OFFSET(p[mid]);
 			if (a <= s)
 				lo = mid;
 			else
@@ -282,41 +324,8 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 						 &lo, &hi, &changed);
 		s += merged_sectors;
 		sectors -= merged_sectors;
-		if (sectors == 0 && hi < bb->count) {
-			/* we might be able to combine lo and hi */
-			/* Note: 's' is at the end of 'lo' */
-			sector_t loa = BB_OFFSET(p[lo]), hia = BB_OFFSET(p[hi]);
-			sector_t hie = hia + BB_LEN(p[hi]);
-			int newlen = max(s, hie) - loa;
-
-			ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
-			if (s >= hia) {
-				while (s >= hie) {
-					/* lo contains hi, just remove hi */
-					memmove(p + hi, p + hi + 1,
-						(bb->count - hi - 1) * 8);
-					bb->count--;
-					if (hi >= bb->count)
-						break;
-					hia = BB_OFFSET(p[hi]);
-					hie = hia + BB_LEN(p[hi]);
-				}
-				if (s >= hia && hi < bb->count) {
-					if (newlen > BB_MAX_LEN) {
-						p[lo] = BB_MAKE(loa, BB_MAX_LEN, ack);
-						p[hi] = BB_MAKE(loa + BB_MAX_LEN,
-								newlen - BB_MAX_LEN,
-								BB_ACK(p[hi]));
-					} else {
-						p[lo] = BB_MAKE(loa, newlen, ack);
-						memmove(p + hi, p + hi + 1,
-							(bb->count - hi - 1) * 8);
-						bb->count--;
-					}
-				}
-				changed = true;
-			}
-		}
+		if (sectors == 0)
+			badblocks_combine(bb, lo);
 	}
 	while (sectors) {
 		/* didn't merge (it all).
-- 
2.31.1

