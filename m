Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5162F68A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiKRNqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiKRNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:46:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B3487640;
        Fri, 18 Nov 2022 05:46:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F45623A;
        Fri, 18 Nov 2022 05:46:11 -0800 (PST)
Received: from [10.0.2.87] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91DE53F587;
        Fri, 18 Nov 2022 05:46:01 -0800 (PST)
Message-ID: <3bf8bbf1-c2bc-3199-2cee-99a1e3e920c7@arm.com>
Date:   Fri, 18 Nov 2022 14:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] sched/topology: Remove EM_MAX_COMPLEXITY limit
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz Luba <lukasz.luba@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-doc@vger.kernel.org
References: <20221028153032.395898-1-pierre.gondois@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221028153032.395898-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 17:30, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> The Energy Aware Scheduler (EAS) estimates the energy consumption
> of placing a task on different CPUs. The goal is to minimize this
> energy consumption. Estimating the energy of different task placements
> is increasingly complex with the size of the platform. To avoid having
> a slow wake-up path, EAS is only enabled if this complexity is low
> enough.
> 
> The current complexity limit was set in:
> commit b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate
> platforms").
> base on the first implementation of EAS, which was re-computing
> the power of the whole platform for each task placement scenario, cf:
> commit 390031e4c309 ("sched/fair: Introduce an energy estimation helper
> function").
> but the complexity of EAS was reduced in:
> commit eb92692b2544d ("sched/fair: Speed-up energy-aware wake-ups")
> and find_energy_efficient_cpu() (feec) algorithm was updated in:
> commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective
> utilization in feec()")
> 
> find_energy_efficient_cpu() (feec) is now doing:
> feec()
> \_ for_each_pd(pd) [0]
>   // get max_spare_cap_cpu and compute_prev_delta
>   \_ for_each_cpu(pd) [1]
> 
>   \_ eenv_pd_busy_time(pd) [2]
> 	\_ for_each_cpu(pd)
> 
>   // compute_energy(pd) without the task
>   \_ eenv_pd_max_util(pd, -1) [3.0]
>     \_ for_each_cpu(pd)
>   \_ em_cpu_energy(pd, -1)
>     \_ for_each_ps(pd)
> 
>   // compute_energy(pd) with the task on prev_cpu
>   \_ eenv_pd_max_util(pd, prev_cpu) [3.1]
>     \_ for_each_cpu(pd)
>   \_ em_cpu_energy(pd, prev_cpu)
>     \_ for_each_ps(pd)
> 
>   // compute_energy(pd) with the task on max_spare_cap_cpu
>   \_ eenv_pd_max_util(pd, max_spare_cap_cpu) [3.2]
>     \_ for_each_cpu(pd)
>   \_ em_cpu_energy(pd, max_spare_cap_cpu)
>     \_ for_each_ps(pd)
> 
> [3.1] happens only once since prev_cpu is unique. With the same
> definitions for nr_pd, nr_cpus and nr_ps, the complexity is of:
> nr_pd * (2 * [nr_cpus in pd] + 2 * ([nr_cpus in pd] + [nr_ps in pd]))
> + ([nr_cpus in pd] + [nr_ps in pd])
> 
>  [0]  * (     [1] + [2]      +       [3.0] + [3.2]                  )
> + [3.1]
> 
> = nr_pd * (4 * [nr_cpus in pd] + 2 * [nr_ps in pd])
> + [nr_cpus in prev pd] + nr_ps
> 
> The complexity limit was set to 2048 in:
> commit b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate
> platforms")
> to make "EAS usable up to 16 CPUs with per-CPU DVFS and less than 8
> performance states each". For the same platform, the complexity would
> actually be of:
> 16 * (4 + 2 * 7) + 1 + 7 = 296
> 
> Since the EAS complexity was greatly reduced, bigger platforms can
> handle EAS. For instance, a platform with 112 CPUs with 7 performance
> states each would not reach it:
> 112 * (4 + 2 * 7) + 1 + 7 = 2024
> 
> To reflect this improvement, remove the EAS complexity check.
> 
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

OK, let's remove the specific EAS EM complexity check in this case.

But we should still have some info about the decission that EAS is now
only constraint by EM's own EM_MAX_NUM_CPUS in terms of complexity.

So maybe replace `6.3 - Energy Model complexity` by:

EAS does not impose any complexity limit on numbers of CPUs but relies
on EM's own EM_MAX_NUM_CPUS.

And also mention this fact in the patch-header for future reference
regarding this change.

[...]
