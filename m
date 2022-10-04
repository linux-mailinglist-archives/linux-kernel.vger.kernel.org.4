Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA695F3FF1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiJDJjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJDJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:38:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A609455096
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:34:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 336C512FC;
        Tue,  4 Oct 2022 02:33:54 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 284643F67D;
        Tue,  4 Oct 2022 02:33:45 -0700 (PDT)
Message-ID: <2a8b0887-503d-0350-7364-9c1c9293a793@arm.com>
Date:   Tue, 4 Oct 2022 11:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Content-Language: en-US
To:     Wei Wang <wvw@google.com>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>,
        "Chung-Kai (Michael) Mei" <chungkai@google.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <CAGXk5yoC+whmLQn-KvUE3_rGGj4jodsKushr5LmtPK0mi6DFEQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAGXk5yoC+whmLQn-KvUE3_rGGj4jodsKushr5LmtPK0mi6DFEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On 04/10/2022 00:57, Wei Wang wrote:

Please don't do top-posting.

> We have some data on an earlier build of Pixel 6a, which also runs a
> slightly modified "sched" governor. The tuning definitely has both
> performance and power impact on UX. With some additional user space
> hints such as ADPF (Android Dynamic Performance Framework) and/or the
> old-fashioned INTERACTION power hint, different trade-offs can be
> archived with this sort of tuning.
> 
> 
> +---------------------------------------------------------+----------+----------+
> |                         Metrics                         |   32ms   |
>   8ms    |
> +---------------------------------------------------------+----------+----------+
> | Sum of gfxinfo_com.android.test.uibench_deadline_missed |   185.00 |
>   112.00 |
> | Sum of SFSTATS_GLOBAL_MISSEDFRAMES                      |    62.00 |
>    49.00 |
> | CPU Power                                               | 6,204.00 |
> 7,040.00 |
> | Sum of Gfxinfo.frame.95th                               |   582.00 | 
>   506.00 |
> | Avg of Gfxinfo.frame.95th                               |    18.19 |
>    15.81 |
> +---------------------------------------------------------+----------+----------+

Which App is package `gfxinfo_com.android.test`? Is this UIBench? Never
ran it.

I'm familiar with `dumpsys gfxinfo <PACKAGE_NAME>`.

# adb shell dumpsys gfxinfo <PACKAGE_NAME>

...
** Graphics info for pid XXXX [<PACKAGE_NAME>] **
...
95th percentile: XXms            <-- (a)
...
Number Frame deadline missed: XX <-- (b)
...


I assume that `Gfxinfo.frame.95th` is related to (a) and
`gfxinfo_com.android.test.uibench_deadline_missed` to (b)? Not sure
where `SFSTATS_GLOBAL_MISSEDFRAMES` is coming from?

What's the Sum here? Is it that you ran the test 32 times (582/18.19 = 32)?

[...]

> On Thu, Sep 29, 2022 at 11:59 PM Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
>>
>> On Thu, Sep 29, 2022 at 01:21:45PM +0200, Peter Zijlstra wrote:
>>> On Thu, Sep 29, 2022 at 12:10:17PM +0100, Kajetan Puchalski wrote:
>>>
>>>> Overall, the problem being solved here is that based on our testing the
>>>> PELT half life can occasionally be too slow to keep up in scenarios
>>>> where many frames need to be rendered quickly, especially on high-refresh
>>>> rate phones and similar devices.
>>>
>>> But it is a problem of DVFS not ramping up quick enough; or of the
>>> load-balancer not reacting to the increase in load, or what aspect
>>> controlled by PELT is responsible for the improvement seen?
>>
>> Based on all the tests we've seen, jankbench or otherwise, the
>> improvement can mainly be attributed to the faster ramp up of frequency
>> caused by the shorter PELT window while using schedutil. Alongside that
>> the signals rising faster also mean that the task would get migrated
>> faster to bigger CPUs on big.LITTLE systems which improves things too
>> but it's mostly the frequency aspect of it.
>>
>> To establish that this benchmark is sensitive to frequency I ran some
>> tests using the 'performance' cpufreq governor.
>>
>> Max frame duration (ms)
>>
>> +------------------+-------------+----------+
>> | kernel           |   iteration |    value |
>> |------------------+-------------+----------|
>> | pelt_1           |          10 | 157.426  |
>> | pelt_4           |          10 |  85.2713 |
>> | performance      |          10 |  40.9308 |
>> +------------------+-------------+----------+
>>
>> Mean frame duration (ms)
>>
>> +---------------+------------------+---------+-------------+
>> | variable      | kernel           |   value | perc_diff   |
>> |---------------+------------------+---------+-------------|
>> | mean_duration | pelt_1           |    14.6 | 0.0%        |
>> | mean_duration | pelt_4           |    14.5 | -0.58%      |
>> | mean_duration | performance      |     4.4 | -69.75%     |
>> +---------------+------------------+---------+-------------+
>>
>> Jank percentage
>>
>> +------------+------------------+---------+-------------+
>> | variable   | kernel           |   value | perc_diff   |
>> |------------+------------------+---------+-------------|
>> | jank_perc  | pelt_1           |     2.1 | 0.0%        |
>> | jank_perc  | pelt_4           |     2   | -3.46%      |
>> | jank_perc  | performance      |     0.1 | -97.25%     |
>> +------------+------------------+---------+-------------+
>>
>> As you can see, bumping up frequency can hugely improve the results
>> here. This is what's happening when we decrease the PELT window, just on
>> a much smaller and not as drastic scale. It also explains specifically
>> where the increased power usage is coming from.

