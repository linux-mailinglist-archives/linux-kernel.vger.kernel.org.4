Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CB75E60ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIVLZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiIVLZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:25:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889E3ABD6D;
        Thu, 22 Sep 2022 04:25:16 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYCYX3FQ4zpVCp;
        Thu, 22 Sep 2022 19:22:24 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 19:25:14 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 19:25:13 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yukuai1@huaweicloud.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 4/5] blk-wbt: don't enable throttling if default elevator is bfq
Date:   Thu, 22 Sep 2022 19:35:57 +0800
Message-ID: <20220922113558.1085314-5-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922113558.1085314-1-yukuai3@huawei.com>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 block/bfq-iosched.c | 2 ++
 block/blk-wbt.c     | 8 +++++++-
 block/elevator.h    | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fec52968fe07..f67ed271baa9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7037,6 +7037,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	blkcg_deactivate_policy(bfqd->queue, &blkcg_policy_bfq);
+	clear_bit(ELEVATOR_FLAG_DISABLE_WBT, &e->flags);
 	wbt_enable_default(bfqd->queue);
 #else
 	spin_lock_irq(&bfqd->lock);
@@ -7191,6 +7192,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
+	set_bit(ELEVATOR_FLAG_DISABLE_WBT, &eq->flags);
 	wbt_disable_default(q);
 #endif
 	blk_stat_enable_accounting(q);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 68851c2c02d2..279f8dc1e952 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -27,6 +27,7 @@
 
 #include "blk-wbt.h"
 #include "blk-rq-qos.h"
+#include "elevator.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
@@ -645,9 +646,14 @@ void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
  */
 void wbt_enable_default(struct request_queue *q)
 {
-	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_qos *rqos;
+
+	if (q->elevator &&
+	    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
+		return;
 
 	/* Throttling already enabled? */
+	rqos = wbt_rq_qos(q);
 	if (rqos) {
 		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
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

