Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1356C74DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCXBHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCXBHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C0412051;
        Thu, 23 Mar 2023 18:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8134628D1;
        Fri, 24 Mar 2023 01:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2DEC433D2;
        Fri, 24 Mar 2023 01:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679620018;
        bh=4N7NbSy+DaFdt9Jg48zJv1+Dm8Zg1MoaSBsjcm2DD9E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uh8NafDEcWfzZE0sJTgjRKmD6zIGGWUFO2r13Tk7UMJTmQ8D5pl8N2wMmRmJ7CnJS
         gFBQhgsvLbEm7/iRP69YWZCVsxFS+w/otMUml5e6d5F1QcfwMcvz/CEsZ6A0WZAS9K
         IHiQ3bnJIASS6IqLySHabq4Jmu9KMOIEQHYczDbfC+byWEkaqJ0IfN3HssarrhgSej
         yioq2gxrwpAHS62aOJ0oOS2SzszKnSC1bBGB/1dpXP3s5cvnxDIzd7uaCUhbD3kHQ3
         bVSJjpovlIq67e+Y1QnYJSF43znIinVb35F7AYDglVv5CGKiYABGJStj06xsXFAz3o
         y/o15kwMDLjTg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A74C21540379; Thu, 23 Mar 2023 18:06:57 -0700 (PDT)
Date:   Thu, 23 Mar 2023 18:06:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent
 (de-)offloading
Message-ID: <b9804cee-b50a-48a5-ae44-06f755eb4998@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230322194456.2331527-1-frederic@kernel.org>
 <20230322194456.2331527-2-frederic@kernel.org>
 <c614c542-f2b5-4b39-bbc4-ae5f0a125c81@paulmck-laptop>
 <20230324005523.GB723582@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324005523.GB723582@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 12:55:23AM +0000, Joel Fernandes wrote:
> On Wed, Mar 22, 2023 at 04:18:24PM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 22, 2023 at 08:44:53PM +0100, Frederic Weisbecker wrote:
> > > The shrinker may run concurrently with callbacks (de-)offloading. As
> > > such, calling rcu_nocb_lock() is very dangerous because it does a
> > > conditional locking. The worst outcome is that rcu_nocb_lock() doesn't
> > > lock but rcu_nocb_unlock() eventually unlocks, or the reverse, creating
> > > an imbalance.
> > > 
> > > Fix this with protecting against (de-)offloading using the barrier mutex.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Good catch!!!  A few questions, comments, and speculations below.
> 
> Added a few more. ;)
> 
> > > ---
> > >  kernel/rcu/tree_nocb.h | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index f2280616f9d5..dd9b655ae533 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -1336,13 +1336,25 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > >  	unsigned long flags;
> > >  	unsigned long count = 0;
> > >  
> > > +	/*
> > > +	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
> > > +	 * may be ignored or imbalanced.
> > > +	 */
> > > +	mutex_lock(&rcu_state.barrier_mutex);
> > 
> > I was worried about this possibly leading to out-of-memory deadlock,
> > but if I recall correctly, the (de-)offloading process never allocates
> > memory, so this should be OK?
> 
> Maybe trylock is better then? If we can't make progress, may be better to let
> kswapd free memory by other means than blocking on the mutex.
> 
> ISTR, from my Android days that there are weird lockdep issues that happen
> when locking in a shrinker (due to the 'fake lock' dependency added during
> reclaim).

This stuff gets tricky quickly.  ;-)

> > The other concern was that the (de-)offloading operation might take a
> > long time, but the usual cause for that is huge numbers of callbacks,
> > in which case letting them free their memory is not necessarily a bad
> > strategy.
> > 
> > > +
> > >  	/* Snapshot count of all CPUs */
> > >  	for_each_possible_cpu(cpu) {
> > >  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > > -		int _count = READ_ONCE(rdp->lazy_len);
> > > +		int _count;
> > > +
> > > +		if (!rcu_rdp_is_offloaded(rdp))
> > > +			continue;
> > 
> > If the CPU is offloaded, isn't ->lazy_len guaranteed to be zero?
> 
> Did you mean de-offloaded? If it is offloaded, that means nocb is active so
> there could be lazy CBs queued. Or did I miss something?

You are quite right, offloaded for ->lazy_len to be zero.

							Thanx, Paul.

> thanks,
> 
>  - Joel
> 
> 
> > Or can it contain garbage after a de-offloading operation?
> > 
> > > +		_count = READ_ONCE(rdp->lazy_len);
> > >  
> > >  		if (_count == 0)
> > >  			continue;
> > > +
> > >  		rcu_nocb_lock_irqsave(rdp, flags);
> > >  		WRITE_ONCE(rdp->lazy_len, 0);
> > >  		rcu_nocb_unlock_irqrestore(rdp, flags);
> > > @@ -1352,6 +1364,9 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > >  		if (sc->nr_to_scan <= 0)
> > >  			break;
> > >  	}
> > > +
> > > +	mutex_unlock(&rcu_state.barrier_mutex);
> > > +
> > >  	return count ? count : SHRINK_STOP;
> > >  }
> > >  
> > > -- 
> > > 2.34.1
> > > 
