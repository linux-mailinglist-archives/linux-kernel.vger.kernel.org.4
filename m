Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E0164C119
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbiLNATx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLNATa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:19:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA4965CC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:18:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso3778476wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E8lBAvMUbSarOvBnBi7Cy+Xm1lvvYValWY+7vlRPdgA=;
        b=E78rr4cbJo6XYu+wDZPWGNQuktj7gpgEnD45pbxHQN63on6NbyD1u7Az5EtM7RgzxM
         3Ufry04woZyjm6S8qtJb7uoTAZ9TW4/0nyI+jVTGgle0j9fOrqdRrey5CCC8GAglznaA
         DKh3ts2gKmQQPYIXWsOopNEoGtXvXmQ2CklP5EuF7+1p11z9iMOseglGg6D8gA78CvlX
         6MAKdUsaNo1yiS8aYS8g32Z0g/i57rbvIXCli90IkLBZq7hUe1MjyGOF/mR+4SR2DOhg
         ccYklEhGXQGHZaw+ik/s2jaVkgLtQIT99w/w8b1YG8rZjbtjRJDw5UbaSh04PXoiO1uO
         tGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8lBAvMUbSarOvBnBi7Cy+Xm1lvvYValWY+7vlRPdgA=;
        b=7rJmRjgmtsr5T3Bt5U8Z2n5DwP4o3EEWWN3f3EyA5hWqK4//u8uIXmuFUZSc4uu08k
         MbB+/F2XEG1LTuOUkHQD7TUHocnY1znppvf9nh2Q928jDImFQNvUZZR/h6mIf2z2BJ+E
         Nnmp1NIIR4G5dhOa1q7Wxc4CFUjJ1B2R5Q02DBc4nXpnlgJWv0a/ZBlfunn9iBu7jAcV
         90LfgTOCHbDv9oQpQUz+uJ62dyQxdqYNImIKqAw8Ade67R9DCOMqHeirY/lCqgbCh6Qy
         JAjbbrEJ6GWujNbdZa4beoW4wSjcAi07ORtZd9lIrL3A0tL2MOAw0vm3y79Mc08q7jXD
         OhOg==
X-Gm-Message-State: ANoB5pnj958hFce9elNmSeQw00GEkNh0r4ZKwG+Cv+gjkw7gjipqq01W
        b7QmXFYhYHCWytQeaXI4Tom1vra29a9TNfecw+nw/g==
X-Google-Smtp-Source: AA0mqf5MLuP3NYBWv5mB/DHXIafSAjDm3AQT1rtH62Wy21w/CcE4rpap1LMZ66/oXUtfQT6H+J9M/dcOWOU4iC844Ss=
X-Received: by 2002:a1c:7c05:0:b0:3cf:cb16:f24a with SMTP id
 x5-20020a1c7c05000000b003cfcb16f24amr24690wmc.182.1670977118978; Tue, 13 Dec
 2022 16:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20221212230820.901382-1-namhyung@kernel.org>
In-Reply-To: <20221212230820.901382-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Dec 2022 16:18:26 -0800
Message-ID: <CAP-5=fWGX12LhziS1LG7UwyEtdaJdNoiqc6KBEav0XkSOZ_bww@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Do not delay the workload with --delay
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kevin Nomura <nomurak@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 3:08 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The -D/--delay option is to delay the measure after the program starts.
> But the current code goes to sleep before starting the program so the
> program is delayed too.  This is not the intention, let's fix it.
>
> Before:
>
>   $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
>   Events disabled
>   Events enabled
>
>    Performance counter stats for 'system wide':
>
>        4,326,949,337      cycles
>
>          4.007494118 seconds time elapsed
>
>   real  0m7.474s
>   user  0m0.356s
>   sys   0m0.120s
>
> It ran the workload for 4 seconds and gave the 3 second delay.  So it
> should skip the first 3 second and measure the last 1 second only.  But
> as you can see, it delays 3 seconds and ran the workload after that for
> 4 seconds.  So the total time (real) was 7 seconds.
>
> After:
>
>   $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
>   Events disabled
>   Events enabled
>
>    Performance counter stats for 'system wide':
>
>        1,063,551,013      cycles
>
>          1.002769510 seconds time elapsed
>
>   real  0m4.484s
>   user  0m0.385s
>   sys   0m0.086s

The commit message feels like it could almost be turned into a shell
test. The test would need some fudge factors in case of load on the
test system. Any thoughts if we could add this? We wouldn't need to
rely on 'time' as we have tool events of user_time, system_time, etc.

Thanks,
Ian

> The bug was introduced when it changed enablement of system-wide events
> with a command line workload.  But it should've considered the initial
> delay case.  The code was reworked since then (in bb8bc52e7578) so I'm
> afraid it won't be applied cleanly.
>
> Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Reported-by: Kevin Nomura <nomurak@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d040fbcdcc5a..b39bf785a16e 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -540,26 +540,14 @@ static int enable_counters(void)
>                         return err;
>         }
>
> -       if (stat_config.initial_delay < 0) {
> -               pr_info(EVLIST_DISABLED_MSG);
> -               return 0;
> -       }
> -
> -       if (stat_config.initial_delay > 0) {
> -               pr_info(EVLIST_DISABLED_MSG);
> -               usleep(stat_config.initial_delay * USEC_PER_MSEC);
> -       }
> -
>         /*
>          * We need to enable counters only if:
>          * - we don't have tracee (attaching to task or cpu)
>          * - we have initial delay configured
>          */
> -       if (!target__none(&target) || stat_config.initial_delay) {
> +       if (!target__none(&target)) {
>                 if (!all_counters_use_bpf)
>                         evlist__enable(evsel_list);
> -               if (stat_config.initial_delay > 0)
> -                       pr_info(EVLIST_ENABLED_MSG);
>         }
>         return 0;
>  }
> @@ -930,14 +918,27 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>                         return err;
>         }
>
> -       err = enable_counters();
> -       if (err)
> -               return -1;
> +       if (stat_config.initial_delay) {
> +               pr_info(EVLIST_DISABLED_MSG);
> +       } else {
> +               err = enable_counters();
> +               if (err)
> +                       return -1;
> +       }
>
>         /* Exec the command, if any */
>         if (forks)
>                 evlist__start_workload(evsel_list);
>
> +       if (stat_config.initial_delay > 0) {
> +               usleep(stat_config.initial_delay * USEC_PER_MSEC);
> +               err = enable_counters();
> +               if (err)
> +                       return -1;
> +
> +               pr_info(EVLIST_ENABLED_MSG);
> +       }
> +
>         t0 = rdclock();
>         clock_gettime(CLOCK_MONOTONIC, &ref_time);
>
> --
> 2.39.0.rc1.256.g54fd8350bd-goog
>
