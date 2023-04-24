Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00026EA59D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjDUIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjDUIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:12:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7745FC9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682064746; x=1713600746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PewL7vUlEmsTr4bE8a5Ir3k55P/Ujk1QI8mfIJkKt8Y=;
  b=GLP37LGTmjpDtTajQ1efOQrN9IHkAG2m32/QJ9ZAXCyueFtx7cjU2riQ
   SMAQIzSN7PWIL5Ds5eZM1QGbbb3O6PVxKI4iAohpCTFdtTRMt8xeLCimD
   dMxusTL/yKcjQd+0kSFtSPDwKNfZmVVdRdsMJrHOU7qD+5soj8NpBapyz
   yDFc3v4PLX+fqK4B65ewYdQ/QUHe0C4uHuRlZx5gIg1Jp4GhQkxItTsD1
   pcNjGdYgEtPTOKlKoKjcanvcY4NEqUCV1Br6ccoD1oH2O961S/bHpwwOq
   Im5tmMqFBwLcO+csfjQnwnAlmN8TP7fUk0B9wVWNOnH2tX9Bjkg9xgNv2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="344697791"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="344697791"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 01:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="642431537"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="642431537"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2023 01:12:18 -0700
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
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v7 2/2] sched/fair: Introduce SIS_CURRENT to wake up short task on current CPU
Date:   Sat, 22 Apr 2023 00:08:18 +0800
Message-Id: <98257d0184b227cad8b4e947eedd9246d60191d3.1682060436.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1682060436.git.yu.c.chen@intel.com>
References: <cover.1682060436.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
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
instances continues to increase.

The will-it-scale context_switch1 test case exposes the issue. The
test platform is Intel Sapphire Rapids, which has 2 x 56C/112T and
224 CPUs in total. will-it-scale launches 1, 8, 16 ... instances
respectively. Each instance is composed of 2 tasks, and each pair
of tasks would do ping-pong scheduling via pipe_read() and pipe_write().
No task is bound to any CPU. It is found that, once the number of
instances is higher than 56, the throughput drops accordingly:

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

The performance downgrading was caused by a high system idle
percentage(around 20% ~ 30%). The CPUs waste a lot of time in
idle and do nothing. As a comparison, if set CPU affinity to
these workloads and stops them from migrating among CPUs,
the idle percentage drops to nearly 0%, and the throughput
increases a lot. This indicates room for optimization.

The cause is the race condition between select_task_rq() and
the task enqueue.

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
be scheduled.

Tiancheng has mentioned the above issue here[1].

[Proposal]
The root cause is that there is no strict synchronization of
select_task_rq() and the set of ttwu_pending flag among several CPUs.
And this might be by design because the scheduler prefers parallel
wakeup.

Avoid this problem indirectly.
Wake up the short task on current CPU, if the following conditions are met:

1. waker A's rq->nr_running <= 1
2. waker A is a short duration task (waker will fall asleep soon)
3. wakee B is a short duration task (impact of B is minor to A)
4. A->wakee_flips is 0 and A->last_wakee = B
5. B->wakee_flips is 0 and B->last_wakee = A

The reason is that, if the waker is a short-duration task, it might
relinquish the CPU soon, and the wakee has the chance to be scheduled.
On the other hand, if the wakee is a short duration task, putting it on
non-idle CPU would bring minimal impact to the running task. Besides,
if two tasks wake up each other alternately, it suggests that
they usually share resource and should be put together.

This wake up strategy is regarded as a dynamic WF_CURRENT_CPU[2] proposed
by Andrei Vagin, except that this change treats the current CPU as the
last resort when previous CPU is not idle, and avoid tasks stacking
on current CPU as much as possible.

[Benchmark results]
The baseline is v6.3-rc3 tip:sched/core, on top of
Commit 9b8e17813aec ("sched/core: Make sched_dynamic_mutex static").
The test platform Intel Sapphire Rapids has 2 x 56C/112T and 224 CPUs in total.
C-states deeper than C1E are disabled. Turbo is disabled. CPU frequency governor
is performance.

