Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0AE612921
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 09:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJ3Icj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 04:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Ich (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 04:32:37 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F9081C3;
        Sun, 30 Oct 2022 01:32:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app4 (Coremail) with SMTP id cS_KCgAHmtyONl5jK6mfBw--.21945S2;
        Sun, 30 Oct 2022 16:32:29 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH] blk-mq: remove redundant call to blk_freeze_queue_start in blk_mq_destroy_queue
Date:   Sun, 30 Oct 2022 16:32:12 +0800
Message-Id: <20221030083212.1251255-1-nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgAHmtyONl5jK6mfBw--.21945S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF48AFW3Gw48trW5Aw13Arb_yoWDGwc_Wa
        y8A3WqvFs8GF15ur1YkF1rZFn2k348JFy7GFWDW3srJwn5Aan8Z3y7Cr1rCr45W3yUGasr
        Wr18Gas7Jr10qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
        xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
        64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgYTB1ZdtcKYKQACsf
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
    ...

So there is a redundant call to blk_freeze_queue_start().

Replace blk_freeze_queue() with blk_mq_freeze_queue_wait() to avoid the
redundant call.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4cecf281123f..8ca49530bdf3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4005,7 +4005,7 @@ void blk_mq_destroy_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 	blk_queue_start_drain(q);
-	blk_freeze_queue(q);
+	blk_mq_freeze_queue_wait(q);
 
 	blk_sync_queue(q);
 	blk_mq_cancel_work_sync(q);
-- 
2.31.1

