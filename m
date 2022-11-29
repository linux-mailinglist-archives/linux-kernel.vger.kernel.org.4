Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BFC63C379
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiK2PSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiK2PSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:18:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D82EF66;
        Tue, 29 Nov 2022 07:18:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DF06617A3;
        Tue, 29 Nov 2022 15:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68F0C43470;
        Tue, 29 Nov 2022 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669735091;
        bh=PAhRHefh63QPKzR0YMUfvO7NfJ7s0IoYl5L7+q1ICY8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LJa0LJR5Sf4jMZ2WcDfEo2oi25kSp64NQlmQZePm47sD6nb0plm8O4tsD30dt6c35
         xyvvXZPU9OSrjdV4Uqoyqxsbs1PwgXIyBs+VpfXC1hPBbEak/JVN6fiErJ7HkjmP60
         xcY7Sg6K0MWRGARIEwdkWyYc9Mu3b4W7QXnrfBX2Zyjd18yQg/3ZZ7ICs3l3onNjij
         gIWCjpJs+4kml+pcB324C8LaTMX93PVEnCWVRML7HcpN8m2Y2YzRbxTEdDJYwr2psL
         LlYeWi//YInKTNBCi/gkiouotPr7N+nSnaNBlhKlxzhMPBdAL3mT5yDOFS9l0suHdE
         lmPG1UoWsW9Bg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8222D5C03A4; Tue, 29 Nov 2022 07:18:10 -0800 (PST)
Date:   Tue, 29 Nov 2022 07:18:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Message-ID: <20221129151810.GY4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <PH0PR11MB588001E6982A9DC32F93FD7ADA129@PH0PR11MB5880.namprd11.prod.outlook.com>
 <24EC376D-B542-4E3C-BC10-3E81F2F2F49C@joelfernandes.org>
 <PH0PR11MB58801BEDCA0F6600F01486FEDA129@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB58801BEDCA0F6600F01486FEDA129@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:25:04AM +0000, Zhang, Qiang1 wrote:
> > On Nov 28, 2022, at 11:54 PM, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
> > 
> > ﻿On Mon, Nov 28, 2022 at 10:34:28PM +0800, Zqiang wrote:
> >> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
> >> RCU-tasks grace period, if __num_online_cpus == 1, will return
> >> directly, indicates the end of the rude RCU-task grace period.
> >> suppose the system has two cpus, consider the following scenario:
> >> 
> >>    CPU0                                   CPU1 (going offline)
> >>                          migration/1 task:
> >>                                      cpu_stopper_thread
> >>                                       -> take_cpu_down
> >>                                          -> _cpu_disable
> >>                               (dec __num_online_cpus)
> >>                                          ->cpuhp_invoke_callback
> >>                                                preempt_disable
> >>                        access old_data0
> >>           task1
> >> del old_data0                                  .....
> >> synchronize_rcu_tasks_rude()
> >> task1 schedule out
> >> ....
> >> task2 schedule in
> >> rcu_tasks_rude_wait_gp()
> >>     ->__num_online_cpus == 1
> >>       ->return
> >> ....
> >> task1 schedule in
> >> ->free old_data0
> >>                                                preempt_enable
> >> 
> >> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
> >> the CPU1 has not finished offline, stop_machine task(migration/1)
> >> still running on CPU1, maybe still accessing 'old_data0', but the
> >> 'old_data0' has freed on CPU0.
> >> 
> >> This commit add cpus_read_lock/unlock() protection before accessing
> >> __num_online_cpus variables, to ensure that the CPU in the offline
> >> process has been completed offline.
> >> 
> >> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >> 
> >> First, good eyes and good catch!!!
> >> 
> >> The purpose of that check for num_online_cpus() is not performance
> >> on single-CPU systems, but rather correct operation during early boot.
> >> So a simpler way to make that work is to check for RCU_SCHEDULER_RUNNING,
> >> for example, as follows:
> >> 
> >>    if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING &&
> >>        num_online_cpus() <= 1)
> >>        return;    // Early boot fastpath for only one CPU.
> > 
> > Hi Paul
> > 
> > During system startup, because the RCU_SCHEDULER_RUNNING is set after starting other CPUs, 
> > 
> >              CPU0                                                                       CPU1                                                                 
> > 
> > if (rcu_scheduler_active !=                                    
> >    RCU_SCHEDULER_RUNNING &&
> >           __num_online_cpus  == 1)                                               
> >    return;                                                                         inc  __num_online_cpus
> >                            (__num_online_cpus == 2)
> > 
> > CPU0 didn't notice the update of the __num_online_cpus variable by CPU1 in time
> > Can we move rcu_set_runtime_mode() before smp_init()
> > any thoughts?
> >
> >Is anyone expected to do rcu-tasks operation before the scheduler is running? 
> 
> Not sure if such a scenario exists.
> 
> >Typically this requires the tasks to context switch which is a scheduler operation.
> >
> >If the scheduler is not yet running, then I don’t think missing an update the __num_online_cpus matters since no one does a tasks-RCU synchronize.
> 
> Hi Joel
> 
> After the kernel_init task runs, before calling smp_init() to starting other CPUs, 
> the scheduler haven been initialization, task context switching can occur.

