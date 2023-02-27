Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A7B6A4F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjB0XFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjB0XFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:05:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D9A248;
        Mon, 27 Feb 2023 15:05:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B321760F22;
        Mon, 27 Feb 2023 23:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106C0C433D2;
        Mon, 27 Feb 2023 23:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677539103;
        bh=VJ99xYjaKWs1HHH9MiQTFOkvkDQ34wqosQ/qAG7Fcxs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jlYmN/zwCa59Ygks5miVKi7ow98JlaWqeBCyTj4lP5vAT5Insd+F0m1SG4FnzlWjZ
         MamNRJc3up5N6LU7DmSxBBwbItCfSXhtnF+BmJ+tb4kBogBW7QDFO+c1r4PRDwxBuQ
         hsEY8z7xNL3bMjv+xHz994fFLLKtxku8KNb3e9jCs0Gawh9gdxHFRBh83xWVKZqy1/
         T3PPNvwYDSl5rOqY49IlnAJYP9drxfIyouVpTKhgPn7EJEVArz4qHThXfNPYFmSuMu
         Fo5itpmxUc/W8JVi/WuaxFcaVNgAF/SQTITUChLs+PLk9RArXb9qhJj/9EpqgSgLcV
         z8TGTHQDzKk5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A55C85C0267; Mon, 27 Feb 2023 15:05:02 -0800 (PST)
Date:   Mon, 27 Feb 2023 15:05:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y/z0fHHYdxEXcWMT@pc636>
 <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636>
 <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 02:10:30PM -0500, Joel Fernandes wrote:
