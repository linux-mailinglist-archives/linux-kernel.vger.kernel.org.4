Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FFF62417F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiKJLfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiKJLfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:35:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2BC657C8;
        Thu, 10 Nov 2022 03:35:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56A62CE223D;
        Thu, 10 Nov 2022 11:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE944C433D6;
        Thu, 10 Nov 2022 11:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668080106;
        bh=LmlA1KvKNiCBzyvniKHyrhNeQe12u7RcZBNQGuu1HjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ry4t1NfrCFz+0ZncYL9OQxkW7TuBEpQULUlh73sSxMqh3Qi7EUXEOQwxfzNHCOeYa
         xg99dE2YPDtnWjAQlvPAkBd4ZR2Uw+v/9RwxUGNiw6AJm+RodOVWu/Pj8xU3c+Mvu5
         t6O5Gk4Ef2ETwPR8Ihw6vmHR0Yji259Bl2UJ230viL8VUrDiM1Wul+RbyIaWk6BVWz
         ydCuelFwbVZJYWjESLF41z5/lqjQN7y5VVwgM/T767SMVyegShKmDSD1rSIKHj4m8o
         GOCRr0wBkKtdwqDha3WvDJ5HvMBtPxKuc9wnMD/4V/nJ3FILdwN6s3/96niqtlK0mH
         uEvhyCuIWSI2g==
Date:   Thu, 10 Nov 2022 12:35:02 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v6 0/2] rcu: Add RCU stall diagnosis information
Message-ID: <20221110113502.GE300561@lothringen>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109152621.GB298683@lothringen>
 <20221109155901.GA727034@paulmck-ThinkPad-P17-Gen-1>
 <20221109170317.GA300561@lothringen>
 <c8b7deaa-1d4f-0e73-269a-32d6105b89a7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b7deaa-1d4f-0e73-269a-32d6105b89a7@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 03:29:04PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/10 1:03, Frederic Weisbecker wrote:
> > On Wed, Nov 09, 2022 at 07:59:01AM -0800, Paul E. McKenney wrote:
> >> On Wed, Nov 09, 2022 at 04:26:21PM +0100, Frederic Weisbecker wrote:
> >>> Hi Zhen Lei,
> >>>
> >>> On Wed, Nov 09, 2022 at 05:37:36PM +0800, Zhen Lei wrote:
> >>>> v5 --> v6:
> >>>> 1. When there are more than two continuous RCU stallings, correctly handle the
> >>>>    value of the second and subsequent sampling periods. Update comments and
> >>>>    document.
> >>>>    Thanks to Elliott, Robert for the test.
> >>>> 2. Change "rcu stall" to "RCU stall".
> >>>>
> >>>> v4 --> v5:
> >>>> 1. Resolve a git am conflict. No code change.
> >>>>
> >>>> v3 --> v4:
> >>>> 1. Rename rcu_cpu_stall_deep_debug to rcu_cpu_stall_cputime.
> >>>>
> >>>> v2 --> v3:
> >>>> 1. Fix the return type of kstat_cpu_irqs_sum()
> >>>> 2. Add Kconfig option CONFIG_RCU_CPU_STALL_DEEP_DEBUG and boot parameter
> >>>>    rcupdate.rcu_cpu_stall_deep_debug.
> >>>> 3. Add comments and normalize local variable name
> >>>>
> >>>>
> >>>> v1 --> v2:
> >>>> 1. Fixed a bug in the code. If the rcu stall is detected by another CPU,
> >>>>    kcpustat_this_cpu cannot be used.
> >>>> @@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
> >>>>         if (r->gp_seq != rdp->gp_seq)
> >>>>                 return;
> >>>>
> >>>> -       cpustat = kcpustat_this_cpu->cpustat;
> >>>> +       cpustat = kcpustat_cpu(cpu).cpustat;
> >>>> 2. Move the start point of statistics from rcu_stall_kick_kthreads() to
> >>>>    rcu_implicit_dynticks_qs(), removing the dependency on irq_work.
> >>>>
> >>>> v1:
> >>>> In some extreme cases, such as the I/O pressure test, the CPU usage may
> >>>> be 100%, causing RCU stall. In this case, the printed information about
> >>>> current is not useful. Displays the number and usage of hard interrupts,
> >>>> soft interrupts, and context switches that are generated within half of
> >>>> the CPU stall timeout, can help us make a general judgment. In other
> >>>> cases, we can preliminarily determine whether an infinite loop occurs
> >>>> when local_irq, local_bh or preempt is disabled.
> >>>
> >>> That looks useful but I have to ask: what does it bring that the softlockup
> >>> and hardlockup watchdog can not already solve?
> >>
> >> This is a good point.  One possible benefit is putting the needed information
> >> in one spot, for example, in cases where the soft/hard lockup timeouts are
> >> significantly different than the RCU CPU stall warning timeout.
> > 
> > Arguably, the hardlockup/softlockup detectors usually trigger after RCU stall,
> > unless all CPUs are caught into a hardlockup, in which case only the hardlockup
> > detector has a chance.
> 
> But not all ARCHs support hardlockup, such as s390. Maybe arm64.
> 
> config HARDLOCKUP_DETECTOR
>         bool "Detect Hard Lockups"
>         depends on DEBUG_KERNEL && !S390
>         depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_ARCH

Ah fair point indeed.

Thanks!
