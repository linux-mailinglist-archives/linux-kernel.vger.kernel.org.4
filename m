Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8063C7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiK2TSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiK2TSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:18:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0E81DF37;
        Tue, 29 Nov 2022 11:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43E81B818A9;
        Tue, 29 Nov 2022 19:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FC6C43152;
        Tue, 29 Nov 2022 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669749496;
        bh=/Gzf5VjkGbrloDTfPxv9l92KDFa+IDXWjOaC6u0x8Ow=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nqD9B2jDz5Wk4t168uyU//16IO+pqrlKydrrB+BdcaGU13pUT7rgEq58N60eEr0xC
         Q/xY/FJhGv9T8R5nFT7UbWn26+mwhZkscN+nnowowF4HPiEcuqUorq9M5dwEjt043S
         WjE4aLkV63D+JKyDurx6SbiKc7A1z75LkkXKokzGMUprvcWnFdegxFpQceDZM0v85W
         looTtVibLGMFbJfwV1IOOxp9ZtjMgA/CfWP8vH/M1hubiyCPP8n5QDygGE98EgGpbL
         //KwrhjBPiku8eXr8/JKIFvDraCSZbebPl+hEpfsjoVJSv+v9moMCcDkqP6KBRCj9g
         LHSYBr0MeYiGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 62B505C0584; Tue, 29 Nov 2022 11:18:16 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:18:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Message-ID: <20221129191816.GA388190@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221129151810.GY4001@paulmck-ThinkPad-P17-Gen-1>
 <9299CE62-C7B6-45F5-BD07-C1CB02F0D08C@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9299CE62-C7B6-45F5-BD07-C1CB02F0D08C@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:00:05AM -0500, Joel Fernandes wrote:
> 
> 
> > On Nov 29, 2022, at 10:18 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Tue, Nov 29, 2022 at 06:25:04AM +0000, Zhang, Qiang1 wrote:
> >>>> On Nov 28, 2022, at 11:54 PM, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
> >>> 
> >>> ﻿On Mon, Nov 28, 2022 at 10:34:28PM +0800, Zqiang wrote:
> >>>> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
> >>>> RCU-tasks grace period, if __num_online_cpus == 1, will return
> >>>> directly, indicates the end of the rude RCU-task grace period.
> >>>> suppose the system has two cpus, consider the following scenario:
> >>>> 
> >>>>   CPU0                                   CPU1 (going offline)
> >>>>                         migration/1 task:
> >>>>                                     cpu_stopper_thread
> >>>>                                      -> take_cpu_down
> >>>>                                         -> _cpu_disable
> >>>>                              (dec __num_online_cpus)
> >>>>                                         ->cpuhp_invoke_callback
> >>>>                                               preempt_disable
> >>>>                       access old_data0
> >>>>          task1
> >>>> del old_data0                                  .....
> >>>> synchronize_rcu_tasks_rude()
> >>>> task1 schedule out
> >>>> ....
> >>>> task2 schedule in
> >>>> rcu_tasks_rude_wait_gp()
> >>>>    ->__num_online_cpus == 1
> >>>>      ->return
> >>>> ....
> >>>> task1 schedule in
> >>>> ->free old_data0
> >>>>                                               preempt_enable
> >>>> 
> >>>> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
> >>>> the CPU1 has not finished offline, stop_machine task(migration/1)
> >>>> still running on CPU1, maybe still accessing 'old_data0', but the
> >>>> 'old_data0' has freed on CPU0.
> >>>> 
> >>>> This commit add cpus_read_lock/unlock() protection before accessing
> >>>> __num_online_cpus variables, to ensure that the CPU in the offline
> >>>> process has been completed offline.
> >>>> 
> >>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >>>> 
> >>>> First, good eyes and good catch!!!
> >>>> 
> >>>> The purpose of that check for num_online_cpus() is not performance
> >>>> on single-CPU systems, but rather correct operation during early boot.
> >>>> So a simpler way to make that work is to check for RCU_SCHEDULER_RUNNING,
> >>>> for example, as follows:
> >>>> 
> >>>>   if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING &&
> >>>>       num_online_cpus() <= 1)
> >>>>       return;    // Early boot fastpath for only one CPU.
> >>> 
> >>> Hi Paul
> >>> 
> >>> During system startup, because the RCU_SCHEDULER_RUNNING is set after starting other CPUs, 
> >>> 
> >>>             CPU0                                                                       CPU1                                                                 
> >>> 
> >>> if (rcu_scheduler_active !=                                    
> >>>   RCU_SCHEDULER_RUNNING &&
> >>>          __num_online_cpus  == 1)                                               
> >>>   return;                                                                         inc  __num_online_cpus
> >>>                           (__num_online_cpus == 2)
> >>> 
> >>> CPU0 didn't notice the update of the __num_online_cpus variable by CPU1 in time
> >>> Can we move rcu_set_runtime_mode() before smp_init()
> >>> any thoughts?
> >>> 
> >>> Is anyone expected to do rcu-tasks operation before the scheduler is running? 
> >> 
> >> Not sure if such a scenario exists.
> >> 
> >>> Typically this requires the tasks to context switch which is a scheduler operation.
> >>> 
> >>> If the scheduler is not yet running, then I don’t think missing an update the __num_online_cpus matters since no one does a tasks-RCU synchronize.
> >> 
> >> Hi Joel
> >> 
> >> After the kernel_init task runs, before calling smp_init() to starting other CPUs, 
> >> the scheduler haven been initialization, task context switching can occur.
> > 
> > Good catch, thank you both.  For some reason, I was thinking that the
> > additional CPUs did not come online until later.
> > 
> > So how about this?
> > 
> >    if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> >        return;    // Early boot fastpath.
> > 
> > If this condition is true, there is only one CPU and no scheduler,
> > thus no preemption.
> 
> Agreed. I was going to suggest exactly this :)
> 
> Ack.
> (Replying by phone but feel free to add my reviewed by tag).

