Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F272A87A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjFJCfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjFJCfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:35:06 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5628935B3;
        Fri,  9 Jun 2023 19:35:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QdMVX4xj3z4f3m7K;
        Sat, 10 Jun 2023 10:35:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZRT4YNktllkLQ--.11524S4;
        Sat, 10 Jun 2023 10:35:01 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, axboe@kernel.dk, qiulaibin@huawei.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2] blk-mq: fix potential io hang by wrong 'wake_batch'
Date:   Sat, 10 Jun 2023 10:30:43 +0800
Message-Id: <20230610023043.2559121-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZRT4YNktllkLQ--.11524S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWrAFW7Jr15ZrWfWw4kJFb_yoWrJF4fpa
        yUCa17Kw1Sqr1UXayDt39rXF1Sgan0yr13Jrsaqa4YvF1j9r1fXr18urW0qrW0qrs3AF43
        urs8trW8tF4UG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

In __blk_mq_tag_busy/idle(), updating 'active_queues' and calculating
'wake_batch' is not atomic:

t1:			t2:
_blk_mq_tag_busy	blk_mq_tag_busy
inc active_queues
// assume 1->2
			inc active_queues
			// 2 -> 3
			blk_mq_update_wake_batch
			// calculate based on 3
blk_mq_update_wake_batch
/* calculate based on 2, while active_queues is actually 3. */

Fix this problem by protecting them wih 'tags->lock', this is not a hot
path, so performance should not be concerned. And now that all writers
are inside the lock, switch 'actives_queues' from atomic to unsigned
int.

Fixes: 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - switch 'active_queues' from atomic to unsigned int.

 block/blk-mq-debugfs.c |  2 +-
 block/blk-mq-tag.c     | 15 ++++++++++-----
 block/blk-mq.h         |  3 +--
 include/linux/blk-mq.h |  3 +--
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 68165a50951b..c3b5930106b2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -401,7 +401,7 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
 	seq_printf(m, "active_queues=%d\n",
-		   atomic_read(&tags->active_queues));
+		   READ_ONCE(tags->active_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
 	sbitmap_queue_show(&tags->bitmap_tags, m);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index dfd81cab5788..cc57e2dd9a0b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -38,6 +38,7 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
 void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
+	struct blk_mq_tags *tags = hctx->tags;
 
 	/*
 	 * calling test_bit() prior to test_and_set_bit() is intentional,
@@ -55,9 +56,11 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 			return;
 	}
 
-	users = atomic_inc_return(&hctx->tags->active_queues);
-
-	blk_mq_update_wake_batch(hctx->tags, users);
+	spin_lock_irq(&tags->lock);
+	users = tags->active_queues + 1;
+	WRITE_ONCE(tags->active_queues, users);
+	blk_mq_update_wake_batch(tags, users);
+	spin_unlock_irq(&tags->lock);
 }
 
 /*
@@ -90,9 +93,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 			return;
 	}
 
-	users = atomic_dec_return(&tags->active_queues);
-
+	spin_lock_irq(&tags->lock);
+	users = tags->active_queues - 1;
+	WRITE_ONCE(tags->active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
+	spin_unlock_irq(&tags->lock);
 
 	blk_mq_tag_wakeup_all(tags, false);
 }
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8c642e9f32f1..1743857e0b01 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -412,8 +412,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 			return true;
 	}
 
-	users = atomic_read(&hctx->tags->active_queues);
-
+	users = READ_ONCE(hctx->tags->active_queues);
 	if (!users)
 		return true;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 59b52ec155b1..f401067ac03a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -739,8 +739,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 struct blk_mq_tags {
 	unsigned int nr_tags;
 	unsigned int nr_reserved_tags;
-
-	atomic_t active_queues;
+	unsigned int active_queues;
 
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
-- 
2.39.2

