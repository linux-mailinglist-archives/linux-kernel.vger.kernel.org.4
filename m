Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39ED64E736
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLPGKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiLPGKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:10:45 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FFB7D0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671171043; x=1702707043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lLZ7StEuYNJH37HXF082y7je8y7wH9Yvy0jgWSt7jl4=;
  b=iEj5e5ymRE/8PqFU6aNZ9LD6fY1cw2yyPXcAsqRX2+dtr4PnkMSeOxu7
   R1fWnF8zDtifC6ONJcpfCf0NvpPwmVBHkWB9IhVHJUPiBOXX0UjVnD8LB
   QDQOLIH2nbDy3eDEwcFx79fQLhzYZPo9u9PrYjresMQESxkl8WyoQ9lx4
   BB9/TDZAxgAvTyMeA24BPccv++oFzc3AcA6/kRfEN4Spvs9qZ4P8noehH
   WceLzgvftOJvOm+8+EablEed+P+1NlU76fy2d91KrW8M5AD/dwXUEdc4S
   TsIb12Tsnx0OlLPkARGhf4hKoALK/3T08XYsH8JoRwOi0ALGUBUakhjHB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="320069234"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="320069234"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 22:10:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="680389392"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="680389392"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2022 22:10:35 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        kernel test robot <yujie.liu@intel.com>
Subject: [RFC PATCH v4 2/2] sched/fair: Choose the CPU where short task is running during wake up
Date:   Fri, 16 Dec 2022 14:11:32 +0800
Message-Id: <3479fdc1eb255fe16f570230f807e009f919f7de.1671158588.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1671158588.git.yu.c.chen@intel.com>
References: <cover.1671158588.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
56(112 tasks in total, every CPU has 1 task), the throughput
drops accordingly if the instance number continues to increase:

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
increases by about 300%. This indicates room for optimization.

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

Actually, Tiancheng has mentioned the above issue here[1].

[Proposal]
The root cause is that there is no strict synchronization of
select_task_rq() and the set of ttwu_pending flag among several CPUs.
And this might be by design because the scheduler prefers parallel
wakeup.

So avoid this problem indirectly. If a system does not have idle cores,
and if the waker and wakee are both short duration tasks, wake up the
wakee on the same CPU as waker.

The reason is that, if the waker is a short-duration task, it might
relinquish the CPU soon, and the wakee has the chance to be scheduled.
On the other hand, if the wakee is a short duration task, putting it on
non-idle CPU would bring minimal impact to the running task. No idle
core in the system indicates that this mechanism should not inhibit
spreading the tasks if the system has idle cores.

[Benchmark results]
The baseline is v6.1-rc8. The test platform has 56 Cores(112 CPUs) per
LLC domain. C-states deeper than C1E are disabled. Turbo is disabled.
CPU frequency governor is performance.

