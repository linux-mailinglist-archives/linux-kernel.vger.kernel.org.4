Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB936FD7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbjEJHIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbjEJHIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:08:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06A785B80;
        Wed, 10 May 2023 00:08:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 254D21063;
        Wed, 10 May 2023 00:08:50 -0700 (PDT)
Received: from [10.57.22.157] (unknown [10.57.22.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A0BE3F663;
        Wed, 10 May 2023 00:08:03 -0700 (PDT)
Message-ID: <0cda1fc9-2e99-66a2-b833-fe5be676d815@arm.com>
Date:   Wed, 10 May 2023 08:08:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/17] PM: EM: Find first CPU online while updating OPP
 efficiency
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org
References: <20230314103357.26010-1-lukasz.luba@arm.com>
 <20230314103357.26010-3-lukasz.luba@arm.com>
 <c35741e3-f0c9-bec4-7e9a-c96e5949839f@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <c35741e3-f0c9-bec4-7e9a-c96e5949839f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/23 16:40, Pierre Gondois wrote:
> Hello Lukasz,
> 
> On 3/14/23 11:33, Lukasz Luba wrote:
>> The Energy Model might be updated at runtime and the energy efficiency
>> for each OPP may change. Thus, there is a need to update also the
>> cpufreq framework and make it aligned to the new values. In order to
>> do that, use a first online CPU from the Performance Domain.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/power/energy_model.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 265d51a948d4..3d8d1fad00ac 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -246,12 +246,19 @@ em_cpufreq_update_efficiencies(struct device 
>> *dev, struct em_perf_state *table)
>>       struct em_perf_domain *pd = dev->em_pd;
>>       struct cpufreq_policy *policy;
>>       int found = 0;
>> -    int i;
>> +    int i, cpu;
>>       if (!_is_cpu_device(dev) || !pd)
>>           return;
> 
> Since dev is a CPU, I think it shouldn be possible to get the cpu id via 
> 'dev->id'.
> If so the code below should not be necessary anymore.

When you look at the code it does two things.
It tries to get the CPU id - this might be similar to what you
have proposed with the 'dev->id' but it's also looking at CPUs
which are 'active'. The 'dev' that we have might come from
some place, e.g. thermal cooling, which had a first CPU in
the domain stored somewhere. That CPU might be sometimes
not active, but the rest of the CPUs in the domain might be
running. We have to find an active CPU id and then we get the
'policy'.

> 
>> -    policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
>> +    /* Try to get a CPU which is online and in this PD */
>> +    cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);
>> +    if (cpu >= nr_cpu_ids) {
>> +        dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
>> +        return;
>> +    }
>> +
>> +    policy = cpufreq_cpu_get(cpu);
>>       if (!policy) {
>>           dev_warn(dev, "EM: Access to CPUFreq policy failed");
>>           return;
> 
> Regards,
> Pierre
