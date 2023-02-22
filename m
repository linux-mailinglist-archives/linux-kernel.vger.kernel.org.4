Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BAC69FCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjBVUOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjBVUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:13:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E63859E3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:13:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3A89FEC;
        Wed, 22 Feb 2023 12:14:27 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920343F703;
        Wed, 22 Feb 2023 12:13:41 -0800 (PST)
Message-ID: <36bfd828-5af7-3bcb-d642-3361820c6071@arm.com>
Date:   Wed, 22 Feb 2023 21:13:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <249816c9-c2b5-8016-f9ce-dab7b7d384e4@arm.com>
 <CAKfTPtA4gSZAmi3FtU2Y57cuqCzC5LCR=+7Q8Xh=VtkbfaQP5Q@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtA4gSZAmi3FtU2Y57cuqCzC5LCR=+7Q8Xh=VtkbfaQP5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 14:54, Vincent Guittot wrote:
> On Fri, 17 Feb 2023 at 14:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 09/02/2023 17:16, Vincent Guittot wrote:
>>> On Tue, 7 Feb 2023 at 11:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 09/11/2022 16:49, Peter Zijlstra wrote:
>>>>> On Tue, Nov 08, 2022 at 07:48:43PM +0000, Qais Yousef wrote:
>>>>>> On 11/07/22 14:41, Peter Zijlstra wrote:
>>>>>>> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:

[...]

>>> Graphics Pipeline short task, hasn't uclamp_min been designed for and
>>> a better solution ?
>>
>> Yes, it has. I'm not sure how feasible this is to do for all tasks
>> involved. I'm thinking about the Binder threads here for instance.
> 
> Yes, that can probably not help for all threads but some system
> threads like surfaceflinger and graphic composer should probably
> benefit from min uclamp

Yes, and it looks like that the Android version I'm using
SQ1D.220205.004 (Feb '22) (automatic system updates turned off) is
already using uclamp_min != 0 for tasks like UI thread. It's not one
particular value but different values  from [0 .. 512] over the runtime
of a Jankbench iteration. I have to have a closer look.

[...]

>> Max_frame_duration:
>> +------------------------------------------+------------+
>> |             kernel                       |    value   |
>> +------------------------------------------+------------+
>> |            base-a30b17f016b0             | 147.571352 |
>> |                pelt-hl-m2                | 119.416351 |
>> |                pelt-hl-m4                | 96.473412  |
>> |       scaled_util_est_faster_freq        | 126.646506 |
>> | max_util_scaled_util_est_faster_rbl_freq | 157.974501 | <-- !!!
>> +------------------------------------------+------------+
>>
>> Mean_frame_duration:
>> +------------------------------------------+-------+-----------+
>> |                  kernel                  | value | perc_diff |
>> +------------------------------------------+-------+-----------+
>> |            base-a30b17f016b0             | 14.7  |   0.0%    |
>> |                pelt-hl-m2                | 13.6  |   -7.5%   |
>> |                pelt-hl-m4                | 13.0  |  -11.68%  |
>> |       scaled_util_est_faster_freq        | 13.7  |  -6.81%   |
>> | max_util_scaled_util_est_faster_rbl_freq | 12.1  |  -17.85%  |
>> +------------------------------------------+-------+-----------+
>>
>> Jank percentage (Jank deadline 16ms):
>> +------------------------------------------+-------+-----------+
>> |                  kernel                  | value | perc_diff |
>> +------------------------------------------+-------+-----------+
>> |            base-a30b17f016b0             |  1.8  |   0.0%    |
>> |                pelt-hl-m2                |  1.8  |  -4.91%   |
>> |                pelt-hl-m4                |  1.2  |  -36.61%  |
>> |       scaled_util_est_faster_freq        |  1.3  |  -27.63%  |
>> | max_util_scaled_util_est_faster_rbl_freq |  0.8  |  -54.86%  |
>> +------------------------------------------+-------+-----------+
>>
>> Power usage [mW] (total - all CPUs):
>> +------------------------------------------+-------+-----------+
>> |             kernel                       | value | perc_diff |
>> +------------------------------------------+-------+-----------+
>> |            base-a30b17f016b0             | 144.4 |   0.0%    |
>> |                pelt-hl-m2                | 141.6 |  -1.97%   |
>> |                pelt-hl-m4                | 163.2 |  12.99%   |
>> |       scaled_util_est_faster_freq        | 132.3 |  -8.41%   |
>> | max_util_scaled_util_est_faster_rbl_freq | 133.4 |  -7.67%   |
>> +------------------------------------------+-------+-----------+
>>
>> There is a regression in `Max_frame_duration` but `Mean_frame_duration`,
>> `Jank percentage` and `Power usage` are better.
> 
> The max frame duration is interesting. Could it be the very 1st frame
> of the test ?
> It's interesting that it's even worse than baseline whereas it should
> take the max of baseline and runnable_avg

Since you asked in the following email: I just used the boosting for CPU
frequency selection (from sugov_get_util()). I added the the `_freq`
suffix in the kernel name to indicate this.

I don't have any helpful `ftrace` or `perfetto` data for these test runs
though.

That's why I ran another iteration with perfetto on
`max_util_scaled_util_est_faster_rbl_freq`.

`Max frame duration` = 121ms (< 158ms but this was over 10 iterations)
happened at the beginning of the 3/8 `List View Fling` episode.

The UI thread (com.android.benchmark) runs on CPU1. Just before the
start of this episode the CPU freq is 0.3Ghz. It takes 43ms for the CPU
freq to go up to 1.1Ghz.

  oriole:/sys # cat devices/system/cpu/cpu1/cpu_capacity

  124

  oriole:/sys # cat devices/system/cpu/cpu1/cpufreq
  /scaling_available_frequencies

  300000 574000 738000 930000 1098000 1197000 1328000 1401000 1598000
  1704000 1803000

So the combination of little CPU and low CPU frequency is the reason
why. But I can't see how using `max(max(util_avg, util_est.enq),
rbl_avg) can make `max frame duration` worse?
Don't understand how asking for higher CPU frequencies in contention
favors the UI thread being scheduled on little CPUs at the beginning of
an episode?

Also the particular uclamp_min settings of the runnable tasks at this
moment can have an influence on this `max frame duration` value.

[...]
