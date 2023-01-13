Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E13669E33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjAMQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAMQdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:33:15 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 938B455841
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:28:10 -0800 (PST)
Received: (qmail 25287 invoked by uid 1000); 13 Jan 2023 11:28:10 -0500
Date:   Fri, 13 Jan 2023 11:28:10 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
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
Message-ID: <Y8GGmstFlgg91RMp@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not replying earlier.  Yesterday was an extremely busy day,
and while I was working on a reply late at night, a network outage led
to all I had written getting lost.  :-(

Here's what I wanted to say, more or less.  (And I will also ignore the
difference between gp and rcu-gp.)

On Thu, Jan 12, 2023 at 01:48:26PM +0000, Jonas Oberhauser wrote:
> 
> 
> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> Sent: Wednesday, January 11, 2023 4:06 PM
> > Maybe we need a different word from "order".  Or maybe rcu-order should be renamed.
> 
> Alright, I've spent some time reading the rcu relations.
> If I understand correctly, there are the -rscs relations which "parse" the balanced and nested lock-unlock critical sections (e.g., in L1  L2 U2 U1,  it links L1 to U1 and L2 to U2).
> In those relations the equation
> 	matched = matched | (unmatched-locks-to-unlocks \
> 		(unmatched-po ; unmatched-po))
> confused me for a second because it has multiple solutions, but I assume it should be read as producing the fixed point one gets by starting from the empty set and iteratively applying the map until one reaches a fixed point.

Yes; cat uses least-fixed-point definitions.

> Next, rcu-link is the normal hb/pb happens-before relation, enclosed by po; .. ; po?.

Here's how I think about rcu-link.  rcu-fence will end up functioning
as kind of a super "cross-CPU" strong fence, so first consider the
restrictions we already have on strong fences.  In particular,
consider a cycle of the sort ruled out by the propagation axiom
(I have expanded out the initial pb link):

	A ->prop B ->strong-fence C ->hb* D ->pb* A

The part of the cycle running from C to B is:

	C ->hb* D ->pb* A ->prop B

which is rcu-link aside from lacking the po? and po at the beginning
and end.  Thus, it is easy to see that cycles of the form

	(rcu-link ; strong-fence)+

are forbidden by the propagation axiom.  We will want similar cycles
to be forbidden when the strong-fence is replaced by appropriate
RCU-specific relations.  Hence the use of rcu-link to connect the
RCU-specific items.

> Then rcu-order links rcu events (grace periods and read-side critical sections) in a kind of rcu happens-before order. The basic idea is that if a grace period happens before an unlock, it must also happen before the matching lock since otherwise the grace period would be fully spanned by the critical section; analogously, if a lock happens before the grace period, the matching unlock must also happen before the grace period.

IMO it's generally better to think of grace periods as not being
instantaneous but as occurring over a prolonged period of time.  Thus
we should say: If a grace period ends before an unlock occurs, it must
start before the corresponding lock.  And contrapositively, if a lock
occurs before a grace period starts, the corresponding unlock must
occur before the grace period ends.

There's a little more to it, because rcu-fence also has implications
about stores propagating from one CPU to another in a particular
order, just like strong-fence, but that's the basic idea.

> This is made tricky by the fact that there's a distinction between the hb/pb happens-before and the rcu happens-before relations.
> As far as I understand, the current way to resolve this in LKMM is to count the number of critical sections and grace periods and analyzing that if the number of the latter is not less, then even nested and all kind of other weird cases will be ordered by applying this logic recursively when relying only on rcu-link (i.e., hb/pb happens-before).

We included a mathematical proof of this in the supplemental material
to our ASPLOS paper.

> But if I look at it through a lense of a unified notion of happens-before (let's call it rcu-link'), I would think of a definition in the direction of
>     idealized-rcu-order = rcu-rscs^-1 ; rcu-link' ; gp | gp ; rcu-link' ; rcu-rscs^-1
> where rcu-order can itself contribute to rcu-link', in the sense that it extends any rcu-link
>    rcu-link' = rcu-link | rcu-link' ; idealized-rcu-order 

Not quite; there needs to be another "; rcu-link'" at the end.

> After thinking about it for a while, I came up with the following (ignoring the srcu cases since I don't understand them yet):

SRCU is exactly like RCU except for one aspect: The SRCU primitives
(synchronize_srcu(), srcu_lock(), and srcu_unlock()) each take an
argument, a pointer to an srcu structure.  The ordering restrictions
apply only in cases where the arguments to the corresponding
primitives point to the _same_ srcu structure.  That's why you see all
those "& loc" expressions sprinkled throughout the definitions of
srcu-rscs and rcu-order.

>   let rec rcu-extend = rcu-rscs^-1 ; rcu-link' ; gp | gp ; rcu-link' ; rcu-rscs^-1 | gp
>    	and rcu-link' = rcu-link ; (rcu-extend ; rcu-link)*
> which I think satisfies
>    rcu-extend <= rcu-order   (use the helpful lemma rcu-order ; (rcu-link ; rcu-order)* <= rcu-order)
>    rcu-order = rcu-extend ; (rcu-link ; rcu-extend)*
> (I've attached my proof sketch, but I'm not sure it's readable.)

Yes, this is a more succinct way of expressing the same definition, by
factoring out a common sub-relation and then performing simultaneous
recursion on two relations rather than one.

> If this is true, defining rcu-order like this cuts away roughly half of the cases (ignoring srcu, rcu-order has 6 cases and rcu-extend has 3),

The definition of rcu-link' should count as a case, so you have only
eliminated one-third of the cases.  :-)

>  and I believe makes the argument for why the relation works much clearer: It's essentially just the argument from above, that a grace period can't happen between a lock and unlock and thus if something happens before a grace period that happens before an unlock, it must also happen before the lock, and analogously if something happens after a grace period that happens after a lock, it must also happen after the unlock. 
> In a sense I suppose that by splitting the recursion over two relations, the argument becomes disentangled into two simple arguments: firstly, rcu-link' can just be thought of as a kind of happens-before that is used to define rcu-extend, and secondly, rcu-extend can be used to extend rcu-link's happens-before. 

Clarity is in the eye of the beholder.  But I agree your definition is
shorter and easier to read, although perhaps grasping its full
implications is a little harder.

> The only thing that bothers me about it is the gp. It looks quite foreign here and besides, gp is already a strong fence and implies happens-before in its own right.

The lone gp is present in the definition of rcu-order because I wanted
to express explicitly the condition that the number of grace periods
in a cycle must be _at least_ as large as the number of critical
sections.  There can be more grace periods, meaning that some of them
need not be paired with a critical section.

However, it's true that (rcu-link ; gp ; rcu-link) is a sub-relation
of rcu-link.  Hence the only need for a lone gp in these definitions
is to cover the case where there are no critical sections at all in
the cycle (which I would like be to be forbidden by the rcu axiom,
even if it's already forbidden by the propagation axiom).

> So to clarify, I'm thinking something in the direction of 
> 	rcu-extend = rcu-rscs^-1 ; rcu-link' ; gp | gp ; rcu-link' ; rcu-rscs^-1    (* no gp! *)
> 	(* recursion like before... (omitted) *)
> 	rb = prop ; rcu-extend ; ...
> and relying on the hb-ordering provided by lonely po;gp;po? to give the ordering ostensibly lost by not including the full rcu-order relation here.
> And then drop the old rcu-order and rename rcu-extend into rcu-order.
> But I haven't had time to think about this direction deeply yet.
> 
> Let me know if I'm on the right track towards understanding rcu-order.

I think you are.

Alan

PS: I have no idea why the mailing list isn't accepting your emails.
