Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D92E6CF4A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjC2Uo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC2Uo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:44:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E6F1985;
        Wed, 29 Mar 2023 13:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51A8FB8243B;
        Wed, 29 Mar 2023 20:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ABCC433EF;
        Wed, 29 Mar 2023 20:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680122694;
        bh=rlvOoss2lwuSgPse3uwfSjVIpRXM0gtIahyFHTbcZHM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YynDBGv4SFEFYCOTZpdYhBs47EkHYRxllrqcZCPDmFBhwkCVe4A4Nl4Fx3RIIQNpi
         zW12DhUx4JGA6qn7LCovXa1twZ4UH/Ir38iu8FtEMRNSGXQ5ql0e+JsSp1BC0/NMZC
         T0t7GZK/y9AkP4M4/Fzp5U97xpPoT7WiNEsRQHZTI6YWWQ9JZ98ZykAZL68ipDNXVT
         T6n2RA1To1dPnOT1+4PoIlG3FbEtw6getmH0jWVOulIPqT1sLhS2DJx3FohEMOZ366
         JKTvFn9FTvwZ+vP99t4CQf9S1Vo+mVxgBhHbuZFSUX96FmnaOg8MLUrPIBtjhMJeS+
         bUhLLZMzK4zng==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 43D39154047D; Wed, 29 Mar 2023 13:44:53 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:44:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent
 (de-)offloading
Message-ID: <1c1313c5-5d57-4692-8295-da199da31cb9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230329160203.191380-1-frederic@kernel.org>
 <20230329160203.191380-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329160203.191380-2-frederic@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 06:02:00PM +0200, Frederic Weisbecker wrote:
> The shrinker may run concurrently with callbacks (de-)offloading. As
> such, calling rcu_nocb_lock() is very dangerous because it does a
> conditional locking. The worst outcome is that rcu_nocb_lock() doesn't
> lock but rcu_nocb_unlock() eventually unlocks, or the reverse, creating
> an imbalance.
> 
> Fix this with protecting against (de-)offloading using the barrier mutex.
> Although if the barrier mutex is contended, which should be rare, then
> step aside so as not to trigger a mutex VS allocation
> dependency chain.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree_nocb.h | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f2280616f9d5..1a86883902ce 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1336,13 +1336,33 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	unsigned long flags;
>  	unsigned long count = 0;
>  
> +	/*
> +	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
> +	 * may be ignored or imbalanced.
> +	 */
> +	if (!mutex_trylock(&rcu_state.barrier_mutex)) {

This looks much better, thank you!

> +		/*
> +		 * But really don't insist if barrier_mutex is contended since we
> +		 * can't guarantee that it will never engage in a dependency
> +		 * chain involving memory allocation. The lock is seldom contended
> +		 * anyway.
> +		 */
> +		return 0;
> +	}
> +
>  	/* Snapshot count of all CPUs */
>  	for_each_possible_cpu(cpu) {
>  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> -		int _count = READ_ONCE(rdp->lazy_len);
> +		int _count;
> +
> +		if (!rcu_rdp_is_offloaded(rdp))
> +			continue;
> +
> +		_count = READ_ONCE(rdp->lazy_len);
>  
>  		if (_count == 0)
>  			continue;
> +

And I just might have unconfused myself here.  We get here only if this
CPU is offloaded, in which case it might also have non-zero ->lazy_len,
so this is in fact *not* dead code.

>  		rcu_nocb_lock_irqsave(rdp, flags);
>  		WRITE_ONCE(rdp->lazy_len, 0);
>  		rcu_nocb_unlock_irqrestore(rdp, flags);
> @@ -1352,6 +1372,9 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		if (sc->nr_to_scan <= 0)
>  			break;
>  	}
> +
> +	mutex_unlock(&rcu_state.barrier_mutex);
> +
>  	return count ? count : SHRINK_STOP;
>  }
>  
> -- 
> 2.34.1
> 
