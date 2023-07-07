Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474D874ADE4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjGGJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjGGJjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:39:10 -0400
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [IPv6:2001:41d0:1004:224b::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAE42106
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:39:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688722747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QGerpK1V1ctRjZC2+PWM/5ULJ+kFtEXJRRHXssQgmz0=;
        b=tp5iOy0v8KgRa4hlqo8i924ZQp+iuFTBITRyHheniNvm5f7NmrOMXW4w4tbs8LhaNFMRTr
        u3lRyyu1yPeaQba0mTC5uet5FJCdOQ9dHpoIkFx8chDvgjoQzwIsBEavz0pb5IPAvA0Lrr
        dV8vx/Z4HH10KBrOU8IKjaxyHix3Ppk=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v3 2/4] blk-mq: use percpu csd to remote complete instead of per-rq csd
Date:   Fri,  7 Jul 2023 17:37:20 +0800
Message-ID: <20230707093722.1338589-3-chengming.zhou@linux.dev>
In-Reply-To: <20230707093722.1338589-1-chengming.zhou@linux.dev>
References: <20230707093722.1338589-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

If request need to be completed remotely, we insert it into percpu llist,
and smp_call_function_single_async() if llist is empty previously.

We don't need to use per-rq csd, percpu csd is enough. And the size of
struct request is decreased by 24 bytes.

This way is cleaner, and looks correct, given block softirq is guaranteed
to be scheduled to consume the list if one new request is added to this
percpu list, either smp_call_function_single_async() returns -EBUSY or 0.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
v3:
 - Remove the list and csd variables as they are only used once, as
   suggested by Christoph Hellwig.

v2:
 - Change to use call_single_data_t, which avoid to use 2 cache lines
   for 1 csd, as suggested by Ming Lei.
 - Improve the commit log, the explanation is copied from Ming Lei.
---
 block/blk-mq.c         | 12 ++++++------
 include/linux/blk-mq.h |  5 +----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index decb6ab2d508..7d013588077a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,6 +43,7 @@
 #include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
+static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
 
 static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
 static void blk_mq_request_bypass_insert(struct request *rq,
@@ -1154,15 +1155,11 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 
 static void blk_mq_complete_send_ipi(struct request *rq)
 {
-	struct llist_head *list;
 	unsigned int cpu;
 
 	cpu = rq->mq_ctx->cpu;
-	list = &per_cpu(blk_cpu_done, cpu);
-	if (llist_add(&rq->ipi_list, list)) {
-		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(cpu, &rq->csd);
-	}
+	if (llist_add(&rq->ipi_list, &per_cpu(blk_cpu_done, cpu)))
+		smp_call_function_single_async(cpu, &per_cpu(blk_cpu_csd, cpu));
 }
 
 static void blk_mq_raise_softirq(struct request *rq)
@@ -4796,6 +4793,9 @@ static int __init blk_mq_init(void)
 
 	for_each_possible_cpu(i)
 		init_llist_head(&per_cpu(blk_cpu_done, i));
+	for_each_possible_cpu(i)
+		INIT_CSD(&per_cpu(blk_cpu_csd, i),
+			 __blk_mq_complete_request_remote, NULL);
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
 
 	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0a1c404e6c7a..34d400171b3e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -180,10 +180,7 @@ struct request {
 		rq_end_io_fn		*saved_end_io;
 	} flush;
 
-	union {
-		struct __call_single_data csd;
-		u64 fifo_time;
-	};
+	u64 fifo_time;
 
 	/*
 	 * completion callback.
-- 
2.41.0

