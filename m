Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF25766A3DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjAMUHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjAMUHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:07:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B844551F9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:07:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A1094CE213C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 20:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FF5C433F0;
        Fri, 13 Jan 2023 20:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673640426;
        bh=tm60MhR2Yu73Egi7j3XIvH++TiMLajjoI0UVb1QTUQY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GYHe0e/j73QWRE85kmHzqwtYEC5q0b7EB2QwekFjCMe6oVrmekPJL/1dRH49TPP8I
         Szgg1ISPmq1LHDl7L/HnLqk1/YmXzdl+a2pDbQ1U5+BZO8TbrDKjmQSiYAxhQuzF4f
         ZvE2izqMhzWZfbxMCc5HGVcZ16qWSAlGofZupopRn66ANqECsyt1roNG0mZjb5EdTy
         YNzQeGCWwVvNVu6xanb2JZ8g8Hl65Syar1+OROK35/cOzytogPymSDYduxn82WcxPL
         uObE5AdOHsTnhWzol1qzvQeAIK5RVAj9Vcp5dnwaJRmLwZChgSNIoZYM8vlilYIvnt
         tUww6BqOl70cg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6B9065C06D0; Fri, 13 Jan 2023 12:07:06 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:07:06 -0800
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
Message-ID: <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GGmstFlgg91RMp@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:28:10AM -0500, Alan Stern wrote:
> Sorry for not replying earlier.  Yesterday was an extremely busy day,
> and while I was working on a reply late at night, a network outage led
> to all I had written getting lost.  :-(
> 
> Here's what I wanted to say, more or less.  (And I will also ignore the
> difference between gp and rcu-gp.)
> 
> On Thu, Jan 12, 2023 at 01:48:26PM +0000, Jonas Oberhauser wrote:
> > 
> > 
> > -----Original Message-----
> > From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> > Sent: Wednesday, January 11, 2023 4:06 PM
> > > Maybe we need a different word from "order".  Or maybe rcu-order should be renamed.
> > 
> > Alright, I've spent some time reading the rcu relations.
> > If I understand correctly, there are the -rscs relations which "parse" the balanced and nested lock-unlock critical sections (e.g., in L1  L2 U2 U1,  it links L1 to U1 and L2 to U2).
> > In those relations the equation
> > 	matched = matched | (unmatched-locks-to-unlocks \
> > 		(unmatched-po ; unmatched-po))
> > confused me for a second because it has multiple solutions, but I assume it should be read as producing the fixed point one gets by starting from the empty set and iteratively applying the map until one reaches a fixed point.
> 
> Yes; cat uses least-fixed-point definitions.
> 
> > Next, rcu-link is the normal hb/pb happens-before relation, enclosed by po; .. ; po?.
> 
> Here's how I think about rcu-link.  rcu-fence will end up functioning
> as kind of a super "cross-CPU" strong fence, so first consider the
> restrictions we already have on strong fences.  In particular,
> consider a cycle of the sort ruled out by the propagation axiom
> (I have expanded out the initial pb link):
> 
> 	A ->prop B ->strong-fence C ->hb* D ->pb* A
> 
> The part of the cycle running from C to B is:
> 
> 	C ->hb* D ->pb* A ->prop B
> 
> which is rcu-link aside from lacking the po? and po at the beginning
> and end.  Thus, it is easy to see that cycles of the form
> 
> 	(rcu-link ; strong-fence)+
> 
> are forbidden by the propagation axiom.  We will want similar cycles
> to be forbidden when the strong-fence is replaced by appropriate
> RCU-specific relations.  Hence the use of rcu-link to connect the
> RCU-specific items.
> 
> > Then rcu-order links rcu events (grace periods and read-side critical sections) in a kind of rcu happens-before order. The basic idea is that if a grace period happens before an unlock, it must also happen before the matching lock since otherwise the grace period would be fully spanned by the critical section; analogously, if a lock happens before the grace period, the matching unlock must also happen before the grace period.
> 
> IMO it's generally better to think of grace periods as not being
> instantaneous but as occurring over a prolonged period of time.  Thus
> we should say: If a grace period ends before an unlock occurs, it must
> start before the corresponding lock.  And contrapositively, if a lock
> occurs before a grace period starts, the corresponding unlock must
> occur before the grace period ends.

What Alan said!  You could even have distinct partially overlapping
grace periods, as the Linux kernel actually does have courtesy of normal
grace periods via synchronize_rcu() and expedited grace periods via
synchronize_rcu_expedited().

