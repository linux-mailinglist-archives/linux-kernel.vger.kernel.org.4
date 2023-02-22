Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1880B69F623
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjBVOIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjBVOIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:08:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64A36FC9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677074920; x=1708610920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pktt/mrqrBC63XYiImrQ9EcPUvlSLszWvscUVEpComk=;
  b=mSR3xkvFgtOAuVIKV/u9C1eCO2l6r+dDMw182WkMTBl+8lAf5PLYO84O
   mKbMz6ZBHfDeSKqWixqdOxTyAn7ULqG5mXO8+2ieiXWEUT+BI+0RzPGg/
   O1ssZrlSy80wipjc8H2lcbFOt/kwuIdYFxMedcq1tTs7diMjvC9ZKnKsh
   NqEqPdsZAH14K0uJawyjVUIEuMxR4W1KNh4V5/nKoPHBWStvh4LzQh5QZ
   Wfw2ruN695sKJ4w6eaN1Mx1Nu5WFLoJUmUpulqictgP0J+kfZrBwK+LCB
   Hn6xbsmx9uSCQj63/yvxSDCoEBXc9ecsZYMlQdypcL1AWpYCDKKxiIwiR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="335129349"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="335129349"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 06:08:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="674121288"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="674121288"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2023 06:08:25 -0800
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
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v6 2/2] sched/fair: Introduce SIS_SHORT to wake up short task on current CPU
Date:   Wed, 22 Feb 2023 22:09:55 +0800
Message-Id: <373e6886e274f198608fa1b5f1c254e32b43845d.1677069490.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1677069490.git.yu.c.chen@intel.com>
References: <cover.1677069490.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
test platform has 112 CPUs per LLC domain. The will-it-scale launches
1, 8, 16 ... 112 instances respectively. Each instance is composed
of 2 tasks, and each pair of tasks would do ping-pong scheduling via
pipe_read() and pipe_write(). No task is bound to any CPU.
It is found that, once the number of instances is higher than
56, the throughput drops accordingly:

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

Avoid this problem indirectly. If the following conditions are met:
1. the system does not have idle cores,
2. the waker and wakee are both short duration tasks,
3. the waker and wakee have very limited wakee_flips,
then wake up the wakee on current CPU.

The reason is that, if the waker is a short-duration task, it might
relinquish the CPU soon, and the wakee has the chance to be scheduled.
On the other hand, if the wakee is a short duration task, putting it on
non-idle CPU would bring minimal impact to the running task. No idle
core in the system indicates that this mechanism should not inhibit
spreading the tasks if the system is not busy. Besides, if two tasks
wake up each other frequently(wakee_flips = 0), it suggests that
they share resource and should be put together.

This wake up strategy can be viewed as dynamic WF_SYNC. Except that
WF_SYNC does not treat non-idle CPU as candidate CPU.

[Benchmark results]
The baseline is v6.2-rc6 tip:sched/core, on top of
Commit 7c4a5b89a0b5 ("sched/rt: pick_next_rt_entity(): check list_entry").
The test platform has 2 x 56C/112T and 224 CPUs in total. C-states
deeper than C1E are disabled. Turbo is disabled. CPU frequency governor
is performance.

will-it-scale
=============
case			load		baseline	compare%
context_switch1		224 groups	1.00		+946.68%

