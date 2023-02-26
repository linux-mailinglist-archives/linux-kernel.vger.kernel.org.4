Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABDF6A33A3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBZTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZTci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:32:38 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 47CD1CC04
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 11:32:37 -0800 (PST)
Received: (qmail 102798 invoked by uid 1000); 26 Feb 2023 14:32:36 -0500
Date:   Sun, 26 Feb 2023 14:32:36 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y/uz1FYR0rP8uTzg@rowland.harvard.edu>
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
 <Y/rNUfW509AQYCYn@boqun-archlinux>
 <Y/rSQ2FNTJyj2bqR@rowland.harvard.edu>
 <a862ee59-ca12-b609-48cc-0784c7ce24af@huaweicloud.com>
 <Y/uOA3umovz06/SV@rowland.harvard.edu>
 <20230226184528.GY2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226184528.GY2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 10:45:28AM -0800, Paul E. McKenney wrote:
> On Sun, Feb 26, 2023 at 11:51:15AM -0500, Alan Stern wrote:
> > Here's a related question to think about.  Suppose a compiler does make 
> > this change, adding a load-and-test in front of a store.  Can that load 
> > cause a data race?
> > 
> > Normally I'd say no, because compilers aren't allowed to create data 
> > races where one didn't already exist.  But that restriction is part of 
> > the C/C++ standard, and what we consider to be a data race differs from 
> > what the standard considers.
> > 
> > So what's the answer?  Is the compiler allowed to translate:
> > 
> > 	r1 = READ_ONCE(*x);
> > 	if (r1)
> > 		*y = 1;
> > 
> > into something resembling:
> > 
> > 	r1 = READ_ONCE(*x);
> > 	rtemp = *y;
> > 	if (r1) {
> > 		if (rtemp != 1)
> > 			*y = 1;
> > 	}
> > 
> > (Note that whether the load to rtemp occurs inside the "if (r1)" 
> > conditional or not makes no difference; either way the CPU can execute 
> > it before testing the condition.  Even before reading the value of *x.)
> > 
> > _If_ we assume that these manufactured loads can never cause a data race 
> > then it should be safe to remove the r-pre/post-bounded tests for plain 
> > writes.
> > 
> > But what if rtemp reads from a plain write that was torn, and the 
> > intermediate value it observes happens to be 1, even though neither the 
> > initial nor the final value of *y was 1?
> 
> I am not worried about compilers creating data races, so that assignment
> to rtemp would be within the "if (r1)" statement.  Not that this matters,
> as you say, from a hardware ordering viewpoint.
> 
> However, tearing is a concern.  Just to make sure I undersand, one
> scenario might be where the initial value of *y was zero and the final
> value was 0x10001, correct?  In that case, we have seen compilers that
> would write that constant 16 bits at a time, resulting in an transitory
> value of 0x1.
> 
> But in this case, we would need the value to -not- be 1 for bad things
> to happen, correct?
> 
> And in that case, we would need the value to initially be 1 and the
> desired value to be 1 and some other store to redundantly set it to
> 1, but tear is such a way that the transitory value is not 1, correct?
> Plus we should detect the data race in that case, not?
> 
> Or am I missing yet another opportunity for a mischievous compiler?

Let's try a better example:

P0(int *x, int *y)
{
	*y = 0x10001;
	smp_store_release(x, 1);
}

P1(int *x, int *y)
{
	int r1;

	r1 = READ_ONCE(*x);
	if (r1)
		*y = 1;
}

exists (1:r1=1 /\ y=0x10001)

Assume the compiler translates "*y = 1;" to:

	{
		rtemp = *y;
		if (rtemp != 1)
			*y = 1;
	}

Then there is nothing preventing P1's CPU from loading *y into rtemp 
before it reads *x.  If the plain write in P0 is torn then rtemp could 
end up getting set to 1, so P1 wouldn't write anything to *y and the 
litmus test would succeed.

If the LKMM should think this litmus test has no data race then it 
should also think the test will never succeed.  But I've just shown how 
it might succeed.  Ergo the LKMM should say this test has a data race, 
and thus we shouldn't remove the r-pre-bounded tests for plain writes.

Of course, this is a separate question from whether w-pre-bounded should 
be changed to use rwdep instead of addr.

Alan
