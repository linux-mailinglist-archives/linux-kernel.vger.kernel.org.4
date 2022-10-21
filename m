Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FCA607EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiJUTQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiJUTQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4DB11DA9A;
        Fri, 21 Oct 2022 12:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C6B661F55;
        Fri, 21 Oct 2022 19:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4520C433D6;
        Fri, 21 Oct 2022 19:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666379700;
        bh=AbUS1JFjhdv2c6YdetyoszWM62iOHLCtRYVnnCFAhoM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GLJTK/LEUuv3GZyohwrD7kcLsCb/T4vxGwS3o8IX3TsHCXrW81WfQuJaxBVG7D1Ap
         Y1wQawJjdUNzaeellVjogxe/VoBs6QocR6Oy1JJXbdupfo3AW1PY5ZD85xmsXO6vsj
         37sWYdn357YvoQ+ROvKKbHR53asY7cu2a5kBXxjaOaNKS3uvUeujNxynhatIojJGcg
         007MEQQ/xxaigY8yRwBm2BEQsiUhD8+pcCKxfdDils+FnrhI7ZuT2XvXh3qss1VQsq
         HR3XEFhNm2MJhCAX2+HGmvoMb6WSpZaiZsrCsCLG3dBq7GocnNYJN2//mkB1kzToHF
         WCNB1TjtNp/7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4F4AB5C0543; Fri, 21 Oct 2022 12:15:00 -0700 (PDT)
Date:   Fri, 21 Oct 2022 12:15:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] rcu: Add RCU stall diagnosis information
Message-ID: <20221021191500.GQ5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221017100108.2063-1-thunder.leizhen@huawei.com>
 <20221020231353.GC5600@paulmck-ThinkPad-P17-Gen-1>
 <f71fa16b-10c8-58a8-4646-9b5efc44a429@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f71fa16b-10c8-58a8-4646-9b5efc44a429@huawei.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:07:43PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/10/21 7:13, Paul E. McKenney wrote:
> > On Mon, Oct 17, 2022 at 06:01:05PM +0800, Zhen Lei wrote:
> >> In some extreme cases, such as the I/O pressure test, the CPU usage may
> >> be 100%, causing RCU stall. In this case, the printed information about
> >> current is not useful. Displays the number and usage of hard interrupts,
> >> soft interrupts, and context switches that are generated within half of
> >> the CPU stall timeout, can help us make a general judgment. In other
> >> cases, we can preliminarily determine whether an infinite loop occurs
> >> when local_irq, local_bh or preempt is disabled.
> >>
> >> Zhen Lei (3):
> >>   sched: Add helper kstat_cpu_softirqs_sum()
> >>   sched: Add helper nr_context_switches_cpu()
> >>   rcu: Add RCU stall diagnosis information
> > 
> > Interesting approach, thank you!
> > 
> > I have pulled this in for testing and review, having rescued it from my
> > spam folder.
> 
> Thanks. My company's mail system has been having some problems lately.
> 
> Also, I need to apologize that yesterday I found out there was a mistake
> in patch 3/3. Yesterday, I finally got to print_other_cpu_stall() by forcing
> a stub.

OK, I done dropped your three patches for the time being.

Please feel free to submit v2 whenever you are ready to do so.

> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 08cfcf526f7d245..caaee5f4ee091df 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
>         if (r->gp_seq != rdp->gp_seq)
>                 return;
> 
> -       cpustat = kcpustat_this_cpu->cpustat;
> +       cpustat = kcpustat_cpu(cpu).cpustat;
>         half_timeout = rcu_jiffies_till_stall_check() / 2;
> 
>         pr_err("         hardirqs   softirqs   csw/system\n");
> 
> > 
> > Some questions that might come up include:  (1) Can the addition of
> > things like cond_resched() make RCU happier with the I/O pressure test?
> > (2) Should there be a way to turn this off for environments with slow
> > consoles?  (3) If this information shows heavy CPU usage, what debug
> > and fix approach should be used?
> 
> If the CPU usage is high due to busy services, I think it is excusable
> to report RCU stall warning.

Not so much.  RCU CPU stall warning usually means that there is some
overly long loop in the kernel.

>                              When users see RCU stall, they are most
> worried about whether there are unrecoverable errors, such as dead loop.
> If the cause is known to be the CPU usage, the I/O performance has
> reached its peak, this is probably what people want to see.

You have a workload that can be carried out entirely in interrupt
handlers?  If not, the kernel code really should be updated to avoid
the RCU CPU stall warnings.

> (1) This needs to be considered by the business task itself. As far as I
>     know some drivers' data processing is done in an interrupt context.

You are seeing an entire CPU being consumed by interrupt handlers?
If so, is the CPU being carefully placed in the idle loop beforehand?
If not, how do you keep the long delays in the interrupted processing
from causing problems?

> (2) Do you mean to suppress such new debugging information that I added?
>     or the whole RCU stall information?

Only the new debugging information.  I already get complaints about RCU
CPU stall warnings producing more output than people like.

> (3) The statistics can be accurate to a single hard interrupt, software
>     interrupt, or task. However, the price will be higher. Users can
>     recall what they did at the time, then reproduce it. Maybe we can get
>     this code ready, add a new debugging option, and turn it on when needed.

Let me ask this a different way.  What combination of numbers would lead
you to believe that a given RCU CPU stall warning can safely be ignored?

> > For an example of #1, if a CPU is flooded with softirq activity, one
> > might hope that the call to rcu_softirq_qs() would prevent the RCU CPU
> > stall warning, at least for kernels built with CONFIG_PREEMPT_RT=n.
> > Similarly, if there are huge numbers of context switches, one might hope
> > that the rcu_note_context_switch() would report a quiescent state sooner
> > rather than later.
> 
> Good idea. I'm going to dig deeper.
> 
> How about dynamically extending the stall timeout if the CPU usage is too high?

Let's first work out why the RCU CPU stalls are happening.  After all, if
there is a particular case that is truly harmless, it would be better to
arrange that stalls not be printed at all in that case.  It is better to
just not have false positives, right?

							Thanx, Paul

> > Thoughts?
> > 
> > 							Thanx, Paul
> > 
> >>  include/linux/kernel_stat.h | 12 +++++++++++
> >>  kernel/rcu/tree.h           | 11 ++++++++++
> >>  kernel/rcu/tree_stall.h     | 40 +++++++++++++++++++++++++++++++++++++
> >>  kernel/sched/core.c         |  5 +++++
> >>  4 files changed, 68 insertions(+)
> >>
> >> -- 
> >> 2.25.1
> >>
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
