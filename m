Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7766E73D70E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFZFGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFZFGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:06:08 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9892912D
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 22:06:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687755963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQ1f0H8lujgnS2QY9KNbH8M2Bukb16RSvTZHPii0Y5I=;
        b=lvw7E9knFolsCy1ySMPIvpFMBrc7UR0e6MThfgqnPdjxDNnCU7/EjXABj2lUVUuWS8Coh3
        RjIsc8pcy0woXf34Kpr/XsRT/oSF6zr1BCff+csDOdEI248UxN68j6UlvH0Nfe1wjVPHS+
        JrfpuqDXNxNpmkEpLr/jNAqFPuLCBnE=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 3/3] blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq
Date:   Mon, 26 Jun 2023 13:04:05 +0800
Message-Id: <20230626050405.781253-4-chengming.zhou@linux.dev>
In-Reply-To: <20230626050405.781253-1-chengming.zhou@linux.dev>
References: <20230626050405.781253-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The iocost rely on rq start_time_ns and alloc_time_ns to tell saturation
state of the block device. Most of the time request is allocated after
rq_qos_throttle() and its alloc_time_ns or start_time_ns won't be affected.

But for plug batched allocation introduced by the commit 47c122e35d7e
("block: pre-allocate requests if plug is started and is a batch"), we can
rq_qos_throttle() after the allocation of the request. This is what the
blk_mq_get_cached_request() does.

In this case, the cached request alloc_time_ns or start_time_ns is much
ahead if blocked in any qos ->throttle().

This patch fix it by setting alloc_time_ns and start_time_ns to now
when the pre-allocated rq is actually used.

Note we don't skip setting alloc_time_ns and start_time_ns for all
pre-allocated rq, since the first returned rq still need to be set.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8b981d0a868e..6a3f1b8aaad8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -337,6 +337,24 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 }
 EXPORT_SYMBOL(blk_rq_init);
 
+/* Set rq alloc and start time when pre-allocated rq is actually used */
+static inline void blk_mq_rq_time_init(struct request_queue *q, struct request *rq)
+{
+	if (blk_mq_need_time_stamp(rq->rq_flags)) {
+		u64 now = ktime_get_ns();
+
+#ifdef CONFIG_BLK_RQ_ALLOC_TIME
+		/*
+		 * alloc time is only used by iocost for now,
+		 * only possible when blk_mq_need_time_stamp().
+		 */
+		if (blk_queue_rq_alloc_time(q))
+			rq->alloc_time_ns = now;
+#endif
+		rq->start_time_ns = now;
+	}
+}
+
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		struct blk_mq_tags *tags, unsigned int tag,
 		u64 alloc_time_ns, u64 start_time_ns)
@@ -575,6 +593,7 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
 			return NULL;
 
 		plug->cached_rq = rq_list_next(rq);
+		blk_mq_rq_time_init(q, rq);
 	}
 
 	rq->cmd_flags = opf;
@@ -2896,6 +2915,7 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	plug->cached_rq = rq_list_next(rq);
 	rq_qos_throttle(q, *bio);
 
+	blk_mq_rq_time_init(q, rq);
 	rq->cmd_flags = (*bio)->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
-- 
2.39.2

