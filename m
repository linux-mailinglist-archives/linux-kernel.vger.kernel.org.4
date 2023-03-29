Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44C36CF4E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjC2U6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC2U6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:58:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AC544B8;
        Wed, 29 Mar 2023 13:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55BC9B82380;
        Wed, 29 Mar 2023 20:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC0CC433D2;
        Wed, 29 Mar 2023 20:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680123487;
        bh=jZSvfkxfSobZMH0f4f+AmJcVVJiuIjKI73HVR4F6utI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HXHoYum1XH7llICQ5HsSpSuY4Uw7M9FQO4NDH19g3IEFPvcGDU8Nh7nhzQJLYACQa
         kuu071pujfpUNoYsaxyZfGeraQRkI0ItVFaIVXy3R+00pLxF/s1cv9RsypXmvKsoJ7
         YZrO9M1rwJch9ontBlN7Zt76MSLfZQA8k0NLNe4WVf3w88/CB4fPsJ2U3AtQsU2T2P
         M/762IiJwCdx0RTOVB8sR2EawozNm1kkEHL4Ix9AKc0EVpaU4xL4yhcl4ieopUTvXp
         qTq2H9JbQOgW8MOQw63JiSSobyQMxJ1NnQ64TRaMaVi6t+EOhVFbfVI30pIMSbOilR
         a7CF3NCeNXNLQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9BB84154047D; Wed, 29 Mar 2023 13:58:06 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:58:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 4/4] rcu/nocb: Make shrinker to iterate only NOCB CPUs
Message-ID: <519aadf0-6acd-43c0-89cf-caab9e229a46@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230329160203.191380-1-frederic@kernel.org>
 <20230329160203.191380-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329160203.191380-5-frederic@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 06:02:03PM +0200, Frederic Weisbecker wrote:
> Callbacks can only be queued as lazy on NOCB CPUs, therefore iterating
> over the NOCB mask is enough for both counting and scanning. Just lock
> the mostly uncontended barrier mutex on counting as well in order to
> keep rcu_nocb_mask stable.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Looks plausible.  ;-)

What are you doing to test this?  For that matter, what should rcutorture
be doing to test this?  My guess is that the current callback flooding in
rcu_torture_fwd_prog_cr() should do the trick, but figured I should ask.

							Thanx, Paul

> ---
>  kernel/rcu/tree_nocb.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index dfa9c10d6727..43229d2b0c44 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1319,13 +1319,22 @@ lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  	int cpu;
>  	unsigned long count = 0;
>  
> +	if (WARN_ON_ONCE(!cpumask_available(rcu_nocb_mask)))
> +		return 0;
> +
> +	/*  Protect rcu_nocb_mask against concurrent (de-)offloading. */
> +	if (!mutex_trylock(&rcu_state.barrier_mutex))
> +		return 0;
> +
>  	/* Snapshot count of all CPUs */
> -	for_each_possible_cpu(cpu) {
> +	for_each_cpu(cpu, rcu_nocb_mask) {
>  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  
>  		count +=  READ_ONCE(rdp->lazy_len);
>  	}
>  
> +	mutex_unlock(&rcu_state.barrier_mutex);
> +
>  	return count ? count : SHRINK_EMPTY;
>  }
>  
> @@ -1336,6 +1345,8 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	unsigned long flags;
>  	unsigned long count = 0;
>  
> +	if (WARN_ON_ONCE(!cpumask_available(rcu_nocb_mask)))
> +		return 0;
>  	/*
>  	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
>  	 * may be ignored or imbalanced.
> @@ -1351,11 +1362,11 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	}
>  
>  	/* Snapshot count of all CPUs */
> -	for_each_possible_cpu(cpu) {
> +	for_each_cpu(cpu, rcu_nocb_mask) {
>  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  		int _count;
>  
> -		if (!rcu_rdp_is_offloaded(rdp))
> +		if (WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp)))
>  			continue;
>  
>  		if (!READ_ONCE(rdp->lazy_len))
> -- 
> 2.34.1
> 
