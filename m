Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1FC676979
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjAUU4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjAUU43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:56:29 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D8AEA1BACF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 12:56:27 -0800 (PST)
Received: (qmail 77051 invoked by uid 1000); 21 Jan 2023 15:56:27 -0500
Date:   Sat, 21 Jan 2023 15:56:27 -0500
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
Message-ID: <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
 <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
 <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
 <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
 <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
 <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
 <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 01:41:16AM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/20/2023 5:32 PM, Alan Stern wrote:
> > On Fri, Jan 20, 2023 at 12:12:50PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/19/2023 9:06 PM, Alan Stern wrote:
> > > > That's backward logic.  Being strong isn't the reason the fences are
> > > > A-cumulative.  Indeed, the model could have been written not to assume
> > > > that strong fences are A-cumulative.
> > > It's not just the model, it's also how strong fences are introduced in the
> > > documentation.
> > The documentation can be updated.
> 
> Sure. But what would be the benefit?

Aren't you interested in making the memory model more understandable to 
students?  See also the end of this email (comments count somewhat as 
documentation).

> Anyways, what I meant is something else.
> There are (at least) two interpretations of what a strong-fence is.
> The first that you have in mind as far as I understand, that every store
> affected by the strong-fence must propagate to every other CPU before any
> instruction behind the strong-fence executes. (but it doesn't talk about
> which stores are being affected).

Yes, that's what I have in mind.

> The second one is that a strong-fence is an A-cumulative fence which
> additionally has that guarantee.
> 
> What I meant is that reading the documentation or the model, one might come
> to the conclusion that it means the second thing, and in that interpretation
> fences that are strong must be A-cumulative.

Okay, so let's change the documentation/model to ensure this doesn't 
happen.

> I don't see anything wrong with that, especially since I don't think
> strong-fence is a standard term that exists in a vacuum and means the first
> thing by convention.
> 
> Obviously there's some elegance in making things orthogonal rather than
> hierarchical.
> So I can understand why you defend the first interpretation.
> But there's really only a benefit if that opens up some interesting design
> space. I just don't see that right now.
> 
> So if hypothetically you were ok to change the meaning of strong fence to
> include A-cumulativity -- and I think from the model and documentation
> perspective it doesn't take much to do that if anything -- then saying "all
> strong-fence properties are covered exactly in pb" isn't a big step.

I believe that the difference between strong and weak fences is much 
more fundamental and important than the difference between A-cumulative 
and non-A-cumulative fences.

Consider an analogy: Some animals are capable of walking around, but no 
plants are.  Would you ever want to say that a plant is a non-walking 
living thing with various properties that differentiate it from animals?  
Or does it make more sense to say that plants are living things with 
various fundamental properties, and in addition some animals can walk?

> > > I agree though that you could decouple the notion of strong from
> > > A-cumulativity.
> > > But would anyone want a strong fence that is not A-cumulative?
> > Why would anyone want a weak fence that isn't A-cumulative?  :-)
> > Architecture designers sometimes do strange things...
> 
> (as a side note and out of curiosity: Which architecture has a weak fence
> that isn't A-cumulative? Is it alpha?)

I believe that's right.  It still exists in the kernel as smp_wmb().

> As for strong fences that aren't A-cumulative, I remember someone telling me
> not too long ago that one shouldn't worry about strange hypothetical
> architectures ; )
> More to the point, I find it improbable that the performance benefit of this
> vs just using however smp_mb() maps on that architecture would ever warrant
> the inclusion of such a fence in the LKMM.

Agreed; I can't imagine any good reason for having a non-A-cumulative 
strong fence either.  But it doesn't matter; when learning or using the 
LKMM it's much more important to focus on strong vs. weak than on 
A-cumulative vs. non-A-cumulative.

> > > It's a bit like asking in C11 for a barrier that has the sequential
> > > consistency guarantee of appearing in the global order S, but doesn't have
> > > release or acquire semantics. Yes you could define that, but would it really
> > > make sense?
> > You're still missing the point.  The important aspect of the fences in
> > cumul-fence is that they are A-cumulative, not whether they are strong.
> 
> I completely understand that. I just don't think there's anything
> fundamentally wrong with alternatively creating a more disjoint hierarchy of
> - fences that aren't A-cumulative but order propagation (in cumul-fence,
> without A-cumul)
> - fences that are A-cumulative but aren't strong (in cumul-fence, with
> A-cumul)
> - fences that are strong (in pb)

