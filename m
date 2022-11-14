Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296C9627DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbiKNMc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbiKNMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:32:25 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DCE23149;
        Mon, 14 Nov 2022 04:32:23 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9pbD0DbSzHvqf;
        Mon, 14 Nov 2022 20:31:52 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 20:32:21 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 20:32:20 +0800
Subject: Re: [PATCH v7 4/6] rcu: Add RCU stall diagnosis information
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-5-thunder.leizhen@huawei.com>
 <20221114112438.GA472998@lothringen>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5f73bb77-e334-d604-d0cd-0ce7af45f209@huawei.com>
Date:   Mon, 14 Nov 2022 20:32:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221114112438.GA472998@lothringen>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/14 19:24, Frederic Weisbecker wrote:
> On Fri, Nov 11, 2022 at 09:07:07PM +0800, Zhen Lei wrote:
>> Because RCU CPU stall warnings are driven from the scheduling-clock
>> interrupt handler, a workload consisting of a very large number of
>> short-duration hardware interrupts can result in misleading stall-warning
>> messages.  On systems supporting only a single level of interrupts,
>> that is, where interrupts handlers cannot be interrupted, this can
>> produce misleading diagnostics.  The stack traces will show the
>> innocent-bystander interrupted task, not the interrupts that are
>> at the very least exacerbating the stall.
>>
>> This situation can be improved by displaying the number of interrupts
>> and the CPU time that they have consumed.  Diagnosing other types
>> of stalls can be eased by also providing the count of softirqs and
>> the CPU time that they consumed as well as the number of context
>> switches and the task-level CPU time consumed.
>>
>> Consider the following output given this change:
>>
>> rcu: INFO: rcu_preempt self-detected stall on CPU
>> rcu:     0-....: (1250 ticks this GP) <omitted>
>> rcu:          hardirqs   softirqs   csw/system
>> rcu:  number:      624         45            0
>> rcu: cputime:       69          1         2425   ==> 2500(ms)
>>
>> This output shows that the number of hard and soft interrupts is small,
>> there are no context switches, and the system takes up a lot of time. This
>> indicates that the current task is looping with preemption disabled.
>>
>> The impact on system performance is negligible because snapshot is
>> recorded only once for all continuous RCU stalls.
>>
>> This added debugging information is suppressed by default and can be
>> enabled by building the kernel with CONFIG_RCU_CPU_STALL_CPUTIME=y or
>> by booting with rcupdate.rcu_cpu_stall_cputime=1.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  6 ++++
>>  kernel/rcu/Kconfig.debug                      | 11 +++++++
>>  kernel/rcu/rcu.h                              |  1 +
>>  kernel/rcu/tree.c                             | 18 +++++++++++
>>  kernel/rcu/tree.h                             | 19 ++++++++++++
>>  kernel/rcu/tree_stall.h                       | 31 +++++++++++++++++++
>>  kernel/rcu/update.c                           |  2 ++
>>  7 files changed, 88 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 811b2e6d4672685..ee7d9d962591c5d 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5084,6 +5084,12 @@
>>  			rcupdate.rcu_cpu_stall_timeout to be used (after
>>  			conversion from seconds to milliseconds).
>>  
>> +	rcupdate.rcu_cpu_stall_cputime= [KNL]
>> +			Provide statistics on the cputime and count of
>> +			interrupts and tasks during the sampling period. For
>> +			multiple continuous RCU stalls, all sampling periods
>> +			begin at half of the first RCU stall timeout.
>> +
>>  	rcupdate.rcu_expedited= [KNL]
>>  			Use expedited grace-period primitives, for
>>  			example, synchronize_rcu_expedited() instead
>> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
>> index 1b0c41d490f0588..025566a9ba44667 100644
>> --- a/kernel/rcu/Kconfig.debug
>> +++ b/kernel/rcu/Kconfig.debug
>> @@ -95,6 +95,17 @@ config RCU_EXP_CPU_STALL_TIMEOUT
>>  	  says to use the RCU_CPU_STALL_TIMEOUT value converted from
>>  	  seconds to milliseconds.
>>  
>> +config RCU_CPU_STALL_CPUTIME
>> +	bool "Provide additional RCU stall debug information"
>> +	depends on RCU_STALL_COMMON
>> +	default n
>> +	help
>> +	  Collect statistics during the sampling period, such as the number of
>> +	  (hard interrupts, soft interrupts, task switches) and the cputime of
>> +	  (hard interrupts, soft interrupts, kernel tasks) are added to the
>> +	  RCU stall report. For multiple continuous RCU stalls, all sampling
>> +	  periods begin at half of the first RCU stall timeout.
>> +
>>  config RCU_TRACE
>>  	bool "Enable tracing for RCU"
>>  	depends on DEBUG_KERNEL
>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>> index 96122f203187f39..4844dec36bddb48 100644
>> --- a/kernel/rcu/rcu.h
>> +++ b/kernel/rcu/rcu.h
>> @@ -231,6 +231,7 @@ extern int rcu_cpu_stall_ftrace_dump;
>>  extern int rcu_cpu_stall_suppress;
>>  extern int rcu_cpu_stall_timeout;
>>  extern int rcu_exp_cpu_stall_timeout;
>> +extern int rcu_cpu_stall_cputime;
>>  int rcu_jiffies_till_stall_check(void);
>>  int rcu_exp_jiffies_till_stall_check(void);
>>  
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index ed93ddb8203d42c..3921aacfd421ba9 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -866,6 +866,24 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>>  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
>>  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
>>  		}
>> +
>> +		if (rcu_cpu_stall_cputime && rdp->snap_record.gp_seq != rdp->gp_seq) {
>> +			int cpu = rdp->cpu;
>> +			struct rcu_snap_record *rsrp;
>> +			struct kernel_cpustat *kcsp;
>> +
>> +			kcsp = &kcpustat_cpu(cpu);
>> +
>> +			rsrp = &rdp->snap_record;
>> +			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
>> +			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
>> +			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
>> +			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
>> +			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
> 
> Getting the sum of all CPU's IRQs, with even two iterations on all of them, look
> costly. So I have to ask: why is this information useful and why can't we deduce
> it from other CPUs stall reports?

Only the RCU stalled CPUs are recorded. Why all CPUs?

static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
{
	rcu_for_each_leaf_node(rnp) {
		if (rnp->qsmask == 0) {
			continue;
		}
		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
			if (f(rdp))

> 
> I'm also asking because this rcu_cpu_stall_cputime is likely to be very useful for
> distros, to the point that I expect it to be turned on by default as doing a
> snapshot of kcpustat fields is cheap. But doing that wide CPU snapshot is
> definetly going to be an unbearable overhead.

I purposely added a print test, only the RCU stalled CPU would be taken snapshots and
calculated differentials.

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d1f0d857dc85df5..693e7c83bd17d1e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -872,6 +872,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
                        struct rcu_snap_record *rsrp;
                        struct kernel_cpustat *kcsp;

+                       printk("fixme: cpu=%d\n", smp_processor_id());
                        kcsp = &kcpustat_cpu(cpu);

                        rsrp = &rdp->snap_record;

> 
> Thanks.
> .
> 

-- 
Regards,
  Zhen Lei
