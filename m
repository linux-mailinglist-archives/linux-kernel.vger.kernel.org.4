Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BE56813A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjA3OoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbjA3OoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:44:12 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5677C178
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:44:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so11802782plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZGho2u6YM0rz1TL72zvwzMowIZDbxTUZ0o5oNDAiBQ=;
        b=CbpF8QLkYosO9tTKBxxdC4YVhhreVPrD773gi9bsJkMmQKsuoTVMcGSDIZd/UCCESp
         aYOHgXamc1oaigVA6UhDkqfyJQao/5RjE/yvZdlCr5aotYRN3VkioY2y8LhWS5k1TIE2
         4DJC7YbhPwf4zOaneh8vL/ueRp3eKUvCtpKV6yyjSSm5/VwRXxM6XAg4LToPuDTBuIgp
         AZXTAG+f+mKStc3rGM2DPpWPeV6rMKDsL7p/I34jVVyihHtsa1UEFIa2j8vz+Irhxcw1
         JwVqI4xJLqK/AMPHELEHk9m2KGDglg75PY8DJTdfgNR1kEHgAA2SCHm0o4SkeaWkS1r2
         R2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZGho2u6YM0rz1TL72zvwzMowIZDbxTUZ0o5oNDAiBQ=;
        b=7MaIoRsqI8o7rr5ek5F6EUJELu9v9JsXc2FMW5rZjtqBnTN7YMyVTIReaY2UBXBpik
         tDfvmbpq3aRjABPGVTsXVG5F+d8M+NUUjw1ST0FYA91ydS84vNU5RPo926U6JFtwh5yh
         8VYjAq12FrkLt5M97fgA+up7shmb71cx8XZVhoTBawXxnE3qawTOaSvNFms+lUAzDEg1
         h9a5rEr3VPmWjR9KeMOdKwaDxeOS8pa4ovZUCeJxwzv1T/dw6lDkCzuqRQOHG2i/+HF4
         bJHRY8GiEIiSUbk0uNLO3xEf6nfKuQwfk7PSvPhNqzqsgQ2gdjY3aheIF5zLKM+bwUS3
         uclQ==
X-Gm-Message-State: AO0yUKUqH+vekTfhJqstY6MyNn65rKCXUyMl9XnlmkSG0fMiQKEn25ym
        x6/DWqIRjm9NGH+bdNTRzekuMH+ywa0Ae6ihP7gb2A==
X-Google-Smtp-Source: AK7set/TKqP3sGcVaHkkt/2gWgmMAorASV9wxECMMiQria4/4ZsW+pLv8ksRzz+6LCRqrSV37zBnYypn6JD6+hwtIF0=
X-Received: by 2002:a17:902:c945:b0:196:63c8:6a92 with SMTP id
 i5-20020a170902c94500b0019663c86a92mr1176284pla.10.1675089851305; Mon, 30 Jan
 2023 06:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20230129161444.1674958-1-qyousef@layalina.io> <20230129161444.1674958-2-qyousef@layalina.io>
In-Reply-To: <20230129161444.1674958-2-qyousef@layalina.io>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 Jan 2023 15:44:00 +0100
Message-ID: <CAKfTPtCstN-oJ=UsDJrwacj8fm_cq-5N3LAWc_zz32E2FCJgBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023 at 17:14, Qais Yousef <qyousef@layalina.io> wrote:
>
> When uclamp_max is being used, the util of the task could be higher than
> the spare capacity of the CPU, but due to uclamp_max value we force fit
> it there.
>
> The way the condition for checking for max_spare_cap in
> find_energy_efficient_cpu() was constructed; it ignored any CPU that has
> its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
> max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
> hence ending up never performing compute_energy() for this cluster and
> missing an opportunity for a better energy efficient placement to honour
> uclamp_max setting.
>
>         max_spare_cap = 0;
>         cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high
>
>         ...
>
>         util_fits_cpu(...);             // will return true if uclamp_max forces it to fit
>
>         ...
>
>         // this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
>         if (cpu_cap > max_spare_cap) {
>                 max_spare_cap = cpu_cap;
>                 max_spare_cap_cpu = cpu;
>         }
>
> prev_spare_cap suffers from a similar problem.
>
> Fix the logic by treating -1UL value as 'not populated' instead of
> 0 which is a viable and correct spare capacity value.
>
> Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e29e9ea4cde8..ca2c389d3180 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7390,9 +7390,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>         for (; pd; pd = pd->next) {
>                 unsigned long util_min = p_util_min, util_max = p_util_max;
>                 unsigned long cpu_cap, cpu_thermal_cap, util;
> -               unsigned long cur_delta, max_spare_cap = 0;
> +               unsigned long cur_delta, max_spare_cap = -1UL;
>                 unsigned long rq_util_min, rq_util_max;
> -               unsigned long prev_spare_cap = 0;
> +               unsigned long prev_spare_cap = -1UL;
>                 int max_spare_cap_cpu = -1;
>                 unsigned long base_energy;
>                 int fits, max_fits = -1;
> @@ -7457,7 +7457,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                                 prev_spare_cap = cpu_cap;
>                                 prev_fits = fits;
>                         } else if ((fits > max_fits) ||
> -                                  ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> +                                  ((fits == max_fits) &&
> +                                  (cpu_cap > max_spare_cap || max_spare_cap == -1UL) {

Can't we use a signed comparison to include the case of max_spare_cap
== -1 in cpu_cap > max_spare_cap ?

>                                 /*
>                                  * Find the CPU with the maximum spare capacity
>                                  * among the remaining CPUs in the performance
> @@ -7469,7 +7470,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                         }
>                 }
>
> -               if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
> +               if (max_spare_cap_cpu < 0 && prev_spare_cap == -1UL)
>                         continue;
>
>                 eenv_pd_busy_time(&eenv, cpus, p);
> @@ -7477,7 +7478,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                 base_energy = compute_energy(&eenv, pd, cpus, p, -1);
>
>                 /* Evaluate the energy impact of using prev_cpu. */
> -               if (prev_spare_cap > 0) {
> +               if (prev_spare_cap != -1UL) {
>                         prev_delta = compute_energy(&eenv, pd, cpus, p,
>                                                     prev_cpu);
>                         /* CPU utilization has changed */
> @@ -7489,7 +7490,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                 }
>
>                 /* Evaluate the energy impact of using max_spare_cap_cpu. */
> -               if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
> +               if (max_spare_cap_cpu >= 0 &&
> +                   (max_spare_cap > prev_spare_cap || prev_spare_cap == -1UL)) {
>                         /* Current best energy cpu fits better */
>                         if (max_fits < best_fits)
>                                 continue;
> --
> 2.25.1
>
