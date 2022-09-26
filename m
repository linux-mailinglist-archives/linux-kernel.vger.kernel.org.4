Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186645EAEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIZSCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIZSBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2702BE0A8;
        Mon, 26 Sep 2022 10:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C65E6112B;
        Mon, 26 Sep 2022 17:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80130C433D6;
        Mon, 26 Sep 2022 17:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664214160;
        bh=TYfPai1SJhgBw/yIgoHGYTSZw4RvmIQ26nHXVhK7S7o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YWG7As6wlxGdfyT3/OHKOC/y0RwFvt0M9f1BK1wP7mUtNDWTjTlEdMpqyWRjBkvJo
         kPdrnJjReJdwYpO3TXbQ5MAl/bscyrF23lsFOWlEZYw5yIvnWEOPmbFx6hdexa3C8w
         JxqwXxymFOh5Ri6Zy/oTmXjKc3aDVEfrzCfAd4CGsDlDXdug73+g3Knd6nEPnqxa1e
         KCQHKnMHwaB4iQPtFwPvLg9NDrV5wzLxQEk3RRRKgG2xBZmbSXlEycKhIQm1Q7tL79
         MI4FyvWKyfy0LPYsJPv5Gm42xPevSctPvT0xI3FW2qnnuCU2TGYR3xih3gPBrJ3J1T
         t6JMSVUDG4ELw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1FD565C05B1; Mon, 26 Sep 2022 10:42:40 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:42:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220926174240.GO4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220923214408.GC4196@paulmck-ThinkPad-P17-Gen-1>
 <4AE2CA06-8D91-42D7-9EE5-0C99BA7F9D13@joelfernandes.org>
 <20220924211132.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <YzCQYW6yRRBWWMXk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzCQYW6yRRBWWMXk@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 05:31:13PM +0000, Joel Fernandes wrote:
> Hi Paul,
> 
> Back to Mutt for this one ;-)

As they used to say in my youth, "Get a horse!"  ;-)

> Replies below:
> 
> On Sat, Sep 24, 2022 at 02:11:32PM -0700, Paul E. McKenney wrote:
> [...]
> > > >> +     */
> > > >> +    if (lazy && rhp) {
> > > >> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
> > > >> +        rcu_cblist_enqueue(&rcl, rhp);
> > > > 
> > > > Would it makes sense to enqueue rhp onto ->nocb_bypass first, NULL out
> > > > rhp, then let the rcu_cblist_flush_enqueue() be common code?  Or did this
> > > > function grow a later use of rhp that I missed?
> > > 
> > > No that could be done, but it prefer to keep it this
> > >  way because rhp is a function parameter and I
> > > prefer not to modify those since it could add a
> > > bug in future where rhp passed by user is now
> > > NULL for some reason, half way through the
> > > function.
> > 
> > I agree that changing a function parameter is bad practice.
> > 
> > So the question becomes whether introducing a local would outweigh
> > consolidating this code.  Could you please at least give it a shot?
> > 
> > > >> +        WRITE_ONCE(rdp->lazy_len, 0);
> > > >> +    } else {
> > > >> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > > >> +        WRITE_ONCE(rdp->lazy_len, 0);
> > > > 
> > > > This WRITE_ONCE() can be dropped out of the "if" statement, correct?
> > > 
> > > Yes will update.
> > 
> > Thank you!
> > 
> > > > If so, this could be an "if" statement with two statements in its "then"
> > > > clause, no "else" clause, and two statements following the "if" statement.
> > > 
> > > I don’t think we can get rid of the else part but I’ll see what it looks like.
> > 
> > In the function header, s/rhp/rhp_in/, then:
> > 
> > 	struct rcu_head *rhp = rhp_in;
> > 
> > And then:
> > 
> > 	if (lazy && rhp) {
> > 		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> > 		rhp = NULL;
> 
> This enqueues on to the bypass list, where as if lazy && rhp, I want to queue
> the new rhp on to the main cblist. So the pseudo code in my patch is:
> 
> if (lazy and rhp) then
> 	1. flush bypass CBs on to main list.
> 	2. queue new CB on to main list.

And the difference is here, correct?  I enqueue to the bypass list,
which is then flushed (in order) to the main list.  In contrast, you
flush the bypass list, then enqueue to the main list.  Either way,
the callback referenced by rhp ends up at the end of ->cblist.

Or am I on the wrong branch of this "if" statement?

> else
> 	1. flush bypass CBs on to main list
> 	2. queue new CB on to bypass list.
> 
> > 	}
> > 	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > 	WRITE_ONCE(rdp->lazy_len, 0);
> > 
> > Or did I mess something up?
> 
> So the rcu_cblist_flush_enqueue() has to happen before the
> rcu_cblist_enqueue() to preserve the ordering of flushing into the main list,
> and queuing on to the main list for the "if". Where as in your snip, the
> order is reversed.

Did I pick the correct branch of the "if" statement above?  Or were you
instead talking about the "else" clause?

I would have been more worried about getting cblist->len right.

> If I consolidate it then, it looks like the following. However, it is a bit
> more unreadable. I could instead just take the WRITE_ONCE out of both if/else
> and move it to after the if/else, that would be cleanest. Does that sound
> good to you? Thanks!

Let's first figure out whether or not we are talking past one another.  ;-)

							Thanx, Paul

> ---8<-----------------------
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 1a182b9c4f6c..bd3f54d314e8 100644
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
> @@ -348,14 +349,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	 * If the new CB requested was a lazy one, queue it onto the main
>  	 * ->cblist so we can take advantage of a sooner grade period.
>  	 */
> -	if (lazy && rhp) {
> -		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
> -		rcu_cblist_enqueue(&rcl, rhp);
> -		WRITE_ONCE(rdp->lazy_len, 0);
> -	} else {
> -		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> -		WRITE_ONCE(rdp->lazy_len, 0);
> -	}
> +	if (lazy && rhp)
> +		rhp = NULL;
> +	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> +	if (lazy && rhp_in)
> +		rcu_cblist_enqueue(&rcl, rhp_in);
> +
> +	WRITE_ONCE(rdp->lazy_len, 0);
>  
>  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
>  	WRITE_ONCE(rdp->nocb_bypass_first, j);
