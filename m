Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B635BB597
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 04:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiIQCdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 22:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIQCdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 22:33:31 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E68399B77;
        Fri, 16 Sep 2022 19:33:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VPzHIFq_1663381981;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VPzHIFq_1663381981)
          by smtp.aliyun-inc.com;
          Sat, 17 Sep 2022 10:33:27 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] sbitmap: fix permanent io blocking caused by insufficient wakeup times
Date:   Sat, 17 Sep 2022 10:33:01 +0800
Message-Id: <1663381981-6413-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

In "sbitmap_queue_clear_batch", a batch of completed requests may be
processed at once, but "wait_cnt" is only reduced once by
"sbitmap_queue_wake_up".
In our environment, if "/sys/block/nvme0n1/nr_requests" is adjusted to
32, it is easily because no tag and then enter the waiting situation,
if continue change "nr_requests" to 1023 at this time, it will basically
fall into the situation of permanent blocking. Because there will be
"blk_freeze_queue" in "blk_mq_update_nr_requests", which will prevent
any new requests, but due to insufficient wake-up, there are tasks
waiting for wake-up, but no new wake-up opportunities will be generated
at this time, so this situation needs to be repaired.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 include/linux/sbitmap.h |  8 ++++++++
 lib/sbitmap.c           | 22 ++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 8f5a86e..153382e 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -579,6 +579,14 @@ static inline struct sbq_wait_state *sbq_wait_ptr(struct sbitmap_queue *sbq,
 void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
 
 /**
+ * sbitmap_queue_wake_up_batch() - Attempt to wake up waiters in batches
+ * on a &struct sbitmap_queue.
+ * @sbq: Bitmap queue to wake up.
+ * @nr: The number of attempts to wake the waiter.
+ */
+void sbitmap_queue_wake_up_batch(struct sbitmap_queue *sbq, int nr);
+
+/**
  * sbitmap_queue_show() - Dump &struct sbitmap_queue information to a &struct
  * seq_file.
  * @sbq: Bitmap queue to show.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 29eb048..f2aa1da 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -600,7 +600,7 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 	return NULL;
 }
 
-static bool __sbq_wake_up(struct sbitmap_queue *sbq)
+static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
 {
 	struct sbq_wait_state *ws;
 	unsigned int wake_batch;
@@ -610,6 +610,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	if (!ws)
 		return false;
 
+again:
 	wait_cnt = atomic_dec_return(&ws->wait_cnt);
 	if (wait_cnt <= 0) {
 		int ret;
@@ -632,10 +633,14 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 		if (ret == wait_cnt) {
 			sbq_index_atomic_inc(&sbq->wake_index);
 			wake_up_nr(&ws->wait, wake_batch);
-			return false;
+			if (!nr || *nr <= 0)
+				return false;
 		}
 
 		return true;
+	} else if (nr && *nr) {
+		(*nr)--;
+		goto again;
 	}
 
 	return false;
@@ -643,11 +648,20 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 
 void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
 {
-	while (__sbq_wake_up(sbq))
+	while (__sbq_wake_up(sbq, NULL))
 		;
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
 
+void sbitmap_queue_wake_up_batch(struct sbitmap_queue *sbq, int nr)
+{
+	int i = SBQ_WAIT_QUEUES;
+
+	while (__sbq_wake_up(sbq, &nr) && --i)
+		;
+}
+EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up_batch);
+
 static inline void sbitmap_update_cpu_hint(struct sbitmap *sb, int cpu, int tag)
 {
 	if (likely(!sb->round_robin && tag < sb->depth))
@@ -683,7 +697,7 @@ void sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, int offset,
 		atomic_long_andnot(mask, (atomic_long_t *) addr);
 
 	smp_mb__after_atomic();
-	sbitmap_queue_wake_up(sbq);
+	sbitmap_queue_wake_up_batch(sbq, nr_tags);
 	sbitmap_update_cpu_hint(&sbq->sb, raw_smp_processor_id(),
 					tags[nr_tags - 1] - offset);
 }
-- 
1.8.3.1

