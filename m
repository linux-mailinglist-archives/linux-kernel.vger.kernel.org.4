Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03DA5E9059
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiIXWqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIXWqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:46:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856FA491FF;
        Sat, 24 Sep 2022 15:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9888BCE02C7;
        Sat, 24 Sep 2022 22:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E7FC433C1;
        Sat, 24 Sep 2022 22:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664059600;
        bh=eHSWTYnYsyVR2UjL5XkSiNfNQCN0O0WOvvT2T6zd9/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTvEy692J7m3Bc7aiAqp/ud5O+dnXdHo/ejW4MEq5xuFjGRMJ1CVmrDxHY97EIM4f
         uEi4e5HAjI4b5hiyg6C5hcKV+Gp1dhP76ZnGquDWlh0aEdVzIEkkVOib4HNgrEOfnh
         kOFr1VVbKZr3ZaF/J1bR8Zaffs3LPMnuX+6yTdegwSa23UrFLE9VkfouZIHSF1Yw81
         FK732zZDV2BzCJNLIeggo8Hfen6mzyfj529ec2PMtJJHjITRNZXmp76sZPv26fZsWF
         eRbj0RU8yMOEzZQxmsrGuMjOto5s56x5eO5297Ihf/SQhPoWVRk+we26xbLKSXhqW7
         L3zfXLvL8w7DA==
Date:   Sun, 25 Sep 2022 00:46:37 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220924224637.GA161871@lothringen>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922220104.2446868-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:01:01PM +0000, Joel Fernandes (Google) wrote:
> @@ -3902,7 +3939,11 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  	rdp->barrier_head.func = rcu_barrier_callback;
>  	debug_rcu_head_queue(&rdp->barrier_head);
>  	rcu_nocb_lock(rdp);
> -	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> +	/*
> +	 * Flush the bypass list, but also wake up the GP thread as otherwise
> +	 * bypass/lazy CBs maynot be noticed, and can cause real long delays!
> +	 */
> +	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_WAKE));

This fixes an issue that goes beyond lazy implementation. It should be done
in a separate patch, handling rcu_segcblist_entrain() as well, with "Fixes: " tag.

And then FLUSH_BP_WAKE is probably not needed anymore. 

>  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>  		atomic_inc(&rcu_state.barrier_cpu_count);
>  	} else {
> @@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>  
>  	/*
> -	 * Bypass wakeup overrides previous deferments. In case
> -	 * of callback storm, no need to wake up too early.
> +	 * Bypass wakeup overrides previous deferments. In case of
> +	 * callback storm, no need to wake up too early.
>  	 */
> -	if (waketype == RCU_NOCB_WAKE_BYPASS) {
> +	if (waketype == RCU_NOCB_WAKE_LAZY
> +		&& READ_ONCE(rdp->nocb_defer_wakeup) == RCU_NOCB_WAKE_NOT) {

This can be a plain READ since ->nocb_defer_wakeup is only written under ->nocb_gp_lock.

> +		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> +	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
>  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>  	} else {
> @@ -512,9 +598,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  	}
>  	// Need to actually to a wakeup.
>  	len = rcu_segcblist_n_cbs(&rdp->cblist);
> +	bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +	lazy_len = READ_ONCE(rdp->lazy_len);
>  	if (was_alldone) {
>  		rdp->qlen_last_fqs_check = len;
> -		if (!irqs_disabled_flags(flags)) {
> +		// Only lazy CBs in bypass list
> +		if (lazy_len && bypass_len == lazy_len) {
> +			rcu_nocb_unlock_irqrestore(rdp, flags);
> +			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
> +					   TPS("WakeLazy"));

I'm trying to think of a case where rcu_nocb_try_bypass() returns false
(queue to regular list) but then call_rcu() -> __call_rcu_nocb_wake() ends up
seeing a lazy bypass queue even though we are queueing a non-lazy callback
(should have flushed in this case).

Looks like it shouldn't happen, even with concurrent (de-offloading) but just
in case, can we add:

      WARN_ON_ONCE(lazy_len != len)

> +		} else if (!irqs_disabled_flags(flags)) {
>  			/* ... if queue was empty ... */
>  			rcu_nocb_unlock_irqrestore(rdp, flags);
>  			wake_nocb_gp(rdp, false);

Thanks.
