Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DB62F43F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbiKRMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbiKRMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:10:15 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA7458FF96;
        Fri, 18 Nov 2022 04:10:13 -0800 (PST)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app4 (Coremail) with SMTP id cS_KCgDX2MwUdndjSIwaCA--.39489S3;
        Fri, 18 Nov 2022 20:10:09 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [RFC PATCH 1/2] elevator: add a helper for applying scheduler to request_queue
Date:   Fri, 18 Nov 2022 20:09:53 +0800
Message-Id: <5abfd81ae73b4e86ff260475b28a218e78eaad4a.1668772991.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1668772991.git.nickyc975@zju.edu.cn>
References: <cover.1668772991.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgDX2MwUdndjSIwaCA--.39489S3
X-Coremail-Antispam: 1UD129KBjvJXoW7GF47Cw1rAr4fJw48CFW8Xrb_yoW8JF1DpF
        Z5GwsIkr1Fqr4xXa13Zw17X345J34v9ry3ZrWxA34IkFnFyrW3Ka18CF12qF45Grs7AFsa
        vF48ta9rCFyj9rJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI
        7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgAPB1ZdtcbINgAGsK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for supporting fallback in elevator_switch.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/elevator.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index a5bdc3b1e7e5..517857a9a68f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -649,6 +649,21 @@ void elevator_init_mq(struct request_queue *q)
 	elevator_put(e);
 }
 
+static int __elevator_apply(struct request_queue *q, struct elevator_type *e)
+{
+	int ret;
+
+	ret = blk_mq_init_sched(q, e);
+	if (ret)
+		return ret;
+
+	ret = elv_register_queue(q, true);
+	if (ret)
+		elevator_exit(q);
+
+	return ret;
+}
+
 /*
  * switch to new_e io scheduler. be careful not to introduce deadlocks -
  * we don't free the old io scheduler, before we have allocated what we
@@ -669,15 +684,10 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 		elevator_exit(q);
 	}
 
-	ret = blk_mq_init_sched(q, new_e);
+	ret = __elevator_apply(q, new_e);
 	if (ret)
 		goto out_unfreeze;
 
-	ret = elv_register_queue(q, true);
-	if (ret) {
-		elevator_exit(q);
-		goto out_unfreeze;
-	}
 	blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
 
 out_unfreeze:
-- 
2.31.1

