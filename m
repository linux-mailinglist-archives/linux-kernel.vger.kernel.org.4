Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A0761D7FF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 08:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKEHDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 03:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKEHDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 03:03:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C111A2ED6C;
        Sat,  5 Nov 2022 00:03:17 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N47f33f5PzpW3m;
        Sat,  5 Nov 2022 14:59:39 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 15:03:15 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 15:03:15 +0800
Subject: Re: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <14e3aa38-98e6-01be-8cde-68fd1f85edf4@huawei.com>
Date:   Sat, 5 Nov 2022 15:03:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
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



On 2022/11/5 9:58, Elliott, Robert (Servers) wrote:
> 
>> --- a/kernel/rcu/Kconfig.debug
>> +++ b/kernel/rcu/Kconfig.debug
>> @@ -95,6 +95,16 @@ config RCU_EXP_CPU_STALL_TIMEOUT
>>  	  says to use the RCU_CPU_STALL_TIMEOUT value converted from
>>  	  seconds to milliseconds.
>>
>> +config RCU_CPU_STALL_CPUTIME
> 
> Since the information might change and grow over time, consider
> calling it "ADDITIONAL_INFO" rather than just "CPUTIME".

I think it's okay. But I need to wait for Paul's opinion.
In fact, I've also considered using MORE_DEBUG_INFO.

> 
>> +	bool "Provide additional rcu stall debug information"
>> +	depends on RCU_STALL_COMMON
>> +	default n
>> +	help
>> +	  Statistics during the period from RCU_CPU_STALL_TIMEOUT/2 to
>> +	  RCU_CPU_STALL_TIMEOUT, such as the number of (hard interrupts,
>> soft
>> +	  interrupts, task switches) and the cputime of (hard interrupts,
>> soft
>> +	  interrupts, kerenl tasks) are added to the rcu stall report.
> 
> s/kerenl/kernel/

Good catch.

> 
> Those parenthetical words are not grammatically correct, and
> nobody will remember to update Kconfig if they change the code.
> 
> Try making it is a little less precise: 
> "Collect statistics during the RCU stall timeout period

the second half period of RCU stall timeout

> (e.g., counts and CPU time consumed by hard interrupts, soft
> interrupts, task switches, and kernel tasks) and include

Maybe we can remove "task switches, and kernel tasks". Just for example,
no need to exhaustively.

> them in the RCU stall console error message."

Looks good above. Thanks.

> 
> ...
>> +
>> +	pr_err("         hardirqs   softirqs   csw/system\n");
>> +	pr_err(" number: %8ld %10d %12lld\n",
> 
> Everything after a %d is a "number". These are more specifically counts.
> 
>> +		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
>> +		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
>> +		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
> 
> Two columns are plural and one is not. 

I didn't understand. Do you mean:
(1)
             hardirqs   softirqs  csw  system
     number:                      xx   N/A
cputime(ms):                      N/A   xx

> 
> Within a few lines, this is referred to as "context_switches", cws, 
> and "task switches." One term would be better. vmstat uses "cs", 
> pidstat uses "cswch", and /proc/<pid>/status uses "ctxt_switches,"
> so there's not one ideal term for that column. Matching one
> of those might be better than using another unique name.

struct task_struct {
        /* Context switch counts: */
        unsigned long                   nvcsw;
        unsigned long                   nivcsw;

There's nothing wrong with 'csw'.

> 
> Since no other variants are shown, the "/system" suffix is a bit
> confusing.

I don't think it's a problem! Because the prefix cputime already exists,
so CPUTIME_SYSTEM --> system.

How about:
             hardirqs   softirqs  tasks
     counts:
cputime(ms):

It's like drawing a head with a pipe in the men's room, and a head with
long hair in the women's room. Although women may also have smokers, men
may also have long hair. Oh, the example right in front of us, who would
interpret the first line as the number of interrupt types? So I think
it's pretty good to use 'tasks'.

> 
> 
>> +	pr_err("cputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
>> +		div_u64(cpustat[CPUTIME_IRQ] - rsrp->cputime_irq, NSEC_PER_MSEC),
>> +		div_u64(cpustat[CPUTIME_SOFTIRQ] - rsrp->cputime_softirq, NSEC_PER_MSEC),
>> +		div_u64(cpustat[CPUTIME_SYSTEM] - rsrp->cputime_system, NSEC_PER_MSEC),
>> +		jiffies64_to_msecs(half_timeout));
> 
> There is no column header for that fourth number. "half_timeout"
> might be good, dropping the "==>".

If we use words, I'll use "sampling period" or "period".

To be honest, the printed information of the RCU needs to be understood in
combination with the code. For exmaple:

pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
               cpu,
               "O."[!!cpu_online(cpu)],
               "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
               "N."[!!(rdp->grpmask & rdp->mynode->qsmaskinitnext)],

Paul mentioned a few days ago that there were complaints that the RCU was
printing too much. So "==>" is better suited for people who often deal with
rcu stall issues.

> 
> The "(ms)" at the end is awkward. Try moving it to the left
> as "cputime (ms): "

OK

> 
>> +int rcu_cpu_stall_cputime __read_mostly =
>> IS_ENABLED(CONFIG_RCU_CPU_STALL_CPUTIME);
> 
> As a config option and module parameter, adding some more
> instrumentation overhead might be worthwhile for other
> likely causes of rcu stalls.
> 
> For example, if enabled, have these functions (if available
> on the architecture) maintain a per-CPU running count of
> their invocations, which also cause the CPU to be unavailable
> for rcu: 
> - kernel_fpu_begin() calls - FPU/SIMD context preservation,
>   which also calls preempt_disable()
> - preempt_disable() calls - scheduler context switches disabled
> - local_irq_save() calls - interrupts disabled
> - cond_resched() calls - lack of these is a problem
> 
> For kernel_fpu_begin and preempt_disable, knowing if it is
> currently blocked for those reasons is probably the most
> helpful.

These instructions is already in Documentation/RCU/stallwarn.rst

> 
> .
> 

-- 
Regards,
  Zhen Lei
