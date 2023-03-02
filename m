Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C526E6A78CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCBBTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCBBTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:19:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FE11B556;
        Wed,  1 Mar 2023 17:19:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 248E5CE1EC1;
        Thu,  2 Mar 2023 01:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D300C433D2;
        Thu,  2 Mar 2023 01:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677719949;
        bh=Snf1tIKNo7waT6gubhhft5f41e+dfcAwpZjlx/Je1gI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NVKW1KCfRbeCa5llS4njOUhIi03APJXhT6CuSBQ+Yr+EFaFx28bVFElLoNjbDbyRG
         hjL9SEcEszgpwypYpTNDlhndeL0/pMjmBB0duceqhTRvwCEV+VvE7Qp6AlBFhF9MKg
         JoFUuFqv2NzMwZFjvJ+y6Cn8M2N4eo/txNf2wUf9LIMY5U66Dur9iPeJzpyWaPVGP4
         SI0MprNiSmDsmOR7rgPcDAP1lm+V4J2EOUVRpCZLdCdDggDzM92WowIoLAlNlrt1wp
         9ZEYtIjSsKEGT/vTlVjWBKSUVFQIvyywZqpdJhHXUWuOp81wRAfi9BTXLi324ADfNQ
         NBFDyBkDjPq8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AA66A5C0361; Wed,  1 Mar 2023 17:19:08 -0800 (PST)
Date:   Wed, 1 Mar 2023 17:19:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <20230302011908.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
 <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/0/dnmIk508sidK@lothringen>
 <Y/1ZMXsNZtwYPJNW@google.com>
 <Y/3fxLXbfvnLFEZq@lothringen>
 <Y/5fXskgrQxzbt0U@google.com>
 <Y/+HPrU/ofFXapHM@lothringen>
 <CAEXW_YTt=VZ8ZMptccFMStsQvfjy5yMbd5Ah3KL=PUB4YVSTCg@mail.gmail.com>
 <20230302004931.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YRwNT02Z7e1NVd5eCknwtGfS98cViMGjuvp7zFNgu8pxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRwNT02Z7e1NVd5eCknwtGfS98cViMGjuvp7zFNgu8pxg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 08:08:54PM -0500, Joel Fernandes wrote:
> On Wed, Mar 1, 2023 at 7:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Mar 01, 2023 at 04:31:01PM -0500, Joel Fernandes wrote:
> > > On Wed, Mar 1, 2023 at 12:11 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > [...]
> > > > > Hmmm I see what you mean, so a conservative and configurable "fail-safe"
> > > > > timeout followed by sysctl to end the boot earlier than the timeout, should
> > > > > do it (something like 30 seconds IMHO sounds reasonable)? In any case,
> > > > > whatever way we go, we would not end the kernel boot before
> > > > > rcu_end_inkernel_boot() is called at least once (which is the current
> > > > > behavior).
> > > > >
> > > > > So it would be:
> > > > >
> > > > >   low level boot + initcalls
> > > > >        20 sec                         30 second timeout
> > > > > |------------------------------|--------------------------
> > > > >                                |                         |
> > > > >               old rcu_end_inkernel_boot()      new rcu_end_inkernel_boot()
> > > > >
> > > > > But it could be, if user decides:
> > > > >   low level boot + initcalls
> > > > >        20 sec                         10 second timeout
> > > > > |------------------------------|--------------------------
> > > > >                                |                         |
> > > > >               old rcu_end_inkernel_boot()      new rcu_end_inkernel_boot()
> > > > >                                                via /sys/ entry.
> > > >
> > > > The problem I have with a random default timeout is that it may break sensitive
> > > > workloads. If the default is 30 and say the boot only takes 5 seconds and
> > > > immediately launches a latency sensitive task, this may break things in a
> > > > subtle way during these 25 seconds when it usually didn't. Because expedited
> > > > RCU is a hammer interrupting all non-idle CPUs.
> > > >
> > > > Until now forcing expedited RCU was only performed before any user code. Now it
> > > > crosses the boundary so better be careful. I'd personally advocate for keeping
> > > > the current call before init is launched. Then provide an end_boot_sysctl kernel
> > > > boot parameter that will ignore the current call before init and let the user
> > > > signal that through sysctl.
> > >
> > > Considering that the PREEMPT-RT system benefits from it within the 8
> > > seconds, I will go ahead make the default 15 seconds or so and make it
> > > tunable. Hopefully that will be an acceptable compromise, with
> > > sufficient documentation, changelog, and so forth... If you agree I'd
> > > appreciate your Ack on the next posting.
> >
> > Just checking on the sysfs portion of this.
> 
> Yes, the current plan is to add a sysfs node (likely sysctl) with the
> 15-second failsafe.

Whew!!!  Very good, then!

> > After all, tuning kernel
> > boot parameters to specific systems is not all that much fun, especially
> > when you have lots of systems.
> 
> Are you suggesting to drop "end the boot" sysfs and just have a
> minimum-time approach as I initially did?

Not at all.  I was just concerned that the sysfs was getting lost in
the shuffle.

All good now, thank you!

							Thanx, Paul
