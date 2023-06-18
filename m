Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA7F73455F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFRIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjFRIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:09:03 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502BE70;
        Sun, 18 Jun 2023 01:09:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QkQX86bCZz4f3nyQ;
        Sun, 18 Jun 2023 16:08:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZSXu45kz8rjLw--.30784S5;
        Sun, 18 Jun 2023 16:08:58 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC 1/7] blk-mq: factor out a structure from blk_mq_tags to control tag sharing
Date:   Mon, 19 Jun 2023 00:07:32 +0800
Message-Id: <20230618160738.54385-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230618160738.54385-1-yukuai1@huaweicloud.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZSXu45kz8rjLw--.30784S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXrykAw43Wr17AFy8Kr4Durg_yoW5urWDpa
        98Ga17Cw1fJr1UXFWqq3y7XF1SganIyF1xGwn3W34YyF1jkw1fZr109rW0vr48ZrsayF47
        Grs8trWktF1UW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRE2NtUUUUUU=
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

Currently tags is fair shared, and the new structure contains only one
field active_queues. There are no functional changes and prepare to
refactor tag sharing.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c |  2 +-
 block/blk-mq-tag.c     |  8 ++++----
 block/blk-mq.h         |  2 +-
 include/linux/blk-mq.h | 10 ++++++++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index c3b5930106b2..431aaa3eb181 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -401,7 +401,7 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
 	seq_printf(m, "active_queues=%d\n",
-		   READ_ONCE(tags->active_queues));
+		   READ_ONCE(tags->ctl.active_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
 	sbitmap_queue_show(&tags->bitmap_tags, m);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..fe41a0d34fc0 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -57,8 +57,8 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 	}
 
 	spin_lock_irq(&tags->lock);
-	users = tags->active_queues + 1;
-	WRITE_ONCE(tags->active_queues, users);
+	users = tags->ctl.active_queues + 1;
+	WRITE_ONCE(tags->ctl.active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
 	spin_unlock_irq(&tags->lock);
 }
@@ -94,8 +94,8 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	}
 
 	spin_lock_irq(&tags->lock);
-	users = tags->active_queues - 1;
-	WRITE_ONCE(tags->active_queues, users);
+	users = tags->ctl.active_queues - 1;
+	WRITE_ONCE(tags->ctl.active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
 	spin_unlock_irq(&tags->lock);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1743857e0b01..ca1c13127868 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -412,7 +412,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 			return true;
 	}
 
-	users = READ_ONCE(hctx->tags->active_queues);
+	users = READ_ONCE(hctx->tags->ctl.active_queues);
 	if (!users)
 		return true;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f401067ac03a..8d2cd6b9d305 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -733,13 +733,16 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		blk_opf_t opf, blk_mq_req_flags_t flags,
 		unsigned int hctx_idx);
 
+struct tag_sharing_ctl {
+	unsigned int active_queues;
+};
+
 /*
  * Tag address space map.
  */
 struct blk_mq_tags {
 	unsigned int nr_tags;
 	unsigned int nr_reserved_tags;
-	unsigned int active_queues;
 
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
@@ -750,9 +753,12 @@ struct blk_mq_tags {
 
 	/*
 	 * used to clear request reference in rqs[] before freeing one
-	 * request pool
+	 * request pool, and to protect tag_sharing_ctl.
 	 */
 	spinlock_t lock;
+
+	/* used when tags is shared for multiple request_queue or hctx. */
+	struct tag_sharing_ctl ctl;
 };
 
 static inline struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags,
-- 
2.39.2

