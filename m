Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187D2611DBA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJ1WzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJ1WzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:55:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE1F625D1;
        Fri, 28 Oct 2022 15:55:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFDF562AC3;
        Fri, 28 Oct 2022 22:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375EEC433C1;
        Fri, 28 Oct 2022 22:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666997712;
        bh=Qx+Ar6Rx89QSE4eSqCXte9rvP+OpROy88fkjDeTVhQ4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EhsdrU+GdlkPq3Oem82ZGnkkVXIxxoM34IU27mNFuMiLbvRIObPus34UZboNoT5Pm
         C0AV0gQD+vjMbLSINUCm1709njJRJn3Yws4jiofNRsTh9debLXhwIkRoZUncdCqJTv
         CXYcrcKsIWVvZPmgscfqHObE7mHXDARO0ABt3Gv0P6LfjARuBgOcqXXtHFRzCFsXLV
         MPCl5wVi08M9nI4Sa+OM3nqGIVc7fYMm6uD/yGpOeliPxhbrxstrf+RW6hUTnoT1eU
         Yrhf4EJ62S5ou4dCbUWjarIKqOewaNBOS0+VaOgrWRaZyKK87s+aEA0ig8USxZxuIx
         besiEXGCdmRSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BCBCF5C1040; Fri, 28 Oct 2022 15:55:11 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:55:11 -0700
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
Subject: Re: [PATCH v2 3/3] rcu: Add RCU stall diagnosis information
Message-ID: <20221028225511.GW5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221022124525.2080-1-thunder.leizhen@huawei.com>
 <20221022124525.2080-4-thunder.leizhen@huawei.com>
 <20221027173334.GB5600@paulmck-ThinkPad-P17-Gen-1>
 <5a4acb9d-48ba-7f41-51c7-19f300a47f22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4acb9d-48ba-7f41-51c7-19f300a47f22@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 11:16:55AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/10/28 1:33, Paul E. McKenney wrote:
