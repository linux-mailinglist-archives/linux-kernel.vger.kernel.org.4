Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DBF6AA8AC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCDIRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCDIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:17:44 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419CD4B804;
        Sat,  4 Mar 2023 00:17:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PTHl52Xgtz4f3jMQ;
        Sat,  4 Mar 2023 16:17:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyGg_gJkXTNDEQ--.38480S6;
        Sat, 04 Mar 2023 16:17:39 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 2/3] blk-wbt: freeze queue in wbt_enable/disable_default
Date:   Sat,  4 Mar 2023 16:40:52 +0800
Message-Id: <20230304084053.2822411-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230304084053.2822411-1-yukuai1@huaweicloud.com>
References: <20230304084053.2822411-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyGg_gJkXTNDEQ--.38480S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyrur17Wr45Xw1fAry7Jrb_yoW8urW7pF
        4rG3yfKwnFqr4I93WxXw47XF13CFs5Wr1xCrWxC34S93WYkw40qa10ka4ruF40qFWkAF43
        Zw45tFWUCFW8ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjYiiDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

All the caller of wbt_enable/disable_default() ensures that queue is
freezed and quiesced, and it's not a good idea to enable or disable wbt
while io is inflight because this will make implementation complex and
easy to leak wbt inflight counter, which will cause io hang.

This patch just freeze queue in wbt explicitly, there are no functional
changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-wbt.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index b5edf44499ab..2d5a2f4ee8bc 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -729,24 +729,32 @@ void wbt_enable_default(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct rq_qos *rqos;
-	bool disable_flag = q->elevator &&
-		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags);
+	bool disable_flag;
 
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
+	disable_flag = q->elevator && test_bit(ELEVATOR_FLAG_DISABLE_WBT,
+					       &q->elevator->flags);
 	/* Throttling already enabled? */
 	rqos = wbt_rq_qos(q);
 	if (rqos) {
 		if (!disable_flag &&
 		    RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
-		return;
+		goto out;
 	}
 
 	/* Queue not registered? Maybe shutting down... */
 	if (!blk_queue_registered(q))
-		return;
+		goto out;
 
 	if (queue_is_mq(q) && !disable_flag)
 		wbt_init(disk);
+
+out:
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
@@ -801,8 +809,14 @@ void wbt_disable_default(struct gendisk *disk)
 		return;
 	rwb = RQWB(rqos);
 	if (rwb->enable_state == WBT_STATE_ON_DEFAULT) {
+		blk_mq_freeze_queue(disk->queue);
+		blk_mq_quiesce_queue(disk->queue);
+
 		blk_stat_deactivate(rwb->cb);
 		rwb->enable_state = WBT_STATE_OFF_DEFAULT;
+
+		blk_mq_unquiesce_queue(disk->queue);
+		blk_mq_unfreeze_queue(disk->queue);
 	}
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
-- 
2.31.1

