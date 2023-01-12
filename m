Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373F1667F62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbjALTdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240399AbjALTcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:32:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4048BAE52;
        Thu, 12 Jan 2023 11:27:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B67AF6215D;
        Thu, 12 Jan 2023 19:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF9DC433EF;
        Thu, 12 Jan 2023 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673551645;
        bh=knR8cl3o+HfVzBhq/zdyoNjRSHVV4P+0dXDoWli0Txw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GcZluJXo7+9YmFaADjGPdfhmvj5WxPIHBMO0HGqkM2KQUGYclHP0JAsxTpLB4ATLf
         /nnJfKuqjbwCf2EzYjinzfuJw98quMujcKZKPQV4eWNDxvEZ+yk8eMXTPqSGRlJzru
         dHJXr2oQ1GuF62qdAaBr1Yg1YvtL32LUk8ohyZ00ke8dGYAbl/f3kysYgpTn6Y/jYT
         BfDexzSoH3lsA9lqt/PXElDDPRxgSIaVL8EhR9DJEFOybO+IaDUX8Rt4TIx1MuQxP/
         qb9uZmJTVTve1U8zRmB0E1NuMP5SuQv70SQCekziPDJ4NVQxgNqS5/bjBXTdj1pxAn
         Qlh4rE3qmMjEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BC5A05C0AF8; Thu, 12 Jan 2023 11:27:24 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:27:24 -0800
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
Message-ID: <20230112192724.GA3610129@paulmck-ThinkPad-P17-Gen-1>
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
> 
> I also booted debian Linux and verified the flag is reset correctly after boot
> completes. Thanks.

After going back and forth a bit, I took these two as-is (aside from
the usual commit-log wordsmithing).

At some point, the state-change-notification from things like boot,
suspend/resume, sysrq-t, and panic() should probably be refactored.
But I do not believe that we are yet at that point, and there is not
much point in half-refactorings in cases such as this one.

I added the Fixes tags, and, if testing goes well, I plan to submit
them into the upcoming merge window.  I have no reason to believe that
anyone is hitting this, it is only a few weeks away anyhow, and a good
chunk of that would be consumed by testing and review.

And if someone does hit it, we do have your fixes to send to them, so
thank you for that!

(These won't become visible on -rcu until I complete today's rebase,
in case you were wondering.)

						Thanx, Paul

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