Overall there is universal improvement for netperf/tbench/will-it-scale,
under different load. And there is no significant impact on hackbench/schbench.

will-it-scale
=============
case			load		baseline	compare%
context_switch1		224 groups	1.00		+1467.97%

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	56-threads	 1.00 (  2.20)	+13.15 (  4.36)
TCP_RR          	112-threads	 1.00 (  2.08)	+87.39 (  4.35)
TCP_RR          	168-threads	 1.00 ( 17.82)	+419.70 (  7.34)
TCP_RR          	224-threads	 1.00 ( 15.60)	+779.49 (  3.24)
TCP_RR          	280-threads	 1.00 ( 73.01)	+192.72 (  9.17)
TCP_RR          	336-threads	 1.00 ( 18.42)	 +0.21 ( 19.25)
TCP_RR          	392-threads	 1.00 ( 41.34)	+26.30 ( 26.97)
TCP_RR          	448-threads	 1.00 ( 27.61)	 +0.02 ( 28.65)
UDP_RR          	56-threads	 1.00 (  4.82)	 -0.60 ( 11.28)
UDP_RR          	112-threads	 1.00 ( 29.67)	-15.97 ( 44.92)
UDP_RR          	168-threads	 1.00 ( 21.62)	+113.99 ( 45.49)
UDP_RR          	224-threads	 1.00 ( 18.54)	+184.40 ( 44.54)
UDP_RR          	280-threads	 1.00 ( 24.41)	+199.72 ( 42.38)
UDP_RR          	336-threads	 1.00 ( 41.28)	 +0.40 ( 38.10)
UDP_RR          	392-threads	 1.00 ( 32.40)	 +1.73 ( 39.68)
UDP_RR          	448-threads	 1.00 ( 36.24)	 +3.69 ( 48.73)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	56-threads	 1.00 (  1.13)	+11.54 (  1.29)
loopback        	112-threads	 1.00 (  0.18)	 +2.82 (  0.27)
loopback        	168-threads	 1.00 (  0.02)	+154.13 (  0.20)
loopback        	224-threads	 1.00 ( 58.38)	+82.56 (  0.49)
loopback        	280-threads	 1.00 (  0.06)	 -0.07 (  0.28)
loopback        	336-threads	 1.00 (  0.37)	 -1.24 (  0.33)
loopback        	392-threads	 1.00 (  0.11)	 +0.17 (  0.09)
loopback        	448-threads	 1.00 (  0.29)	 +0.32 (  0.14)

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  0.95)	 +0.02 (  0.60)
process-pipe    	2-groups	 1.00 (  8.51)	 -0.43 (  3.21)
process-pipe    	4-groups	 1.00 (  7.39)	 -9.09 (  2.50)
process-sockets 	1-groups	 1.00 (  1.28)	 +1.03 (  0.95)
process-sockets 	2-groups	 1.00 (  0.85)	 +6.27 ( 10.32)
process-sockets 	4-groups	 1.00 (  1.28)	 -0.51 (  0.66)
threads-pipe    	1-groups	 1.00 (  1.69)	 +0.66 (  0.40)
threads-pipe    	2-groups	 1.00 (  8.25)	 -7.78 (  3.31)
threads-pipe    	4-groups	 1.00 (  1.52)	 +1.50 (  4.98)
threads-sockets 	1-groups	 1.00 (  1.50)	 +0.96 (  2.02)
threads-sockets 	2-groups	 1.00 (  1.87)	 -1.15 (  1.91)
threads-sockets 	4-groups	 1.00 (  0.77)	 -0.73 (  2.15)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  1.25)	 +0.00 (  1.25)
normal          	2-mthreads	 1.00 (  0.00)	 +0.88 (  3.31)
normal          	4-mthreads	 1.00 (  1.29)	 +0.91 (  1.30)
normal          	8-mthreads	 1.00 (  2.21)	 +0.00 (  2.21)

