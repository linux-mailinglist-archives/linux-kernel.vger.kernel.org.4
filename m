Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D29F67B672
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjAYP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjAYP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:56:35 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0B39F193FF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:56:27 -0800 (PST)
Received: (qmail 214449 invoked by uid 1000); 25 Jan 2023 10:56:27 -0500
Date:   Wed, 25 Jan 2023 10:56:27 -0500
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
Message-ID: <Y9FRK+AWped17QfU@rowland.harvard.edu>
References: <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
 <41a14c54-8f17-d3ba-fc03-f9af4645881d@huaweicloud.com>
 <Y87D0ekKCHFLjzeP@rowland.harvard.edu>
 <8908438d-da93-b843-f0e0-831ba7070c86@huaweicloud.com>
 <Y873uBB5rAW8tjdd@rowland.harvard.edu>
 <1a189694-57b4-81d0-625a-64dd069b1953@huaweicloud.com>
 <Y9AR4Gr10SyCKovo@rowland.harvard.edu>
 <40447973-6f6b-86f7-1147-d8f20a943767@huaweicloud.com>
 <Y9CamIsCmFkPYrwl@rowland.harvard.edu>
 <61447f05-7875-f0ce-3b51-c3f4428b85d4@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61447f05-7875-f0ce-3b51-c3f4428b85d4@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 02:06:01PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/25/2023 3:57 AM, Alan Stern wrote:
> > Starting from first principles, it's apparent that each of these types
> > of propagation fences is associated with two relations: one involving
> > propagation order and a companion relation involving execution order.
> > 
> > Here's what I mean.  For the sake of discussion let's define several
> > classes of fences:
> > 
> > 	efences are those which constrain execution order;
> > 
> > 	pfences are those which constrain propagation order;
> > 
> > 	sfences are those which strongly constrain propagation order.
> > 
> > Each class includes the following ones.  (And if you like, you can
> > insert afences between pfences and sfences -- they would be the
> > A-cumulative fences.)
> > 
> > Now, the memory model builds up successively more inclusive notions of
> > execution order.  This process starts with execution of instructions in
> > the same CPU not involving fences.  Thus we have the ppo relations:
> > dependencies and a few oddball things like ((overwrite ; rfe) & int) or
> > ([UL] ; po ; [LKR]).
> > 
> > Next, the efences also restrict single-CPU execution order.  These
> > fences only need to have one associated relation since they don't
> > specifically involve propagation.  Adding rfe to the list gives us
> > inter-CPU ordering.
> > 
> > Then associated with pfences we have the relation you've been talking
> > about:
> > 
> > 	W propagates to each CPU before W' does.
> > 
> > This is (cumul-fence ; [W]).  Perhaps a better name for it would be
> > wprop.  Given this relation, we obtain a companion relation that
> > restricts execution order:
> > 
> > 	((overwrite & ext) ; wprop+ ; rfe) & int.
> > 
> > (Note that the overall form is the same for afences as for pfences.)
> > Adding this companion relation into the mix gives us essentially hb.
> > 
> > For sfences the associated relation expresses:
> > 
> > 	W propagates to every CPU before Y executes.
> > 
> > This is basically (wprop* ; rfe? ; sfence) (using the fact that all
> > sfences are A-cumulative) -- or if you prefer, (wprop* ; cumul-sfence).
> > We can call this sprop.  Then the companion relation restricting
> > execution order is:
> > 
> > 	(overwrite & ext) ; sprop
> > 
> > For RCU, the associated relation expressing t2(A) < t1(B) is rcu-order
> > and the companion relation is rcu-fence.
> Do we put rcu-order under sprop as well? Otherwise you need
> 
>     (overwrite & ext)? ; rcu-fence
> 
> to express the full companion relation.

My mistake; what I meant was something a little smaller than rb.  That 
is,

	(overwrite & ext) ; wprop* ; rfe? ; rcu-fence

In other words, a relation expressing that rcu-fence acts as a strong 
fence.  But also something expressing that rcu-fence acts as an efence? 
-- I guess this is covered if the (overwrite & ext) part above is made 
optional, although that feels a little artificial.

I don't think we will be able to include rcu-fence in sprop, because we 
will need to use sprop in the definition of rcu-fence.

Oh yes, one other piece of terminology I forgot to mention.  The things 
you referred to before as "ordering operations" could instead be called 
"extended fences".  What do you think?

> > Putting all those execution-order relations together gives us xb, the
> > executes-before relation.  Then the only axiom we need for all of this
> > that xb is acyclic.
> > 
> > Of course, I have left out a lot of details.  Still, how does that sound
> > as a scheme for rationalizing the memory model?
> 
> It seems like we're on the same page!
> It would be an honor for me to fill in the details and propose a patch, if
> you're interested.

An invasive, multi-faceted change like this has to be broken down into 
multiple patches, each doing only one thing and each easily verified as 
not changing the meaning of the code.  Feel free to go ahead and work 
out a proposal.

Alan
