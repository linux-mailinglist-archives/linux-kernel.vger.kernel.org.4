Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2831373456A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFRIJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFRIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:09:05 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEEA1700;
        Sun, 18 Jun 2023 01:09:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QkQXB4mt1z4f4MX9;
        Sun, 18 Jun 2023 16:08:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZSXu45kz8rjLw--.30784S7;
        Sun, 18 Jun 2023 16:08:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC 3/7] blk-mq: support to track active queues from blk_mq_tags
Date:   Mon, 19 Jun 2023 00:07:34 +0800
Message-Id: <20230618160738.54385-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230618160738.54385-1-yukuai1@huaweicloud.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZSXu45kz8rjLw--.30784S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZry8XryktF1rAFyftF1UJrb_yoWrAr4fpF
        W3Ga12k3yrXr1DXFWDK39rC3WIgrs3Kr13Jasag34Yyr1Fkrs3Zr18Kry5ZrWrArZ5Crsr
        CrWjgry0yF1UAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiyCJDUUUUU=
        =
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

In order to refactor how tags is shared, it's necessary to acquire some
information for each disk/hctx, so that more tags can be assigned to the
one with higher pressure.

Prepare to refactor tag sharing.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c     | 13 +++++++++++++
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 1c2bde917195..8c527e68d4e4 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -64,6 +64,7 @@ void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
 void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_tags *tags = hctx->tags;
+	struct tag_sharing *tag_sharing;
 
 	/*
 	 * calling test_bit() prior to test_and_set_bit() is intentional,
@@ -75,13 +76,18 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
 		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return;
+
+		tag_sharing = &q->tag_sharing;
 	} else {
 		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
 		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return;
+
+		tag_sharing = &hctx->tag_sharing;
 	}
 
 	spin_lock_irq(&tags->lock);
+	list_add(&tag_sharing->node, &tags->ctl.head);
 	WRITE_ONCE(tags->ctl.active_queues, tags->ctl.active_queues + 1);
 	spin_unlock_irq(&tags->lock);
 }
@@ -111,6 +117,7 @@ static void __blk_mq_driver_tag_idle(struct blk_mq_hw_ctx *hctx)
 void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_tags *tags = hctx->tags;
+	struct tag_sharing *tag_sharing;
 
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
@@ -118,12 +125,17 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 		if (!test_and_clear_bit(QUEUE_FLAG_HCTX_ACTIVE,
 					&q->queue_flags))
 			return;
+
+		tag_sharing = &q->tag_sharing;
 	} else {
 		if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return;
+
+		tag_sharing = &hctx->tag_sharing;
 	}
 
 	spin_lock_irq(&tags->lock);
+	list_del_init(&tag_sharing->node);
 	__blk_mq_driver_tag_idle(hctx);
 	WRITE_ONCE(tags->ctl.active_queues, tags->ctl.active_queues - 1);
 	WRITE_ONCE(tags->ctl.share_queues, tags->ctl.active_queues);
@@ -619,6 +631,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 	spin_lock_init(&tags->lock);
+	INIT_LIST_HEAD(&tags->ctl.head);
 
 	if (blk_mq_init_bitmaps(&tags->bitmap_tags, &tags->breserved_tags,
 				total_tags, reserved_tags, node,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index bc3ac22edb07..639d618e6ca8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -390,6 +390,7 @@ struct blk_mq_hw_ctx {
 	 * assigned when a request is dispatched from a hardware queue.
 	 */
 	struct blk_mq_tags	*tags;
+	struct tag_sharing	tag_sharing;
 	/**
 	 * @sched_tags: Tags owned by I/O scheduler. If there is an I/O
 	 * scheduler associated with a request queue, a tag is assigned when
@@ -737,6 +738,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 struct tag_sharing_ctl {
 	unsigned int active_queues;
 	unsigned int share_queues;
+	struct list_head head;
 };
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0994707f6a68..62f8fcc20c30 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -375,6 +375,10 @@ struct blk_independent_access_ranges {
 	struct blk_independent_access_range	ia_range[];
 };
 
+struct tag_sharing {
+	struct list_head node;
+};
+
 struct request_queue {
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
@@ -513,6 +517,7 @@ struct request_queue {
 
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
+	struct tag_sharing	tag_sharing;
 
 	struct dentry		*debugfs_dir;
 	struct dentry		*sched_debugfs_dir;
-- 
2.39.2

