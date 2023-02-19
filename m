Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554AA69BE2D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBSClc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBSCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:41:28 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F4411EA1;
        Sat, 18 Feb 2023 18:41:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PK8v456gdz4f3lbQ;
        Sun, 19 Feb 2023 10:41:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7utQjPFjPmleDw--.7604S4;
        Sun, 19 Feb 2023 10:41:22 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 02/17] block, bfq: try preemption if bfqq has higher weight and the same priority class
Date:   Sun, 19 Feb 2023 18:42:54 +0800
Message-Id: <20230219104309.1511562-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
References: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7utQjPFjPmleDw--.7604S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4xWF43Cw4fZFW7Wr13CFg_yoW8GrykpF
        9rG3yUWr17CF4ru3WUJFnavrWrWas3GrnrJrs3ua18CrWUZrnruF9Ik3s3ZF4Igr1IqF4a
        qr10qr9rX3W5Xw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
        RNVbyUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will compare priority class and weight of current bfqq with
in_service_queue to check if bfqq could preempt in_service_queue.
Currently we will try to preempt in_service_queue if bfqq has higher
weight than in_service_queue even with lower priority class. Actually,
we will only serve bfqq with higher priority class (see
bfq_lookup_next_entity), so bfqq with higher weight and lower priority
class will not be a candidate to preempt in_service_queue.
Compare weight of bfqqs with the same priority in
bfq_bfqq_higher_class_or_weight to make preemption check more reasonable.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3f5c740664ce..4868538c9745 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1768,6 +1768,10 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
 	if (bfqq->ioprio_class < in_serv_bfqq->ioprio_class)
 		return true;
 
+	/* only try weight comparison with same priority class */
+	if (bfqq->ioprio_class != in_serv_bfqq->ioprio_class)
+		return false;
+
 	if (in_serv_bfqq->entity.parent == bfqq->entity.parent) {
 		bfqq_weight = bfqq->entity.weight;
 		in_serv_weight = in_serv_bfqq->entity.weight;
-- 
2.30.0

