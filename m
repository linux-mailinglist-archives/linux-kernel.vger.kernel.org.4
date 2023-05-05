Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB86F888A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjEESQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEESQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:16:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A13819D5F
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:16:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE5291FB;
        Fri,  5 May 2023 11:17:18 -0700 (PDT)
Received: from [192.168.178.92] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E63983F67D;
        Fri,  5 May 2023 11:16:32 -0700 (PDT)
Message-ID: <11e07f3a-3576-f408-1891-2dca5ddf343e@arm.com>
Date:   Fri, 5 May 2023 20:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
 <20230406155030.1989554-2-dietmar.eggemann@arm.com>
 <CAKfTPtDh_aQn15to7E9JypVXarFVcEL+jiWJMV6J7-Gijj9SyQ@mail.gmail.com>
 <f4501e45-3cfc-b605-b065-5693427ab877@arm.com>
 <CAKfTPtBcT8KbH=r2zCgqBF7V7cp=REceiyWWjjCc8FD2btO-=A@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtBcT8KbH=r2zCgqBF7V7cp=REceiyWWjjCc8FD2btO-=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 10:22, Vincent Guittot wrote:
> On Thu, 4 May 2023 at 19:11, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 03/05/2023 18:08, Vincent Guittot wrote:
>>> On Thu, 6 Apr 2023 at 17:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

[...]

>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>>> index e3211455b203..728b186cd367 100644
>>>> --- a/kernel/sched/cpufreq_schedutil.c
>>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>>> @@ -158,7 +158,8 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>>>>         struct rq *rq = cpu_rq(sg_cpu->cpu);
>>>>
>>>>         sg_cpu->bw_dl = cpu_bw_dl(rq);
>>>> -       sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
>>>> +       sg_cpu->util = effective_cpu_util(sg_cpu->cpu,
>>>> +                                         cpu_boosted_util_cfs(sg_cpu->cpu),
>>>
>>> Shouldn't we have a similar change in feec to estimate correctly which
>>> OPP/ freq will be selected by schedutil ?
>>
>> Yes, this should be more correct. Schedutil and EAS should see the world
>> the same way.
>>
>> But IMHO only for the
>>
>> find_energy_efficient_cpu()
>>   compute_energy()
>>     eenv_pd_max_util()
>>       util = cpu_util_next(..., p, ...)
>>       effective_cpu_util(..., util, FREQUENCY_UTIL, ...)
>>                                     ^^^^^^^^^^^^^^
> yes only to get same max utilization and as a result the same OPP as schedutil
> 
>> case.
>>
>> Not sure what I do for the task contribution? We use
>> task_util(p)/_task_util_est(p) inside cpu_util_next().
>> Do I have to consider p->se.avg.runnable_avg as well?
> 
> hmm, I would stay with util_avg for now

OK, in this case I'm trying  to refactor cpu_util_next() so that
cpu_util_cfs() can call it as well. This will allow me to code the
runnable boosting only once in cpu_util_next().
Boosting can then be enabled via an additional `int boost` parameter for
cpu_util_next() and cpu_util_cfs().
