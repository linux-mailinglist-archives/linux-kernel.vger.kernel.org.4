Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D1C674349
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjASUGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjASUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:06:09 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0C74E9516C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:06:07 -0800 (PST)
Received: (qmail 262815 invoked by uid 1000); 19 Jan 2023 15:06:07 -0500
Date:   Thu, 19 Jan 2023 15:06:07 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, viktor@mpi-sws.org
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
 <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
 <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:05:38PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/19/2023 4:13 AM, Alan Stern wrote:
> > On Wed, Jan 18, 2023 at 10:38:11PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/18/2023 8:52 PM, Alan Stern wrote:
> > > > On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
> > > > > -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> > > > > -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> > > > > -		fencerel(After-unlock-lock) ; [M])
> > > > > +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
> > > > Shouldn't the po case of (co | po) remain intact here?
> > > You can leave it here, but it is already covered by two other parts: the
> > > ordering given through ppo/hb is covered by the po-unlock-lock-po & int in
> > > ppo, and the ordering given through pb is covered by its inclusion in
> > > strong-order.
> > What about the ordering given through
> > A-cumul(strong-fence)/cumul-fence/prop/hb?  I suppose that might be
> > superseded by pb as well,
> Indeed, in fact all of A-cumul(strong-fence) is already covered through pb.
> > but it seems odd not to have it in hb.
> > In general, the idea in the memory model is that hb ordering relies on
> > the non-strong properties of fences, whereas pb relies on the properties
> > of strong fences, and rb relies on the properties of the RCU fences.
> 
> I agree in the sense that all strong-ordering operations are A-cumulative
> and not including them in A-cumul is weird.

The reason for including A-cumul(strong-fence | po-rel) in the 
definition of cumul-fence had nothing to do with the fact that the 
fences needed to be strong.  It was simply a convenient way to list 
all the A-cumulative fences.  It could just as well have been written 
A-cumul(mb | gp | po-rel).

> On the other side  the model becomes a tiny bit smaller and simpler when all
> ordering of prop;strong-ordering goes through a single place (pb).
> 
> If you want, you could think of the A-cumulativity of strong ordering
> operations as being a consequence of their strong properties. Mathematically

That's backward logic.  Being strong isn't the reason the fences are 
A-cumulative.  Indeed, the model could have been written not to assume 
that strong fences are A-cumulative.

> it already is the case, since
>   overwrite&ext ; cumul-fence* ; rfe ; strong-fence ; cumul-fence* ; rfe?
> is a subset of
>   prop ; strong-fence ; hb*

Invalid reasoning.  If strong fences had not been A-cumulative then this 
inclusion wouldn't matter, because the pb relation would have been 
defined differently.


> > > > > @@ -91,8 +89,12 @@ acyclic hb as happens-before
> > > > >    (* Write and fence propagation ordering *)
> > > > >    (****************************************)
> > > > > -(* Propagation: Each non-rf link needs a strong fence. *)
> > > > > -let pb = prop ; strong-fence ; hb* ; [Marked]
> > > > > +(* Strong ordering operations *)
> > > > > +let strong-order = strong-fence | ([M] ; po-unlock-lock-po ;
> > > > > +		[After-unlock-lock] ; po ; [M])
> > > > This is not the same as the definition removed above.  In particular,
> > > > po-unlock-lock-po only allows one step along the locking chain -- it has
> > > > rf where the definition above has co.
> > > Indeed it is not, but the subsequent lock-unlock sequences are in hb*. For
> > > this reason it can be simplified to just consider the directly following
> > > unlock().
> > I'm not sure that argument is right.  The smp_mb__after_unlock_lock
> > needs to go after the _last_ lock in the sequence, not after the first.
> > So you don't have to worry about subsequent lock-unlock sequences; you
> > have to worry about preceding lock-unlock sequences.
> 
> I formalized a proof of equivalence in Coq a few months ago, but I was
> recalling the argument incorrectly from memory.
> I think the correct argument is that the previous po-unlock-lock-po form a
> cumul-fence*;rfe;po sequence that starts with a po-rel.
> so any
>     prop; .... ; co ; ... ; this fence ;...
> can be rewritten to
>     prop; cumul_fence* ; po-unlock-lock-po ; this fence ;...
> and because the the first cumul-fence here needs to start with po-release,
> the prop ;cumul-fence* can be merged into a larger prop, leaving
>     prop; po-unlock-lock-po ; this fence ;...

This may be so, but I would like to point out that the memory model was 
not particularly designed to be as short or as simple as possible, but 
more to reflect transparently the intuitions that kernel programmers 
have about the ways ordering should work in the kernel.  It may very 
well include redundancies as a result.  I don't think that's a bad 
point.

For example, the prop relation is meant to cover all fences that order 
store propagations in the usual way (basically all fences except rmb).  
This includes both weak and strong fences; the fact that strong fences 
also have other ordering properties doesn't mean they should be kept out 
of prop.

Alan
