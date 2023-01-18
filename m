Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3036728C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjARTwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjARTwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:52:16 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 54F7A58983
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:52:15 -0800 (PST)
Received: (qmail 221383 invoked by uid 1000); 18 Jan 2023 14:52:14 -0500
Date:   Wed, 18 Jan 2023 14:52:14 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
> As stated in the documentation and implied by its name, the ppo
> (preserved program order) relation is intended to link po-earlier
> to po-later instructions under certain conditions.  However, a
> corner case currently allows instructions to be linked by ppo that
> are not executed by the same thread, i.e., instructions are being
> linked that have no po relation.
> 
> This happens due to the mb/strong-fence relations, which (as one
> case) provide order when locks are passed between threads followed
> by an smp_mb__after_unlock_lock() fence.  This is illustrated in
> the following litmus test (as can be seen when using herd7 with
> `doshow ppo`):
> 
> P0(int *x, int *y)
> {
>     spin_lock(x);
>     spin_unlock(x);
> }
> 
> P1(int *x, int *y)
> {
>     spin_lock(x);
>     smp_mb__after_unlock_lock();
>     *y = 1;
> }
> 
> The ppo relation will link P0's spin_lock(x) and P1's *y=1,
> because P0 passes a lock to P1 which then uses this fence.
> 
> The patch makes ppo a subrelation of po by eliminating this
> possibility from mb and strong-fence, and instead introduces the
> notion of strong ordering operations, which are allowed to link
> events of distinct threads.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---

I'm just going to comment on the changes to the cat file.  I'll review 
the documentation changes later.

> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 07f884f9b2bf..1d91edbc10fe 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -36,9 +36,7 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>  	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> -		fencerel(After-unlock-lock) ; [M])
> +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])

Shouldn't the po case of (co | po) remain intact here?

>  let gp = po ; [Sync-rcu | Sync-srcu] ; po?
>  let strong-fence = mb | gp
>  
> @@ -91,8 +89,12 @@ acyclic hb as happens-before
>  (* Write and fence propagation ordering *)
>  (****************************************)
>  
> -(* Propagation: Each non-rf link needs a strong fence. *)
> -let pb = prop ; strong-fence ; hb* ; [Marked]
> +(* Strong ordering operations *)
> +let strong-order = strong-fence | ([M] ; po-unlock-lock-po ;
> +		[After-unlock-lock] ; po ; [M])

This is not the same as the definition removed above.  In particular, 
po-unlock-lock-po only allows one step along the locking chain -- it has 
rf where the definition above has co.

> +
> +(* Propagation: Each non-rf link needs a strong ordering operation. *)
> +let pb = prop ; strong-order ; hb* ; [Marked]
>  acyclic pb as propagation
>  
>  (*******)
> @@ -141,7 +143,7 @@ let rec rcu-order = rcu-gp | srcu-gp |
>  	(rcu-order ; rcu-link ; rcu-order)
>  let rcu-fence = po ; rcu-order ; po?
>  let fence = fence | rcu-fence

It would be nice here to have a separate term for a potentially 
cross-CPU fence.

In fact, why don't we make a concerted effort to straighten out the 
terminology more fully?  Now seems like a good time to do it.

To begin with, let's be more careful about the difference between an 
order-inducing object (an event or pair of events) and the relation of 
being ordered by such an object.  For instance, given:

	A: WRITE_ONCE(x, 1);
	B: smp_mb();
	C: r1 = READ_ONCE(y);

then B is an order-inducing object (a memory barrier), and (A,C) is a 
pair of events ordered by that object.  In general, an order is related 
to an order-inducing object by:

	order = po ; [order-inducing object] ; po

with suitable modifications for things like smp_store_release where 
one of the events being ordered _is_ the order-inducing event.

So for example, we could consistently refer to all order-inducing events 
as either barriers or fences, and all order-reflecting relations as 
orders.  This would require widespread changes to the .cat file, but I 
think it would be worthwhile.

(Treating "barrier" and "fence" as synonyms seems to be too deeply 
entrenched to try and fight against.)

Once that is straightened out, we can distinguish between fences or 
orders that are weak vs. strong.  And then we can divide up strong 
fences/orders into single-CPU vs. cross-CPU, if we want to.

How does that sound?

Alan

> -let strong-fence = strong-fence | rcu-fence
> +let strong-order = strong-order | rcu-fence
>  
>  (* rb orders instructions just as pb does *)
>  let rb = prop ; rcu-fence ; hb* ; pb* ; [Marked]
> @@ -169,7 +171,7 @@ flag ~empty mixed-accesses as mixed-accesses
>  (* Executes-before and visibility *)
>  let xbstar = (hb | pb | rb)*
>  let vis = cumul-fence* ; rfe? ; [Marked] ;
> -	((strong-fence ; [Marked] ; xbstar) | (xbstar & int))
> +	((strong-order ; [Marked] ; xbstar) | (xbstar & int))
>  
>  (* Boundaries for lifetimes of plain accesses *)
>  let w-pre-bounded = [Marked] ; (addr | fence)?
> @@ -180,9 +182,9 @@ let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
>  	[Marked]
>  
>  (* Visibility and executes-before for plain accesses *)
> -let ww-vis = fence | (strong-fence ; xbstar ; w-pre-bounded) |
> +let ww-vis = fence | (strong-order ; xbstar ; w-pre-bounded) |
>  	(w-post-bounded ; vis ; w-pre-bounded)
> -let wr-vis = fence | (strong-fence ; xbstar ; r-pre-bounded) |
> +let wr-vis = fence | (strong-order ; xbstar ; r-pre-bounded) |
>  	(w-post-bounded ; vis ; r-pre-bounded)
>  let rw-xbstar = fence | (r-post-bounded ; xbstar ; w-pre-bounded)
>  
> -- 
> 2.17.1
> 
