Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405B8667308
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjALNSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjALNSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:18:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172751E3F5;
        Thu, 12 Jan 2023 05:18:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B908EB81DC4;
        Thu, 12 Jan 2023 13:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD57C433EF;
        Thu, 12 Jan 2023 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673529491;
        bh=BDvN5ZLk/njQe+svUcrjrAn0YUpLJT8kpaTkXNuJp98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSaxD7QkgYx9p5tWhyMFfpdO2b+EEtrBZAjChsbD7SrzlCNF53BprbbzhkfsRlW9c
         d5Deemm2bVOryepkiiJ351o4ZEzO5XUKgzoKk5rIyxpzdmtIyDwfiNKmiyjKOgl6h4
         OXKdhLB7ZpexCU6YB1Q7Y+003QUdnLYcThMbVPJZuXptMKSjpqEhrxj1JtQ0eqBmZ5
         IatZN8yfga/80omt4IMZPC0PVuA8EgSt+0aOXpy2f/avMyr+kvkM+e8+jnyrBVMPca
         BDuWeh7IeuSAse6JL+O60gf6iZvGqYN2CVX2CWdtBc+rBMV117lng958X1WsdfN5lh
         YFKshjYRU4RXA==
Date:   Thu, 12 Jan 2023 14:18:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited()
 be invoked very early
Message-ID: <Y8AIkL0ZT7nhiYFK@lothringen>
References: <20230112075629.1661429-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112075629.1661429-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 03:56:29PM +0800, Zqiang wrote:
> Currently, the start_poll_synchronize_rcu_expedited() can be invoked
> very early. before rcu_init(), the rcu_data structure's->mynode is not
> initialized, if invoke start_poll_synchronize_rcu_expedited() before
> rcu_init(), will trigger a null rcu_node structure's->exp_seq_poll access.
> 
> This commit add boot_exp_seq_poll_rq member to rcu_state structure to
> store seq number return by invoke start_poll_synchronize_rcu_expedited()
> very early.
> 
> Fixes: d96c52fe4907 ("rcu: Add polled expedited grace-period primitives")
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Just a nit below:

> ---
>  kernel/rcu/tree.c     | 3 ++-
>  kernel/rcu/tree.h     | 1 +
>  kernel/rcu/tree_exp.h | 6 ++++--
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 63545d79da51..12f0891ce7f4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -92,6 +92,7 @@ static struct rcu_state rcu_state = {
>  	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex),
>  	.exp_wake_mutex = __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex),
>  	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> +	.boot_exp_seq_poll_rq = RCU_GET_STATE_COMPLETED,
>  };
>  
>  /* Dump rcu_node combining tree at boot to verify correct setup. */
> @@ -4938,7 +4939,7 @@ void __init rcu_init(void)
>  		qovld_calc = qovld;
>  
>  	// Kick-start any polled grace periods that started early.
> -	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
> +	if (!(rcu_state.boot_exp_seq_poll_rq & 0x1))

This can be "if (!(rcu_state.boot_exp_seq_poll_rq == RCU_GET_STATE_COMPLETED))" 

>  		(void)start_poll_synchronize_rcu_expedited();
>  
>  	rcu_test_sync_prims();
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 192536916f9a..ae50ca6853ad 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -397,6 +397,7 @@ struct rcu_state {
>  						/* Synchronize offline with */
>  						/*  GP pre-initialization. */
>  	int nocb_is_setup;			/* nocb is setup from boot */
> +	unsigned long boot_exp_seq_poll_rq;

A comment on the right can mention: "/* exp seq poll request before rcu_init() */"

Thanks!

>  };
>  
>  /* Values for rcu_state structure's gp_flags field. */
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 956cd459ba7f..1b35a1e233d9 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -1068,9 +1068,11 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
>  	if (rcu_init_invoked())
>  		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
>  	if (!poll_state_synchronize_rcu(s)) {
> -		rnp->exp_seq_poll_rq = s;
> -		if (rcu_init_invoked())
> +		if (rcu_init_invoked()) {
> +			rnp->exp_seq_poll_rq = s;
>  			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
> +		} else
> +			rcu_state.boot_exp_seq_poll_rq = s;
>  	}
>  	if (rcu_init_invoked())
>  		raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
> -- 
> 2.25.1
> 
