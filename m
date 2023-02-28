Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924D76A6024
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjB1UJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjB1UJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:09:06 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1961B56F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:09:05 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id y12so7744902qvt.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677614944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NH34UHl+rn2FO1mQ7lCOsCVjbWfDkbPYuh07UsQOhis=;
        b=H8JbXstRVmnyb9jd9RDj3Pnvvuq5Ealg3QjKjfsGavPEO6e7ckbwkzZz/20MOO5Ey0
         FbksYZRhWWe7hwgmwnvyaVn/kra+2SNHIurnijeStGiR1CaANhatLN1Y5afYqd8mOs8N
         I6y6IfhP5H2cDUXJ+p+5b6eKHrXxkTjTvct4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677614944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH34UHl+rn2FO1mQ7lCOsCVjbWfDkbPYuh07UsQOhis=;
        b=jWrTG0szKWqAD9e/hL10gQ0lhc6rvboGtP2AKAmXabIxT24dTshjMmZZDnRCSpCLAP
         yqUqWeucGdtWxZcA19asrceVKUsThFDNN8b8W26AUUTD8bMkwx5UCGlolCqKP4AOWMV7
         WR0/kaLJ8vDe9UEyg2YHb5b4/14vurEMPWOGBygM8SDudIQ1gG7m2ellTg81/vm2FoGl
         nrBpMZjSsNFyDNvUqZkq0iTgiijJbO30Gl/+qVFRIlEzXq2AtaL2vbZ8/OdVMzW1qwsv
         5UnVRbg2ty1afLqGBndYsa+lnF+uNCiNczMMjpOzKrlkvpZuIn8yQI+AXJF15pXKRK9T
         eptQ==
X-Gm-Message-State: AO0yUKUR93T74nTEeiID8aItkwaryUjQLeW+NVnZudHXxA3+Xr4RogiS
        Sx9ZxULQdfbEXxWmzV17+IvOcQ==
X-Google-Smtp-Source: AK7set950bRPMYcF1PBo6aHG2JurEHS1incCiQgR8NOD4Yh854UqDXAxDRkb6hlikDJeHLFHuKCVVA==
X-Received: by 2002:a05:6214:f0f:b0:56e:bc62:e151 with SMTP id gw15-20020a0562140f0f00b0056ebc62e151mr8013215qvb.7.1677614944380;
        Tue, 28 Feb 2023 12:09:04 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v23-20020a05620a091700b007423c78b004sm7359424qkv.9.2023.02.28.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 12:09:03 -0800 (PST)
Date:   Tue, 28 Feb 2023 20:09:02 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/5fXskgrQxzbt0U@google.com>
References: <Y/z0fHHYdxEXcWMT@pc636>
 <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636>
 <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
 <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/0/dnmIk508sidK@lothringen>
 <Y/1ZMXsNZtwYPJNW@google.com>
 <Y/3fxLXbfvnLFEZq@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/3fxLXbfvnLFEZq@lothringen>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On Tue, Feb 28, 2023 at 12:04:36PM +0100, Frederic Weisbecker wrote:
> On Tue, Feb 28, 2023 at 01:30:25AM +0000, Joel Fernandes wrote:
> > On Tue, Feb 28, 2023 at 12:40:38AM +0100, Frederic Weisbecker wrote:
> > > On Mon, Feb 27, 2023 at 03:05:02PM -0800, Paul E. McKenney wrote:
> > > > On Mon, Feb 27, 2023 at 02:10:30PM -0500, Joel Fernandes wrote:
> > > > 
> > > > The combination of sysfs manipulated by userspace and a kernel failsafe
> > > > makes sense to me.  Especially if by default triggering the failsafe
> > > > splats.  That way, bugs where userspace fails to update the sysfs file
> > > > get caught.
> > > > 
> > > > The non-default silent-failsafe mode is also useful to allow some power
> > > > savings in advance of userspace getting the sysfs updating in place.
> > > > And of course the default splatting setup can be used in internal testing
> > > > with the release software being more tolerant of userspace foibles.
> > > 
> > > I'm wondering, this is all about CONFIG_RCU_LAZY, right? Or does also expedited
> > > GP turned off a bit early or late on boot matter for anybody in practice?
> > 
> > Yes, if you provide 'rcu_normal_after_boot', then after the boot ends, it
> > switches expedited GPs to normal ones.
> > 
> > It is the same issue for expedited, the kernel's version of what is 'boot' is
> > much shorter than what is actually boot.
> > 
> > This is also the case with suspend/resume's rcu_pm_notify(). See the comment:
> >   /*
> >    * On non-huge systems, use expedited RCU grace periods to make suspend
> >    * and hibernation run faster.
> >    */
> > 
> > There also we turn on/off both lazy and expedited. I don't see why we
> > shouldn't do it for boot.
> 
> Of course but I mean currently rcu_end_inkernel_boot() is called explicitly
> before the kernel calls init. From that point on, what is the source of the
> issue? Delaying lazy further would be enough or do we really need to delay
> forcing expedited as well? Or is it the reverse: delaying expedited further
> would matter and lazy doesn't play much role from there.

