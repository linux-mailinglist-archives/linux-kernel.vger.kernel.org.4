Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8F667E81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjALS6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbjALS6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:58:23 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4178214028;
        Thu, 12 Jan 2023 10:32:54 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id b4so8522628edf.0;
        Thu, 12 Jan 2023 10:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SAGLpKsU4o47p/A9CQ347oqlBXJCr/zYaiDCxIStgg=;
        b=znhqqiWmydGp7JqQz0xhejA6YDBN/1CHDuduixVDq+hHFPTUede/Q8Bk2fBMU8JFmI
         A3q3K1IslGr3oZBrUElv38n9/AaRDWMfJYX12NGGnGT6WT/cYFTEuLZuj4gWFvqI/mcs
         v4zwziU+qTa+XkvuBSeaUC+rIgNZZYnIqUVV9DWeugHe2isUq2s4h8oktElsUOP9nDLI
         HVZD/E2IvRcKyRiVehhOC4j5v25zrYco2ErxkQFeI3FlD9f03vXkONtxUSPFjs5ZQNNF
         vrf0pNR4NL4h7VmIcp1xCpMB6LYMmaAAwUYMhtGT96N/KvdN9xFgMFZXMljJzYB+bFFx
         nBNw==
X-Gm-Message-State: AFqh2koFR3ExfuwvS0n/WhFOAI7tMGdEkvc/xsiW+9X3XA+R7Jp6ipnO
        GvBsyonepFM35aK9vsGHp6hPyVR6INXhb2T1KOI=
X-Google-Smtp-Source: AMrXdXsbwPpNPYc5l0Dt43HfgeX6ValNQPgVRnLp0qxrERhRCxCuUgN5CGpJIzxmlFp0pxwNnl0jvEETv6HycPzHEGE=
X-Received: by 2002:a05:6402:298b:b0:47f:7465:6e76 with SMTP id
 eq11-20020a056402298b00b0047f74656e76mr7335662edb.181.1673548372629; Thu, 12
 Jan 2023 10:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com> <20221129233419.4022830-4-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20221129233419.4022830-4-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 19:32:41 +0100
