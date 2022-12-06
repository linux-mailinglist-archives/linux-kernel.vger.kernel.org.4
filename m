Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB76443E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiLFNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiLFNCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:02:19 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3710A10A1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:02:14 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NRL820p7BzJp77;
        Tue,  6 Dec 2022 20:58:42 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 21:02:11 +0800
CC:     <yangyicong@hisilicon.com>, Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
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
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 2/2] sched/fair: Choose the CPU where short task is
 running during wake up
To:     Chen Yu <yu.c.chen@intel.com>
References: <cover.1669862147.git.yu.c.chen@intel.com>
 <0fefba11f59c083256eabff0fbb6c82b9d3bfdf9.1669862147.git.yu.c.chen@intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <c504bc78-364b-e608-d539-c763b6ca84e3@huawei.com>
Date:   Tue, 6 Dec 2022 21:02:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <0fefba11f59c083256eabff0fbb6c82b9d3bfdf9.1669862147.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Yu,

Just some minor questions below.

On 2022/12/1 16:44, Chen Yu wrote:
> [Problem Statement]
> For a workload that is doing frequent context switches, the throughput
> scales well until the number of instances reaches a peak point. After
> that peak point, the throughput drops significantly if the number of
> instances continues to increase.
> 
> The will-it-scale context_switch1 test case exposes the issue. The
> test platform has 112 CPUs per LLC domain. The will-it-scale launches
> 1, 8, 16 ... 112 instances respectively. Each instance is composed
> of 2 tasks, and each pair of tasks would do ping-pong scheduling via
> pipe_read() and pipe_write(). No task is bound to any CPU.
> It is found that, once the number of instances is higher than
> 56(112 tasks in total, every CPU has 1 task), the throughput
> drops accordingly if the instance number continues to increase:
> 
>           ^
> throughput|
>           |                 X
>           |               X   X X
>           |             X         X X
>           |           X               X
>           |         X                   X
>           |       X
>           |     X
>           |   X
>           | X
>           |
>           +-----------------.------------------->
>                             56
>                                  number of instances
> 
> [Symptom analysis]
> 
> The performance downgrading was caused by a high system idle
> percentage(around 20% ~ 30%). The CPUs waste a lot of time in
> idle and do nothing. As a comparison, if set CPU affinity to
> these workloads and stops them from migrating among CPUs,
> the idle percentage drops to nearly 0%, and the throughput
> increases by about 300%. This indicates room for optimization.
> 
> The reason for the high idle percentage is different before/after
> commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU
> on wakelist if wakee cpu is idle").
> 
> [Before the commit]
> The bottleneck is the runqueue spinlock.
> 
> nr_instance          rq lock percentage
> 1                    1.22%
> 8                    1.17%
> 16                   1.20%
> 24                   1.22%
> 32                   1.46%
> 40                   1.61%
> 48                   1.63%
> 56                   1.65%
> --------------------------
> 64                   3.77%      |
> 72                   5.90%      | increase
> 80                   7.95%      |
> 88                   9.98%      v
> 96                   11.81%
> 104                  13.54%
> 112                  15.13%
> 
> And top 2 rq lock hot paths:
> 
> (path1):
> raw_spin_rq_lock_nested.constprop.0;
> try_to_wake_up;
> default_wake_function;
> autoremove_wake_function;
> __wake_up_common;
> __wake_up_common_lock;
> __wake_up_sync_key;
> pipe_write;
> new_sync_write;
> vfs_write;
> ksys_write;
> __x64_sys_write;
> do_syscall_64;
> entry_SYSCALL_64_after_hwframe;write
> 
> (path2):
> raw_spin_rq_lock_nested.constprop.0;
> __sched_text_start;
> schedule_idle;
> do_idle;
> cpu_startup_entry;
> start_secondary;
> secondary_startup_64_no_verify
> 
> task A tries to wake up task B on CPU1, then task A grabs the
> runqueue lock of CPU1. If CPU1 is about to quit idle, it needs
> to grab its lock which has been taken by someone else. Then
> CPU1 takes more time to quit which hurts the performance.
> 
> [After the commit]
> The cause is the race condition between select_task_rq() and
> the task enqueue.
> 
> Suppose there are nr_cpus pairs of ping-pong scheduling
> tasks. For example, p0' and p0 are ping-pong scheduling,
> so do p1' <=> p1, and p2'<=> p2. None of these tasks are
> bound to any CPUs. The problem can be summarized as:
> more than 1 wakers are stacked on 1 CPU, which slows down
> waking up their wakees:
> 
> CPU0					CPU1				CPU2
> 
> p0'					p1' => idle			p2'
> 
> try_to_wake_up(p0)							try_to_wake_up(p2);
> CPU1 = select_task_rq(p0);						CPU1 = select_task_rq(p2);
> ttwu_queue(p0, CPU1);							ttwu_queue(p2, CPU1);
>   __ttwu_queue_wakelist(p0, CPU1); =>	ttwu_list->p0
> 					quiting cpuidle_idle_call()
> 
> 					ttwu_list->p2->p0	<=	  __ttwu_queue_wakelist(p2, CPU1);
> 
>     WRITE_ONCE(CPU1->ttwu_pending, 1);					    WRITE_ONCE(CPU1->ttwu_pending, 1);
> 
> p0' => idle
> 					sched_ttwu_pending()
> 					  enqueue_task(p2 and p0)
> 
> 					idle => p2
> 
> 					...
> 					p2 time slice expires
> 					...
> 									!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> 								<===	!!! p2 delays the wake up of p0' !!!
> 									!!! causes long idle on CPU0     !!!
> 					p2 => p0			!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> 					p0 wakes up p0'
> 
> idle => p0'
> 
> 
> 
> Since there are many waker/wakee pairs in the system, the chain reaction
> causes many CPUs to be victims. These idle CPUs wait for their waker to
> be scheduled.
> 
> Actually Tiancheng has mentioned above issue here[2].
> 
> [Proposal]
> The root cause is that there is no strict synchronization of select_task_rq()
> and the set of ttwu_pending flag among several CPUs. And this might be by
> design because the scheduler prefers parallel wakeup.
> 
> So avoid this problem indirectly. If a system does not have idle cores,
> and if the waker and wakee are both short duration tasks, wake up the wakee on
> the same CPU as waker.
> 
> The reason is that, if the waker is a short-duration task, it might
> relinquish the CPU soon, and the wakee has the chance to be scheduled.
> On the other hand, if the wakee is a short duration task, putting it on
> non-idle CPU would bring minimal impact to the running task. No idle
> core in the system indicates that this mechanism should not inhibit
> spreading the tasks if the system have idle core.
> 
> [Benchmark results]
> The baseline is v6.1-rc6. The test platform has 56 Cores(112 CPUs) per
> LLC domain. C-states deeper than C1E are disabled. Turbo is disabled.
> CPU frequency governor is performance.
> 
> will-it-scale.context_switch1
> =============================
> +331.13%
> 
> hackbench
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1 group 	 1.00 (  1.50)	 +0.83 (  0.19)
> process-pipe    	2 groups 	 1.00 (  0.77)	 +0.82 (  0.52)
> process-pipe    	4 groups 	 1.00 (  0.20)	 -2.07 (  2.91)
> process-pipe    	8 groups 	 1.00 (  0.05)	 +3.48 (  0.06)
> process-sockets 	1 group 	 1.00 (  2.90)	-11.20 ( 11.99)
> process-sockets 	2 groups 	 1.00 (  5.42)	 -1.39 (  1.70)
> process-sockets 	4 groups 	 1.00 (  0.17)	 -0.20 (  0.19)
> process-sockets 	8 groups 	 1.00 (  0.03)	 -0.05 (  0.11)
> threads-pipe    	1 group 	 1.00 (  2.09)	 -1.63 (  0.44)
> threads-pipe    	2 groups 	 1.00 (  0.28)	 -0.21 (  1.48)
> threads-pipe    	4 groups 	 1.00 (  0.27)	 +0.13 (  0.63)
> threads-pipe    	8 groups 	 1.00 (  0.14)	 +5.04 (  0.04)
> threads-sockets 	1 group 	 1.00 (  2.51)	 -1.86 (  2.08)
> threads-sockets 	2 groups 	 1.00 (  1.24)	 -0.60 (  3.83)
> threads-sockets 	4 groups 	 1.00 (  0.49)	 +0.07 (  0.46)
> threads-sockets 	8 groups 	 1.00 (  0.09)	 -0.04 (  0.08)
> 
> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	28 threads	 1.00 (  0.81)	 -0.13 (  0.80)
> TCP_RR          	56 threads	 1.00 (  0.55)	 +0.03 (  0.64)
> TCP_RR          	84 threads	 1.00 (  0.33)	 +1.74 (  0.31)
> TCP_RR          	112 threads	 1.00 (  0.24)	 +3.71 (  0.23)
> TCP_RR          	140 threads	 1.00 (  0.21)	+215.10 ( 12.37)
> TCP_RR          	168 threads	 1.00 ( 61.97)	+86.15 ( 12.26)
> TCP_RR          	196 threads	 1.00 ( 14.49)	 +0.71 ( 14.20)
> TCP_RR          	224 threads	 1.00 (  9.54)	 +0.68 (  7.00)
> UDP_RR          	28 threads	 1.00 (  1.51)	 +0.25 (  1.02)
> UDP_RR          	56 threads	 1.00 (  7.90)	 +0.57 (  7.89)
> UDP_RR          	84 threads	 1.00 (  6.38)	 +3.66 ( 20.77)
> UDP_RR          	112 threads	 1.00 ( 10.15)	 +3.16 ( 11.87)
> UDP_RR          	140 threads	 1.00 (  9.98)	+164.29 ( 12.55)
> UDP_RR          	168 threads	 1.00 ( 10.72)	+174.41 ( 17.05)
> UDP_RR          	196 threads	 1.00 ( 18.84)	 +3.92 ( 15.48)
> UDP_RR          	224 threads	 1.00 ( 16.97)	 +2.98 ( 16.69)
> 
> tbench
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	28 threads	 1.00 (  0.12)	 -0.38 (  0.35)
> loopback        	56 threads	 1.00 (  0.17)	 -0.04 (  0.19)
> loopback        	84 threads	 1.00 (  0.03)	 +0.95 (  0.07)
> loopback        	112 threads	 1.00 (  0.03)	+162.42 (  0.05)
> loopback        	140 threads	 1.00 (  0.14)	 -2.26 (  0.14)
> loopback        	168 threads	 1.00 (  0.49)	 -2.15 (  0.54)
> loopback        	196 threads	 1.00 (  0.06)	 -2.38 (  0.22)
> loopback        	224 threads	 1.00 (  0.20)	 -1.95 (  0.30)
> 
> schbench
> ========
> case            	load    	baseline(std%)	compare%( std%)
> normal          	1 mthread	 1.00 (  1.46)	 +1.03 (  0.00)
> normal          	2 mthreads	 1.00 (  3.82)	 -5.41 (  8.37)
> normal          	4 mthreads	 1.00 (  1.03)	 +5.11 (  2.88)
> normal          	8 mthreads	 1.00 (  2.96)	 -2.41 (  0.93)
> 
> In summary, overall there is no significant performance regression detected
> and there is a big improvement in netperf/tbench in partially-busy cases.
> 
> [Limitations]
> As Peter said, the criteria of a short duration task is intuitive, but it
> seems to be hard to find an accurate criterion to describe this.
> 
> This wake up strategy can be viewed as dynamic WF_SYNC. Except that:
> 1. Some workloads do not have WF_SYNC set.
> 2. WF_SYNC does not treat non-idle CPU as candidate target CPU.
> 
> Peter has suggested[1] comparing task duration with the cost of searching
> for an idle CPU. If the latter is higher, then give up the scan, to
> achieve better task affine. However, this method does not fit in the case
> encountered in this patch. Because there are plenty of idle CPUs in the system,
> it will not take too long to find an idle CPU. The bottleneck is caused by the
> race condition mentioned above.
> 
> [1] https://lore.kernel.org/lkml/Y2O8a%2FOhk1i1l8ao@hirez.programming.kicks-ass.net/
> [2] https://lore.kernel.org/lkml/9ed75cad-3718-356f-21ca-1b8ec601f335@linux.alibaba.com/
> 
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a4b314b664f8..3f7361ec1330 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6246,6 +6246,11 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>  	if (available_idle_cpu(prev_cpu))
>  		return prev_cpu;
>  
> +	/* The only running task is a short duration one. */
> +	if (cpu_rq(this_cpu)->nr_running == 1 &&
> +	    is_short_task((struct task_struct *)cpu_curr(this_cpu)))
> +		return this_cpu;
> +

Is it necessary to check the ttwu pending state here and below?

>  	return nr_cpumask_bits;
>  }
>  
> @@ -6612,6 +6617,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		time = cpu_clock(this);
>  	}
>  
> +	if (!has_idle_core && cpu_rq(target)->nr_running == 1 &&
> +	    is_short_task((struct task_struct *)cpu_curr(target)) &&
> +	    is_short_task(p))
> +		return target;
> +

A short running task doesn't means a low utilization (you also mentioned in Patch 1/2).
So should we concern that we may overload the target?

btw, we're doing no scanning here so I may think it'll be more consistent to put this part
in select_idle_siblings(), considering we've already have some similiar judgement for the
prev_cpu, recent_used_cpu, etc. there.

Still doing some test, will reply the results once I get them.

Thanks,
Yicong

>  	if (sched_feat(SIS_UTIL)) {
>  		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
>  		if (sd_share) {
> 
