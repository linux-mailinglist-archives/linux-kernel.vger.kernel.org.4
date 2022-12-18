Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED646505B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 00:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLRXbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 18:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiLRXbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 18:31:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AF1625F;
        Sun, 18 Dec 2022 15:31:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1D74CE0B65;
        Sun, 18 Dec 2022 23:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D064C433EF;
        Sun, 18 Dec 2022 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671406257;
        bh=h7iuzz8UVrqbvVSIZSAZKZQgGhq5Drf6tGGemI48zmo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KFvnwHfY0xL7oJRj4uBD73t+VD7zJ3MgflTFBYNF3y3RU3nKEUdfVSjR5NAHY8vtS
         iLh1wwh0o694BFbTEImV/+7J6pAyWEgVHMNNHEpss6br0DY7uYZNMR58Nyb8sfXYdn
         azM4D72/ozyGyEn2OT+64Y2H2mM4BuTvjH650eHyqP/jkI23K10dqrBhCpKnBk240X
         jZpFy1vW24m8LzGI5X/6Us0JDdmniV3qO4UduV+3aZzAA9sDhX5W/6/UdA7lyRb5AC
         jgwynDXAlindBpbaImbtL6ID3pWqsnQwlGsl7PtC4VxC4wPR2rMzfK0dX6pg+7NgbU
         haCFaanpnmZqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ABACC5C0EBF; Sun, 18 Dec 2022 15:30:56 -0800 (PST)
Date:   Sun, 18 Dec 2022 15:30:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fix opposite might_sleep() check in
 rcu_blocking_is_gp()
Message-ID: <20221218233056.GU4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221215035755.2820163-1-qiang1.zhang@intel.com>
 <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880526CB255AFF91F0D76A2DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588000890D537044BBAA209EDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221217051759.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <Y550Z+MOq1IX3Wb4@google.com>
 <20221218180638.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSy4MyUW55Umtt4LRfX_4Dhdv0h2O=n+Zbq2ijakwGnBw@mail.gmail.com>
 <20221218194434.GS4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQvbcvxh7u7sU-VjdAYUWpxDzdH-68qk_AjY54hMjNYMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQvbcvxh7u7sU-VjdAYUWpxDzdH-68qk_AjY54hMjNYMg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 04:02:35PM -0500, Joel Fernandes wrote:
> On Sun, Dec 18, 2022 at 2:44 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > > > If not, I would do something like this:
> > > > >
> > > > > ---8<-----------------------
> > > > >
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 79aea7df4345..23c2303de9f4 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -3435,11 +3435,12 @@ static int rcu_blocking_is_gp(void)
> > > > >  {
> > > > >       int ret;
> > > > >
> > > > > +     might_sleep();  /* Check for RCU read-side critical section. */
> > > > > +
> > > > >       // Invoking preempt_model_*() too early gets a splat.
> > > > >       if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE ||
> > > > >           preempt_model_full() || preempt_model_rt())
> > > > >               return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
> >
> > If the scheduler is inactive (early boot with interrupts disabled),
> > we return here.
> >
> > > > > -     might_sleep();  /* Check for RCU read-side critical section. */
> >
> > We get here only if the scheduler has started, and even then only in
> > preemption-disabled kernels.
> >
> > Or is you concern that the might_sleep() never gets invoked in kernels
> > with preemption enabled?  Fixing that would require a slightly different
> > patch, though.
> >
> > Or should I have waited until tomorrow to respond to this email?  ;-)
> 
> No, I think you are quite right. I was not referring to
> rcu_sleep_check(), but rather the following prints in might_sleep(). I
> see an unconditional call to might_sleep()  from kvfree_call_rcu() but
> not one from synchronize_rcu() which can also sleep.
> 
> But I see your point, early boot code has interrupts disabled, but can
> still totally call synchronize_rcu() when the scheduler is INACTIVE.
> And might_sleep() might bitterly complain. Thanks for the
> clarification.
> 
> pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
>       file, line);
> pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d,
> name: %s\n",
>       in_atomic(), irqs_disabled(), current->non_block_count,
>       current->pid, current->comm);
> pr_err("preempt_count: %x, expected: %x\n", preempt_count(),
>       offsets & MIGHT_RESCHED_PREEMPT_MASK);

And I do not believe that we have defined whether or not it is OK to
invoke single-argument kvfree_rcu() before the scheduler has started.  ;-)

							Thanx, Paul
