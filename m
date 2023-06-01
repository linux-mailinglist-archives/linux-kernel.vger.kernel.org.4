Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103DC7192C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjFAFyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjFAFyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:54:05 -0400
X-Greylist: delayed 590 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 22:52:38 PDT
Received: from out-6.mta0.migadu.com (out-6.mta0.migadu.com [91.218.175.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAFE198E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:52:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685598097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wMraD2clGsbsww7FgpOj2nLzIuUm/oP4AQqhudlO+CU=;
        b=FkyWsbBZ2oZLCAcBImfx6W1IHJc3i/7Zx7aiKeb4ibNEDe4ItNvXQ055eYXhHUKeeeNI80
        QsTlFsysUgtFRAULTHNVAFK4WDrfCURYAnLgKGeK5GJUpW1ybrWuwAm/fo5xXor0NoIPCo
        pKfYZcuMo1xdrXJyz/zYeU/YONzok2g=
From:   chengming.zhou@linux.dev
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] blk-mq: fix incorrect rq start_time_ns and alloc_time_ns after throttled
Date:   Thu,  1 Jun 2023 13:39:19 +0800
Message-Id: <20230601053919.3639954-1-chengming.zhou@linux.dev>
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

iocost rely on rq start_time_ns and alloc_time_ns to tell the saturation
state of the block device.

If any qos ->throttle() end up blocking, the cached rq start_time_ns and
alloc_time_ns will include its throtted time, which can confuse its user.

This patch add nr_flush counter in blk_plug, so we can tell if the task
has throttled in any qos ->throttle(), in which case we need to correct
the rq start_time_ns and alloc_time_ns.

Another solution may be make rq_qos_throttle() return bool to indicate
if it has throttled in any qos ->throttle(). But this need more changes.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-core.c       |  3 +++
 block/blk-mq.c         | 18 ++++++++++++++++++
 include/linux/blkdev.h |  8 +++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 00c74330fa92..5109f7f5606c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1053,6 +1053,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	plug->cached_rq = NULL;
 	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count = 0;
+	plug->nr_flush = 0;
 	plug->multiple_queues = false;
 	plug->has_elevator = false;
 	plug->nowait = false;
@@ -1150,6 +1151,8 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 	 */
 	if (unlikely(!rq_list_empty(plug->cached_rq)))
 		blk_mq_free_plug_rqs(plug);
+
+	plug->nr_flush++;
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2f..8731f2815790 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2871,6 +2871,7 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 {
 	struct request *rq;
 	enum hctx_type type, hctx_type;
+	unsigned short nr_flush;
 
 	if (!plug)
 		return NULL;
@@ -2897,8 +2898,25 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	 * before we throttle.
 	 */
 	plug->cached_rq = rq_list_next(rq);
+	nr_flush = plug->nr_flush;
 	rq_qos_throttle(q, *bio);
 
+	/*
+	 * If any qos ->throttle() end up blocking, we will have flushed the
+	 * plug and we need to correct the rq start_time_ns and alloc_time_ns.
+	 */
+	if (nr_flush != plug->nr_flush) {
+		if (blk_mq_need_time_stamp(rq)) {
+			u64 now = ktime_get_ns();
+
+#ifdef CONFIG_BLK_RQ_ALLOC_TIME
+			if (rq->alloc_time_ns)
+				rq->alloc_time_ns += now - rq->start_time_ns;
+#endif
+			rq->start_time_ns = now;
+		}
+	}
+
 	rq->cmd_flags = (*bio)->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e3242e67a8e3..cf66871a1844 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -978,9 +978,11 @@ struct blk_plug {
 
 	unsigned short rq_count;
 
-	bool multiple_queues;
-	bool has_elevator;
-	bool nowait;
+	unsigned short nr_flush;
+
+	bool multiple_queues:1;
+	bool has_elevator:1;
+	bool nowait:1;
 
 	struct list_head cb_list; /* md requires an unplug callback */
 };
-- 
2.39.2

