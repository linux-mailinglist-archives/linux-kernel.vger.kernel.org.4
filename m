Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B755461278D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 06:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJ3F17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 01:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3F1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 01:27:50 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43BA03B991;
        Sat, 29 Oct 2022 22:27:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app3 (Coremail) with SMTP id cC_KCgBn3qlCC15jnGV2CA--.28011S4;
        Sun, 30 Oct 2022 13:27:38 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        nickyc975@zju.edu.cn
Subject: [RESEND PATCH v2 2/3] blk-mq: remove blk_freeze_queue
Date:   Sun, 30 Oct 2022 13:26:45 +0800
Message-Id: <e21821b72fe9df4f187c1321dd38587138cd1aaa.1667107410.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667107410.git.nickyc975@zju.edu.cn>
References: <cover.1667107410.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgBn3qlCC15jnGV2CA--.28011S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3AF4rXr18ZrWruFyrtFb_yoW8Zr1xpF
        ZxJF47Cw1Iqr4UXrW8Jw47Xr9Iga18Kry7C3ySy3yYvrnIkFn2vF18A3W8uF40yrZ5JFsr
        ZrWqgrZxAr18CrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgsTB1ZdtcKSqwAAsY
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is calling blk_freeze_queue except its alias, so remove it.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/blk-mq.c | 18 +-----------------
 block/blk.h    |  1 -
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 14c4165511b9..e0654a2e80b9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -194,27 +194,11 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
  * Guarantee no request is in use, so we can change any data structure of
  * the queue afterward.
  */
-void blk_freeze_queue(struct request_queue *q)
+void blk_mq_freeze_queue(struct request_queue *q)
 {
-	/*
-	 * In the !blk_mq case we are only calling this to kill the
-	 * q_usage_counter, otherwise this increases the freeze depth
-	 * and waits for it to return to zero.  For this reason there is
-	 * no blk_unfreeze_queue(), and blk_freeze_queue() is not
-	 * exported to drivers as the only user for unfreeze is blk_mq.
-	 */
 	blk_freeze_queue_start(q);
 	blk_mq_freeze_queue_wait(q);
 }
-
-void blk_mq_freeze_queue(struct request_queue *q)
-{
-	/*
-	 * ...just an alias to keep freeze and unfreeze actions balanced
-	 * in the blk_mq_* namespace
-	 */
-	blk_freeze_queue(q);
-}
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
diff --git a/block/blk.h b/block/blk.h
index 7f9e089ab1f7..e9addea2838a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -37,7 +37,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 					      gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
-void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
-- 
2.31.1

