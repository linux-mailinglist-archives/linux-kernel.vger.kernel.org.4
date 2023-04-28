Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7A6F139D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345670AbjD1Iwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345632AbjD1Ive (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:51:34 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114944487;
        Fri, 28 Apr 2023 01:51:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q75tf6xTjz4f3lXn;
        Fri, 28 Apr 2023 16:51:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAGiUtkh9RFIQ--.49176S14;
        Fri, 28 Apr 2023 16:51:24 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, vishal.l.verma@intel.com, dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 10/10] block/badblocks: try to merge badblocks as much as possible
Date:   Fri, 28 Apr 2023 16:50:20 +0800
Message-Id: <20230428085020.2283981-11-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230428085020.2283981-1-linan666@huaweicloud.com>
References: <20230428085020.2283981-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLAGiUtkh9RFIQ--.49176S14
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww48tFW5WF4UKF43Cr1xZrb_yoW8Cry7pF
        n0y3WfKry2gr17W3W5X3W8Kr10g34fJF4UCF43Xw1jkFyxGwn3tF1kZw4FqFyjgF43Wrs0
        v3Wruryjva4kCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x0262
        8vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
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