will-it-scale.context_switch1
=============================
+331.13%

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1 group 	 1.00 (  1.50)	 +0.83 (  0.19)
process-pipe    	2 groups 	 1.00 (  0.77)	 +0.82 (  0.52)
process-pipe    	4 groups 	 1.00 (  0.20)	 -2.07 (  2.91)
process-pipe    	8 groups 	 1.00 (  0.05)	 +3.48 (  0.06)
process-sockets 	1 group 	 1.00 (  2.90)	-11.20 ( 11.99)
process-sockets 	2 groups 	 1.00 (  5.42)	 -1.39 (  1.70)
process-sockets 	4 groups 	 1.00 (  0.17)	 -0.20 (  0.19)
process-sockets 	8 groups 	 1.00 (  0.03)	 -0.05 (  0.11)
threads-pipe    	1 group 	 1.00 (  2.09)	 -1.63 (  0.44)
threads-pipe    	2 groups 	 1.00 (  0.28)	 -0.21 (  1.48)
threads-pipe    	4 groups 	 1.00 (  0.27)	 +0.13 (  0.63)
threads-pipe    	8 groups 	 1.00 (  0.14)	 +5.04 (  0.04)
threads-sockets 	1 group 	 1.00 (  2.51)	 -1.86 (  2.08)
threads-sockets 	2 groups 	 1.00 (  1.24)	 -0.60 (  3.83)
threads-sockets 	4 groups 	 1.00 (  0.49)	 +0.07 (  0.46)
threads-sockets 	8 groups 	 1.00 (  0.09)	 -0.04 (  0.08)

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	28-threads	 1.00 (  0.74)	 -1.31 (  0.78)
TCP_RR          	56-threads	 1.00 (  0.60)	 -0.54 (  0.76)
TCP_RR          	84-threads	 1.00 (  0.32)	 -3.22 (  0.30)
TCP_RR          	112-threads	 1.00 (  0.21)	 -4.34 (  0.22)
TCP_RR          	140-threads	 1.00 (  0.19)	+202.56 ( 10.11)
TCP_RR          	168-threads	 1.00 ( 59.37)	+82.78 ( 10.85)
TCP_RR          	196-threads	 1.00 ( 12.89)	 -0.16 ( 13.80)
TCP_RR          	224-threads	 1.00 (  7.14)	 -0.68 (  7.02)
UDP_RR          	28-threads	 1.00 (  1.39)	 +0.26 (  1.13)
UDP_RR          	56-threads	 1.00 ( 10.91)	 +0.80 (  1.14)
UDP_RR          	84-threads	 1.00 (  0.17)	 -4.00 (  0.75)
UDP_RR          	112-threads	 1.00 (  9.53)	 -6.41 (  5.47)
UDP_RR          	140-threads	 1.00 (  6.93)	+146.56 ( 13.58)
UDP_RR          	168-threads	 1.00 ( 13.09)	+156.22 ( 11.81)
UDP_RR          	196-threads	 1.00 ( 19.75)	 +5.75 ( 15.65)
UDP_RR          	224-threads	 1.00 ( 13.90)	 +5.48 ( 14.49)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	28-threads	 1.00 (  0.20)	 -0.24 (  0.51)
loopback        	56-threads	 1.00 (  0.03)	 -0.59 (  0.08)
loopback        	84-threads	 1.00 (  0.11)	 -1.76 (  0.13)
loopback        	112-threads	 1.00 (  0.04)	+161.78 (  0.25)
loopback        	140-threads	 1.00 (  0.14)	 -0.54 (  0.02)
loopback        	168-threads	 1.00 (  0.38)	 -0.33 (  0.21)
loopback        	196-threads	 1.00 (  0.15)	 -0.46 (  0.06)
loopback        	224-threads	 1.00 (  0.08)	 -0.36 (  0.11)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthread	 1.00 (  1.49)	 -3.16 (  5.20)
normal          	2-mthreads	 1.00 (  9.25)	 -1.87 ( 12.97)
normal          	4-mthreads	 1.00 (  4.82)	 -3.91 (  5.92)
normal          	8-mthreads	 1.00 (  0.54)	 +4.14 (  3.28)

In summary, overall there is no significant performance regression detected
and there is a big improvement in netperf/tbench in partially-busy cases.
There should be no impact on schbench in theory, because the default task
duration of schbench is 30 ms.

[Limitations]
As Peter said, the criteria of a short duration task is intuitive, but it
seems to be hard to find an accurate criterion to describe this.

This wake up strategy can be viewed as dynamic WF_SYNC. Except that:
1. Some workloads do not have WF_SYNC set.
2. WF_SYNC does not treat non-idle CPU as candidate target CPU.

Peter has suggested[2] comparing task duration with the cost of searching
for an idle CPU. If the latter is higher, then give up the scan, to
achieve better task affine. However, this method does not fit in the case
encountered in this patch. Because there are plenty of idle CPUs in the
system, it will not take too long to find an idle CPU. The bottleneck is
caused by the race condition mentioned above.

[1] https://lore.kernel.org/lkml/9ed75cad-3718-356f-21ca-1b8ec601f335@linux.alibaba.com/
[2] https://lore.kernel.org/lkml/Y2O8a%2FOhk1i1l8ao@hirez.programming.kicks-ass.net/

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index abdb7a442052..4983c60c1b3f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6259,6 +6259,11 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (available_idle_cpu(prev_cpu))
 		return prev_cpu;
 
+	/* The only running task is a short duration one. */
+	if (cpu_rq(this_cpu)->nr_running == 1 &&
+	    is_short_task(cpu_curr(this_cpu)))
+		return this_cpu;
+
 	return nr_cpumask_bits;
 }
 
@@ -6809,6 +6814,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
+	if (!has_idle_core && cpu_rq(target)->nr_running == 1 &&
+	    is_short_task(cpu_curr(target)) && is_short_task(p))
+		return target;
+
 	i = select_idle_cpu(p, sd, has_idle_core, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
-- 
2.25.1

