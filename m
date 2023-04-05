Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA616D8561
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjDER53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjDER52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:57:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBD28B0;
        Wed,  5 Apr 2023 10:57:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A407FEC;
        Wed,  5 Apr 2023 10:58:10 -0700 (PDT)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCE313F73F;
        Wed,  5 Apr 2023 10:57:24 -0700 (PDT)
Message-ID: <4bda6b02-cc50-fa47-c9b6-acda4cf201a8@arm.com>
Date:   Wed, 5 Apr 2023 19:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
To:     Yang Shi <yang@os.amperecomputing.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     viresh.kumar@linaro.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
 <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
 <d08222bf-fa05-3e3b-18dd-d24ced6c1536@os.amperecomputing.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <d08222bf-fa05-3e3b-18dd-d24ced6c1536@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/23 21:07, Yang Shi wrote:
> 
> 
> On 3/29/23 11:43 AM, Rafael J. Wysocki wrote:
>> On Tue, Mar 28, 2023 at 9:39 PM Yang Shi <yang@os.amperecomputing.com> wrote:
>>> When testing CPPC cpufreq on our platform, we noticed the error may be quite
>>> high and the high error may happen quite often.  For example, on a platform
>>> with a maximum frequency of 2.8GHz when the CPUs were fully loaded (100% load),
>>> we saw cpuinfo_cur_freq may show 4GHz, it means the error is > 40%.  And the
>>> high error (> 1%) happened 256 times out of 2127 samples (sampled every 3
>>> seconds) in an approximate 2hrs test.
>> The description above is a bit cryptic IMV.  For example, it is not
>> particularly clear what "high error" means.
>>
>>> We tried to enlarge the delay, and tested with 100us, 1ms and 10ms.  The
>>> below is the results.
>>>
>>> 100us:
>>> The highest error is 4GHz, 22 times out of 3623 samples
>>>
>>> 1ms:
>>> The highest error is 3.3GHz, 3 times out of 2814 samples
>>>
>>> 10ms:
>>> No high error anymore
>>>
>>> Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to avoid
>>> high measurement errors.
>>>
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>    drivers/cpufreq/cppc_cpufreq.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 022e3555407c..c2bf65448d3d 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -851,7 +851,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>>           if (ret)
>>>                   return ret;
>>>
>>> -       udelay(2); /* 2usec delay between sampling */
>>> +       mdelay(10); /* 10msec delay between sampling */
>> This function can be called with interrupts off, so it cannot spin for 10 ms.
> 
> Per Pierre's comment, the delay may still be ms. Is it still too long? A
> quick look at the code shows cpufreq_quick_get() is the only caller with
> irq off IIRC. So can we have another callback for it, for example,
> get_quick() which does spin for shorter time (for example, keep 2us
> delay). Then have ->get() callback use longer delay?

-
According to the same ACPI 6.5 s8.4.6.1.2.5 "Time Window Register" paragraph,
and assuming we are in the 'Autonomous Selection is not enabled' case,
the OS is supposed to write (not read) the delta between successive reads of the
counter, so using this field as is would be bending the definition I think.

-
It is correct that the "Time Window Register" field specifies a value in ms,
but it seems a long time to wait for with irqs off.

-
Theoretically, the perf/ref counters should accumulate to allow computing
a correct frequency. Is it possible to know how these counters are accessed ?
Is it through PCC channels and there is some undesired delay between the
reads of the perf/ref counters ?

-
About making the delay:
     max(cppc_cpufreq_get_transition_delay_us(), Time Winder Register)
I think it would be good to know why the values of the counters
don't accumulate correctly, ideally by getting a trace where a frequency
above the maximum frequency is computed, and with the timestamps at which
the counters are read.
If the values are coming from PCC channels / the firmware, it might be difficult
to get.

Just for reference, the value of 2us was picked in this thread:
https://lore.kernel.org/all/ac2eb509-c1b0-521a-07e5-2bf8eaaa55c2@codeaurora.org/T/#u

Regards,
Pierre


> 
> 
>>
>>>           ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>>           if (ret)
>>> --
> 
