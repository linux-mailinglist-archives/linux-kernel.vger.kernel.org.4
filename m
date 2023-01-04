Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CBB65CD09
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjADGZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjADGYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:24:23 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF9217E09;
        Tue,  3 Jan 2023 22:24:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nn01V1W12z4f3mSJ;
        Wed,  4 Jan 2023 14:24:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGOG7Vju3lKBA--.23788S3;
        Wed, 04 Jan 2023 14:24:16 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v2 01/13] blk-mq: avoid sleep in blk_mq_alloc_request_hctx
Date:   Wed,  4 Jan 2023 22:22:47 +0800
Message-Id: <20230104142259.2673013-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
References: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGOG7Vju3lKBA--.23788S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1rZw13Kw47GF13JFW8JFb_yoW8Cw4fpF
        W7ta1jyrn0934xCFyIy39xW3y7Cws7ur9rGF1aq34Fv3y7Kw10kF48Zr48WFyxAFs7Ar45
        J34rt3WUXr9F93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsWrWDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1f5bd336b9150 ("blk-mq: add blk_mq_alloc_request_hctx") add
blk_mq_alloc_request_hctx to send commands to a specific queue. If
BLK_MQ_REQ_NOWAIT is not set in tag allocation, we may change to different
hctx after sleep and get tag from unexpected hctx. So BLK_MQ_REQ_NOWAIT
must be set in flags for blk_mq_alloc_request_hctx.
After commit 600c3b0cea784 ("blk-mq: open code __blk_mq_alloc_request in
blk_mq_alloc_request_hctx"), blk_mq_alloc_request_hctx return -EINVAL
if both BLK_MQ_REQ_NOWAIT and BLK_MQ_REQ_RESERVED are not set instead of
if BLK_MQ_REQ_NOWAIT is not set. So if BLK_MQ_REQ_NOWAIT is not set and
BLK_MQ_REQ_RESERVED is set, blk_mq_alloc_request_hctx could alloc tag
from unexpected hctx. I guess what we need here is that return -EINVAL
if either BLK_MQ_REQ_NOWAIT or BLK_MQ_REQ_RESERVED is not set.

Currently both BLK_MQ_REQ_NOWAIT and BLK_MQ_REQ_RESERVED will be set if
specific hctx is needed in nvme_auth_submit, nvmf_connect_io_queue
and nvmf_connect_admin_queue. Fix the potential BLK_MQ_REQ_NOWAIT missed
case in future.

Fixes: 600c3b0cea78 ("blk-mq: open code __blk_mq_alloc_request in blk_mq_alloc_request_hctx")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e6b3ccd4989..42bb59fa275c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -657,7 +657,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * allocator for this for the rare use case of a command tied to
 	 * a specific queue.
 	 */
-	if (WARN_ON_ONCE(!(flags & (BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED))))
+	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)) ||
+	    WARN_ON_ONCE(!(flags & BLK_MQ_REQ_RESERVED)))
 		return ERR_PTR(-EINVAL);
 
 	if (hctx_idx >= q->nr_hw_queues)
-- 
2.30.0

