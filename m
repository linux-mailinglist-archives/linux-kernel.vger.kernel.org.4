Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF02D626184
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiKKSlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiKKSlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:41:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D04487162
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:39:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA22423A;
        Fri, 11 Nov 2022 10:38:52 -0800 (PST)
Received: from [10.1.197.38] (unknown [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1B473F703;
        Fri, 11 Nov 2022 10:38:44 -0800 (PST)
Message-ID: <f191bff5-b868-e008-376b-7b0a316dc5be@arm.com>
Date:   Fri, 11 Nov 2022 18:38:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/1] x86/resctrl: fix task closid/rmid update race
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>, reinette.chatre@intel.com,
        fenghua.yu@intel.com
Cc:     bp@alien8.de, derkling@google.com, eranian@google.com,
        hpa@zytor.com, jannh@google.com, kpsingh@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
References: <20221110135346.2209839-1-peternewman@google.com>
 <20221110135346.2209839-2-peternewman@google.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20221110135346.2209839-2-peternewman@google.com>
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

Hi Peter,

On 10/11/2022 13:53, Peter Newman wrote:
> When determining whether running tasks need to be interrupted due to a
> closid/rmid change, it was possible for the task in question to migrate
> or wake up concurrently without observing the updated values.
> 
> This was because stores updating the closid and rmid in the task
> structure could reorder with the loads in task_curr() and task_cpu().

Mentioning this happens in __rdtgroup_move_task() would make this easier to review.


> Similar reordering also impacted resctrl_sched_in(), where reading the
> updated values could reorder with prior stores to t->on_cpu.

Where does restrl_sched_in() depend on t->on_cpu?


> Instead, when moving a single task, use task_call_func() to serialize
> updates to the closid and rmid fields in the task_struct with context
> switch.
> 
> When deleting a group, just update the MSRs on all CPUs rather than
> calling task_call_func() on every task in a potentially long list while
> read-locking the tasklist_lock.

This rmdir stuff feels like something that should go in a preparatory patch with an
expanded justification. (the stuff in the comment below). Real-time users may care about
unconditionally IPIing all CPUs, but I suspect changes to resctrl while the system is
running aren't realistic.

A group of smaller patches that make independent changes is easier to review than one big
one! (especially as some of those changes are mechanical)


> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e5a48f05e787..d645f9a6c22e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -538,12 +538,38 @@ static void _update_task_closid_rmid(void *task)
>  		resctrl_sched_in();
>  }
>  
> -static void update_task_closid_rmid(struct task_struct *t)
> +static int update_locked_task_closid_rmid(struct task_struct *t, void *arg)
>  {
> -	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
> -		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
> -	else
> -		_update_task_closid_rmid(t);

[...]

>  static int __rdtgroup_move_task(struct task_struct *tsk,
> @@ -557,39 +583,26 @@ static int __rdtgroup_move_task(struct task_struct *tsk,

> -	update_task_closid_rmid(tsk);
> +	if (update_task_closid_rmid(tsk, rdtgrp) && IS_ENABLED(CONFIG_SMP))
> +		/*
> +		 * If the task has migrated away from the CPU indicated by
> +		 * task_cpu() below, then it has already switched in on the
> +		 * new CPU using the updated closid and rmid and the call below
> +		 * unnecessary, but harmless.
> +		 */
> +		smp_call_function_single(task_cpu(tsk),
> +					 _update_task_closid_rmid, tsk, 1);
> +	else
> +		_update_task_closid_rmid(tsk);

I think it would result in less churn if you kept this chunk in update_task_closid_rmid().


>  	return 0;
>  }
> @@ -2385,12 +2398,13 @@ static int reset_all_ctrls(struct rdt_resource *r)
>   * Move tasks from one to the other group. If @from is NULL, then all tasks
>   * in the systems are moved unconditionally (used for teardown).
>   *
> - * If @mask is not NULL the cpus on which moved tasks are running are set
> - * in that mask so the update smp function call is restricted to affected
> - * cpus.
> + * Following this operation, the caller is required to update the MSRs on all
> + * CPUs. The cost of constructing the precise mask of CPUs impacted by this
> + * operation will likely be high, during which we'll be blocking writes to the
> + * tasklist, and in non-trivial cases, the resulting mask would contain most of
> + * the CPUs anyways.

This is the argument for not building the mask. I think it would be better placed in the
commit message of a patch that removes that support. It's not really necessary for new
users to read about what the function doesn't do....


With the caveat that I don't understand memory ordering:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
