Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3018461270A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJ3DHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJ3DHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:07:30 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56F65360A1;
        Sat, 29 Oct 2022 20:07:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app3 (Coremail) with SMTP id cC_KCgAXlrpJ6l1jv9B1CA--.27265S5;
        Sun, 30 Oct 2022 11:07:19 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, nickyc975@zju.edu.cn
Subject: [PATCH v2 3/3] block: hide back blk_freeze_queue_start and export its blk-mq alias
Date:   Sun, 30 Oct 2022 11:06:48 +0800
Message-Id: <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667098953.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667098953.git.nickyc975@zju.edu.cn>
References: <cover.1667098953.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgAXlrpJ6l1jv9B1CA--.27265S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1xCw1UZF4rGF45Ary5Arb_yoW7Kry8pF
        ZxXa13Aw10gr4UXrW8Jw47Zr9xKw4vg347C3yftryYvrn8Kas3ZF17A3W5XF48ArWkCFs8
        ArWDKrsrCr18JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI
        7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgUTB1ZdtcKOnAABs8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_freeze_queue_start is used internally for universal queue draining and
externally for blk-mq specific queue freezing. Keep the non-blk-mq name
private and export a blk-mq alias to users.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/blk-core.c              | 13 +++++++++++++
 block/blk-mq.c                | 27 ++++++++++++++-------------
 block/blk-pm.c                |  2 +-
 block/blk.h                   |  1 +
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  2 +-
 include/linux/blk-mq.h        |  2 +-
 7 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5d50dd16e2a5..d3dd439a8ed4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -269,6 +269,19 @@ void blk_put_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_put_queue);
 
+void blk_freeze_queue_start(struct request_queue *q)
+{
+	mutex_lock(&q->mq_freeze_lock);
+	if (++q->mq_freeze_depth == 1) {
+		percpu_ref_kill(&q->q_usage_counter);
+		mutex_unlock(&q->mq_freeze_lock);
+		if (queue_is_mq(q))
+			blk_mq_run_hw_queues(q, false);
+	} else {
+		mutex_unlock(&q->mq_freeze_lock);
+	}
+}
+
 void blk_queue_start_drain(struct request_queue *q)
 {
 	/*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e0654a2e80b9..d638bd0fb4d8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -161,19 +161,20 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 	inflight[1] = mi.inflight[1];
 }
 
-void blk_freeze_queue_start(struct request_queue *q)
+void blk_mq_freeze_queue_start(struct request_queue *q)
 {
-	mutex_lock(&q->mq_freeze_lock);
-	if (++q->mq_freeze_depth == 1) {
-		percpu_ref_kill(&q->q_usage_counter);
-		mutex_unlock(&q->mq_freeze_lock);
-		if (queue_is_mq(q))
-			blk_mq_run_hw_queues(q, false);
-	} else {
-		mutex_unlock(&q->mq_freeze_lock);
-	}
+	/*
+	 * Warn on non-blk-mq usages.
+	 */
+	WARN_ON_ONCE(!queue_is_mq(q));
+
+	/*
+	 * Just an alias of blk_freeze_queue_start to keep the consistency of the
+	 * blk_mq_* namespace.
+	 */
+	blk_freeze_queue_start(q);
 }
-EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
+EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_start);
 
 void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
@@ -196,7 +197,7 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
  */
 void blk_mq_freeze_queue(struct request_queue *q)
 {
-	blk_freeze_queue_start(q);
+	blk_mq_freeze_queue_start(q);
 	blk_mq_freeze_queue_wait(q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
@@ -1570,7 +1571,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	 * percpu_ref_tryget directly, because we need to be able to
 	 * obtain a reference even in the short window between the queue
 	 * starting to freeze, by dropping the first reference in
-	 * blk_freeze_queue_start, and the moment the last request is
+	 * blk_mq_freeze_queue_start, and the moment the last request is
 	 * consumed, marked by the instant q_usage_counter reaches
 	 * zero.
 	 */
diff --git a/block/blk-pm.c b/block/blk-pm.c
index 2dad62cc1572..ae2b950ed45d 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -80,7 +80,7 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	blk_set_pm_only(q);
 	ret = -EBUSY;
 	/* Switch q_usage_counter from per-cpu to atomic mode. */
-	blk_freeze_queue_start(q);
+	blk_mq_freeze_queue_start(q);
 	/*
 	 * Wait until atomic mode has been reached. Since that
 	 * involves calling call_rcu(), it is guaranteed that later
diff --git a/block/blk.h b/block/blk.h
index e9addea2838a..ee576bb74382 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -37,6 +37,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 					      gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
+void blk_freeze_queue_start(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0090dc0b3ae6..e2d5c54c651a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5199,7 +5199,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_freeze_queue_start(ns->queue);
+		blk_mq_freeze_queue_start(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0ea7e441e080..3bb358bd0cde 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -77,7 +77,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 	lockdep_assert_held(&subsys->lock);
 	list_for_each_entry(h, &subsys->nsheads, entry)
 		if (h->disk)
-			blk_freeze_queue_start(h->disk->queue);
+			blk_mq_freeze_queue_start(h->disk->queue);
 }
 
 void nvme_failover_req(struct request *req)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 569053ed959d..8600d4b4aa80 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -887,7 +887,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
-void blk_freeze_queue_start(struct request_queue *q);
+void blk_mq_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
-- 
2.31.1

