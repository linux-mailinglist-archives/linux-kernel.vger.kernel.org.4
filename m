Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7624762F448
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbiKRMK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbiKRMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:10:15 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E6DE8FF8B;
        Fri, 18 Nov 2022 04:10:13 -0800 (PST)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app4 (Coremail) with SMTP id cS_KCgDX2MwUdndjSIwaCA--.39489S4;
        Fri, 18 Nov 2022 20:10:11 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [RFC PATCH 2/2] elevator: restore the old io scheduler if failed to switch to the new one
Date:   Fri, 18 Nov 2022 20:09:54 +0800
Message-Id: <29281ffcdd756bdbdfcee8769cd8b2eb867b74e2.1668772991.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1668772991.git.nickyc975@zju.edu.cn>
References: <cover.1668772991.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgDX2MwUdndjSIwaCA--.39489S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry7JFWDAryUGr45Zw4Dtwb_yoW8AF1xpF
        4rGwsxKrsrJr47X3W3Cw17Z345tF9agrW3XrWxC34FkFn3tr47Ja1UGF1IvF4DJrW8JFsI
        vr48tFWDGa4UurJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI
        7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAg0SB1ZdtcfEpQAAsC
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we failed to switch to the new io scheduler, we should try to restore
the old one instead of just switching to none.

This also makes elevator_switch match its document.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/elevator.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 517857a9a68f..b7bd0b8468bd 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -672,6 +672,7 @@ static int __elevator_apply(struct request_queue *q, struct elevator_type *e)
  */
 int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
+	struct elevator_type *old_e = NULL;
 	int ret;
 
 	lockdep_assert_held(&q->sysfs_lock);
@@ -680,17 +681,37 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
+		old_e = q->elevator->type;
+		/*
+		 * Keep a reference so we can fallback on failure.
+		 */
+		__elevator_get(old_e);
 		elv_unregister_queue(q);
 		elevator_exit(q);
 	}
 
 	ret = __elevator_apply(q, new_e);
-	if (ret)
-		goto out_unfreeze;
+	if (likely(!ret)) {
+		blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
+	} else if (old_e) {
+		int err;
+
+		err = __elevator_apply(q, old_e);
+		if (unlikely(err)) {
+			blk_add_trace_msg(q,
+				"elv switch failed: %s (%d), fallback failed: %s (%d)",
+				new_e->elevator_name, ret, old_e->elevator_name, err
+			);
+		}
+	}
 
-	blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
+	if (old_e) {
+		/*
+		 * Done, release the reference we kept.
+		 */
+		elevator_put(old_e);
+	}
 
-out_unfreeze:
 	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 	return ret;
-- 
2.31.1

