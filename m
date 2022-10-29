Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F1C612200
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJ2Jv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 05:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2Jv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 05:51:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31421107A92;
        Sat, 29 Oct 2022 02:51:54 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MzvhH4TpVz15Lx9;
        Sat, 29 Oct 2022 17:46:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 17:51:52 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 17:51:51 +0800
Subject: Re: [PATCH v2 1/3] sched: Add helper kstat_cpu_softirqs_sum()
To:     <paulmck@kernel.org>
CC:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221022124525.2080-1-thunder.leizhen@huawei.com>
 <20221022124525.2080-2-thunder.leizhen@huawei.com>
 <MW5PR84MB18423C3F30D3F789EB48D0A5AB339@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <e15cd40f-6613-ba44-cc54-0d00f3c7eab1@huawei.com>
 <20221028223514.GV5600@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <40cf1a2c-821d-51da-14b1-cdf6d5b8aeef@huawei.com>
Date:   Sat, 29 Oct 2022 17:51:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221028223514.GV5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2022/10/29 6:35, Paul E. McKenney wrote:
> On Fri, Oct 28, 2022 at 10:38:15AM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2022/10/28 3:04, Elliott, Robert (Servers) wrote:
>>>
>>>> Similar to kstat_cpu_irqs_sum(), it counts the sum of all software
>>>> interrupts on a specified CPU.
>>>>
>>>> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
>>>> @@ -67,6 +67,17 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
>>>>         return kstat_cpu(cpu).softirqs[irq];
>>>>  }
>>>>
>>>> +static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
>>>> +{
>>>> +	int i;
>>>> +	unsigned int sum = 0;
>>>> +
>>>> +	for (i = 0; i < NR_SOFTIRQS; i++)
>>>> +		sum += kstat_softirqs_cpu(i, cpu);
>>>> +
>>>> +	return sum;
>>>> +}
>>>
>>> In the function upon which this is based:
>>>
>>> struct kernel_stat {
>>>         unsigned long irqs_sum;
>>>         unsigned int softirqs[NR_SOFTIRQS];
>>> };
>>>
>>> static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
>>> {
>>>         return kstat_cpu(cpu).irqs_sum;
>>> }
>>>
>>> kstat_cpu_irqs_sum returns an unsigned long as an unsigned int, which
>>> could cause large values to be truncated. Should that return
>>> unsigned long? The only existing caller is fs/proc/stat.c which
>>
>> This should be a mistake on:
>> commit f2c66cd8eeddedb4 ("/proc/stat: scalability of irq num per cpu")
>>
>> I'll correct it to "unsigned long" in the next version. Thanks.
>>
>>> puts it into a u64:
>>>         u64 sum = 0;
>>>         ...
>>>         sum             += kstat_cpu_irqs_sum(i);
>>>
>>> The softirqs field is an unsigned int, so the new function doesn't have
>>> this inconsistency.
>>
>> OK.
>>
>> To be honest, I did the math. CONFIG_HZ=250
>> 2^32 / 250 / 3600 / 24 / 365 = 0.545 < 1 year
> 
> For this to be a problem, our RCU CPU stall warning would have to be
> for a months-long grace period, even on systems with HZ=1000.  In almost
> all cases, the system would have OOMed long before then.

Yes.

> 
>> So, in theory, for those 32-bit processors, we should use "unsigned long long".
>> Of course, from a programming point of view, 64-bit consists of two 32-bits,
>> and there is an atomicity problem. I think that's probably why members of
>> struct kernel_stat don't use u64.
>>
>> However, it seems that the type of member softirqs can currently be changed to
>> unsigned long. So, at least on a 64-bit processor, it won't have a count
>> overflow problem.
> 
> An unsigned long should suffice.  ;-)

include/linux/irqdesc.h:58:     unsigned int __percpu   *kstat_irqs;

I found another place where the hard interrupt count was stored with type "unsigned int",
it's used by "/proc/interrupts". Maybe the user-mode program gets it periodically and
accumulates it to a 64-bit value. Of course, maybe half a year later, no one cares about
the specific interrupts count anymore.

So, apart from what Elliott mentioned, I won't change the rest.

> 
> 							Thanx, Paul
> .
> 

-- 
Regards,
  Zhen Lei
