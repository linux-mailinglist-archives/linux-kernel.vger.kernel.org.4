Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF96367B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbiKWRyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiKWRyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:54:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6152E65844;
        Wed, 23 Nov 2022 09:54:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E55BBB82208;
        Wed, 23 Nov 2022 17:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AA9C433D7;
        Wed, 23 Nov 2022 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669226077;
        bh=KojPnCJDd+viWW6lLyZAJlQQAA7kDDhcYbMJeadUl/g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZmFzWMqQyUimMTw5jdhvuXaNi9STJVNZY0Dj3dlMyquHVUUkGbbMCY4ot4DNMsNqT
         PFmUbxfCqQIOf+slnTfIercvXQvZhn2v82VM+yFA25mLs63I9cB4itvtbZL4Ho+4EB
         RRBISd6ETV0iFXGXQGqmYcO67QR+QRjj+5+eIcXmbAZ0gNV/aZ0KDK1TXfdLEw67v6
         eLTwtI9A6uwVrI73FKLibYsqMEdYH9Rv0OoTZcEPfkvOGsMI7oUrMLOtsx4/ma6ky6
         gkck0ema33P83/BIt6BOqVGNcE2yMFaQOyEyt31ZrpxxJSaMOok7GX8cj9ous7Tj27
         EYG6j/JywzdeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3313F5C0A3F; Wed, 23 Nov 2022 09:54:37 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:54:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v2 rcu 05/16] rcu: Refactor code a bit in
 rcu_nocb_do_flush_bypass()
Message-ID: <20221123175437.GA4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
 <20221122010421.3799681-5-paulmck@kernel.org>
 <20221123155929.GB1387380@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123155929.GB1387380@lothringen>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 04:59:29PM +0100, Frederic Weisbecker wrote:
> On Mon, Nov 21, 2022 at 05:04:10PM -0800, Paul E. McKenney wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > This consolidates the code a bit and makes it cleaner. Functionally it
> > is the same.
> > 
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree_nocb.h | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index d6e4c076b0515..213daf81c057f 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -327,10 +327,11 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
> >   *
> >   * Note that this function always returns true if rhp is NULL.
> >   */
> > -static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > +static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
> >  				     unsigned long j, bool lazy)
> >  {
> >  	struct rcu_cblist rcl;
> > +	struct rcu_head *rhp = rhp_in;
> 
> Why that intermediate rhp_in?

To avoid modifying the formal parameter, should the original value prove
useful, for example, for tracing or debugging.

> >  	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
> >  	rcu_lockdep_assert_cblist_protected(rdp);
> > @@ -345,16 +346,16 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  
> >  	/*
> >  	 * If the new CB requested was a lazy one, queue it onto the main
> > -	 * ->cblist so we can take advantage of a sooner grade period.
> > +	 * ->cblist so that we can take advantage of the grace-period that will
> > +	 * happen regardless. But queue it onto the bypass list first so that
> > +	 * the lazy CB is ordered with the existing CBs in the bypass list.
> >  	 */
> >  	if (lazy && rhp) {
> > -		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
> > -		rcu_cblist_enqueue(&rcl, rhp);
> > -		WRITE_ONCE(rdp->lazy_len, 0);
> > -	} else {
> > -		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > -		WRITE_ONCE(rdp->lazy_len, 0);
> > +		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> > +		rhp = NULL;
> >  	}
> > +	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > +	WRITE_ONCE(rdp->lazy_len, 0);
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul

> Thanks.
> 
> >  
> >  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
> >  	WRITE_ONCE(rdp->nocb_bypass_first, j);
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
