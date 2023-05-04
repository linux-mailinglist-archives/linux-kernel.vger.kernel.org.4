Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758126F6C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjEDMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjEDMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:49:51 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AAD6A66;
        Thu,  4 May 2023 05:49:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QBttp22fCz4f3v6h;
        Thu,  4 May 2023 20:49:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHdqVNkzuf5Ig--.27873S14;
        Thu, 04 May 2023 20:49:40 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 10/11] block/badblocks: factor out a helper to create badblocks
Date:   Thu,  4 May 2023 20:48:27 +0800
Message-Id: <20230504124828.679770-11-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504124828.679770-1-linan666@huaweicloud.com>
References: <20230504124828.679770-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHdqVNkzuf5Ig--.27873S14
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4UCrW7tFW8WrWxZF48tFb_yoW8tr43pr
        sIy3Zagry7Ww1xXanxX3ZrKr1rK3yfZF1UGr47Aw1UGFyxCwnrtFn2vryfuFyj9Fy3Jr4q
        q3WYgryY9asrC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