Message-ID: <CAJZ5v0iPfFi9oS3D2=CvzdqZc+iZ7XUex8s_81-voVHYuU4Pvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] thermal/drivers/intel_powerclamp: Use powercap
 idle-inject framework
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, amitk@kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:34 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> There are two idle injection implementation in the Linux kernel. One
> via intel_powerclamp and the other using powercap/idle_inject. Both
> implementation end up in calling play_idle* function from a FIFO
> priority thread. Both can't be used at the same time.
>
> Currently per core idle injection (cpuidle_cooling) is using
> powercap/idle_inject, which is not used in platforms where
> intel_powerclamp is used for system wide idle injection. So there is
> no conflict. But there are some use cases where per core idle injection
> is beneficial on the same system where system wide idle injection is
> also used via intel_powerclamp. To avoid conflict only one of the idle
> injection type must be in use at a time. This require a common framework
> which both per core and system wide idle injection can use.
>
> Here powercap/idle_inject can be used for both per-core and for system
> wide idle injection. This framework has a well defined interface
> which allow registry for per-core or for all CPUs (system wide). If
> particular CPU is already participating in idle injection, the call
> to registry fails. Here the registry can be done when user space
> changes the current cooling device state.
>
> Also one framework for idle injection is better as there is one loop
> calling play_idle*, instead of multiple for better maintenance.
>
> So, reuse powercap/idle_inject calls in intel_powerclamp. This simplifies
> the code as all per CPU kthreads which calls play_idle* can be removed.
>
> The changes include:
> - Remove unneeded include files
> - Remove per CPU kthread workers: balancing_work and idle_injection_work
> - Reuse the compensation related code by moving from previous worker
> thread to idle_injection callbacks
> - Adjust the idle_duration and runtime by using powercap/idle_inject
> interface
> - Remove all variables, which are not required once powercap/idle_inject
> is used
> - Add mutex to avoid race during removal of idle injection during module
> unload and user action to change idle inject percent
> - Use READ_ONCE and WRITE_ONCE for data accessed from multiple CPUs
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> - Use idle_inject_register_full instead of idle_inject_register
> - Also fix dependency issue with POWERCAP config
> Reported-by: kernel test robot <lkp@intel.com>
>
>  drivers/thermal/intel/Kconfig            |   2 +
>  drivers/thermal/intel/intel_powerclamp.c | 292 ++++++++++-------------
>  2 files changed, 126 insertions(+), 168 deletions(-)
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index f0c845679250..6c2a95f41c81 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -3,6 +3,8 @@ config INTEL_POWERCLAMP
>         tristate "Intel PowerClamp idle injection driver"
>         depends on X86
>         depends on CPU_SUP_INTEL
> +       select POWERCAP
> +       select IDLE_INJECT
>         help
>           Enable this to enable Intel PowerClamp idle injection driver. This
>           enforce idle time which results in more package C-state residency. The
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index b80e25ec1261..3f2b20ae8f68 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -2,7 +2,7 @@
>  /*
>   * intel_powerclamp.c - package c-state idle injection
>   *
> - * Copyright (c) 2012, Intel Corporation.
> + * Copyright (c) 2022, Intel Corporation.

Nit: I would retain the original year of introduction, so 2012 - 2022.

>   *
>   * Authors:
>   *     Arjan van de Ven <arjan@linux.intel.com>
> @@ -27,21 +27,15 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
> -#include <linux/kthread.h>
>  #include <linux/cpu.h>
>  #include <linux/thermal.h>
> -#include <linux/slab.h>
> -#include <linux/tick.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> -#include <linux/sched/rt.h>
> -#include <uapi/linux/sched/types.h>
> +#include <linux/idle_inject.h>
>
> -#include <asm/nmi.h>
>  #include <asm/msr.h>
>  #include <asm/mwait.h>
>  #include <asm/cpu_device_id.h>
> -#include <asm/hardirq.h>
>
>  #define MAX_TARGET_RATIO (50U)
>  /* For each undisturbed clamping period (no extra wake ups during idle time),
> @@ -60,6 +54,7 @@ static struct dentry *debug_dir;
>
>  /* user selected target */
>  static unsigned int set_target_ratio;
> +static bool target_ratio_updated;
>  static unsigned int current_ratio;
>  static bool should_skip;
>
> @@ -67,26 +62,20 @@ static unsigned int control_cpu; /* The cpu assigned to collect stat and update
>                                   * control parameters. default to BSP but BSP
>                                   * can be offlined.
>                                   */
> -static bool clamping;
> -
> -struct powerclamp_worker_data {
> -       struct kthread_worker *worker;
> -       struct kthread_work balancing_work;
> -       struct kthread_delayed_work idle_injection_work;
> +struct powerclamp_data {
>         unsigned int cpu;
>         unsigned int count;
>         unsigned int guard;
>         unsigned int window_size_now;
>         unsigned int target_ratio;
> -       unsigned int duration_jiffies;
>         bool clamping;
>  };
>
> -static struct powerclamp_worker_data __percpu *worker_data;
> +static struct powerclamp_data powerclamp_data;
> +
>  static struct thermal_cooling_device *cooling_dev;
> -static unsigned long *cpu_clamping_mask;  /* bit map for tracking per cpu
> -                                          * clamping kthread worker
> -                                          */
> +
> +static DEFINE_MUTEX(powerclamp_lock);
>
>  static unsigned int duration;
>  static unsigned int pkg_cstate_ratio_cur;
> @@ -344,79 +333,33 @@ static bool powerclamp_adjust_controls(unsigned int target_ratio,
>         return set_target_ratio + guard <= current_ratio;
>  }
>
> -static void clamp_balancing_func(struct kthread_work *work)
> +static unsigned int get_run_time(void)
>  {
> -       struct powerclamp_worker_data *w_data;
> -       int sleeptime;
> -       unsigned long target_jiffies;
>         unsigned int compensated_ratio;
> -       int interval; /* jiffies to sleep for each attempt */
> -
> -       w_data = container_of(work, struct powerclamp_worker_data,
> -                             balancing_work);
> +       unsigned int runtime;
>
>         /*
>          * make sure user selected ratio does not take effect until
>          * the next round. adjust target_ratio if user has changed
>          * target such that we can converge quickly.
>          */
> -       w_data->target_ratio = READ_ONCE(set_target_ratio);
> -       w_data->guard = 1 + w_data->target_ratio / 20;
> -       w_data->window_size_now = window_size;
> -       w_data->duration_jiffies = msecs_to_jiffies(duration);
> -       w_data->count++;
> +       powerclamp_data.target_ratio = READ_ONCE(set_target_ratio);
> +       powerclamp_data.guard = 1 + powerclamp_data.target_ratio / 20;
> +       powerclamp_data.window_size_now = window_size;
>
>         /*
>          * systems may have different ability to enter package level
>          * c-states, thus we need to compensate the injected idle ratio
>          * to achieve the actual target reported by the HW.
>          */
> -       compensated_ratio = w_data->target_ratio +
> -               get_compensation(w_data->target_ratio);
> +       compensated_ratio = powerclamp_data.target_ratio +
> +               get_compensation(powerclamp_data.target_ratio);
>         if (compensated_ratio <= 0)
>                 compensated_ratio = 1;
> -       interval = w_data->duration_jiffies * 100 / compensated_ratio;
> -
> -       /* align idle time */
> -       target_jiffies = roundup(jiffies, interval);
> -       sleeptime = target_jiffies - jiffies;
> -       if (sleeptime <= 0)
> -               sleeptime = 1;
> -
> -       if (clamping && w_data->clamping && cpu_online(w_data->cpu))
> -               kthread_queue_delayed_work(w_data->worker,
> -                                          &w_data->idle_injection_work,
> -                                          sleeptime);
> -}
>
> -static void clamp_idle_injection_func(struct kthread_work *work)
> -{
> -       struct powerclamp_worker_data *w_data;
> -
> -       w_data = container_of(work, struct powerclamp_worker_data,
> -                             idle_injection_work.work);
> +       runtime = duration * 100 / compensated_ratio - duration;
>
> -       /*
> -        * only elected controlling cpu can collect stats and update
> -        * control parameters.
> -        */
> -       if (w_data->cpu == control_cpu &&
> -           !(w_data->count % w_data->window_size_now)) {
> -               should_skip =
> -                       powerclamp_adjust_controls(w_data->target_ratio,
> -                                                  w_data->guard,
> -                                                  w_data->window_size_now);
> -               smp_mb();
> -       }
> -
> -       if (should_skip)
> -               goto balance;
> -
> -       play_idle(jiffies_to_usecs(w_data->duration_jiffies));
> -
> -balance:
> -       if (clamping && w_data->clamping && cpu_online(w_data->cpu))
> -               kthread_queue_work(w_data->worker, &w_data->balancing_work);
> +       return runtime;
>  }
>
>  /*
> @@ -452,104 +395,127 @@ static void poll_pkg_cstate(struct work_struct *dummy)
>         msr_last = msr_now;
>         tsc_last = tsc_now;
>
> -       if (true == clamping)
> +       if (powerclamp_data.clamping)
>                 schedule_delayed_work(&poll_pkg_cstate_work, HZ);
>  }
>
> -static void start_power_clamp_worker(unsigned long cpu)
> +static struct idle_inject_device *ii_dev;
> +
> +static int idle_inject_begin(unsigned int cpu)

So this would be the ->prepare() callback to be invoked on each CPU
from idle_inject_fn() IIUC.

>  {
> -       struct powerclamp_worker_data *w_data = per_cpu_ptr(worker_data, cpu);
> -       struct kthread_worker *worker;
> +       /*
> +        * only elected controlling cpu can collect stats and update
> +        * control parameters.
> +        */
> +       if (cpu == control_cpu) {
> +               bool update = READ_ONCE(target_ratio_updated);
> +
> +               if (!(powerclamp_data.count % powerclamp_data.window_size_now)) {
> +                       bool skip = powerclamp_adjust_controls(powerclamp_data.target_ratio,
> +                                                      powerclamp_data.guard,
> +                                                      powerclamp_data.window_size_now);
> +                       WRITE_ONCE(should_skip, skip);
> +                       update = true;
> +               }
>
> -       worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inj/%ld", cpu);
> -       if (IS_ERR(worker))
> -               return;
> +               if (update) {
> +                       unsigned int runtime;
> +
> +                       runtime = get_run_time();
> +                       idle_inject_set_duration(ii_dev, runtime, duration);
> +                       WRITE_ONCE(target_ratio_updated, false);
> +               }
> +               powerclamp_data.count++;
> +       }
> +
> +       if (READ_ONCE(should_skip))
> +               return -EAGAIN;

This has a bit of a synchronization issue, because the control CPU is
not guaranteed to run this code before any other CPUs in the given
cycle, so at least some of them may see a stale value of should_skip
and they will still inject idle in this cycle.  Or else, they may skip
idle injection when it should be done.

I think that it would be better to run the callback from
idle_inject_timer_fn() where it would decide whether or not to call
idle_inject_wakeup(), in which case the control CPU would not be
needed any more (which would be a plus), because the "control" could
be done by the CPU running the timer function, whichever it is.

Does this sound viable?  Or if it doesn't, then why?
