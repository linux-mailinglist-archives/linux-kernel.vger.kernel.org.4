Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD354615882
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKBCxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiKBCw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:52:57 -0400
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 87F26220DE;
        Tue,  1 Nov 2022 19:52:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [61.164.42.140])
        by mail-app2 (Coremail) with SMTP id by_KCgB3ffVv22FjEPFcBw--.14956S3;
        Wed, 02 Nov 2022 10:52:42 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH v2 1/2] blk-mq: improve error handling in blk_mq_alloc_rq_map()
Date:   Wed,  2 Nov 2022 10:52:29 +0800
Message-Id: <bbbc2d9b17b137798c7fb92042141ca4cbbc58cc.1667356813.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667356813.git.nickyc975@zju.edu.cn>
References: <cover.1667356813.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgB3ffVv22FjEPFcBw--.14956S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF43Gw13Ar1UCw4UuryxGrg_yoWkZwc_Cr
        y0kw1vvFyUAr1Fkw4q9r15Ar97CanakF40vFWDK3srJ3s7GanrAa9xZrnxJrZ7Ww4xWFWx
        Gw1kZr1Fkr15tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbhAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkE
        FVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
        8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
        s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
        8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5q2MUUUUU
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgoCB1ZdtcNVXAAFs8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

