Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD8068675D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjBANqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjBANqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:46:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2805A815
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:46:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 826F420854;
        Wed,  1 Feb 2023 13:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675259194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCban+rklTSAHJrwmyqwKlEmWGG+9E85BUPyoUJxwp8=;
        b=g7zA+L17Z5RyGOK0VteZ0LaBkA7iKvDo15K15xO4GgQVgtqSM7T0djEijMCn4kX0hGjlfB
        HkY6RAKVlEMFLn1KXz+EUpx8VdnNTdsC6pIbJ8uIDP6PSSBhcM+0mMkrZR6RGVdVmxt9Zr
        JCX+3xs3lW65dlCdlBNqlRiIIhMC5PY=
Received: from alley.suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 42CED2C141;
        Wed,  1 Feb 2023 13:46:34 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [RFC 5/5] workqueue: Print backtraces from CPUs with hung CPU bound workqueues
Date:   Wed,  1 Feb 2023 14:45:43 +0100
Message-Id: <20230201134543.13687-6-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230201134543.13687-1-pmladek@suse.com>
References: <20230201134543.13687-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
not be created in which case some warnings should get printed.
Another problem might be too high load. In this case, workers are
victims of a global system problem.

Worker pools for CPU bound workqueues are designed for lightweight
work items that do not need much CPU time. They are ideally proceed
on a single worker. New worker is used only when a work is sleeping.
It brings one additional problem. The stall might happen when
the CPU-bound workqueue is used for CPU-intensive work.

The problem happens when the CPU-intensive work is not sleeping/waiting
for a long time. Such a worker would be in TASK_RUNNING state.

In this case, it might be useful to see backtrace from the problematic
worker.

wq_watchdog_timer_fn() starts with one line report for each stalled worker
pool. All the extra information are printed later.

The most precise solution would be to make a note in struct worker_pool
when the first check found a stall in a CPU-bound workqueue.

A good enough heuristic should be printing backtraces of workers in
TASK_RUNNING state on CPUs where the stall was detected. After all,
there are just two CPU-bound workers pools for normal and high priority
workers.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/workqueue.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 58b835420435..c6017d178b91 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -49,6 +49,7 @@
 #include <linux/moduleparam.h>
 #include <linux/uaccess.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/debug.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
 
@@ -5911,6 +5912,68 @@ static struct timer_list wq_watchdog_timer;
 
 static unsigned long wq_watchdog_touched = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, wq_watchdog_touched_cpu) = INITIAL_JIFFIES;
+static DEFINE_PER_CPU(bool, wq_watchdog_hung_cpu);
+
+/*
+ * Show workers that might prevent processing pending work items.
+ * The only candidates are CPU-bound workers in a running state.
+ * Pending work items should be handled by another idle worker in all
+ * other situations.
+ */
+static bool show_pool_suspicious_workers(struct worker_pool *pool, bool shown_title)
+{
+	bool shown_any = false;
+	struct worker *worker;
+	unsigned long flags;
+	int bkt;
+
+	raw_spin_lock_irqsave(&pool->lock, flags);
+
+	if (pool->cpu < 0)
+		goto out;
+
+	if (!per_cpu(wq_watchdog_hung_cpu, pool->cpu))
+		goto out;
+
+	if (list_empty(&pool->worklist))
+		goto out;
+
+	hash_for_each(pool->busy_hash, bkt, worker, hentry) {
+		if (!task_is_running(worker->task))
+			continue;
+
+		if (!shown_title) {
+			pr_info("Showing backtraces of running workers in stuck CPU-bound worker pools:\n");
+			shown_title = true;
+		}
+
+		shown_any = true;
+		pr_info("pool %d:\n", pool->id);
+		sched_show_task(worker->task);
+	}
+out:
+	raw_spin_unlock_irqrestore(&pool->lock, flags);
+	return shown_any;
+}
+
+static void show_suspicious_workers(void)
+{
+	struct worker_pool *pool;
+	bool shown_title = false;
+	int pi;
+
+	rcu_read_lock();
+
+	for_each_pool(pool, pi) {
+		bool shown;
+
+		shown = show_pool_suspicious_workers(pool, shown_title);
+		if (shown)
+			shown_title = shown;
+	}
+
+	rcu_read_unlock();
+}
 
 static void wq_watchdog_reset_touched(void)
 {
@@ -5927,11 +5990,15 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	bool lockup_detected = false;
 	unsigned long now = jiffies;
 	struct worker_pool *pool;
+	int cpu;
 	int pi;
 
 	if (!thresh)
 		return;
 
+	for_each_online_cpu(cpu)
+		per_cpu(wq_watchdog_hung_cpu, cpu) = false;
+
 	rcu_read_lock();
 
 	for_each_pool(pool, pi) {
@@ -5961,11 +6028,15 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 		/* did we stall? */
 		if (time_after(now, ts + thresh)) {
 			lockup_detected = true;
+			if (pool->cpu >= 0)
+				per_cpu(wq_watchdog_hung_cpu, pool->cpu) = true;
 			pr_emerg("BUG: workqueue lockup - pool");
 			pr_cont_pool_info(pool);
 			pr_cont(" stuck for %us!\n",
 				jiffies_to_msecs(now - pool_ts) / 1000);
 		}
+
+
 	}
 
 	rcu_read_unlock();
@@ -5973,6 +6044,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	if (lockup_detected) {
 		print_create_worker_failed_num();
 		show_all_workqueues();
+		show_suspicious_workers();
 	}
 
 	wq_watchdog_reset_touched();
-- 
2.35.3

