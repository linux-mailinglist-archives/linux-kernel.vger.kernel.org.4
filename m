Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E95EAF03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIZSED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiIZSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:03:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB82207;
        Mon, 26 Sep 2022 10:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81CCEB80B9C;
        Mon, 26 Sep 2022 17:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0972BC433D6;
        Mon, 26 Sep 2022 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664214326;
        bh=Bn1HSf7II+l0C0Thc4GW4IZtTClrYEYo9ov431I8puA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HfX/APbfw1n0RbnqwlbUysPcsqzAaX6+uKWg4yCqy2VHR1bSrldnKgonuy5nXVJr1
         qVouHIH5whFMsZ32r/UbCs+YDpQ8OgMcC64jZJucGOAFQTW4i/QZGgHNzF5poL8Wk7
         01WVl8VCqeAxBFuAnqGhlwmrJOBmDccU42uduJZIBQ7exf4mi5Ly3iitQ5iMcLuYuk
         ls7Qouv1H8sQtAWfUzrWyHZdR8vTUmNLD4kGoDPCiCmsOxxZAR+JvWgRyuINKDDp0m
         m81doRUwQ3BbFz/t2neGoyzp48G6QzDWDkeFL6PQVpW9tFz/eoGx8PeShXw7OeM5TY
         /xH2TIzrBjItA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F3F45C05B1; Mon, 26 Sep 2022 10:45:25 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:45:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220926174525.GP4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220924224637.GA161871@lothringen>
 <19217A4C-7183-4D78-A714-FBFE7BB20742@joelfernandes.org>
 <20220925220936.GA182999@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220925220936.GA182999@lothringen>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 12:09:36AM +0200, Frederic Weisbecker wrote:
> On Sat, Sep 24, 2022 at 07:28:16PM -0400, Joel Fernandes wrote:
> > > And then FLUSH_BP_WAKE is probably not needed anymore. 
> > 
> > It is needed as the API is in tree_nocb.h and we
> > have to have that handle the details of laziness
> > there rather than tree.c. We could add new apis
> > to get rid of flag but it’s cleaner (and Paul seemed
> > to be ok with it).
> 
> If the wake up is handled outside the flush function, as in the
> diff I just posted, there is no more user left of FLUSH_BP_WAKE, IIRC...

To get rid of FLUSH_BP_WAKE, we might need to pull some rcu_data fields
out from under #ifdef in order to allow them to be accessed by common
code.  Which might be a good tradeoff, as the size of rcu_data has not
been a concern.  Plus the increase in size would be quite small.

							Thanx, Paul

> > >> @@ -512,9 +598,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> > >>    }
> > >>    // Need to actually to a wakeup.
> > >>    len = rcu_segcblist_n_cbs(&rdp->cblist);
> > >> +    bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > >> +    lazy_len = READ_ONCE(rdp->lazy_len);
> > >>    if (was_alldone) {
> > >>        rdp->qlen_last_fqs_check = len;
> > >> -        if (!irqs_disabled_flags(flags)) {
> > >> +        // Only lazy CBs in bypass list
> > >> +        if (lazy_len && bypass_len == lazy_len) {
> > >> +            rcu_nocb_unlock_irqrestore(rdp, flags);
> > >> +            wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
> > >> +                       TPS("WakeLazy"));
> > > 
> > > I'm trying to think of a case where rcu_nocb_try_bypass() returns false
> > > (queue to regular list) but then call_rcu() -> __call_rcu_nocb_wake() ends up
> > > seeing a lazy bypass queue even though we are queueing a non-lazy callback
> > > (should have flushed in this case).
> > > 
> > > Looks like it shouldn't happen, even with concurrent (de-offloading) but just
> > > in case, can we add:
> > 
> > Yes I also feel this couldn’t happen because irq is
> > off and nocb lock is held throughout the calls to
> > the above 2 functions. Unless I missed the race
> > you’re describing?
> 
> At least I can't find any either...
> 
> > 
> > > 
> > >      WARN_ON_ONCE(lazy_len != len)
> > 
> > But this condition can be true even in normal
> > circumstances? len also contains DONE CBs
> > which are ready to be invoked. Or did I miss
> > something?
> 
> Duh, good point, nevermind then :-)
> 
> Thanks.
> 
> > 
> > Thanks,
> > 
> >   - Joel
> > 
> > > 
> > >> +        } else if (!irqs_disabled_flags(flags)) {
> > >>            /* ... if queue was empty ... */
> > >>            rcu_nocb_unlock_irqrestore(rdp, flags);
> > >>            wake_nocb_gp(rdp, false);
> > > 
> > > Thanks.
