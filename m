Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428D563D818
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiK3OaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiK3OaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:30:14 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6D54756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:30:11 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id r81so12421667iod.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/Y6JfFohmJ3Rvsl0Sh/xfP65FizKCMZT85La1Uopwg=;
        b=b/Gj5j1bXT22qxr3wLHfYKT9tFptmaXZVPwMIaIDifwBWb9HTyAwFvD+WaREAgL2Df
         pWlTpGE5HTetahStiRBlUxLtEtSmgTaR/Z+TOB8vS5u2ea3aYdjNA1XgePMPs9168NyL
         71E98kacyf/2WEdn+FM95hAe9MTmSdPX+38FpnVoL6mQbTe1vV6YOiOcuKB0dHI1bsdP
         70eVvzGK7xFUONE8KW/VzCNC1XPhS84k6czdLzLLycRkw5YyUMvn1r0DXl2wytt/mY7p
         LQ4byboM4I/bWmmZgqWGXn4/vokHmjSD6WGOeEA/mnTeiZalPCYWfNGIPMv64DzsZtMq
         JRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/Y6JfFohmJ3Rvsl0Sh/xfP65FizKCMZT85La1Uopwg=;
        b=UCUoneGTzm1OMyprruM7I6ZtTHej4sE75GWW0FxC1cZNNbR1dS4Arv2ef40El4HQIR
         UZSKx2lVwdIA/CYnazaR6WJ5hJWKsDFBXNoZhbXkN3McO8KKlmOcGLun/hO+M1Pt1y/U
         JZYfMNOs4K345Wwt2RysluNpBWm3VhgYDgLMrJZsZsHoCI6X8tGJcLTwIE15/q6OqiU6
         lXjazC6w4u3F4t9+MYvGZru2Z+PB09pONKps/I70EwNbad/Zmhg4OQEsq+Pz/Ilq2JHP
         iUy/eszu6/FmCgx1XrIuVDhxgTBPrKe+UK+LbbMqquRHjOap4GIyYHfFw4XIJ27pVKDe
         BwtA==
X-Gm-Message-State: ANoB5pnpYl8ubwXIqfYzFzph3xCc8QMCLP35qy0TIcFgKjX4ITjvYQ+p
        kn4f2him+bTUaiLOJLOVhIwf+Mrf6cz4zRJ5gCflPw==
X-Google-Smtp-Source: AA0mqf5zySZLEHJnlYwInWzy0W/FGXYBQN1FoIQ1TLD+7TDdTSAIe71NporRYBjZu8oXnxSvkq3rvprfO5JXOndmpZs=
X-Received: by 2002:a02:2b01:0:b0:374:fe84:1e9 with SMTP id
 h1-20020a022b01000000b00374fe8401e9mr29409189jaa.71.1669818610739; Wed, 30
 Nov 2022 06:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20221110195732.1382314-1-wusamuel@google.com> <CAGETcx_aAynvykDSL4aue3zf5Pv7+hELUHQ=MWOzBbyZBPySDA@mail.gmail.com>
 <880b7332-562c-4934-4e92-493b112568c9@arm.com> <CAG2Kctp_VwryYTYMoqe6EBKFs-FZuNcB94e_MzLgBN9jJ5tpQA@mail.gmail.com>
 <CAJZ5v0iNjPAAn0-uygpJe0ya_LW7pfF4C8OHd+8EMLg+Ws=02Q@mail.gmail.com>
 <97af1300-541d-a79c-404c-92886f10b220@arm.com> <CAKfTPtAPniqQyDzh=Yu8Z9R9+H2PzBKkHT0SJgHZiUOdNdw3Mg@mail.gmail.com>
 <75bba88a-0516-a6a2-d4e6-8cedabadf413@arm.com>
In-Reply-To: <75bba88a-0516-a6a2-d4e6-8cedabadf413@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Nov 2022 15:29:59 +0100
Message-ID: <CAKfTPtA=7DkjADnNijLPDm_6hh9XkFjC9ZUVQ_5_NSU2Fn5pHQ@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to sugov_policy"
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sam Wu <wusamuel@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 at 15:04, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
> On 11/30/22 10:42, Vincent Guittot wrote:
> > Hi All
> >
> > Just for the log and because it took me a while to figure out the root
> > cause of the problem: This patch also creates a regression for
> > snapdragon845 based systems and probably on any QC chipsets that use a
> > LUT to update the OPP table at boot. The behavior is the same as
> > described by Sam with a staled value in sugov_policy.max field.
>
> Thanks for sharing this info and apologies that you spent cycles
> on it.
>
> I have checked that whole setup code (capacity + cpufreq policy and
> governor). It looks like to have a proper capacity of CPUs, we need
> to wait till the last policy is created. It's due to the arch_topology.c
> mechanism which is only triggered after all CPUs' got the policy.
> Unfortunately, this leads to a chicken & egg situation for this
> schedutil setup of max capacity.
>
> I have experimented with this code, which triggers an update in
> the schedutil, when all CPUs got the policy and sugov gov
> (with trace_printk() to mach the output below)

Your proposal below looks similar to what is done in arch_topology.c.
arch_topology.c triggers a rebuild of sched_domain and removes its
cpufreq notifier cb once it has visited all CPUs, could it also
trigger an update of CPU's policy with cpufreq_update_policy() ?

