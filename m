Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01AA626B1C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 20:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiKLS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 13:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLS7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 13:59:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196C22706;
        Sat, 12 Nov 2022 10:59:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80969B80B07;
        Sat, 12 Nov 2022 18:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED841C433D6;
        Sat, 12 Nov 2022 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668279585;
        bh=3MxJWQ4V8Ernje8HFQ2ldHzE+pKK2tRT6hQuwIow7VY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eoeD214sWEMuyzQ22hlaKc/9h/7jZSm+t3bzW4HbiUVsfQbTd9pkXappZ1ujsMDxr
         4sAjchfMa4TYyV9xk6I8m5Pip6H/J+xfLj0v5sx769vxzOkghiKJoHe4XcLKBNdfx8
         3W9I/POsrHLWP5y1tY86vMbw5vC+EMbviGl+D8xbXk6AgoztcUI2c5AerLbosS7RWo
         MqJpjv6HS4RPKjMeB9wzIydYfZfA0y/zZpoYO1l6bWgsJeRO1qP4/zumjbBttxUnda
         Sq8UEnO6id1dTVVOexcvnZbieXReZ3ZmfGJTqr1M+yA0FQ6DBLcZjS4Qvqa9+nCzxs
         kSbdb97VLHVSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0DBDD5C0FC9; Sat, 12 Nov 2022 10:59:41 -0800 (PST)
Date:   Sat, 12 Nov 2022 10:59:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v6 0/2] rcu: Add RCU stall diagnosis information
Message-ID: <20221112185941.GG725751@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109152621.GB298683@lothringen>
 <20221109155901.GA727034@paulmck-ThinkPad-P17-Gen-1>
 <20221109170317.GA300561@lothringen>
 <20221109172221.GD725751@paulmck-ThinkPad-P17-Gen-1>
 <a48a3eb1-5fa4-4b6b-f7bf-e0bc589f7bf6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a48a3eb1-5fa4-4b6b-f7bf-e0bc589f7bf6@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 10:27:44AM +0800, Leizhen (ThunderTown) wrote:
> On 2022/11/10 1:22, Paul E. McKenney wrote:
> > On Wed, Nov 09, 2022 at 06:03:17PM +0100, Frederic Weisbecker wrote:
> >> On Wed, Nov 09, 2022 at 07:59:01AM -0800, Paul E. McKenney wrote:
> >>> On Wed, Nov 09, 2022 at 04:26:21PM +0100, Frederic Weisbecker wrote:
> >>>> Hi Zhen Lei,
> >>>>
> >>>> On Wed, Nov 09, 2022 at 05:37:36PM +0800, Zhen Lei wrote:
> >>>>> v5 --> v6:
> >>>>> 1. When there are more than two continuous RCU stallings, correctly handle the
> >>>>>    value of the second and subsequent sampling periods. Update comments and
> >>>>>    document.
> >>>>>    Thanks to Elliott, Robert for the test.
> >>>>> 2. Change "rcu stall" to "RCU stall".
> >>>>>
> >>>>> v4 --> v5:
> >>>>> 1. Resolve a git am conflict. No code change.
> >>>>>
> >>>>> v3 --> v4:
> >>>>> 1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.
> >>>>>
> >>>>> v2 --> v3:
> >>>>> 1. Fix the return type of kstat_cpu_irqs_sum()
> >>>>> 2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
> >>>>>    rcupdate.rcu_cpu_stall_deep_debug.
> >>>>> 3. Add comments and normalize local variable name
> >>>>>
> >>>>>
> >>>>> v1 --> v2:
> >>>>> 1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
> >>>>>    kcpustat_this_cpu cannot be used.
> >>>>> @@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
> >>>>>         if (r->gp_seq != rdp->gp_seq)
> >>>>>                 return;
> >>>>>
> >>>>> -       cpustat = kcpustat_this_cpu->cpustat;
> >>>>> +       cpustat = kcpustat_cpu(cpu).cpustat;
> >>>>> 2. Move the start point of statistics from rcu_stall_kick_kthreads() to
> >>>>>    rcu_implicit_dynticks_qs(), removing the dependency on irq_work.
> >>>>>
> >>>>> v1:
> >>>>> In some extreme cases, such as the I/O pressure test, the CPU usage may
> >>>>> be 100%, causing RCU stall. In this case, the printed information about
> >>>>> current is not useful. Displays the number and usage of hard interrupts,
> >>>>> soft interrupts, and context switches that are generated within half of
> >>>>> the CPU stall timeout, can help us make a general judgment. In other
> >>>>> cases, we can preliminarily determine whether an infinite loop occurs
> >>>>> when local_irq, local_bh or preempt is disabled.
> >>>>
> >>>> That looks useful but I have to ask: what does it bring that the softlockup
> >>>> and hardlockup watchdog can not already solve?
> >>>
> >>> This is a good point.  One possible benefit is putting the needed information
> >>> in one spot, for example, in cases where the soft/hard lockup timeouts are
> >>> significantly different than the RCU CPU stall warning timeout.
> >>
> >> Arguably, the hardlockup/softlockup detectors usually trigger after RCU stall,
> >> unless all CPUs are caught into a hardlockup, in which case only the hardlockup
> >> detector has a chance.
> >>
> >> Anyway I would say that in this case just lower the delay for the lockup
> >> detectors to consider the situation is a lockup?
> > 
> > Try it both ways and see how it works?  The rcutorture module parameters
> > stall_cpu and stall_cpu_irqsoff are easy ways to generate these sorts
> > of scenarios.
> > 
> > Actually, that does remind me of something.  Back when I was chasing
> > that interrupt storm, would this patch have helped me?  In that case, the
> 
> Yes, this patch series originally addressed an RCU stall issue caused by an
> interruption storm. The serial port driver written by another project team
> failed to write the register in a specific condition. As a result, interrupts
> were repeatedly reported.

