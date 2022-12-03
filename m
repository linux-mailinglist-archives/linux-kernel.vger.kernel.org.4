Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F7064193D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 22:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiLCVcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 16:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLCVcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 16:32:21 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BF8591B9E2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 13:32:19 -0800 (PST)
Received: (qmail 570052 invoked by uid 1000); 3 Dec 2022 16:32:19 -0500
Date:   Sat, 3 Dec 2022 16:32:19 -0500
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
Subject: Re: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 12:44:05PM -0800, Paul E. McKenney wrote:
> On Sat, Dec 03, 2022 at 03:34:20PM -0500, stern@rowland.harvard.edu wrote:
> > On Sat, Dec 03, 2022 at 11:02:26AM -0800, Paul E. McKenney wrote:
> > > On Sat, Dec 03, 2022 at 11:58:36AM +0000, Jonas Oberhauser wrote:
> > > > 
> > > > 
> > > > -----Original Message-----
> > > > From: Boqun Feng [mailto:boqun.feng@gmail.com] 
> > > > Sent: Friday, December 2, 2022 7:50 PM
> > > 
> > > > > I wonder is this patch a first step to solve the OOTA problem you reported in OSS:
> > > > >	https://static.sched.com/hosted_files/osseu2022/e1/oss-eu22-jonas.pdf
> > > > > If so maybe it's better to put the link in the commit log I think.
> > > > 
> > > > It's not directly related to that specific problem, it does solve some other OOTA issues though.
> > > > If you think we should link to the talk, there's also a video with slightly more updated slides from the actual talk: https://www.youtube.com/watch?v=iFDKhIxKhoQ
> > > > do you think I should link to both then?
> > > 
> > > It is not hard for me to add that in if people believe that it should be
> > > included.  But default is lazy in this case.  ;-)
> > 
> > I don't think there's any need to mention that video in the commit log.  
> > It's an introductory talk, and it's pretty safe to assume that anyone 
> > reading the commit because they are interested in the LKMM in great 
> > detail is already beyond the introductory level.
> > 
> > On the other hand, it wouldn't hurt to include a Link: tag to an 
> > appropriate message in this email thread.  (I leave it up to Paul to 
> > decide which message is most "appropriate" -- there may not be a good 
> > candidate, because a lot of the messages were not CC'ed to LKML.)
> 
> For this approach, I would add this:
> 
> Link: https://lore.kernel.org/all/4262e55407294a5989e766bc4dc48293@huawei.com/

There's no point including that link; it merely points to messages 
containing or commenting on early versions of the commit.  It adds very 
little information not already present in the commit itself.  (Have you 
read any of Linus's criticisms of the Link: tags that people tend to 
include in patches they send him?  It's the same principle.)

I was thinking of the discussion which led up to the commit being 
written, where Jonas first brought up the idea that plain accesses 
should be able to carry dependencies just like accesses to registers.  
That's the sort of thing which would give readers some context and 
understanding of the reasoning behind the commit.  They were part of the 
thread with the subject "RE: Interesting LKMM litmus test".

But I can't find those messages on lore.kernel.org (which isn't 
surprising, as they weren't CC'ed to any mailing lists).

> I could of course do both the extra paragraph -and- the Link:.  ;-)
> 
> Thoughts?

My advice: Omit them both.

Alan
