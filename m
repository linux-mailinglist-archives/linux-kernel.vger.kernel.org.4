Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B9469FCFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBVU3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjBVU3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:29:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 123941B30D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:29:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8713FEC;
        Wed, 22 Feb 2023 12:29:48 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 982683F703;
        Wed, 22 Feb 2023 12:29:03 -0800 (PST)
Message-ID: <94eeb587-e9c9-1d92-7fd3-edde46fd4dba@arm.com>
Date:   Wed, 22 Feb 2023 21:28:54 +0100
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
 <CAKfTPtCdoAtQUJgSGgCZtCWhtv0_WgDrBpGSRTwHG=SV_Jf4ew@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtCdoAtQUJgSGgCZtCWhtv0_WgDrBpGSRTwHG=SV_Jf4ew@mail.gmail.com>
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

On 21/02/2023 10:29, Vincent Guittot wrote:
> On Mon, 20 Feb 2023 at 14:54, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> On Fri, 17 Feb 2023 at 14:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 09/02/2023 17:16, Vincent Guittot wrote:
>>>> On Tue, 7 Feb 2023 at 11:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>>
>>>>> On 09/11/2022 16:49, Peter Zijlstra wrote:
>>>>>> On Tue, Nov 08, 2022 at 07:48:43PM +0000, Qais Yousef wrote:
>>>>>>> On 11/07/22 14:41, Peter Zijlstra wrote:
>>>>>>>> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:

[...]

>>> I ran the same test (boosting only for DVFS requests) with:
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ *
>>>
>>> -->8--
>>>
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index dbc56e8b85f9..7a4bf38f2920 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -2946,6 +2946,8 @@ static inline unsigned long cpu_util_cfs(int cpu)
>>>                              READ_ONCE(cfs_rq->avg.util_est.enqueued));
>>>         }
>>>
>>> +       util = max(util, READ_ONCE(cfs_rq->avg.runnable_avg));
>>> +
> 
> Another reason why it gives better results could be that
> cpu_util_cfs() is not only used for DVFS selection but also to track
> the cpu utilization in load balance and EAS so the cpu will be faster
> seen as overloaded and tasks will be spread around when there are
> contentions.
> 
> Could you try to take cfs_rq->avg.runnable_avg into account only when
> selecting frequency ?

I actually did exactly this. (* but not shown in the code snippet).
I just used the boosting for CPU frequency selection (from
sugov_get_util()). I added the the `_freq` suffix in the kernel name to
indicate this.

> That being said I can see some place in load balance where
> cfs_rq->avg.runnable_avg could give some benefits like in
> find_busiest_queue() where it could be better to take into account the
> contention when selecting the busiest queue

Could be. Looks like so far we only use it in group_has_capacity(),
group_is_overloaded() and for NUMA.

[...]