Very good!

> > half-way point would have been reached while all online CPUs were spinning
> > with interrupts disabled and the incoming CPU was getting hammered with
> > continual scheduling-clock interrupts.  So I suspect that the answer is
> > "no" because the incoming CPU was not blocking the grace period.
> > 
> > Instead of being snapshot halfway to the RCU CPU stall warning, should
> > the values be snapshot when the CPU notices the beginning or end of an
> > RCU grace period and when a CPU goes offline?
> 
> This won't work. Those normal counts that occurred before the failure
> have an impact on our analysis. For example, some software interrupts
> may have been generated before local_bh_disable() is called.

Fair enough, and thank you for considering this option.  But please be
prepared to adjust (somehow or another) as needed to accommodate other
failure scenarios as they arise.

							Thanx, Paul

> > But that would not suffice, because detailed information would not have
> > been dumped for the incoming CPU.
> > 
> > However, the lack of context switches and interrupts on the rest of the
> > CPUs would likely have been a big cluebat, so there is that.  It might
> > be better to rework the warning at the beginning of rcu_sched_clock_irq()
> > to complain if more than (say) 10 scheduling-clock interrupts occur on
> > a given CPU during a single jiffy.
> > 
> > Independent of Zhen Lei patch.
> > 
> > Thoughts?
> > 
> > 							Thanx, Paul
> > 
> >> Thanks.
> >>
> >>
> >>>
> >>> Thoughts?
> >>>
> >>> 							Thanx, Paul
> >>>
> >>>> Thanks.
> >>>>
> >>>>>
> >>>>> Zhen Lei (2):
> >>>>>   rcu: Add RCU stall diagnosis information
> >>>>>   doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
> >>>>>
> >>>>>  Documentation/RCU/stallwarn.rst               | 88 +++++++++++++++++++
> >>>>>  .../admin-guide/kernel-parameters.txt         |  6 ++
> >>>>>  kernel/rcu/Kconfig.debug                      | 11 +++
> >>>>>  kernel/rcu/rcu.h                              |  1 +
> >>>>>  kernel/rcu/tree.c                             | 17 ++++
> >>>>>  kernel/rcu/tree.h                             | 19 ++++
> >>>>>  kernel/rcu/tree_stall.h                       | 29 ++++++
> >>>>>  kernel/rcu/update.c                           |  2 +
> >>>>>  8 files changed, 173 insertions(+)
> >>>>>
> >>>>> -- 
> >>>>> 2.25.1
> >>>>>
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
