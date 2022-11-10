Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE53624E50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiKJXPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiKJXPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:15:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1238E086;
        Thu, 10 Nov 2022 15:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668122118; x=1699658118;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2bnIoY+pBkGJTjXFdnqJEaioLPMFfI2z+MLotyzz/o4=;
  b=DA/Jb2IOB/Ike2KIwNKQlMm8PS7+7Te4x/y0bo1extf5Vy2hmfkDL7O9
   /XsrOT1tFZQdR0Ts3v4naz6EmswtQ6OEdpZ35RebAc4yRO+jrq/kOR3+p
   Q8kerLRYJPUVmsgVQMJqSGMKIwmVKMwDTp2mZblaxfptgtzxaVtStaBaO
   GFI2QtHrEFqR8mGOldEhPJIA7jSBB43L71mBEF0VIYE2RMvUKK+5FTgPb
   m7Mx0HZwpabrFBvl3mhRIc39RjT3cFzT6dl/Nb7Y4oNzuu5jdsaC6eHE9
   9X4lU5jTOs1M1oaUvO/SVubK5BksqxYyFhwg8RqVjulDcqrLmZePC5/CT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="311469675"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="311469675"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 15:13:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615286212"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="615286212"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 15:13:55 -0800
Message-ID: <38fabc3b02db3824314d343bb6cebcc8997a03cb.camel@linux.intel.com>
Subject: Re: [PATCH 2/4] powercap: idle_inject: Add begin/end callbacks
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Thu, 10 Nov 2022 15:13:55 -0800
In-Reply-To: <CAJZ5v0jD-a__naERH3MsB1yDQwNkwKcL=aSP3JEdiD11s76gDA@mail.gmail.com>
References: <20221108030342.1127216-1-srinivas.pandruvada@linux.intel.com>
         <20221108030342.1127216-3-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0jD-a__naERH3MsB1yDQwNkwKcL=aSP3JEdiD11s76gDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-09 at 15:48 +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 8, 2022 at 4:04 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > The actual CPU Idle percent can be different than what can be
> > observed
> > from the hardware.
> 
> Can you expand this a bit, please?  It is not clear what the "CPU
> idle
> percent" and "observed from the hardware" phrases mean here.
Sure.

> 
> > Since the objective for CPU Idle injection is for
> > thermal control, the idle percent observed by the hardware is more
> > relevant.
> > 
> > To account for hardware feedback the actual runtime/idle time
> > should be
> > adjusted.
> > 
> > Add a capability to register a begin and end callback during call
> > to
> 
> I would call them "prepare" and "complete" without the "idle_inject_"
> prefix.
OK

> 
> > idle_inject_register(). If they are not NULL, then begin callback
> > is
> > called before calling play_idle_precise() and end callback is
> > called
> > after play_idle_precise().
> > 
> > If begin callback is present and returns non 0 value then
> > play_idle_precise() is not called as it means there is some over
> > compensation.
> 
> This behavior needs to be documented somewhere other than the patch
> changelog.
We can add a kernel doc and add there.

