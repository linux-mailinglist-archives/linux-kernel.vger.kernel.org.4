Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9685F647F65
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLIIjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLIIjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:39:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E84AD4D5C6;
        Fri,  9 Dec 2022 00:39:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1409323A;
        Fri,  9 Dec 2022 00:39:23 -0800 (PST)
Received: from [10.57.9.37] (unknown [10.57.9.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D92A3F73B;
        Fri,  9 Dec 2022 00:39:13 -0800 (PST)
Message-ID: <e8f4f0d0-d071-e169-48c2-02081c840583@arm.com>
Date:   Fri, 9 Dec 2022 08:39:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/1] cpufreq: schedutil: Optimize operations with
 single CPU capacity lookup
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, saravanak@google.com,
        wusamuel@google.com, isaacmanjarres@google.com,
        kernel-team@android.com, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
References: <20221208160256.859-1-lukasz.luba@arm.com>
 <20221208160256.859-2-lukasz.luba@arm.com>
 <20221208233801.s26awslkx6aloxyd@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221208233801.s26awslkx6aloxyd@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/22 23:38, Viresh Kumar wrote:
> On 08-12-22, 16:02, Lukasz Luba wrote:
>> @@ -332,12 +333,15 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>>   	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
>>   	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>>   	unsigned int cached_freq = sg_policy->cached_raw_freq;
>> +	unsigned long max_cap;
>>   	unsigned int next_f;
>>   
>> -	if (!sugov_update_single_common(sg_cpu, time, flags))
>> +	max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);
> 
> I will rather do this at all three locations:
> 
> 	unsigned long max_cap = arch_scale_cpu_capacity(sg_cpu->cpu);
> 

In the 2nd location it is called after the check:

if (!arch_scale_freq_invariant())

which can return.

IMO this is more visible and exposed.
The way it's implemented now stresses the fact that
we read this value at runtime (unfortunately). Maybe in the
future someone would find it and simplify.

I sometimes found difficult to spot those important calls in
the variable header section, e.g. how many times are called
or with what kind of arguments. In this case the sg_cpu->cpu
should be clearly visible and effectively matched as the same as
smp_procesor_id() for that running CPU, thus fetching the
same capacity variable from local per-cpu (not remote).
IMO the way how the code is structured could help (or not)
to spot those details. That's why I prefer to keep it as is
in this implementation.
