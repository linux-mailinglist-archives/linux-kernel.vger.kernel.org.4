Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7290867589E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjATPct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjATPcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:32:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56E1725
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:32:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC37861FA9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5703AC433EF;
        Fri, 20 Jan 2023 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674228763;
        bh=0XaUav4RueNVm96Ywl+Yh8XPQ+ZnAL0snvgSSziw1Sg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NS9RhnxdY2+K41whvY7LIUidI3DiDpqXfPnGrG50UuV/jdx0aWqiwFbJVc4ca3lci
         td/Z6KIMWnUTDGb6b9wmp0qrsFv6wv38oLIOnwl4+GFy/msrfuEtk/ymomDzDsSRHU
         bScz02TMnpdAjeP7vEayd8oPfTyJ0Uko5u9NiafvfwIV54dyr6a6Km33l78x14p7v7
         v/Fc1owt0K9wtZMufJwGPUNY6exa5oNUugs8KlK2ATRY21fIzlGdGt3fzsQF1NgWLO
         S1blgt9Kop6onqCJ7o8yWQwluA0XoVbEYLfbT268MjiiqbJQI6kqbV7hUK4INsBS1C
         bmXvlMXfNo3OQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E66635C0DFC; Fri, 20 Jan 2023 07:32:42 -0800 (PST)
Date:   Fri, 20 Jan 2023 07:32:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
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
Message-ID: <20230120153242.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230120035521.GA319650@paulmck-ThinkPad-P17-Gen-1>
 <126e32b7-caa7-0a1e-4589-885aef7c5a39@huaweicloud.com>
 <fbbd5a65-7f93-ba5e-d8a6-236d9af43c47@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbbd5a65-7f93-ba5e-d8a6-236d9af43c47@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:51:01PM +0100, Jonas Oberhauser wrote:
> I'm not going to get it right today, am I?

Believe me, I know that feeling!  Open-source development is therefore
an extremely good character-building exercise.  At least that is what
I keep telling myself.  ;-)

> +let srcu-rscs = ([Srcu-lock] ; (data ; [~ Srcu-unlock] ; rfe) * ; data ;
> [Srcu-unlock]) & loc
> 
> I see now that I copied the format from your message but without realizing
> the original had a `|` where I have a `;`.
> I hope this version is finally right and perhaps more natural than the (data
> | rf) version, considering rf can't actually appear in most places and this
> more closely matches carry-dep;data.
> But of course feel free to use
> +let srcu-rscs = ([Srcu-lock] ; (data  | [~ Srcu-unlock] ; rf)+ ;
> [Srcu-unlock]) & loc
> instead if you prefer.

Ah, herd7 could see an rf link between any srcu_read_unlock() and any
"later" srcu_read_lock(), couldn't it?  Good catch!!!

I took this last one, adding parentheses that might well be unnecessary.
(You see, herd7 was complaining about cut-and-paste, possibly due to
alternative character sets, so I indulged in a bit of diagnostic-driven
development.)

let srcu-rscs = ([Srcu-lock] ; (data | ([~ Srcu-unlock] ; rf))+ ;
[Srcu-unlock]) & loc

The reason for favoring "rf" over "rfe" is the possibility of a litmus
test where the process containing the srcu_down_read() sometimes but
not always also has the matching srcu_up_read().  Perhaps a pair of "if"
statements control which process does the matching srcu_up_read().

With this change, all of the C-srcu-nest-*.litmus tests act as expected.

And thank you!!!

							Thanx, Paul

