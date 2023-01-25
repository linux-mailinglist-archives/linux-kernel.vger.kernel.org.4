Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00467A909
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjAYC5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjAYC5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:57:30 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D6A712A9AC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 18:57:28 -0800 (PST)
Received: (qmail 193799 invoked by uid 1000); 24 Jan 2023 21:57:28 -0500
Date:   Tue, 24 Jan 2023 21:57:28 -0500
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
Message-ID: <Y9CamIsCmFkPYrwl@rowland.harvard.edu>
References: <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
 <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
 <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
 <41a14c54-8f17-d3ba-fc03-f9af4645881d@huaweicloud.com>
 <Y87D0ekKCHFLjzeP@rowland.harvard.edu>
 <8908438d-da93-b843-f0e0-831ba7070c86@huaweicloud.com>
 <Y873uBB5rAW8tjdd@rowland.harvard.edu>
 <1a189694-57b4-81d0-625a-64dd069b1953@huaweicloud.com>
 <Y9AR4Gr10SyCKovo@rowland.harvard.edu>
 <40447973-6f6b-86f7-1147-d8f20a943767@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40447973-6f6b-86f7-1147-d8f20a943767@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:23:02PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/24/2023 6:14 PM, Alan Stern wrote:
> > On Tue, Jan 24, 2023 at 02:14:03PM +0100, Jonas Oberhauser wrote:
> > > After mulling it over a bit in my big old head, I consider that even though
> > > dropping the [W] may be shorter, it might make for the simpler model by
> > > excluding lots of cases.
> > > That makes me think you should do it for real in the definition of prop. And
> > > not just at the very end, because in fact each cumul-fence link might come
> > > from a non-A-cumulative fence. So the same argument you are giving should be
> > > applied recursively.
> > > Either
> > > 
> > > 	prop = (overwrite & ext)? ; (cumul-fence; [W])* ; rfe?
> > > 
> > > or integrate it directly into cumul-fence.
> > I dislike this sort of argument.  I understand the formal memory model
> > by relating it to the informal operational model.  Thus, cumul-fence
> > links a write W to another event E when the fence guarantees that W will
> > propagate to E's CPU before E executes.
> 
> I later wondered why it's not defined like this and realized that prop means
> that it's before E executes.
> 
> > That's how the memory model
> > expresses the propagation properties of these fences.
> 
> I don't think that's really a perfect match though.
> For example, W ->wmb E (and thus cumul-fence) does guarantee that W
> propagates to E's CPU before E executes.
> But the propagation property of wmb is that W propagates to every CPU before
> E propagates to that CPU.
> It just so happens that the time E propagates to E's CPU is the time it
> executes.
> 
> Indeed, looking at the non-strong properties of fences only, should give
> rise to a relation that only says "W propagates to any CPU before E
> propagates to that CPU" and that is a relation between stores. And quite
> different from "W propagates to E's CPU before E executes".
> 
> I believe that relation is (cumul-fence;[W])+.

Add an rfe? to the end and you get the "before E executes" version.  Or 
more accurately (rfe? ; ppo*).  Hmmm, the only reason for omitting that 
ppo* term in the model is that it would never be needed.  So maybe we 
should after all do the same for the hb* term at the end of pb and the 
(hb* | pb*) part at the end of rb.


Starting from first principles, it's apparent that each of these types 
of propagation fences is associated with two relations: one involving 
propagation order and a companion relation involving execution order.

Here's what I mean.  For the sake of discussion let's define several 
classes of fences:

	efences are those which constrain execution order;

	pfences are those which constrain propagation order;

	sfences are those which strongly constrain propagation order.

Each class includes the following ones.  (And if you like, you can 
insert afences between pfences and sfences -- they would be the 
A-cumulative fences.)

Now, the memory model builds up successively more inclusive notions of 
execution order.  This process starts with execution of instructions in 
the same CPU not involving fences.  Thus we have the ppo relations: 
dependencies and a few oddball things like ((overwrite ; rfe) & int) or 
([UL] ; po ; [LKR]).

Next, the efences also restrict single-CPU execution order.  These 
fences only need to have one associated relation since they don't 
specifically involve propagation.  Adding rfe to the list gives us 
inter-CPU ordering.

Then associated with pfences we have the relation you've been talking 
about:

	W propagates to each CPU before W' does.

This is (cumul-fence ; [W]).  Perhaps a better name for it would be 
wprop.  Given this relation, we obtain a companion relation that 
restricts execution order:

	((overwrite & ext) ; wprop+ ; rfe) & int.

(Note that the overall form is the same for afences as for pfences.) 
Adding this companion relation into the mix gives us essentially hb.

For sfences the associated relation expresses:

	W propagates to every CPU before Y executes.

This is basically (wprop* ; rfe? ; sfence) (using the fact that all 
sfences are A-cumulative) -- or if you prefer, (wprop* ; cumul-sfence).  
We can call this sprop.  Then the companion relation restricting 
execution order is:

	(overwrite & ext) ; sprop

For RCU, the associated relation expressing t2(A) < t1(B) is rcu-order 
and the companion relation is rcu-fence.

Putting all those execution-order relations together gives us xb, the 
executes-before relation.  Then the only axiom we need for all of this 
that xb is acyclic.

Of course, I have left out a lot of details.  Still, how does that sound 
as a scheme for rationalizing the memory model?

Alan
