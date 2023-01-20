Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5E675A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjATQeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjATQeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:34:08 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0D0486C124
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:33:38 -0800 (PST)
Received: (qmail 38719 invoked by uid 1000); 20 Jan 2023 11:32:04 -0500
Date:   Fri, 20 Jan 2023 11:32:04 -0500
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
Message-ID: <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
 <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
 <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
 <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
 <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:12:50PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/19/2023 9:06 PM, Alan Stern wrote:
> > That's backward logic.  Being strong isn't the reason the fences are
> > A-cumulative.  Indeed, the model could have been written not to assume
> > that strong fences are A-cumulative.
> 
> It's not just the model, it's also how strong fences are introduced in the
> documentation.

The documentation can be updated.

> I agree though that you could decouple the notion of strong from
> A-cumulativity.
> But would anyone want a strong fence that is not A-cumulative?

Why would anyone want a weak fence that isn't A-cumulative?  :-)
Architecture designers sometimes do strange things...

> It's a bit like asking in C11 for a barrier that has the sequential
> consistency guarantee of appearing in the global order S, but doesn't have
> release or acquire semantics. Yes you could define that, but would it really
> make sense?

You're still missing the point.  The important aspect of the fences in 
cumul-fence is that they are A-cumulative, not whether they are strong.
You're fixating on an irrelevancy.


> > This may be so, but I would like to point out that the memory model was
> > not particularly designed to be as short or as simple as possible, but
> > more to reflect transparently the intuitions that kernel programmers
> > have about the ways ordering should work in the kernel.  It may very
> > well include redundancies as a result.  I don't think that's a bad
> > point.
> 
> I agree that sometimes redundancies have value. But I think having, where
> possible, a kind of minimal responsibility principle where each fence
> appears in as few relations as possible also has value.
> I've seen that when I try to help people in my team learn to use LKMM: they
> see a specific type of fence and get stuck for a while chasing one of its
> uses. For example, they may chase a long prop link using the only strong
> fence in the example somewhere in the middle, which will then later turn out
> to be a dead-end because what they need to use is pb.

People who make that particular mistake should take a lesson from it: 
The presence of a strong fence should point them toward looking for an 
application of pb before looking at prop, because pb is is based on the 
special properties of strong fences whereas prop is not.

> For someone who doesn't know that we never need to rely on that use to get
> ordering, it basically doubles the amount of time spent looking at the graph
> and chasing definitions. And for very good reasons there already are alot of
> definitions even when redundancies are eliminated.

IMO, people who try to use the memory model this way need to develop a 
good understanding of it first.  (Although perhaps carrying out these 
sorts of exercises is _how_ people develop their understanding...)  I 
don't regard it as a bad thing that by making a mistake through pursuing 
a redundant pathway, people can deepen their understanding.  That's how 
one learns.

> Perhaps I would say that including these redundancies is good for
> understanding why the formalization makes sense, but excluding them is
> better for actually using the formalization.
> This includes both when looking at code while having a printout of the model
> next to you, but also when trying to reason about LKMM itself (e.g., what
> one might do when changes are made to LKMM and one wants to check that they
> interact well with the existing parts of LKMM).

Not necessarily so.  You might _want_ a change to affect one of the 
redundant paths but not the other.

> I think in the long term, increasing the usability is more important than
> the obvious correctness. But maybe I'm biased because I'm mostly on the user
> side of LKMM :D

No doubt I'm guilty of having my own set of biases...

Alan
