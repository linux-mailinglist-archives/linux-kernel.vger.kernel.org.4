Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65897707790
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjERBo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjERBo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:44:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC22D7D;
        Wed, 17 May 2023 18:44:52 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QMCNF0Z0Pz18Ls7;
        Thu, 18 May 2023 09:40:29 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 09:44:48 +0800
Message-ID: <72de6a0f-f8c9-2b3d-04b5-613f2d368b61@huawei.com>
Date:   Thu, 18 May 2023 09:44:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: keep target core awake when reading
 its cpufreq rate
To:     Sumit Gupta <sumitg@nvidia.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>,
        <liwei391@huawei.com>, <linux-acpi@vger.kernel.org>,
        <weiyongjun1@huawei.com>, <lenb@kernel.org>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        Yang Shi <yang@os.amperecomputing.com>
References: <20230516133248.712242-1-zengheng4@huawei.com>
 <a1075da1-4ff1-4a8b-2902-3954db717ded@arm.com>
 <cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com>
Content-Language: en-US
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/17 23:03, Sumit Gupta 写道:
>
>
> On 17/05/23 13:47, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> +Ionela, Sumit, Yang,
>>
>> Hello Zeng,
>>
>> I think solutions around related issues were suggested at:
>>
>> [1] 
>> https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
>> [2] 
>> https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
>> [3] https://lore.kernel.org/all/ZEl1Fms%2FJmdEZsVn@arm.com/
>>
>> About this patch, it seems to mean that CPPC counters of CPUx are always
>> accessed from CPUx, even when they are not AMUs. For instance CPPC
>> counters could be memory mapped and accessible from any CPU.
>> cpu_has_amu_feat() should allow to probe if a CPU uses AMUs or not,
>> and [2] had an implementation using it.
>>
>> Another comment about PATCH 2/2 is that if the counters are accessed
>> through FFH, arm64 version of cpc_read_ffh() is calling
>> counters_read_on_cpu(), and a comment in counters_read_on_cpu() seems
>> to specify the function must be called with interrupt enabled.
>>
>> I think the best solution so far was the one at [3], suggested by 
>> Ionela,
>> but it doesn't seem to solve your issue. Indeed, it is not checked 
>> whether
>> the counters are AMU counters and that they must be remotely read (to
>> have the CPU awake),
>>
>> Regards,
>> Pierre
>>
>
> I think the solution in [1] is simple and solves all the three cases.
> Also, it provides better accuracy between the set and get frequency as 
> compared to [3].
>
> This can be merged and can later still be improved in Upstream.
>
> If OK, I can send new version by changing the patch to apply for all 
> ARM SoC's with AMU and not specific to Tegra.
>
> Thank you,
> Sumit Gupta
>
I vote solution [1] and it should be applied to all ARM SoCs with AMU.

Zeng Heng

>>
>> On 5/16/23 15:32, Zeng Heng wrote:
>>> As ARM AMU's document says, all counters are subject to any changes
>>> in clock frequency, including clock stopping caused by the WFI and WFE
>>> instructions.
>>>
>>> Therefore, using smp_call_on_cpu() to trigger target CPU to
>>> read self's AMU counters, which ensures the counters are working
>>> properly during calculation.
>>>
>>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 30 +++++++++++++++++++-----------
>>>   1 file changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index 022e3555407c..910167f58bb3 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -837,9 +837,24 @@ static int cppc_perf_from_fbctrs(struct 
>>> cppc_cpudata *cpu_data,
>>>       return (reference_perf * delta_delivered) / delta_reference;
>>>   }
>>>
>>> +static int cppc_get_perf_ctrs_smp(void *val)
>>> +{
>>> +     int cpu = smp_processor_id();
>>> +     struct cppc_perf_fb_ctrs *fb_ctrs = val;
>>> +     int ret;
>>> +
>>> +     ret = cppc_get_perf_ctrs(cpu, fb_ctrs);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     udelay(2); /* 2usec delay between sampling */
>>> +
>>> +     return cppc_get_perf_ctrs(cpu, fb_ctrs + 1);
>>> +}
>>> +
>>>   static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>>   {
>>> -     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>> +     struct cppc_perf_fb_ctrs fb_ctrs[2] = {0};
>>>       struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>>>       struct cppc_cpudata *cpu_data = policy->driver_data;
>>>       u64 delivered_perf;
>>> @@ -847,19 +862,12 @@ static unsigned int 
>>> cppc_cpufreq_get_rate(unsigned int cpu)
>>>
>>>       cpufreq_cpu_put(policy);
>>>
>>> -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>>> -     if (ret)
>>> -             return ret;
>>> -
>>> -     udelay(2); /* 2usec delay between sampling */
>>> -
>>> -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>> +     ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_smp, fb_ctrs, 1);
>>>       if (ret)
>>>               return ret;
>>>
>>> -     delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>>> -                                            &fb_ctrs_t1);
>>> -
>>> +     delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs,
>>> +                                            fb_ctrs + 1);
>>>       return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>>>   }
>>>
