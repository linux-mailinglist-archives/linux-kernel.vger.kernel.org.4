Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957026F1B58
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346273AbjD1PV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjD1PVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:21:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A305B8E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682695274; x=1714231274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B+TtyZeK9FscAzdtTa8qglBpvfdeLQnvoehTGlvtDPk=;
  b=Zmwrkry7qo7KMua2/0LXX1tiMaT86CBn/NhcVKNqu7LpLpFyaggLKmFj
   j/dUcLqC1NIKoXIx8oGoU5veMmKz7eELVLMpFgJAzpHay59GinzlCekBM
   zNRyRFNOywKoJ6+o0YNZ52BD0tIX7E6qOx3rC4QhOLwveMMlJGb4bsUuN
   DQb00PCaM13vYgloY98IHA95waqGXSi7Z7E/SfFKH/fWh+icn5h2SWn8b
   MvOSa+EJ+EEqA+cOOOfdaWjATpfB5qm/jXNrSRohp/UYrbpR/fp4mMsa+
   B2xrcT15h2fVck8UTiHnZcWbtwO8zAmaZzgyTHnt3Wz4B1mGvghCQwTJP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="347799373"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="347799373"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:21:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="727577295"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="727577295"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga001.jf.intel.com with ESMTP; 28 Apr 2023 08:21:07 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v8 2/2] sched/fair: Introduce SIS_CURRENT to wake up short task on current CPU
Date:   Sat, 29 Apr 2023 07:16:56 +0800
Message-Id: <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1682661027.git.yu.c.chen@intel.com>
References: <cover.1682661027.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Problem Statement]
For a workload that is doing frequent context switches, the throughput
scales well until the number of instances reaches a peak point. After
that peak point, the throughput drops significantly if the number of
instances continue to increase.

The will-it-scale context_switch1 test case exposes the issue. The
test platform has 2 x 56C/112T and 224 CPUs in total. will-it-scale
launches 1, 8, 16 ... instances respectively. Each instance is composed
of 2 tasks, and each pair of tasks would do ping-pong scheduling via
pipe_read() and pipe_write(). No task is bound to any CPU. It is found
that, once the number of instances is higher than 56, the throughput
drops accordingly:

          ^
throughput|
          |                 X
          |               X   X X
          |             X         X X
          |           X               X
          |         X                   X
          |       X
          |     X
          |   X
          | X
          |
          +-----------------.------------------->
                            56
                                 number of instances

[Symptom analysis]

One of the reasons to cause the performance downgrading is the high
system idle percentage(around 20% ~ 30%). The CPUs waste a lot of
time in idle and do nothing. As a comparison, if set CPU affinity
to these workloads and stops them from migrating among CPUs,
the idle percentage drops to nearly 0%, and the throughput
increases a lot. This indicates room for optimization.

The cause of high idle time is that there is no strict synchronization
between select_task_rq() and the set of ttwu_pending flag among several
CPUs. And this might be by design because the scheduler prefers parallel
wakeup.

Suppose there are nr_cpus pairs of ping-pong scheduling
tasks. For example, p0' and p0 are ping-pong scheduling,
so do p1' <=> p1, and p2'<=> p2. None of these tasks are
bound to any CPUs. The problem can be summarized as:
more than 1 wakers are stacked on 1 CPU, which slows down
waking up their wakees:

CPU0					CPU1				CPU2

p0'					p1' => idle			p2'

try_to_wake_up(p0)							try_to_wake_up(p2);
CPU1 = select_task_rq(p0);						CPU1 = select_task_rq(p2);
ttwu_queue(p0, CPU1);							ttwu_queue(p2, CPU1);
  __ttwu_queue_wakelist(p0, CPU1);
    WRITE_ONCE(CPU1->ttwu_pending, 1);
    __smp_call_single_queue(CPU1, p0);	=> ttwu_list->p0
					quiting cpuidle_idle_call()

									  __ttwu_queue_wakelist(p2, CPU1);
									    WRITE_ONCE(CPU1->ttwu_pending, 1);
					ttwu_list->p2->p0	<=	    __smp_call_single_queue(CPU1, p2);

p0' => idle
					sched_ttwu_pending()
					  enqueue_task(p2 and p0)

					idle => p2

					...
					p2 time slice expires
					...
									!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
								<===	!!! p2 delays the wake up of p0' !!!
									!!! causes long idle on CPU0     !!!
					p2 => p0			!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
					p0 wakes up p0'

idle => p0'

