Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF41E6ADF39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjCGMy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCGMyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:54:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3BD360BB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:54:26 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1CA4D1FE17;
        Tue,  7 Mar 2023 12:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678193665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ot5WhI+pYLPKm66MfFAHddCebeV3Th9lv/jx6sTdo4=;
        b=UvHQEw7KmbW4QdFxNbaJ65oPOx+c7/QR8YeKPTtdS1Iy/ho0D0pZePY1AGz0i7FkspFwk+
        ojvNxafFfe5c+k9LkhGm9A+cGvPIMKkBJoMma17e/Y7qlgDXSRrRSsdU9mYim63NTEBpN8
        f3jO2OmgCqKAZ51DCTLfC3OqQgi82X8=
Received: from alley.suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id C5ADD2C141;
        Tue,  7 Mar 2023 12:54:24 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 5/5] workqueue: Print backtraces from CPUs with hung CPU bound workqueues
Date:   Tue,  7 Mar 2023 13:53:35 +0100
Message-Id: <20230307125335.28805-6-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230307125335.28805-1-pmladek@suse.com>
References: <20230307125335.28805-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue watchdog reports a lockup when there was not any progress
in the worker pool for a long time. The progress means that a pending
work item starts being proceed.

Worker pools for unbound workqueues always wake up an idle worker and
try to process the work immediately. The last idle worker has to create
new worker first. The stall might happen only when a new worker could
not be created in which case an error should get printed. Another problem
might be too high load. In this case, workers are victims of a global
system problem.

Worker pools for CPU bound workqueues are designed for lightweight
work items that do not need much CPU time. They are proceed one by
one on a single worker. New worker is used only when a work is sleeping.
It creates one additional scenario. The stall might happen when
the CPU-bound workqueue is used for CPU-intensive work.

More precisely, the stall is detected when a CPU-bound worker is in
the TASK_RUNNING state for too long. In this case, it might be useful
to see the backtrace from the problematic worker.

The information how long a worker is in the running state is not available.
But the CPU-bound worker pools do not have many workers in the running
state by definition. And only few pools are typically blocked.

It should be acceptable to print backtraces from all workers in
TASK_RUNNING state in the stalled worker pools. The number of false
positives should be very low.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/workqueue.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cce342defc69..db6be8df5ddc 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -49,6 +49,7 @@
 #include <linux/moduleparam.h>
 #include <linux/uaccess.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/debug.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
 
@@ -141,6 +142,8 @@ enum {
  * WR: wq->mutex protected for writes.  RCU protected for reads.
  *
  * MD: wq_mayday_lock protected.
+ *
+ * WD: Used internally by the watchdog.
  */
 
 /* struct worker is defined in workqueue_internal.h */
@@ -153,6 +156,7 @@ struct worker_pool {
 	unsigned int		flags;		/* X: flags */
 
 	unsigned long		watchdog_ts;	/* L: watchdog timestamp */
+	bool			cpu_stall;	/* WD: stalled cpu bound pool */
 
 	/*
 	 * The counter is incremented in a process context on the associated CPU
@@ -5978,6 +5982,57 @@ static struct timer_list wq_watchdog_timer;
 static unsigned long wq_watchdog_touched = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, wq_watchdog_touched_cpu) = INITIAL_JIFFIES;
 
+/*
+ * Show workers that might prevent the processing of pending work items.
+ * The only candidates are CPU-bound workers in the running state.
+ * Pending work items should be handled by another idle worker
+ * in all other situations.
+ */
+static void show_cpu_pool_hog(struct worker_pool *pool)
+{
+	struct worker *worker;
+	unsigned long flags;
+	int bkt;
+
+	raw_spin_lock_irqsave(&pool->lock, flags);
+
+	hash_for_each(pool->busy_hash, bkt, worker, hentry) {
+		if (task_is_running(worker->task)) {
+			/*
+			 * Defer printing to avoid deadlocks in console
+			 * drivers that queue work while holding locks
+			 * also taken in their write paths.
+			 */
+			printk_deferred_enter();
+
+			pr_info("pool %d:\n", pool->id);
+			sched_show_task(worker->task);
+
+			printk_deferred_exit();
+		}
+	}
+
+	raw_spin_unlock_irqrestore(&pool->lock, flags);
+}
+
+static void show_cpu_pools_hogs(void)
+{
+	struct worker_pool *pool;
+	int pi;
+
+	pr_info("Showing backtraces of running workers in stalled CPU-bound worker pools:\n");
+
+	rcu_read_lock();
+
+	for_each_pool(pool, pi) {
+		if (pool->cpu_stall)
+			show_cpu_pool_hog(pool);
+
+	}
+
+	rcu_read_unlock();
+}
+
 static void wq_watchdog_reset_touched(void)
 {
 	int cpu;
@@ -5991,6 +6046,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 {
 	unsigned long thresh = READ_ONCE(wq_watchdog_thresh) * HZ;
 	bool lockup_detected = false;
+	bool cpu_pool_stall = false;
 	unsigned long now = jiffies;
 	struct worker_pool *pool;
 	int pi;
@@ -6003,6 +6059,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	for_each_pool(pool, pi) {
 		unsigned long pool_ts, touched, ts;
 
+		pool->cpu_stall = false;
 		if (list_empty(&pool->worklist))
 			continue;
 
@@ -6027,11 +6084,17 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 		/* did we stall? */
 		if (time_after(now, ts + thresh)) {
 			lockup_detected = true;
+			if (pool->cpu >= 0) {
+				pool->cpu_stall = true;
+				cpu_pool_stall = true;
+			}
 			pr_emerg("BUG: workqueue lockup - pool");
 			pr_cont_pool_info(pool);
 			pr_cont(" stuck for %us!\n",
 				jiffies_to_msecs(now - pool_ts) / 1000);
 		}
+
+
 	}
 
 	rcu_read_unlock();
@@ -6039,6 +6102,9 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	if (lockup_detected)
 		show_all_workqueues();
 
+	if (cpu_pool_stall)
+		show_cpu_pools_hogs();
+
 	wq_watchdog_reset_touched();
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);
 }
-- 
2.35.3

