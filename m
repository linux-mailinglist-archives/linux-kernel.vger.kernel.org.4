Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC046129B6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJ3Jrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJ3Jrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:47:47 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56D0E211;
        Sun, 30 Oct 2022 02:47:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app2 (Coremail) with SMTP id by_KCgBn21gzSF5jiVFMBw--.58770S2;
        Sun, 30 Oct 2022 17:47:39 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH] blk-mq: move queue_is_mq out of blk_mq_cancel_work_sync
Date:   Sun, 30 Oct 2022 17:47:30 +0800
Message-Id: <20221030094730.1275463-1-nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgBn21gzSF5jiVFMBw--.58770S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4rtFyUCr1fXFWkKr45KFg_yoW8GrW8pF
        W3J39rta40qayUXFyqqay7XF17GwnxKr1xJrsxAw4Yvr9rGr17Xr18uFyjgF10qrs3ZF4a
        vrZxXFWfZr18GwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI
        7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUFYFADUUUU
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgYTB1ZdtcKYKQAHsa
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller that needs queue_is_mq check is del_gendisk, so move the
check into it.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/blk-mq.c | 12 +++++-------
 block/genhd.c  |  4 +++-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8ca49530bdf3..e2a332786ebd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4851,15 +4851,13 @@ EXPORT_SYMBOL(blk_mq_rq_cpu);
 
 void blk_mq_cancel_work_sync(struct request_queue *q)
 {
-	if (queue_is_mq(q)) {
-		struct blk_mq_hw_ctx *hctx;
-		unsigned long i;
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
 
-		cancel_delayed_work_sync(&q->requeue_work);
+	cancel_delayed_work_sync(&q->requeue_work);
 
-		queue_for_each_hw_ctx(q, hctx, i)
-			cancel_delayed_work_sync(&hctx->run_work);
-	}
+	queue_for_each_hw_ctx(q, hctx, i)
+		cancel_delayed_work_sync(&hctx->run_work);
 }
 
 static int __init blk_mq_init(void)
diff --git a/block/genhd.c b/block/genhd.c
index 17b33c62423d..493b93faee9c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -638,7 +638,9 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_sync_queue(q);
 	blk_flush_integrity();
-	blk_mq_cancel_work_sync(q);
+
+	if (queue_is_mq(q))
+		blk_mq_cancel_work_sync(q);
 
 	blk_mq_quiesce_queue(q);
 	if (q->elevator) {
-- 
2.31.1

