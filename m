Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8818C6D58F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjDDGyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDDGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:54:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BBB1FE9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:54:29 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PrJPM4hdKzrVkJ;
        Tue,  4 Apr 2023 14:53:11 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 14:54:25 +0800
Subject: Re: [PATCH 2/2] lib/percpu_counter: fix dying cpu compare race
To:     Yury Norov <yury.norov@gmail.com>, Ye Bin <yebin@huaweicloud.com>
References: <20230404014206.3752945-1-yebin@huaweicloud.com>
 <20230404014206.3752945-3-yebin@huaweicloud.com>
 <ZCuQhDLkRhJy081W@yury-laptop>
CC:     <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>,
        <linux-mm@kvack.org>, <andriy.shevchenko@linux.intel.com>,
        <linux@rasmusvillemoes.dk>, <linux-kernel@vger.kernel.org>,
        <dchinner@redhat.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <642BC9A1.4040802@huawei.com>
Date:   Tue, 4 Apr 2023 14:54:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <ZCuQhDLkRhJy081W@yury-laptop>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/4 10:50, Yury Norov wrote:
> On Tue, Apr 04, 2023 at 09:42:06AM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> In commit 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") a race
>> condition between a cpu dying and percpu_counter_sum() iterating online CPUs
>> was identified.
>> Acctually, there's the same race condition between a cpu dying and
>> __percpu_counter_compare(). Here, use 'num_online_cpus()' for quick judgment.
>> But 'num_online_cpus()' will be decreased before call 'percpu_counter_cpu_dead()',
>> then maybe return incorrect result.
>> To solve above issue, also need to add dying CPUs count when do quick judgment
>> in __percpu_counter_compare().
> Not sure I completely understood the race you are describing. All CPU
> accounting is protected with percpu_counters_lock. Is it a real race
> that you've faced, or hypothetical? If it's real, can you share stack
> traces?
>   
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   lib/percpu_counter.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
>> index 5004463c4f9f..399840cb0012 100644
>> --- a/lib/percpu_counter.c
>> +++ b/lib/percpu_counter.c
>> @@ -227,6 +227,15 @@ static int percpu_counter_cpu_dead(unsigned int cpu)
>>   	return 0;
>>   }
>>   
>> +static __always_inline unsigned int num_count_cpus(void)
> This doesn't look like a good name. Maybe num_offline_cpus?
>
>> +{
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +	return (num_online_cpus() + num_dying_cpus());
>                 ^                                    ^
>           'return' is not a function. Braces are not needed
>
> Generally speaking, a sequence of atomic operations is not an atomic
> operation, so the above doesn't look correct. I don't think that it
> would be possible to implement raceless accounting based on 2 separate
> counters.
Yes, there is indeed a concurrency issue with doing so here. But I saw 
that the process was first
set up dying_mask and then reduce the number of online CPUs. The total 
quantity maybe is larger
than the actual value and may fall back to a slow path.But this won't 
cause any problems.

>
> Most probably, you'd have to use the same approach as in 8b57b11cca88:
>
>          lock();
>          for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask)
>                  cnt++;
>          unlock();
>
> And if so, I'd suggest to implement cpumask_weight_or() for that.
>
>> +#else
>> +	return num_online_cpus();
>> +#endif
>> +}
>> +
>>   /*
>>    * Compare counter against given value.
>>    * Return 1 if greater, 0 if equal and -1 if less
>> @@ -237,7 +246,7 @@ int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
>>   
>>   	count = percpu_counter_read(fbc);
>>   	/* Check to see if rough count will be sufficient for comparison */
>> -	if (abs(count - rhs) > (batch * num_online_cpus())) {
>> +	if (abs(count - rhs) > (batch * num_count_cpus())) {
>>   		if (count > rhs)
>>   			return 1;
>>   		else
>> -- 
>> 2.31.1
> .
>

