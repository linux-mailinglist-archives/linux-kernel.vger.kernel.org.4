Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE16609469
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJWPdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJWPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:33:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0702A760F5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666539198; x=1698075198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IpbO5SkXYoDjW3gNw2zKcEzfXLKkirQXFwEG0TXP5wg=;
  b=lTNULwkRl+8gOpWPqk6PKbDw83pnVjNn/Gdg1J3X+0Ty3DX7YMvqPsXB
   UmO8M4AfaKwbDrzm1M6NAKFNIWqn1j0+fsxAkRTCL8ZrYSjtXfp8CqGnQ
   JAHBl6L7UAeg0rXD/8Ll3G6hMDLKFIdbYB3eivExX2IQSJQ4gdQWgN7qM
   kF2nppQ7aRwlfrf6HnZ4Fb4jccJeP5H7PIcy+6wNa1+aeajhM51r0pVck
   UO9++iz8yGYWxEheM/KmSUHyNvVamPTdV9XjE6UQ/48hGniKiz+kz/34z
   JsmsLkkKqKzrTpy3YB5X/JOjcU+Agfin0kiurZ5pvGe3OIEwBbz13P5in
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="308370739"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="308370739"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 08:33:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="756329739"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="756329739"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2022 08:33:12 -0700
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
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH v2 2/2] sched/fair: Choose the CPU where short task is running during wake up
Date:   Sun, 23 Oct 2022 23:33:39 +0800
Message-Id: <1a34e009de0dbe5900c7b2c6074c8e0c04e8596a.1666531576.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666531576.git.yu.c.chen@intel.com>
References: <cover.1666531576.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Both perf profile and lockstat have shown that, the bottleneck
is the runqueue spinlock. Take perf profile for example:

nr_instance          rq lock percentage
1                    1.22%
8                    1.17%
16                   1.20%
24                   1.22%
32                   1.46%
40                   1.61%
48                   1.63%
56                   1.65%
--------------------------
64                   3.77%      |
72                   5.90%      | increase
80                   7.95%      |
88                   9.98%      v
96                   11.81%
104                  13.54%
112                  15.13%

And the rq lock bottleneck is composed of two paths(perf profile):

(path1):
raw_spin_rq_lock_nested.constprop.0;
try_to_wake_up;
default_wake_function;
autoremove_wake_function;
__wake_up_common;
__wake_up_common_lock;
__wake_up_sync_key;
pipe_write;
new_sync_write;
vfs_write;
ksys_write;
__x64_sys_write;
do_syscall_64;
entry_SYSCALL_64_after_hwframe;write

(path2):
raw_spin_rq_lock_nested.constprop.0;
__sched_text_start;
schedule_idle;
do_idle;
cpu_startup_entry;
start_secondary;
secondary_startup_64_no_verify

The idle percentage is around 30% when there are 112 instances:
%Cpu0  :  2.7 us, 66.7 sy,  0.0 ni, 30.7 id

As a comparison, if set CPU affinity to these workloads,
which stops them from migrating among CPUs, the idle percentage
drops to nearly 0%, and the throughput increases by about 300%.
This indicates that there is room for optimization.

A possible scenario to describe the lock contention:
task A tries to wakeup task B on CPU1, then task A grabs the
runqueue lock of CPU1. If CPU1 is about to quit idle, it needs
to grab its own lock which has been taken by someone else. Then
CPU1 takes more time to quit which hurts the performance.

TTWU_QUEUE could mitigate the cross CPU runqueue lock contention.
Since commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU
on wakelist if wakee cpu is idle"), TTWU_QUEUE offloads the work from
the waker and leverages the idle CPU to queue the wakee. However, a long
idle duration is still observed. The idle task spends quite some time
on sched_ttwu_pending() before it switches out. This long idle
duration would mislead SIS_UTIL, then SIS_UTIL suggests the waker scan
for more CPUs. The time spent searching for an idle CPU would make
wakee waiting for more time, which in turn leads to more idle time.
The NEWLY_IDLE balance fails to pull tasks to the idle CPU, which
might be caused by no runnable wakee being found.

