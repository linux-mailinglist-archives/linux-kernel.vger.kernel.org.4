Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462F4672F73
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjASDR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjASDPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:15:33 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F036166FA2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:13:04 -0800 (PST)
Received: (qmail 234764 invoked by uid 1000); 18 Jan 2023 22:13:04 -0500
Date:   Wed, 18 Jan 2023 22:13:04 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, viktor@mpi-sws.org
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
 <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:38:11PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/18/2023 8:52 PM, Alan Stern wrote:
> > On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
> > > -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> > > -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> > > -		fencerel(After-unlock-lock) ; [M])
> > > +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
> > Shouldn't the po case of (co | po) remain intact here?
> 
> You can leave it here, but it is already covered by two other parts: the
> ordering given through ppo/hb is covered by the po-unlock-lock-po & int in
> ppo, and the ordering given through pb is covered by its inclusion in
> strong-order.

What about the ordering given through 
A-cumul(strong-fence)/cumul-fence/prop/hb?  I suppose that might be 
superseded by pb as well, but it seems odd not to have it in hb.

> Now whether it should be included in strong-order or not is a matter of
> grouping: is it better to leave all cases ordered by the [After-unlock-lock]
> fence together, or is it better to keep the <=po parts of the fences
> together and the external parts together?
> Right now I prefer to group things around the fences because that is more of
> an isolated idea, rather than around whether they order internally or
> externally.

In general, the idea in the memory model is that hb ordering relies on 
the non-strong properties of fences, whereas pb relies on the properties 
of strong fences, and rb relies on the properties of the RCU fences.

It's sort of a hierarchy.  In principle these relations should all be 
merged together (like xb does), but it turns out to work okay in 
practice because pb will absorb an hb on its right, and rb will absorb a 
pb on its right.  Besides, merging them all together would involve an 
uncomfortably large recursive definition.

> > > @@ -91,8 +89,12 @@ acyclic hb as happens-before
> > >   (* Write and fence propagation ordering *)
> > >   (****************************************)
> > > -(* Propagation: Each non-rf link needs a strong fence. *)
> > > -let pb = prop ; strong-fence ; hb* ; [Marked]
> > > +(* Strong ordering operations *)
> > > +let strong-order = strong-fence | ([M] ; po-unlock-lock-po ;
> > > +		[After-unlock-lock] ; po ; [M])
> > This is not the same as the definition removed above.  In particular,
> > po-unlock-lock-po only allows one step along the locking chain -- it has
> > rf where the definition above has co.
> 
> Indeed it is not, but the subsequent lock-unlock sequences are in hb*. For
> this reason it can be simplified to just consider the directly following
> unlock().

I'm not sure that argument is right.  The smp_mb__after_unlock_lock 
needs to go after the _last_ lock in the sequence, not after the first.  
So you don't have to worry about subsequent lock-unlock sequences; you 
have to worry about preceding lock-unlock sequences.

> > In fact, why don't we make a concerted effort to straighten out the
> > terminology more fully?  Now seems like a good time to do it.
> 
> I agree; wrapping my head around this terminology-space is the whole reason
> why I started looking into the formalization of rcu, and I'm beginning to
> understand it a little bit.
> 
> > To begin with, let's be more careful about the difference between an
> > order-inducing object (an event or pair of events) and the relation of
> > being ordered by such an object.  For instance, given:
> > 
> > 	A: WRITE_ONCE(x, 1);
> > 	B: smp_mb();
> > 	C: r1 = READ_ONCE(y);
> > 
> > then B is an order-inducing object (a memory barrier), and (A,C) is a
> > pair of events ordered by that object.  In general, an order is related
> > to an order-inducing object by:
> > 
> > 	order = po ; [order-inducing object] ; po
> 
> Yes! That's what I was trying to say in the rcu-order/rcu-fence discussion.
> (I would call it an operation rather than an object, since it may be
> something involving steps of multiple threads, like rcu, but let's stick
> with object for now).

Like I said above, the object could be a pair of events.  But 
"operation" is probably a better term.

> > with suitable modifications for things like smp_store_release where
> > one of the events being ordered _is_ the order-inducing event.
> > 
> > So for example, we could consistently refer to all order-inducing events
> > as either barriers or fences, and all order-reflecting relations as orders.  This would require widespread changes to the .cat file, but I
> > think it would be worthwhile.
> 
> I agree that having a uniform language for this is worthwhile.
> However you just dropped the cases of order-inducing objects that are not
> just a single event.

Let's agree to talk about order-inducing operations instead, and take

	{order-inducing operation}

to be the relation linking the start event of the operation to the end 
event.  So for operations that are a single object, such as a memory 
barrier, it is the same as [order-inducing object].  Then we have

	order = po ; {order-inducing operation} ; po

> I am completely fine calling the individual *events* barriers.
> (I don't like calling every barrier a fence though; Arm very explicitly
> doesn't do this and internally we don't either. However for LKMM I don't
> mind sticking to existing terminology here and calling them all fences; but
> to me a fence is something that orders certain things po-before the fence
> with certain things po-after).

Maybe we should also agree to reserve "barrier" for compiler barriers, 
and use "fence" for all memory barriers.  (Yes, I realize this isn't 
totally consistent but it's the best I can think of.)  Then all fence 
instructions would be barriers but not vice versa.

> But I would like to have a name for order-inducing objects that link two
> events.
> 
> I would call them an "ordering operation" where the first event is the event
> that "starts the operation", and the second event is the event that
> "completes that operation".
> 
> Then we can say things like "when CPU C starts an ordering operation of type
> blah that is completed by CPU C', then any store that propagates to C before
> C starts the operation must propagate to any CPU C'' before any store of C'
> that is executed after C' completes the execution propagates to C''  ".
> This would be a weak ordering operation, and would probably imply that
> blah-order is a kind of happens-before order and would appear in
> cumul-fence.
> 
> Or  "when CPU C starts an ordering operation of type blubb that is completed
> by CPU C', then any store that propagates to C before C starts the operation
> must propagate to any other CPU before any instruction of C' po-after C'
> completes the execution is executed".
> This would be a strong ordering operation which would imply that prop ;
> blubb-order is a kind of happens-before order.

Right.

> > (Treating "barrier" and "fence" as synonyms seems to be too deeply
> > entrenched to try and fight against.)
> > 
> > Once that is straightened out, we can distinguish between fences or
> > orders that are weak vs. strong.  And then we can divide up strong
> > fences/orders into single-CPU vs. cross-CPU, if we want to.
> With the distinction above, barriers and fences are always single-CPU, while
> ordering operations can be either cross-CPU or single-CPU. I'm not sure if
> there's still a need to distinguish more carefully than that.

We'll see.  But we need a shorter name than "ordering-operation" for use 
in the memory model.  How about "xfence"?  Or maybe use "xfence" for 
cross-CPU ordering operations, which are always strong -- I don't know 
what we should call multi-instruction single-CPU ordering operations  
(of which po-unlock-lock-po seems to be the only one).

Alan
