Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C836A3380
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 19:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjBZSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZSpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:45:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E92417151
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:45:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16984B80BA7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 18:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EA2C433EF;
        Sun, 26 Feb 2023 18:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677437128;
        bh=s3jrMMSf7p9BZCaXNca7N9jmQHzpgOUSh11sqU+leng=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e+DC7fDqUWqSOzoITMnQ+HyNLy+5EBPo7efzMaX9zy7cO0dFARgznz5j0ivyVae/I
         P9VOgyRKafpNXHbuI2Yrp34duiWZQMcUjw36lq1366dci4B8cGF3+IcWLo7hf5AMR0
         CK8xkHMIzx4kLacLPdtTwVHp9siZFaVzq7N5yk171u97nHSLPq0Dq70XFNOfeWUVtY
         OlmMoMh6HRykGw4PfAqoDHDx0XRTOqu4UpxoAfJvNfFwQQIzikOy3OQFEEI9VD5E5H
         N8pNfCuqKs3XSCJYyllv/iqFuTiLwkUQXSCd8DZX6T0PTEVtPNL/8nkNBZcVyMgj1+
         DW2Ah03bddosQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 300555C023E; Sun, 26 Feb 2023 10:45:28 -0800 (PST)
Date:   Sun, 26 Feb 2023 10:45:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230226184528.GY2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
 <Y/rNUfW509AQYCYn@boqun-archlinux>
 <Y/rSQ2FNTJyj2bqR@rowland.harvard.edu>
 <a862ee59-ca12-b609-48cc-0784c7ce24af@huaweicloud.com>
 <Y/uOA3umovz06/SV@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/uOA3umovz06/SV@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 11:51:15AM -0500, Alan Stern wrote:
> On Sun, Feb 26, 2023 at 12:17:31PM +0100, Jonas Oberhauser wrote:
> > On 2/26/2023 4:30 AM, Alan Stern wrote:
> > > On Sat, Feb 25, 2023 at 07:09:05PM -0800, Boqun Feng wrote:
> > > > On Sat, Feb 25, 2023 at 09:29:51PM -0500, Alan Stern wrote:
> > > > > On Sat, Feb 25, 2023 at 05:01:10PM -0800, Paul E. McKenney wrote:
> > > > > > A few other oddities:
> > > > > > 
> > > > > > litmus/auto/C-LB-Lww+R-OC.litmus
> > > > > > 
> > > > > > 	Both versions flag a data race, which I am not seeing.	It appears
> > > > > > 	to me that P1's store to u0 cannot happen unless P0's store
> > > > > > 	has completed.  So what am I missing here?
> > > > > The LKMM doesn't believe that a control or data dependency orders a
> > > > > plain write after a marked read.  Hence in this test it thinks that P1's
> > > > > store to u0 can happen before the load of x1.  I don't remember why we
> > > > > did it this way -- probably we just wanted to minimize the restrictions
> > > > > on when plain accesses can execute.  (I do remember the reason for
> > > > > making address dependencies induce order; it was so RCU would work.)
> > > > > 
> > > > Because plain store can be optimzed as an "store only if not equal"?
> > > > As the following sentenses in the explanations.txt:
> > > > 
> > > > 	The need to distinguish between r- and w-bounding raises yet another
> > > > 	issue.  When the source code contains a plain store, the compiler is
> > > > 	allowed to put plain loads of the same location into the object code.
> > > > 	For example, given the source code:
> > > > 
> > > > 		x = 1;
> > > > 
> > > > 	the compiler is theoretically allowed to generate object code that
> > > > 	looks like:
> > > > 
> > > > 		if (x != 1)
> > > > 			x = 1;
> > > > 
> > > > 	thereby adding a load (and possibly replacing the store entirely).
> > > > 	For this reason, whenever the LKMM requires a plain store to be
> > > > 	w-pre-bounded or w-post-bounded by a marked access, it also requires
> > > > 	the store to be r-pre-bounded or r-post-bounded, so as to handle cases
> > > > 	where the compiler adds a load.
> > > Good guess; maybe that was the reason.  [...]
> > > So perhaps the original reason is not valid now
> > > that the memory model explicitly includes tests for stores being
> > > r-pre/post-bounded.
> > > 
> > > Alan
> > 
> > I agree, I think you could relax that condition.
> 
> Here's a related question to think about.  Suppose a compiler does make 
> this change, adding a load-and-test in front of a store.  Can that load 
> cause a data race?
> 
> Normally I'd say no, because compilers aren't allowed to create data 
> races where one didn't already exist.  But that restriction is part of 
> the C/C++ standard, and what we consider to be a data race differs from 
> what the standard considers.
> 
> So what's the answer?  Is the compiler allowed to translate:
> 
> 	r1 = READ_ONCE(*x);
> 	if (r1)
> 		*y = 1;
> 
> into something resembling:
> 
> 	r1 = READ_ONCE(*x);
> 	rtemp = *y;
> 	if (r1) {
> 		if (rtemp != 1)
> 			*y = 1;
> 	}
> 
> (Note that whether the load to rtemp occurs inside the "if (r1)" 
> conditional or not makes no difference; either way the CPU can execute 
> it before testing the condition.  Even before reading the value of *x.)
> 
> _If_ we assume that these manufactured loads can never cause a data race 
> then it should be safe to remove the r-pre/post-bounded tests for plain 
> writes.
> 
> But what if rtemp reads from a plain write that was torn, and the 
> intermediate value it observes happens to be 1, even though neither the 
> initial nor the final value of *y was 1?

I am not worried about compilers creating data races, so that assignment
to rtemp would be within the "if (r1)" statement.  Not that this matters,
as you say, from a hardware ordering viewpoint.

However, tearing is a concern.  Just to make sure I undersand, one
scenario might be where the initial value of *y was zero and the final
value was 0x10001, correct?  In that case, we have seen compilers that
would write that constant 16 bits at a time, resulting in an transitory
value of 0x1.

But in this case, we would need the value to -not- be 1 for bad things
to happen, correct?

And in that case, we would need the value to initially be 1 and the
desired value to be 1 and some other store to redundantly set it to
1, but tear is such a way that the transitory value is not 1, correct?
Plus we should detect the data race in that case, not?

Or am I missing yet another opportunity for a mischievous compiler?

> > Note there's also rw-xbstar (used with fr) which doesn't check for
> > r-pre-bounded, but it should be ok. That's because only reads would be
> > unordered, as a result the read (in the if (x != ..) x=..) should provide
> > the correct value. The store would be issued as necessary, and the issued
> > store would still be ordered correctly w.r.t the read.
> 
> That isn't the reason I left r-pre-bounded out from rw-xbstar.  If the 
> write gets changed to a read there's no need for rw-xbstar to check 
> r-pre-bounded, because then rw-race would be comparing a read with 
> another read (instead of with a write) and so there would be no 
> possibility of a race in any case.

True, and if there was a racing write, it would be a data race in
any case.

							Thanx, Paul
