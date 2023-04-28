Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986646F139C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbjD1Iwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345627AbjD1Ive (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:51:34 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B581D1FCF;
        Fri, 28 Apr 2023 01:51:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q75tf4v39z4f3vfD;
        Fri, 28 Apr 2023 16:51:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAGiUtkh9RFIQ--.49176S13;
        Fri, 28 Apr 2023 16:51:23 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, vishal.l.verma@intel.com, dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 09/10] block/badblocks: factor out a helper to create badblocks
Date:   Fri, 28 Apr 2023 16:50:19 +0800
Message-Id: <20230428085020.2283981-10-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230428085020.2283981-1-linan666@huaweicloud.com>
References: <20230428085020.2283981-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLAGiUtkh9RFIQ--.49176S13
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4UCrW7tFW8WrWxZF48tFb_yoW8tr43pr
        sIy3Zagry7Ww1xXanxX3ZrKr1rK3yfZF1UGr47Aw1UGFyxCwnrtFn2vryfuFyj9Fy3Jr4q
        q3WYgryY9asrC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add a helper badblocks_create() to create badblocks, it makes code more
readable. No functional change.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 65 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index c87c68d4bcac..bb0324b66f57 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -263,6 +263,46 @@ static void badblocks_combine(struct badblocks *bb, int lo)
 	}
 }
 
+/*
+ * creat new badblocks if it can't merge with existing region
+ *
+ * Return:
+ *  0: success
+ *  1: failed to set badblocks (out of space)
+ */
+static int badblocks_create(struct badblocks *bb, sector_t s, sector_t sectors,
+			int hi, int acknowledged, bool *changed)
+{
+	u64 *p = bb->page;
+	int rv = 0;
+
+	while (sectors) {
+		int this_sectors = sectors;
+
+		/* didn't merge (it all).
+		 * Need to add a range just before 'hi'
+		 */
+		if (bb->count >= MAX_BADBLOCKS) {
+			/* No room for more */
+			rv = 1;
+			break;
+		}
+
+		memmove(p + hi + 1, p + hi,
+			(bb->count - hi) * 8);
+		bb->count++;
+
+		if (this_sectors > BB_MAX_LEN)
+			this_sectors = BB_MAX_LEN;
+		p[hi] = BB_MAKE(s, this_sectors, acknowledged);
+		sectors -= this_sectors;
+		s += this_sectors;
+		hi++;
+		*changed = true;
+	}
+	return rv;
+}
+
 /**
  * badblocks_set() - Add a range of bad blocks to the table.
  * @bb:		the badblocks structure that holds all badblock information
@@ -327,30 +367,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 		if (sectors == 0)
 			badblocks_combine(bb, lo);
 	}
-	while (sectors) {
-		/* didn't merge (it all).
-		 * Need to add a range just before 'hi'
-		 */
-		if (bb->count >= MAX_BADBLOCKS) {
-			/* No room for more */
-			rv = 1;
-			break;
-		} else {
-			int this_sectors = sectors;
-
-			memmove(p + hi + 1, p + hi,
-				(bb->count - hi) * 8);
-			bb->count++;
-
-			if (this_sectors > BB_MAX_LEN)
-				this_sectors = BB_MAX_LEN;
-			p[hi] = BB_MAKE(s, this_sectors, acknowledged);
-			sectors -= this_sectors;
-			s += this_sectors;
-			hi++;
-			changed = true;
-		}
-	}
+	rv = badblocks_create(bb, s, sectors, hi, acknowledged, &changed);
 
 	if (changed) {
 		bb->changed = changed;
-- 
2.31.1

