Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8730167102C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjARBjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjARBjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:39:03 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847AF51C65;
        Tue, 17 Jan 2023 17:39:00 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NxT1q24dFz4f3p0V;
        Wed, 18 Jan 2023 09:38:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOqxTcdjBACUBw--.30342S2;
        Wed, 18 Jan 2023 09:38:57 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v4 01/14] blk-mq: avoid sleep in blk_mq_alloc_request_hctx
Date:   Wed, 18 Jan 2023 17:37:13 +0800
Message-Id: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOqxTcdjBACUBw--.30342S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1rZw13Kw47GF13JFW8JFb_yoW8ZrWfpr
        W7ta1Utrn0934xCFyIy39rW3y7CwsrWr9rGF1aq34fZ3yUKr10kF4UZr48WFyxAFs7Ar45
        J34rta4UXr9Fk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E
        3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU01mh7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c49b4151da1..9c6a6ce9eaf2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -658,7 +658,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
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

