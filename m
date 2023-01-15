Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132ED66AF78
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 06:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjAOFUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 00:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjAOFUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 00:20:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F50FB771
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 21:20:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C4A49CE0AE8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 05:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C2EC433D2;
        Sun, 15 Jan 2023 05:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673759998;
        bh=z7Q41GD2HKHS4y8oJmGwm7QmD4id1A5/bb/+x238MMo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q2gVzJMRt6DnhPgOZZds1vnNL4h5lpYRxBUr75VLP8VQ6NAOqGvTBD1f9Kza7HIst
         6zeughe+BmIhN2fltd0AbLjamilvLq0fB69NNxYFZ2fk2uS780dyee2VIEmwr54EBp
         sjX946s5lxoROQ22aUQZQ51JB8T1i7m0chUE+M/5w3X2KGFp3dPV9xKEUt2IEbsnbt
         T30TVSRpffkFL8Ng9l7rvcocBUuHM62HJKOq2rCxshteXTo2rJ+H42fLhHsMRr1kD/
         2V/tcAtqrC8GDt6sLxXEwUWE/ojIDaHMsqFcZBaXJmxcVdHEVi3/m9iQzck4E6dro2
         Dc5vt3eP0duOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 658495C1109; Sat, 14 Jan 2023 21:19:58 -0800 (PST)
Date:   Sat, 14 Jan 2023 21:19:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <20230115051958.GH2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
 <136d019d8c8049f6b737627df830e66f@huawei.com>
 <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
 <Y8MJZX/Png1zfYG0@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8MJZX/Png1zfYG0@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 02:58:29PM -0500, Alan Stern wrote:
> On Sat, Jan 14, 2023 at 10:15:37AM -0800, Paul E. McKenney wrote:
> > > > Perhaps the closest to what you want is to express that as a data dependency if you know how to teach herd that Srcu-unlock is a read and Srcu-lock depends on its second input :D (I have no idea how to do that, hence the questions above)
> > > 
> > > Given that both you and Alan suggested it, I must try it.  ;-)
> > 
> > And it works as desired on these litmus tests:
> > 
> > manual/kernel/C-srcu-nest-*.litmus
> > 
> > In this repository:
> > 
> > https://github.com/paulmckrcu/litmus
> > 
> > However, this has to be dumb luck because herd7 does not yet provide
> > the second argument to srcu_read_unlock().
> 
> Yes it does.  Grep for srcu_read_unlock in linux-kernel.def and you'll 
> see two arguments.

Right you are!  Too early this morning...

> >  My guess is that the herd7
> > is noting the dependency that is being carried by the pointers to the
> > srcu_struct structures.
> 
> That is not a dependency.

You are right, and apparently neither is the value returned by
srcu_read_lock() and passed to srcu_read_unlock().

> >  This guess stems in part from the fact that
> > I get "Flag unbalanced-srcu-locking" when I have one SRCU read-side
> > critical section following another in the same process, both using the
> > same srcu_struct structure.
> > 
> > Nevertheless, here is the resulting .bell fragment:
> > 
> > ------------------------------------------------------------------------
> > 
> > (* Compute matching pairs of Srcu-lock and Srcu-unlock *)
> > let srcu-rscs = ([Srcu-lock] ; data ; [Srcu-unlock]) & loc
> > 
> > (* Validate nesting *)
> > flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> > flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> > 
> > (* Check for use of synchronize_srcu() inside an RCU critical section *)
> > flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> > 
> > (* Validate SRCU dynamic match *)
> > flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> > 
> > ------------------------------------------------------------------------
> > 
> > I also created a C-srcu-nest-*.litmus as shown below, and LKMM does
> > complain about one srcu_read_lock() feeding into multiple instances of
> > srcu_read_unlock().
> 
> It shouldn't; that doesn't happen in the litmus test below.  But the 
> test does contain an srcu_read_lock() that doesn't match any instances 
> of srcu_read_unlock(), so you should be getting an 
> "unbalanced-srcu-locking" complaint -- and indeed, you mentioned above 
> that this does happen.
> 
> Also, your bell file doesn't contain a check for a lock matched with 
> multiple unlocks, so there's no way for herd to complain about it.

Agreed!

> >  The complaint comes from the different_values()
> > check, which presumably complains about any duplication in the domain
> > or range of the specified relation.
> 
> No; different_values() holds when the values of the two events 
> linked by srcu-rscs are different.  It has nothing to do with 
> duplication.

I removed the different_values() check and one of the complaints
went away, but yes, the other one did not.

> > But still working by accident!  ;-)
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > C C-srcu-nest-3
> > 
> > (*
> >  * Result: Flag srcu-bad-nesting
> >  *
> >  * This demonstrates erroneous matching of a single srcu_read_lock()
> >  * with multiple srcu_read_unlock() instances.
> >  *)
> > 
> > {}
> > 
> > P0(int *x, int *y, struct srcu_struct *s1, struct srcu_struct *s2)
> > {
> > 	int r1;
> > 	int r2;
> > 	int r3;
> > 	int r4;
> > 
> > 	r3 = srcu_read_lock(s1);
> > 	r2 = READ_ONCE(*y);
> > 	r4 = srcu_read_lock(s2);
> > 	r5 = srcu_read_lock(s2);
> > 	srcu_read_unlock(s1, r3);
> > 	r1 = READ_ONCE(*x);
> > 	srcu_read_unlock(s2, r4);
> > }
> 
> This has 3 locks and 2 unlocks.  The first lock matches the the first 
> unlock (r3 and s3), the second lock matches the second unlock (r4 and 
> s2), and the third lock doesn't match any unlock (r5 and s2).

Thank you and fixed.

							Thanx, Paul

> Alan
> 
> > 
> > P1(int *x, int *y, struct srcu_struct *s2)
> > {
> > 	WRITE_ONCE(*y, 1);
> > 	synchronize_srcu(s2);
> > 	WRITE_ONCE(*x, 1);
> > }
> > 
> > locations [0:r1]
> > exists (0:r1=1 /\ 0:r2=0)
