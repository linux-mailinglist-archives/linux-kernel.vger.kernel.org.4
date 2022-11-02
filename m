Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66061593C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKBDGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiKBDGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:06:23 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC73E23EB1;
        Tue,  1 Nov 2022 20:06:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app2 (Coremail) with SMTP id by_KCgA3PSGf3mFjz_9cBw--.7456S3;
        Wed, 02 Nov 2022 11:06:16 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH v3 1/2] blk-mq: improve error handling in blk_mq_alloc_rq_map()
Date:   Wed,  2 Nov 2022 11:06:04 +0800
Message-Id: <bbbc2d9b17b137798c7fb92042141ca4cbbc58cc.1667358114.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667358114.git.nickyc975@zju.edu.cn>
References: <cover.1667358114.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgA3PSGf3mFjz_9cBw--.7456S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF43Gw13Ar1UCw4UuryxGrg_yoWkZwc_Cr
        y0kw1vvFyUAr1Fkw4q9r15Ar97CanakF40vFWDK3srJ3s7GanrAa9xZrnxJrZ7Ww4xWFWx
        Gw1kZr1Fkr15tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2z280
        aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwV
        AKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
        6r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvg4fUUUUU=
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgoCB1ZdtcNVXAAMs1
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
 block/blk-mq.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 623e8a506539..453ad445a6bd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3274,21 +3274,22 @@ static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
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
+	return NULL;
 }
 
 static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
-- 
2.31.1

