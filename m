Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345E06687F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjALXuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjALXuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:50:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FDDA45F;
        Thu, 12 Jan 2023 15:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6A08B82039;
        Thu, 12 Jan 2023 23:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672B7C433D2;
        Thu, 12 Jan 2023 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673567413;
        bh=N4m4bXPk4Vvg4JUzPHaMx6XKiDu3zzjCCgl7Rx7jJqI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=soxLYVYVJmOnxATKSgIyibxbYO9gKNhpTnPVSRBc1/Y8o88BewcvkLzq9X0KLQlwc
         Soi6IWDb6ABGMGT7ghTTb51jJc38e5oAJS3tHECGFor9LDUD6FUtw14RQ2qayCVbme
         PXcPKfEgr7xicG/BcdFb4AHo59U4YNQaYv+aLrVm7BZ0c0O8F5uyRVpi3eDZtwJBS/
         bhW1NIVkKrUeDLAUHGA/Ys3vVVmy3FRjwfCpJSVHY8G+j1CExT8oBVq5laomlh4tDR
         5WwiF5QbxL2ZJ6fUxQDs752Q06U5v/1T4nkl5YzaXR/kVVLzKUhN5Pzb15hLyjDh7i
         Ja1vUdLUQdBOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 066C45C09F1; Thu, 12 Jan 2023 15:50:13 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:50:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        fweisbec@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and
 suspend
Message-ID: <20230112235013.GU4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230112192724.GA3610129@paulmck-ThinkPad-P17-Gen-1>
 <E588EAC4-D8F2-4893-A668-816C0C7104B2@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E588EAC4-D8F2-4893-A668-816C0C7104B2@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 05:25:51PM -0500, Joel Fernandes wrote:
> 
> 
> > On Jan 12, 2023, at 2:27 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Thu, Jan 12, 2023 at 12:52:22AM +0000, Joel Fernandes (Google) wrote:
> >> During boot and suspend/resume, it is desired to prevent RCU laziness from
> >> effecting performance and in some cases failures like with suspend.
> >> 
> >> Track whether RCU laziness is to be ignored or not, in kernels with
> >> CONFIG_RCU_LAZY enabled. We do such tracking for expedited-RCU already, however
> >> since Android currently expedites synchronous_rcu() always, we cannot rely on
> >> that. The next patch ignores laziness hints based on this tracking.
> >> 
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> ---
> >> Paul, could we take this and the next one for 6.2 -rc cycle?
> >> 
> >> I also booted debian Linux and verified the flag is reset correctly after boot
> >> completes. Thanks.
> > 
> > After going back and forth a bit, I took these two as-is (aside from
> > the usual commit-log wordsmithing).
> > 
> > At some point, the state-change-notification from things like boot,
> > suspend/resume, sysrq-t, and panic() should probably be refactored.
> > But I do not believe that we are yet at that point, and there is not
> > much point in half-refactorings in cases such as this one.
> > 
> > I added the Fixes tags, and, if testing goes well, I plan to submit
> > them into the upcoming merge window.  I have no reason to believe that
> > anyone is hitting this, it is only a few weeks away anyhow, and a good
> > chunk of that would be consumed by testing and review.
> > 
> > And if someone does hit it, we do have your fixes to send to them, so
> > thank you for that!
> > (These won't become visible on -rcu until I complete today's rebase,
> > in case you were wondering.)
> 
> Thanks and this sounds good to me. Meanwhile I pulled into our product kernel so all is good.

Very good!  Please let me know how it goes!

							Thanx, Paul

