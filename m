Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBCF62CDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbiKPWkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiKPWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:39:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C4C59878;
        Wed, 16 Nov 2022 14:39:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50E6161FF9;
        Wed, 16 Nov 2022 22:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CDDC433D6;
        Wed, 16 Nov 2022 22:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668638385;
        bh=ieNpiLVdRQunBu175zpt6RHDSuNw5y2DmXy3+JAlHuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VX9H5+oaEIeH/5Zn+GPn6WPKff7fSkYMmav3bvxfKs2qBw9qPPxIi9T5JCyU42kvb
         hSV4MrzCzxdpZX0RXRAeIFiGe3EdiD06xQDEnim8XauSAjAI2JUF5mkICwwBAiYayD
         idSsj7VC9QOs2A2XaGMHyepfmwQoah1zszOZE9zdg/H9rTswOtw1rcEyxRoy/jbgSS
         5ZKhQ5sqp6dpbxNmechqQc01ZtBV4FZ1WNnINIyIaWMW4c8GMvJ1KmPw4TyiPIhNpL
         2M5nqHPEOqc2PmJF9Pv/LCd5LjvJTnoZCe7ITDdhRwGRkcN60I6LBUHlwJbV737l9W
         LP0xjMVKZi/5g==
Date:   Wed, 16 Nov 2022 23:39:42 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v7 4/6] rcu: Add RCU stall diagnosis information
Message-ID: <20221116223942.GA838972@lothringen>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111130709.247-5-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:07:07PM +0800, Zhen Lei wrote:
> @@ -262,6 +279,8 @@ struct rcu_data {
>  	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
>  	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
>  	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
> +	struct rcu_snap_record snap_record; /* Snapshot of core stats at half of */
> +					    /* the first RCU stall timeout */

This should be under #ifdef CONFIG_RCU_CPU_STALL_CPUTIME

> +static void print_cpu_stat_info(int cpu)
> +{
> +	struct rcu_snap_record rsr, *rsrp;
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +	struct kernel_cpustat *kcsp = &kcpustat_cpu(cpu);
> +
> +	if (!rcu_cpu_stall_cputime)
> +		return;
> +
> +	rsrp = &rdp->snap_record;
> +	if (rsrp->gp_seq != rdp->gp_seq)
> +		return;
> +
> +	rsr.cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
> +	rsr.cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
> +	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
> +
> +	pr_err("\t         hardirqs   softirqs   csw/system\n");
> +	pr_err("\t number: %8ld %10d %12lld\n",
> +		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
> +		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
> +		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
> +	pr_err("\tcputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
> +		div_u64(rsr.cputime_irq - rsrp->cputime_irq, NSEC_PER_MSEC),
> +		div_u64(rsr.cputime_softirq - rsrp->cputime_softirq, NSEC_PER_MSEC),
> +		div_u64(rsr.cputime_system - rsrp->cputime_system, NSEC_PER_MSEC),
> +		jiffies64_to_msecs(jiffies - rsrp->jiffies));

jiffies_to_msecs() should be enough.

Thanks.

