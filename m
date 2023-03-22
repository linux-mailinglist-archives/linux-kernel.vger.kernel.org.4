Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3766C4718
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCVJ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCVJ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:57:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853452D4A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MepofSho9k8xeRbWNPZZ+b/oeW4EOWYNx1ZHow41Q0M=; b=geC7HoOO3D5XVXJb0Rh6Zky0OU
        QNkvKkUCvitUfjQqKXWXOGJLBmA7ykSXs0eCQUBE6RI/aAgQtxFOfjgWlkStF+UsqxXWrPhwZ2NUg
        IHFY3vr4dPniov2l8ydfRkJ4GSii0UxrJVEKmjwUCBF6vH/+8pSxEtUc4tsxkbUjJ3UrUwBSrgxXx
        0LfhSPJHDovHqAmUkdxmirY2t27Fi8Si8JxLBgBC+nCvDhWOJxocxBFOrWhJ5XiWvIONcsQQk17bb
        j1nWoSGUneLudThXMgw4cyj4azatXOSDAZJH+m+HaKXCwoVNflvFIwI22Dpp2b6uJeZhQT3x7AYu8
        42YcZ6Xw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pevDd-004Wy0-33;
        Wed, 22 Mar 2023 09:57:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B440300652;
        Wed, 22 Mar 2023 10:57:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E511D205414ED; Wed, 22 Mar 2023 10:57:19 +0100 (CET)
Date:   Wed, 22 Mar 2023 10:57:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, jgross@suse.com, mingo@kernel.org,
        corbet@lwn.net, vschneid@redhat.com
Subject: Re: [PATCH RFC smp] Remove diagnostics and adjust config for CSD
 lock diagnostics
Message-ID: <20230322095719.GT2017917@hirez.programming.kicks-ass.net>
References: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
 <20230321102220.GH2234901@hirez.programming.kicks-ass.net>
 <1b48795e-8ec7-4628-b926-38f21a024a9d@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b48795e-8ec7-4628-b926-38f21a024a9d@paulmck-laptop>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:38:50AM -0700, Paul E. McKenney wrote:
> On Tue, Mar 21, 2023 at 11:22:20AM +0100, Peter Zijlstra wrote:
> > On Mon, Mar 20, 2023 at 05:54:39PM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > This series removes CSD-lock diagnostics that were once very useful
> > > but which have not seen much action since.  It also adjusts Kconfig and
> > > kernel-boot-parameter setup.
> > > 
> > > 1.	locking/csd_lock: Add Kconfig option for csd_debug default.
> > > 
> > > 2.	locking/csd_lock: Remove added data from CSD lock debugging.
> > > 
> > > 3.	locking/csd_lock: Remove per-CPU data indirection from CSD
> > > 	lock debugging.
> > > 
> > > 4.	kernel/smp: Make csdlock_debug= resettable.
> > > 
> > > 						Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > >  Documentation/admin-guide/kernel-parameters.txt   |   17 -
> > >  b/Documentation/admin-guide/kernel-parameters.txt |    6 
> > >  b/kernel/smp.c                                    |    2 
> > >  b/lib/Kconfig.debug                               |    9 
> > >  kernel/smp.c                                      |  260 ++--------------------
> > >  5 files changed, 47 insertions(+), 247 deletions(-)
> > 
> > Yay!! How do you want to route these, should I take them through tip?
> 
> Either way works for me.  If you take them into -tip, I will drop them
> from -rcu.  If you don't take them into -tip, I will send Linus a pull
> request for the upcoming merge window.  And if you take them at just
> the wrong time, we will both send them to Linus.  ;-)
> 
> Your choice!

OK, since they conflict a wee bit with Valentin's IPI tracepoint stuff,
I'm probably going to take both these series, let me stomp on the
conflict and feed it to the robots to see how bad it all gets :-)

I'll let you know if/when i'll push them to -tip.
