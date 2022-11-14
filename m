Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A0C628276
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiKNO0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiKNO0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:26:44 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A5B332;
        Mon, 14 Nov 2022 06:26:43 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9s7826Q0zHvx6;
        Mon, 14 Nov 2022 22:26:12 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 22:26:41 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 22:26:40 +0800
Subject: Re: [PATCH v7 2/6] sched: Add helper kstat_cpu_softirqs_sum()
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
 <20221111130709.247-3-thunder.leizhen@huawei.com>
 <20221114114252.GA590078@lothringen>
 <568f1341-401d-7de4-0dfd-79b8121ef413@huawei.com>
 <20221114125018.GF590078@lothringen>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5bb31903-207c-2171-5914-ec3046f7241b@huawei.com>
Date:   Mon, 14 Nov 2022 22:26:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221114125018.GF590078@lothringen>
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



On 2022/11/14 20:50, Frederic Weisbecker wrote:
> On Mon, Nov 14, 2022 at 08:45:26PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2022/11/14 19:42, Frederic Weisbecker wrote:
>>> On Fri, Nov 11, 2022 at 09:07:05PM +0800, Zhen Lei wrote:
>>>> Similar to kstat_cpu_irqs_sum(), it counts the sum of all software
>>>> interrupts on a specified CPU.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  include/linux/kernel_stat.h | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
>>>> index 90e2fdc17d79ff8..898076e173a928a 100644
>>>> --- a/include/linux/kernel_stat.h
>>>> +++ b/include/linux/kernel_stat.h
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
>>>
>>> This should return a u64 or at least an unsigned long so that high
>>> numbers of CPUs don't overflow easily.
>>
>> OK! Then I'll adjust the following types by the way.
>>
>> struct kernel_stat {
>>         unsigned long irqs_sum;
>>         unsigned int softirqs[NR_SOFTIRQS];
>> };
>>
>> static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
> 
> And I also misread kstat_softirqs_cpu() content, my bad. Although at some point
> the sum of all softirqs within a single CPU might overflow in an int so I guess
> that still applies...

Yes, this was discussed before. In fact, I think unsigned int and unsigned
long are all right.

> 
> Thanks.
> 
> 
>>
>>
>>
>>
>>>
>>> Thanks.
>>>
>>>> +
>>>> +	return sum;
>>>> +}
>>>> +
>>>>  /*
>>>>   * Number of interrupts per specific IRQ source, since bootup
>>>>   */
>>>> -- 
>>>> 2.25.1
>>>>
>>> .
>>>
>>
>> -- 
>> Regards,
>>   Zhen Lei
> .
> 

-- 
Regards,
  Zhen Lei
