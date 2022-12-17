Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8353864F6AC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiLQBJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLQBJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:09:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2D26489;
        Fri, 16 Dec 2022 17:09:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2349362295;
        Sat, 17 Dec 2022 01:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE18C433EF;
        Sat, 17 Dec 2022 01:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671239359;
        bh=8xpp5MLvKY8KzVXKEqfKMt8HVvfyO0C36vgYBC8BXg4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ac2sr7K4EDW2JK34cSpmEXQmOaOV+p3SSawEjRXnz7IfpjXBn409LfOtFWfQOHYbo
         2/YjKiBoS0oE4ZoZ/gtn5ggCIas7gdp6SSOHbdiYGLte+0MOJ4BR/Ub9lZAKiaFq45
         ck9DyqI8tPUsviSIrByuXGeOwGP2LKnOWU8O7SOD4le7OCdNEaaET/tMe86ZI6zSTg
         1Vq7JWcHT7837HJk/aaERJJPlyO9I8pYsrCS8OYSZrWal6QD48JCRTB6boHfbvpeFD
         agFaZdDkwN7Ct9cN3vkM4Z55h1eHQXyCvePQ+zn2hSj2wH2RLfmA5KU5CUpm0oE5Wr
         mVoS5A+J3/eJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 234F85C0A2D; Fri, 16 Dec 2022 17:09:19 -0800 (PST)
Date:   Fri, 16 Dec 2022 17:09:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove duplicate settings for rcu boost kthreads
 affinity
Message-ID: <20221217010919.GG4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221215090029.2972236-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215090029.2972236-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:00:29PM +0800, Zqiang wrote:
> Currently, when CPUs going offline, the rcu boost kthreads CPU
> affinity has been reset in rcutree_offline_cpu(), therefore this
> commit remove duplicate settings in rcutree_dead_cpu().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

One question...

Given that rcutree_offline_cpu() causes rcu_boost_kthread_setaffinity()
to be invoked with the number of the outgoing CPU, but rcutree_dead_cpu()
instead passes in -1, are these two invocations really redundant?

							Thanx, paul

> ---
>  kernel/rcu/tree.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 65f3dd2fd3ae..20de83ed0c7e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4122,15 +4122,10 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
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
> -- 
> 2.25.1
> 
