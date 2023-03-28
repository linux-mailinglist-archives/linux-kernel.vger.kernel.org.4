Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF3B6CBB58
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjC1Jn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjC1JnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:43:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEBE65AA;
        Tue, 28 Mar 2023 02:43:03 -0700 (PDT)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pm4Qn2S44zgZD1;
        Tue, 28 Mar 2023 17:39:45 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 17:43:00 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] blktrace: Gracefully return if fail in blk_register_tracepoints()
Date:   Tue, 28 Mar 2023 17:46:05 +0800
Message-ID: <20230328094605.480557-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently blk_register_tracepoints() WARN for every registration failure
of block tracepoint, however, blk_trace can still be setup-ed.

It seems better to cleanup registered tracepoints and return error when
a certain registration failed, even if it's a small probability, and
users can know the error and do blk_trace setup again.

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/blktrace.c | 113 +++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..62ac72866f02 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -60,7 +60,7 @@ static struct tracer_flags blk_tracer_flags = {
 static DEFINE_MUTEX(blk_probe_mutex);
 static int blk_probes_ref;
 
-static void blk_register_tracepoints(void);
+static int blk_register_tracepoints(void);
 static void blk_unregister_tracepoints(void);
 
 /*
@@ -330,12 +330,20 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	kfree(bt);
 }
 
-static void get_probe_ref(void)
+static int get_probe_ref(void)
 {
+	int ret = 0;
+
 	mutex_lock(&blk_probe_mutex);
-	if (++blk_probes_ref == 1)
-		blk_register_tracepoints();
+	if (++blk_probes_ref == 1) {
+		ret = blk_register_tracepoints();
+		if (ret) {
+			pr_warn("Could not register block tracepoints\n");
+			--blk_probes_ref;
+		}
+	}
 	mutex_unlock(&blk_probe_mutex);
+	return ret;
 }
 
 static void put_probe_ref(void)
@@ -608,13 +616,14 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	bt->pid = buts->pid;
 	bt->trace_state = Blktrace_setup;
 
+	ret = get_probe_ref();
+	if (ret)
+		goto err;
 	rcu_assign_pointer(q->blk_trace, bt);
-	get_probe_ref();
+	return 0;
 
-	ret = 0;
 err:
-	if (ret)
-		blk_trace_free(q, bt);
+	blk_trace_free(q, bt);
 	return ret;
 }
 
@@ -1088,42 +1097,92 @@ void blk_add_driver_data(struct request *rq, void *data, size_t len)
 }
 EXPORT_SYMBOL_GPL(blk_add_driver_data);
 
-static void blk_register_tracepoints(void)
+static int blk_register_tracepoints(void)
 {
 	int ret;
 
 	ret = register_trace_block_rq_insert(blk_add_trace_rq_insert, NULL);
-	WARN_ON(ret);
+	if (ret)
+		return ret;
 	ret = register_trace_block_rq_issue(blk_add_trace_rq_issue, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_rq_issue;
 	ret = register_trace_block_rq_merge(blk_add_trace_rq_merge, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_rq_merge;
 	ret = register_trace_block_rq_requeue(blk_add_trace_rq_requeue, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_rq_requeue;
 	ret = register_trace_block_rq_complete(blk_add_trace_rq_complete, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_rq_complete;
 	ret = register_trace_block_bio_bounce(blk_add_trace_bio_bounce, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_bio_bounce;
 	ret = register_trace_block_bio_complete(blk_add_trace_bio_complete, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_bio_complete;
 	ret = register_trace_block_bio_backmerge(blk_add_trace_bio_backmerge, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_bio_backmerge;
 	ret = register_trace_block_bio_frontmerge(blk_add_trace_bio_frontmerge, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_bio_frontmerge;
 	ret = register_trace_block_bio_queue(blk_add_trace_bio_queue, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_bio_queue;
 	ret = register_trace_block_getrq(blk_add_trace_getrq, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_getrq;
 	ret = register_trace_block_plug(blk_add_trace_plug, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_plug;
 	ret = register_trace_block_unplug(blk_add_trace_unplug, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_unplug;
 	ret = register_trace_block_split(blk_add_trace_split, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_split;
 	ret = register_trace_block_bio_remap(blk_add_trace_bio_remap, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_bio_remap;
 	ret = register_trace_block_rq_remap(blk_add_trace_rq_remap, NULL);
-	WARN_ON(ret);
+	if (ret)
+		goto err_block_rq_remap;
+	return 0;
+
+err_block_rq_remap:
+	unregister_trace_block_bio_remap(blk_add_trace_bio_remap, NULL);
+err_block_bio_remap:
+	unregister_trace_block_split(blk_add_trace_split, NULL);
+err_block_split:
+	unregister_trace_block_unplug(blk_add_trace_unplug, NULL);
+err_block_unplug:
+	unregister_trace_block_plug(blk_add_trace_plug, NULL);
+err_block_plug:
+	unregister_trace_block_getrq(blk_add_trace_getrq, NULL);
+err_block_getrq:
+	unregister_trace_block_bio_queue(blk_add_trace_bio_queue, NULL);
+err_block_bio_queue:
+	unregister_trace_block_bio_frontmerge(blk_add_trace_bio_frontmerge, NULL);
+err_block_bio_frontmerge:
+	unregister_trace_block_bio_backmerge(blk_add_trace_bio_backmerge, NULL);
+err_block_bio_backmerge:
+	unregister_trace_block_bio_complete(blk_add_trace_bio_complete, NULL);
+err_block_bio_complete:
+	unregister_trace_block_bio_bounce(blk_add_trace_bio_bounce, NULL);
+err_block_bio_bounce:
+	unregister_trace_block_rq_complete(blk_add_trace_rq_complete, NULL);
+err_block_rq_complete:
+	unregister_trace_block_rq_requeue(blk_add_trace_rq_requeue, NULL);
+err_block_rq_requeue:
+	unregister_trace_block_rq_merge(blk_add_trace_rq_merge, NULL);
+err_block_rq_merge:
+	unregister_trace_block_rq_issue(blk_add_trace_rq_issue, NULL);
+err_block_rq_issue:
+	unregister_trace_block_rq_insert(blk_add_trace_rq_insert, NULL);
+	tracepoint_synchronize_unregister();
+	return ret;
 }
 
 static void blk_unregister_tracepoints(void)
@@ -1643,8 +1702,10 @@ static int blk_trace_setup_queue(struct request_queue *q,
 
 	blk_trace_setup_lba(bt, bdev);
 
+	ret = get_probe_ref();
+	if (ret)
+		goto free_bt;
 	rcu_assign_pointer(q->blk_trace, bt);
-	get_probe_ref();
 	return 0;
 
 free_bt:
-- 
2.25.1