[Proposal]
If a system is busy, and if the workloads are doing frequent context
switches, it might not be a good idea to spread the wakee on different
CPUs. Instead, consider the task running time and enhance wake affine
might be applicable.

This idea has been suggested by Rik at LPC 2019 when discussing
the latency nice. He asked the following question: if P1 is a small-time
slice task on CPU, can we put the waking task P2 on the CPU and wait for
P1 to release the CPU, without wasting time searching for an idle CPU?
At LPC 2021 Vincent Guittot has proposed:
1. If the wakee is a long-running task, should we skip the short idle CPU?
2. If the wakee is a short-running task, can we put it onto a lightly
   loaded local CPU?

Inspired by this, if the target CPU is running a short task, and the task
is the only runnable task on target CPU, then the target CPU could be
chosen as the candidate when the system is busy.

The definition of a short task is: The average duration of the task
in each run is no more than sysctl_sched_min_granularity.
If a task switches in and then voluntarily relinquishes the CPU
quickly, it is regarded as a short task. Choosing
sysctl_sched_min_granularity because it is the minimal slice if there
are too many runnable tasks.

Reuse the nr_idle_scan of SIS_UTIL to decide if the system is busy.
If yes, then a compromised "idle" CPU might be acceptable.

The reason is that, if the waker is a short-duration task, it might
relinquish the CPU soon, and the wakee has the chance to be scheduled.
The effect is, the wake affine is enhanced. But this strategy should
only take effect when the system is busy. Otherwise, it could
inhibit spreading the workload when there are many idle CPUs
around, as Peter mentioned.

[Benchmark results]
The baseline is v6.0. The test platform has 56 Cores(112 CPUs) per
LLC domain. First tested with SNC(Sub-Numa-Cluser) disabled,
then with SNC4 enabled(each Cluster has 28 CPUs), to evaluate
the impact on small LLC domain.

  [SNC disabled]
The throughput of will-it-scale.context_switch1 has been increased by
331.13% with this patch applied.

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	28 threads	 1.00 (  0.61)	 -0.38 (  0.66)
TCP_RR          	56 threads	 1.00 (  0.51)	 -0.11 (  0.52)
TCP_RR          	84 threads	 1.00 (  0.30)	 -0.98 (  0.28)
TCP_RR          	112 threads	 1.00 (  0.22)	 -1.07 (  0.21)
TCP_RR          	140 threads	 1.00 (  0.19)	+185.34 (  9.21)
TCP_RR          	168 threads	 1.00 (  0.17)	+195.31 (  9.48)
TCP_RR          	196 threads	 1.00 ( 13.32)	 +0.17 ( 13.39)
TCP_RR          	224 threads	 1.00 (  8.81)	 +0.50 (  7.18)
UDP_RR          	28 threads	 1.00 (  0.94)	 -0.56 (  1.03)
UDP_RR          	56 threads	 1.00 (  0.82)	 -0.67 (  0.83)
UDP_RR          	84 threads	 1.00 (  0.15)	 -2.34 (  0.71)
UDP_RR          	112 threads	 1.00 (  5.54)	 -2.92 (  8.35)
UDP_RR          	140 threads	 1.00 (  4.90)	+139.71 ( 14.04)
UDP_RR          	168 threads	 1.00 ( 10.56)	+151.51 ( 11.16)
UDP_RR          	196 threads	 1.00 ( 18.68)	 -4.32 ( 16.22)
UDP_RR          	224 threads	 1.00 ( 12.84)	 -4.56 ( 14.15)

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1 group 	 1.00 (  1.21)	 -1.06 (  0.59)
process-pipe    	2 groups 	 1.00 (  1.35)	 -1.21 (  0.69)
process-pipe    	4 groups 	 1.00 (  0.36)	 -0.68 (  0.15)
process-pipe    	8 groups 	 1.00 (  0.06)	 +2.24 (  0.14)
process-sockets 	1 group 	 1.00 (  1.04)	 +2.69 (  1.18)
process-sockets 	2 groups 	 1.00 (  2.12)	 +0.48 (  1.80)
process-sockets 	4 groups 	 1.00 (  0.10)	 -2.30 (  0.09)
process-sockets 	8 groups 	 1.00 (  0.04)	 -1.84 (  0.06)
threads-pipe    	1 group 	 1.00 (  0.47)	 -0.70 (  1.13)
threads-pipe    	2 groups 	 1.00 (  0.32)	 +0.15 (  0.66)
threads-pipe    	4 groups 	 1.00 (  0.64)	 -0.26 (  0.69)
threads-pipe    	8 groups 	 1.00 (  0.04)	 +3.99 (  0.04)
threads-sockets 	1 group 	 1.00 (  1.39)	 -5.40 (  2.07)
threads-sockets 	2 groups 	 1.00 (  0.79)	 -1.32 (  2.07)
threads-sockets 	4 groups 	 1.00 (  0.23)	 -2.08 (  0.08)
threads-sockets 	8 groups 	 1.00 (  0.05)	 -1.84 (  0.03)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	28 threads	 1.00 (  0.12)	 -0.45 (  0.09)
loopback        	56 threads	 1.00 (  0.34)	 -0.29 (  0.10)
loopback        	84 threads	 1.00 (  0.06)	 -0.36 (  0.05)
loopback        	112 threads	 1.00 (  0.05)	 +0.19 (  0.05)
loopback        	140 threads	 1.00 (  0.28)	 -4.02 (  0.10)
loopback        	168 threads	 1.00 (  0.31)	 -3.36 (  0.33)
loopback        	196 threads	 1.00 (  0.25)	 -2.91 (  0.28)
loopback        	224 threads	 1.00 (  0.15)	 -3.42 (  0.22)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1 mthread	 1.00 (  0.00)	+28.40 (  0.00)
normal          	2 mthreads	 1.00 (  0.00)	 +8.20 (  0.00)
normal          	4 mthreads	 1.00 (  0.00)	 +7.58 (  0.00)
normal          	8 mthreads	 1.00 (  0.00)	 -3.91 (  0.00)

  [SNC4 enabled]
