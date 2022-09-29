Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EFD5EF890
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiI2PU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbiI2PUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:20:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E414595F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C04AB824F2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8E5C433C1;
        Thu, 29 Sep 2022 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664464845;
        bh=sqQ6oe05gq7aYThrxlVt8MSq59/VzcXG/IUm78quuqA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PofQJdRrpEpBa+pn2m+DuYCl4mCS+5DffX+lNKosx7ZbKQT+BM1MAXfkEPDMgyzQr
         DZ1evuMZ6RdlzsWK8b4pSr538ADWaBLtwQ4CuuXf+7hXt+6PH0+Q+74FJSO1Prcn/L
         QqfxjAYjA8JJ/8V6YU4bISIRR6rZvAAzX4XSmsgF7b0k4MjBmIgq1YkTDex0o3CslD
         +3Zu5G1NoGdLRVJOAggG4qDVVcPjLRMkfinv/oMC/fhfTGlsv1Tp3epvvMRhLtKXc4
         2mlQyAdVGWOWNNLOGLXKCInaLXfJFIa+4nHMUE8HjfQEA0DNNqJazpaNmLtG/Xvh1R
         YvhLbQh9x3Qfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D44315C0AC7; Thu, 29 Sep 2022 08:20:44 -0700 (PDT)
Date:   Thu, 29 Sep 2022 08:20:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:55:58PM +0200, Peter Zijlstra wrote:
> On Sat, Sep 17, 2022 at 07:25:08AM -0700, Paul E. McKenney wrote:
> > On Fri, Sep 16, 2022 at 11:20:14AM +0200, Peter Zijlstra wrote:
> > > On Fri, Sep 16, 2022 at 12:58:17AM -0700, Paul E. McKenney wrote:
> > > 
> > > > To the best of my knowledge at this point in time, agreed.  Who knows
> > > > what someone will come up with next week?  But for people running certain
> > > > types of real-time and HPC workloads, context tracking really does handle
> > > > both idle and userspace transitions.
> > > 
> > > Sure, but idle != nohz. Nohz is where we disable the tick, and currently
> > > RCU can inhibit this -- rcu_needs_cpu().
> > 
> > Exactly.  For non-nohz userspace execution, the tick is still running
> > anyway, so RCU of course won't be inhibiting its disabling.  And in that
> > case, RCU's hook is the tick interrupt itself.  RCU's hook is passed a
> > flag saying whether the interrupt came from userspace or from kernel.
> 
> I'm not sure how we ended up here; this is completely irrelevant and I'm
> not disagreeing with it.
> 
> > > AFAICT there really isn't an RCU hook for this, not through context
> > > tracking not through anything else.
> > 
> > There is a directly invoked RCU hook for any transition that enables or
> > disables the tick, namely the ct_*_enter() and ct_*_exit() functions,
> > that is, those functions formerly known as rcu_*_enter() and rcu_*_exit().
> 
> Context tracking doesn't know about NOHZ, therefore RCU can't either.
> Context tracking knows about IDLE, but not all IDLE is NOHZ-IDLE.
> 
> Specifically we have:
> 
> 	ct_{idle,irq,nmi,user,kernel}_enter()
> 
> And none of them are related to NOHZ in the slightest. So no, RCU does
> not have a NOHZ callback.
> 
> I'm still thikning you're conflating NOHZ_FULL (stopping the tick when
> in userspace) and regular NOHZ (stopping the tick when idle).
> 
> > And this of course means that any additional schemes to reduce RCU's
> > power consumption must be compared (with real measurements on real
> > hardware!) to Joel et al.'s work, whether in combination or as an
> > alternative.  And either way, the power savings must of course justify
> > the added code and complexity.
> 
> Well, Joel's lazy scheme has the difficulty that you can wreck things by
> improperly marking the callback as lazy when there's an explicit
> dependency on it. The talk even called that out.
> 
> I was hoping to construct a scheme that doesn't need the whole lazy
> approach.
> 
> 
> To recap; we want the CPU to go into deeper idle states, no?
> 
> RCU can currently inhibit this by having callbacks pending for this CPU
> -- in this case RCU inhibits NOHZ-IDLE and deep power states are not
> selected or less effective.
> 
> Now, deep idle states actually purge the caches, so cache locality
> cannot be an argument to keep the callbacks local.
> 
> We know when we're doing deep idle we stop the tick.
> 
> So why not, when stopping the tick, move the RCU pending crud elsewhere
> and let the CPU get on with going idle instead of inhibiting the
> stopping of the tick and wrecking deep idle?

Because doing so in the past has cost more energy than is saved.

							Thanx, Paul