Redis
=====
Launch 224 instances of redis-server on machine A, launch 224 instances
of redis-benchmark on machine B, measure the SET/GET latency on B.
It was tested on a 1G NIC card. The 99th latency before vs after SIS_CURRENT
did not change much.
         baseline               sis_current
SET      115 ms                   116 ms
GET      225 ms                   228 ms

Thanks Prateek for testing on a dual socket Zen3 system (2 x 64C/128T).
tbench and netperf show good improvements at 128 clients. SpecJBB shows
some improvement in max-jOPS:
                                tip             SIS_CURRENT
SPECjbb2015 max-jOPS            100.00%         102.78%
SPECjbb2015 Critical-jOPS       100.00%         100.00%

Others are perf neutral.

[Limitations/Miscellaneous]

[a]
Peter has suggested[3] comparing task duration with the cost of searching
for an idle CPU. If the latter is higher, then give up the scan, to
achieve better task affine. However, this method does not fit in the case
encountered in this patch. Because there are plenty of (fast)idle CPUs in
the system, it will not take too long to find an idle CPU. The bottleneck is
caused by the race condition mentioned above.

[b]
The short task threshold is sysctl_sched_min_granularity / 8.
According to get_update_sysctl_factor(), the sysctl_sched_min_granularity
could be 0.75 msec * 4 for SCHED_TUNABLESCALING_LOG,
or 0.75 msec * ncpus for SCHED_TUNABLESCALING_LINEAR.
Choosing 8 as the divisor is a trade-off. Thanks Honglei for pointing
this out.

[c]
Inspired by Abel's Redis test, the short task definination not only considers
the duration, but also checks the wakee_flips/last_wakee of both waker and
wakee. A waker can only wake up the wakee on current CPU if the wakee_flips is 0
and last_wakee is the wakee. That is to say, task A only wakes up task B, and
task B only wakes up A, A and B can be put together on one CPU.

[d]
Inspired by Andrei's WF_CURRENT_CPU proposal, makes SIS_CURRENT a dynamic version
for WF_CURRENT_CPU: short tasks having close wakeup relationship with each other,
should be put on 1 CPU to benefit cache sharing.


[1] https://lore.kernel.org/lkml/9ed75cad-3718-356f-21ca-1b8ec601f335@linux.alibaba.com/
[2] https://lore.kernel.org/lkml/20230308073201.3102738-3-avagin@google.com/
[3] https://lore.kernel.org/lkml/Y2O8a%2FOhk1i1l8ao@hirez.programming.kicks-ass.net/

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
index 4af5799b90fc..46c1321c0407 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6501,6 +6501,46 @@ static int wake_wide(struct task_struct *p)
 	return 1;
 }
 
+/*
+ * Wake up the task on current CPU, if the following conditions are met:
+ *
+ * 1. waker A is the only running task on this_cpu
+ * 3. A is a short duration task (waker will fall asleep soon)
+ * 4. wakee B is a short duration task (impact of B on A is minor)
+ * 5. A and B wake up each other alternately
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
+	 * minor impact to the target rq. Put the short waker and wakee together
+	 * bring benefit to cache-share task pairs and avoid migration overhead.
+	 */
+	if (!current->se.dur_avg || ((current->se.dur_avg * 8) >= sysctl_sched_min_granularity))
+		return false;
+
+	if (!p->se.dur_avg || ((p->se.dur_avg * 8) >= sysctl_sched_min_granularity))
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
@@ -6594,6 +6634,9 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
+	if (target == nr_cpumask_bits && wake_on_current(this_cpu, p))
+		target = this_cpu;
+
 	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
 	if (target != this_cpu)
 		return prev_cpu;
@@ -7115,6 +7158,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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

