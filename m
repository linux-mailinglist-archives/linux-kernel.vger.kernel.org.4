Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D38643E5B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiLFITh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiLFISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:18:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA233DA5;
        Tue,  6 Dec 2022 00:17:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA82523A;
        Tue,  6 Dec 2022 00:17:17 -0800 (PST)
Received: from [10.57.7.134] (unknown [10.57.7.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB2403F73B;
        Tue,  6 Dec 2022 00:17:07 -0800 (PST)
Message-ID: <d38e1cba-23f1-a19d-54dd-b9e18e852bee@arm.com>
Date:   Tue, 6 Dec 2022 08:17:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to
 sugov_policy"
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sam Wu <wusamuel@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110195732.1382314-1-wusamuel@google.com>
 <20221205091830.pttdbyts4hujkpq2@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221205091830.pttdbyts4hujkpq2@vireshk-i7>
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

Hi Viresh,

On 12/5/22 09:18, Viresh Kumar wrote:
> Lukasz,
> 
> On 10-11-22, 19:57, Sam Wu wrote:
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index 9161d1136d01..1207c78f85c1 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -25,9 +25,6 @@ struct sugov_policy {
>>   	unsigned int		next_freq;
>>   	unsigned int		cached_raw_freq;
>>   
>> -	/* max CPU capacity, which is equal for all CPUs in freq. domain */
>> -	unsigned long		max;
>> -
>>   	/* The next fields are only needed if fast switch cannot be used: */
>>   	struct			irq_work irq_work;
>>   	struct			kthread_work work;
>> @@ -51,6 +48,7 @@ struct sugov_cpu {
>>   
>>   	unsigned long		util;
>>   	unsigned long		bw_dl;
>> +	unsigned long		max;
> 
> IIUC, this part, i.e. moving max to sugov_policy, wasn't the problem
> here, right ? Can you send a patch for that at least first, since this
> is fully reverted now.
> 
> Or it doesn't make sense?
> 

Yes, that still could make sense. We could still optimize a bit that
code in the sugov_next_freq_shared(). Look at that function. It loops
over all CPUs in the policy and calls sugov_get_util() which calls
this arch_scale_cpu_capacity() N times. Then it does those
multiplications below:

if (j_util * max > j_max * util)

which will be 2*N mul operations...
IMO this is pointless and heavy for LITTLE cores which are 4 or
sometimes 6 in the policy.

As you could see, my code just left that loop with a simple
max() operation.

I might just attack this code differently. Switch to that
sugov_policy::max, fetch the cpu capacity only once, before that loop.
I will rewrite a bit the sugov_get_util() and adjust the
2nd user of it: sugov_update_single_common()

Regards,
Lukasz