Both should play a role. For lazy, we found callbacks that showed later in
the full boot sequence (like the SCSI issue).

For expedited, there is new data from Qiuxu showing 5% improvement in boot
time.

> It matters to know because if delaying expedited further is enough, then indeed
> we must delay the call to rcu_end_inkernel_boot() somehow. But if delaying
> expedited further doesn't matter and delaying lazy matter then it's possible
> that the issue is a callback that should be marked as call_rcu_hurry() and then
> the source of the problem is much broader.

Right, and we also don't know if in the future, somebody queues a CB that
slows down boot as well (say they queue a lazy CB that does a wakeup), even
if currently there are not any such. As noted, that SCSI issue did show. Just
to note, callbacks doing wakeups are supposed to call call_rcu_hurry().

> I think the confusion comes from the fact that your changelog doesn't state precisely
> what the problem exactly is. Also do we need to wait for the kernel boot completion?
> And if so what is missing from kernel boot after the current explicit call to
> rcu_end_inkernel_boot()?

Yes, sorry, it was more an RFC but still should have been more clear. For the
v3 I'll definitely make it clear.

rcu_end_inkernel_boot() is called before init is run. But the kernel cannot
posibly know when init has finished running and say the system is now waiting
for user login, or something. There's a considerable amount time from
rcu_end_inkernel_boot() to when the system is actually "booted". That's the
main issue. We could look at CPU load, but that's not ideal. Maybe wait for
user input, but that sucks as well.

> Or do we also need to wait for userspace to complete the boot? Different
> problems, different solutions.
> 
> But in any case a countdown is not a way to go. Consider that rcu_lazy may
> be used by a larger audience than just chromium in the long run. You can not
> ask every admin to provide his own estimation per type of machine. You can't
> either rely on a long default value because that may have bad impact on
> workload assumptions launched right after boot.

Hmmm I see what you mean, so a conservative and configurable "fail-safe"
timeout followed by sysctl to end the boot earlier than the timeout, should
do it (something like 30 seconds IMHO sounds reasonable)? In any case,
whatever way we go, we would not end the kernel boot before
rcu_end_inkernel_boot() is called at least once (which is the current
behavior).

So it would be:

  low level boot + initcalls
       20 sec                         30 second timeout
|------------------------------|--------------------------
                               |                         |
	        old rcu_end_inkernel_boot()      new rcu_end_inkernel_boot()

But it could be, if user decides:
  low level boot + initcalls
       20 sec                         10 second timeout
|------------------------------|--------------------------
                               |                         |
	        old rcu_end_inkernel_boot()      new rcu_end_inkernel_boot()
		                                 via /sys/ entry.

> > > So shouldn't we disable lazy callbacks by default when CONFIG_RCU_LAZY=y and then
> > > turn it on with "sysctl kernel.rcu.lazy=1" only whenever userspace feels ready
> > > about it? We can still keep the current call to rcu_end_inkernel_boot().
> > 
> > Hmm IMHO that would add more knobs for not much reason honestly. We already
> > have CONFIG_RCU_LAZY default disabled, I really don't want to add more
> > dependency (like user enables the config and does not see laziness).
> 
> I don't know. Like I said, different problems, different solutions. Let's
> identify what the issue is precisely. For example can we expect that the issues
> on boot can be a problem also on some temporary workloads?
> 
> Besides I'm currently testing a very hacky flavour of rcu_lazy and so far it
> shows many idle calls that would have been delayed if callbacks weren't queued
> as lazy.

Can you provide more details? What kind of hack flavor, and what is it doing?

thanks,

 - Joel


> I have yet to do actual energy and performance measurements but if it
> happens to show improvements, I suspect distros will want a supported yet
> default disabled Kconfig that can be turned on on boot or later. Of course we
> are not there yet but things to keep in mind...
> 
> Thanks.
