Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73716683120
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjAaPP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjAaPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:15:21 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 55C7C3253F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:13:41 -0800 (PST)
Received: (qmail 449299 invoked by uid 1000); 31 Jan 2023 10:06:40 -0500
Date:   Tue, 31 Jan 2023 10:06:40 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>, paulmck@kernel.org,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9kugMJrR2oJhUVv@rowland.harvard.edu>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <0da94668-c041-1d59-a46d-bd13562e385e@huaweicloud.com>
 <Y9ct1aAnOTGCy9n2@rowland.harvard.edu>
 <001f7d74-0ef9-a667-b656-bbd18491d5c1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001f7d74-0ef9-a667-b656-bbd18491d5c1@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:56:00PM +0100, Jonas Oberhauser wrote:
> I have some additional thoughts now. It seems that you could weaken the
> operational model by stating that an A-cumulative fence orders propagation
> of all *external* stores (in addition to all po-earlier stores) that
> propagated to you before the fence is executed.

How is that a weakening of the operational model?  It's what the 
operational model says right now.  From explanation.txt:

	Release fences, such as smp_store_release(), force the CPU to
	execute all po-earlier instructions before the store
	associated with the fence (e.g., the store part of an
	smp_store_release()).

...  When a fence instruction is executed on CPU C:

	...

	For each other CPU C', any store which propagates to C before
	a release fence is executed (including all po-earlier
	stores executed on C) is forced to propagate to C' before the
	store associated with the release fence does.

In theory, we could weaken the operational model by saying that pfences 
order propagation of stores from other CPUs only when those stores are 
read-from by instructions po-before the fence.  But I suspect that's not 
such a good idea.

> It seems that on power, from an operational model perspective, there's
> currently no difference between propagation fences ordering all stores vs
> only external stores that propagated to the CPU before the fence is
> executed, because they only have bidirectional (*->W) fences (sync, lwsync)
> and not uni-directional (acquire, release), and so it is not possible for a
> store that is po-later than the barrier to be executed before the barrier;
> i.e., on power, every internal store that propagates to a CPU before the
> fence executes is also po-earler than the fence.
> 
> If power did introduce release stores, I think you could potentially create
> implementations that allow the behavior in the example you have given, but I
> don't think they are the most natural ones:

Maybe so.  In any case, it's a moot point.  In fact, I don't know if any 
architecture supporting Linux allows a write that is po-after a release 
store to be reordered before the release store.

> > P0(int *x, int *y, int *z)
> > {
> > 	int r1;
> > 
> > 	r1 = READ_ONCE(*x);
> > 	smp_store_release(y, 1);
> > 	WRITE_ONCE(*z, 1);
> > }
> > 
> > P1(int *x, int *y, int *z)
> > {
> > 	int r2;
> > 
> > 	r2 = READ_ONCE(*z);
> > 	WRITE_ONCE(*x, r2);
> > }
> > 
> > P2(int *x, int *y, int *z)
> > {
> > 	int r3;
> > 	int r4;
> > 
> > 	r3 = READ_ONCE(*y);
> > 	smp_rmb();
> > 	r4 = READ_ONCE(*z);
> > }
> > 
> > exists (0:r1=1 /\ 2:r3=1 /\ 2:r4=0)
> 
> I could imagine that P0 posts both of its stores in a shared store buffer
> before reading *x, but marks the release store as "not ready".
> Then P1 forwards *z=1 from the store buffer and posts *x=1, which P0 reads,
> and subsequently marks its release store as "ready".

That isn't how release stores are meant to work.  The read of x is 
supposed to be complete before the release store becomes visible to any 
other CPU.  This is true even in C11.

> Then the release store is sent to the cache, where P2 reads *y=1 and then
> *z=0.
> Finally P0 sends its *z=1 store to the cache.
> 
> However, a perhaps more natural implementation would not post the release
> store to the store buffer until it is "ready", in which case the order in
> the store buffer would be *z=1 before *y=1, and in this case the release
> ordering would presumably work like your current operational model.
> 
> Nevertheless, perhaps this slightly weaker operational model isn't as absurd
> as it sounds. And I think many people wouldn't be shocked if the release
> store didn't provide ordering with *z=1.

This issue is one we should discuss with all the other people involved 
in maintaining the LKMM.

Alan