Each LLC domain now has 14 Cores/28 CPUs.

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	28 threads	 1.00 (  2.92)	 +0.21 (  2.48)
TCP_RR          	56 threads	 1.00 (  1.48)	 -0.15 (  1.49)
TCP_RR          	84 threads	 1.00 (  1.82)	 +3.29 (  2.00)
TCP_RR          	112 threads	 1.00 ( 25.85)	+126.43 (  0.74)
TCP_RR          	140 threads	 1.00 (  6.01)	 -0.20 (  6.38)
TCP_RR          	168 threads	 1.00 (  7.21)	 -0.13 (  7.31)
TCP_RR          	196 threads	 1.00 ( 12.60)	 -0.28 ( 12.49)
TCP_RR          	224 threads	 1.00 ( 12.53)	 -0.29 ( 12.35)
UDP_RR          	28 threads	 1.00 (  2.29)	 -0.69 (  1.65)
UDP_RR          	56 threads	 1.00 (  0.86)	 -1.30 (  7.79)
UDP_RR          	84 threads	 1.00 (  6.56)	 +3.11 ( 10.79)
UDP_RR          	112 threads	 1.00 (  5.74)	+132.30 (  6.80)
UDP_RR          	140 threads	 1.00 ( 12.85)	 -6.79 (  8.45)
UDP_RR          	168 threads	 1.00 ( 13.23)	 -6.69 (  9.44)
UDP_RR          	196 threads	 1.00 ( 14.86)	 -7.59 ( 17.78)
UDP_RR          	224 threads	 1.00 ( 13.84)	 -7.01 ( 14.75)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	28 threads	 1.00 (  0.27)	 -0.80 (  0.33)
loopback        	56 threads	 1.00 (  0.59)	 +0.18 (  0.53)
loopback        	84 threads	 1.00 (  0.23)	 +2.63 (  0.48)
loopback        	112 threads	 1.00 (  1.50)	 +6.56 (  0.28)
loopback        	140 threads	 1.00 (  0.35)	 +3.77 (  1.67)
loopback        	168 threads	 1.00 (  0.69)	 +4.86 (  0.12)
loopback        	196 threads	 1.00 (  0.91)	 +3.95 (  0.34)
loopback        	224 threads	 1.00 (  0.26)	 +4.15 (  0.06)

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1 group 	 1.00 (  1.30)	 +0.52 (  0.32)
process-pipe    	2 groups 	 1.00 (  1.26)	 +2.20 (  1.42)
process-pipe    	4 groups 	 1.00 (  2.60)	 -4.01 (  1.31)
process-pipe    	8 groups 	 1.00 (  1.01)	 +0.58 (  1.26)
process-sockets 	8 groups 	 1.00 (  2.98)	 -2.06 (  1.54)
process-sockets 	2 groups 	 1.00 (  0.62)	 -1.56 (  0.19)
process-sockets 	4 groups 	 1.00 (  1.88)	 +0.57 (  0.99)
process-sockets 	8 groups 	 1.00 (  0.23)	 -0.60 (  0.17)
threads-pipe    	1 group 	 1.00 (  0.68)	 +1.27 (  0.39)
threads-pipe    	2 groups 	 1.00 (  1.56)	 +0.85 (  2.82)
threads-pipe    	4 groups 	 1.00 (  3.16)	 +0.26 (  1.72)
threads-pipe    	8 groups 	 1.00 (  1.03)	 +2.28 (  0.95)
threads-sockets 	1 group 	 1.00 (  1.68)	 -1.41 (  3.78)
threads-sockets 	2 groups 	 1.00 (  0.13)	 -1.70 (  0.88)
threads-sockets 	4 groups 	 1.00 (  5.48)	 -4.99 (  2.66)
threads-sockets 	8 groups 	 1.00 (  0.06)	 -0.41 (  0.10)

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1 mthread	 1.00 (  0.00)	 -7.81 (  0.00)*
normal          	2 mthreads	 1.00 (  0.00)	 +6.25 (  0.00)
normal          	4 mthreads	 1.00 (  0.00)	+22.50 (  0.00)
normal          	8 mthreads	 1.00 (  0.00)	 +6.99 (  0.00)

