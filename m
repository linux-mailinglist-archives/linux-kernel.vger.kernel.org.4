Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5149D60BDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiJXWwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiJXWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF42320B55;
        Mon, 24 Oct 2022 14:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 638F461572;
        Mon, 24 Oct 2022 20:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACADC433C1;
        Mon, 24 Oct 2022 20:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666641886;
        bh=jizu7/ZumgplJo0/abAjfwvHnMiHdDjhuRmpuyRU9OY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Mk+8jPX+4Xxs7S4+YFMO6Tyb7aZ7p08D/+g+p63bWkfpUJnrwbBWU5Sql9/xQNr6U
         Wft++X2QuJpstY5N5eAeCIz1LKmbejIasdJCStp2O16dfGXSRdZXzny1qGBzRAE+6L
         Y1G4PxMrkmTmW7eV3jS92eKUGdQd21UWy1z7w3/LWqFOERlO3GXELbFEerTRfK1in1
         UE+q4KhIddlu9Zi8qKyWOEtlvWiWc3INrxzPBA+36nI/j50dEOl3GJ7du/mQj/3kVt
         BQQGuL61+LoubnfYhtEtuHjgdLxGWJPbMBO2b1A4ao1mjbL2k5SkdCYs1r/vaSWRpk
         j05wm1Hr36xoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 542D35C0DDA; Mon, 24 Oct 2022 13:04:46 -0700 (PDT)
Date:   Mon, 24 Oct 2022 13:04:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
Subject: Re: [GIT PULL] Keep synchronize_rcu() from enabling irqs in early
 boot
Message-ID: <20221024200446.GD5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221024165421.GA1246679@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wi1GXyh+kn1XfrbLA209MBGktteN=L+=cTEcoruxBtu3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1GXyh+kn1XfrbLA209MBGktteN=L+=cTEcoruxBtu3g@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 12:40:01PM -0700, Linus Torvalds wrote:
> On Mon, Oct 24, 2022 at 9:54 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > This pull request contains a commit that fixes bf95b2bc3e42 ("rcu: Switch
> > polled grace-period APIs to ->gp_seq_polled"), which could incorrectly
> > leave interrupts enabled after an early-boot call to synchronize_rcu().
> 
> Minor stylistic nit-pick - please try to keep the commit tags
> together, ie the "Fixes:" tags goes with Reported-by: tags and
> sign-offs etc..

Please accept my apologies for my confusion!

Please see below for a pull request for a better-formatted commit.

							Thanx, Paul

------------------------------------------------------------------------

This pull request fixes a merge-window regression noted by Steve Rostedt.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu-urgent.2022.10.24a

for you to fetch changes up to c216e5557395092a1a30ddb2be8ab924b0364585:

  rcu: Keep synchronize_rcu() from enabling irqs in early boot (2022-10-24 12:55:37 -0700)

----------------------------------------------------------------
Urgent RCU pull request for v6.1

This pull request contains a commit that fixes bf95b2bc3e42 ("rcu: Switch
polled grace-period APIs to ->gp_seq_polled"), which could incorrectly
leave interrupts enabled after an early-boot call to synchronize_rcu().
Such synchronize_rcu() calls must acquire leaf rcu_node locks in order to
properly interact with polled grace periods, but the code did not take
into account the possibility of synchronize_rcu() being invoked from
the portion of the boot sequence during which interrupts are disabled.
This commit therefore switches the lock acquisition and release from
irq to irqsave/irqrestore.

----------------------------------------------------------------
Paul E. McKenney (1):
      rcu: Keep synchronize_rcu() from enabling irqs in early boot

 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
