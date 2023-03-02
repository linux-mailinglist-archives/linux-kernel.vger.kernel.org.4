Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED66A787B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 01:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCBAth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 19:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCBAtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 19:49:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFDA4109C;
        Wed,  1 Mar 2023 16:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 224E8B81181;
        Thu,  2 Mar 2023 00:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FC9C4339C;
        Thu,  2 Mar 2023 00:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677718171;
        bh=ScTaIO2bmnGm7UFxZU1tGtirzKJTkwioWhjsQT4uvDc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uJ/u04YQXkqTeHnTtGT6A8EjiN24jAL36LC0u/tWul9Gi/GHYmLtJAjrFEtigVNlf
         M9WHjJkcsT2PZALaaHtXY00OD1QV/TAiRUtEXfmQj0PNRDiAxyfb78uwzszPU/KJtK
         w9UY79Oue/u3knBeQ82u12P/w29xc6kMEyrXZ5MoQBKdUPuZAPa6C+on/tZuFkAtSx
         /Dp9v1FIHo56Ik9wfZsSKJv9Pz82m1B5oU6QLGCmXBVfTgAroa/XaR+EkkVJ3pZbvc
         1T1p7PMZhRCQcM/vK4jrU9xHZpy59d4Z9TXhyjxo6MWrSlqNBMh18xmJcByIxoATaW
         5NzAJOHosJGgA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7374D5C0361; Wed,  1 Mar 2023 16:49:31 -0800 (PST)
Date:   Wed, 1 Mar 2023 16:49:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <20230302004931.GM2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636>
 <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
 <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/0/dnmIk508sidK@lothringen>
 <Y/1ZMXsNZtwYPJNW@google.com>
 <Y/3fxLXbfvnLFEZq@lothringen>
 <Y/5fXskgrQxzbt0U@google.com>
 <Y/+HPrU/ofFXapHM@lothringen>
 <CAEXW_YTt=VZ8ZMptccFMStsQvfjy5yMbd5Ah3KL=PUB4YVSTCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTt=VZ8ZMptccFMStsQvfjy5yMbd5Ah3KL=PUB4YVSTCg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 04:31:01PM -0500, Joel Fernandes wrote:
> On Wed, Mar 1, 2023 at 12:11 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> [...]
> > > Hmmm I see what you mean, so a conservative and configurable "fail-safe"
> > > timeout followed by sysctl to end the boot earlier than the timeout, should
> > > do it (something like 30 seconds IMHO sounds reasonable)? In any case,
> > > whatever way we go, we would not end the kernel boot before
> > > rcu_end_inkernel_boot() is called at least once (which is the current
> > > behavior).
> > >
> > > So it would be:
> > >
> > >   low level boot + initcalls
> > >        20 sec                         30 second timeout
> > > |------------------------------|--------------------------
> > >                                |                         |
> > >               old rcu_end_inkernel_boot()      new rcu_end_inkernel_boot()
> > >
> > > But it could be, if user decides:
> > >   low level boot + initcalls
> > >        20 sec                         10 second timeout
> > > |------------------------------|--------------------------
> > >                                |                         |
> > >               old rcu_end_inkernel_boot()      new rcu_end_inkernel_boot()
> > >                                                via /sys/ entry.
> >
> > The problem I have with a random default timeout is that it may break sensitive
> > workloads. If the default is 30 and say the boot only takes 5 seconds and
> > immediately launches a latency sensitive task, this may break things in a
> > subtle way during these 25 seconds when it usually didn't. Because expedited
> > RCU is a hammer interrupting all non-idle CPUs.
> >
> > Until now forcing expedited RCU was only performed before any user code. Now it
> > crosses the boundary so better be careful. I'd personally advocate for keeping
> > the current call before init is launched. Then provide an end_boot_sysctl kernel
> > boot parameter that will ignore the current call before init and let the user
> > signal that through sysctl.
> 
> Considering that the PREEMPT-RT system benefits from it within the 8
> seconds, I will go ahead make the default 15 seconds or so and make it
> tunable. Hopefully that will be an acceptable compromise, with
> sufficient documentation, changelog, and so forth... If you agree I'd
> appreciate your Ack on the next posting.

Just checking on the sysfs portion of this.  After all, tuning kernel
boot parameters to specific systems is not all that much fun, especially
when you have lots of systems.

							Thanx, Paul