> have fun, jonas
> 
> 
> On 1/20/2023 1:34 PM, Jonas Oberhauser wrote:
> > I just realized I made a mistake in my earlier response to this message;
> > you still need the rf for passing the cookie across threads.
> > Perhaps it's better to just also exclude srcu_unlock type events
> > explicitly here.
> > 
> > +let srcu-rscs = ([Srcu-lock] ; (data ; [~ Srcu-unlock] ; rf) + ;
> > [Srcu-unlock]) & loc
> > 
> > 
> > best wishes,
> > jonas
> > 
> > On 1/20/2023 4:55 AM, Paul E. McKenney wrote:
> > > On Thu, Jan 19, 2023 at 02:51:53PM -0500, Alan Stern wrote:
> > > > On Thu, Jan 19, 2023 at 10:41:07AM -0800, Paul E. McKenney wrote:
> > > > > In contrast, this actually needs srcu_down_read() and srcu_up_read():
> > > > > 
> > > > > ------------------------------------------------------------------------
> > > > > 
> > > > > 
> > > > > C C-srcu-nest-6
> > > > > 
> > > > > (*
> > > > >   * Result: Never
> > > > >   *
> > > > >   * Flag unbalanced-srcu-locking
> > > > >   * This would be valid for srcu_down_read() and srcu_up_read().
> > > > >   *)
> > > > > 
> > > > > {}
> > > > > 
> > > > > P0(int *x, int *y, struct srcu_struct *s1, int *idx)
> > > > > {
> > > > >     int r2;
> > > > >     int r3;
> > > > > 
> > > > >     r3 = srcu_down_read(s1);
> > > > >     WRITE_ONCE(*idx, r3);
> > > > >     r2 = READ_ONCE(*y);
> > > > > }
> > > > > 
> > > > > P1(int *x, int *y, struct srcu_struct *s1, int *idx)
> > > > > {
> > > > >     int r1;
> > > > >     int r3;
> > > > > 
> > > > >     r1 = READ_ONCE(*x);
> > > > >     r3 = READ_ONCE(*idx);
> > > > >     srcu_up_read(s1, r3);
> > > > > }
> > > > > 
> > > > > P2(int *x, int *y, struct srcu_struct *s1)
> > > > > {
> > > > >     WRITE_ONCE(*y, 1);
> > > > >     synchronize_srcu(s1);
> > > > >     WRITE_ONCE(*x, 1);
> > > > > }
> > > > > 
> > > > > locations [0:r1]
> > > > > exists (1:r1=1 /\ 0:r2=0)
> > > > I modified this litmus test by adding a flag variable with an
> > > > smp_store_release in P0, an smp_load_acquire in P1, and a filter clause
> > > > to ensure that P1 reads the flag and idx from P1.
> > > > 
> > > > With the patch below, the results were as expected:
> > > > 
> > > > Test C-srcu-nest-6 Allowed
> > > > States 3
> > > > 0:r1=0; 0:r2=0; 1:r1=0;
> > > > 0:r1=0; 0:r2=1; 1:r1=0;
> > > > 0:r1=0; 0:r2=1; 1:r1=1;
> > > > No
> > > > Witnesses
> > > > Positive: 0 Negative: 3
> > > > Condition exists (1:r1=1 /\ 0:r2=0)
> > > > Observation C-srcu-nest-6 Never 0 3
> > > > Time C-srcu-nest-6 0.04
> > > > Hash=2b010cf3446879fb84752a6016ff88c5
> > > > 
> > > > It turns out that the idea of removing rf edges from Srcu-unlock events
> > > > doesn't work well.  The missing edges mess up herd's calculation of the
> > > > fr relation and the coherence axiom.  So I've gone back to filtering
> > > > those edges out of carry-dep.
> > > > 
> > > > Also, Boqun's suggestion for flagging ordinary accesses to SRCU
> > > > structures no longer works, because the lock and unlock operations now
> > > > _are_ normal accesses.  I removed that check too, but it shouldn't hurt
> > > > much because I don't expect to encounter litmus tests that try to read
> > > > or write srcu_structs directly.
> > > > 
> > > > Alan
> > > > 
> > > > 
> > > > 
> > > > Index: usb-devel/tools/memory-model/linux-kernel.bell
> > > > ===================================================================
> > > > --- usb-devel.orig/tools/memory-model/linux-kernel.bell
> > > > +++ usb-devel/tools/memory-model/linux-kernel.bell
> > > > @@ -53,38 +53,30 @@ let rcu-rscs = let rec
> > > >       in matched
> > > >     (* Validate nesting *)
> > > > -flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
> > > > -flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
> > > > +flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-lock
> > > > +flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-unlock
> > > >     (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> > > > -let srcu-rscs = let rec
> > > > -        unmatched-locks = Srcu-lock \ domain(matched)
> > > > -    and unmatched-unlocks = Srcu-unlock \ range(matched)
> > > > -    and unmatched = unmatched-locks | unmatched-unlocks
> > > > -    and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
> > > > -    and unmatched-locks-to-unlocks =
> > > > -        ([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
> > > > -    and matched = matched | (unmatched-locks-to-unlocks \
> > > > -        (unmatched-po ; unmatched-po))
> > > > -    in matched
> > > > +let srcu-rscs = ([Srcu-lock] ; (data | rf)+ ; [Srcu-unlock]) & loc
> > > >     (* Validate nesting *)
> > > > -flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> > > > -flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> > > > +flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-lock
> > > > +flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-unlock
> > > > +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
> > > >     (* Check for use of synchronize_srcu() inside an RCU
> > > > critical section *)
> > > >   flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> > > >     (* Validate SRCU dynamic match *)
> > > > -flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> > > > +flag ~empty different-values(srcu-rscs) as bad-srcu-value-match
> > > >     (* Compute marked and plain memory accesses *)
> > > >   let Marked = (~M) | IW | Once | Release | Acquire |
> > > > domain(rmw) | range(rmw) |
> > > > -        LKR | LKW | UL | LF | RL | RU
> > > > +         LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
> > > >   let Plain = M \ Marked
> > > >     (* Redefine dependencies to include those carried through
> > > > plain accesses *)
> > > > -let carry-dep = (data ; rfi)*
> > > > +let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
> > > >   let addr = carry-dep ; addr
> > > >   let ctrl = carry-dep ; ctrl
> > > >   let data = carry-dep ; data
> > > > Index: usb-devel/tools/memory-model/linux-kernel.def
> > > > ===================================================================
> > > > --- usb-devel.orig/tools/memory-model/linux-kernel.def
> > > > +++ usb-devel/tools/memory-model/linux-kernel.def
> > > > @@ -49,8 +49,10 @@ synchronize_rcu() { __fence{sync-rcu}; }
> > > >   synchronize_rcu_expedited() { __fence{sync-rcu}; }
> > > >     // SRCU
> > > > -srcu_read_lock(X)  __srcu{srcu-lock}(X)
> > > > -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> > > > +srcu_read_lock(X) __load{srcu-lock}(*X)
> > > > +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
> > > > +srcu_down_read(X) __load{srcu-lock}(*X)
> > > > +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
> > > >   synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> > > >   synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
> > > And for some initial tests:
> > > 
> > > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-1.litmus
> > > 
> > > 
> > >     "Flag multiple-srcu-matches" but otherwise OK.
> > >     As a "hail Mary" exercise, I used r4 for the second SRCU
> > >     read-side critical section, but this had no effect.
> > >     (This flag is expected and seen for #4 below.)
> > > 
> > > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-2.litmus
> > > 
> > > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-3.litmus
> > > 
> > > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-4.litmus
> > > 
> > > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-5.litmus
> > > 
> > > 
> > >     All as expected.
> > > 
> > > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-6.litmus
> > > 
> > > 
> > >     Get "Flag unbalanced-srcu-lock" and "Flag unbalanced-srcu-unlock",
> > >     but this is srcu_down_read() and srcu_up_read(), where this should
> > >     be OK.    Ah, but I need to do the release/acquire/filter
> > > trick.  Once
> > >     I did that, it works as expected.
> > > 
> > > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-7.litmus
> > > 
> > > https://github.com/paulmckrcu/litmus/blob/master/manual/kernel/C-srcu-nest-8.litmus
> > > 
> > > 
> > >     Both as expected.
> > > 
> > > Getting there!!!
> > > 
> > > I also started a regression test, hopefully without pilot error.  :-/
> > > 
> > >                             Thanx, Paul
> > 
> 
