Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263DE73456C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjFRIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFRIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:09:06 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84DE70;
        Sun, 18 Jun 2023 01:09:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QkQXC48rPz4f3wHV;
        Sun, 18 Jun 2023 16:08:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZSXu45kz8rjLw--.30784S9;
        Sun, 18 Jun 2023 16:09:00 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC 5/7] blk-mq: record the number of times fail to get driver tag while sharing tags
Date:   Mon, 19 Jun 2023 00:07:36 +0800
Message-Id: <20230618160738.54385-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230618160738.54385-1-yukuai1@huaweicloud.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZSXu45kz8rjLw--.30784S9
X-Coremail-Antispam: 1UD129KBjvJXoWxur1fKF4UWF4kAFy3tw1xGrg_yoW5XFWUpF
        W7KF45K34rXr47uayDt39Fk3WfKws2kr15Ka4Iq34rZr1akr4F9w18Kry8Zr48CrZ3CrsF
        vryYgryjyF17A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Add a atomic counter to record such times, such counter will be used to
adjust the number of tags assigned to active queues. And this counter will
degrade each seconds so that it will only represent io pressure
recently.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c     | 22 ++++++++++++++++++++--
 include/linux/blkdev.h |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index e0137206c02b..5e5742c7277a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -45,6 +45,17 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
 			users);
 }
 
+static void update_tag_sharing_busy(struct tag_sharing *tag_sharing)
+{
+	unsigned int count = atomic_inc_return(&tag_sharing->fail_count);
+	unsigned long last_period = READ_ONCE(tag_sharing->period);
+
+	if (time_after(jiffies, last_period + HZ) &&
+	    cmpxchg_relaxed(&tag_sharing->period, last_period, jiffies) ==
+			    last_period)
+		atomic_sub(count / 2, &tag_sharing->fail_count);
+}
+
 void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_tags *tags = hctx->tags;
@@ -57,12 +68,16 @@ void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
 		struct request_queue *q = hctx->queue;
 
 		if (test_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags) ||
-		    test_and_set_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags))
+		    test_and_set_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags)) {
+			update_tag_sharing_busy(&q->tag_sharing);
 			return;
+		}
 	} else {
 		if (test_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state) ||
-		    test_and_set_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state))
+		    test_and_set_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state)) {
+			update_tag_sharing_busy(&hctx->tag_sharing);
 			return;
+		}
 	}
 
 	spin_lock_irq(&tags->lock);
@@ -152,8 +167,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	}
 
 	spin_lock_irq(&tags->lock);
+
 	list_del_init(&tag_sharing->node);
 	tag_sharing->available_tags = tags->nr_tags;
+	atomic_set(&tag_sharing->fail_count, 0);
+
 	__blk_mq_driver_tag_idle(hctx);
 	WRITE_ONCE(tags->ctl.active_queues, tags->ctl.active_queues - 1);
 	WRITE_ONCE(tags->ctl.share_queues, tags->ctl.active_queues);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e5111bedfd8d..f3faaf5f6504 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -378,6 +378,8 @@ struct blk_independent_access_ranges {
 struct tag_sharing {
 	struct list_head	node;
 	unsigned int		available_tags;
+	atomic_t		fail_count;
+	unsigned long		period;
 };
 
 struct request_queue {
-- 
2.39.2