Good catch, thank you both.  For some reason, I was thinking that the
additional CPUs did not come online until later.

So how about this?

	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
		return;    // Early boot fastpath.

If this condition is true, there is only one CPU and no scheduler,
thus no preemption.

						Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >Or did I miss something?
> >
> >Thanks.
> >
> >
> >
> > 
> > Thanks
> > Zqiang
> > 
> >> 
> >> This works because rcu_scheduler_active is set to RCU_SCHEDULER_RUNNING
> >> long before it is possible to offline CPUs.
> >> 
> >> Yes, schedule_on_each_cpu() does do cpus_read_lock(), again, good eyes,
> >> and it also unnecessarily does the schedule_work_on() the current CPU,
> >> but the code calling synchronize_rcu_tasks_rude() is on high-overhead
> >> code paths, so this overhead is down in the noise.
> >> 
> >> Until further notice, anyway.
> >> 
> >> So simplicity is much more important than performance in this code.
> >> So just adding the check for RCU_SCHEDULER_RUNNING should fix this,
> >> unless I am missing something (always possible!).
> >> 
> >>                            Thanx, Paul
> >> 
> >> ---
> >> kernel/rcu/tasks.h | 20 ++++++++++++++++++--
> >> 1 file changed, 18 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >> index 4a991311be9b..08e72c6462d8 100644
> >> --- a/kernel/rcu/tasks.h
> >> +++ b/kernel/rcu/tasks.h
> >> @@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *work)
> >> {
> >> }
> >> 
> >> +static DEFINE_PER_CPU(struct work_struct, rude_work);
> >> +
> >> // Wait for one rude RCU-tasks grace period.
> >> static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
> >> {
> >> +    int cpu;
> >> +    struct work_struct *work;
> >> +
> >> +    cpus_read_lock();
> >>    if (num_online_cpus() <= 1)
> >> -        return;    // Fastpath for only one CPU.
> >> +        goto end;// Fastpath for only one CPU.
> >> 
> >>    rtp->n_ipis += cpumask_weight(cpu_online_mask);
> >> -    schedule_on_each_cpu(rcu_tasks_be_rude);
> >> +    for_each_online_cpu(cpu) {
> >> +        work = per_cpu_ptr(&rude_work, cpu);
> >> +        INIT_WORK(work, rcu_tasks_be_rude);
> >> +        schedule_work_on(cpu, work);
> >> +    }
> >> +
> >> +    for_each_online_cpu(cpu)
> >> +        flush_work(per_cpu_ptr(&rude_work, cpu));
> >> +
> >> +end:
> >> +    cpus_read_unlock();
> >> }
> >> 
> >> void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
> >> -- 
> >> 2.25.1
> >> 
