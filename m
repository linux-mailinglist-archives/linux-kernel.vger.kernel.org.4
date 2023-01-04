Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17E065D00C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjADJ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjADJ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:57:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C64011A3BF;
        Wed,  4 Jan 2023 01:57:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492D51596;
        Wed,  4 Jan 2023 01:57:45 -0800 (PST)
Received: from [10.57.12.241] (unknown [10.57.12.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 215EA3F71A;
        Wed,  4 Jan 2023 01:57:01 -0800 (PST)
Message-ID: <14dc7a29-c01d-ae0c-e531-66f6f65aee1e@arm.com>
Date:   Wed, 4 Jan 2023 09:57:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v5 2/2] cpuidle: teo: Introduce util-awareness
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com,
        dsmythies@telus.net, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
References: <20221130153204.2085591-1-kajetan.puchalski@arm.com>
 <20221130153204.2085591-3-kajetan.puchalski@arm.com>
 <CAJZ5v0jXkKTUsA1Pdis7T9qzYZBiRFnpJ+AwE3zEuAHNR_=K3A@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jXkKTUsA1Pdis7T9qzYZBiRFnpJ+AwE3zEuAHNR_=K3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Forgive me to jump into the discussion, I would like to clarify some
stuff.

On 1/3/23 17:53, Rafael J. Wysocki wrote:
> On Wed, Nov 30, 2022 at 4:33 PM Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
>>
>> Modern interactive systems, such as recent Android phones, tend to have power
>> efficient shallow idle states. Selecting deeper idle states on a device while a
>> latency-sensitive workload is running can adversely impact performance due to
>> increased latency. Additionally, if the CPU wakes up from a deeper sleep before
>> its target residency as is often the case, it results in a waste of energy on
>> top of that.
>>
>> At the moment, all the available idle governors operate mainly based on their
>> own past correctness metrics along with timer events without taking into account
>> any scheduling information.
> 
> I still don't quite agree with the above statement.
> 
> It would be accurate enough to state the fact that currently cpuidle
> governors don't take scheduling information into account.

Fair enough.

> 
>> Especially on interactive systems, this results in
>> them frequently selecting a deeper idle state and then waking up before its
>> target residency is hit, thus leading to increased wakeup latency and lower
>> performance with no power saving. For 'menu' while web browsing on Android for
>> instance, those types of wakeups ('too deep') account for over 24% of all
>> wakeups.
> 
> I don't think that you can convincingly establish a cause-and-effect
> relationship between not taking scheduling information into account
> and overestimating the idle duration.

This is tough topic to prove this correctly, good for some PhD studies.
There is some correlation which we see in the results and measurements,
though. An interesting topic to study would be the CPU runqueue
utilization signal nature, when the tasks sleep or migrate. We don't
have time to study that signal nature over time and if that function
matches some already discovered process and invented math theory,
e.g. Erlang distribution or only exponential distribution...
Your exponentially decaying statistics might fall into same bucket.

> 
> It would be just fine to say something like "They also tend to
> overestimate the idle duration quite often, which causes them to
> select excessively deep idle states, which leads to ...".

Fair enough.

> 
>> At the same time, on some platforms C0 can be power efficient enough to warrant
>> wanting to prefer it over C1.
> 
> If you say C0 or C1, a casual reader may think about x86 which
> probably is not your intention.
> 
> I would say "idle state 0" and "idle state 1" instead.  I would also
> say that this is on systems where idle state 0 is not a polling state.

I agree.

> 
>> This is because the power usage of the two states
>> can be so close that sufficient amounts of too deep C1 sleeps can completely
>> offset the C1 power saving to the point where it would've been more power
>> efficient to just use C0 instead.
>>
>> Sleeps that happened in C0 while they could have used C1 ('too shallow') only
>> save less power than they otherwise could have. Too deep sleeps, on the other
>> hand, harm performance and nullify the potential power saving from using C1 in
>> the first place. While taking this into account, it is clear that on balance it
>> is preferable for an idle governor to have more too shallow sleeps instead of
>> more too deep sleeps on those kinds of platforms.
> 
> I don't think that the above paragraphs, while generally true, are
> relevant for what the patch really does.

I disagree. That's the patch improvement, precisely the threshold
value of ~1.56% makes this trade-off. We more often prefer too shallow
idle state 0. When you change that threshold to bigger value, you reduce
this preference.

> 
> They would have been relevant if the patch had improved the
> energy-efficiency, but it doesn't.  It sacrifices energy for
> performance by reducing the CPU wakeup latency.

I disagree. Let me clarify those results, because there is a lot of
data I think you might miss some important bits.

Kajetan has provided 4 benchmarks' test results, which are really
comprehensive.

A. There are 2 benchmarks 'performance-first', so we want better score,
*no matter the energy cost* (Geekbench 5 and Speedometer).
The Geekbench5 is most important since a lot of people check it before
buying a phone. For this benchmark TEO was an issue as you can see:
multicore score TEO vs TEO_util:
   2764.8 vs. 2865
which is ~3.5% improvement, trust me it's a lot.

B. There are 2 benchmarks trying to reflect 'normal usage' of a phone:
- PCMark Web Browsing
   score TEO vs. TEO_util
     5219.8 vs. 5239.9 ---> better score
   avg power
     184.8 vs. 184.1 mW ---> lower power, better
- Jankbench
   score TEO vs. TEO_util (lower janky frames percentage is better)
     2.1% vs. 1.3% ---> better score
   avg power
     136.9 mW vs. 121.3 mW ----> lower power, better

The results in B. show that it doesn't sacrifice energy for performance.
We were able to reduce the avg power while even improving the score
results. It would lead to lower energy for the whole test.

You might ask: how is this possible?
Or HW design has evolved and made the idle state 0 very attractive
(reducing more and more power). This created a potential new area
to explore which was in my head for quite a long. Kajetan was keen to
explore that space and found many interesting behaviors there.
Some background about energy and costs.
Don't forget that to enter a deeper idle state you have to flush the
caches gently, not just drop the data blindly. That will cost you some
extra energy (you can drop instr. cache) (comparing to a situation when
you don't have to do this and you keep the caches on). Then when you
wakeup the CPU you have to load instr. and data into cache, which cost
you another extra energy. If you have to do this to/from LPDDR, then it
is ~10x bigger energy vs. some internal data passing (e.g. L3 -> L2).
If you do this wrongly (that's what Kajetan is calling "too deep",
which is a nice new metric IMO) then you will pay those two extra energy
penalties and most likely not saving enough energy to compensate that
loss. That's why you might wonder why choosing a deeper idle I couldn't
save energy... That's the reason.


> 
>> This patch specifically tunes TEO to minimise too deep sleeps and minimise
>> latency to achieve better performance.
> 
> I'm not sure if you can demonstrate that the number of "too deep
> sleeps" is really reduced in all cases, but the reduction of latency
> is readily demonstrable, so I would focus on that part.

Sounds sane

> 
>> To this end, before selecting the next
>> idle state it uses the avg_util signal of a CPU's runqueue in order to determine
>> to what extent the CPU is being utilized. This util value is then compared to a
>> threshold defined as a percentage of the cpu's capacity (capacity >> 6 ie. ~1.5%
>> in the current implementation). If the util is above the threshold, the
>> idle state selected by TEO metrics will be reduced by 1, thus selecting a
>> shallower state. If the util is below the threshold, the governor defaults to
>> the TEO metrics mechanism to try to select the deepest available idle state
>> based on the closest timer event and its own correctness.
>>
>> The main goal of this is to reduce latency and increase performance for some
>> workloads. Under some workloads it will result in an increase in power usage
>> (Geekbench 5) while for other workloads it will also result in a decrease in
>> power usage compared to TEO (PCMark Web, Jankbench, Speedometer).
>>
>> It can provide drastically decreased latency and performance benefits in certain
>> types of workloads that are sensitive to latency.
> 
> And I would put some numbers from your cover letter in here.
>

I agree.

[snip]

>> + *
>> + * When the CPU is utilized while going into idle, more likely than not it will
>> + * be woken up to do more work soon and so a shallower idle state should be
>> + * selected to minimise latency and maximise performance. When the CPU is not
>> + * being utilized, the usual metrics-based approach to selecting the deepest
>> + * available idle state should be preferred to take advantage of the power
>> + * saving.
> 
> I would say "energy saving" instead of "power saving", as the former
> is technically more accurate.

I agree.

I hope this could help to clarify some bits.

Regards,
Lukasz
