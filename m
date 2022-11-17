Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842B862DA91
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiKQMWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiKQMWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:22:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE40CDB;
        Thu, 17 Nov 2022 04:22:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2734661482;
        Thu, 17 Nov 2022 12:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF504C433C1;
        Thu, 17 Nov 2022 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668687761;
        bh=zx0pWb4nQH5eQDMQu6wkWFs3SGyhmtK2xNcBwlJKago=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOEcrIuJuXo3UqeHSLDo4YcpL+sR1xv99xElhrQ5H3zZ7gavxEZ3MiyfMmP7DT4td
         RBF36nj/9nq/sU80QmRWCE2hPI2nNqTopUFc0xlGqr3+UoL3VrnW3ZO9N72UQGud01
         T6B4F1peVgNtAM8xE+km2Erhp9Ldqwh6TXfSIUPsxPWYegK3+ZZ+wq1tMcvtM1y0MK
         oIuudSVQxwDeG7F99C7a/5h7NGLK0P1muN2SmAdIlCL7T7DkabPvz0TWl4I2yTO5qt
         dVveaM7ccLfzPS4iAKF2EB8EVMJ431y+T98fw63gaFe5zDv8vm4s3X5UFjA9YWuLaF
         jH4oYq5Oq7uUg==
Date:   Thu, 17 Nov 2022 13:22:38 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v7 4/6] rcu: Add RCU stall diagnosis information
Message-ID: <20221117122238.GC839309@lothringen>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-5-thunder.leizhen@huawei.com>
 <20221116223942.GA838972@lothringen>
 <d4f7f41c-e1ef-606f-d700-3e67059bb06d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f7f41c-e1ef-606f-d700-3e67059bb06d@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:57:18AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/17 6:39, Frederic Weisbecker wrote:
> > On Fri, Nov 11, 2022 at 09:07:07PM +0800, Zhen Lei wrote:
> >> @@ -262,6 +279,8 @@ struct rcu_data {
> >>  	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
> >>  	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
> >>  	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
> >> +	struct rcu_snap_record snap_record; /* Snapshot of core stats at half of */
> >> +					    /* the first RCU stall timeout */
> > 
> > This should be under #ifdef CONFIG_RCU_CPU_STALL_CPUTIME
> 
> This will not work for now because we also support boot option
> rcupdate.rcu_cpu_stall_cputime.

I'm confused. If CONFIG_RCU_CPU_STALL_CPUTIME=n then rcupdate.rcu_cpu_stall_cputime has
no effect, right?

Thanks.

> 
> > 
> >> +static void print_cpu_stat_info(int cpu)
> >> +{
> >> +	struct rcu_snap_record rsr, *rsrp;
> >> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >> +	struct kernel_cpustat *kcsp = &kcpustat_cpu(cpu);
> >> +
> >> +	if (!rcu_cpu_stall_cputime)
> >> +		return;
> >> +
> >> +	rsrp = &rdp->snap_record;
> >> +	if (rsrp->gp_seq != rdp->gp_seq)
> >> +		return;
> >> +
> >> +	rsr.cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
> >> +	rsr.cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
> >> +	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
> >> +
> >> +	pr_err("\t         hardirqs   softirqs   csw/system\n");
> >> +	pr_err("\t number: %8ld %10d %12lld\n",
> >> +		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
> >> +		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
> >> +		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
> >> +	pr_err("\tcputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
> >> +		div_u64(rsr.cputime_irq - rsrp->cputime_irq, NSEC_PER_MSEC),
> >> +		div_u64(rsr.cputime_softirq - rsrp->cputime_softirq, NSEC_PER_MSEC),
> >> +		div_u64(rsr.cputime_system - rsrp->cputime_system, NSEC_PER_MSEC),
> >> +		jiffies64_to_msecs(jiffies - rsrp->jiffies));
> > 
> > jiffies_to_msecs() should be enough.
> 
> OK, thanks.
> 
> > 
> > Thanks.
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
