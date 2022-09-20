Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726415BECAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiITSSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiITSSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:18:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F37467CBA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:17:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 491CE143D;
        Tue, 20 Sep 2022 11:18:03 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7BBC3F5A1;
        Tue, 20 Sep 2022 11:17:53 -0700 (PDT)
Message-ID: <07193d97-476a-498f-e738-e7920c2fdeea@arm.com>
Date:   Tue, 20 Sep 2022 20:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org>
 <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 17:49, Vincent Guittot wrote:
> On Mon, 19 Sept 2022 at 13:55, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> s/valentin.schneider@arm.com//
>>
>> On 16/09/2022 10:03, Vincent Guittot wrote:
>>> Task can set its latency priority, which is then used to decide to preempt
>>> the current running entity of the cfs, but sched group entities still have
>>> the default latency offset.
>>>
>>> Add a latency field in task group to set the latency offset of the
>>> sched_eneities of the group, which will be used against other entities in
>>
>> s/sched_eneities/sched_entity
>>
>>> the parent cfs when deciding which entity to schedule first.
>>
>> So latency for cgroups does not follow any (existing) Resource
>> Distribution Model/Scheme (Documentation/admin-guide/cgroup-v2.rst)?
>> Latency values are only used to compare sched entities at the same level.
> 
> Just like share/cpu.weight value does for time sharing

But for this we define it as following the `Weights` scheme. That's why
I was asking,

>> [...]
>>
>>> +static int cpu_latency_write_s64(struct cgroup_subsys_state *css,
>>> +                             struct cftype *cft, s64 latency)
>>> +{
>>
>> There is no [MIN, MAX] checking?
> 
> This is done is sched_group_set_latency() which checks that
> abs(latency) < sysctl_sched_latency

I see. Nit-picking: Wouldn't this allow to specify a latency offset
value for the non-existent `nice = 20`? Highest nice value 19 maps to
`973/1024 * sysctl_sched_latency`.

> 
>>
>> min_weight = sched_latency_to_weight[0]  = -1024
>> max_weight = sched_latency_to_weight[39] =   973
>>
>> [MIN, MAX] = [sysctl_sched_latency * min_weight >> NICE_LATENCY_SHIFT,
>>               sysctl_sched_latency * max_weight >> NICE_LATENCY_SHIFT]
>>
>>
>> With the `cpu.latency` knob user would have to know for example that the
>> value is -24,000,000ns to get the same behaviour as for a task latency
>> nice = -20 (latency prio = 0) (w/ sysctl_sched_latency = 24ms)?
> 
> Yes, Tejun raised some concerns about adding an interface like nice in
> the task group in v2 so I have removed it.
> 
>>
>> For `nice` we have `cpu.weight.nice` next to `cpu.weight` in cgroup v2 ?
> 
> If everybody is ok, I can add back the cpu.latency.nice interface in
> the v5 in addition to the cpu.latency

cpu.weight/cpu.weight.nice interface:

echo X > cpu.weight	   tg->shares

    1                          10,240
  100                       1,048,576
10000                     104,857,600

echo X > cpu.weight.nice

  -20                     90,891,264
    0                      1,048,576
   19                         15,360

Wouldn't then a similar interface for cpu.latency [1..100..10000] and
cpu.latency.nice [-20..0..19] make most sense?

Raw latency_offset values at interface level are not portable.


