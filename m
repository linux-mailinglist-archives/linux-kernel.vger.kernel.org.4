Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA4F614E16
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiKAPPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKAPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:15:07 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 827B41BE9D;
        Tue,  1 Nov 2022 08:12:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app4 (Coremail) with SMTP id cS_KCgCH_k0qN2FjsHmtBw--.39315S4;
        Tue, 01 Nov 2022 23:12:02 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH 2/4] blk-mq: improve error handling in blk_mq_alloc_rq_map()
Date:   Tue,  1 Nov 2022 23:11:35 +0800
Message-Id: <992db53bdeaba35d37de3784fe6f80879c9bbb35.1667314759.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667314759.git.nickyc975@zju.edu.cn>
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgCH_k0qN2FjsHmtBw--.39315S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4kKr1rWr4rAr4fKr45Wrg_yoW8Gr13pF
        45Ga1DKa43JF17Xan7tay8XF1FkFs2gw4xG3Wft390vrn0kr4IyFn5ZFyjvr1FkrWkCrs3
        Cr4DKFyUWF4UJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgIAB1ZdtcLuXwAIsC
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use goto-style error handling like we do elsewhere in the kernel.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/blk-mq.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7ceceea91b3b..408a929be90e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3272,26 +3272,28 @@ static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
 				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
 	if (!tags)
-		return NULL;
+		goto err_out;
 
 	tags->rqs = kcalloc_node(nr_tags, sizeof(struct request *),
 				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
 				 node);
-	if (!tags->rqs) {
-		blk_mq_free_tags(tags);
-		return NULL;
-	}
+	if (!tags->rqs)
+		goto err_free_tags;
 
 	tags->static_rqs = kcalloc_node(nr_tags, sizeof(struct request *),
 					GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
 					node);
-	if (!tags->static_rqs) {
-		kfree(tags->rqs);
-		blk_mq_free_tags(tags);
-		return NULL;
-	}
+	if (!tags->static_rqs)
+		goto err_free_rqs;
 
 	return tags;
+
+err_free_rqs:
+	kfree(tags->rqs);
+err_free_tags:
+	blk_mq_free_tags(tags);
+err_out:
+	return NULL;
 }
 
 static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
-- 
2.31.1

