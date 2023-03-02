Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293F96A8988
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCBTgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCBTgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:36:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BDC54DBFD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:36:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 479122F4;
        Thu,  2 Mar 2023 11:37:25 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F02523F587;
        Thu,  2 Mar 2023 11:36:39 -0800 (PST)
Message-ID: <c81955c0-5f2e-e0e9-1a9a-5d005066df06@arm.com>
Date:   Thu, 2 Mar 2023 20:36:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
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
 <36bfd828-5af7-3bcb-d642-3361820c6071@arm.com>
Content-Language: en-US
In-Reply-To: <36bfd828-5af7-3bcb-d642-3361820c6071@arm.com>
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

On 22/02/2023 21:13, Dietmar Eggemann wrote:
> On 20/02/2023 14:54, Vincent Guittot wrote:
>> On Fri, 17 Feb 2023 at 14:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 09/02/2023 17:16, Vincent Guittot wrote:
>>>> On Tue, 7 Feb 2023 at 11:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>>
>>>>> On 09/11/2022 16:49, Peter Zijlstra wrote:
>>>>>> On Tue, Nov 08, 2022 at 07:48:43PM +0000, Qais Yousef wrote:
>>>>>>> On 11/07/22 14:41, Peter Zijlstra wrote:
>>>>>>>> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:
> 
> [...]
> 
>>>> Graphics Pipeline short task, hasn't uclamp_min been designed for and
>>>> a better solution ?
>>>
>>> Yes, it has. I'm not sure how feasible this is to do for all tasks
>>> involved. I'm thinking about the Binder threads here for instance.
>>
>> Yes, that can probably not help for all threads but some system
>> threads like surfaceflinger and graphic composer should probably
>> benefit from min uclamp
> 
> Yes, and it looks like that the Android version I'm using
> SQ1D.220205.004 (Feb '22) (automatic system updates turned off) is
> already using uclamp_min != 0 for tasks like UI thread. It's not one
> particular value but different values  from [0 .. 512] over the runtime
> of a Jankbench iteration. I have to have a closer look.

I did more Jankbench and Speedometer testing especially to understand
the influence of the already used uclamp_min boosting (Android Dynamic
Performance Framework (ADPF) `CPU performance hints` feature:
https://developer.android.com/games/optimize/adpf#cpu-hints) for some
App tasks.

The following notebooks show which of the App tasks are uclamp_min
boosted (their diagram title carries an additional 'uclamp_min_boost'
tag and how uclamp_min boost relates to the other boost values:
This is probably not a fixed mapping and could change between test runs.
I assume that Android will issue performance hints in form of uclamp_min
boosting when it detects certain scenarios like a specific jankframe
threshold or something similar.

https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/jankbench_uclamp_min_boost.ipynb

https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/speedometer_uclamp_min_boost.ipynb

`base` has changed compared to `base-a30b17f016b0`. It now also
contains: e5ed0550c04c - sched/fair: unlink misfit task from cpu
overutilized (2023-02-11 Vincent Guittot)

Former `max_util_scaled_util_est_faster_rbl_freq` has been renamed to
`cpu_rbl_freq`.

Jankbench:

Max_frame_duration:
+-----------------------------+------------+
|             kernel          |    value   |
+-----------------------------+------------+
|            base             | 156.299159 |
|       base_wo_uclamp        | 171.063764 | uclamp disabled*
|         pelt-hl-m2          | 126.190232 |
|         pelt-hl-m4          | 100.865171 |
| scaled_util_est_faster_freq | 126.074194 |
|        cpu_rbl_freq         | 153.123089 |
+-----------------------------+------------+

* We still let Android set the uclamp_min values.
Just the uclamp setter are bypassed now.

Mean_frame_duration:
+-----------------------------+-------+-----------+
|           kernel            | value | perc_diff |
+-----------------------------+-------+-----------+
|            base             | 15.5  |   0.0%    |
|       base_wo_uclamp        | 16.6  |   7.76%   |
|         pelt-hl-m2          | 14.9  |  -3.27%   |
|         pelt-hl-m4          | 13.6  |  -12.16%  |
| scaled_util_est_faster_freq | 14.7  |  -4.88%   |
|        cpu_rbl_freq         | 12.2  |  -20.84%  |
+-----------------------------+-------+-----------+

Jank percentage (Jank deadline 16ms):
+-----------------------------+-------+-----------+
|           kernel            | value | perc_diff |
+-----------------------------+-------+-----------+
|            base             |  2.6  |   0.0%    |
|       base_wo_uclamp        |  3.0  |  17.47%   |
|         pelt-hl-m2          |  2.0  |  -23.33%  |
|         pelt-hl-m4          |  1.3  |  -48.55%  |
| scaled_util_est_faster_freq |  1.7  |  -32.21%  |
|        cpu_rbl_freq         |  0.7  |  -71.36%  |
+-----------------------------+-------+-----------+

Power usage [mW] (total - all CPUs):
+-----------------------------+-------+-----------+
|           kernel            | value | perc_diff |
+-----------------------------+-------+-----------+
|            base             | 141.1 |   0.0%    |
|       base_wo_uclamp        | 116.6 |  -17.4%   |
|         pelt-hl-m2          | 138.7 |   -1.7%   |
|         pelt-hl-m4          | 156.5 |  10.87%   |
| scaled_util_est_faster_freq | 147.6 |   4.57%   |
|        cpu_rbl_freq         | 135.0 |  -4.33%   |
+-----------------------------+-------+-----------+

Speedometer:

Score:
+-----------------------------+-------+-----------+
|           kernel            | value | perc_diff |
+-----------------------------+-------+-----------+
|            base             | 108.4 |   0.0%    |
|       base_wo_uclamp        | 95.2  |  -12.17%  |
|         pelt-hl-m2          | 112.9 |   4.13%   |
| scaled_util_est_faster_freq | 114.7 |   5.77%   |
|        cpu_rbl_freq         | 127.7 |  17.75%   |
+-----------------------------+-------+-----------+

Power usage [mW] (total - all CPUs):
+-----------------------------+--------+-----------+
|           kernel            | value  | perc_diff |
+-----------------------------+--------+-----------+
|            base             | 2268.4 |   0.0%    |
|       base_wo_uclamp        | 1789.5 |  -21.11%  |
|         pelt-hl-m2          | 2386.5 |   5.21%   |
| scaled_util_est_faster_freq | 2292.3 |   1.05%   |
|        cpu_rbl_freq         | 2198.3 |  -3.09%   |
+-----------------------------+--------+-----------+

The explanation I have is that the `CPU performance hints` feature
tries to recreate the information about contention for a specific set of
tasks. Since there is also contention in which only non uclamp_min
boosted tasks are runnable, mechanisms like `util_est_faster` or
`cpu_runnable boosting` can help on top of what's already provided with
uclamp_min boosting from userspace.

[...]

