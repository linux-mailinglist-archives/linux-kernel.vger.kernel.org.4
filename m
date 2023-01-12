Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140E8668451
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbjALUwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjALUvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:51:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203B69B24;
        Thu, 12 Jan 2023 12:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673554992; x=1705090992;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6YfvABiBp7ocCrIDI9snXmbWhGiqaSceGl7APOCsxQM=;
  b=EFhjlqcU2XouvJssKlSi6bZICJSEmel6wzg+qR2oeDKgJe0VBTd7dSGR
   +CfvE5QUtpxyBy41CWp8T5xEIgSf/A5gUZrHCUfktvDW0Yn9aIgpeH7dY
   xW4fdTyN82iq1/fdi3tg09bDbw1gAutESYOs2fCstoMtrFyNhVLaF4ei6
   0IXFnUSaoI/OOx04shnhnDHotTQo3/amDfu1CR3Wgue04sqBV86oak9rN
   Xc1hCJez9KteAm/59OVzx1OIITHo7QV/F5eRVu2yY2iBvgV3YK6cLPAqt
   w3dkauHsWqL2Lj6EgjHGoMI+THd9xyzdcMUJe5HFwqJ7zrUMYB9e9uftS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325873428"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325873428"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 12:23:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="657967008"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="657967008"
Received: from rehlert-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.98.252])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 12:23:12 -0800
Message-ID: <beda908814705a9e71f8241c787e5c53d2c7cda3.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/4] thermal/drivers/intel_powerclamp: Use powercap
 idle-inject framework
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kernel test robot <lkp@intel.com>
Date:   Thu, 12 Jan 2023 12:23:12 -0800
In-Reply-To: <CAJZ5v0iPfFi9oS3D2=CvzdqZc+iZ7XUex8s_81-voVHYuU4Pvw@mail.gmail.com>
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
         <20221129233419.4022830-4-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0iPfFi9oS3D2=CvzdqZc+iZ7XUex8s_81-voVHYuU4Pvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-12 at 19:32 +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 30, 2022 at 12:34 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > There are two idle injection implementation in the Linux kernel.