> 
> > Signed-off-by: Srinivas Pandruvada <   
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/powercap/idle_inject.c    | 19 ++++++++++++++++++-
> >  drivers/thermal/cpuidle_cooling.c |  2 +-
> >  include/linux/idle_inject.h       |  4 +++-
> >  3 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/powercap/idle_inject.c
> > b/drivers/powercap/idle_inject.c
> > index e73885bd9065..14968b0ff133 100644
> > --- a/drivers/powercap/idle_inject.c
> > +++ b/drivers/powercap/idle_inject.c
> > @@ -70,6 +70,8 @@ struct idle_inject_device {
> >         unsigned int idle_duration_us;
> >         unsigned int run_duration_us;
> >         unsigned int latency_us;
> > +       int (*idle_inject_begin)(unsigned int cpu);
> > +       void (*idle_inject_end)(unsigned int cpu);
> 
> The comment above needs to be updated.  Also please see the remark
> above regarding callback names.
> 
> >         unsigned long cpumask[];
> >  };
> > 
> > @@ -132,6 +134,7 @@ static void idle_inject_fn(unsigned int cpu)
> >  {
> >         struct idle_inject_device *ii_dev;
> >         struct idle_inject_thread *iit;
> > +       int ret;
> > 
> >         ii_dev = per_cpu(idle_inject_device, cpu);
> >         iit = per_cpu_ptr(&idle_inject_thread, cpu);
> > @@ -141,8 +144,18 @@ static void idle_inject_fn(unsigned int cpu)
> >          */
> >         iit->should_run = 0;
> > 
> > +       if (ii_dev->idle_inject_begin) {
> > +               ret = ii_dev->idle_inject_begin(cpu);
> > +               if (ret)
> > +                       goto skip;
> > +       }
> > +
> >         play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) *
> > NSEC_PER_USEC,
> >                           READ_ONCE(ii_dev->latency_us) *
> > NSEC_PER_USEC);
> > +
> > +skip:
> > +       if (ii_dev->idle_inject_end)
> > +               ii_dev->idle_inject_end(cpu);
> >  }
> > 
> >  /**
> > @@ -302,7 +315,9 @@ static int idle_inject_should_run(unsigned int
> > cpu)
> >   * Return: NULL if memory allocation fails, idle injection control
> > device
> >   * pointer on success.
> >   */
> > -struct idle_inject_device *idle_inject_register(struct cpumask
> > *cpumask)
> > +struct idle_inject_device *idle_inject_register(struct cpumask
> > *cpumask,
> > +                                               int
> > (*idle_inject_begin)(unsigned int cpu),
> > +                                               void
> > (*idle_inject_end)(unsigned int cpu))
> 
> Instead of modifying this, I would add something like
> idle_inject_register_full() that will take the callback arguments and
> will be called internally by idle_inject_register().
OK

Thanks,
Srinivas

> 
> >  {
> >         struct idle_inject_device *ii_dev;
> >         int cpu, cpu_rb;
> > @@ -315,6 +330,8 @@ struct idle_inject_device
> > *idle_inject_register(struct cpumask *cpumask)
> >         hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC,
> > HRTIMER_MODE_REL);
> >         ii_dev->timer.function = idle_inject_timer_fn;
> >         ii_dev->latency_us = UINT_MAX;
> > +       ii_dev->idle_inject_begin = idle_inject_begin;
> > +       ii_dev->idle_inject_end = idle_inject_end;
> > 
> >         for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
> > 
> > diff --git a/drivers/thermal/cpuidle_cooling.c
> > b/drivers/thermal/cpuidle_cooling.c
> > index 4f41102e8b16..e8b35b3b5767 100644
> > --- a/drivers/thermal/cpuidle_cooling.c
> > +++ b/drivers/thermal/cpuidle_cooling.c
> > @@ -184,7 +184,7 @@ static int __cpuidle_cooling_register(struct
> > device_node *np,
> >                 goto out;
> >         }
> > 
> > -       ii_dev = idle_inject_register(drv->cpumask);
> > +       ii_dev = idle_inject_register(drv->cpumask, NULL, NULL);
> 
> So this change would not be necessary any more.
> 
> >         if (!ii_dev) {
> >                 ret = -EINVAL;
> >                 goto out_kfree;
> > diff --git a/include/linux/idle_inject.h
> > b/include/linux/idle_inject.h
> > index fb88e23a99d3..73f3414fafe2 100644
> > --- a/include/linux/idle_inject.h
> > +++ b/include/linux/idle_inject.h
> > @@ -11,7 +11,9 @@
> >  /* private idle injection device structure */
> >  struct idle_inject_device;
> > 
> > -struct idle_inject_device *idle_inject_register(struct cpumask
> > *cpumask);
> > +struct idle_inject_device *idle_inject_register(struct cpumask
> > *cpumask,
> > +                                               int
> > (*idle_inject_begin)(unsigned int cpu),
> > +                                               void
> > (*idle_inject_end)(unsigned int cpu));
> > 
> >  void idle_inject_unregister(struct idle_inject_device *ii_dev);
> > 
> > --


