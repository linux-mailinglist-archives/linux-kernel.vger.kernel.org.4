Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F862BB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbiKPLNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiKPLNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:13:14 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6CE57B41
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:00:36 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i5so8911017ilc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4QOjFN/Je4Gn0mjRNwSTUGIImeYdhKzGuLoPtH22l8s=;
        b=OvcPKLAUFjT+OTTHT3o1xqICgOAMG3+z3bjJO0td614fQYlBPQCSslezt/hi8sue6/
         C0e0Z/bJg5DaYj1N4ZK2wLSNwKMfdWnOzOjFRPSqbRG53dx2K2LZYGSF76PUWnLWg2uD
         /bSAvh2FW2OJ2PbKfxT8+9ZpChhtholk1TnDP2tQ0hcCQMNbegwTSZ8DHKpq28lUIqfO
         gAfTbgiNI4Cv9+q5j+CnjZ1smjO88tzbSLquAnBk4EOZmOyylAFxEEA4woNRy8WAddsX
         kpM4eQ5urzyKdXsvlqcyfAoIKfWnHqDuT09MPynL7/O9t6/V2eMJHcS4aiJeqG1AIzIB
         TA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QOjFN/Je4Gn0mjRNwSTUGIImeYdhKzGuLoPtH22l8s=;
        b=A0kzkpt0A2Co7EqBeYwAPhOJsHKroSxinrd9MO23BnZaV+OjPwh4ia8CtYiJKU/LWH
         TsTR4VHSGTUOuA1Syp8ukuqXYtuXqqLUCuH+c9yTMjA3kPLwFNBIibF886yqZQkZp+pR
         3Jz8Kcr9VHrRibU7399YKjgRd4s9qspXSPi70oAIqqknsoWV2SDco5BsNAiMN+CJAx3w
         V2OD1Yqk3rY6tUbstGa2edahqqPf1PbtfopYS0duA3Cej0+w3YgqgJM/HW1GsNjGEar8
         6mIdFABXvyQ/G8e7ldjpD1ITM27h3O8xJkdybo2clXb2mGSnj1ymXjzOPqmhpE8tV533
         k+ow==
X-Gm-Message-State: ANoB5plYodULFBcFpXjIgmI4mmcuSbFojSFYfbtb8q6PourP3gizQ8K/
        03pBiQCDBiEZNbY/lFwvG1uht5IDpugnR47cmDCU9Q==
X-Google-Smtp-Source: AA0mqf4nWwIv1l2q1wq/1SU+XkrmU39wdEzD3cDZ2V0rszjuVL9m7lgmsNfcXbyl7SZ5nqxM9L8vGfBSzuWUUad65c4=
X-Received: by 2002:a05:6e02:eee:b0:2ff:7103:cb2d with SMTP id
 j14-20020a056e020eee00b002ff7103cb2dmr10499165ilk.232.1668596436176; Wed, 16
 Nov 2022 03:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20221116091027.78906-1-wanghonglei@didiglobal.com>
In-Reply-To: <20221116091027.78906-1-wanghonglei@didiglobal.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Nov 2022 12:00:24 +0100
Message-ID: <CAKfTPtCthYY9HxaNDyHYszgJctrjTiWPF=AYaj2dLhcB5X=NYw@mail.gmail.com>
Subject: Re: [PATCH] sched/core: use correct cpu_capacity in wake_affine_weight()
To:     Honglei Wang <wanghonglei@didiglobal.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 at 10:12, Honglei Wang <wanghonglei@didiglobal.com> wrote:
>
> It seems make more sense to do the load weight calculation with
> respective cpu_capacity.
>
> Signed-off-by: Honglei Wang <wanghonglei@didiglobal.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..a9f75040969b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6262,13 +6262,13 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
>         this_eff_load += task_load;
>         if (sched_feat(WA_BIAS))
>                 this_eff_load *= 100;
> -       this_eff_load *= capacity_of(prev_cpu);
> +       this_eff_load *= capacity_of(this_cpu);
>
>         prev_eff_load = cpu_load(cpu_rq(prev_cpu));
>         prev_eff_load -= task_load;
>         if (sched_feat(WA_BIAS))
>                 prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
> -       prev_eff_load *= capacity_of(this_cpu);
> +       prev_eff_load *= capacity_of(prev_cpu);

we want to test :
    (cpu_load(this_rq) + task_h_load(p) ) / capacity_of(this_cpu)  <
cpu_load(prev_rq) / capacity_of(prev_cpu)

but instead of doing expensive division, we do the below which gives
the same result
    (cpu_load(this_rq) + task_h_load(p) ) * capacity_of(prev_cpu)  <
cpu_load(prev_rq) * capacity_of(this_cpu)


>
>         /*
>          * If sync, adjust the weight of prev_eff_load such that if
> --
> 2.14.1
>
