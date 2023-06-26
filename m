Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3373D93C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjFZIK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjFZIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:10:16 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F8110DF;
        Mon, 26 Jun 2023 01:10:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqL9j66NBz4f4FTB;
        Mon, 26 Jun 2023 16:10:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLPWR5lkQbNDMg--.19922S6;
        Mon, 26 Jun 2023 16:10:02 +0800 (CST)
From:   linan666@huaweicloud.com
To:     axboe@kernel.dk, linan122@huawei.com, vishal.l.verma@intel.com,
        dan.j.williams@intel.com, ashok_raj@linux.intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v4 2/4] block/badblocks: only set bb->changed/unacked_exist when badblocks changes
Date:   Mon, 26 Jun 2023 16:09:11 +0800
Message-Id: <20230626080913.3493135-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626080913.3493135-1-linan666@huaweicloud.com>
References: <20230626080913.3493135-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLPWR5lkQbNDMg--.19922S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry8uF1DCr43tFyrAw1UWrg_yoW8Cr15pF
        98C3WftrWjg3WIgF1UZ3ZxKw1FgayfXF48Gr4ay345Gry8G3s3tF1vq34aqa4jgr1avrnI
        qa4FgryYva4DC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU1H7K7UUUUU==
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

In badblocks_set(), even if no badblocks changes, bb->changed and
unacked_exist will still be set. Only set them when badblocks changes.

Fixes: 9e0e252a048b ("badblocks: Add core badblock management code")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index f28e971a4b94..7b1ad364e85c 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -166,6 +166,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 	int lo, hi;
 	int rv = 0;
 	unsigned long flags;
+	bool changed = false;
 
 	if (bb->shift < 0)
 		/* badblocks are disabled */
@@ -229,6 +230,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 				s = a + BB_MAX_LEN;
 			}
 			sectors = e - s;
+			changed = true;
 		}
 	}
 	if (sectors && hi < bb->count) {
@@ -259,6 +261,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 			sectors = e - s;
 			lo = hi;
 			hi++;
+			changed = true;
 		}
 	}
 	if (sectors == 0 && hi < bb->count) {
@@ -277,6 +280,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 			memmove(p + hi, p + hi + 1,
 				(bb->count - hi - 1) * 8);
 			bb->count--;
+			changed = true;
 		}
 	}
 	while (sectors) {
@@ -299,14 +303,17 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 			p[hi] = BB_MAKE(s, this_sectors, acknowledged);
 			sectors -= this_sectors;
 			s += this_sectors;
+			changed = true;
 		}
 	}
 
-	bb->changed = true;
-	if (!acknowledged)
-		bb->unacked_exist = true;
-	else
-		badblocks_update_acked(bb);
+	if (changed) {
+		bb->changed = changed;
+		if (!acknowledged)
+			bb->unacked_exist = true;
+		else
+			badblocks_update_acked(bb);
+	}
 	write_sequnlock_irqrestore(&bb->lock, flags);
 
 	return rv;
-- 
2.39.2

