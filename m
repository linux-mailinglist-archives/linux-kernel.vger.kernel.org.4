Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305F26A71DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCARLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCARLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:11:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550A639CDC;
        Wed,  1 Mar 2023 09:11:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E696E6131D;
        Wed,  1 Mar 2023 17:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0160EC433D2;
        Wed,  1 Mar 2023 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677690689;
        bh=PH/epbOMVisSzzrM7zukqcL0LJjEZPVuHTbngJa+R2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fE5hykG7gUZjXoWdrr16RJE0QLTUswgRknNW1D+poxFcAItPhRKH933W8F0e3bO6j
         Wus9cHXgwQqizGQiDghC+K1BZ+ChYi9urKokMXdHbnCkI95/LWQdY7hPARF5K3gWMb
         1Ul9O+B5NkapKd/+2hTuolgkCPXv3qkSLnGr262dcEmxAZFEgHI5gJgRUpLsGs58QU
         8U4qeWFuOA0UlDGjPj2xiF9EkoFa5RJb2LKCbHDzc9ZfbJFKfprnADb1JRqP+dapoN
         6zKeadLC0hh1xEaJK9z0KgAxVUqD5K++x2iXYCrkQBhKLgbQIduZwWcXZcNBKa5A3B
         0s9zNVR1nZ7cg==
Date:   Wed, 1 Mar 2023 18:11:26 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/+HPrU/ofFXapHM@lothringen>
References: <Y/z0fHHYdxEXcWMT@pc636>
 <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636>
 <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
 <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/0/dnmIk508sidK@lothringen>
 <Y/1ZMXsNZtwYPJNW@google.com>
 <Y/3fxLXbfvnLFEZq@lothringen>
 <Y/5fXskgrQxzbt0U@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/5fXskgrQxzbt0U@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 08:09:02PM +0000, Joel Fernandes wrote:
> Hi Frederic,
> 
> On Tue, Feb 28, 2023 at 12:04:36PM +0100, Frederic Weisbecker wrote:
> Both should play a role. For lazy, we found callbacks that showed later in
> the full boot sequence (like the SCSI issue).
> 
> For expedited, there is new data from Qiuxu showing 5% improvement in boot
> time.

Indeed, nice one!

> Right, and we also don't know if in the future, somebody queues a CB that
> slows down boot as well (say they queue a lazy CB that does a wakeup), even
> if currently there are not any such. As noted, that SCSI issue did show. Just
> to note, callbacks doing wakeups are supposed to call call_rcu_hurry().

Sure, ideally we should have a way to debug lazy callbacks involved in wait/wake
dependency against the enqueuer but that doesn't sound easy to do...

> Yes, sorry, it was more an RFC but still should have been more clear. For the
> v3 I'll definitely make it clear.
> 
> rcu_end_inkernel_boot() is called before init is run. But the kernel cannot
> posibly know when init has finished running and say the system is now waiting
> for user login, or something. There's a considerable amount time from
> rcu_end_inkernel_boot() to when the system is actually "booted". That's the
> main issue. We could look at CPU load, but that's not ideal. Maybe wait for
> user input, but that sucks as well.

So it looks like user boot is involved in what you want to wait for. In that
case only userspace can tell.

> Hmmm I see what you mean, so a conservative and configurable "fail-safe"
> timeout followed by sysctl to end the boot earlier than the timeout, should
> do it (something like 30 seconds IMHO sounds reasonable)? In any case,
> whatever way we go, we would not end the kernel boot before
> rcu_end_inkernel_boot() is called at least once (which is the current
> behavior).
> 
> So it would be:
> 
>   low level boot + initcalls
>        20 sec                         30 second timeout
> |------------------------------|--------------------------
>                                |                         |
> 	        old rcu_end_inkernel_boot()      new rcu_end_inkernel_boot()
> 
> But it could be, if user decides:
>   low level boot + initcalls
>        20 sec                         10 second timeout
> |------------------------------|--------------------------
>                                |                         |
> 	        old rcu_end_inkernel_boot()      new rcu_end_inkernel_boot()
> 		                                 via /sys/ entry.

The problem I have with a random default timeout is that it may break sensitive
workloads. If the default is 30 and say the boot only takes 5 seconds and
immediately launches a latency sensitive task, this may break things in a
subtle way during these 25 seconds when it usually didn't. Because expedited
RCU is a hammer interrupting all non-idle CPUs.

Until now forcing expedited RCU was only performed before any user code. Now it
crosses the boundary so better be careful. I'd personally advocate for keeping
the current call before init is launched. Then provide an end_boot_sysctl kernel
boot parameter that will ignore the current call before init and let the user
signal that through sysctl.


> > > > So shouldn't we disable lazy callbacks by default when CONFIG_RCU_LAZY=y and then
> > > > turn it on with "sysctl kernel.rcu.lazy=1" only whenever userspace feels ready
> > > > about it? We can still keep the current call to rcu_end_inkernel_boot().
> > > 
> > > Hmm IMHO that would add more knobs for not much reason honestly. We already
> > > have CONFIG_RCU_LAZY default disabled, I really don't want to add more
> > > dependency (like user enables the config and does not see laziness).
> > 
> > I don't know. Like I said, different problems, different solutions. Let's
> > identify what the issue is precisely. For example can we expect that the issues
> > on boot can be a problem also on some temporary workloads?
> > 
> > Besides I'm currently testing a very hacky flavour of rcu_lazy and so far it
> > shows many idle calls that would have been delayed if callbacks weren't queued
> > as lazy.
> 
> Can you provide more details? What kind of hack flavor, and what is it doing?

Sorry, I meant a hacky implementation of lazy to work with !NOCB.

Thanks.
