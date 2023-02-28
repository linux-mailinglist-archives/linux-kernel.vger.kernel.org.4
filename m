Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A906A5773
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjB1LEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjB1LEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:04:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A627497;
        Tue, 28 Feb 2023 03:04:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FCD2B80D58;
        Tue, 28 Feb 2023 11:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8F2C433D2;
        Tue, 28 Feb 2023 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677582280;
        bh=QpDfQ/zJp6kV7hVEF9bezQ5WIgwiAYm6JLVTuiilDXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PxIOIXNqhzXRLo2LGPqW2PgTig+cHJdmF6wthVXirQB1Eqc3HBvl+EPi3ZEWuHF4c
         n+/2/fOjEJCyXki6PSX4oeix71z8Y+eprCUXKH1YWqVmEwOeOpZtquIL038SEKnNvb
         Kt/CfrKVY9AoyIr1IkHjJZf4vvmVTUytMrMBCTSGwiDSRjl692CuiZFlK7Zw30TmXi
         vGkmvW+VOHeE0om/CPMJQrGNugdD1pU75Yi1ikm+ZWkjnjKH2J/cAxJlnEAqHPU0kZ
         UxbJwI49lXOUBMv8vxmQhuGVWnh0cXN92HinaChq0/HnYyp7WFFyBzzPsmNC7Wse0y
         YynmkKaKnSXiw==
Date:   Tue, 28 Feb 2023 12:04:36 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/3fxLXbfvnLFEZq@lothringen>
References: <Y/z0fHHYdxEXcWMT@pc636>
 <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636>
 <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
 <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/0/dnmIk508sidK@lothringen>
 <Y/1ZMXsNZtwYPJNW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/1ZMXsNZtwYPJNW@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 01:30:25AM +0000, Joel Fernandes wrote:
> On Tue, Feb 28, 2023 at 12:40:38AM +0100, Frederic Weisbecker wrote:
> > On Mon, Feb 27, 2023 at 03:05:02PM -0800, Paul E. McKenney wrote:
> > > On Mon, Feb 27, 2023 at 02:10:30PM -0500, Joel Fernandes wrote:
> > > 
> > > The combination of sysfs manipulated by userspace and a kernel failsafe
> > > makes sense to me.  Especially if by default triggering the failsafe
> > > splats.  That way, bugs where userspace fails to update the sysfs file
> > > get caught.
> > > 
> > > The non-default silent-failsafe mode is also useful to allow some power
> > > savings in advance of userspace getting the sysfs updating in place.
> > > And of course the default splatting setup can be used in internal testing
> > > with the release software being more tolerant of userspace foibles.
> > 
> > I'm wondering, this is all about CONFIG_RCU_LAZY, right? Or does also expedited
> > GP turned off a bit early or late on boot matter for anybody in practice?
> 
> Yes, if you provide 'rcu_normal_after_boot', then after the boot ends, it
> switches expedited GPs to normal ones.
> 
> It is the same issue for expedited, the kernel's version of what is 'boot' is
> much shorter than what is actually boot.
> 
> This is also the case with suspend/resume's rcu_pm_notify(). See the comment:
>   /*
>    * On non-huge systems, use expedited RCU grace periods to make suspend
>    * and hibernation run faster.
>    */
> 
> There also we turn on/off both lazy and expedited. I don't see why we
> shouldn't do it for boot.

Of course but I mean currently rcu_end_inkernel_boot() is called explicitly
before the kernel calls init. From that point on, what is the source of the
issue? Delaying lazy further would be enough or do we really need to delay
forcing expedited as well? Or is it the reverse: delaying expedited further
would matter and lazy doesn't play much role from there.

It matters to know because if delaying expedited further is enough, then indeed
we must delay the call to rcu_end_inkernel_boot() somehow. But if delaying
expedited further doesn't matter and delaying lazy matter then it's possible
that the issue is a callback that should be marked as call_rcu_hurry() and then
the source of the problem is much broader.

I think the confusion comes from the fact that your changelog doesn't state precisely
what the problem exactly is. Also do we need to wait for the kernel boot completion?
And if so what is missing from kernel boot after the current explicit call to
rcu_end_inkernel_boot()?

Or do we also need to wait for userspace to complete the boot? Different
problems, different solutions.

But in any case a countdown is not a way to go. Consider that rcu_lazy may
be used by a larger audience than just chromium in the long run. You can not
ask every admin to provide his own estimation per type of machine. You can't
either rely on a long default value because that may have bad impact on
workload assumptions launched right after boot.

> 
> > So shouldn't we disable lazy callbacks by default when CONFIG_RCU_LAZY=y and then
> > turn it on with "sysctl kernel.rcu.lazy=1" only whenever userspace feels ready
> > about it? We can still keep the current call to rcu_end_inkernel_boot().
> 
> Hmm IMHO that would add more knobs for not much reason honestly. We already
> have CONFIG_RCU_LAZY default disabled, I really don't want to add more
> dependency (like user enables the config and does not see laziness).

I don't know. Like I said, different problems, different solutions. Let's
identify what the issue is precisely. For example can we expect that the issues
on boot can be a problem also on some temporary workloads?

Besides I'm currently testing a very hacky flavour of rcu_lazy and so far it
shows many idle calls that would have been delayed if callbacks weren't queued
as lazy. I have yet to do actual energy and performance measurements but if it
happens to show improvements, I suspect distros will want a supported yet
default disabled Kconfig that can be turned on on boot or later. Of course we
are not there yet but things to keep in mind...

Thanks.
