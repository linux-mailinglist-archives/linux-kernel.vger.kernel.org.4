Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6876B678940
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjAWVKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjAWVKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:10:18 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 34C3827D43
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:10:17 -0800 (PST)
Received: (qmail 141244 invoked by uid 1000); 23 Jan 2023 16:10:16 -0500
Date:   Mon, 23 Jan 2023 16:10:16 -0500
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
Message-ID: <Y873uBB5rAW8tjdd@rowland.harvard.edu>
References: <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
 <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
 <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
 <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
 <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
 <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
 <41a14c54-8f17-d3ba-fc03-f9af4645881d@huaweicloud.com>
 <Y87D0ekKCHFLjzeP@rowland.harvard.edu>
 <8908438d-da93-b843-f0e0-831ba7070c86@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8908438d-da93-b843-f0e0-831ba7070c86@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 08:33:42PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/23/2023 6:28 PM, Alan Stern wrote:
> The reason I was asking is because if forwarding was forbidden from
> non-executed stores, execute-to-prop frences could potentially have
> observably different behavior from comparable execute-to-execute cases. It's
> moot because it's not forbidden, but if you want to see the reasoning,
> consider a case like this:
> 
>   load from y ; execute-to-prop-fence ; store to x ; ... ; load from x
>   load from y ; execute-to-execute-fence ; store to x ; ... ; load from x
> 
> (where both fences only order load->store).
> In the first case, x could execute before the load from y and the load from
> x could already execute.
> In the second case, x couldn't execute before the load from y and so
> (assuming you couldn't forward from non-executed stores) x couldn't execute.
> As a result, the second type of fence would have ordered the loads but the
> first one wouldn't.

The prototype example demonstrating that store forwarding really happens 
looks like this:

	read y ; ctrl-dep ; write x ; read x ; addr-dep ; read z

where forwarding allows x and z to be read before y.

> > > > Not quite right.  A hypothetical non-A-cumulative case for pb would have
> > > > to omit the cumul-fence term entirely.
> > > Wouldn't that violate the transitivity of "X is required to propagate before
> > > Y" ?
> > > If I have
> > >     X ->cumul-fence+ Y ->weird-strong-fence Z
> > > doesn't that mean that for every CPU C,
> > > 1. X is required to propagate to C before Y propagates to C
> > > 2. Y is required to propagate to C before any instruction po-after Z
> > > executes
> > Not if Y is a load.
> > 
> > I guess one would have to put
> > 
> > 	(cumul-fence+ ; [W])?
> > 
> > or something like it in the definition.
> 
> I suppose it's true that Y being a load would be an exception, but that
> would only be if the cumul-fence+ sequence either ends in a strong-fence, or
> in po-unlock-lock-po.
> 
> We can ignore the first case (and the ordering would be provided anyways
> through pb at that point).
> For the po-unlock-lock-po, you can just take Y:=the LKW event of the unlock
> and repeat the argument.

And yet you complained about the reasoning needed to understand that 
(pb ; hb) <= pb!  Not to mention the brittleness of this argument; what 
if in the future cumul-fence gets another term ending in a load?

> So I don't think the [W] is necessary. (and if it was maybe it would also be
> necessary in the definition of prop/cumul-fence itself, to account for all
> the non-A-cumulative fences in there).
> 
> I think part of my weird feeling comes from this asymmetry between A-cumul()
> putting the rfe? to the left and prop putting the rfe? to the right. Or more
> precisely, that the latter is sometimes in anticipation of an A-cumulative
> fence (where the A-cumul would normally take it to the left of that fence)
> and sometimes just to express the idea of propagation, and that these are
> the same, which should somehow lead to a simpler definition but doesn't.

Well, consider that maybe they aren't the same.  :-)

The definition of prop is a little more complicated than one might 
expect, because the overwrite and cumul-fence parts are both optional.  
Leaving one or both of them out is valid, but it requires a little extra 
thought to see why.

> > > I'm not against this partially overlapping kind of redundancy, but I dislike
> > > subsuming kind of redundancy where some branches of the logic just never
> > > need to be used.
> > Consider: Could we remove all propagation-ordering fences from ppo
> > because they are subsumed by prop?  (Or is that just wrong?)
> 
> Surely not, since prop doesn't usually provide ordering by itself.

Sorry, I meant the prop-related non-ppo parts of hb and pb.

> > > > In fact, I wouldn't mind removing the happens-before, propagation, and
> > > > rcu axioms from LKMM entirely, replacing them with the single
> > > > executes-before axiom.
> > > I was planning to propose the same thing, however, I would also propose to
> > > redefine hb and rb by dropping the hb/pb parts at the end of these
> > > relations.
> > > 
> > >   hb = ....
> > >   pb = prop ; strong-fence ; [Marked]
> > >   rb = prop ; rcu-fence ; [Marked]
> > > 
> > >   xb = hb|pb|rb
> > >   acyclic xb
> > I'm not so sure that's a good idea.  For instance, it would require the
> > definitions of rcu-link and rb to be changed from having (hb* ; pb*) to
> > having (hb | pb)*.
> I think that's an improvement. It's obvious that (hb | pb)* is right and so
> is (pb | hb)*.
> For (hb* ; pb*), the first reaction is "why do all the hb edges need to be
> before the pb edges?", until one realizes that pb actually allows hb* at the
> end, so in a sense this is  hb* ; (pb ; hb*)*, and then one has to
> understand that this means that the prop;strong-fence edges can appear any
> number of times at arbitrary locations. It just seems like defining (pb |
> hb)* with extra steps.

This can be mentioned explicitly as a comment or in explanation.txt.

> The order of nesting seems to be also somewhat a matter of preference,
> perhaps in some weird alternative universe the LKMM says pb = (prop\id)&int
> | prop;strong-fence  and hb = (rfe | ppo);pb*. (Personally I think the
> current way is more reasonable than this one, but that might be because our
> preferences happen to align in this instance.)

You can't define hb that way, because the definition of hb appears 
before the definition of pb.  And it has to be this way, because hb is 
used in the definition of pb.

Alan
