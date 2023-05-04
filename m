Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130FF6F6C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjEDMua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjEDMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:49:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D116A7D;
        Thu,  4 May 2023 05:49:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QBttq1GYTz4f3kkN;
        Thu,  4 May 2023 20:49:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHdqVNkzuf5Ig--.27873S15;
        Thu, 04 May 2023 20:49:40 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 11/11] block/badblocks: try to merge badblocks as much as possible
Date:   Thu,  4 May 2023 20:48:28 +0800
Message-Id: <20230504124828.679770-12-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504124828.679770-1-linan666@huaweicloud.com>
References: <20230504124828.679770-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHdqVNkzuf5Ig--.27873S15
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww48tFW5WF4UKF43Cr1xZrb_yoW8Cry7pF
        n0y3WfKry2gr17W3W5X3W8Kr10g34fJF4UCF43Xw1jkFyxGwn3tF1kZw4FqFyjgF43Wrs0
        v3Wruryjva4kCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1lksDUUUUU==
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

If we set a new badblocks, we first merge it with existing region, then
try to combine lo and hi. If there are still badblocks need to be set,
create it. It is a bad way when setting a laget number of badblocks. for
example, it will become chaotic if we set as below:

  # echo 1 1 > bad_blocks
  # echo 512 1 > bad_blocks
  # echo 0 513 > bad_blocks
  # cat bad_blocks
    0 512
    512 1
    512 1

Fix it by trying to merge as much as possible. If we have merged any
badblocks, retry to merge next sectors. Do not check sectors while
combining, we should combine lo and hi each sycle.

Fixes: 9e0e252a048b ("badblocks: Add core badblock management code")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index bb0324b66f57..7e6fce10c82d 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -347,8 +347,6 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 	lo = 0;
 	hi = bb->count;
 	if (bb->count) {
-		int merged_sectors;
-
 		/* Find the last range that starts at-or-before 's' */
 		while (hi - lo > 1) {
 			int mid = (lo + hi) / 2;
@@ -360,12 +358,19 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 				hi = mid;
 		}
 
-		merged_sectors = badblocks_merge(bb, s, sectors, acknowledged,
-						 &lo, &hi, &changed);
-		s += merged_sectors;
-		sectors -= merged_sectors;
-		if (sectors == 0)
+		while (sectors) {
+			int merged_sectors;
+
+			merged_sectors = badblocks_merge(bb, s, sectors, acknowledged,
+							 &lo, &hi, &changed);
+			/* can't merge, break to create */
+			if (!merged_sectors)
+				break;
+
+			s += merged_sectors;
+			sectors -= merged_sectors;
 			badblocks_combine(bb, lo);
+		}
 	}
 	rv = badblocks_create(bb, s, sectors, hi, acknowledged, &changed);
 
-- 
2.31.1

