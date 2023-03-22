Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBCB6C4E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjCVOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjCVOso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:48:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF8A66D32
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1BA56216E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332E7C433EF;
        Wed, 22 Mar 2023 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496417;
        bh=HSy7BUgXmmW5l/rd71lUZKoxOtkcUeLHYdijdlSP6JE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qzvzqkvkW4nJAZk/6+uJ9Upm7H3gkxIrQKgyRGA4GVan6u15aeXrQ13A/27N7rQjz
         rss0GRX/c4WZp9tWpJeMPWzMN9c8/qOueZjwZeigu/b2oTbtVWnHgfD2Gz231BKGDR
         M5M9RPIXH4y8L1Vns7nY3iwRbHoNPAsJLAvi/wiff8JwPmccnozjYoZuDc6RHldMjg
         Loixe8pSxIqjl1cMTVbhnLVkEkd/2JlZcUB31eHvM606cadYfAALW54Xp+n1H9pcGV
         NfXVuhFy7jrjs8QWikkBKABu7ppuSDkBINo2iFt+67bilPuXhbV72wzUJ0nCdfW737
         WoctQVzZ/XH9w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DC6A5154033A; Wed, 22 Mar 2023 07:46:56 -0700 (PDT)
Date:   Wed, 22 Mar 2023 07:46:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, jgross@suse.com, mingo@kernel.org,
        corbet@lwn.net, vschneid@redhat.com
Subject: Re: [PATCH RFC smp] Remove diagnostics and adjust config for CSD
 lock diagnostics
Message-ID: <5b93d526-a784-42d3-92a6-bd4b8feefa80@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
 <20230321102220.GH2234901@hirez.programming.kicks-ass.net>
 <1b48795e-8ec7-4628-b926-38f21a024a9d@paulmck-laptop>
 <20230322095719.GT2017917@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322095719.GT2017917@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 10:57:19AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 21, 2023 at 08:38:50AM -0700, Paul E. McKenney wrote:
> > On Tue, Mar 21, 2023 at 11:22:20AM +0100, Peter Zijlstra wrote:
> > > On Mon, Mar 20, 2023 at 05:54:39PM -0700, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > This series removes CSD-lock diagnostics that were once very useful
> > > > but which have not seen much action since.  It also adjusts Kconfig and
> > > > kernel-boot-parameter setup.
> > > > 
> > > > 1.	locking/csd_lock: Add Kconfig option for csd_debug default.
> > > > 
> > > > 2.	locking/csd_lock: Remove added data from CSD lock debugging.
> > > > 
> > > > 3.	locking/csd_lock: Remove per-CPU data indirection from CSD
> > > > 	lock debugging.
> > > > 
> > > > 4.	kernel/smp: Make csdlock_debug= resettable.
> > > > 
> > > > 						Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > >  Documentation/admin-guide/kernel-parameters.txt   |   17 -
> > > >  b/Documentation/admin-guide/kernel-parameters.txt |    6 
> > > >  b/kernel/smp.c                                    |    2 
> > > >  b/lib/Kconfig.debug                               |    9 
> > > >  kernel/smp.c                                      |  260 ++--------------------
> > > >  5 files changed, 47 insertions(+), 247 deletions(-)
> > > 
> > > Yay!! How do you want to route these, should I take them through tip?
> > 
> > Either way works for me.  If you take them into -tip, I will drop them
> > from -rcu.  If you don't take them into -tip, I will send Linus a pull
> > request for the upcoming merge window.  And if you take them at just
> > the wrong time, we will both send them to Linus.  ;-)
> > 
> > Your choice!
> 
> OK, since they conflict a wee bit with Valentin's IPI tracepoint stuff,
> I'm probably going to take both these series, let me stomp on the
> conflict and feed it to the robots to see how bad it all gets :-)
> 
> I'll let you know if/when i'll push them to -tip.

Works for me!  I will keep them in the meantime, until told otherwise
by tip-bot.

							Thanx, Paul