> There's a little more to it, because rcu-fence also has implications
> about stores propagating from one CPU to another in a particular
> order, just like strong-fence, but that's the basic idea.
> 
> > This is made tricky by the fact that there's a distinction between the hb/pb happens-before and the rcu happens-before relations.
> > As far as I understand, the current way to resolve this in LKMM is to count the number of critical sections and grace periods and analyzing that if the number of the latter is not less, then even nested and all kind of other weird cases will be ordered by applying this logic recursively when relying only on rcu-link (i.e., hb/pb happens-before).
> 
> We included a mathematical proof of this in the supplemental material
> to our ASPLOS paper.
> 
> > But if I look at it through a lense of a unified notion of happens-before (let's call it rcu-link'), I would think of a definition in the direction of
> >     idealized-rcu-order = rcu-rscs^-1 ; rcu-link' ; gp | gp ; rcu-link' ; rcu-rscs^-1
> > where rcu-order can itself contribute to rcu-link', in the sense that it extends any rcu-link
> >    rcu-link' = rcu-link | rcu-link' ; idealized-rcu-order 
> 
> Not quite; there needs to be another "; rcu-link'" at the end.
> 
> > After thinking about it for a while, I came up with the following (ignoring the srcu cases since I don't understand them yet):
> 
> SRCU is exactly like RCU except for one aspect: The SRCU primitives
> (synchronize_srcu(), srcu_lock(), and srcu_unlock()) each take an
> argument, a pointer to an srcu structure.  The ordering restrictions
> apply only in cases where the arguments to the corresponding
> primitives point to the _same_ srcu structure.  That's why you see all
> those "& loc" expressions sprinkled throughout the definitions of
> srcu-rscs and rcu-order.

In addition, the actual Linux-kernel SRCU has srcu_read_lock() return a
value that must be passed to srcu_read_unlock().  This means that SRCU
can have distinct overlapping SRCU read-side critical sections within
the confines of a given process.

Worse yet, the upcoming addition of srcu_down_read() and srcu_up_read()
means that a given SRCU read-side critical section might begin on one
process and end on another.  Thus srcu_down_read() is to srcu_read_lock()
as down_sema() is to mutex_lock(), more or less.

Making LKMM correctly model all of this has been on my todo list for an
embarrassingly long time.

> >   let rec rcu-extend = rcu-rscs^-1 ; rcu-link' ; gp | gp ; rcu-link' ; rcu-rscs^-1 | gp
> >    	and rcu-link' = rcu-link ; (rcu-extend ; rcu-link)*
> > which I think satisfies
> >    rcu-extend <= rcu-order   (use the helpful lemma rcu-order ; (rcu-link ; rcu-order)* <= rcu-order)
> >    rcu-order = rcu-extend ; (rcu-link ; rcu-extend)*
> > (I've attached my proof sketch, but I'm not sure it's readable.)
> 
> Yes, this is a more succinct way of expressing the same definition, by
> factoring out a common sub-relation and then performing simultaneous
> recursion on two relations rather than one.
> 
> > If this is true, defining rcu-order like this cuts away roughly half of the cases (ignoring srcu, rcu-order has 6 cases and rcu-extend has 3),
> 
> The definition of rcu-link' should count as a case, so you have only
> eliminated one-third of the cases.  :-)
> 
> >  and I believe makes the argument for why the relation works much clearer: It's essentially just the argument from above, that a grace period can't happen between a lock and unlock and thus if something happens before a grace period that happens before an unlock, it must also happen before the lock, and analogously if something happens after a grace period that happens after a lock, it must also happen after the unlock. 
> > In a sense I suppose that by splitting the recursion over two relations, the argument becomes disentangled into two simple arguments: firstly, rcu-link' can just be thought of as a kind of happens-before that is used to define rcu-extend, and secondly, rcu-extend can be used to extend rcu-link's happens-before. 
> 
> Clarity is in the eye of the beholder.  But I agree your definition is
> shorter and easier to read, although perhaps grasping its full
> implications is a little harder.
> 
> > The only thing that bothers me about it is the gp. It looks quite foreign here and besides, gp is already a strong fence and implies happens-before in its own right.
> 
> The lone gp is present in the definition of rcu-order because I wanted
> to express explicitly the condition that the number of grace periods
> in a cycle must be _at least_ as large as the number of critical
> sections.  There can be more grace periods, meaning that some of them
> need not be paired with a critical section.
> 
> However, it's true that (rcu-link ; gp ; rcu-link) is a sub-relation
> of rcu-link.  Hence the only need for a lone gp in these definitions
> is to cover the case where there are no critical sections at all in
> the cycle (which I would like be to be forbidden by the rcu axiom,
> even if it's already forbidden by the propagation axiom).
> 
> > So to clarify, I'm thinking something in the direction of 
> > 	rcu-extend = rcu-rscs^-1 ; rcu-link' ; gp | gp ; rcu-link' ; rcu-rscs^-1    (* no gp! *)
> > 	(* recursion like before... (omitted) *)
> > 	rb = prop ; rcu-extend ; ...
> > and relying on the hb-ordering provided by lonely po;gp;po? to give the ordering ostensibly lost by not including the full rcu-order relation here.
> > And then drop the old rcu-order and rename rcu-extend into rcu-order.
> > But I haven't had time to think about this direction deeply yet.
> > 
> > Let me know if I'm on the right track towards understanding rcu-order.
> 
> I think you are.
> 
> Alan
> 
> PS: I have no idea why the mailing list isn't accepting your emails.

The gmail service also doesn't like them.  I forgot to look at the reason
this time, but last time it was that gmail couldn't prove to itself that
your email really came from huawei.com.

You are not the only one.  So much so that I keep a browser window
open to my gmail spam folder at all times.  :-/

							Thaxn, Paul