There is yet another level of fences in the hierarchy: those which order 
instruction execution but not propagation (smp_rmb() and acquire).  One 
of the important points about cumul-fence is that it excludes this 
level.

That's for a functional reason -- prop simply doesn't work for those 
fences, so it has to exclude them.  But it does work for strong fences, 
so excluding them would be an artificial restriction.

> Right now, both pb and cumul-fence deal with strong fences. And again, I

I would say that cumul-fence _allows_ strong fences, or _can work with_ 
strong fences.  And I would never want to say that cumul-fence and prop 
can't be used with strong fences.  In fact, if you find a situation 
where this happens, it might incline you to consider if the fence could 
be replaced with a weaker one.

> understand that one point of view here is that this is not because strong
> fences need to inherently be A-cumulative and included in cumul-fence by
> using the strong-fence identifier.
> Indeed one could have, in theory, strong fences that aren't A-cumulative,
> and using strong-fence is as you wrote just a convenient way to list all the
> A-cumulative strong fences because that currently happens to be all of the
> strong fences.
> 
> Another POV is that one might instead formally describe things in terms of
> these three more disjoint classes, adapt the documentation of cumul-fence to
> say that it does not deal with strong fences because those are dealt with in
> a later relation, and not worry about hypothetical barriers that currently
> don't have a justifying use case.
> (And I suppose to some extent you already don't worry about it, because pb
> would have to be defined differently if such fences ever made their way into
> LKMM.)
> 
> Now cumul-fence/prop cares about the A-cumulativity aspect, and pb about the
> strong-fence aspect, but of course the A-cumulativity also appears in pb,
> just hidden right now through the additional rfe? at the end of prop (if
> there were non-A-cumulative strong fences, I think it would need to be pb =
> overwrite & ext ; cumul-fence* ; (A-cumul(...) | ...)). So I don't think one

Not quite right.  A hypothetical non-A-cumulative case for pb would have 
to omit the cumul-fence term entirely.

> can draw the A-cumulativity aspect delineation between the relations clearly
> (when allowing for orthogonality). I'm proposing instead to make
> A-cumulativity a part of being a strong-fence and drawing the strong-fence
> delineation clearly.

Maybe so, in some sense.  But in practice you're asking to have strong 
fences removed from cumul-fence and prop.  I don't want to do that, even 
at the cost of some redundancy.

Consider the RB pattern as another example.  Suppose the read -> write 
ordering on one or both sides is provided by a fence rather than a 
dependency or some such.  Would you want to keep such cycles out of the 
(ppo | rfe)+ part of hb+, on the basis that they also can be covered by 
((prop \ id) & int)?

> > People who make that particular mistake should take a lesson from it:
> > The presence of a strong fence should point them toward looking for an
> > application of pb before looking at prop, because pb is is based on the
> > special properties of strong fences whereas prop is not.
> 
> Yes, with two caveats:
> - you can remove the "before looking at prop" since there's never ever any
> point of looking at (extending) prop when you have a strong fence
> - why give people the opportunity for that mistake in the first place? ...
> > [...] by making a mistake through pursuing
> > a redundant pathway, people can deepen their understanding.  That's how
> > one learns.
> ... I do feel reminded about the discussion about building character : )
> 
> Honestly I would easily see your point if there were some uncommon reasons
> to use the strong fence to extend prop. Then the lesson is what you
> mentioned: usually, strong fences should be looked at through the pb lense,
> and only if you get stuck that way it makes sense to look through the prop
> lense (and probably one could develop a good intuition for which situation
> calls for which after some time).
> 
> But that's not the case here. There's nothing to learn here except that one
> should pretend that strong-fence didn't exist in prop.
> That lesson could also be learned by not having it there in the first place.
> And I think you can easily present LKMM in a way that makes this look
> reasonable.

In fact, I wouldn't mind removing the happens-before, propagation, and 
rcu axioms from LKMM entirely, replacing them with the single 
executes-before axiom.

> I'm wondering a little if there's some way in the middle, e.g., by writting
> short comments in the model wherever something is redundant. Something like
> (* note: strong-fence is included here for completeness, and can be safely
> ignored *).

I have no objection to doing that.  It seems like a good idea.

Alan
