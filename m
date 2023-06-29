Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5237D7424AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjF2LHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjF2LHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:07:16 -0400
Received: from out-55.mta1.migadu.com (out-55.mta1.migadu.com [IPv6:2001:41d0:203:375::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B16E72
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:07:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688036833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNin81+NgdWvZKUgysygT1wpEuRFau3v3obyeOkX5fM=;
        b=wwqEmJdrPmGhPaPCNNeah4+ETGQTleAhQTC7xostmyZuZdJychdvBYIDsi+H4x6MrfHW8p
        c6P2ePqkoYs95JZypBggJd7pyt64ZMEfrqpnao0izFegeXWFKgAL8UwFUZRoOWGW+V21oL
        hto1QBQcoDWwYWAKXB5SN1k+aLYpCkk=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 1/4] blk-mq: use percpu csd to remote complete instead of per-rq csd
Date:   Thu, 29 Jun 2023 19:03:56 +0800
Message-Id: <20230629110359.1111832-2-chengming.zhou@linux.dev>
In-Reply-To: <20230629110359.1111832-1-chengming.zhou@linux.dev>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

This way is cleaner, and looks correct, given block softirq is guaranteed to be
scheduled to consume the list if one new request is added to this percpu list,
either smp_call_function_single_async() returns -EBUSY or 0.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - Change to use call_single_data_t, which avoid to use 2 cache lines
   for 1 csd, as suggested by Ming Lei.
 - Improve the commit log, the explanation is copied from Ming Lei.
---
 block/blk-mq.c         | 12 ++++++++----
 include/linux/blk-mq.h |  5 +----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index decb6ab2d508..e52200edd2b1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,6 +43,7 @@
 #include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
+static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
 
 static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
 static void blk_mq_request_bypass_insert(struct request *rq,
@@ -1156,13 +1157,13 @@ static void blk_mq_complete_send_ipi(struct request *rq)
 {
 	struct llist_head *list;
 	unsigned int cpu;
+	call_single_data_t *csd;
 
 	cpu = rq->mq_ctx->cpu;
 	list = &per_cpu(blk_cpu_done, cpu);
-	if (llist_add(&rq->ipi_list, list)) {
-		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(cpu, &rq->csd);
-	}
+	csd = &per_cpu(blk_cpu_csd, cpu);
+	if (llist_add(&rq->ipi_list, list))
+		smp_call_function_single_async(cpu, csd);
 }
 
 static void blk_mq_raise_softirq(struct request *rq)
@@ -4796,6 +4797,9 @@ static int __init blk_mq_init(void)
 
 	for_each_possible_cpu(i)
 		init_llist_head(&per_cpu(blk_cpu_done, i));
+	for_each_possible_cpu(i)
+		INIT_CSD(&per_cpu(blk_cpu_csd, i),
+			 __blk_mq_complete_request_remote, NULL);
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
 
 	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f401067ac03a..070551197c0e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -182,10 +182,7 @@ struct request {
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
2.39.2

