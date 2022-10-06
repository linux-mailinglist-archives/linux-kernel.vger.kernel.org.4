Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6C65F63ED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiJFJ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiJFJ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:57:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F881680
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:57:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d6so1899737lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=opxhvMyksIWC/XaTujBMKI+eEiNMJ9sC/vnX4uFYn3Y=;
        b=yWESaXjvwPXqPDLYpE+GwxV87Vp+ib2StS/dQLfGll3KZLdQx4FxwiC7A6uYED3oMe
         F7gZzqvOazykM12q9cSqMpk5TyV/VOkrdPQv7kRHc0SN1TV45hkvQxlSVmOxGuASZDby
         oT9jR3M9vvzAK0nbh+fV6SjcKiFiHJKhZHTD/TH6pCUYOn2S1YzO3RFbqE4KNoSnnLJC
         Qg5ukIfyCSZdZFUS1BukVJJedy5jgnvy7ROt1mErolImNlfoQlfpyP3yZLbQMdH5bLli
         azHFv3O3YzZOK4nu/1d7fJzemcQqBlQaM7Ik0USlYyCXez9h9mUvzFVXCKsh8iUBpsn0
         yjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=opxhvMyksIWC/XaTujBMKI+eEiNMJ9sC/vnX4uFYn3Y=;
        b=fXCgwY7CXNbeXKhwCipoaVpvBoLnJ8BSadVf9m9ZYYAZS8YOMLHCDjEd30BMVl8P89
         HsTHIV9w1DWnOdFMdMqGjp17CIw186CRg4al5JcoDa76zq09chIlGXTi4kGhbjC7d40S
         Jlt8Pf9TFwoqocYZ9VFH0Kk4zwvrvJROZNmjUYrt/glKUIyzAsow2zDT7o3qOkYLWDCI
         nw3aC6NKIooFAdXjpxKgHRA3rrWEvPwSdS++pMOGsNgoOfuno8sjdfkZjHxWahlLBxvO
         5iA/f3DyQPtcqkLHzt6/wtiPQaNqTVDrvBzZc0BFFQSlCzRViMvJNY4vFMbUkMvaSB3Y
         1rqw==
X-Gm-Message-State: ACrzQf0o11YBENfPUF9qbd8oUyqKHuPWxQSeCRbVcTLLmxSDVfZq0cin
        TPH6aEZL7N5YO2wN6RtDUe891o91CRvYFxvY15qOFBZapj4=
X-Google-Smtp-Source: AMsMyM72QSALP475xAlHfSfAwVDI552DOgoGPlPsNoq8lu+E46LTwcS1rG9vHK0eIhdqTqES/LZdF5cTo2kNzUsKgvs=
X-Received: by 2002:a05:6512:22c3:b0:4a2:7da9:440c with SMTP id
 g3-20020a05651222c300b004a27da9440cmr81562lfu.490.1665050222657; Thu, 06 Oct
 2022 02:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221006081052.3862167-1-pierre.gondois@arm.com> <20221006081052.3862167-2-pierre.gondois@arm.com>
In-Reply-To: <20221006081052.3862167-2-pierre.gondois@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 6 Oct 2022 11:56:51 +0200
Message-ID: <CAKfTPtB9z4MJj5aMM7CZSVmw_xgF-ijpph0igTNTONYZHvwu0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sched/fair: Check if prev_cpu has highest spare
 cap in feec()
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 at 10:11, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> When evaluating the CPU candidates in the perf domain (pd) containing
> the previously used CPU (prev_cpu), find_energy_efficient_cpu()
> evaluates the energy of the pd:
> - without the task (base_energy)
> - with the task placed on prev_cpu (if the task fits)
> - with the task placed on the CPU with the highest spare capacity,
>   prev_cpu being excluded from this set
>
> If prev_cpu is already the CPU with the highest spare capacity,
> max_spare_cap_cpu will be the CPU with the second highest spare
> capacity.
>
> On an Arm64 Juno-r2, with a workload of 10 tasks at a 10% duty cycle,
> when prev_cpu and max_spare_cap_cpu are both valid candidates,
> prev_spare_cap > max_spare_cap at ~82%.
> Thus the energy of the pd when placing the task on max_spare_cap_cpu
> is computed with no possible positive outcome 82% most of the time.
>
> Do not consider max_spare_cap_cpu as a valid candidate if
> prev_spare_cap > max_spare_cap.
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

nit: the reviewed tag should be after the signed-off

> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 914096c5b1ae..bcae7bdd5582 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6900,7 +6900,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>         for (; pd; pd = pd->next) {
>                 unsigned long cpu_cap, cpu_thermal_cap, util;
>                 unsigned long cur_delta, max_spare_cap = 0;
> -               bool compute_prev_delta = false;
> +               unsigned long prev_spare_cap = 0;
>                 int max_spare_cap_cpu = -1;
>                 unsigned long base_energy;
>
> @@ -6944,18 +6944,19 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>                         if (cpu == prev_cpu) {
>                                 /* Always use prev_cpu as a candidate. */
> -                               compute_prev_delta = true;
> +                               prev_spare_cap = cpu_cap;
>                         } else if (cpu_cap > max_spare_cap) {
>                                 /*
>                                  * Find the CPU with the maximum spare capacity
> -                                * in the performance domain.
> +                                * among the remaining CPUs in the performance
> +                                * domain.
>                                  */
>                                 max_spare_cap = cpu_cap;
>                                 max_spare_cap_cpu = cpu;
>                         }
>                 }
>
> -               if (max_spare_cap_cpu < 0 && !compute_prev_delta)
> +               if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
>                         continue;
>
>                 eenv_pd_busy_time(&eenv, cpus, p);
> @@ -6963,7 +6964,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                 base_energy = compute_energy(&eenv, pd, cpus, p, -1);
>
>                 /* Evaluate the energy impact of using prev_cpu. */
> -               if (compute_prev_delta) {
> +               if (prev_spare_cap > 0) {
>                         prev_delta = compute_energy(&eenv, pd, cpus, p,
>                                                     prev_cpu);
>                         /* CPU utilization has changed */
> @@ -6974,7 +6975,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                 }
>
>                 /* Evaluate the energy impact of using max_spare_cap_cpu. */
> -               if (max_spare_cap_cpu >= 0) {
> +               if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
>                         cur_delta = compute_energy(&eenv, pd, cpus, p,
>                                                    max_spare_cap_cpu);
>                         /* CPU utilization has changed */
> --
> 2.25.1
>