There is a huge improvement in fast context switch test case, especially
when the number of groups equals the CPUs.

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	56-threads	 1.00 (  1.12)	 -0.05 (  0.97)
TCP_RR          	112-threads	 1.00 (  0.50)	 +0.31 (  0.35)
TCP_RR          	168-threads	 1.00 (  3.46)	 +5.50 (  2.08)
TCP_RR          	224-threads	 1.00 (  2.52)	+665.38 (  3.38)
TCP_RR          	280-threads	 1.00 ( 38.59)	+22.12 ( 11.36)
TCP_RR          	336-threads	 1.00 ( 15.88)	 -0.00 ( 19.96)
TCP_RR          	392-threads	 1.00 ( 27.22)	 +0.26 ( 24.26)
TCP_RR          	448-threads	 1.00 ( 37.88)	 +0.04 ( 27.87)
UDP_RR          	56-threads	 1.00 (  2.39)	 -0.36 (  8.33)
UDP_RR          	112-threads	 1.00 ( 22.62)	 -0.65 ( 24.66)
UDP_RR          	168-threads	 1.00 ( 15.72)	 +3.97 (  5.02)
UDP_RR          	224-threads	 1.00 ( 15.90)	+134.98 ( 28.59)
UDP_RR          	280-threads	 1.00 ( 32.43)	 +0.26 ( 29.68)
UDP_RR          	336-threads	 1.00 ( 39.21)	 -0.05 ( 39.71)
UDP_RR          	392-threads	 1.00 ( 31.76)	 -0.22 ( 32.00)
UDP_RR          	448-threads	 1.00 ( 44.90)	 +0.06 ( 31.83)

There is significant 600+% improvement for TCP_RR and 100+% for UDP_RR
when the number of threads equals the CPUs.

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	56-threads	 1.00 (  0.15)	 +0.88 (  0.08)
loopback        	112-threads	 1.00 (  0.06)	 -0.41 (  0.52)
loopback        	168-threads	 1.00 (  0.17)	+45.42 ( 39.54)
loopback        	224-threads	 1.00 ( 36.93)	+24.10 (  0.06)
loopback        	280-threads	 1.00 (  0.04)	 -0.04 (  0.04)
loopback        	336-threads	 1.00 (  0.06)	 -0.16 (  0.14)
loopback        	392-threads	 1.00 (  0.05)	 +0.06 (  0.02)
loopback        	448-threads	 1.00 (  0.07)	 -0.02 (  0.07)

There is no noticeable impact on tbench. Although there is run-to-run variance
in 168/224 threads case, with or without this patch applied.

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  5.39)	 +5.26 (  7.26)
process-pipe    	2-groups	 1.00 (  7.56)	 +1.85 (  1.98)
process-pipe    	4-groups	 1.00 ( 11.14)	 +6.40 (  4.77)
process-pipe    	8-groups	 1.00 (  1.99)	 -1.03 (  0.29)
process-sockets 	1-groups	 1.00 (  0.32)	 +0.81 (  0.53)
process-sockets 	2-groups	 1.00 (  0.44)	 -1.57 (  0.04)
process-sockets 	4-groups	 1.00 (  0.43)	 -0.33 (  1.13)
process-sockets 	8-groups	 1.00 (  0.42)	 -0.91 (  0.92)
threads-pipe    	1-groups	 1.00 (  0.15)	 -1.28 (  1.42)
threads-pipe    	2-groups	 1.00 (  4.20)	 -4.82 (  4.20)
threads-pipe    	4-groups	 1.00 (  2.23)	 +0.57 (  3.89)
threads-pipe    	8-groups	 1.00 (  1.24)	 -0.37 (  1.08)
threads-sockets 	1-groups	 1.00 (  1.93)	 +0.89 (  1.43)
threads-sockets 	2-groups	 1.00 (  0.43)	 -2.92 (  4.96)
threads-sockets 	4-groups	 1.00 (  0.59)	 -2.63 (  1.60)
threads-sockets 	8-groups	 1.00 (  0.38)	 -0.42 (  0.33)

Overall there is no noticeable impact on hackbench.

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  2.27)	 +1.75 (  3.31)
normal          	2-mthreads	 1.00 (  4.10)	 +0.59 (  4.72)
normal          	4-mthreads	 1.00 (  2.41)	 +1.91 (  4.11)
normal          	8-mthreads	 1.00 (  1.74)	 +4.87 (  1.40)

Overall there is no noticeable impact on schbench.