> > One
> > via intel_powerclamp and the other using powercap/idle_inject. Both
> > implementation end up in calling play_idle* function from a FIFO
> > priority thread. Both can't be used at the same time.
> > 
> > Currently per core idle injection (cpuidle_cooling) is using
> > powercap/idle_inject, which is not used in platforms where
> > intel_powerclamp is used for system wide idle injection. So there
> > is
> > no conflict. But there are some use cases where per core idle
> > injection
> > is beneficial on the same system where system wide idle injection
> > is
> > also used via intel_powerclamp. To avoid conflict only one of the
> > idle
> > injection type must be in use at a time. This require a common
> > framework
> > which both per core and system wide idle injection can use.
> > 
> > Here powercap/idle_inject can be used for both per-core and for
> > system
> > wide idle injection. This framework has a well defined interface
> > which allow registry for per-core or for all CPUs (system wide). If
> > particular CPU is already participating in idle injection, the call
> > to registry fails. Here the registry can be done when user space
> > changes the current cooling device state.
> > 
> > Also one framework for idle injection is better as there is one
> > loop
> > calling play_idle*, instead of multiple for better maintenance.
> > 
> > So, reuse powercap/idle_inject calls in intel_powerclamp. This
> > simplifies
> > the code as all per CPU kthreads which calls play_idle* can be
> > removed.
> > 
> > The changes include:
> > - Remove unneeded include files
> > - Remove per CPU kthread workers: balancing_work and
> > idle_injection_work
> > - Reuse the compensation related code by moving from previous
> > worker
> > thread to idle_injection callbacks
> > - Adjust the idle_duration and runtime by using
> > powercap/idle_inject
> > interface
> > - Remove all variables, which are not required once
> > powercap/idle_inject
> > is used
> > - Add mutex to avoid race during removal of idle injection during
> > module
> > unload and user action to change idle inject percent
> > - Use READ_ONCE and WRITE_ONCE for data accessed from multiple CPUs
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > v2:
> > - Use idle_inject_register_full instead of idle_inject_register
> > - Also fix dependency issue with POWERCAP config
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> >  drivers/thermal/intel/Kconfig            |   2 +
> >  drivers/thermal/intel/intel_powerclamp.c | 292 ++++++++++---------
> > ----
> >  2 files changed, 126 insertions(+), 168 deletions(-)
> > 
> > diff --git a/drivers/thermal/intel/Kconfig
> > b/drivers/thermal/intel/Kconfig
> > index f0c845679250..6c2a95f41c81 100644
> > --- a/drivers/thermal/intel/Kconfig
> > +++ b/drivers/thermal/intel/Kconfig
> > @@ -3,6 +3,8 @@ config INTEL_POWERCLAMP
> >         tristate "Intel PowerClamp idle injection driver"
> >         depends on X86
> >         depends on CPU_SUP_INTEL
> > +       select POWERCAP
> > +       select IDLE_INJECT
> >         help
> >           Enable this to enable Intel PowerClamp idle injection
> > driver. This
> >           enforce idle time which results in more package C-state
> > residency. The
> > diff --git a/drivers/thermal/intel/intel_powerclamp.c
> > b/drivers/thermal/intel/intel_powerclamp.c
> > index b80e25ec1261..3f2b20ae8f68 100644
> > --- a/drivers/thermal/intel/intel_powerclamp.c
> > +++ b/drivers/thermal/intel/intel_powerclamp.c
> > @@ -2,7 +2,7 @@
> >  /*
> >   * intel_powerclamp.c - package c-state idle injection
> >   *
> > - * Copyright (c) 2012, Intel Corporation.
> > + * Copyright (c) 2022, Intel Corporation.
> 
> Nit: I would retain the original year of introduction, so 2012 -
> 2022.
OK

> 
> >   *
> > 

[...]

> > +
> > +static int idle_inject_begin(unsigned int cpu)
> 
> So this would be the ->prepare() callback to be invoked on each CPU
> from idle_inject_fn() IIUC.
> 
Yes

> >  {
> > -       struct powerclamp_worker_data *w_data =
> > per_cpu_ptr(worker_data, cpu);
> > -       struct kthread_worker *worker;
> > +       /*
> > +        * only elected controlling cpu can collect stats and
> > update
> > +        * control parameters.
> > +        */
> > +       if (cpu == control_cpu) {
> > +               bool update = READ_ONCE(target_ratio_updated);
> > +
> > +               if (!(powerclamp_data.count %
> > powerclamp_data.window_size_now)) {
> > +                       bool skip =
> > powerclamp_adjust_controls(powerclamp_data.target_ratio,
> > +                                                     
> > powerclamp_data.guard,
> > +                                                     
> > powerclamp_data.window_size_now);
> > +                       WRITE_ONCE(should_skip, skip);
> > +                       update = true;
> > +               }
> > 
> > -       worker = kthread_create_worker_on_cpu(cpu, 0,
> > "kidle_inj/%ld", cpu);
> > -       if (IS_ERR(worker))
> > -               return;
> > +               if (update) {
> > +                       unsigned int runtime;
> > +
> > +                       runtime = get_run_time();
> > +                       idle_inject_set_duration(ii_dev, runtime,
> > duration);
> > +                       WRITE_ONCE(target_ratio_updated, false);
> > +               }
> > +               powerclamp_data.count++;
> > +       }
> > +
> > +       if (READ_ONCE(should_skip))
> > +               return -EAGAIN;
> 
> This has a bit of a synchronization issue, because the control CPU is
> not guaranteed to run this code before any other CPUs in the given
> cycle, so at least some of them may see a stale value of should_skip
> and they will still inject idle in this cycle.  Or else, they may
> skip
> idle injection when it should be done.
This is correct observation. This is true in in even in current
implementation. The per thread timer in the existing implementation has
this sync issue. So I tried to just mimic current implementation as is.


> 
> I think that it would be better to run the callback from
> idle_inject_timer_fn() where it would decide whether or not to call
> idle_inject_wakeup(), in which case the control CPU would not be
> needed any more (which would be a plus), because the "control" could
> be done by the CPU running the timer function, whichever it is.
> 
> Does this sound viable? 
Yes it is. In this case prepare() callback from idle_inject core is not
per CPU, but per device.

Thanks,
Srinivas

>  Or if it doesn't, then why?