> On Mon, Feb 27, 2023 at 1:57 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Mon, Feb 27, 2023 at 01:27:20PM -0500, Joel Fernandes wrote:
> > >
> > >
> > > > On Feb 27, 2023, at 1:20 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > ﻿On Mon, Feb 27, 2023 at 01:15:47PM -0500, Joel Fernandes wrote:
> > > >>
> > > >>
> > > >>>> On Feb 27, 2023, at 1:06 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >>>
> > > >>> ﻿On Mon, Feb 27, 2023 at 10:16:51AM -0500, Joel Fernandes wrote:
> > > >>>>> On Mon, Feb 27, 2023 at 9:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >>>>>
> > > >>>>> On Mon, Feb 27, 2023 at 08:22:06AM -0500, Joel Fernandes wrote:
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>> On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
> > > >>>>>>>
> > > >>>>>>> ﻿
> > > >>>>>>>>
> > > >>>>>>>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >>>>>>>> Sent: Saturday, February 25, 2023 11:34 AM
> > > >>>>>>>> To: linux-kernel@vger.kernel.org
> > > >>>>>>>> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic Weisbecker
> > > >>>>>>>> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>; linux-
> > > >>>>>>>> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
> > > >>>>>>>> rcu@vger.kernel.org
> > > >>>>>>>> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
> > > >>>>>>>> completed
> > > >>>>>>>>
> > > >>>>>>>> On many systems, a great deal of boot happens after the kernel thinks the
> > > >>>>>>>> boot has completed. It is difficult to determine if the system has really
> > > >>>>>>>> booted from the kernel side. Some features like lazy-RCU can risk slowing
> > > >>>>>>>> down boot time if, say, a callback has been added that the boot
> > > >>>>>>>> synchronously depends on.
> > > >>>>>>>>
> > > >>>>>>>> Further, it is better to boot systems which pass 'rcu_normal_after_boot' to
> > > >>>>>>>> stay expedited for as long as the system is still booting.
> > > >>>>>>>>
> > > >>>>>>>> For these reasons, this commit adds a config option
> > > >>>>>>>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
> > > >>>>>>>> rcupdate.boot_end_delay.
> > > >>>>>>>>
> > > >>>>>>>> By default, this value is 20s. A system designer can choose to specify a value
> > > >>>>>>>> here to keep RCU from marking boot completion.  The boot sequence will not
> > > >>>>>>>> be marked ended until at least boot_end_delay milliseconds have passed.
> > > >>>>>>>
> > > >>>>>>> Hi Joel,
> > > >>>>>>>
> > > >>>>>>> Just some thoughts on the default value of 20s, correct me if I'm wrong :-).
> > > >>>>>>>
> > > >>>>>>> Does the OS with CONFIG_PREEMPT_RT=y kernel concern more about the
> > > >>>>>>> real-time latency than the overall OS boot time?
> > > >>>>>>
> > > >>>>>> But every system has to boot, even an RT system.
> > > >>>>>>
> > > >>>>>>>
> > > >>>>>>> If so, we might make rcupdate.boot_end_delay = 0 as the default value
> > > >>>>>>> (NOT the default 20s) for CONFIG_PREEMPT_RT=y kernels?
> > > >>>>>>
> > > >>>>>> Could you measure how much time your RT system takes to boot before the application runs?
> > > >>>>>>
> > > >>>>>> I can change it to default 0 essentially NOOPing it, but I would rather have a saner default (10 seconds even), than having someone forget to tune this for their system.
> > > >>>>>
> > > >>>>> Provide a /sys location that the userspace code writes to when it
> > > >>>>> is ready?  Different systems with different hardware and software
> > > >>>>> configurations are going to take different amounts of time to boot,
> > > >>>>> correct?
> > > >>>>
> > > >>>> I could add a sysfs node, but I still wanted this patch as well
> > > >>>> because I am wary of systems where yet more userspace changes are
> > > >>>> required. I feel the kernel should itself be able to do this. Yes, it
> > > >>>> is possible the system completes "booting" at a different time than
> > > >>>> what the kernel thinks. But it does that anyway (even without this
> > > >>>> patch), so I am not seeing a good reason to not do this in the kernel.
> > > >>>> It is also only a minimum cap, so if the in-kernel boot takes too
> > > >>>> long, then the patch will have no effect.
> > > >>>>
> > > >>>> Thoughts?
> > > >>>>
> > > >>> Why "rcu_boot_ended" is not enough? As i see right after that an "init"
> > > >>> process or shell or panic is going to be invoked by the kernel. It basically
> > > >>> indicates that a kernel is fully functional.
> > > >>>
> > > >>> Or an idea to wait even further? Until all kernel modules are loaded by
> > > >>> user space.
> > > >>
> > > >> I mentioned in commit message it is daemons, userspace initialization etc. There is a lot of userspace booting up as well and using the kernel while doing so.
> > > >>
> > > >> So, It does not make sense to me to mark kernel as booted too early. And no harm in adding some builtin kernel hysteresis. What am I missing?
> > > >>
> > > > Than it is up to user space to decide when it is ready in terms of "boot completed".
> > >
> > > I dont know if you caught up with the other threads. See replies from Paul and my reply to that.
> > >
> > > Also what you are proposing can be more harmful. If user space has a bug and does not notify the kernel that boot completed, then the boot can stay incomplete forever. The idea with this patch is to make things better, not worse.
> > >
> > I saw that Paul proposed to have a sysfs attribute using which you can
> > send a notification.
> 
> Maybe I am missing something but how will a sysfs node on its own work really?
> 
> 1. delete kernel marking itself boot completed  -- and then sysfs
> marks it completed?
> 
> 2. delete kernel marking itself boot completed  -- and then sysfs
> marks it completed, if sysfs does not come in in N seconds, then
> kernel marks as completed?
> 
> #1 is a no go, that just means a bug waiting to happen if userspace
> forgets to write to sysfs.
> 
> #2 is just an extension of this patch. So I can add a sysfs node on
> top of this. And we can make the minimum time as a long period of
> time, as you noted below:
> 
> > IMHO, to me this patch does not provide a clear correlation between what
> > is a boot complete and when it occurs. A boot complete is a synchronous
> > event whereas the patch thinks that after some interval a "boot" is completed.
> 
> But that is exactly how the kernel code is now without this patch, so
> it is already broken in that sense, I am not really breaking it more
> ;-)
> 
> > We can imply that after, say 100 seconds an initialization of user space
> > is done. Maybe 100 seconds then? :)
> 
> Yes I am Ok with that. So are you suggesting we change the default to
> 100 seconds and then add a sysfs node to mark as boot done whenever
> userspace notifies?

The combination of sysfs manipulated by userspace and a kernel failsafe
makes sense to me.  Especially if by default triggering the failsafe
splats.  That way, bugs where userspace fails to update the sysfs file
get caught.

The non-default silent-failsafe mode is also useful to allow some power
savings in advance of userspace getting the sysfs updating in place.
And of course the default splatting setup can be used in internal testing
with the release software being more tolerant of userspace foibles.

							Thanx, Paul
