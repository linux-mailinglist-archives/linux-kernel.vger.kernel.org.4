Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C467E5EAEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIZR5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiIZR4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C499FA94;
        Mon, 26 Sep 2022 10:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCD0AB80AB0;
        Mon, 26 Sep 2022 17:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78607C433D6;
        Mon, 26 Sep 2022 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664213637;
        bh=gcTCr29MlAc0bR145T43S5F8g08IZsYaNY7uAKZu+S0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LE6ncc4mCBok/0bbtpvAkIaFJG8z+/IGraM2fjulAy8eTghEkqgSLXPVVTUVXRL7I
         1YkcXjDA4PgUzdfhWQaFnv8Tlmg6cWAg1uENDpRKVbEowWDoucMRuru0uKSSZHfFL3
         3Qyv32pniVI/E86uV7fNx7OUu+cIINkrGLE0qn2HmJaHew8BiGWP7779kB+Qn0tH5C
         au+8ecqpjgOvOFSApjwLxtxGd5QTRX5MUvoN5xoQhr8dRoPLYyzZzZSEcWZWHXm0KV
         HoK7tHVoLxg08sEoYKlM05t5U+S3S8ZKjtoBEG8CoteeGFd1DsiYsLWxg7fazCX4VY
         p9fOVqykCKXmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2201C5C05B1; Mon, 26 Sep 2022 10:33:57 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:33:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220926173357.GN4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <19217A4C-7183-4D78-A714-FBFE7BB20742@joelfernandes.org>
 <22F29015-5962-433D-8815-E4154B4897DD@joelfernandes.org>
 <20220925220045.GA182613@lothringen>
 <YzG/hoePbBumpaBV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzG/hoePbBumpaBV@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:04:38PM +0000, Joel Fernandes wrote:
> On Mon, Sep 26, 2022 at 12:00:45AM +0200, Frederic Weisbecker wrote:
> > On Sat, Sep 24, 2022 at 09:00:39PM -0400, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Sep 24, 2022, at 7:28 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > 
> > > > ﻿Hi Frederic, thanks for the response, replies
> > > > below courtesy fruit company’s device:
> > > > 
> > > >>> On Sep 24, 2022, at 6:46 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > > >>> 
> > > >>> ﻿On Thu, Sep 22, 2022 at 10:01:01PM +0000, Joel Fernandes (Google) wrote:
> > > >>> @@ -3902,7 +3939,11 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> > > >>>   rdp->barrier_head.func = rcu_barrier_callback;
> > > >>>   debug_rcu_head_queue(&rdp->barrier_head);
> > > >>>   rcu_nocb_lock(rdp);
> > > >>> -    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> > > >>> +    /*
> > > >>> +     * Flush the bypass list, but also wake up the GP thread as otherwise
> > > >>> +     * bypass/lazy CBs maynot be noticed, and can cause real long delays!
> > > >>> +     */
> > > >>> +    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_WAKE));
> > > >> 
> > > >> This fixes an issue that goes beyond lazy implementation. It should be done
> > > >> in a separate patch, handling rcu_segcblist_entrain() as well, with "Fixes: " tag.
> > > > 
> > > > I wanted to do that, however on discussion with
> > > > Paul I thought of making this optimization only for
> > > > all lazy bypass CBs. That makes it directly related
> > > > this patch since the laziness notion is first
> > > > introduced here. On the other hand I could make
> > > > this change in a later patch since we are not
> > > > super bisectable anyway courtesy of the last
> > > > patch (which is not really an issue if the CONFIG
> > > > is kept off during someone’s bisection.
> > > 
> > > Or are we saying it’s worth doing the wake up for rcu barrier even for
> > > regular bypass CB? That’d save 2 jiffies on rcu barrier. If we agree it’s
> > > needed, then yes splitting the patch makes sense.
> > > 
> > > Please let me know your opinions, thanks,
> > > 
> > >  - Joel
> > 
> > Sure, I mean since we are fixing the buggy rcu_barrier_entrain() anyway, let's
> > just fix bypass as well. Such as in the following (untested):
> 
> Got it. This sounds good to me, and will simplify the code a bit more for sure.
> 
> I guess a question for Paul - are you Ok with rcu_barrier() causing wake ups
> if the bypass list has any non-lazy CBs as well? That should be OK, IMO.

In theory, I am OK with it.  In practice, you are the guys with the
hardware that can measure power consumption, not me!  ;-)

> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b39e97175a9e..a0df964abb0e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3834,6 +3834,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >  {
> >  	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
> >  	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
> > +	bool wake_nocb = false;
> > +	bool was_alldone = false;
> >  
> >  	lockdep_assert_held(&rcu_state.barrier_lock);
> >  	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
> > @@ -3842,6 +3844,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >  	rdp->barrier_head.func = rcu_barrier_callback;
> >  	debug_rcu_head_queue(&rdp->barrier_head);
> >  	rcu_nocb_lock(rdp);
> > +	if (rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist))
> > +		was_alldone = true;
> >  	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> >  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
> >  		atomic_inc(&rcu_state.barrier_cpu_count);
> > @@ -3849,7 +3853,12 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> >  		debug_rcu_head_unqueue(&rdp->barrier_head);
> >  		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
> >  	}
> > +	if (was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist))
> > +		wake_nocb = true;
> >  	rcu_nocb_unlock(rdp);
> > +	if (wake_nocb)
> > +		wake_nocb_gp(rdp, false);
> > +
> 
> Thanks for the code snippet, I like how you are checking if the bypass list
> is empty, without actually checking it ;-)

That certainly is consistent with the RCU philosophy.  :-)

							Thanx, Paul
