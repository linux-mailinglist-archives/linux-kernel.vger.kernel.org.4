Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD164C46E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbiLNHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiLNHgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:36:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA12C178BA;
        Tue, 13 Dec 2022 23:36:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D15DAFEC;
        Tue, 13 Dec 2022 23:37:30 -0800 (PST)
Received: from [10.57.11.76] (unknown [10.57.11.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81643F5A1;
        Tue, 13 Dec 2022 23:36:46 -0800 (PST)
Message-ID: <b343821d-78b8-0c46-bf03-bfd645d99a2e@arm.com>
Date:   Wed, 14 Dec 2022 07:36:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 02/22] sched: Add interfaces for IPC classes
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-3-ricardo.neri-calderon@linux.intel.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221128132100.30253-3-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richardo,

I have some generic comment for the design of those interfaces.

On 11/28/22 13:20, Ricardo Neri wrote:
> Add the interfaces that architectures shall implement to convey the data
> to support IPC classes.
> 
> arch_update_ipcc() updates the IPC classification of the current task as
> given by hardware.
> 
> arch_get_ipcc_score() provides a performance score for a given IPC class
> when placed on a specific CPU. Higher scores indicate higher performance.
> 
> The number of classes and the score of each class of task are determined
> by hardware.
> 
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v1:
>   * Shortened the names of the IPCC interfaces (PeterZ):
>     sched_task_classes_enabled >> sched_ipcc_enabled
>     arch_has_task_classes >> arch_has_ipc_classes
>     arch_update_task_class >> arch_update_ipcc
>     arch_get_task_class_score >> arch_get_ipcc_score
>   * Removed smt_siblings_idle argument from arch_update_ipcc(). (PeterZ)
> ---
>   kernel/sched/sched.h    | 60 +++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/topology.c |  8 ++++++
>   2 files changed, 68 insertions(+)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b1d338a740e5..75e22baa2622 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2531,6 +2531,66 @@ void arch_scale_freq_tick(void)
>   }
>   #endif
>   
> +#ifdef CONFIG_IPC_CLASSES
> +DECLARE_STATIC_KEY_FALSE(sched_ipcc);
> +
> +static inline bool sched_ipcc_enabled(void)
> +{
> +	return static_branch_unlikely(&sched_ipcc);
> +}
> +
> +#ifndef arch_has_ipc_classes
> +/**
> + * arch_has_ipc_classes() - Check whether hardware supports IPC classes of tasks
> + *
> + * Returns: true of IPC classes of tasks are supported.
> + */
> +static __always_inline
> +bool arch_has_ipc_classes(void)
> +{
> +	return false;
> +}
> +#endif
> +
> +#ifndef arch_update_ipcc
> +/**
> + * arch_update_ipcc() - Update the IPC class of the current task
> + * @curr:		The current task
> + *
> + * Request that the IPC classification of @curr is updated.
> + *
> + * Returns: none
> + */
> +static __always_inline
> +void arch_update_ipcc(struct task_struct *curr)
> +{
> +}
> +#endif
> +
> +#ifndef arch_get_ipcc_score
> +/**
> + * arch_get_ipcc_score() - Get the IPC score of a class of task
> + * @ipcc:	The IPC class
> + * @cpu:	A CPU number
> + *
> + * Returns the performance score of an IPC class when running on @cpu.
> + * Error when either @class or @cpu are invalid.
> + */
> +static __always_inline
> +int arch_get_ipcc_score(unsigned short ipcc, int cpu)
> +{
> +	return 1;
> +}
> +#endif

Those interfaces are quite simple, probably work really OK with
your HW/FW. If any other architecture is going to re-use them
in future, we might face some issue. Let me explain why.

These kernel functions are start to be used very early in boot.
Your HW/FW is probably instantly ready to work from the very
beginning during boot. What is some other HW needs some
preparation code, like setup communication channel to FW or enable
needed clocks/events/etc.

What I would like to see is a similar mechanism to the one in schedutil.
Schedutil governor has to wait till cpufreq initialize the cpu freq
driver and policy objects (which sometimes takes ~2-3 sec). After that
cpufreq fwk starts the governor which populates this hook [1].
It's based on RCU mechanism with function pointer that can be then
called from the task scheduler when everything is ready to work.

If we (Arm) is going to use your proposed interfaces, we might need
different mechanisms because the platform likely would be ready after
our SCMI FW channels and cpufreq are setup.

Would it be possible to address such need now or I would have to
change that interface code later?

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/latest/source/kernel/sched/cpufreq.c#L29

