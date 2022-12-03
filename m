Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792CA64177B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 16:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLCPUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 10:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLCPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 10:20:31 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EAB2520348
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 07:20:29 -0800 (PST)
Received: (qmail 562353 invoked by uid 1000); 3 Dec 2022 10:20:29 -0500
Date:   Sat, 3 Dec 2022 10:20:28 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <Y4tpPCWyt3zfQljk@rowland.harvard.edu>
References: <20221201121808.20785-1-jonas.oberhauser@huaweicloud.com>
 <Y4jQC9ejAQqJFTo+@rowland.harvard.edu>
 <6abbb72eef6149eb842a3351ecea7af5@huawei.com>
 <Y4kMskpQGOvlPyYf@rowland.harvard.edu>
 <4905c14d2bc547a391d626416a20a2e9@huawei.com>
 <Y4pec7lfQHwmH4V/@rowland.harvard.edu>
 <bcacee1a2ce84123a664d783d108050e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcacee1a2ce84123a664d783d108050e@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 11:47:06AM +0000, Jonas Oberhauser wrote:
> 
> 
> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> Sent: Friday, December 2, 2022 9:22 PM
> 
> > > void *y[2];
> > > void *x[2] = { (void*)&y[1], (void*)&y[0] };
> > > 
> > > P0() {
> > >     void **t = (void**)(x[0]);
> 
> > Now t holds a pointer to y[1].
> 
> Unfortunately, this kind of inductive reasoning (arguing about what happens based on what happened "before") is not possible with memory models that allow OOTA; as you put it, one must allow for loads reading from stores that haven't happened yet.
> One such store (I promise!(*)) is a store to x[0] which writes &x[1]. Let's consider the alternative universe where we read from this future store, so now t holds a pointer to x[1].
> 
> > >     *t = (void*)(t-1);
> 
> > And now y[1] holds a pointer to y[0].
> 
> In our alternative universe, x[1] now holds a pointer to x[0].
> 
> 
> > > }
> > > P1() {
> > >     void **u = (void**)(x[1]);	
> 
> > Now u holds a pointer to y[0].
> 
> In our alternative universe, u holds the pointer to x[0] stored by P0().
> 
> > >     *u = (void*)(u+1);
> 
> > And now y[0] holds a pointer to y[1].
> 
> In our alternative universe, now x[0] holds a pointer to x[1]. Behold, the store I promised would happen!
> 
> > > }
> 
> > The contents of x[] never get changed, so there's no question about the values of t and u.
> 
> They might get changed, by the stores *t=... and *u=...

Okay, now I understand.  Yes, this counts as an example of values 
appearing out of thin air, even though the values are constrained.  The 
same sort of thing can happen in a less exotic form, such as:

	P0		P1
	------		-----------
	x = y;		y = x & ~1;

Then in an OOTA execution, x and y can end up holding any _even_ value.  
Yes, constraining a value to be even is less drastic than constraining 
it to be &x[0] as in your example, but it's still a constraint.  One 
can easily extend this example in various directions.

Alan
