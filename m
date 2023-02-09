Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E94690857
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBIMLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBIMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:11:13 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906FE4C31;
        Thu,  9 Feb 2023 04:09:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PCFyz2wPhz4f3l7J;
        Thu,  9 Feb 2023 20:09:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrFr4uRj4rAuDQ--.53349S3;
        Thu, 09 Feb 2023 20:09:17 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, hch@lst.de, jack@suse.cz
Cc:     andriy.shevchenko@linux.intel.com, qiulaibin@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] blk-mq: sync wake_batch update and users number change
Date:   Fri, 10 Feb 2023 04:11:10 +0800
Message-Id: <20230209201116.579809-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230209201116.579809-1-shikemeng@huaweicloud.com>
References: <20230209201116.579809-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrFr4uRj4rAuDQ--.53349S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF15ur4DGF17tryrAF4ktFb_yoW5WFyxpa
        y7ta17Kw1Fvry2qFW7JwsrXF4S9F4DKr13WrZaqa4rAw1Ykw1rur1kGrWkWrW0qr4kCr4x
        Aw47trZYyFsrAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
        0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0PPEDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be awakened")
added recalculation of wake_batch when active_queues changes to avoid io
hung.
Function blk_mq_tag_idle and blk_mq_tag_busy can be called concurrently,
then wake_batch maybe updated with old users number. For example, if
tag alloctions for two shared queue happen concurrently, blk_mq_tag_busy
maybe executed as following:
thread1  			thread2
atomic_inc_return
				atomic_inc_return
				blk_mq_update_wake_batch
blk_mq_update_wake_batch

1.Thread1 adds active_queues from zero to one.
2.Thread2 adds active_queues from one to two.
3.Thread2 calculates wake_batch with latest active_queues number two.
4.Thread1 calculates wake_batch with stale active_queues number one.
Then wake_batch is inconsistent with actual active_queues. If wake_batch
is calculated with active_queues number smaller than actual active_queues
number, wake_batch will be greater than it supposed to be and cause io
hung.

Sync wake_batch update and users number change to keep wake_batch
consistent with active_queues to fix this.

Fixes: 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq-tag.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9eb968e14d31..1d3135acfc98 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -39,7 +39,9 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
  */
 void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
+	struct blk_mq_tags *tags = hctx->tags;
 	unsigned int users;
+	unsigned long flags;
 
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
@@ -53,9 +55,11 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
 	}
 
-	users = atomic_inc_return(&hctx->tags->active_queues);
+	spin_lock_irqsave(&tags->lock, flags);
+	users = atomic_inc_return(&tags->active_queues);
 
-	blk_mq_update_wake_batch(hctx->tags, users);
+	blk_mq_update_wake_batch(tags, users);
+	spin_unlock_irqrestore(&tags->lock, flags);
 }
 
 /*
@@ -76,6 +80,7 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_tags *tags = hctx->tags;
 	unsigned int users;
+	unsigned long flags;
 
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
@@ -88,9 +93,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 			return;
 	}
 
+	spin_lock_irqsave(&tags->lock, flags);
 	users = atomic_dec_return(&tags->active_queues);
 
 	blk_mq_update_wake_batch(tags, users);
+	spin_unlock_irqrestore(&tags->lock, flags);
 
 	blk_mq_tag_wakeup_all(tags, false);
 }
-- 
2.30.0

