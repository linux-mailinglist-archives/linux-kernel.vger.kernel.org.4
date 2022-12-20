Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB92651FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiLTLvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiLTLvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:51:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C6FBCB8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:51:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m14so11468981wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2IFHwf3PZoIlb3TFc7LKyLHPvFKgU3mx6c729/ao6P8=;
        b=KGBOMCVcGVKBXskn32NrUuRBQsNEZGoWTiRBlVrmOwTdCYTkMp08EVAkvjN2E1gls5
         AjBv7U4VTcBXUqaGK1TIgnWA//h9h2684PY3noMtSij6DU4TaImgmd8ju275B+nC4fRx
         JApm7FXhBPqF/ZYwOrSO+dumozi1gUELkBzj8njaJpHH9q0VpBEcKZ9whf6Vx+5foqJm
         sb5b7WGKYmTSup4mtfFCUi8RR0bn7qRuPc9UWwDFy6dVdd1bSYRvqvhGr1/T23Z7fy/P
         3jhlBt/CLBO5q2KsJmgLX9QenXspEfq7SBT+TSdxS/HdmC8zGpd6XxKn19uPYVYLeCSa
         LYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IFHwf3PZoIlb3TFc7LKyLHPvFKgU3mx6c729/ao6P8=;
        b=a488CxGkQSu1kMNph9e5IbP/jknmqt+muH6UuwbLYwQOP0LPluxuwcnGH8GSZErKhd
         7o62EvuN61CMDio6LiPnSkr8uKxC0VyEJYZpiGiM0WfOkIVSrQLt2SjeOqedcz+Jo0/p
         E/ZfXi0XbNVxuwaaFBb6mKlR3U0RX9aDHi9T/4bZKP4GP11uO0tuALaCYfrvem1fjjJ2
         CP+6N6zllILqldtvJNZ5ezu/9i7UXbxzxK91pWoH1o5hTah5AZRRei9T62zxziSA4wci
         C4yAnWGAo+cm8p9kqEhuViLmaokPMj8akezKH4cu828ejeeSXt66YrQ3/Fof6vsu28ZH
         T1wQ==
X-Gm-Message-State: ANoB5pl9tY7QMNmHaM8ElqdkNmPoKHCwrtTEEOwdx8Vw2XAUiuqgcZ+C
        gWMkmMHXU53woqB4ClI3PPKh5w==
X-Google-Smtp-Source: AA0mqf4I34hp/H6yiZNrwzo77ElvDz1txdC/DrS3wQ8HbZCxejNZplEulTAGEtxTj3odeydSdYNQuw==
X-Received: by 2002:a5d:5950:0:b0:242:88f8:a67c with SMTP id e16-20020a5d5950000000b0024288f8a67cmr27941684wri.42.1671537091800;
        Tue, 20 Dec 2022 03:51:31 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d510d000000b00241e5b917d0sm14811325wrt.36.2022.12.20.03.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:51:31 -0800 (PST)
Date:   Tue, 20 Dec 2022 11:51:30 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
Message-ID: <20221220115130.lhhakj36kn3opqtz@airbuntu>
References: <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu>
 <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu>
 <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu>
 <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu>
 <19bd3f60-63ea-4ccc-b5a2-6507276c8f0d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19bd3f60-63ea-4ccc-b5a2-6507276c8f0d@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 17:42, Lukasz Luba wrote:
> Hi Qais,
> 
> I thought I could help with this issue.

Thanks Lukasz!

> 
> On 12/12/22 18:43, Qais Yousef wrote:
> > On 12/09/22 17:47, Vincent Guittot wrote:
> > 
> > [...]
> > 
> > > > > > > This patch loops on all cpufreq policy in sched softirq, how can this
> > > > > > > be sane ? and not only in eas mode but also in the default asymmetric
> > > > > > 
> > > > > > Hmm I'm still puzzled. Why it's not sane to do it here but it's okay to do it
> > > > > > in the wake up path in feec()?
> > > > > 
> > > > > feec() should be considered as an exception not as the default rule.
> > > > > Thing like above which loops for_each on external subsystem should be
> > > > > prevented and the fact that feec loops all PDs doesn't means that we
> > > > > can put that everywhere else
> > > > 
> > > > Fair enough. But really understanding the root cause behind this limitation
> > > > will be very helpful. I don't have the same appreciation of why this is
> > > > a problem, and shedding more light will help me to think more about it in the
> > > > future.
> > > > 
> > > 
> > > Take the example of 1k cores with per cpu policy. Do you really think a
> > > for_each_cpufreq_policy would be reasonable ?
> > 
> > Hmm I don't think such an HMP system makes sense to ever exist.
> > 
> > That system has to be a multi-socket system and I doubt inversion detection is
> > something of value.
> > 
> > Point taken anyway. Let's find another way to do this.
> > 
> 
> Another way might be to use the 'update' code path, which sets this
> information source, for the thermal pressure. That code path isn't as
> hot as this in the task scheduler. Furthermore, we would also
> have time and handle properly CPU hotplug callbacks there.
> 
> So something like this, I have in mind:
> 
> ------------------------------8<-----------------------------
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index e7d6e6657ffa..7f372a93e21b 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -16,6 +16,7 @@
>  #include <linux/sched/topology.h>
>  #include <linux/cpuset.h>
>  #include <linux/cpumask.h>
> +#include <linux/mutex.h>
>  #include <linux/init.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
> @@ -153,6 +154,33 @@ void topology_set_freq_scale(const struct cpumask
> *cpus, unsigned long cur_freq,
>  DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
>  DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
>  EXPORT_PER_CPU_SYMBOL_GPL(cpu_scale);
> 
> +static struct cpumask highest_capacity_mask;
> 
> +static struct cpumask highest_capacity_mask;
> +static unsigned int max_possible_capacity;
> +static DEFINE_MUTEX(max_capacity_lock);
> +
> +static void max_capacity_update(const struct cpumask *cpus,
> +                               unsigned long capacity)
> +{
> +       mutex_lock(&max_capacity_lock);
> +
> +       if (max_possible_capacity < capacity) {
> +               max_possible_capacity = capacity;
> +
> +               cpumask_clear(&highest_capacity_mask);
> +
> +               cpumask_or(&highest_capacity_mask,
> +                          &highest_capacity_mask, cpus);
> +       }
> +
> +       mutex_unlock(&max_capacity_lock);
> +}
> +
> +bool topology_test_max_cpu_capacity(unsigned int cpu)
> +{
> +       return cpumask_test_cpu(cpu, &highest_capacity_mask);
> +}
> +EXPORT_SYMBOL_GPL(topology_test_max_cpu_capacity);
> +
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>  {
>         per_cpu(cpu_scale, cpu) = capacity;
> @@ -203,6 +231,8 @@ void topology_update_thermal_pressure(const struct
> cpumask *cpus,
> 
>         for_each_cpu(cpu, cpus)
>                 WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
> +
> +       max_capacity_update(cpus, capacity);
>  }
>  EXPORT_SYMBOL_GPL(topology_update_thermal_pressure);
> 
> 
> --------------------------->8--------------------------------
> 
> We could use the RCU if there is a potential to read racy date
> while the updater modifies the mask in the meantime. Mutex is to
> serialize the thermal writers which might be kicked for two
> policies at the same time.
> 
> If you like I can develop and test such code in the arch_topology.c

As we discussed offline, Vincent is keen on decoupling the util_fits_cpu()
logic from HMP - which means I need to reword this differently.

Let's keep this in the back burner in case we need to revisit it again.

Appreciate the proposal!!


Many thanks

--
Qais Yousef
