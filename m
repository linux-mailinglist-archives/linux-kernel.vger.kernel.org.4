Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA724622EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiKIPU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiKIPUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:20:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E11CFD5;
        Wed,  9 Nov 2022 07:20:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E17BB81F2F;
        Wed,  9 Nov 2022 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84203C433D6;
        Wed,  9 Nov 2022 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668007220;
        bh=Vr/cy832j8J0sCXCxl3MEXl0xqNDZqkspPy8VOsvgco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNCgBq/hQu8OJoZzunEhGp1nahLqMwNsRoVfZMsrY5MzxVSdAGzGTwHnLfI+ckLDe
         zWt6022kLiHXWysNtWiWs0k+umlg8tNve/yslT3WVCtrcgqzO+VOy9VTl6SP3IJjxU
         oQjG8ER5oYcc/ZO9BmAyCb4a3V3UlxLpG/DQmCsSkvtEbL0Xz+8UJrucJGsrjPc+c+
         WYHQkH2HOQBGmaRKf7+L6eQJMNiYHtay6SF7i2aSQK/d24ujuXOmgyydL9lACe7J6a
         df+N1GDARxOwnZqbJrwX81b+hPBGaaU1GYh2DkuR8EnkE7HkuQzeTBYf21N50LTby7
         OuWnAGJ94GRqw==
Date:   Wed, 9 Nov 2022 16:20:17 +0100
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
Subject: Re: [PATCH v6 1/2] rcu: Add RCU stall diagnosis information
Message-ID: <20221109152017.GA298612@lothringen>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109093739.187-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109093739.187-2-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:37:37PM +0800, Zhen Lei wrote:
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ed93ddb8203d42c..e1ff23b2a14d71d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -866,6 +866,23 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
>  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
>  		}
> +
> +		if (rcu_cpu_stall_cputime && rdp->snap_record.gp_seq != rdp->gp_seq) {
> +			u64 *cpustat;
> +			struct rcu_snap_record *rsrp;
> +
> +			cpustat = kcpustat_cpu(rdp->cpu).cpustat;
> +
> +			rsrp = &rdp->snap_record;
> +			rsrp->cputime_irq     = cpustat[CPUTIME_IRQ];
> +			rsrp->cputime_softirq = cpustat[CPUTIME_SOFTIRQ];
> +			rsrp->cputime_system  = cpustat[CPUTIME_SYSTEM];

You need to use kcpustat_field(), otherwise you'll get stalled values on nohz_full CPUs.

> +			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
> +			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
> +			rsrp->nr_csw = nr_context_switches_cpu(rdp->cpu);
> +			rsrp->jiffies = jiffies;
> +			rsrp->gp_seq = rdp->gp_seq;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 5653560573e22d6..7b6afb9c7b96dbe 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -428,6 +428,33 @@ static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp
>  	return j > 2 * HZ;
>  }
>  
> +static void print_cpu_stat_info(int cpu)
> +{
> +	u64 *cpustat;
> +	struct rcu_snap_record *rsrp;
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +
> +	if (!rcu_cpu_stall_cputime)
> +		return;
> +
> +	rsrp = &rdp->snap_record;
> +	if (rsrp->gp_seq != rdp->gp_seq)
> +		return;
> +
> +	cpustat = kcpustat_cpu(cpu).cpustat;
> +
> +	pr_err("         hardirqs   softirqs   csw/system\n");
> +	pr_err(" number: %8ld %10d %12lld\n",
> +		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
> +		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
> +		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
> +	pr_err("cputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
> +		div_u64(cpustat[CPUTIME_IRQ] - rsrp->cputime_irq, NSEC_PER_MSEC),
> +		div_u64(cpustat[CPUTIME_SOFTIRQ] - rsrp->cputime_softirq, NSEC_PER_MSEC),
> +		div_u64(cpustat[CPUTIME_SYSTEM] - rsrp->cputime_system,
> NSEC_PER_MSEC),

Same here.

Thanks.
