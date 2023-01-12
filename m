Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268CD666864
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjALB3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjALB3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:29:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78265E8;
        Wed, 11 Jan 2023 17:29:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5398861F1C;
        Thu, 12 Jan 2023 01:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0441C433EF;
        Thu, 12 Jan 2023 01:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673486990;
        bh=luOxm3+i/J9Q/Ezer2VdFlolnQ7fylcdvzVjPTHlZW0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Dd4tYj20l/gEgLbXUmWmL3KJlnKalbUwOBfXBBaRgLVcLPsy3gMQbNaIBPQgueGGf
         Cphs5P4hvjK+8QPo6TmOXOdwEzuZ5QHrLxe6/RjS0xk+Yi7CRPBo0xcd8z57i7QUwX
         /oGgJYEZWKGJArz/6wopodabV80KTBJ92pRS/5JdtLconKVD6hDaeqNKc+Yw7sf6bV
         N08smO4BHslniKtjUS4N/ZVBAqgPwXnrqWC7ELusNkLDBZDh2eoRNeZb2NuB0y0b78
         bsndBU7Z5CLUsL8d/vtROw4Tt1OX/blwDCf3QDi2t8l9b866P+RWENU26oh+GgJ0nP
         iRHymdtxed2Ew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3CB6A5C06D0; Wed, 11 Jan 2023 17:29:50 -0800 (PST)
Date:   Wed, 11 Jan 2023 17:29:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        fweisbec@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and
 suspend
Message-ID: <20230112012950.GE4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230112005223.2329802-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112005223.2329802-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 12:52:22AM +0000, Joel Fernandes (Google) wrote:
> During boot and suspend/resume, it is desired to prevent RCU laziness from
> effecting performance and in some cases failures like with suspend.
> 
> Track whether RCU laziness is to be ignored or not, in kernels with
> CONFIG_RCU_LAZY enabled. We do such tracking for expedited-RCU already, however
> since Android currently expedites synchronous_rcu() always, we cannot rely on
> that. The next patch ignores laziness hints based on this tracking.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> Paul, could we take this and the next one for 6.2 -rc cycle?

Given how late it is in v6.2, I would need you to make it all depend on
CONFIG_RCU_LAZY, so that it is blindingly and immediately obvious that
there is no change in behavior for kernels built with CONFIG_RCU_LAZY=n.

If you are OK with the v6.3 merge window and backports, what you have
likely suffices, modulo review and testing.

So, how would you like to proceed?

							Thanx, Paul

> I also booted debian Linux and verified the flag is reset correctly after boot
> completes. Thanks.
> 
>  kernel/rcu/rcu.h    |  6 ++++++
>  kernel/rcu/tree.c   |  2 ++
>  kernel/rcu/update.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 cc_list
>  create mode 100644 to_list
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 5c8013f7085f..115616ac3bfa 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -449,14 +449,20 @@ do {									\
>  /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
>  static inline bool rcu_gp_is_normal(void) { return true; }
>  static inline bool rcu_gp_is_expedited(void) { return false; }
> +static inline bool rcu_async_should_hurry(void) { return false; }
>  static inline void rcu_expedite_gp(void) { }
>  static inline void rcu_unexpedite_gp(void) { }
> +static inline void rcu_async_hurry(void) { }
> +static inline void rcu_async_relax(void) { }
>  static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
>  #else /* #ifdef CONFIG_TINY_RCU */
>  bool rcu_gp_is_normal(void);     /* Internal RCU use. */
>  bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
> +bool rcu_async_should_hurry(void);  /* Internal RCU use. */
>  void rcu_expedite_gp(void);
>  void rcu_unexpedite_gp(void);
> +void rcu_async_hurry(void);
> +void rcu_async_relax(void);
>  void rcupdate_announce_bootup_oddness(void);
>  #ifdef CONFIG_TASKS_RCU_GENERIC
>  void show_rcu_tasks_gp_kthreads(void);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 63545d79da51..78b2e999c904 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4504,11 +4504,13 @@ static int rcu_pm_notify(struct notifier_block *self,
>  	switch (action) {
>  	case PM_HIBERNATION_PREPARE:
>  	case PM_SUSPEND_PREPARE:
> +		rcu_async_hurry();
>  		rcu_expedite_gp();
>  		break;
>  	case PM_POST_HIBERNATION:
>  	case PM_POST_SUSPEND:
>  		rcu_unexpedite_gp();
> +		rcu_async_relax();
>  		break;
>  	default:
>  		break;
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 3893022f8ed8..19bf6fa3ee6a 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -144,8 +144,45 @@ bool rcu_gp_is_normal(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_gp_is_normal);
>  
> -static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
> +static atomic_t rcu_async_hurry_nesting = ATOMIC_INIT(1);
> +/*
> + * Should call_rcu() callbacks be processed with urgency or are
> + * they OK being executed with arbitrary delays?
> + */
> +bool rcu_async_should_hurry(void)
> +{
> +	return !IS_ENABLED(CONFIG_RCU_LAZY) ||
> +	       atomic_read(&rcu_async_hurry_nesting);
> +}
> +EXPORT_SYMBOL_GPL(rcu_async_should_hurry);
> +
> +/**
> + * rcu_async_hurry - Make future async RCU callbacks not lazy.
> + *
> + * After a call to this function, future calls to call_rcu()
> + * will be processed in a timely fashion.
> + */
> +void rcu_async_hurry(void)
> +{
> +	if (IS_ENABLED(CONFIG_RCU_LAZY))
> +		atomic_inc(&rcu_async_hurry_nesting);
> +}
> +EXPORT_SYMBOL_GPL(rcu_async_hurry);
>  
> +/**
> + * rcu_async_relax - Make future async RCU callbacks lazy.
> + *
> + * After a call to this function, future calls to call_rcu()
> + * will be processed in a lazy fashion.
> + */
> +void rcu_async_relax(void)
> +{
> +	if (IS_ENABLED(CONFIG_RCU_LAZY))
> +		atomic_dec(&rcu_async_hurry_nesting);
> +}
> +EXPORT_SYMBOL_GPL(rcu_async_relax);
> +
> +static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
>  /*
>   * Should normal grace-period primitives be expedited?  Intended for
>   * use within RCU.  Note that this function takes the rcu_expedited
> @@ -195,6 +232,7 @@ static bool rcu_boot_ended __read_mostly;
>  void rcu_end_inkernel_boot(void)
>  {
>  	rcu_unexpedite_gp();
> +	rcu_async_relax();
>  	if (rcu_normal_after_boot)
>  		WRITE_ONCE(rcu_normal, 1);
>  	rcu_boot_ended = true;
> -- 
> 2.39.0.314.g84b9a713c41-goog