> > On Sat, Oct 22, 2022 at 08:45:25PM +0800, Zhen Lei wrote:
> >> In some extreme cases, such as the I/O pressure test, the CPU usage may
> >> be 100%, causing RCU stall. In this case, the printed information about
> >> current is not useful. Displays the number and usage of hard interrupts,
> >> soft interrupts, and context switches that are generated within half of
> >> the CPU stall timeout, can help us make a general judgment. In other
> >> cases, we can preliminarily determine whether an infinite loop occurs
> >> when local_irq, local_bh or preempt is disabled.
> >>
> >> For example:
> >> rcu: INFO: rcu_preempt self-detected stall on CPU
> >> rcu:     0-....: (1250 ticks this GP) <omitted>
> >> rcu:          hardirqs   softirqs   csw/system
> >> rcu:  number:      624         45            0
> >> rcu: cputime:       69          1         2425   ==> 2500(ms)
> >>
> >> The example above shows that the number of hard and soft interrupts is
> >> small, there is zero context switching, and the system takes up a lot of
> >> time. We can quickly conclude that the current task is infinitely looped
> >> with preempt_disable().
> >>
> >> The impact on system performance is negligible because snapshot is
> >> recorded only one time after 1/2 CPU stall timeout.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  kernel/rcu/tree.c       | 16 ++++++++++++++++
> >>  kernel/rcu/tree.h       | 11 +++++++++++
> >>  kernel/rcu/tree_stall.h | 28 ++++++++++++++++++++++++++++
> >>  3 files changed, 55 insertions(+)
> >>
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index 6bb8e72bc8151ef..56c49a3117e7a81 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -931,6 +931,22 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> >>  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
> >>  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
> >>  		}
> >> +
> >> +		if (rdp->snap_record.gp_seq != rdp->gp_seq) {
> >> +			u64 *cpustat;
> >> +			struct rcu_snap_record *r;
> >> +
> >> +			cpustat = kcpustat_cpu(rdp->cpu).cpustat;
> >> +
> >> +			r = &rdp->snap_record;
> >> +			r->cputime_irq     = cpustat[CPUTIME_IRQ];
> >> +			r->cputime_softirq = cpustat[CPUTIME_SOFTIRQ];
> >> +			r->cputime_system  = cpustat[CPUTIME_SYSTEM];
> >> +			r->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
> >> +			r->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
> >> +			r->nr_csw = nr_context_switches_cpu(rdp->cpu);
> >> +			r->gp_seq = rdp->gp_seq;
> > 
> > This needs to be optional.  Yes, it is normally rarely executed, but
> > people who don't want the additional information should not pay the
> > price for it.
> > 
> >> +		}
> >>  	}
> >>  
> >>  	return 0;
> >> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> >> index d4a97e40ea9c3e2..fb3121d15cca6f8 100644
> >> --- a/kernel/rcu/tree.h
> >> +++ b/kernel/rcu/tree.h
> >> @@ -158,6 +158,16 @@ union rcu_noqs {
> >>  	u16 s; /* Set of bits, aggregate OR here. */
> >>  };
> >>  
> >> +struct rcu_snap_record {
> >> +	unsigned long	gp_seq;
> >> +	u64		cputime_irq;
> >> +	u64		cputime_softirq;
> >> +	u64		cputime_system;
> >> +	unsigned int	nr_hardirqs;
> >> +	unsigned int	nr_softirqs;
> >> +	unsigned long long nr_csw;
> >> +};
> > 
> > Please add a comment saying what this is and what it is used for.
> 
> OK, I will do it.
> 
> > 
> >> +
> >>  /* Per-CPU data for read-copy update. */
> >>  struct rcu_data {
> >>  	/* 1) quiescent-state and grace-period handling : */
> >> @@ -262,6 +272,7 @@ struct rcu_data {
> >>  	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
> >>  	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
> >>  	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
> >> +	struct rcu_snap_record snap_record;
> > 
> > And here as well, please.
> 
> OK
> 
> > 
> >>  	int cpu;
> >>  };
> >> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> >> index 5653560573e22d6..f8c9d0284d116a8 100644
> >> --- a/kernel/rcu/tree_stall.h
> >> +++ b/kernel/rcu/tree_stall.h
> >> @@ -428,6 +428,32 @@ static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp
> >>  	return j > 2 * HZ;
> >>  }
> >>  
> >> +static void print_cpu_stat_info(int cpu)
> >> +{
> >> +	u64 *cpustat;
> >> +	unsigned long half_timeout;
> >> +	struct rcu_snap_record *r;
> > 
> > Let's please follow convention and call it "rsrp" rather than just "r".
> 
> OK
> 
> > 
> >> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >> +
> >> +	r = &rdp->snap_record;
> >> +	if (r->gp_seq != rdp->gp_seq)
> >> +		return;
> >> +
> >> +	cpustat = kcpustat_cpu(cpu).cpustat;
> >> +	half_timeout = rcu_jiffies_till_stall_check() / 2;
> >> +
> >> +	pr_err("         hardirqs   softirqs   csw/system\n");
> >> +	pr_err(" number: %8d %10d %12lld\n",
> >> +		kstat_cpu_irqs_sum(cpu) - r->nr_hardirqs,
> >> +		kstat_cpu_softirqs_sum(cpu) - r->nr_softirqs,
> >> +		nr_context_switches_cpu(cpu) - r->nr_csw);
> >> +	pr_err("cputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
> >> +		div_u64(cpustat[CPUTIME_IRQ] - r->cputime_irq, NSEC_PER_MSEC),
> >> +		div_u64(cpustat[CPUTIME_SOFTIRQ] - r->cputime_softirq, NSEC_PER_MSEC),
> >> +		div_u64(cpustat[CPUTIME_SYSTEM] - r->cputime_system, NSEC_PER_MSEC),
> >> +		jiffies64_to_msecs(half_timeout));
> >> +}
> >> +
> >>  /*
> >>   * Print out diagnostic information for the specified stalled CPU.
> >>   *
> >> @@ -484,6 +510,8 @@ static void print_cpu_stall_info(int cpu)
> >>  	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
> >>  	       rcuc_starved ? buf : "",
> >>  	       falsepositive ? " (false positive?)" : "");
> >> +
> >> +	print_cpu_stat_info(cpu);
> > 
> > Again, please make this conditional.  One way to do that is with a
> > Kconfig option.  Another is with a kernel boot parameter, as is done
> > wtih module_param() elsewhere in tree_stall.h.  Or if the parsing needs
> > to be fancy (it shouldn't) using kernel_param_ops as is done in tree.c.
> > Distros tend to like kernel boot parameters, while people dealing with
> > large numbers of devices tend to like Kconfig options.  Choose wisely.  ;-)
> 
> OK. I will add both Kconfig option and boot parameter, let the user
> choose freely.

Works for me!  ;-)

							Thanx, Paul
