Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9FD6CF4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjC2Uy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2UyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:54:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD710FB;
        Wed, 29 Mar 2023 13:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9653F61E27;
        Wed, 29 Mar 2023 20:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB292C433D2;
        Wed, 29 Mar 2023 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680123261;
        bh=AbVWsfd24flX0NPK7NPatY9+8fT6TeXiEaIfWJAqTIM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=M/MwojbQOjIFYA215EwwrbyaIYUfgtTlJvfup4puyu0OpeSoE84RHFBW4HmnMEI0t
         lFUexgCWABLMPBoMerI0L163fWcVNtSSkr0UJCv3OYVS0z3FPK3qeHbIwuxH616Yxs
         M7imhua9aINkFUuh9Nzwemsp2ELRtBrpohR+DWto+mHzJfBBh0Nr1+IZvTG91OPLuq
         gbG56QSj7i8lTGtLQ3k+j8djUIrN3GXhOGbIvMq2QKoDNjeVeomQgQKM8p7YsPPpBc
         D7RFRQAwvyNK+wC5JCAojVDqhRqsZzLZOCn0QiMJgclaKds/zGXufDwgfRBsoARlvH
         7WGflIt3350JA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7C9FA154047D; Wed, 29 Mar 2023 13:54:20 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:54:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/4] rcu/nocb: Recheck lazy callbacks under the
 ->nocb_lock from shrinker
Message-ID: <8df51703-1ee4-4b7b-9e05-90b3650e8ee7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230329160203.191380-1-frederic@kernel.org>
 <20230329160203.191380-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329160203.191380-4-frederic@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 06:02:02PM +0200, Frederic Weisbecker wrote:
> The ->lazy_len is only checked locklessly. Recheck again under the
> ->nocb_lock to avoid spending more time on flushing/waking if not
> necessary. The ->lazy_len can still increment concurrently (from 1 to
> infinity) but under the ->nocb_lock we at least know for sure if there
> are lazy callbacks at all (->lazy_len > 0).
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree_nocb.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index c321fce2af8e..dfa9c10d6727 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1358,12 +1358,20 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		if (!rcu_rdp_is_offloaded(rdp))
>  			continue;
>  
> +		if (!READ_ONCE(rdp->lazy_len))
> +			continue;

Do you depend on the ordering of the above read of ->lazy_len against
anything in the following, aside from the re-read of ->lazy_len?  (Same
variable, both READ_ONCE() or stronger, so you do get that ordering.)

If you do need that ordering, the above READ_ONCE() needs to instead
be smp_load_acquire() or similar.  If you don't need that ordering,
what you have is good.

> +		rcu_nocb_lock_irqsave(rdp, flags);
> +		/*
> +		 * Recheck under the nocb lock. Since we are not holding the bypass
> +		 * lock we may still race with increments from the enqueuer but still
> +		 * we know for sure if there is at least one lazy callback.
> +		 */
>  		_count = READ_ONCE(rdp->lazy_len);
> -
> -		if (_count == 0)
> +		if (!_count) {
> +			rcu_nocb_unlock_irqrestore(rdp, flags);
>  			continue;
> -
> -		rcu_nocb_lock_irqsave(rdp, flags);
> +		}
>  		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
>  		rcu_nocb_unlock_irqrestore(rdp, flags);
>  		wake_nocb_gp(rdp, false);
> -- 
> 2.34.1
> 
