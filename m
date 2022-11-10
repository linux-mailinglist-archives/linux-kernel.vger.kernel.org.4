Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810AA6239C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiKJC1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiKJC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:27:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714DE25C51;
        Wed,  9 Nov 2022 18:27:47 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N75Hm3lwfzpWMB;
        Thu, 10 Nov 2022 10:24:04 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:27:45 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:27:44 +0800
Subject: Re: [PATCH v6 0/2] rcu: Add RCU stall diagnosis information
To:     <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
CC:     Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109152621.GB298683@lothringen>
 <20221109155901.GA727034@paulmck-ThinkPad-P17-Gen-1>
 <20221109170317.GA300561@lothringen>
 <20221109172221.GD725751@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a48a3eb1-5fa4-4b6b-f7bf-e0bc589f7bf6@huawei.com>
Date:   Thu, 10 Nov 2022 10:27:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221109172221.GD725751@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



On 2022/11/10 1:22, Paul E. McKenney wrote:
> On Wed, Nov 09, 2022 at 06:03:17PM +0100, Frederic Weisbecker wrote:
>> On Wed, Nov 09, 2022 at 07:59:01AM -0800, Paul E. McKenney wrote:
>>> On Wed, Nov 09, 2022 at 04:26:21PM +0100, Frederic Weisbecker wrote:
>>>> Hi Zhen Lei,
>>>>
>>>> On Wed, Nov 09, 2022 at 05:37:36PM +0800, Zhen Lei wrote:
>>>>> v5 --> v6:
>>>>> 1. When there are more than two continuous RCU stallings, correctly handle the
>>>>>    value of the second and subsequent sampling periods. Update comments and
>>>>>    document.
>>>>>    Thanks to Elliott, Robert for the test.
>>>>> 2. Change "rcu stall" to "RCU stall".
>>>>>
>>>>> v4 --> v5:
>>>>> 1. Resolve a git am conflict. No code change.
>>>>>
>>>>> v3 --> v4:
>>>>> 1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.
>>>>>
>>>>> v2 --> v3:
>>>>> 1. Fix the return type of kstat_cpu_irqs_sum()
>>>>> 2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
>>>>>    rcupdate.rcu_cpu_stall_deep_debug.
>>>>> 3. Add comments and normalize local variable name
>>>>>
>>>>>
>>>>> v1 --> v2:
>>>>> 1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
>>>>>    kcpustat_this_cpu cannot be used.
>>>>> @@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
>>>>>         if (r->gp_seq != rdp->gp_seq)
>>>>>                 return;
>>>>>
>>>>> -       cpustat = kcpustat_this_cpu->cpustat;
>>>>> +       cpustat = kcpustat_cpu(cpu).cpustat;
>>>>> 2. Move the start point of statistics from rcu_stall_kick_kthreads() to
>>>>>    rcu_implicit_dynticks_qs(), removing the dependency on irq_work.
>>>>>
>>>>> v1:
>>>>> In some extreme cases, such as the I/O pressure test, the CPU usage may
>>>>> be 100%, causing RCU stall. In this case, the printed information about
>>>>> current is not useful. Displays the number and usage of hard interrupts,
>>>>> soft interrupts, and context switches that are generated within half of
>>>>> the CPU stall timeout, can help us make a general judgment. In other
>>>>> cases, we can preliminarily determine whether an infinite loop occurs
>>>>> when local_irq, local_bh or preempt is disabled.
>>>>
>>>> That looks useful but I have to ask: what does it bring that the softlockup
>>>> and hardlockup watchdog can not already solve?
>>>
>>> This is a good point.  One possible benefit is putting the needed information
>>> in one spot, for example, in cases where the soft/hard lockup timeouts are
>>> significantly different than the RCU CPU stall warning timeout.
>>
>> Arguably, the hardlockup/softlockup detectors usually trigger after RCU stall,
>> unless all CPUs are caught into a hardlockup, in which case only the hardlockup
>> detector has a chance.
>>
>> Anyway I would say that in this case just lower the delay for the lockup
>> detectors to consider the situation is a lockup?
> 
> Try it both ways and see how it works?  The rcutorture module parameters
> stall_cpu and stall_cpu_irqsoff are easy ways to generate these sorts
> of scenarios.
> 
> Actually, that does remind me of something.  Back when I was chasing
> that interrupt storm, would this patch have helped me?  In that case, the

Yes, this patch series originally addressed an RCU stall issue caused by an
interruption storm. The serial port driver written by another project team
failed to write the register in a specific condition. As a result, interrupts
were repeatedly reported.

> half-way point would have been reached while all online CPUs were spinning
> with interrupts disabled and the incoming CPU was getting hammered with
> continual scheduling-clock interrupts.  So I suspect that the answer is
> "no" because the incoming CPU was not blocking the grace period.
> 
> Instead of being snapshot halfway to the RCU CPU stall warning, should
> the values be snapshot when the CPU notices the beginning or end of an
> RCU grace period and when a CPU goes offline?

This won't work. Those normal counts that occurred before the failure
have an impact on our analysis. For example, some software interrupts
may have been generated before local_bh_disable() is called.

> 
> But that would not suffice, because detailed information would not have
> been dumped for the incoming CPU.
> 
> However, the lack of context switches and interrupts on the rest of the
> CPUs would likely have been a big cluebat, so there is that.  It might
> be better to rework the warning at the beginning of rcu_sched_clock_irq()
> to complain if more than (say) 10 scheduling-clock interrupts occur on
> a given CPU during a single jiffy.
> 
> Independent of Zhen Lei patch.
> 
> Thoughts?
> 
> 							Thanx, Paul
> 
>> Thanks.
>>
>>
>>>
>>> Thoughts?
>>>
>>> 							Thanx, Paul
>>>
>>>> Thanks.
>>>>
>>>>>
>>>>> Zhen Lei (2):
>>>>>   rcu: Add RCU stall diagnosis information
>>>>>   doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
>>>>>
>>>>>  Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
>>>>>  .../admin-guide/kernel-parameters.txt         |  6 ++
>>>>>  kernel/rcu/Kconfig.debug                      | 11 +++
>>>>>  kernel/rcu/rcu.h                              |  1 +
>>>>>  kernel/rcu/tree.c                             | 17 ++++
>>>>>  kernel/rcu/tree.h                             | 19 ++++
>>>>>  kernel/rcu/tree_stall.h                       | 29 ++++++
>>>>>  kernel/rcu/update.c                           |  2 +
>>>>>  8 files changed, 173 insertions(+)
>>>>>
>>>>> -- 
>>>>> 2.25.1
>>>>>
> .
> 

-- 
Regards,
  Zhen Lei
