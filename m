Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD92623CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiKJH3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiKJH3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:29:12 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143F3326C4;
        Wed,  9 Nov 2022 23:29:07 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7D3D3kjyzHvpN;
        Thu, 10 Nov 2022 15:28:40 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 15:29:06 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 15:29:05 +0800
Subject: Re: [PATCH v6 0/2] rcu: Add RCU stall diagnosis information
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
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
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c8b7deaa-1d4f-0e73-269a-32d6105b89a7@huawei.com>
Date:   Thu, 10 Nov 2022 15:29:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221109170317.GA300561@lothringen>
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



On 2022/11/10 1:03, Frederic Weisbecker wrote:
> On Wed, Nov 09, 2022 at 07:59:01AM -0800, Paul E. McKenney wrote:
>> On Wed, Nov 09, 2022 at 04:26:21PM +0100, Frederic Weisbecker wrote:
>>> Hi Zhen Lei,
>>>
>>> On Wed, Nov 09, 2022 at 05:37:36PM +0800, Zhen Lei wrote:
>>>> v5 --> v6:
>>>> 1. When there are more than two continuous RCU stallings, correctly handle the
>>>>    value of the second and subsequent sampling periods. Update comments and
>>>>    document.
>>>>    Thanks to Elliott, Robert for the test.
>>>> 2. Change "rcu stall" to "RCU stall".
>>>>
>>>> v4 --> v5:
>>>> 1. Resolve a git am conflict. No code change.
>>>>
>>>> v3 --> v4:
>>>> 1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.
>>>>
>>>> v2 --> v3:
>>>> 1. Fix the return type of kstat_cpu_irqs_sum()
>>>> 2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
>>>>    rcupdate.rcu_cpu_stall_deep_debug.
>>>> 3. Add comments and normalize local variable name
>>>>
>>>>
>>>> v1 --> v2:
>>>> 1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
>>>>    kcpustat_this_cpu cannot be used.
>>>> @@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
>>>>         if (r->gp_seq != rdp->gp_seq)
>>>>                 return;
>>>>
>>>> -       cpustat = kcpustat_this_cpu->cpustat;
>>>> +       cpustat = kcpustat_cpu(cpu).cpustat;
>>>> 2. Move the start point of statistics from rcu_stall_kick_kthreads() to
>>>>    rcu_implicit_dynticks_qs(), removing the dependency on irq_work.
>>>>
>>>> v1:
>>>> In some extreme cases, such as the I/O pressure test, the CPU usage may
>>>> be 100%, causing RCU stall. In this case, the printed information about
>>>> current is not useful. Displays the number and usage of hard interrupts,
>>>> soft interrupts, and context switches that are generated within half of
>>>> the CPU stall timeout, can help us make a general judgment. In other
>>>> cases, we can preliminarily determine whether an infinite loop occurs
>>>> when local_irq, local_bh or preempt is disabled.
>>>
>>> That looks useful but I have to ask: what does it bring that the softlockup
>>> and hardlockup watchdog can not already solve?
>>
>> This is a good point.  One possible benefit is putting the needed information
>> in one spot, for example, in cases where the soft/hard lockup timeouts are
>> significantly different than the RCU CPU stall warning timeout.
> 
> Arguably, the hardlockup/softlockup detectors usually trigger after RCU stall,
> unless all CPUs are caught into a hardlockup, in which case only the hardlockup
> detector has a chance.

But not all ARCHs support hardlockup, such as s390. Maybe arm64.

config HARDLOCKUP_DETECTOR
        bool "Detect Hard Lockups"
        depends on DEBUG_KERNEL && !S390
        depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_ARCH

> 
> Anyway I would say that in this case just lower the delay for the lockup
> detectors to consider the situation is a lockup?

In most architectures, CONFIG_SOFTLOCKUP_DETECTOR is not set by default.
Otherwise 20 is less than 21.

Softlockups are bugs that cause the kernel to loop in kernel
mode for more than 20 seconds, without giving other tasks a
chance to run.

config RCU_CPU_STALL_TIMEOUT
	default 21


In short, hardlockup and softlockup are completely uncontrollable to RCU stall.

> 
> Thanks.
> 
> 
>>
>> Thoughts?
>>
>> 							Thanx, Paul
>>
>>> Thanks.
>>>
>>>>
>>>> Zhen Lei (2):
>>>>   rcu: Add RCU stall diagnosis information
>>>>   doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
>>>>
>>>>  Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
>>>>  .../admin-guide/kernel-parameters.txt         |  6 ++
>>>>  kernel/rcu/Kconfig.debug                      | 11 +++
>>>>  kernel/rcu/rcu.h                              |  1 +
>>>>  kernel/rcu/tree.c                             | 17 ++++
>>>>  kernel/rcu/tree.h                             | 19 ++++
>>>>  kernel/rcu/tree_stall.h                       | 29 ++++++
>>>>  kernel/rcu/update.c                           |  2 +
>>>>  8 files changed, 173 insertions(+)
>>>>
>>>> -- 
>>>> 2.25.1
>>>>
> .
> 

-- 
Regards,
  Zhen Lei
