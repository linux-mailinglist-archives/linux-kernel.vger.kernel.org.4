Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980F5728F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 07:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjFIFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 01:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFIFlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 01:41:44 -0400
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8EF4F2D7C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 22:41:42 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 4ED8211003DC0E;
        Fri,  9 Jun 2023 13:41:39 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 9 Jun 2023 13:41:38 +0800
Date:   Fri, 9 Jun 2023 13:41:37 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   Tio Zhang <tiozhang@didiglobal.com>
To:     <tj@kernel.org>, <jiangshanlai@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        <zyhtheonly@yeah.net>, <zwp10758@gmail.com>,
        <tiozhang@didiglobal.com>, <fuyuanli@didiglobal.com>
Subject: [PATCH 2/2] workqueue: introduce queue_work_cpumask to queue work
 onto a given cpumask
Message-ID: <20230609053910.GA19570@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, pmladek@suse.com, zyhtheonly@yeah.net,
        zwp10758@gmail.com, fuyuanli@didiglobal.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEQmJ=iwgFFjM+brDGRx9h8o6hQVNBPY1UB9nTg4PWQ=6r1pyQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce queue_work_cpumask to queue work on a "random" CPU onto a given
cpumask. It would be helpful when devices/modules want to assign works on
different cpusets but do not want to maintain extra workqueues, motivation
of doing this is to better improve boot/working times for devices when we
want to prevent our works running from some "bad" CPUs, i,e, some CPUs
filling with irqs, FIFO or some other "bad" things which would potentially
stuck our works.

And default to the first CPU that is in the intersection of the cpumask
given and the online cpumask.
The only exception is if the CPU is local in the cpuset we will just use
the current CPU.

The implementation refactors queue_work_node, it patches
'commit 8204e0c1113d ("workqueue: Provide queue_work_node to queue work
near a given NUMA node")'

For now queue_work_cpumask is not available for unbound workqueues, We will
try to further patch it.

Signed-off-by: tiozhang <tiozhang@didiglobal.com>
Signed-off-by: zzzyhtheonly <zyhtheonly@yeah.net>
---
 include/linux/workqueue.h |   2 +
 kernel/workqueue.c        | 108 ++++++++++++++++++++++++++------------
 2 files changed, 76 insertions(+), 34 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 3992c994787f..61e56f4fcdaa 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -440,6 +440,8 @@ extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work);
 extern bool queue_work_node(int node, struct workqueue_struct *wq,
 			    struct work_struct *work);
+extern bool queue_work_cpumask(cpumask_var_t cpumask,
+			struct workqueue_struct *wq, struct work_struct *work);
 extern bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			struct delayed_work *work, unsigned long delay);
 extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4666a1a92a31..d2c157b90b7c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1561,38 +1561,73 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 EXPORT_SYMBOL(queue_work_on);
 
 /**
- * workqueue_select_cpu_near - Select a CPU based on NUMA node
- * @node: NUMA node ID that we want to select a CPU from
+ * workqueue_select_cpu_cpumask - Select a CPU based on cpumask
+ * @cpumask: cpumask that we want to select a CPU from
  *
  * This function will attempt to find a "random" cpu available on a given
- * node. If there are no CPUs available on the given node it will return
- * WORK_CPU_UNBOUND indicating that we should just schedule to any
+ * cpumask. If there are no CPUs available on the given cpumask it will
+ * return WORK_CPU_UNBOUND indicating that we should just schedule to any
  * available CPU if we need to schedule this work.
  */
-static int workqueue_select_cpu_near(int node)
+static int workqueue_select_cpu_cpumask(cpumask_var_t cpumask)
 {
 	int cpu;
 
-	/* No point in doing this if NUMA isn't enabled for workqueues */
-	if (!wq_numa_enabled)
-		return WORK_CPU_UNBOUND;
-
-	/* Delay binding to CPU if node is not valid or online */
-	if (node < 0 || node >= MAX_NUMNODES || !node_online(node))
-		return WORK_CPU_UNBOUND;
-
-	/* Use local node/cpu if we are already there */
+	/* Use local cpu later if we are already there */
 	cpu = raw_smp_processor_id();
-	if (node == cpu_to_node(cpu))
+	if (cpumask_test_cpu(cpu, cpumask))
 		return cpu;
 
-	/* Use "random" otherwise know as "first" online CPU of node */
-	cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
+	/* Use "random" otherwise know as "first" online CPU of cpumask */
+	cpu = cpumask_any_and(cpumask, cpu_online_mask);
 
 	/* If CPU is valid return that, otherwise just defer */
 	return cpu < nr_cpu_ids ? cpu : WORK_CPU_UNBOUND;
 }
 
