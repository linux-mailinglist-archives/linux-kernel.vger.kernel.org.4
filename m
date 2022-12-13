Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB2E64BF43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiLMWU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiLMWUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:20:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF2D1AF07;
        Tue, 13 Dec 2022 14:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53722B815F6;
        Tue, 13 Dec 2022 22:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03116C433D2;
        Tue, 13 Dec 2022 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670970017;
        bh=db8XXM7xw4bBFe9oeneqRnie7ojBSdy6+4wc4wjk7m4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FpaPcZjJp0U4NdnluLqQQGoSIRxDfl6fDogj06Y3Anyh9amC2X2OZ/AST34ZzsEh3
         GPVAv2JH+bKyNY9J5cCqYSWNS5QtuKp0TAPXWNPQM+Ctsp9oeTNUv5zNwEcUnL6W81
         HpDbhe+k2vOVi5ClIULRDESM1ZpMgEK3O8efg5+wJfg+nxs54joxgb4Iqqi9m8hFBe
         EHlYY2QPNMdNiaV9zD3h6ARRtKxmcyDmi1J3Nde2UqaZhFWl3IX6pOjgx7oyxNRFgo
         D5nM1lTCrSN8+JQkiLVRvC5xVccClrYA4EXnoffwpiqwhpfj5Yy5TihmY64y+xyFVx
         hTq1vu2jSPjcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A15CB5C13B7; Tue, 13 Dec 2022 14:20:16 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:20:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        connoro@google.com
Subject: Re: [PATCH v3 rcu/dev 2/2] locktorture: Make the rt_boost factor a
 tunable
Message-ID: <20221213222016.GV4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221213204839.321027-1-joel@joelfernandes.org>
 <20221213204839.321027-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213204839.321027-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 08:48:39PM +0000, Joel Fernandes (Google) wrote:
> The rt boosting in locktorture has a factor variable s currently large enough
> that boosting only happens once every minute or so. Add a tunable to reduce the
> factor so that boosting happens more often, to test paths and arrive at failure
> modes earlier. With this change, I can set the factor to like 50 and have the
> boosting happens every 10 seconds or so.
> 
> Tested with boot parameters:
> locktorture.torture_type=mutex_lock
> locktorture.onoff_interval=1
> locktorture.nwriters_stress=8
> locktorture.stutter=0
> locktorture.rt_boost=1
> locktorture.rt_boost_factor=50
> locktorture.nlocks=3
> 
> [ Apply Davidlohr Bueso feedback on quoting rt_boost_factor. ]
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued and pushed both, thank you both!

I am not seeing any evidence of boot parameters being quoted in the
kernel/locking directory, and I don't feel like I should be the one to
be the first to push that convention into kernel/locking, so I left that
change off.  I don't have an opinion either way on it myself, aside from
being more than a bit wary of the churn that would be required to impose
this convention uniformly.

							Thanx, Paul

> ---
>  kernel/locking/locktorture.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index e2271e8fc302..87e861da0ad5 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -48,6 +48,7 @@ torture_param(int, stat_interval, 60,
>  torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
>  torture_param(int, rt_boost, 2,
>  		"Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
> +torture_param(int, rt_boost_factor, 50, "A factor determining how often rt-boost happens.");
>  torture_param(int, verbose, 1,
>  	     "Enable verbose debugging printk()s");
>  
> @@ -131,12 +132,12 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
>  
>  static void __torture_rt_boost(struct torture_random_state *trsp)
>  {
> -	const unsigned int factor = 50000; /* yes, quite arbitrary */
> +	const unsigned int factor = rt_boost_factor;
>  
>  	if (!rt_task(current)) {
>  		/*
> -		 * Boost priority once every ~50k operations. When the
> -		 * task tries to take the lock, the rtmutex it will account
> +		 * Boost priority once every 'rt_boost_factor' operations. When
> +		 * the task tries to take the lock, the rtmutex it will account
>  		 * for the new priority, and do any corresponding pi-dance.
>  		 */
>  		if (trsp && !(torture_random(trsp) %
> @@ -146,8 +147,9 @@ static void __torture_rt_boost(struct torture_random_state *trsp)
>  			return;
>  	} else {
>  		/*
> -		 * The task will remain boosted for another ~500k operations,
> -		 * then restored back to its original prio, and so forth.
> +		 * The task will remain boosted for another 10 * 'rt_boost_factor'
> +		 * operations, then restored back to its original prio, and so
> +		 * forth.
>  		 *
>  		 * When @trsp is nil, we want to force-reset the task for
>  		 * stopping the kthread.
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
