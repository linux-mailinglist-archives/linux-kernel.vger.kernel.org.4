Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA71F5C0055
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIUOyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIUOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:54:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AA55FF50;
        Wed, 21 Sep 2022 07:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67ABBB83027;
        Wed, 21 Sep 2022 14:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27719C433D6;
        Wed, 21 Sep 2022 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772056;
        bh=N7rXLPz/wHSQhimjH/4apy7jZtngaME80JDdD/mzkoQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JIVQ2fNUPaf7W3WVf7fTO7oslichj/bTyvJR7SQQmvTP6kLdzTAFMSEzA+ALUrwT2
         oY8VnbFN0mITjBcsHM98sUBf0BFy+525Za30M0CWuIdMgB59Swo0lxeG88WUBTdJZl
         DL5NhPecvnlb3PDIP2KsdW76+P+nT4uWzzSLMtlsfHpZZrl/er3C9s41z18RrXbRfh
         uEp01aWE4Yo2ryCP0m1mdRevRCfZJL6me3Ki8muZ3vYTFGijrxxTZ1B4RdDOIrgZW2
         dJeNefD7cYwUfdAx+B02GvKKND7pazO16QvZpjQKG9RWKTA/PSoF3TF+rUQdgPJUid
         cP2YdIB+W7spg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BF51B5C0849; Wed, 21 Sep 2022 07:54:15 -0700 (PDT)
Date:   Wed, 21 Sep 2022 07:54:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH rcu/next 2/3] rcu: Fix late wakeup when flush of bypass
 cblist happens (v6)
Message-ID: <20220921145415.GC4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220917164200.511783-1-joel@joelfernandes.org>
 <20220917164200.511783-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917164200.511783-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 04:41:59PM +0000, Joel Fernandes (Google) wrote:
> When the bypass cblist gets too big or its timeout has occurred, it is
> flushed into the main cblist. However, the bypass timer is still running
> and the behavior is that it would eventually expire and wake the GP
> thread.
> 
> Since we are going to use the bypass cblist for lazy CBs, do the wakeup
> soon as the flush for "too big or too long" bypass list happens.
> Otherwise, long delays can happen for callbacks which get promoted from
> lazy to non-lazy.
> 
> This is a good thing to do anyway (regardless of future lazy patches),
> since it makes the behavior consistent with behavior of other code paths
> where flushing into the ->cblist makes the GP kthread into a
> non-sleeping state quickly.
> 
> [ Frederic Weisbec: changes to not do wake up GP thread unless needed,
> 		    comment changes ].
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued and pushed this and 1/3, thank you both!

							Thanx, Paul

> ---
>  kernel/rcu/tree_nocb.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 0a5f0ef41484..04c87f250e01 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -433,8 +433,9 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
>  	    ncbs >= qhimark) {
>  		rcu_nocb_lock(rdp);
> +		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> +
>  		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
> -			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>  			if (*was_alldone)
>  				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  						    TPS("FirstQ"));
> @@ -447,7 +448,12 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  			rcu_advance_cbs_nowake(rdp->mynode, rdp);
>  			rdp->nocb_gp_adv_time = j;
>  		}
> -		rcu_nocb_unlock_irqrestore(rdp, flags);
> +
> +		// The flush succeeded and we moved CBs into the regular list.
> +		// Don't wait for the wake up timer as it may be too far ahead.
> +		// Wake up the GP thread now instead, if the cblist was empty.
> +		__call_rcu_nocb_wake(rdp, *was_alldone, flags);
> +
>  		return true; // Callback already enqueued.
>  	}
>  
> -- 
> 2.37.3.968.ga6b4b080e4-goog
> 
