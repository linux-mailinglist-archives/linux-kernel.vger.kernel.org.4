Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61F36A899B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCBTj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjCBTjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:39:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3219230EA3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:39:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B10B2F4;
        Thu,  2 Mar 2023 11:40:23 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C32113F587;
        Thu,  2 Mar 2023 11:39:37 -0800 (PST)
Message-ID: <7afae848-fab2-9403-62cc-6ad799eee47f@arm.com>
Date:   Thu, 2 Mar 2023 20:39:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
References: <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <20230223153700.55zydy7jyfwidkis@airbuntu>
 <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
 <20230301172458.intrgsirjauzqmo3@airbuntu>
 <CAKfTPtDwDdpiQnUqi_OtER5EE0EN4ykDMqtwzHi3d7AyBd_aQA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtDwDdpiQnUqi_OtER5EE0EN4ykDMqtwzHi3d7AyBd_aQA@mail.gmail.com>
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

On 02/03/2023 09:00, Vincent Guittot wrote:
> On Wed, 1 Mar 2023 at 18:25, Qais Yousef <qyousef@layalina.io> wrote:
>>
>> On 03/01/23 11:39, Vincent Guittot wrote:
>>> On Thu, 23 Feb 2023 at 16:37, Qais Yousef <qyousef@layalina.io> wrote:
>>>>
>>>> On 02/09/23 17:16, Vincent Guittot wrote:

[...]

>>>> Just to understand why we're heading into this direction now.
>>>>
>>>> AFAIU the desired outcome to have faster rampup time (and on HMP faster up
>>>> migration) which both are tied to utilization signal.
>>>>
>>>> Wouldn't make the util response time faster help not just for rampup, but
>>>> rampdown too?
>>>>
>>>> If we improve util response time, couldn't this mean we can remove util_est or
>>>> am I missing something?
>>>
>>> not sure because you still have a ramping step whereas util_est
>>> directly gives you the final tager
>>
>> I didn't get you. tager?
> 
> target

uclamp_min boosting (ADPF's `CPU performance hints` feature) could
eclipse util_est but only if it's higher and only for those tasks
affected the feature,

[...]

>>>> I think if we can allow improving general util response time by tweaking PELT
>>>> HALFLIFE we can potentially remove util_est and potentially that magic 25%
>>>> margin too.
>>>>
>>>> Why the approach of further tweaking util_est is better?
>>>
>>> note that in this case it doesn't really tweak util_est but Dietmar
>>> has taken into account runnable_avg to increase the freq in case of
>>> contention
>>>
>>> Also IIUC Dietmar's results, the problem seems more linked to the
>>> selection of a higher freq than increasing the utilization;
>>> runnable_avg tests give similar perf results than shorter half life
>>> and better power consumption.
>>
>> Does it ramp down faster too?
> 
> I don't think so.
> 
> To be honest, I'm not convinced that modifying the half time is the
> right way to solve this. If it was only a matter of half life not
> being suitable for a system, the halk life would be set once at boot
> and people would not ask to modify it at run time.

IMHO, what people don't like about PELT halflife mods is the fact that
all sched entities and every functionality based on PELT signals would
be affected even though it might not be beneficial or even harmful for
system behaviour not covered by the specific benchmark numbers shown.

That's why we wanted to figure out what is the actual reason which
improves those Jankbench (or Speedometer resp. game FPS numbers). In
this case we would be able to boost more selectively than PELT halflife
modding can do.

Util_est_faster (1) is an approach to only boost the CPU util signal
depending on the current task's activation duration (sum of task's
running time). This time is multiplied by 2 when calculating the fake
PELT signal which is then max-compared with the existing CPU util.

And the idea to max-compare CPU util and CPU runnable (2) is to help
tasks under contention. Android testing showed that contention very
often accompanies jankframe occurrences for example.

I only applied (1) and (2) to DVFS requests in my testing.

[...]