In summary, overall there is no significant performance regression detected
and there is improvement in some cases. The schbench result is quite
unstable when there is 1 mthread so the -7.81 regress might not be valid.
Other than that, netperf and schbench have shown improvement in the
partially-busy case.

This patch is more about enhancing the wake affine, rather than improving
the SIS efficiency, so Mel's SIS statistic patch was not deployed.

[Limitations]
When the number of CPUs suggested by SIS_UTIL is lower than 60% of the LLC
CPUs, the LLC domain is regarded as relatively busy. However, the 60% is
somewhat arbitrary, because it indicates that the util_avg% is around 50%,
a half busy LLC. I don't have other lightweight/accurate method in mind to
check if the LLC domain is busy or not. By far the test result looks good.

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8820d0d14519..3a8ee6232c59 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6249,6 +6249,11 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (available_idle_cpu(prev_cpu))
 		return prev_cpu;
 
+	/* The only running task is a short duration one. */
+	if (cpu_rq(this_cpu)->nr_running == 1 &&
+	    is_short_task(cpu_curr(this_cpu)))
+		return this_cpu;
+
 	return nr_cpumask_bits;
 }
 
@@ -6623,6 +6628,23 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 			/* overloaded LLC is unlikely to have idle cpu/core */
 			if (nr == 1)
 				return -1;
+
+			/*
+			 * If nr is smaller than 60% of llc_weight, it
+			 * indicates that the util_avg% is higher than 50%.
+			 * This is calculated by SIS_UTIL in
+			 * update_idle_cpu_scan(). The 50% util_avg indicates
+			 * a half-busy LLC domain. System busier than this
+			 * level could lower its bar to choose a compromised
+			 * "idle" CPU, so as to avoid the overhead of cross
+			 * CPU wakeup. If the task on target CPU is a short
+			 * duration one, and it is the only running task, pick
+			 * target directly.
+			 */
+			if (!has_idle_core && (5 * nr < 3 * sd->span_weight) &&
+			    cpu_rq(target)->nr_running == 1 &&
+			    is_short_task(cpu_curr(target)))
+				return target;
 		}
 	}
 
-- 
2.25.1

