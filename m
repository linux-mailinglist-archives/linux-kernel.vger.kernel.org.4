Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBFF6A2D47
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 04:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBZDaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 22:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBZDaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:30:14 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D2C33126E0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:30:12 -0800 (PST)
Received: (qmail 83422 invoked by uid 1000); 25 Feb 2023 22:30:11 -0500
Date:   Sat, 25 Feb 2023 22:30:11 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y/rSQ2FNTJyj2bqR@rowland.harvard.edu>
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
 <Y/rNUfW509AQYCYn@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/rNUfW509AQYCYn@boqun-archlinux>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 07:09:05PM -0800, Boqun Feng wrote:
> On Sat, Feb 25, 2023 at 09:29:51PM -0500, Alan Stern wrote:
> > On Sat, Feb 25, 2023 at 05:01:10PM -0800, Paul E. McKenney wrote:
> > > A few other oddities:
> > > 
> > > litmus/auto/C-LB-Lww+R-OC.litmus
> > > 
> > > 	Both versions flag a data race, which I am not seeing.	It appears
> > > 	to me that P1's store to u0 cannot happen unless P0's store
> > > 	has completed.  So what am I missing here?
> > 
> > The LKMM doesn't believe that a control or data dependency orders a 
> > plain write after a marked read.  Hence in this test it thinks that P1's 
> > store to u0 can happen before the load of x1.  I don't remember why we 
> > did it this way -- probably we just wanted to minimize the restrictions 
> > on when plain accesses can execute.  (I do remember the reason for 
> > making address dependencies induce order; it was so RCU would work.)
> > 
> 
> Because plain store can be optimzed as an "store only if not equal"?
> As the following sentenses in the explanations.txt:
> 
> 	The need to distinguish between r- and w-bounding raises yet another
> 	issue.  When the source code contains a plain store, the compiler is
> 	allowed to put plain loads of the same location into the object code.
> 	For example, given the source code:
> 
> 		x = 1;
> 
> 	the compiler is theoretically allowed to generate object code that
> 	looks like:
> 
> 		if (x != 1)
> 			x = 1;
> 
> 	thereby adding a load (and possibly replacing the store entirely).
> 	For this reason, whenever the LKMM requires a plain store to be
> 	w-pre-bounded or w-post-bounded by a marked access, it also requires
> 	the store to be r-pre-bounded or r-post-bounded, so as to handle cases
> 	where the compiler adds a load.

Good guess; maybe that was the reason.  Ironically, in this case the 
store _is_ r-pre-bounded, because there's an smp_rmb() in the litmus 
test just before it.  So perhaps the original reason is not valid now 
that the memory model explicitly includes tests for stores being 
r-pre/post-bounded.

Alan