Since there are many waker/wakee pairs in the system, the chain reaction
causes many CPUs to be victims. These idle CPUs wait for their waker to
be scheduled. Tiancheng has mentioned the above issue here[1].

Besides the high idle percentage, waking up the tasks on different CPUs
could bring Core-to-Core cache overhead, which hurts the performance.

[Proposal]

Waking up the short task on current CPU, if the
following conditions are met:

1. waker A's rq->nr_running <= 1
2. waker A is a short duration task (waker will fall asleep soon)
3. wakee B is a short duration task (impact of B is minor to A)
4. A->wakee_flips is 0 and A->last_wakee = B
5. B->wakee_flips is 0 and B->last_wakee = A

The reason is that, if the waker is a short-duration task, it might
relinquish the CPU soon, and the wakee has the chance to be scheduled.
On the other hand, if the wakee is a short duration task, putting it on
non-idle CPU would bring minimal impact to the running task.
The benefit of waking short task on current CPU:
1. Reduce race condition which causes high idle percentage.
2. Increase cache share between the waker and wakee.

The threshold to define a short duration task is sysctl_sched_migration_cost.
As suggested by Peter, this value is also used in task_hot() to prevent
migrations.

This wake up strategy is regarded as a dynamic WF_CURRENT_CPU[2] proposed
by Andrei Vagin, except that this change treats the current CPU as the
last resort when the previous CPU is not idle, and avoid tasks stacking
on the current CPU as much as possible.

[Benchmark results]
The baseline is v6.3-rc7 tip:sched/core, on top of
Commit f31dcb152a3d ("sched/clock: Fix local_clock() before sched_clock_init()").
The test platform Intel Sapphire Rapids has 2 x 56C/112T and 224 CPUs in total.
C-states deeper than C1E are disabled. Turbo is disabled. CPU frequency governor
is performance.

Overall there is a universal improvement for netperf/tbench/will-it-scale,
under different loads. And there is no significant impact on hackbench/schbench.

will-it-scale
=============
case			load		baseline	compare%
context_switch1		224 groups	1.00		+552.84%

netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  56-threads       1.00 (  1.96)  +15.23 (  4.67)
TCP_RR                  112-threads      1.00 (  1.84)  +88.83 (  4.37)
TCP_RR                  168-threads      1.00 (  0.41)  +475.45 (  4.45)
TCP_RR                  224-threads      1.00 (  0.62)  +806.85 (  3.67)
TCP_RR                  280-threads      1.00 ( 65.80)  +162.66 ( 10.26)
TCP_RR                  336-threads      1.00 ( 17.30)   -0.19 ( 19.07)
TCP_RR                  392-threads      1.00 ( 26.88)   +3.38 ( 28.91)
TCP_RR                  448-threads      1.00 ( 36.43)   -0.26 ( 33.72)
UDP_RR                  56-threads       1.00 (  7.91)   +3.77 ( 17.48)
UDP_RR                  112-threads      1.00 (  2.72)  -15.02 ( 10.78)
UDP_RR                  168-threads      1.00 (  8.86)  +131.77 ( 13.30)
UDP_RR                  224-threads      1.00 (  9.54)  +178.73 ( 16.75)
UDP_RR                  280-threads      1.00 ( 15.40)  +189.69 ( 19.36)
UDP_RR                  336-threads      1.00 ( 24.09)   +0.54 ( 22.28)
UDP_RR                  392-threads      1.00 ( 39.63)   -3.90 ( 33.77)
UDP_RR                  448-threads      1.00 ( 43.57)   +1.57 ( 40.43)

tbench
======
case                    load            baseline(std%)  compare%( std%)
loopback                56-threads       1.00 (  0.50)  +10.78 (  0.52)
loopback                112-threads      1.00 (  0.19)   +2.73 (  0.08)
loopback                168-threads      1.00 (  0.09)  +173.72 (  0.47)
loopback                224-threads      1.00 (  0.20)   -2.13 (  0.42)
loopback                280-threads      1.00 (  0.06)   -0.77 (  0.15)
loopback                336-threads      1.00 (  0.14)   -0.08 (  0.08)
loopback                392-threads      1.00 (  0.17)   -0.27 (  0.86)
loopback                448-threads      1.00 (  0.37)   +0.32 (  0.02)

