Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAED1646AAD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLHIiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLHIiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:38:00 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3123A31DE3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:37:59 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id g20so349187iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc02ZfrYOJ3+oJFjjLedRFiQuFgTS0ibOsHmLGsOq1s=;
        b=SBf4qsXMiYTRUzMgRFTlaE6NAOf5FNKX2hHcsPvW0zoMyzf+W2AZMbBTFyKaIdnbP9
         TvsZzNWQfFuh38MVCiNfUyQSc7nzXLncW0WFIG3FGMar6jOW/qJ2NDKWbjsKvzWa5StN
         I0eAVuaVNkrEltBmn2/BQvM1CWarMEk+UKc60J10qNHzjGEmFVDAhg0vFIyvBY7FR0ew
         SxRcIa5gLlEk6WoU9XYQlIw4cLW5xk4UaTRhyFTWeIHQsM8xl2BozD6eu3U/f8DnKhUK
         +Ar2V7QMXKaxQf2PIzAjCNOKmhbBpoBQezhG6CAXENQ1xpAb80Ef0K0Gp/1RfY+dnsG6
         T0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mc02ZfrYOJ3+oJFjjLedRFiQuFgTS0ibOsHmLGsOq1s=;
        b=eJFWsz7K51gGnCZ7O79ac7RvN46RY9zRNBILFeRKTDMT4zCPe0TGIRdPrqO41D/si7
         7Q+w+5FkhP3It/emw4aaxFeHqFlwiVb0Nb5APGQP+qV5wR9GyicnUOQoVGdTf4MG7XQn
         dnMxtYYtuyuIWcmFrnZHgf/yt15JitJiZcU5MSZpB7fqDCgtkpzchZ82TZwvDz5luWRJ
         lyK8Ko0ySj4Dp89CrwxHS29wp0GBFN/VWN3BUq9Owlah7VGNq79KRDeC1pzLt2pNwiuL
         unp2bG61ULtos11SBwj9kLnxu82aTGcT9WEYiiHRmQ42Li8sHZzX3Ly/sWcpwlNrH3PL
         6z3w==
X-Gm-Message-State: ANoB5plo+A1S9BZEn3hJ3ekpPYw8eUcpW0CPJVS0E7GUIUfLZmJhR0QI
        YP9KJMggJk2xv6PSJDUdOoyv5Yj7zTPYzNoNZap8gw==
X-Google-Smtp-Source: AA0mqf6rj5WxqJdQ5U5VKCUfb5VL+yDTa+9Uxc+7TZaty5sKReLB8Ovbc/Wnf4ZzlJC8Z8YOa3jeD0h5UVRN4JoRwQg=
X-Received: by 2002:a05:6638:328a:b0:386:eaa7:85dd with SMTP id
 f10-20020a056638328a00b00386eaa785ddmr32566226jav.120.1670488678426; Thu, 08
 Dec 2022 00:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20221207101705.9460-1-lukasz.luba@arm.com> <20221207101705.9460-3-lukasz.luba@arm.com>
In-Reply-To: <20221207101705.9460-3-lukasz.luba@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 8 Dec 2022 09:37:47 +0100
Message-ID: <CAKfTPtB8f0RH4qToLrWS+HSZhm8pyUe42DijiXZqo+mQQPWetQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: schedutil: Optimize operations with
 single max CPU capacity
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, saravanak@google.com,
        wusamuel@google.com, isaacmanjarres@google.com,
        kernel-team@android.com, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 at 11:17, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The max CPU capacity is the same for all CPUs sharing frequency domain
> and thus 'policy' object. There is a way to avoid heavy operations
> in a loop for each CPU by leveraging this knowledge. Thus, simplify
> the looping code in the sugov_next_freq_shared() and drop heavy
> multiplications. Instead, use simple max() to get the highest utilization
> from these CPUs. This is useful for platforms with many (4 or 6) little
> CPUs.
>
> The max CPU capacity must be fetched every time we are called, due to
> difficulties during the policy setup, where we are not able to get the
> normalized CPU capacity at the right time.
>
> The stored value in sugov_policy::max is also than used in
> sugov_iowait_apply() to calculate the right boost. Thus, that field is
> useful to have in that sugov_policy struct.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index c19d6de67b7a..f9881f3d9488 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -158,10 +158,8 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>
>  static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
> -       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         struct rq *rq = cpu_rq(sg_cpu->cpu);
>
> -       sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
>         sg_cpu->bw_dl = cpu_bw_dl(rq);
>         sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
>                                           FREQUENCY_UTIL, NULL);
> @@ -317,6 +315,8 @@ static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
>  static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>                                               u64 time, unsigned int flags)
>  {
> +       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> +
>         sugov_iowait_boost(sg_cpu, time, flags);
>         sg_cpu->last_update = time;
>
> @@ -325,6 +325,9 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>         if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
>                 return false;
>
> +       /* Fetch the latest CPU capcity to avoid stale data */
> +       sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
> +
>         sugov_get_util(sg_cpu);
>         sugov_iowait_apply(sg_cpu, time);
>
> @@ -414,25 +417,22 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>  {
>         struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         struct cpufreq_policy *policy = sg_policy->policy;
> -       unsigned long util = 0, max = 1;
> +       unsigned long util = 0;
>         unsigned int j;
>
> +       /* Fetch the latest CPU capcity to avoid stale data */
> +       sg_policy->max = arch_scale_cpu_capacity(sg_cpu->cpu);
> +
>         for_each_cpu(j, policy->cpus) {
>                 struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> -               unsigned long j_util, j_max;
>
>                 sugov_get_util(j_sg_cpu);
>                 sugov_iowait_apply(j_sg_cpu, time);
> -               j_util = j_sg_cpu->util;
> -               j_max = j_sg_cpu->max;
>
> -               if (j_util * max > j_max * util) {
> -                       util = j_util;
> -                       max = j_max;
> -               }

With the code removed above, max is only used in 2 places:
- sugov_iowait_apply
- map_util_freq

I wonder if it would be better to just call arch_scale_cpu_capacity()
in these 2 places instead of saving a copy in sg_policy and then
reading it twice.

arch_scaleu_cpu_capacity is already a per_cpu variable so accessing it
should be pretty cheap.

Thought ?

> +               util = max(j_sg_cpu->util, util);
>         }
>
> -       return get_next_freq(sg_policy, util, max);
> +       return get_next_freq(sg_policy, util, sg_policy->max);
>  }
>
>  static void
> --
> 2.17.1
>
