Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C6A6C5A30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCVXSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCVXS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:18:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFB1969A;
        Wed, 22 Mar 2023 16:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98FBBB81D54;
        Wed, 22 Mar 2023 23:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CDDC433D2;
        Wed, 22 Mar 2023 23:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679527105;
        bh=k6wvhbcJbaBJ1X4EdD057Q9Y+QFDlOgff68w44KovM0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MqMmLCSTtOEBTJSPg3sNAXAmWLR/FFKJKnSYpu39lctsWKnM4c6Q1yvQcUoOtqu5l
         StMsT4vMByc5sh9LM81+zmTHz8K0h4L8KYVHu3F1FrX9cY3eI9Wv/zwgBpxX3B6EgD
         Z99P0OxdzVpNU8+g2Y1OiQdzBYmNmHhYcgcRSJ1gb9g/Ago472zIpSZHmAqcyf9D0d
         KVcVodxWAcABKT+fS0vg+ZkXggYBZZ1hdFvj0uBxaNm+jkv9+SqDHSnIuytqOo7j0u
         Mm99wCKaBtccCz+awBm1Vo705H5Gw5aOaTfvxrMFUaXM6NJGHg65uk66SH6FosxLm2
         lXmgosuwQ+wHA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BC93E1540397; Wed, 22 Mar 2023 16:18:24 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:18:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent
 (de-)offloading
Message-ID: <c614c542-f2b5-4b39-bbc4-ae5f0a125c81@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230322194456.2331527-1-frederic@kernel.org>
 <20230322194456.2331527-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322194456.2331527-2-frederic@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:44:53PM +0100, Frederic Weisbecker wrote:
> The shrinker may run concurrently with callbacks (de-)offloading. As
> such, calling rcu_nocb_lock() is very dangerous because it does a
> conditional locking. The worst outcome is that rcu_nocb_lock() doesn't
> lock but rcu_nocb_unlock() eventually unlocks, or the reverse, creating
> an imbalance.
> 
> Fix this with protecting against (de-)offloading using the barrier mutex.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Good catch!!!  A few questions, comments, and speculations below.

							Thanx, Paul

> ---
>  kernel/rcu/tree_nocb.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f2280616f9d5..dd9b655ae533 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1336,13 +1336,25 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	unsigned long flags;
>  	unsigned long count = 0;
>  
> +	/*
> +	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
> +	 * may be ignored or imbalanced.
> +	 */
> +	mutex_lock(&rcu_state.barrier_mutex);

I was worried about this possibly leading to out-of-memory deadlock,
but if I recall correctly, the (de-)offloading process never allocates
memory, so this should be OK?

The other concern was that the (de-)offloading operation might take a
long time, but the usual cause for that is huge numbers of callbacks,
in which case letting them free their memory is not necessarily a bad
strategy.

> +
>  	/* Snapshot count of all CPUs */
>  	for_each_possible_cpu(cpu) {
>  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> -		int _count = READ_ONCE(rdp->lazy_len);
> +		int _count;
> +
> +		if (!rcu_rdp_is_offloaded(rdp))
> +			continue;

If the CPU is offloaded, isn't ->lazy_len guaranteed to be zero?

Or can it contain garbage after a de-offloading operation?

> +		_count = READ_ONCE(rdp->lazy_len);
>  
>  		if (_count == 0)
>  			continue;
> +
>  		rcu_nocb_lock_irqsave(rdp, flags);
>  		WRITE_ONCE(rdp->lazy_len, 0);
>  		rcu_nocb_unlock_irqrestore(rdp, flags);
> @@ -1352,6 +1364,9 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
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
