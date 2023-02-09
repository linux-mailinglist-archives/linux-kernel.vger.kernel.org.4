Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4751690FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjBISCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBISCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:02:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A07AFAD14
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:02:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 839D6FEC;
        Thu,  9 Feb 2023 10:03:01 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 890943F8C6;
        Thu,  9 Feb 2023 10:02:17 -0800 (PST)
Message-ID: <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
Date:   Thu, 9 Feb 2023 19:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 10:45, Vincent Guittot wrote:
> On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
>>
>> When uclamp_max is being used, the util of the task could be higher than
>> the spare capacity of the CPU, but due to uclamp_max value we force fit
>> it there.
>>
>> The way the condition for checking for max_spare_cap in
>> find_energy_efficient_cpu() was constructed; it ignored any CPU that has
>> its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
>> max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
>> hence ending up never performing compute_energy() for this cluster and
>> missing an opportunity for a better energy efficient placement to honour
>> uclamp_max setting.
>>
>>         max_spare_cap = 0;
>>         cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high
>>
>>         ...
>>
>>         util_fits_cpu(...);             // will return true if uclamp_max forces it to fit

s/true/1/ ?

>>
>>         ...
>>
>>         // this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
>>         if (cpu_cap > max_spare_cap) {
>>                 max_spare_cap = cpu_cap;
>>                 max_spare_cap_cpu = cpu;
>>         }
>>
>> prev_spare_cap suffers from a similar problem.
>>
>> Fix the logic by converting the variables into long and treating -1
>> value as 'not populated' instead of 0 which is a viable and correct
>> spare capacity value.

The issue I see here is in case we don't have any spare capacity left,
the energy calculation (in terms CPU utilization) isn't correct anymore.

Due to `effective_cpu_util()` returning `max=arch_scale_cpu_capacity()`
you never know how big the `busy_time` for the PD really is in this moment.

eenv_pd_busy_time()

  for_each_cpu(cpu, pd_cpus)
    busy_time += effective_cpu_util(..., ENERGY_UTIL, ...)
    ^^^^^^^^^

with:

  sum_util = min(busy_time + task_busy_time, pd_cap)
                 ^^^^^^^^^

  freq = (1.25 * max_util / max) * max_freq

  energy = (perf_state(freq)->cost / max) * sum_util


energy is not related to CPU utilization anymore (since there is no idle
time/spare capacity) left.

So EAS keeps packing on the cheaper PD/clamped OPP.

E.g. Juno-r0 [446 1024 1024 446 446 446] with 6 8ms/16ms uclamp_max=440
tasks all running on little PD, cpumask=0x39. The big PD is idle but
never beats prev_cpu in terms of energy consumption for the wakee.

[...]
