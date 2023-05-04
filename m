Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFEE6F6C57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjEDMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjEDMtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:49:50 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE91C6A78;
        Thu,  4 May 2023 05:49:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QBttm1rNzz4f3pFw;
        Thu,  4 May 2023 20:49:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHdqVNkzuf5Ig--.27873S8;
        Thu, 04 May 2023 20:49:37 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 04/11] block/badblocks: fix badblocks overlap
Date:   Thu,  4 May 2023 20:48:21 +0800
Message-Id: <20230504124828.679770-5-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504124828.679770-1-linan666@huaweicloud.com>
References: <20230504124828.679770-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHdqVNkzuf5Ig--.27873S8
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF17Xw4fuFy8tFWrJrW7XFb_yoW8KF4rpw
        1Sy3Wagry8WFyI9F45X3WDWr1fKas7Jr4UGa13A34UWFykCrnakF1ktw1j9rW8KFZ7XFs0
        v3yrWFyj9F98GwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
        xhVjvjDU0xZFpf9x07UMa0PUUUUU=
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