At this point you will be sure that the normalization has happened and
the max capacity will not change.

I don't know if it's a global problem or only for systems using arch_topology

>
> -------------------------8<-----------------------------------------
> diff --git a/kernel/sched/cpufreq_schedutil.c
> b/kernel/sched/cpufreq_schedutil.c
> index 9161d1136d01..f1913a857218 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -59,6 +59,7 @@ struct sugov_cpu {
>   };
>
>   static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
> +static cpumask_var_t cpus_to_visit;
>
>   /************************ Governor internals ***********************/
>
> @@ -783,6 +784,22 @@ static int sugov_start(struct cpufreq_policy *policy)
>
>                  cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
> uu);
>          }
> +
> +       cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
> +
> +       if (cpumask_empty(cpus_to_visit)) {
> +               trace_printk("schedutil the visit cpu mask is empty now\n");
> +               for_each_possible_cpu(cpu) {
> +                       struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> +                       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> +
> +                       sg_policy->max = arch_scale_cpu_capacity(cpu);
> +
> +                       trace_printk("SCHEDUTIL: NEW  CPU%u
> cpu_capacity=%lu\n",
> +                               cpu, sg_policy->max);
> +               }
> +       }
> +
>          return 0;
>   }
>
> @@ -800,6 +817,8 @@ static void sugov_stop(struct cpufreq_policy *policy)
>                  irq_work_sync(&sg_policy->irq_work);
>                  kthread_cancel_work_sync(&sg_policy->work);
>          }
> +
> +       cpumask_or(cpus_to_visit, cpus_to_visit, policy->related_cpus);
>   }
>
>   static void sugov_limits(struct cpufreq_policy *policy)
> @@ -829,6 +848,11 @@ struct cpufreq_governor schedutil_gov = {
>   #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
>   struct cpufreq_governor *cpufreq_default_governor(void)
>   {
> +       if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL))
> +               return NULL;
> +
> +       cpumask_copy(cpus_to_visit, cpu_possible_mask);
> +
>          return &schedutil_gov;
>   }
>   #endif
>
> ---------------------------------->8---------------------------------
>
>
> That simple approach fixes the issue. I have also tested it with
> governor change a few times and setting back the schedutil.
>
> -------------------------------------------
>     kworker/u12:1-48      [004] .....     2.208847: sugov_start:
> schedutil the visit cpu mask is empty now
>     kworker/u12:1-48      [004] .....     2.208854: sugov_start:
> SCHEDUTIL: NEW  CPU0 cpu_capacity=381
>     kworker/u12:1-48      [004] .....     2.208857: sugov_start:
> SCHEDUTIL: NEW  CPU1 cpu_capacity=381
>     kworker/u12:1-48      [004] .....     2.208860: sugov_start:
> SCHEDUTIL: NEW  CPU2 cpu_capacity=381
>     kworker/u12:1-48      [004] .....     2.208862: sugov_start:
> SCHEDUTIL: NEW  CPU3 cpu_capacity=381
>     kworker/u12:1-48      [004] .....     2.208864: sugov_start:
> SCHEDUTIL: NEW  CPU4 cpu_capacity=1024
>     kworker/u12:1-48      [004] .....     2.208866: sugov_start:
> SCHEDUTIL: NEW  CPU5 cpu_capacity=1024
>              bash-615     [005] .....    35.317113: sugov_start:
> schedutil the visit cpu mask is empty now
>              bash-615     [005] .....    35.317120: sugov_start:
> SCHEDUTIL: NEW  CPU0 cpu_capacity=381
>              bash-615     [005] .....    35.317123: sugov_start:
> SCHEDUTIL: NEW  CPU1 cpu_capacity=381
>              bash-615     [005] .....    35.317125: sugov_start:
> SCHEDUTIL: NEW  CPU2 cpu_capacity=381
>              bash-615     [005] .....    35.317127: sugov_start:
> SCHEDUTIL: NEW  CPU3 cpu_capacity=381
>              bash-615     [005] .....    35.317129: sugov_start:
> SCHEDUTIL: NEW  CPU4 cpu_capacity=1024
>              bash-615     [005] .....    35.317131: sugov_start:
> SCHEDUTIL: NEW  CPU5 cpu_capacity=1024
>              bash-623     [003] .....    57.633328: sugov_start:
> schedutil the visit cpu mask is empty now
>              bash-623     [003] .....    57.633336: sugov_start:
> SCHEDUTIL: NEW  CPU0 cpu_capacity=381
>              bash-623     [003] .....    57.633339: sugov_start:
> SCHEDUTIL: NEW  CPU1 cpu_capacity=381
>              bash-623     [003] .....    57.633340: sugov_start:
> SCHEDUTIL: NEW  CPU2 cpu_capacity=381
>              bash-623     [003] .....    57.633342: sugov_start:
> SCHEDUTIL: NEW  CPU3 cpu_capacity=381
>              bash-623     [003] .....    57.633343: sugov_start:
> SCHEDUTIL: NEW  CPU4 cpu_capacity=1024
>              bash-623     [003] .....    57.633344: sugov_start:
> SCHEDUTIL: NEW  CPU5 cpu_capacity=1024
> ----------------------------------------------------
>
> It should work.
>
> Regards,
> Lukasz
