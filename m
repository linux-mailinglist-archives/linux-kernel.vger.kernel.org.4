Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BDC5F36AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJCTtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJCTtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:49:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D0949B4F;
        Mon,  3 Oct 2022 12:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2764EB81243;
        Mon,  3 Oct 2022 19:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC845C433D7;
        Mon,  3 Oct 2022 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664826549;
        bh=8RMELpb1gRywIzrfwPRBZ65ezuHZV4slRqNYPKkQ844=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ic5mtAxpR0r6xaiY5Glh/9q8Okbyt2bQxrEQJcGnH/5g36mPXw9RnV5SLrcdCBcCc
         xIrbOlfB18AEYuLKWDaRl2t74zbZrbUVR3JINPipQR2VrYxn/6lKwYjPc/r7Ad1Ufn
         M1sWc2dvK50MbZes4kValr/dtkII/CrimqUkd68I6ogPLi9ChIw9pY6gffac0PLGZG
         cxxHemwOfMHHEmcJ191GQICW+O6CCjZJsFoGz6rZLKG3J1urkLRwivkqVBakkEOW9c
         x5WwrQPd8+5MCvx/AgvpFJcLfULE8zeiMY0uG4UxpVluQhQ5n4LgD6zjSVxf9owC5H
         L1SKVb0IQnBdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 637E75C089F; Mon,  3 Oct 2022 12:49:09 -0700 (PDT)
Date:   Mon, 3 Oct 2022 12:49:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20221003194909.GC4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220926223751.GZ4196@paulmck-ThinkPad-P17-Gen-1>
 <A78761F4-5922-418A-AFA3-01101C399778@joelfernandes.org>
 <20220926235351.GC4196@paulmck-ThinkPad-P17-Gen-1>
 <Yzs5BC4SSM1A3BTO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yzs5BC4SSM1A3BTO@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 07:33:24PM +0000, Joel Fernandes wrote:
> On Mon, Sep 26, 2022 at 04:53:51PM -0700, Paul E. McKenney wrote:
> > On Mon, Sep 26, 2022 at 07:33:17PM -0400, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Sep 26, 2022, at 6:37 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > 
> > > > ﻿On Mon, Sep 26, 2022 at 09:07:12PM +0000, Joel Fernandes wrote:
> > > >> Hi Paul,
> > > >> 
> > > >> On Mon, Sep 26, 2022 at 10:42:40AM -0700, Paul E. McKenney wrote:
> > > >> [..]
> > > >>>>>>>> +        WRITE_ONCE(rdp->lazy_len, 0);
> > > >>>>>>>> +    } else {
> > > >>>>>>>> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > > >>>>>>>> +        WRITE_ONCE(rdp->lazy_len, 0);
> > > >>>>>>> 
> > > >>>>>>> This WRITE_ONCE() can be dropped out of the "if" statement, correct?
> > > >>>>>> 
> > > >>>>>> Yes will update.
> > > >>>>> 
> > > >>>>> Thank you!
> > > >>>>> 
> > > >>>>>>> If so, this could be an "if" statement with two statements in its "then"
> > > >>>>>>> clause, no "else" clause, and two statements following the "if" statement.
> > > >>>>>> 
> > > >>>>>> I don’t think we can get rid of the else part but I’ll see what it looks like.
> > > >>>>> 
> > > >>>>> In the function header, s/rhp/rhp_in/, then:
> > > >>>>> 
> > > >>>>>    struct rcu_head *rhp = rhp_in;
> > > >>>>> 
> > > >>>>> And then:
> > > >>>>> 
> > > >>>>>    if (lazy && rhp) {
> > > >>>>>        rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> > > >>>>>        rhp = NULL;
> > > >>>> 
> > > >>>> This enqueues on to the bypass list, where as if lazy && rhp, I want to queue
> > > >>>> the new rhp on to the main cblist. So the pseudo code in my patch is:
> > > >>>> 
> > > >>>> if (lazy and rhp) then
> > > >>>>    1. flush bypass CBs on to main list.
> > > >>>>    2. queue new CB on to main list.
> > > >>> 
> > > >>> And the difference is here, correct?  I enqueue to the bypass list,
> > > >>> which is then flushed (in order) to the main list.  In contrast, you
> > > >>> flush the bypass list, then enqueue to the main list.  Either way,
> > > >>> the callback referenced by rhp ends up at the end of ->cblist.
> > > >>> 
> > > >>> Or am I on the wrong branch of this "if" statement?
> > > >> 
> > > >> But we have to flush first, and then queue the new one. Otherwise wouldn't
> > > >> the callbacks be invoked out of order? Or did I miss something?
> > > > 
> > > > I don't think so...
> > > > 
> > > > We want the new callback to be last, right?  One way to do that is to
> > > > flush the bypass, then queue the new callback onto ->cblist.  Another way
> > > > to do that is to enqueue the new callback onto the end of the bypass,
> > > > then flush the bypass.  Why wouldn't these result in the same order?
> > > 
> > > Yes you are right, sorry. I was fixated on the main list. Both your snippet and my patch will be equivalent then. However I find your snippet a bit confusing, as in it is not immediately obvious - why would we queue something on to a list, if we were about to flush it. But any way, it does make it a clever piece of code in some sense and I am ok with doing it this way ;-)
> > 
> > As long as the ->cblist.len comes out with the right value.  ;-)
> 
> The ->cblist.len's value is not effected by your suggested change, because
> the bypass list's length is already accounted into the ->cblist.len, and for
> the new rhp, after rcu_nocb_do_flush_bypass() is called, it either ends up in
> the bypass list (if it is !lazy) or on the main cblist (if its lazy). So
> everything just works. Below is the change. If its OK with you though, I will
> put it in a separate commit just to be extra safe, since the code before it
> was well tested and I am still testing it.

Having this as a separate simplification commit is fine by me.

And thank you for digging into this!

								Thanx, Paul

> Thanks.
> 
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
> 
> This consolidates the code a bit and makes it cleaner. Functionally it
> is the same.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_nocb.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index d69d058a78f9..1fc704d102a3 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -327,10 +327,11 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
>   *
>   * Note that this function always returns true if rhp is NULL.
>   */
> -static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> +static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
>  				     unsigned long j, unsigned long flush_flags)
>  {
>  	struct rcu_cblist rcl;
> +	struct rcu_head *rhp = rhp_in;
>  	bool lazy = flush_flags & FLUSH_BP_LAZY;
>  
>  	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
> @@ -347,16 +348,15 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	/*
>  	 * If the new CB requested was a lazy one, queue it onto the main
>  	 * ->cblist so that we can take advantage of the grace-period that will
> -	 * happen regardless.
> +	 * happen regardless. But queue it onto the bypass list first so that
> +	 * the lazy CB is ordered with the existing CBs in the bypass list.
>  	 */
>  	if (lazy && rhp) {
> -		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
> -		rcu_cblist_enqueue(&rcl, rhp);
> -		WRITE_ONCE(rdp->lazy_len, 0);
> -	} else {
> -		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> -		WRITE_ONCE(rdp->lazy_len, 0);
> +		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> +		rhp = NULL;
>  	}
> +	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> +	WRITE_ONCE(rdp->lazy_len, 0);
>  
>  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
>  	WRITE_ONCE(rdp->nocb_bypass_first, j);
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
