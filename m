Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7479E612709
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ3DHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJ3DH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:07:28 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FDB93609E;
        Sat, 29 Oct 2022 20:07:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app3 (Coremail) with SMTP id cC_KCgAXlrpJ6l1jv9B1CA--.27265S3;
        Sun, 30 Oct 2022 11:07:17 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, nickyc975@zju.edu.cn
Subject: [PATCH v2 1/3] blk-mq: remove redundant call to blk_freeze_queue_start in blk_mq_destroy_queue
Date:   Sun, 30 Oct 2022 11:06:46 +0800
Message-Id: <3a6d54a5adc8bd09aab28abfbe5f5b02bb863a8d.1667098953.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667098953.git.nickyc975@zju.edu.cn>
References: <cover.1667098953.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgAXlrpJ6l1jv9B1CA--.27265S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JF48AFW3Gw48trW5Aw13Arb_yoWkGrb_Wa
        y8AF1qyFZ8GF15ur1jkF1rZF1vk3y8JFy7GFWDW3srJwn5Aan8A3y7Cr1rCr4UW3yjk3sr
        Wr1UG3s7Jr40qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
        xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
        64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAggTB1ZdtcKM4AADsN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calling relationship in blk_mq_destroy_queue() is as follows:

blk_mq_destroy_queue()
    ...
    -> blk_queue_start_drain()
        -> blk_freeze_queue_start()  <- called
        ...
    -> blk_freeze_queue()
        -> blk_freeze_queue_start()  <- called again
        -> blk_mq_freeze_queue_wait()

So there is a redundant call to blk_freeze_queue_start(). Replace
blk_freeze_queue() with blk_mq_freeze_queue_wait() to avoid the redundant
call.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4cecf281123f..14c4165511b9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4005,7 +4005,12 @@ void blk_mq_destroy_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 	blk_queue_start_drain(q);
-	blk_freeze_queue(q);
+
+	/*
+	 * blk_freeze_queue_start has been called in blk_queue_start_drain, we just
+	 * need to wait.
+	 */
+	blk_mq_freeze_queue_wait(q);
 
 	blk_sync_queue(q);
 	blk_mq_cancel_work_sync(q);
-- 
2.31.1

