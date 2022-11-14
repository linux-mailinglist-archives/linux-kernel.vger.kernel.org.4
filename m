Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23183627D50
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiKNMGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiKNMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:05:35 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3FCD13C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:05:32 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 2AEC50dj085143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Mon, 14 Nov 2022 20:05:00 +0800 (CST)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from BJ10918NBW01.spreadtrum.com (10.0.74.46) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 14 Nov 2022 20:05:00 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <ke.wang@unisoc.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/rt: Use cpu_active_mask to prevent rto_push_irq_work's dead loop
Date:   Mon, 14 Nov 2022 20:04:53 +0800
Message-ID: <20221114120453.3233-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.46]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 2AEC50dj085143
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are performing the stress test related to cpu hotplug,
when there are only two cpus left in the system(for example: cpu0 and cpu1),
if cpu1 is offline at this time, the following infinite loop may occur:

When cpu0 contains more than one rt task, it will push the other rt tasks
to cpux for execution. If cpu1 is going through the hotplug process at this time,
it woule start a stop_machine to be responsible for migrating the tasks on cpu1
to other online cpus. And prevent any task from migrating to this cpu.
As a result, when the cpu0 migrates the rt task to cpu1, the stop_machine
re-migrates the rt task to cpu0, which causes the rt.pushable_tasks of rq0
to never be null. The result is these rt tasks that have been repeatedly
migrated to cpu0 and cpu1.

In order to prevent the above situation from happening, use cpu_active_mask
to prevent find_lowset_rq from selecting inactive cpu. At the same time,
when there is only one active cpu in the system, irq_push_irq_work should be
terminated in advance.

Co-developed-by: Ke Wang <ke.wang@unisoc.com>
Signed-off-by: Ke Wang <ke.wang@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/cpupri.c | 1 +
 kernel/sched/rt.c     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index a286e726eb4b..42c40cfdf836 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -101,6 +101,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 
 	if (lowest_mask) {
 		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..9433696dae50 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2219,6 +2219,7 @@ static int rto_next_cpu(struct root_domain *rd)
 {
 	int next;
 	int cpu;
+	struct cpumask tmp_cpumask;
 
 	/*
 	 * When starting the IPI RT pushing, the rto_cpu is set to -1,
@@ -2238,6 +2239,11 @@ static int rto_next_cpu(struct root_domain *rd)
 		/* When rto_cpu is -1 this acts like cpumask_first() */
 		cpu = cpumask_next(rd->rto_cpu, rd->rto_mask);
 
+		cpumask_and(&tmp_cpumask, rd->rto_mask, cpu_active_mask);
+		if (rd->rto_cpu == -1 && cpumask_weight(&tmp_cpumask) == 1 &&
+		    cpumask_test_cpu(smp_processor_id(), &tmp_cpumask))
+			break;
+
 		rd->rto_cpu = cpu;
 
 		if (cpu < nr_cpu_ids)
-- 
2.25.1

