Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86D8636999
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbiKWTJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbiKWTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:09:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729AA15FF9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:09:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB6761E7A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BCBC433D6;
        Wed, 23 Nov 2022 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669230573;
        bh=o42jQD+pzz1xrbhi8yTGK7QhmQbDhrj4jQEn1JaXlIc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LRxvZcZ6h7xMSLNcW4RoAm9ut3VGgMgmGRMKyiN7TKcvdytRl+2CvGKHk1Mm1Qwx9
         zKP7zhtTNucNcFVMfHHwntYta0dpHjdaWOOubexK/VWJNksaUCVZG3Wcj+M7tN/MXy
         oIgtYpUgjUW1RQoqnN8SHZ2Zwt+ccP3MOPvxsLb61kXi8+eF7SoWiB18v1PTxPMpG5
         GpAPVAWLwqn0JAPKan7a8aM6p+9nMWzNEBg5uYG2f8RA3u5tgZVi6h/nPJMdMsrAwP
         WFShHUbz7nMYL2Wpvs53C1/lIB9m9oaZfjSKeuX0KC6pd4JgYW4kfjeRnC7bikb9pz
         D3QnnRSdNNVYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F0FA75C0E97; Wed, 23 Nov 2022 11:09:32 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:09:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        "phillip.lougher@gmail.com" <phillip.lougher@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Message-ID: <20221123190932.GF4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221118155534.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <dd430080-774b-1cba-1758-2bf92cb1acac@alu.unizg.hr>
 <20221120175016.GC4001@paulmck-ThinkPad-P17-Gen-1>
 <8e62a31f-3ef8-71ec-6181-2afa56eeb5db@alu.unizg.hr>
 <20221120192150.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <8c9eb87b-5623-730a-5cf6-72d831ef797a@alu.unizg.hr>
 <20221122020734.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <e8f5b9b3-383a-c267-9ee3-f1e0da5466fc@alu.unizg.hr>
 <20221123144415.GX4001@paulmck-ThinkPad-P17-Gen-1>
 <MW5PR84MB1842135518BD1D119E26EDCDAB0C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB1842135518BD1D119E26EDCDAB0C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 04:08:03PM +0000, Elliott, Robert (Servers) wrote:
> > -----Original Message-----
> > From: Paul E. McKenney <paulmck@kernel.org>
> > Sent: Wednesday, November 23, 2022 8:44 AM
> > Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls
> > in squashfs_readahead())
> > 
> > On Wed, Nov 23, 2022 at 10:14:07AM +0100, Mirsad Goran Todorovac wrote:
> ...
> 
> > > commit 1045a06724f322ed61f1ffb994427c7bdbe64647
> > > Author: Christoph Hellwig <hch@lst.de>
> > > Date:   Wed Jun 29 17:01:02 2022 +0200
> > >
> > >     remove CONFIG_ANDROID
> > 
> > But your CONFIG_RCU_EXP_CPU_STALL_TIMEOUT seems to be about 20.
> > As in 20 milliseconds.
> > 
> > Is that intentional?
> ...
> > > > And one approach is to take a less aggressive RCU CPU stall timeout,
> > > > say reducing from 21 seconds to (say) 15 seconds instead of all the
> > > > way down to 20 milliseconds.  This could allow you to ease into the
> > > > latency-reduction work.
> > > >
> > > > Alternatively, consider that response time is a property of the
> > > > entire system plus the environment that it runs in.  So I suspect that
> > > > the Android folks are accompanying that 20-millisecond timeout with
> > > > some restrictions on what the on-phone workloads are permitted to do.
> > > > Maybe ask the Android guys what those restrictions are and loosen them
> > > > slightly, again allowing you to ease into the latency-reduction work.
> 
> Since there is no longer a kernel default of 20 ms for Android since
> commit 1045a06724f3 ("remove CONFIG_ANDROID"), it might be appropriate
> to drop that from stallwarn.rst. Something like:

Fair point, except that the Android guys asked for this.  In fact, the
Android guys supplied the patches.  I like the traceability.

> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index e38c587067fc..d86a8b47504f 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -168,10 +168,11 @@ CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
>         Same as the CONFIG_RCU_CPU_STALL_TIMEOUT parameter but only for
>         the expedited grace period. This parameter defines the period
>         of time that RCU will wait from the beginning of an expedited
> -       grace period until it issues an RCU CPU stall warning. This time
> -       period is normally 20 milliseconds on Android devices.  A zero
> -       value causes the CONFIG_RCU_CPU_STALL_TIMEOUT value to be used,
> -       after conversion to milliseconds.
> +       grace period until it issues an RCU CPU stall warning.
> +
> +       A zero value causes the CONFIG_RCU_CPU_STALL_TIMEOUT value to be
> +        used, after conversion to milliseconds, limited to a maximum of
> +        21 seconds.
> 
>         This configuration parameter may be changed at runtime via the
>         /sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout, however
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 1b0c41d490f0..4477eeb8a54f 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -93,7 +93,7 @@ config RCU_EXP_CPU_STALL_TIMEOUT
>           If the RCU grace period persists, additional CPU stall warnings
>           are printed at more widely spaced intervals.  A value of zero
>           says to use the RCU_CPU_STALL_TIMEOUT value converted from
> -         seconds to milliseconds.
> +         seconds to milliseconds, limited to a maximum of 21 seconds.
> 
> > > > But please keep in mind that cond_resched() helps only in kernels
> > > > built with CONFIG_PREEMPTION=n.
> 
> I think they also help with
> 	CONFIG_PREEMPT_VOLUNTARY=y
> which is used by Fedora and RHEL. For example, adding more of those in
> the crypto tcrypt test module eliminated some RCU stalls when running
> speed tests (that send lots of data through the algorithms).
> 
> > > I have bad news that 6.1-r6 is still affected with
> > > squashfs_xz_uncompress bug, despite having both of your fixes
> > > (as visible in above command's output -- double checked):
> > >
> > > [   91.065659] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 3-.... } 6 jiffies s: 621 root: 0x8/.
> > 
> > If you build with (say) CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=200, does
> > this still happen?
> 
> BTW, you don't need to rebuild the kernel to change those parameters; they're
> module parameters, so can be modified on the kernel command line (if needed
> during boot) and sysfs (if only needed after boot).
> 
> For sysfs the syntax is:
> #!/bin/bash
> # set rcu timeouts to specified values
> echo 60 > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
> echo 21000 > /sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout
> echo 600000 > /sys/module/rcupdate/parameters/rcu_task_stall_timeout
> grep -Hs . /sys/module/rcupdate/parameters/rcu_*_timeout

Excellent point, thank you!

I hope that this makes Mirsad's life easier, perhaps featuring less time
waiting for kernel builds and reboots.  ;-)

							Thanx, Paul
