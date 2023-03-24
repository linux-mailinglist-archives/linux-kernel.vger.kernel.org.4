Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E236C889C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCXWv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXWv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B51FCDD3;
        Fri, 24 Mar 2023 15:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4922162CED;
        Fri, 24 Mar 2023 22:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB808C433D2;
        Fri, 24 Mar 2023 22:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679698314;
        bh=sdb/K5BHHX0gmgFsv09SD96Vaxeu98JkCK4mrSm3bws=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jE2GzE6Y68DCXZtv53R5eXEZJrjsBOfjolyg307iF+5EymrzsuX1+ekEDf7PcQX68
         r9LzzqkDBaKXFkz3km6ZhrZI12Ce69ea7oFBi4lXq8M/X1ab/rWushXsrGOPcVO5zs
         kt51ggl8/AeE3kMasFgklr77frMnIgH0N/3L97XieBNel5+FhDaxkrq5YGsSlbz6HS
         PSQdCqItPPh/h8b6vvLTC1MhOASh1+v0XI+2ZH+YtAciI+CV7m74FBJ+Fg+BZzEdY7
         ZnUQWMZD6yvqRE9P/NU+uPLnBdS+GTcJLRLqJEVcya6bJSoVtJ8cbyiIduTBlURdOg
         bLRgSo3Uw2nNQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3ED931540432; Fri, 24 Mar 2023 15:51:54 -0700 (PDT)
Date:   Fri, 24 Mar 2023 15:51:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent
 (de-)offloading
Message-ID: <ae1cb391-aeed-4587-8d9d-50909c918fb1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230322194456.2331527-1-frederic@kernel.org>
 <20230322194456.2331527-2-frederic@kernel.org>
 <c614c542-f2b5-4b39-bbc4-ae5f0a125c81@paulmck-laptop>
 <ZB4fhA1BafN7h2N3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZB4fhA1BafN7h2N3@localhost.localdomain>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:09:08PM +0100, Frederic Weisbecker wrote:
> Le Wed, Mar 22, 2023 at 04:18:24PM -0700, Paul E. McKenney a écrit :
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
> Good point. It _should_ be fine but like you, Joel and Hillf pointed out
> it's asking for trouble.
> 
> We could try Joel's idea to use mutex_trylock() as a best effort, which
> should be fine as it's mostly uncontended.
> 
> The alternative is to force nocb locking and check the offloading state
> right after. So instead of:
> 
> 	rcu_nocb_lock_irqsave(rdp, flags);
> 	//flush stuff
> 	rcu_nocb_unlock_irqrestore(rdp, flags);
> 
> Have:
> 
> 	raw_spin_lock_irqsave(rdp->nocb_lock, flags);
> 	if (!rcu_rdp_is_offloaded(rdp))
> 		raw_spin_unlock_irqrestore(rdp->nocb_lock, flags);
> 		continue;
> 	}
> 	//flush stuff
> 	rcu_nocb_unlock_irqrestore(rdp, flags);
> 
> But it's not pretty and also disqualifies the last two patches as
> rcu_nocb_mask can't be iterated safely anymore.
> 
> What do you think?

The mutex_trylock() approach does have the advantage of simplicity,
and as you say should do well given low contention.

Which reminds me, what sort of test strategy did you have in mind?
Memory exhaustion can have surprising effects.

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
> > 
> > Or can it contain garbage after a de-offloading operation?
> 
> If it's deoffloaded, ->lazy_len is indeed (supposed to be) guaranteed to be zero.
> Bypass is flushed and disabled atomically early on de-offloading and the
> flush resets ->lazy_len.

Whew!  At the moment, I don't feel strongly about whether or not
the following code should (1) read the value, (2) warn on non-zero,
(3) assume zero without reading, or (4) some other option that is not
occurring to me.  Your choice!

							Thanx, Paul
