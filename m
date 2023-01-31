Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB2F683313
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjAaQzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAaQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:55:21 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D497813D57
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:55:19 -0800 (PST)
Received: (qmail 453220 invoked by uid 1000); 31 Jan 2023 11:55:19 -0500
Date:   Tue, 31 Jan 2023 11:55:19 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>, paulmck@kernel.org,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9lH97/Hw+W90gj0@rowland.harvard.edu>
References: <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <0da94668-c041-1d59-a46d-bd13562e385e@huaweicloud.com>
 <Y9ct1aAnOTGCy9n2@rowland.harvard.edu>
 <001f7d74-0ef9-a667-b656-bbd18491d5c1@huaweicloud.com>
 <Y9kugMJrR2oJhUVv@rowland.harvard.edu>
 <878cef1b-d4e5-f710-dc0a-a9329ad483d8@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878cef1b-d4e5-f710-dc0a-a9329ad483d8@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 04:33:25PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/31/2023 4:06 PM, Alan Stern wrote:
> > On Tue, Jan 31, 2023 at 02:56:00PM +0100, Jonas Oberhauser wrote:
> > > I have some additional thoughts now. It seems that you could weaken the
> > > operational model by stating that an A-cumulative fence orders propagation
> > > of all *external* stores (in addition to all po-earlier stores) that
> > > propagated to you before the fence is executed.
> > How is that a weakening of the operational model?  It's what the
> > operational model says right now.
> 
> No, as in the part that you have quoted, it is stated that an A-cumulative
> fence orderes propagation of *all* stores that propagated to you before the
> fence is executed.
> I'm saying you could weaken this to only cover all *external* stores.

Okay, now I understand.

> More precisely, I would change
> 
> > 	For each other CPU C', any store which propagates to C before
> > 	a release fence is executed (including all po-earlier
> > 	stores executed on C) is forced to propagate to C' before the
> > 	store associated with the release fence does.
> 
> Into something like
> 
> 
>      For each other CPU C', any *external* store which propagates to C
> before
>      a release fence is executed as well as any po-earlier
>      store executed on C is forced to propagate to C' before the
>      store associated with the release fence does.
> 
> The difference is that po-later stores that happen to propagate to C before
> the release fence is executed would no longer be ordered.
> That should be consistent with the axiomatic model.

I had to check that it wouldn't affect the (xbstar & int) part of vis, 
but it looks all right.  This seems like a reasonable change.

However, it only fixes part of the problem.  Suppose an external write 
is read by an instruction po-after the release-store, but the read 
executes before the release-store.  The operational model would still 
say the external write has to obey the propagation ordering, whereas the 
formal model doesn't require it.

> > > > P0(int *x, int *y, int *z)
> > > > {
> > > > 	int r1;
> > > > 
> > > > 	r1 = READ_ONCE(*x);
> > > > 	smp_store_release(y, 1);
> > > > 	WRITE_ONCE(*z, 1);
> > > > }
> > > > 
> > > > P1(int *x, int *y, int *z)
> > > > {
> > > > 	int r2;
> > > > 
> > > > 	r2 = READ_ONCE(*z);
> > > > 	WRITE_ONCE(*x, r2);
> > > > }
> > > > 
> > > > P2(int *x, int *y, int *z)
> > > > {
> > > > 	int r3;
> > > > 	int r4;
> > > > 
> > > > 	r3 = READ_ONCE(*y);
> > > > 	smp_rmb();
> > > > 	r4 = READ_ONCE(*z);
> > > > }
> > > > 
> > > > exists (0:r1=1 /\ 2:r3=1 /\ 2:r4=0)
> > > I could imagine that P0 posts both of its stores in a shared store buffer
> > > before reading *x, but marks the release store as "not ready".
> > > Then P1 forwards *z=1 from the store buffer and posts *x=1, which P0 reads,
> > > and subsequently marks its release store as "ready".
> > That isn't how release stores are meant to work.  The read of x is
> > supposed to be complete before the release store becomes visible to any
> > other CPU.
> 
> Note that the release store isn't observed until it becomes "ready", so it
> is really indistinguishable of whether it had become visible to any other
> CPU.
> Indeed stores that aren't marked "ready" would be ignored during forwarding,
> and not allowed to be pushed to the cache.

Oops, I mixed up a couple of the accesses.  Okay, yes, this mechanism 
will allow writes that are po-after a release store but execute before 
it to evade the propagation restriction.

> The reason this kind of implementation seems less natural to me is that such
> an "not ready" store would need to be pushed back in the buffer (if it is
> the head of the buffer and the cache is ready to take a store), stall the
> later stores, or be aborted until it becomes ready.
> That just seems to create a lot of hassle for no discernible benefit.
> A "not ready" store probably shouldn't be put into a store queue, even if
> the only reason it is not ready is that there are some otherwise unrelated
> reads that haven't completed yet.
> 
> 
> 
> > This is true even in C11.
> 
> Arguable... The following pseudo-code litmus test should demonstrate this:
> 
> P0 {
>    int r = read_relaxed(&x);
>    store_release(&y,1);
> }
> 
> 
> P1 {
>    int s = read_relaxed(&y);
>    store_release(&x,1);
> }
> 
> In C11, it should be possible to read r==s==1.

True, in C11 releases don't mean anything unless they're paired with 
acquires.  But if your P1 had been

	int s = read_acquire(&y);
	write_relaxed(&x, 1);

then r = s = 1 would not be allowed.  And presumably the same object 
code would be generated for P0 either way, particularly if P1 was in a 
separate compilation unit (link-time optimization notwithstanding).

> Btw, how to proceed for your SRCU patch and this one?
> Are you planning to make any changes? I think the version you have is ok if
> you don't think the patch is improved by anything I brought up.

I don't see any need to change the SRCU patch at this point, other than 
to improve the attributions.

> Any additional concerns/changes for this patch?

It should give the same data-race diagnostics as the current LKMM.  This 
probably means the patch will need to punch up the definitions of 
*-pre-bounded and *-post-bounded, unless you can think of a better 
approach.

Alan
