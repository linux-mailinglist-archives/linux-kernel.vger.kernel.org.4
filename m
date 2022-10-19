Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E229B604A35
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiJSO7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiJSO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:58:42 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C318237D3;
        Wed, 19 Oct 2022 07:53:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mspw11YZzzKHkv;
        Wed, 19 Oct 2022 19:50:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCX0DAq5U9jgItmAA--.58124S10;
        Wed, 19 Oct 2022 19:53:18 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, ebiggers@google.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v5 6/6] blk-wbt: don't enable throttling if default elevator is bfq
Date:   Wed, 19 Oct 2022 20:15:18 +0800
Message-Id: <20221019121518.3865235-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019121518.3865235-1-yukuai1@huaweicloud.com>
References: <20221019121518.3865235-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX0DAq5U9jgItmAA--.58124S10
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1kCw15ZFWDAryDWFy5XFb_yoW5Zr15p3
        Z5GFySkrZ2gr4xuF97Jr13Xr17Cw4F9ry7Cr48C3yF93W3CrZaqa1vkFyrZF40qrs7JF43
        Xw18KFWDZFy0gw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Commit b5dc5d4d1f4f ("block,bfq: Disable writeback throttling") tries to
disable wbt for bfq, it's done by calling wbt_disable_default() in
bfq_init_queue(). However, wbt is still enabled if default elevator is
bfq:

device_add_disk
 elevator_init_mq
  bfq_init_queue
   wbt_disable_default -> done nothing

 blk_register_queue
  wbt_enable_default -> wbt is enabled

Fix the problem by adding a new flag ELEVATOR_FLAG_DISBALE_WBT, bfq
will set the flag in bfq_init_queue, and following wbt_enable_default()
won't enable wbt while the flag is set.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c |  2 ++
 block/blk-wbt.c     | 11 ++++++++---
 block/elevator.h    |  3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 24649c34cd35..42aa5fc7f17b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6994,6 +6994,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 #endif
 
 	blk_stat_disable_accounting(bfqd->queue);
+	clear_bit(ELEVATOR_FLAG_DISABLE_WBT, &e->flags);
 	wbt_enable_default(bfqd->queue);
 
 	kfree(bfqd);
@@ -7139,6 +7140,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
+	set_bit(ELEVATOR_FLAG_DISABLE_WBT, &eq->flags);
 	wbt_disable_default(q);
 	blk_stat_enable_accounting(q);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 07ed0b0aee1f..68a774d7a7c9 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -27,6 +27,7 @@
 
 #include "blk-wbt.h"
 #include "blk-rq-qos.h"
+#include "elevator.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
@@ -651,11 +652,15 @@ void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
  */
 void wbt_enable_default(struct request_queue *q)
 {
-	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_qos *rqos;
+	bool disable_flag = q->elevator &&
+		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags);
 
 	/* Throttling already enabled? */
+	rqos = wbt_rq_qos(q);
 	if (rqos) {
-		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
+		if (!disable_flag &&
+		    RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
 		return;
 	}
@@ -664,7 +669,7 @@ void wbt_enable_default(struct request_queue *q)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q))
+	if (queue_is_mq(q) && !disable_flag)
 		wbt_init(q);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
diff --git a/block/elevator.h b/block/elevator.h
index ed574bf3e629..75382471222d 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -104,7 +104,8 @@ struct elevator_queue
 	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
 };
 
-#define ELEVATOR_FLAG_REGISTERED 0
+#define ELEVATOR_FLAG_REGISTERED	0
+#define ELEVATOR_FLAG_DISABLE_WBT	1
 
 /*
  * block elevator interface
-- 
2.31.1

