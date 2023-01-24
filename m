Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5378D679FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjAXROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjAXROL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:14:11 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 878FA173B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:14:09 -0800 (PST)
Received: (qmail 173647 invoked by uid 1000); 24 Jan 2023 12:14:08 -0500
Date:   Tue, 24 Jan 2023 12:14:08 -0500
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
Message-ID: <Y9AR4Gr10SyCKovo@rowland.harvard.edu>
References: <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
 <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
 <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
 <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
 <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
 <41a14c54-8f17-d3ba-fc03-f9af4645881d@huaweicloud.com>
 <Y87D0ekKCHFLjzeP@rowland.harvard.edu>
 <8908438d-da93-b843-f0e0-831ba7070c86@huaweicloud.com>
 <Y873uBB5rAW8tjdd@rowland.harvard.edu>
 <1a189694-57b4-81d0-625a-64dd069b1953@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a189694-57b4-81d0-625a-64dd069b1953@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:14:03PM +0100, Jonas Oberhauser wrote:
> After mulling it over a bit in my big old head, I consider that even though
> dropping the [W] may be shorter, it might make for the simpler model by
> excluding lots of cases.
> That makes me think you should do it for real in the definition of prop. And
> not just at the very end, because in fact each cumul-fence link might come
> from a non-A-cumulative fence. So the same argument you are giving should be
> applied recursively.
> Either
> 
> 	prop = (overwrite & ext)? ; (cumul-fence; [W])* ; rfe?
> 
> or integrate it directly into cumul-fence.

I dislike this sort of argument.  I understand the formal memory model 
by relating it to the informal operational model.  Thus, cumul-fence 
links a write W to another event E when the fence guarantees that W will 
propagate to E's CPU before E executes.  That's how the memory model 
expresses the propagation properties of these fences.  I don't want to 
rule out the possibility that E is a read merely because cumul-fence 
might be followed by another, A-cumulative fence.  If E=read were ruled 
out then cumul-fence would not properly express the propagation 
properties of the fences.

> > > > Consider: Could we remove all propagation-ordering fences from ppo
> > > > because they are subsumed by prop?  (Or is that just wrong?)
> > > Surely not, since prop doesn't usually provide ordering by itself.
> > Sorry, I meant the prop-related non-ppo parts of hb and pb.
> 
> I still don't follow :( Can you write some equations to show me what you
> mean?

Consider:

	Rx=1			Ry=1
	Wrelease Y=1		Wx=1

Here we have Wx=1 ->hb* Ry=1 by (prop \ id) & int, using the fact that 
Wy=1 is an A-cumulative release fence.  But we also have

	Wx=1 ->rfe Rx=1 ->ppo Wy=1 ->rfe Ry=1.

Thus there are two distinct ways of proving that Wx=1 ->hb* Ry=1.  If we 
removed the fence term from the definition of ppo (or weakened it to 
just rmb | acq), we would eliminate the second, redundant proof.  Is 
this the sort of thing you think we should do?

> > > > > > In fact, I wouldn't mind removing the happens-before, propagation, and
> > > > > > rcu axioms from LKMM entirely, replacing them with the single
> > > > > > executes-before axiom.
> > > > > I was planning to propose the same thing, however, I would also propose to
> > > > > redefine hb and rb by dropping the hb/pb parts at the end of these
> > > > > relations.
> > > > > 
> > > > >    hb = ....
> > > > >    pb = prop ; strong-fence ; [Marked]
> > > > >    rb = prop ; rcu-fence ; [Marked]
> > > > > 
> > > > >    xb = hb|pb|rb
> > > > >    acyclic xb
> > > > I'm not so sure that's a good idea.  For instance, it would require the
> > > > definitions of rcu-link and rb to be changed from having (hb* ; pb*) to
> > > > having (hb | pb)*.
> > > I think that's an improvement. It's obvious that (hb | pb)* is right and so
> > > is (pb | hb)*.
> > > For (hb* ; pb*), the first reaction is "why do all the hb edges need to be
> > > before the pb edges?", until one realizes that pb actually allows hb* at the
> > > end, so in a sense this is  hb* ; (pb ; hb*)*, and then one has to
> > > understand that this means that the prop;strong-fence edges can appear any
> > > number of times at arbitrary locations. It just seems like defining (pb |
> > > hb)* with extra steps.
> > This can be mentioned explicitly as a comment or in explanation.txt.
> Ok, but why not just use  (pb|hb)* and (pb|hb|rb)* and not worry about
> having to explain anything?
> And make the hb and rb definitions simpler at the same time?

Do you think (pb | hb)* is simpler than pb* (as in the statement of the 
propagation axiom)?

Besides, remember what I said about understanding the formal memory 
model in terms of the operational model.  pb relates a write W to 
another event E when the strong fence guarantees that W will propagate 
to E's CPU before E executes.  If the hb* term were omitted from the 
definition of pb, this wouldn't be true any more.  Or at least, not as 
true as it should be.

Alan