Redis
=====
Launch 224 instances of redis-server on machine A, launch 224 instances
of redis-benchmark on machine B, measure the SET/GET latency on B.
It was tested on a 1G NIC card. The 99th latency before vs after SIS_SHORT
did not change much.
         baseline               sis_short
SET      115 ms                   116 ms
GET      225 ms                   228 ms

Reaim was tested on a 2 x 8C Intel Xeon E-2278G, 16.48% jobs_per_min improvement
was observed when the system is overloaded.

[Limitations/Miscellaneous]

[a]
Peter has suggested[2] comparing task duration with the cost of searching
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
SIS_SHORT leverages SIS_UTIL to do better task placement. If the scan
number suggested by SIS_UTIL is smaller than 60% of llc_weight, it
indicates a util_avg% higher than 50%, which indicates a half-busy LLC
domain. This co-exists with !has_idle_core to not stack too many tasks
on one CPU. System busier than this could lower its bar to choose a
compromised "idle" CPU.

[d]
Inspired by Abel's Redis test, the short task definination not only considers
the duration, but also checks the wakee_flips of both waker and wakee.
A task will only be regarded as short task if the wakee_flips is 0.
That is to say, task A only wakes up task B, and task B only wakes up A,
A and B can be put together on one CPU.

[1] https://lore.kernel.org/lkml/9ed75cad-3718-356f-21ca-1b8ec601f335@linux.alibaba.com/
[2] https://lore.kernel.org/lkml/Y2O8a%2FOhk1i1l8ao@hirez.programming.kicks-ass.net/

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 36 ++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9ac63868eaaa..4f8d5af2d9b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6497,6 +6497,23 @@ static int wake_wide(struct task_struct *p)
 	return 1;
 }
 
+/*
+ * If a task switches in and then voluntarily relinquishes the
+ * CPU quickly, it is regarded as a short duration task.
+ *
+ * SIS_SHORT tries to wake up the short wakee on current CPU. This
+ * aims to avoid race condition among CPUs due to frequent context
+ * switch. Besides, the candidate short task should not be the one
+ * that wakes up more than one tasks, otherwise SIS_SHORT might
+ * stack too many tasks on current CPU.
+ */
+static inline int is_short_task(struct task_struct *p)
+{
+	return sched_feat(SIS_SHORT) && !p->wakee_flips &&
+	       p->se.dur_avg &&
+	       ((p->se.dur_avg * 8) < sysctl_sched_min_granularity);
+}
+
 /*
  * The purpose of wake_affine() is to quickly determine on which CPU we can run
  * soonest. For the purpose of speed we only consider the waking and previous
@@ -6533,6 +6550,11 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (available_idle_cpu(prev_cpu))
 		return prev_cpu;
 
+	/* The only running task is a short duration one. */
+	if (cpu_rq(this_cpu)->nr_running == 1 &&
+	    is_short_task(rcu_dereference(cpu_curr(this_cpu))))
+		return this_cpu;
+
 	return nr_cpumask_bits;
 }
 
@@ -6907,6 +6929,20 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 			/* overloaded LLC is unlikely to have idle cpu/core */
 			if (nr == 1)
 				return -1;
+
+			/*
+			 * If the scan number suggested by SIS_UTIL is smaller
+			 * than 60% of llc_weight, it indicates a util_avg% higher
+			 * than 50%. System busier than this could lower its bar to
+			 * choose a compromised "idle" CPU. This co-exists with
+			 * !has_idle_core to not stack too many tasks on one CPU.
+			 */
+			if (!has_idle_core && this == target &&
+			    (5 * nr < 3 * sd->span_weight) &&
+			    cpu_rq(target)->nr_running <= 1 &&
+			    is_short_task(p) &&
+			    is_short_task(rcu_dereference(cpu_curr(target))))
+				return target;
 		}
 	}
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..efdc29c42161 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_SHORT, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
-- 
2.25.1

