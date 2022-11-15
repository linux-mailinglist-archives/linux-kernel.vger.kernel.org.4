Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53B629E94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbiKOQNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKOQNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:13:14 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CAB2329342
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:13:12 -0800 (PST)
Received: (qmail 175248 invoked by uid 1000); 15 Nov 2022 11:13:12 -0500
Date:   Tue, 15 Nov 2022 11:13:12 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools: memory-model: Add rmw-sequences to the LKMM
Message-ID: <Y3O6mJz4wXJlzLh2@rowland.harvard.edu>
References: <Y3J6P3jCNmrj3tue@rowland.harvard.edu>
 <1453ec4a0b7549009eff21d899053c50@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453ec4a0b7549009eff21d899053c50@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:05:39PM +0000, Jonas Oberhauser wrote:
> 
> 
> 
> 	
> > -----Original Message-----
> > From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> > Sent: Monday, November 14, 2022 6:26 PM
> 
> Hi Alan,
> thanks for preparing this!
> 
> > Jonas has pointed out a weakness in the Linux Kernel Memory Model.
> > Namely, the memory ordering properties of atomic operations are not
> > monotonic: An atomic op with full-barrier semantics does not always provide ordering as strong as one with release-barrier semantics.
> 
> Note that I believe it was Viktor who originally pointed out this weakness to me
> in private communication. My contribution (besides chatting with you) is to
> check that the solution does indeed restore the monotonicity (not just on some
> litmus tests but in general).
> 
> So I would change the wording to "Viktor has pointed out a weakness in the Linux
> Kernel Memory Model."

People will wonder who Viktor is.  I don't have his full name or email 
address.  In fact, shouldn't he have been CC'ed during this entire 
discussion?

> > +let rmw-sequence = (rf ; rmw)*
> 
> I would perhaps suggest to only consider external read-from in rmw-sequences, as
> below:
> +let rmw-sequence = (rfe ; rmw)*

We discussed the matter earlier, and I don't recall any mention of this 
objection.

> The reason I (slightly) prefer this is that this is sufficient to imply
> monotonicity.
> Also there is some minor concern that the patch that results in the stricter
> model (i.e., rmw-sequence = (rf ; rmw)*) might be incorrect on some hypothetical
> future architecture in which RMWs can be merged in the store coalescing queue
> with earlier stores to the same location. This is exemplified in the following
> litmus test:
> 
> C atomics-not-monotonic-2
> 
> {}
> 
> P0(int *x, atomic_t *y)
> {
>     int r1;
> 	WRITE_ONCE(*x, 1);
> 	smp_store_release(y, 0);
> 	r1 = atomic_inc_return_relaxed(y);
> }
> 
> P1(atomic_t *y)
> {
> 	int r1;
> 
> 	r1 = atomic_inc_return(y);
> }
> 
> P2(int *x, atomic_t *y)
> {
> 	int r2;
> 	int r3;
> 
> 	r2 = atomic_read(y);
> 	smp_rmb();
> 	r3 = READ_ONCE(*x);
> }
> 
> exists (2:r2=2 /\ 2:r3=0)
> 
> Here such a hypothetical future architecture could merge the operations to *y by
> P0 into a single store, effectively turning the code of P0 into
> 
> P0(int *x, atomic_t *y)
> {
>     int r1;
> 	WRITE_ONCE(*x, 1);
> 	WRITE_ONCE(*y, 1);
> 	r1 = 0;
> }
> 
> The stricter patch would not be sound with this hypothetical architecture, while
> the more relaxed patch should be.
> 
> I don't think such a future architecture is likely since I don't expect there to
> be any practical performance impact. At the same time I also don't currently see
> any advantage of the stricter model.
> 
> For this reason I would slightly prefer the more relaxed model.

I don't see any point in worrying about hypothetical future 
architectures that might use a questionable design.

Also, given that this test is forbidden:

P0				P1		P2
-------------------------	--------------	----------------------------
WRITE_ONCE(*x, 1);		atomic_inc(y);	r1 = atomic_read_acquire(y);
atomic_set_release(y, 1);			r2 = READ_ONCE(*x);
exists (2:r1=2 /\ 2:r2=0)

shouldn't the following also be forbidden?

P0				P1		P2
-------------------------	--------------	----------------------------
WRITE_ONCE(*x, 1);		atomic_inc(y);	r1 = atomic_read_acquire(y);
atomic_set_release(y, 1);	atomic_inc(y);	r2 = READ_ONCE(*x);
exists (2:r1=3 /\ 2:r2=0)

> > +Rmw sequences have a special property in the LKMM: They can extend the 
> > +cumul-fence relation.  That is, if we have:
> > +
> > +	U ->cumul-fence X -> rmw-sequence Y
> > +
> > +then also U ->cumul-fence Y.  Thinking about this in terms of the 
> > +operational model, U ->cumul-fence X says that the store U propagates 
> > +to each CPU before the store X does.  Then the fact that X and Y are 
> > +linked by an rmw sequence means that U also propagates to each CPU 
> > +before Y does.
> > +
> 
> Here I would add that the rmw sequences also play a similar role in the
> w-post-bounded relation. For example as follows:
> 
> +Rmw sequences have a special property in the LKMM: They can extend the 
> +cumul-fence and w-post-bounded relations.  That is, if we have:
> +
> +	U ->cumul-fence X -> rmw-sequence Y
> +
> +then also U ->cumul-fence Y, and analogously if we have
> +
> +	U ->w-post-bounded X -> rmw-sequence Y
> +
> +then also U ->w-post-bounded Y. Thinking about this in terms of the 
> +operational model, U ->cumul-fence X says that the store U propagates 
> +to each CPU before the store X does.  Then the fact that X and Y are 
> +linked by an rmw sequence means that U also propagates to each CPU 
> +before Y does.
> +

I considered this and specifically decided against it, because the 
w-post-bounded relation has not yet been introduced at this point in the 
document.  It doesn't show up until much later.  (Also, there didn't 
seem to be any graceful way of mentioning this fact at the point where 
w-post-bounded does get introduced, and on the whole the matter didn't 
seem to be all that important.)

Instead of your suggested change, I suppose it would be okay to say, at 
the end of the paragraph:

	(In an analogous way, rmw sequences can extend the 
	w-post-bounded relation defined below in the PLAIN ACCESSES
	AND DATA RACES section.)

Or something like this could be added to the ODDS AND ENDS section at 
the end of the document.

Alan
