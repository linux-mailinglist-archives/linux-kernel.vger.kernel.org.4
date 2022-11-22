Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29E6332D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiKVCOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiKVCOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:14:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908B5E0CB5;
        Mon, 21 Nov 2022 18:14:07 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGSV96m2CzRpcc;
        Tue, 22 Nov 2022 10:13:37 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 10:14:05 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 10:14:05 +0800
Subject: Re: [PATCH v8 0/6] rcu: Add RCU stall diagnosis information
To:     <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>
References: <20221119092508.1766-1-thunder.leizhen@huawei.com>
 <20221121222910.GP4001@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6877d891-7314-d9b3-5e1a-3e6bd239489b@huawei.com>
Date:   Tue, 22 Nov 2022 10:14:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221121222910.GP4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2022/11/22 6:29, Paul E. McKenney wrote:
> On Sat, Nov 19, 2022 at 05:25:02PM +0800, Zhen Lei wrote:
>> v7 --> v8:
>> 1. Change call jiffies64_to_msecs() to call jiffies_to_msecs().
>> 2. Mention that rcupdate.rcu_cpu_stall_cputime overrides
>>    CONFIG_RCU_CPU_STALL_CPUTIME behaviour in the Kconfig help text.
>> 3. Fix a make htmldocs warning, change "|...|" to ":...:".
>>
>> v6 --> v7:
>> 1. Use kcpustat_field() to obtain the cputime.
>> 2. Make the output start with "\t" to match other related prints.
>> 3. Aligns the output of the last line of RCU stall.
>>
>> v5 --> v6:
>> 1. When there are more than two continuous RCU stallings, correctly handle the
>>    value of the second and subsequent sampling periods. Update comments and
>>    document.
>>    Thanks to Elliott, Robert for the test.
>> 2. Change "rcu stall" to "RCU stall".
>>
>> v4 --> v5:
>> 1. Resolve a git am conflict. No code change.
>>
>> v3 --> v4:
>> 1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.
>>
>> v2 --> v3:
>> 1. Fix the return type of kstat_cpu_irqs_sum()
>> 2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
>>    rcupdate.rcu_cpu_stall_deep_debug.
>> 3. Add comments and normalize local variable name
>>
>> v1 --> v2:
>> 1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
>>    kcpustat_this_cpu cannot be used.
>> @@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
>>         if (r->gp_seq != rdp->gp_seq)
>>                 return;
>>
>> -       cpustat = kcpustat_this_cpu->cpustat;
>> +       cpustat = kcpustat_cpu(cpu).cpustat;
>> 2. Move the start point of statistics from rcu_stall_kick_kthreads() to
>>    rcu_implicit_dynticks_qs(), removing the dependency on irq_work.
>>
>> v1:
>> In some extreme cases, such as the I/O pressure test, the CPU usage may
>> be 100%, causing RCU stall. In this case, the printed information about
>> current is not useful. Displays the number and usage of hard interrupts,
>> soft interrupts, and context switches that are generated within half of
>> the CPU stall timeout, can help us make a general judgment. In other
>> cases, we can preliminarily determine whether an infinite loop occurs
>> when local_irq, local_bh or preempt is disabled.
> 
> Queued for further review and testing, thank you!
> 
> I did the usual wordsmithing, so please check to see if I messed
> something up.

Thanks for your help.

Sorry, I think I missed a word in the commit message of patch 5/6.

This commit documents the additional RCU CPU stall warning output produced
- by kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y.
+ by kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
+ rcupdate.rcu_cpu_stall_cputime=1.

> 
> 							Thanx, Paul
> 
>> Zhen Lei (6):
>>   genirq: Fix the return type of kstat_cpu_irqs_sum()
>>   sched: Add helper kstat_cpu_softirqs_sum()
>>   sched: Add helper nr_context_switches_cpu()
>>   rcu: Add RCU stall diagnosis information
>>   doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
>>   rcu: Align the output of RCU stall
>>
>>  Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
>>  .../admin-guide/kernel-parameters.txt         |  6 ++
>>  include/linux/kernel_stat.h                   | 14 ++-
>>  kernel/rcu/Kconfig.debug                      | 13 +++
>>  kernel/rcu/rcu.h                              |  1 +
>>  kernel/rcu/tree.c                             | 18 ++++
>>  kernel/rcu/tree.h                             | 19 ++++
>>  kernel/rcu/tree_stall.h                       | 35 +++++++-
>>  kernel/rcu/update.c                           |  2 +
>>  kernel/sched/core.c                           |  5 ++
>>  10 files changed, 198 insertions(+), 3 deletions(-)
>>
>> -- 
>> 2.25.1
>>
> .
> 

-- 
Regards,
  Zhen Lei
