Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CAE6006BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJQGb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJQGbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:31:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3C5724F;
        Sun, 16 Oct 2022 23:31:19 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrRph3HC9z1P7fB;
        Mon, 17 Oct 2022 14:26:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 14:31:16 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-block@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 1/3] blktrace: introduce 'blk_trace_swicth_state' helper
Date:   Mon, 17 Oct 2022 14:53:19 +0800
Message-ID: <20221017065321.2846017-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221017065321.2846017-1-yebin10@huawei.com>
References: <20221017065321.2846017-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce 'blk_trace_swicth_state' helper. No functional changed.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/blktrace.c | 74 ++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7f5eb295fe19..edd83e213580 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -353,6 +353,39 @@ static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 	put_probe_ref();
 }
 
+static int blk_trace_switch_state(struct blk_trace *bt, int start)
+{
+	/*
+	 * For starting a trace, we can transition from a setup or stopped
+	 * trace. For stopping a trace, the state must be running
+	 */
+	if (start) {
+		if (bt->trace_state == Blktrace_setup ||
+		    bt->trace_state == Blktrace_stopped) {
+			blktrace_seq++;
+			smp_mb();
+			bt->trace_state = Blktrace_running;
+			raw_spin_lock_irq(&running_trace_lock);
+			list_add(&bt->running_list, &running_trace_list);
+			raw_spin_unlock_irq(&running_trace_lock);
+
+			trace_note_time(bt);
+			return 0;
+		}
+	} else {
+		if (bt->trace_state == Blktrace_running) {
+			bt->trace_state = Blktrace_stopped;
+			raw_spin_lock_irq(&running_trace_lock);
+			list_del_init(&bt->running_list);
+			raw_spin_unlock_irq(&running_trace_lock);
+			relay_flush(bt->rchan);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
@@ -658,7 +691,6 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 
 static int __blk_trace_startstop(struct request_queue *q, int start)
 {
-	int ret;
 	struct blk_trace *bt;
 
 	bt = rcu_dereference_protected(q->blk_trace,
@@ -666,36 +698,7 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
 	if (bt == NULL)
 		return -EINVAL;
 
-	/*
-	 * For starting a trace, we can transition from a setup or stopped
-	 * trace. For stopping a trace, the state must be running
-	 */
-	ret = -EINVAL;
-	if (start) {
-		if (bt->trace_state == Blktrace_setup ||
-		    bt->trace_state == Blktrace_stopped) {
-			blktrace_seq++;
-			smp_mb();
-			bt->trace_state = Blktrace_running;
-			raw_spin_lock_irq(&running_trace_lock);
-			list_add(&bt->running_list, &running_trace_list);
-			raw_spin_unlock_irq(&running_trace_lock);
-
-			trace_note_time(bt);
-			ret = 0;
-		}
-	} else {
-		if (bt->trace_state == Blktrace_running) {
-			bt->trace_state = Blktrace_stopped;
-			raw_spin_lock_irq(&running_trace_lock);
-			list_del_init(&bt->running_list);
-			raw_spin_unlock_irq(&running_trace_lock);
-			relay_flush(bt->rchan);
-			ret = 0;
-		}
-	}
-
-	return ret;
+	return blk_trace_switch_state(bt, start);
 }
 
 int blk_trace_startstop(struct request_queue *q, int start)
@@ -1614,13 +1617,8 @@ static int blk_trace_remove_queue(struct request_queue *q)
 	if (bt == NULL)
 		return -EINVAL;
 
-	if (bt->trace_state == Blktrace_running) {
-		bt->trace_state = Blktrace_stopped;
-		raw_spin_lock_irq(&running_trace_lock);
-		list_del_init(&bt->running_list);
-		raw_spin_unlock_irq(&running_trace_lock);
-		relay_flush(bt->rchan);
-	}
+	if (bt->trace_state == Blktrace_running)
+		blk_trace_switch_state(bt, 0);
 
 	put_probe_ref();
 	synchronize_rcu();
-- 
2.31.1

