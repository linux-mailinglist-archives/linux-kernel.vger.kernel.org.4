Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138776678DF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjALPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbjALPPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:15:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D0C3C3A8;
        Thu, 12 Jan 2023 07:07:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6E2762036;
        Thu, 12 Jan 2023 15:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2857C433D2;
        Thu, 12 Jan 2023 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673536030;
        bh=RYC7OJ01AKIFCO3BEi4odVSTc9VcQo0r2QTBNIOjcT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfFt8d64p368aPW00H8FPPmms+mpKYz5fyPJ4w3Ko1lQtUwaDgzx0gJWYtuD9Hj7M
         uAuDbuqw2WtJpp3ECiEku+cgW3HfqzCOTvNksWaNHfRYRngZMTHglFuJOP7szqCHOV
         yt7qB70CU4aPJOhD4PP/mG6x0+aJkZGnA0LCfoSKAglLiu0dbPaRd+nGpHGu5x0pKa
         LN4thza51itIHDhfl3OWr+NYf93k1rIAOQPXF4FgQD7jSah/KmHmvke4WOyUwkXOXb
         sfI4t1Mqr1F8Lg46EX1/VLhS+ss0N5z5V+5ZZRuZhCx+D5DEZ1He74BhjSIDtBL6SR
         nzBLgsz22oicw==
Date:   Thu, 12 Jan 2023 16:07:07 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Remove duplicate settings for rcu boost kthreads
 affinity
Message-ID: <Y8AiGy6iYiUk7iB+@lothringen>
References: <20221215090029.2972236-1-qiang1.zhang@intel.com>
 <20221217010919.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880B9403488CAB5DF9810FFDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58806ABF242993103390A6F5DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221221192622.GD4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221192622.GD4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 11:26:22AM -0800, Paul E. McKenney wrote:
> On Sat, Dec 17, 2022 at 01:02:03PM +0000, Zhang, Qiang1 wrote:
> commit 5815245b56229198d5f5d0c48c26d3c0c53ee222
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Wed Dec 21 11:15:43 2022 -0800
> 
>     rcu: Remove redundant call to rcu_boost_kthread_setaffinity()
>     
>     The rcu_boost_kthread_setaffinity() function is invoked at
>     rcutree_online_cpu() and rcutree_offline_cpu() time, early in the online
>     timeline and late in the offline timeline, respectively.  It is also
>     invoked from rcutree_dead_cpu(), however, in the absence of userspace
>     manipulations (for which userspace must take responsibility), this call
>     is redundant with that from rcutree_offline_cpu().  This redundancy can
>     be demonstrated by printing out the relevant cpumasks
>     
>     This commit therefore removes the call to rcu_boost_kthread_setaffinity()
>     from rcutree_dead_cpu().
>     
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!


> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c3255d27286c4..a6181b76fd5ab 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4165,15 +4165,10 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
>   */
>  int rcutree_dead_cpu(unsigned int cpu)
>  {
> -	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> -	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> -
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>  		return 0;
>  
>  	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> -	/* Adjust any no-longer-needed kthreads. */
> -	rcu_boost_kthread_setaffinity(rnp, -1);
>  	// Stop-machine done, so allow nohz_full to disable tick.
>  	tick_dep_clear(TICK_DEP_BIT_RCU);
>  	return 0;
