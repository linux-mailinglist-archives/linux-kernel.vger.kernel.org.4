Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB606A32EA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBZQvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjBZQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:51:17 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F371EAD01
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:51:15 -0800 (PST)
Received: (qmail 99506 invoked by uid 1000); 26 Feb 2023 11:51:15 -0500
Date:   Sun, 26 Feb 2023 11:51:15 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y/uOA3umovz06/SV@rowland.harvard.edu>
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
 <Y/rNUfW509AQYCYn@boqun-archlinux>
 <Y/rSQ2FNTJyj2bqR@rowland.harvard.edu>
 <a862ee59-ca12-b609-48cc-0784c7ce24af@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a862ee59-ca12-b609-48cc-0784c7ce24af@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 12:17:31PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 2/26/2023 4:30 AM, Alan Stern wrote:
> > On Sat, Feb 25, 2023 at 07:09:05PM -0800, Boqun Feng wrote:
> > > On Sat, Feb 25, 2023 at 09:29:51PM -0500, Alan Stern wrote:
> > > > On Sat, Feb 25, 2023 at 05:01:10PM -0800, Paul E. McKenney wrote:
> > > > > A few other oddities:
> > > > > 
> > > > > litmus/auto/C-LB-Lww+R-OC.litmus
> > > > > 
> > > > > 	Both versions flag a data race, which I am not seeing.	It appears
> > > > > 	to me that P1's store to u0 cannot happen unless P0's store
> > > > > 	has completed.  So what am I missing here?
> > > > The LKMM doesn't believe that a control or data dependency orders a
> > > > plain write after a marked read.  Hence in this test it thinks that P1's
> > > > store to u0 can happen before the load of x1.  I don't remember why we
> > > > did it this way -- probably we just wanted to minimize the restrictions
> > > > on when plain accesses can execute.  (I do remember the reason for
> > > > making address dependencies induce order; it was so RCU would work.)
> > > > 
> > > Because plain store can be optimzed as an "store only if not equal"?
> > > As the following sentenses in the explanations.txt:
> > > 
> > > 	The need to distinguish between r- and w-bounding raises yet another
> > > 	issue.  When the source code contains a plain store, the compiler is
> > > 	allowed to put plain loads of the same location into the object code.
> > > 	For example, given the source code:
> > > 
> > > 		x = 1;
> > > 
> > > 	the compiler is theoretically allowed to generate object code that
> > > 	looks like:
> > > 
> > > 		if (x != 1)
> > > 			x = 1;
> > > 
> > > 	thereby adding a load (and possibly replacing the store entirely).
> > > 	For this reason, whenever the LKMM requires a plain store to be
> > > 	w-pre-bounded or w-post-bounded by a marked access, it also requires
> > > 	the store to be r-pre-bounded or r-post-bounded, so as to handle cases
> > > 	where the compiler adds a load.
> > Good guess; maybe that was the reason.  [...]
> > So perhaps the original reason is not valid now
> > that the memory model explicitly includes tests for stores being
> > r-pre/post-bounded.
> > 
> > Alan
> 
> I agree, I think you could relax that condition.

Here's a related question to think about.  Suppose a compiler does make 
this change, adding a load-and-test in front of a store.  Can that load 
cause a data race?

Normally I'd say no, because compilers aren't allowed to create data 
races where one didn't already exist.  But that restriction is part of 
the C/C++ standard, and what we consider to be a data race differs from 
what the standard considers.

So what's the answer?  Is the compiler allowed to translate:

	r1 = READ_ONCE(*x);
	if (r1)
		*y = 1;

into something resembling:

	r1 = READ_ONCE(*x);
	rtemp = *y;
	if (r1) {
		if (rtemp != 1)
			*y = 1;
	}

(Note that whether the load to rtemp occurs inside the "if (r1)" 
conditional or not makes no difference; either way the CPU can execute 
it before testing the condition.  Even before reading the value of *x.)

_If_ we assume that these manufactured loads can never cause a data race 
then it should be safe to remove the r-pre/post-bounded tests for plain 
writes.

But what if rtemp reads from a plain write that was torn, and the 
intermediate value it observes happens to be 1, even though neither the 
initial nor the final value of *y was 1?

> Note there's also rw-xbstar (used with fr) which doesn't check for
> r-pre-bounded, but it should be ok. That's because only reads would be
> unordered, as a result the read (in the if (x != ..) x=..) should provide
> the correct value. The store would be issued as necessary, and the issued
> store would still be ordered correctly w.r.t the read.

That isn't the reason I left r-pre-bounded out from rw-xbstar.  If the 
write gets changed to a read there's no need for rw-xbstar to check 
r-pre-bounded, because then rw-race would be comparing a read with 
another read (instead of with a write) and so there would be no 
possibility of a race in any case.

Alan
