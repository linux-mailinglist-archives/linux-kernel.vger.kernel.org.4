Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09534678318
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjAWR2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjAWR2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:28:51 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 65E805B8A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:28:50 -0800 (PST)
Received: (qmail 133765 invoked by uid 1000); 23 Jan 2023 12:28:49 -0500
Date:   Mon, 23 Jan 2023 12:28:49 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>, paulmck@kernel.org,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, viktor@mpi-sws.org
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y87D0ekKCHFLjzeP@rowland.harvard.edu>
References: <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
 <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
 <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
 <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
 <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
 <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
 <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
 <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
 <41a14c54-8f17-d3ba-fc03-f9af4645881d@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41a14c54-8f17-d3ba-fc03-f9af4645881d@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 02:59:37PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/21/2023 9:56 PM, Alan Stern wrote:
> > There is yet another level of fences in the hierarchy: those which order
> > instruction execution but not propagation (smp_rmb() and acquire).  One
> > of the important points about cumul-fence is that it excludes this
> > level.
> > 
> > That's for a functional reason -- prop simply doesn't work for those
> > fences, so it has to exclude them.  But it does work for strong fences,
> > so excluding them would be an artificial restriction.
> 
> Hm, so could we say some fences order
> 1) propagation with propagation (weak fences)
> 2) execution with execution (rmb, acquire)
> 3) propagation with execution (strong fences)
> 
> where ordering with execution implicitly orders with propagation as well
> because things can only propagate after they execute.
> However, the 4th possibility (execution with only propagation) happens not
> to exist. I'm not sure if it would even be distinguishable from the second
> type.

Only in that such a memory barrier would order po-earlier anything 
against po-later stores, whereas rmb orders loads against loads and 
acquire orders loads against anything.

>  In the operational model, can you forward from stores that have not
> executed yet?

Yes, it is explicitly allowed.  But forwarding doesn't apply in this 
situation because stores can be forwarded only to po-later loads, not to 
po-earlier ones.

> > > Right now, both pb and cumul-fence deal with strong fences. And again, I
> > I would say that cumul-fence _allows_ strong fences, or _can work with_
> > strong fences.  And I would never want to say that cumul-fence and prop
> > can't be used with strong fences.  In fact, if you find a situation
> > where this happens, it might incline you to consider if the fence could
> > be replaced with a weaker one.
> 
> Can you explain the latter part?
> What does it mean to 'find a situation where this happens'?
> As I understand the sentence, in current LKMM I don't think this is
> possible.
> Do you mean that if you find a case where you could make a cycle with
> cumul-fence/prop using strong fences, you might just rely on a weaker fence
> instead?

Exactly.


> > Not quite right.  A hypothetical non-A-cumulative case for pb would have
> > to omit the cumul-fence term entirely.
> 
> Wouldn't that violate the transitivity of "X is required to propagate before
> Y" ?
> If I have
>    X ->cumul-fence+ Y ->weird-strong-fence Z
> doesn't that mean that for every CPU C,
> 1. X is required to propagate to C before Y propagates to C
> 2. Y is required to propagate to C before any instruction po-after Z 
> executes

Not if Y is a load.

> But then also X is required to pragate to C before any instruction po-after
> Z  executes.
> How is this enforced if there is no cumul-fence* in the new pb?

You do have a point.  I guess one would have to put

	(cumul-fence+ ; [W])?

or something like it in the definition.

> Thinking about prop and pb along these lines gives me a weird feeling.
> Trying to pinpoint it down, it seems a little bit weird that A-cumul doesn't
> appear around the strong-fence in pb.

I think the reason it got left out was because all strong fences are 
A-cumulative.  If some of them weren't, it would have to appear there in 
some form.

>  Of course it should not appear after
> prop which already has an rfe? at the end. Nevertheless, having the rfe? at
> the end is clearly important to representing the idea behind prop. If it
> weren't for the fact that A-cumul is needed to define prop, it almost makes
> me think that it would be nice to express the difference between
> A-cumulative and non-A-cumulative fences (that order propagation) by saying
> that an A-cumulative fence has
>   prop ; a-cumul-fence;rfe? <= prop
> while the non-A-cumulative fence has
>   prop-without-rfe ; non-a-cumul-fence <= prop-without-rfe

Isn't this just a more complicated way of saying what the A-cumul() 
macro expresses?


> I'm not against this partially overlapping kind of redundancy, but I dislike
> subsuming kind of redundancy where some branches of the logic just never
> need to be used.

Consider: Could we remove all propagation-ordering fences from ppo 
because they are subsumed by prop?  (Or is that just wrong?)

> > In fact, I wouldn't mind removing the happens-before, propagation, and
> > rcu axioms from LKMM entirely, replacing them with the single
> > executes-before axiom.
> 
> I was planning to propose the same thing, however, I would also propose to
> redefine hb and rb by dropping the hb/pb parts at the end of these
> relations.
> 
>  hb = ....
>  pb = prop ; strong-fence ; [Marked]
>  rb = prop ; rcu-fence ; [Marked]
> 
>  xb = hb|pb|rb
>  acyclic xb

I'm not so sure that's a good idea.  For instance, it would require the 
definitions of rcu-link and rb to be changed from having (hb* ; pb*) to 
having (hb | pb)*.  Also, although it's not mentioned anywhere, the 
definition of xbstar could be changed to hb* ; pb* ; rb* because each of 
these relations absorbs a weaker one to its right.

> > > I'm wondering a little if there's some way in the middle, e.g., by writting
> > > short comments in the model wherever something is redundant. Something like
> > > (* note: strong-fence is included here for completeness, and can be safely
> > > ignored *).
> > I have no objection to doing that.  It seems like a good idea.
> > 
> > Alan
> 
> Perhaps we can start a new thread then to discuss a few points where
> redundancies might be annotated this way or eliminated.

Sure, go ahead.

Alan
