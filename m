Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88FD6F1399
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbjD1IwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345604AbjD1Iva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:51:30 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3760A49CE;
        Fri, 28 Apr 2023 01:51:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q75tb6dcvz4f3pCb;
        Fri, 28 Apr 2023 16:51:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAGiUtkh9RFIQ--.49176S7;
        Fri, 28 Apr 2023 16:51:21 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, vishal.l.verma@intel.com, dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 03/10] block/badblocks: fix badblocks overlap
Date:   Fri, 28 Apr 2023 16:50:13 +0800
Message-Id: <20230428085020.2283981-4-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230428085020.2283981-1-linan666@huaweicloud.com>
References: <20230428085020.2283981-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLAGiUtkh9RFIQ--.49176S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF17Xw4fuFy8tFWrJrW7XFb_yoW8KF4rpw
        1Sy3Wagry8WFyI9F45X3WDWr1fKas7Jr4UGa13A34UWFykCrnakF1ktw1j9rW8KFZ7XFs0
        v3yrWFyj9F98GwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
        xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
        6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2
        kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjxUwfHjUUUUU
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

badblocks will overlap if we set it as below:

  # echo 0 1 > bad_blocks
  # echo 3 1 > bad_blocks
  # echo 5 1 > bad_blocks
  # echo 0 512 > bad_blocks
  # cat bad_blocks
    0 512
    5 1

The reason for this is we only combine two badblocks once even if it
should be combined many times.

Fix it by classifying combine:
  1)lo contain hi
      just remove hi, and check next hi.
  2)lo intersects with hi
      newlen > BB_MAX_LEN, set lo to MAX, and the remaining is hi.
      newlen <= BB_MAX_LEN, remain unchanged, 2-in-1.

Fixes: 9e0e252a048b ("badblocks: Add core badblock management code")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 2c2ef8284a3f..f34351b59414 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -245,6 +245,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 			/* merging is possible */
 			if (e <= s + sectors) {
 				/* full overlap */
+
 				e = s + sectors;
 				ack = acknowledged;
 			} else
@@ -267,17 +268,35 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 	if (sectors == 0 && hi < bb->count) {
 		/* we might be able to combine lo and hi */
 		/* Note: 's' is at the end of 'lo' */
-		sector_t a = BB_OFFSET(p[lo]);
-		int newlen = max(s, BB_OFFSET(p[hi]) + BB_LEN(p[hi])) - a;
-
-		if (s >= BB_OFFSET(p[hi]) && newlen < BB_MAX_LEN) {
-			/* yes, we can combine them */
-			int ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
-
-			p[lo] = BB_MAKE(a, newlen, ack);
-			memmove(p + hi, p + hi + 1,
-				(bb->count - hi - 1) * 8);
-			bb->count--;
+		sector_t loa = BB_OFFSET(p[lo]), hia = BB_OFFSET(p[hi]);
+		sector_t hie = hia + BB_LEN(p[hi]);
+		int newlen = max(s, hie) - loa;
+		int ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
+
+		if (s >= hia) {
+			while (s >= hie) {
+				/* lo contains hi, just remove hi */
+				memmove(p + hi, p + hi + 1,
+					(bb->count - hi - 1) * 8);
+				bb->count--;
+				if (hi >= bb->count)
+					break;
+				hia = BB_OFFSET(p[hi]);
+				hie = hia + BB_LEN(p[hi]);
+			}
+			if (s >= hia && hi < bb->count) {
+				if (newlen > BB_MAX_LEN) {
+					p[lo] = BB_MAKE(loa, BB_MAX_LEN, ack);
+					p[hi] = BB_MAKE(loa + BB_MAX_LEN,
+							newlen - BB_MAX_LEN,
+							BB_ACK(p[hi]));
+				} else {
+					p[lo] = BB_MAKE(loa, newlen, ack);
+					memmove(p + hi, p + hi + 1,
+						(bb->count - hi - 1) * 8);
+					bb->count--;
+				}
+			}
 			changed = true;
 		}
 	}
-- 
2.31.1