+/**
+ * queue_work_cpumask - queue work on a "random" cpu for a given cpumask
+ * @cpumask: cpumask that we are targeting the work for
+ * @wq: workqueue to use
+ * @work: work to queue
+ *
+ * We queue the work to a "random" CPU within a given cpumask. The basic
+ * idea here is to provide a way to somehow associate work with a given
+ * cpumask.
+ *
+ * This function will only make a best effort attempt at getting this onto
+ * the right cpumask. If no cpu in this cpumask is requested or the
+ * requested cpumask is offline then we just fall back to standard
+ * queue_work behavior.
+ *
+ * Currently the "random" CPU ends up being the first available CPU in the
+ * intersection of cpu_online_mask and the cpumask given, unless we
+ * are running on the cpumask. In that case we just use the current CPU.
+ *
+ * Will not work when your workqueue is WQ_UNBOUND.
+ *
+ * Return: %false if @work was already on a queue, %true otherwise.
+ */
+bool queue_work_cpumask(cpumask_var_t cpumask, struct workqueue_struct *wq,
+			struct work_struct *work)
+{
+	unsigned long flags;
+	bool ret = false;
+
+	local_irq_save(flags);
+
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+		int cpu = workqueue_select_cpu_cpumask(cpumask);
+
+		__queue_work(cpu, wq, work);
+		ret = true;
+	}
+
+	local_irq_restore(flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(queue_work_cpumask);
+
 /**
  * queue_work_node - queue work on a "random" cpu for a given NUMA node
  * @node: NUMA node that we are targeting the work for
@@ -1616,30 +1651,35 @@ static int workqueue_select_cpu_near(int node)
 bool queue_work_node(int node, struct workqueue_struct *wq,
 		     struct work_struct *work)
 {
-	unsigned long flags;
+	int cpu;
 	bool ret = false;
 
-	/*
-	 * This current implementation is specific to unbound workqueues.
-	 * Specifically we only return the first available CPU for a given
-	 * node instead of cycling through individual CPUs within the node.
-	 *
-	 * If this is used with a per-cpu workqueue then the logic in
-	 * workqueue_select_cpu_near would need to be updated to allow for
-	 * some round robin type logic.
-	 */
-	WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND));
+	/* No point in doing this if NUMA isn't enabled for wq */
+	if (!wq_numa_enabled)
+		cpu = WORK_CPU_UNBOUND;
 
-	local_irq_save(flags);
+	/* Delay binding to CPU if node is not valid or online */
+	if (node < 0 || node >= MAX_NUMNODES || !node_online(node))
+		cpu = WORK_CPU_UNBOUND;
 
-	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
-		int cpu = workqueue_select_cpu_near(node);
+	/* Fall back to standard behavior */
+	if (cpu == WORK_CPU_UNBOUND)
+		return queue_work_on(cpu, wq, work);
 
-		__queue_work(cpu, wq, work);
-		ret = true;
+	/* Use local cpu if we are already there, preempt_disable to make
+	 * sure that we dont migrate, otherwise this would be meaningless
+	 */
+	preempt_disable();
+	cpu = raw_smp_processor_id();
+	if (node == cpu_to_node(cpu)) {
+		ret = queue_work_on(cpu, wq, work);
+		preempt_enable();
+	} else {
+		preempt_enable();
+		ret = queue_work_cpumask(
+			(struct cpumask *)cpumask_of_node(node), wq, work);
 	}
 
-	local_irq_restore(flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(queue_work_node);
-- 
2.39.2 (Apple Git-143)

