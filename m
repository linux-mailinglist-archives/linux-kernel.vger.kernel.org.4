Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAA6722DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjARQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjARQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:20:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A71D54B2E;
        Wed, 18 Jan 2023 08:17:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7C25AD7;
        Wed, 18 Jan 2023 08:18:24 -0800 (PST)
Received: from [10.1.196.21] (e125579.cambridge.arm.com [10.1.196.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4F963F67D;
        Wed, 18 Jan 2023 08:17:40 -0800 (PST)
Message-ID: <69457060-ede6-c805-af1d-a6e2b05fd55e@arm.com>
Date:   Wed, 18 Jan 2023 16:17:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
References: <20230113134056.257691-1-vincent.guittot@linaro.org>
 <78bf2d91-0076-f748-7c6a-530dad466787@arm.com>
 <20230117163841.d5jv6ysqf5kmvvmh@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230117163841.d5jv6ysqf5kmvvmh@airbuntu>
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

On 17/01/2023 16:38, Qais Yousef wrote:
> On 01/16/23 09:07, Dietmar Eggemann wrote:
> 
> [...]
> 
>> Not sure if people get what `performance requirements` mean here? I know
>> we want to use `performance` rather `bandwidth hint` to describe what
>> uclamp is. So shouldn't we use `utilization but also uclamp`?
> 
> We do have the uclamp doc now which explains this, no? I'm not keen on
> utilization because it's an overloaded term. In the context of uclamp

And `performance` isn't ? ;-) True, the doc refers to uclamp as a
`performance requirements`.

> - utilization _signal_ in the scheduler is used to indicate performance
> requirements of a workload, no?

I was referring to:

 4569 static inline int task_fits_cpu(struct task_struct *p, int cpu)
 4570 {
 4571   unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
 4572   unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
 4573   unsigned long util = task_util_est(p);
 4574   /*
 4575   * Return true only if the cpu fully fits the task requirements,
 4576   * which include the utilization but also the performance.
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 4577   */
 4578   return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
 4579 }

So here we explicitly talk about `utilization` (util_avg/util_est)
versus `uclamp (max/min)` and the latter is referred as `performance`.
You're right, we shouldn't refer to `uclamp (min/max)` as `utilization`
either.

In other places we use:

select_idle_capacity()

/* This CPU fits with all capacity and performance requirements */
                          ^^^^^^^^     ^^^^^^^^^^^^^^^^^^^^^^^^

`capacity` is probably equal `utilization`? and `performance
requirements` stand for `uclamp (min/max)`.

/* Only the min performance (i.e. uclamp_min) doesn't fit */
            ^^^^^^^^^^^^^^^
here we link `min performance` explicitly to `uclamp_min`.

/* Look for the CPU with highest performance capacity.
                                 ^^^^^^^^^^^^^^^^^^^^
I guess this stands for `cap_orig - thermal_load_avg()`

feec()

/* Both don't fit performance (i.e. uclamp_min) but best energy cpu has
                  ^^^^^^^^^^^  ^^^^^^^^^^^^^^^
better performance. */
^^^^^^ ^^^^^^^^^^^

Here I assume `better performance` stands for higher `cap_orig -
thermal_pressure', not for `uclamp min or max`?

---

IMHO, referring to `uclamp (min/max)` as `performance (min/max)
hint/(requirement)` is fine as long as it's done consistently in
comments and the alias is not used for other items.

> 
> Using 'uclamp hint' if you found it really confusing, is fine by me. But I'd
> rather steer away from 'bandwidth' or 'utilization' when describing uclamp and
> its intention.
> 
> I like using performance requirements because it enforces what this hint
> actually means.