> Thanks,
> 
>  - Joel
> 
> 
> > 
> >                        Thanx, Paul
> > 
> >> kernel/rcu/rcu.h    |  6 ++++++
> >> kernel/rcu/tree.c   |  2 ++
> >> kernel/rcu/update.c | 40 +++++++++++++++++++++++++++++++++++++++-
> >> 5 files changed, 55 insertions(+), 1 deletion(-)
> >> create mode 100644 cc_list
> >> create mode 100644 to_list
> >> 
> >> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> >> index 5c8013f7085f..115616ac3bfa 100644
> >> --- a/kernel/rcu/rcu.h
> >> +++ b/kernel/rcu/rcu.h
> >> @@ -449,14 +449,20 @@ do {                                    \
> >> /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
> >> static inline bool rcu_gp_is_normal(void) { return true; }
> >> static inline bool rcu_gp_is_expedited(void) { return false; }
> >> +static inline bool rcu_async_should_hurry(void) { return false; }
> >> static inline void rcu_expedite_gp(void) { }
> >> static inline void rcu_unexpedite_gp(void) { }
> >> +static inline void rcu_async_hurry(void) { }
> >> +static inline void rcu_async_relax(void) { }
> >> static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
> >> #else /* #ifdef CONFIG_TINY_RCU */
> >> bool rcu_gp_is_normal(void);     /* Internal RCU use. */
> >> bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
> >> +bool rcu_async_should_hurry(void);  /* Internal RCU use. */
> >> void rcu_expedite_gp(void);
> >> void rcu_unexpedite_gp(void);
> >> +void rcu_async_hurry(void);
> >> +void rcu_async_relax(void);
> >> void rcupdate_announce_bootup_oddness(void);
> >> #ifdef CONFIG_TASKS_RCU_GENERIC
> >> void show_rcu_tasks_gp_kthreads(void);
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index 63545d79da51..78b2e999c904 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -4504,11 +4504,13 @@ static int rcu_pm_notify(struct notifier_block *self,
> >>    switch (action) {
> >>    case PM_HIBERNATION_PREPARE:
> >>    case PM_SUSPEND_PREPARE:
> >> +        rcu_async_hurry();
> >>        rcu_expedite_gp();
> >>        break;
> >>    case PM_POST_HIBERNATION:
> >>    case PM_POST_SUSPEND:
> >>        rcu_unexpedite_gp();
> >> +        rcu_async_relax();
> >>        break;
> >>    default:
> >>        break;
> >> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> >> index 3893022f8ed8..19bf6fa3ee6a 100644
> >> --- a/kernel/rcu/update.c
> >> +++ b/kernel/rcu/update.c
> >> @@ -144,8 +144,45 @@ bool rcu_gp_is_normal(void)
> >> }
> >> EXPORT_SYMBOL_GPL(rcu_gp_is_normal);
> >> 
> >> -static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
> >> +static atomic_t rcu_async_hurry_nesting = ATOMIC_INIT(1);
> >> +/*
> >> + * Should call_rcu() callbacks be processed with urgency or are
> >> + * they OK being executed with arbitrary delays?
> >> + */
> >> +bool rcu_async_should_hurry(void)
> >> +{
> >> +    return !IS_ENABLED(CONFIG_RCU_LAZY) ||
> >> +           atomic_read(&rcu_async_hurry_nesting);
> >> +}
> >> +EXPORT_SYMBOL_GPL(rcu_async_should_hurry);
> >> +
> >> +/**
> >> + * rcu_async_hurry - Make future async RCU callbacks not lazy.
> >> + *
> >> + * After a call to this function, future calls to call_rcu()
> >> + * will be processed in a timely fashion.
> >> + */
> >> +void rcu_async_hurry(void)
> >> +{
> >> +    if (IS_ENABLED(CONFIG_RCU_LAZY))
> >> +        atomic_inc(&rcu_async_hurry_nesting);
> >> +}
> >> +EXPORT_SYMBOL_GPL(rcu_async_hurry);
> >> 
> >> +/**
> >> + * rcu_async_relax - Make future async RCU callbacks lazy.
> >> + *
> >> + * After a call to this function, future calls to call_rcu()
> >> + * will be processed in a lazy fashion.
> >> + */
> >> +void rcu_async_relax(void)
> >> +{
> >> +    if (IS_ENABLED(CONFIG_RCU_LAZY))
> >> +        atomic_dec(&rcu_async_hurry_nesting);
> >> +}
> >> +EXPORT_SYMBOL_GPL(rcu_async_relax);
> >> +
> >> +static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
> >> /*
> >>  * Should normal grace-period primitives be expedited?  Intended for
> >>  * use within RCU.  Note that this function takes the rcu_expedited
> >> @@ -195,6 +232,7 @@ static bool rcu_boot_ended __read_mostly;
> >> void rcu_end_inkernel_boot(void)
> >> {
> >>    rcu_unexpedite_gp();
> >> +    rcu_async_relax();
> >>    if (rcu_normal_after_boot)
> >>        WRITE_ONCE(rcu_normal, 1);
> >>    rcu_boot_ended = true;
> >> -- 
> >> 2.39.0.314.g84b9a713c41-goog
