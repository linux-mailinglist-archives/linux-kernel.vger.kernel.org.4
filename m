Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3405E737307
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFTRgy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 13:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjFTRgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:36:52 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D6E10C1;
        Tue, 20 Jun 2023 10:36:48 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-988a4a7be58so75775666b.0;
        Tue, 20 Jun 2023 10:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687282607; x=1689874607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuvZxVykzv8i0fEnOLvP4a311RK4pUX7xiEei9YewKE=;
        b=EVC980wri9bA+J3Fjmeg/irfpK0xBr9kBoZVtAXhkec73VPkZJy4gn0+ywLJ2rYmmK
         RyVJK4hQtybp2HkZ4REwP32RlIBTqv8AEI0hMbS5xh9JYZoKjje6T8rLHLOlQT+GiKKD
         pgq536YHrbHUUqnC2a31KHSS2yJWmrCHZJLe8t8aNi6GtnrfNq2xJIWI9jP07pJyN4y+
         bquSQMoIBD/2kQJs5RKl45gUN437Wj1RwhVt70tbhH/WjnGmj71HDHUIu4UzHFF0U0YW
         JzbsLPWAHsaDxUmXz37le+5BvzO2cBd0i9pAnCZC3qd2l/5fkTF0SHRwvgd9IOC+u1nY
         NiJA==
X-Gm-Message-State: AC+VfDyZeWN/3hsZrmKq6s8b7MjiUy7f92zYKKiV3f0t4t9/tBg+vUiT
        9S0mjgjMeMyXgcGitlYhcB56CL093uk2NuvgfcymldRx
X-Google-Smtp-Source: ACHHUZ76ayD0RiZmNi9FXWKMvBgdyu3CdmRmeJgZQ3kWfHy1tkdC5fkppGjuV11Q8hHn3RHClQ/a+c3QZMWwE+Buyio=
X-Received: by 2002:a17:906:74da:b0:974:5480:6270 with SMTP id
 z26-20020a17090674da00b0097454806270mr9076756ejl.0.1687282607075; Tue, 20 Jun
 2023 10:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230522145702.2419654-1-lukasz.luba@arm.com> <20230522145702.2419654-3-lukasz.luba@arm.com>
In-Reply-To: <20230522145702.2419654-3-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 19:36:36 +0200
Message-ID: <CAJZ5v0i+iY-xknvEZn8Se06XS3Cqyqo3p=fYcsLoFBQ7geKRHA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2 2/3] cpufreq: schedutil: Refactor
 sugov_update_shared() internals
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, delyank@fb.com,
        qyousef@google.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 4:57 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Remove the if section block. Use the simple check to bail out
> and jump to the unlock at the end. That makes the code more readable
> and ready for some future tracing.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e3211455b203..f462496e5c07 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -446,17 +446,19 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
>
>         ignore_dl_rate_limit(sg_cpu);
>
> -       if (sugov_should_update_freq(sg_policy, time)) {
> -               next_f = sugov_next_freq_shared(sg_cpu, time);
> +       if (!sugov_should_update_freq(sg_policy, time))
> +               goto unlock;
>
> -               if (!sugov_update_next_freq(sg_policy, time, next_f))
> -                       goto unlock;
> +       next_f = sugov_next_freq_shared(sg_cpu, time);
> +
> +       if (!sugov_update_next_freq(sg_policy, time, next_f))
> +               goto unlock;
> +
> +       if (sg_policy->policy->fast_switch_enabled)
> +               cpufreq_driver_fast_switch(sg_policy->policy, next_f);
> +       else
> +               sugov_deferred_update(sg_policy);
>
> -               if (sg_policy->policy->fast_switch_enabled)
> -                       cpufreq_driver_fast_switch(sg_policy->policy, next_f);
> -               else
> -                       sugov_deferred_update(sg_policy);
> -       }
>  unlock:
>         raw_spin_unlock(&sg_policy->update_lock);
>  }
> --

The first patch in the series needs some feedback from the scheduler
people, but I can apply this one right away if you want me to.
