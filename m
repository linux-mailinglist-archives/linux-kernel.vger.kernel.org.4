Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0BF5F6DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiJFSzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJFSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025DDC695E;
        Thu,  6 Oct 2022 11:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30AB161A59;
        Thu,  6 Oct 2022 18:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DD8C433D6;
        Thu,  6 Oct 2022 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665082543;
        bh=tmTicypHL4AJTDy+gvYmq3jzH0FcSXkyP/2IndtLrxU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iqDcM69oSm5yw1ZMskQj4T6lycuKNjpR+eoIF6iiF+J+2525f6mfvvlYVc1KGWTad
         clEpCM2PyVnzNuvviF5/4HItBeAC6iUVyXXjiDus6MfmHBqHn5jtwd3eiBHu4m2NzP
         N47wUUZ2dp1pggCNroTsjUrYWhSTrdqqVXmP26iHRf5G91udC/0IRbwWKYP5vxkUD6
         kAYAC9YfMb/U0VcppwZbhzSAoqstt+u5Df0AdFMA5J7DFPdA4EQLX6ApZofR8lpC2c
         3wDF568vSz145sUv8BH4yeFfkGcyypK/i0WgkbstG95RWbDPHcmLT54gi52FFD7cE2
         2M7dbTBsSQagg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0CB035C0F66; Thu,  6 Oct 2022 11:55:43 -0700 (PDT)
Date:   Thu, 6 Oct 2022 11:55:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 00/11] rcu: call_rcu() power improvements
Message-ID: <20221006185543.GB4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221004024157.2470238-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:41:46AM +0000, Joel Fernandes (Google) wrote:
> v7 version of RCU lazy patches based on rcu/next branch.
> 
> To facilitate easier merge, I dropped tracing and other patches and just
> implemented the new changes. I will post the tracing patches later along with
> rcutop as I need to add new tracepoints that Frederic suggested.
> 
> Main recent changes:
> 1. rcu_barrier() wake up only for lazy bypass list.
> 2. Make all call_rcu() default-lazy and add call_rcu_flush() API.
> 3. Take care of some callers using call_rcu_flush() API.
> 4. Several refactorings suggested by Paul/Frederic.
> 5. New call_rcu() to call_rcu_flush() conversions by Joel/Vlad/Paul.
> 
> I am seeing good performance and power with these patches on real ChromeOS x86
> asymmetric hardware.
> 
> Earlier cover letter with lots of details is here:
> https://lore.kernel.org/all/20220901221720.1105021-1-joel@joelfernandes.org/
> 
> List of recent changes:
>     
>     [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
>       deferral levels wake much earlier so for those it is not needed. ]
>     
>     [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
>     
>     [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty. ]
>     
>     [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypass(). ]
>     
>     [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
>     
>     [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up. ]
>     
>     [ Paul/Frederic : Cosmetic changes, split out wakeup of nocb thread. ]
>     
>     [ Vlad/Joel : More call_rcu -> flush conversions ]

Thank you for your continued work on this!

I pulled these into an experimental branch, applied Uladzislau's
Tested-by and ran a quick round of rcutorture.

From TREE02, TREE03, and TREE09 I got this:

In file included from kernel/rcu/tree.c:68:
kernel/rcu/tree.h:449:13: error: ‘wake_nocb_gp’ used but never defined [-Werror]
  449 | static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
      |             ^~~~~~~~~~~~

One could argue that this is not a big deal, except that Linus gets a
bit tetchy when this sort of thing shows up in mainline.

Nevetheless, it looks like we might be getting quite close!

							Thanx, Paul

> Frederic Weisbecker (1):
> rcu: Wake up nocb gp thread on rcu_barrier_entrain()
> 
> Joel Fernandes (Google) (7):
> rcu: Make call_rcu() lazy to save power
> rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
> rcuscale: Add laziness and kfree tests
> percpu-refcount: Use call_rcu_flush() for atomic switch
> rcu/sync: Use call_rcu_flush() instead of call_rcu
> rcu/rcuscale: Use call_rcu_flush() for async reader test
> rcu/rcutorture: Use call_rcu_flush() where needed
> 
> Uladzislau Rezki (2):
> scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
> workqueue: Make queue_rcu_work() use call_rcu_flush()
> 
> Vineeth Pillai (1):
> rcu: shrinker for lazy rcu
> 
> drivers/scsi/scsi_error.c |   2 +-
> include/linux/rcupdate.h  |   7 ++
> kernel/rcu/Kconfig        |   8 ++
> kernel/rcu/rcu.h          |   8 ++
> kernel/rcu/rcuscale.c     |  67 +++++++++++-
> kernel/rcu/rcutorture.c   |  16 +--
> kernel/rcu/sync.c         |   2 +-
> kernel/rcu/tiny.c         |   2 +-
> kernel/rcu/tree.c         | 140 +++++++++++++++++--------
> kernel/rcu/tree.h         |  12 ++-
> kernel/rcu/tree_exp.h     |   2 +-
> kernel/rcu/tree_nocb.h    | 213 ++++++++++++++++++++++++++++++++------
> kernel/workqueue.c        |   2 +-
> lib/percpu-refcount.c     |   3 +-
> 14 files changed, 388 insertions(+), 96 deletions(-)
> 
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
