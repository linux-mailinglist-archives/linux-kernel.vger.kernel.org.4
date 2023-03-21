Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4536C35DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjCUPjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjCUPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:38:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7D2BEE0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E6AF61CEB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68318C433EF;
        Tue, 21 Mar 2023 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679413131;
        bh=Dih/f+sK5t9xwuuNfL9d5fK5xvkAJU6end11mS6FalI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dS1ceQ8jadc30uxHeKXt9YDbaL6DwxqutAV+UXfx7OB8tZ1Rf+rKELJmBVBdkPz2z
         rPoe4WkwFRArybQBIAqBtNdrAtKRjMrrZzERv53LLptGutUViCE/+pa1WyCB3OPwEX
         l7y167hL6PyHwYf340dq9zLci8loBKqxo4RFRc78TPNzsykB609fv/asjRIl9mgIJy
         WupVfj+zhBB+wG6X9Kq6SyvrjkeXZ1eVAfXrb21KXJdyWEqMEZebUD4zuKEmJX9Yre
         0J1uDEUZj/5Lw4MtmdiT0bnRKq//WA2fi8hFL/uhgotRK4SirVeS1UgqOyUTct1NIL
         G91BPgS3A11ZQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 01406154033A; Tue, 21 Mar 2023 08:38:50 -0700 (PDT)
Date:   Tue, 21 Mar 2023 08:38:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, jgross@suse.com, mingo@kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH RFC smp] Remove diagnostics and adjust config for CSD
 lock diagnostics
Message-ID: <1b48795e-8ec7-4628-b926-38f21a024a9d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
 <20230321102220.GH2234901@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321102220.GH2234901@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:22:20AM +0100, Peter Zijlstra wrote:
> On Mon, Mar 20, 2023 at 05:54:39PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series removes CSD-lock diagnostics that were once very useful
> > but which have not seen much action since.  It also adjusts Kconfig and
> > kernel-boot-parameter setup.
> > 
> > 1.	locking/csd_lock: Add Kconfig option for csd_debug default.
> > 
> > 2.	locking/csd_lock: Remove added data from CSD lock debugging.
> > 
> > 3.	locking/csd_lock: Remove per-CPU data indirection from CSD
> > 	lock debugging.
> > 
> > 4.	kernel/smp: Make csdlock_debug= resettable.
> > 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  Documentation/admin-guide/kernel-parameters.txt   |   17 -
> >  b/Documentation/admin-guide/kernel-parameters.txt |    6 
> >  b/kernel/smp.c                                    |    2 
> >  b/lib/Kconfig.debug                               |    9 
> >  kernel/smp.c                                      |  260 ++--------------------
> >  5 files changed, 47 insertions(+), 247 deletions(-)
> 
> Yay!! How do you want to route these, should I take them through tip?

Either way works for me.  If you take them into -tip, I will drop them
from -rcu.  If you don't take them into -tip, I will send Linus a pull
request for the upcoming merge window.  And if you take them at just
the wrong time, we will both send them to Linus.  ;-)

Your choice!

> What about the rest of the thing? Your commits seem to suggest it's
> still actually used -- why? Are there still more virt bugs?

Thus far, no luck.  I proposed ditching some of the stack traces, but
that got shot down.

These find the following issues:  (1) CPU looping with interrupts
disabled.  (2) CPU stuck in a longer-than-average SMI handler or other
firmware sand trap.  (3) CPU fail stopped.

In theory, we could drop the RCU CPU stall warning to five seconds and
catch this same stuff.  Unfortunately, in practice, there would need to
be lots of churn from CPUs looping with preemption disabled.  Which we
still get from time to time even at 21 seconds.

NMIs can be used to deal with #1, and the hard lockup detector in fact
sort of does this.  But these are not helpful for #2 and #3.

So nothing yet, but I am still looking for improved diagnostics.

							Thanx, Paul