hackbench
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            1-groups         1.00 (  0.94)   -0.67 (  0.45)
process-pipe            2-groups         1.00 (  3.22)   -3.00 (  3.35)
process-pipe            4-groups         1.00 (  1.66)   -3.25 (  1.87)
process-sockets         1-groups         1.00 (  0.70)   +1.34 (  0.44)
process-sockets         2-groups         1.00 (  0.24)   +6.99 ( 11.23)
process-sockets         4-groups         1.00 (  0.61)   +1.72 (  0.57)
threads-pipe            1-groups         1.00 (  0.95)   -0.66 (  0.74)
threads-pipe            2-groups         1.00 (  0.79)   -0.59 (  2.10)
threads-pipe            4-groups         1.00 (  1.97)   -1.23 ( 10.62)
threads-sockets         1-groups         1.00 (  0.73)   -2.59 (  1.32)
threads-sockets         2-groups         1.00 (  0.30)   -1.95 (  1.68)
threads-sockets         4-groups         1.00 (  1.22)   +1.86 (  0.73)

schbench
========
case                    load            baseline(std%)  compare%( std%)
normal                  1-mthreads       1.00 (  0.00)   +0.88 (  1.25)
normal                  2-mthreads       1.00 (  2.09)   +0.85 (  2.44)
normal                  4-mthreads       1.00 (  1.29)   -1.82 (  4.55)
normal                  8-mthreads       1.00 (  1.22)   +3.45 (  1.26)

Redis
=====
Launch 224 instances of redis-server on machine A, launch 224 instances
of redis-benchmark on machine B, measure the SET/GET latency on B.
It was tested on a 1G NIC card. The 99th latency before vs after SIS_CURRENT
did not change much.
         baseline               sis_current
SET      115 ms                   116 ms
GET      225 ms                   228 ms

Prateek tested this patch on a dual socket Zen3 system (2 x 64C/128T).
tbench and netperf show good improvements at 128 clients. SpecJBB shows
some improvement in max-jOPS:
                                tip             SIS_CURRENT
SPECjbb2015 max-jOPS            100.00%         102.78%
SPECjbb2015 Critical-jOPS       100.00%         100.00%

Others are perf neutral.

[1] https://lore.kernel.org/lkml/9ed75cad-3718-356f-21ca-1b8ec601f335@linux.alibaba.com/
[2] https://lore.kernel.org/lkml/20230308073201.3102738-3-avagin@google.com/

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: kernel test robot <yujie.liu@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 46 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 47 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3236011658a2..642a9e830e8f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6537,6 +6537,46 @@ static int wake_wide(struct task_struct *p)
 	return 1;
 }
 
+/*
+ * Wake up the task on current CPU, if the following conditions are met:
+ *
+ * 1. waker A is the only running task on this_cpu
+ * 2. A is a short duration task (waker will fall asleep soon)
+ * 3. wakee B is a short duration task (impact of B on A is minor)
+ * 4. A and B wake up each other alternately
+ */
+static bool
+wake_on_current(int this_cpu, struct task_struct *p)
+{
+	if (!sched_feat(SIS_CURRENT))
+		return false;
+
+	if (cpu_rq(this_cpu)->nr_running > 1)
+		return false;
+
+	/*
+	 * If a task switches in and then voluntarily relinquishes the
+	 * CPU quickly, it is regarded as a short duration task. In that
+	 * way, the short waker is likely to relinquish the CPU soon, which
+	 * provides room for the wakee. Meanwhile, a short wakee would bring
+	 * minor impact to the current rq. Put the short waker and wakee together
+	 * bring benefit to cache-share task pairs and avoid migration overhead.
+	 */
+	if (!current->se.dur_avg || current->se.dur_avg >= sysctl_sched_migration_cost)
+		return false;
+
+	if (!p->se.dur_avg || p->se.dur_avg >= sysctl_sched_migration_cost)
+		return false;
+
+	if (current->wakee_flips || p->wakee_flips)
+		return false;
+
+	if (current->last_wakee != p || p->last_wakee != current)
+		return false;
+
+	return true;
+}
+
 /*
  * The purpose of wake_affine() is to quickly determine on which CPU we can run
  * soonest. For the purpose of speed we only consider the waking and previous
@@ -6630,6 +6670,9 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
+	if (target == nr_cpumask_bits && wake_on_current(this_cpu, p))
+		target = this_cpu;
+
 	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
 	if (target != this_cpu)
 		return prev_cpu;
@@ -7151,6 +7194,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
+	if (smp_processor_id() == target && wake_on_current(target, p))
+		return target;
+
 	i = select_idle_cpu(p, sd, has_idle_core, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..a3e05827f7e8 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_CURRENT, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
-- 
2.25.1