I should add that the downside of this approach is that there is a short
time between the scheduler initializing and workqueues fully initializing
where a critical-path call to synchronize_rcu_tasks() will hang the
system.  I do -not- consider this to be a real problem because RCU had
some hundreds of calls to synchronize_rcu() before this became an issue.

So this should be fine, but please recall this for when/if someone does
stick a synchronize_rcu_tasks() into that short time.  ;-)

							Thanx, Paul

> - Joel
> 
> 
> > 
> >                        Thanx, Paul
> > 
> >> Thanks
> >> Zqiang
> >> 
> >>> 
> >>> Or did I miss something?
> >>> 
> >>> Thanks.
> >>> 
> >>> 
> >>> 
> >>> 
> >>> Thanks
> >>> Zqiang
> >>> 
> >>>> 
> >>>> This works because rcu_scheduler_active is set to RCU_SCHEDULER_RUNNING
> >>>> long before it is possible to offline CPUs.
> >>>> 
> >>>> Yes, schedule_on_each_cpu() does do cpus_read_lock(), again, good eyes,
> >>>> and it also unnecessarily does the schedule_work_on() the current CPU,
> >>>> but the code calling synchronize_rcu_tasks_rude() is on high-overhead
> >>>> code paths, so this overhead is down in the noise.
> >>>> 
> >>>> Until further notice, anyway.
> >>>> 
> >>>> So simplicity is much more important than performance in this code.
> >>>> So just adding the check for RCU_SCHEDULER_RUNNING should fix this,
> >>>> unless I am missing something (always possible!).
> >>>> 
> >>>>                           Thanx, Paul
> >>>> 
> >>>> ---
> >>>> kernel/rcu/tasks.h | 20 ++++++++++++++++++--
> >>>> 1 file changed, 18 insertions(+), 2 deletions(-)
> >>>> 
> >>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >>>> index 4a991311be9b..08e72c6462d8 100644
> >>>> --- a/kernel/rcu/tasks.h
> >>>> +++ b/kernel/rcu/tasks.h
> >>>> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *work)
> >>>> {
> >>>> }
> >>>> 
> >>>> +static DEFINE_PER_CPU(struct work_struct, rude_work);
> >>>> +
> >>>> // Wait for one rude RCU-tasks grace period.
> >>>> static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> >>>> {
> >>>> +    int cpu;
> >>>> +    struct work_struct *work;
> >>>> +
> >>>> +    cpus_read_lock();
> >>>>   if (num_online_cpus() <= 1)
> >>>> -        return;    // Fastpath for only one CPU.
> >>>> +        goto end;// Fastpath for only one CPU.
> >>>> 
> >>>>   rtp->n_ipis += cpumask_weight(cpu_online_mask);
> >>>> -    schedule_on_each_cpu(rcu_tasks_be_rude);
> >>>> +    for_each_online_cpu(cpu) {
> >>>> +        work = per_cpu_ptr(&rude_work, cpu);
> >>>> +        INIT_WORK(work, rcu_tasks_be_rude);
> >>>> +        schedule_work_on(cpu, work);
> >>>> +    }
> >>>> +
> >>>> +    for_each_online_cpu(cpu)
> >>>> +        flush_work(per_cpu_ptr(&rude_work, cpu));
> >>>> +
> >>>> +end:
> >>>> +    cpus_read_unlock();
> >>>> }
> >>>> 
> >>>> void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
> >>>> -- 
> >>>> 2.25.1
> >>>> 
