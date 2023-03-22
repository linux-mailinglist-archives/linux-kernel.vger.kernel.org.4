Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D766C5A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCVXV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCVXVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE7220D23;
        Wed, 22 Mar 2023 16:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC9D362306;
        Wed, 22 Mar 2023 23:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEADC433D2;
        Wed, 22 Mar 2023 23:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679527309;
        bh=0RxS9LzwqEuTpc0Cc7hCnYLzybmb7bUKnNrtE5zK+bs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V9ALjO2HecoXi/TgMkx805aggmhFZnwvg0FS4sGwJZaQ1doK7ga/PEjuaK9sFRfdB
         YlHfGIpACSeI1Agaa5LQoAAHMKykzVcTR9un3sD4vmxnSi22ef/9rivCgBkBgaJxh3
         CIHK3QScB5U3jfEosKnnomKMWniaQeMSbvx/U3nyDVCvvRTxmfjT/LFwCG4P0vf+ZL
         h3KCAVmgy7uSt7e53RqVreznOE//gLT53GGDMr+9bGzyX4bmBqAG1ynG2iALlrBl4r
         YCBaHI6mjaEhfhi9ermaUzIsJUMNEMxRFEGSHjaGp5DW0whXv47vtfL76tzO//4xf4
         GxDmuZCu7MkaQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CB3EA1540397; Wed, 22 Mar 2023 16:21:48 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:21:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/4] rcu/nocb: Recheck lazy callbacks under the
 ->nocb_lock from shrinker
Message-ID: <29087017-d349-4710-a7cb-04948fb104df@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230322194456.2331527-1-frederic@kernel.org>
 <20230322194456.2331527-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322194456.2331527-4-frederic@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:44:55PM +0100, Frederic Weisbecker wrote:
> The ->lazy_len is only checked locklessly. Recheck again under the
> ->nocb_lock to avoid spending more time on flushing/waking if not
> necessary. The ->lazy_len can still increment concurrently (from 1 to
> infinity) but under the ->nocb_lock we at least know for sure if there
> are lazy callbacks at all (->lazy_len > 0).
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

This one looks plausible, and might hold the answer to earlier
questions.

							Thanx, Paul

> ---
>  kernel/rcu/tree_nocb.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index cb57e8312231..a3dc7465b0b2 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1350,12 +1350,20 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		if (!rcu_rdp_is_offloaded(rdp))
>  			continue;
>  
> +		if (!READ_ONCE(rdp->lazy_len))
> +			continue;
> +
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
