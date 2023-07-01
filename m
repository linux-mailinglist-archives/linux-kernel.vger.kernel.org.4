Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE556744AD2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGASR4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Jul 2023 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGASRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 14:17:54 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C71BC6;
        Sat,  1 Jul 2023 11:17:53 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so4458924276.1;
        Sat, 01 Jul 2023 11:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688235472; x=1690827472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgbI56nnbOX7WhFj+KJtKuAzNzhUoMUsJk0mZzG98eQ=;
        b=WLjeXN3JpOIlC2+u0h4TKJzg0obaQAqC5xF8/q6PAi6PxNVEfgMzx9CB2u7CnJOco6
         8xhOcc2S6kgbPW+5oXddOsxBRm9Blz70cqLHlhH901RspWyQyb6q+zs31lJ0Gwtmu1I/
         kObR/kvTDsbPl7aaE8mmuwQzyiTI9DKwDrJFYOPGIbqbC8q4qxFFo3WacwkaW99PzHH0
         NzGv1oAPSww7mEtj/3r6gwf5s1ioVonuoPPZhKuJRN/wu579h9EPWCQWMO6K9IYfVjHD
         v1rCrEbN+MnoY+FYjbMNZFsYRs7d9oDc7PRnskJEfUrdgOZNqgef8+eCN2khnctygrm9
         Pheg==
X-Gm-Message-State: ABy/qLbsC1tPu9iI3gNdTN5aXYY7r8hKZSjhen8JKOe28PMrEHevOWRT
        ugGZDM72oSOl2Snlr6AemCcM80Q46L0S8s/BMN4=
X-Google-Smtp-Source: APBJJlEXcL5nDNV6sm/lt5bWSltLXADmCHoMzR3A1HKCNHANZZJeGTGssYjdfP83vMgVHnFGuGFnrNm7ReYQa95fYUM=
X-Received: by 2002:a25:a227:0:b0:bcd:1e9:3703 with SMTP id
 b36-20020a25a227000000b00bcd01e93703mr12091529ybi.21.1688235472430; Sat, 01
 Jul 2023 11:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230630085230.437-1-ravi.bangoria@amd.com>
In-Reply-To: <20230630085230.437-1-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 1 Jul 2023 11:17:41 -0700
Message-ID: <CAM9d7chYnT2s1V1juP+EyewJfRD+2qHGs2pwghh=k3kFf1P9BA@mail.gmail.com>
Subject: Re: [PATCH v3] perf evsel amd: Fix IBS error message
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, peterz@infradead.org, irogers@google.com,
        jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Fri, Jun 30, 2023 at 1:53 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> AMD IBS can do per-process profiling[1] and is no longer restricted to
> per-cpu or systemwide only. Remove stale error message. Also, checking
> just exclude_kernel is not sufficient since IBS does not support any
> privilege filters. So include all exclude_* checks. And finally, move
> these checks under tools/perf/arch/x86/ from generic code.
>
> Before:
>   $ sudo ./perf record -e ibs_op//k -C 0
>   Error:
>   AMD IBS may only be available in system-wide/per-cpu mode.  Try
>   using -a, or -C and workload affinity
>
> After:
>   $ sudo ./perf record -e ibs_op//k -C 0
>   Error:
>   AMD IBS doesn't support privilege filtering. Try again without
>   the privilege modifiers (like 'k') at the end.
>
> [1] https://git.kernel.org/torvalds/c/30093056f7b2
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
> v2: https://lore.kernel.org/r/20230626103958.834-1-ravi.bangoria@amd.com
> v2->v3:
>   - Make error message more perf tool user friendly.
>
>  tools/perf/arch/x86/util/evsel.c | 20 ++++++++++++++++++++
>  tools/perf/util/evsel.c          | 30 +++++++++---------------------
>  tools/perf/util/evsel.h          |  1 +
>  3 files changed, 30 insertions(+), 21 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 512c2d885d24..af454fd07887 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -102,3 +102,23 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
>                 }
>         }
>  }
> +
> +int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size)
> +{
> +       if (!x86__is_amd_cpu())
> +               return 0;
> +
> +       if (!evsel->core.attr.precise_ip &&
> +           !(evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3)))
> +               return 0;
> +
> +       /* More verbose IBS errors. */
> +       if (evsel->core.attr.exclude_kernel || evsel->core.attr.exclude_user ||
> +           evsel->core.attr.exclude_hv || evsel->core.attr.exclude_idle ||
> +           evsel->core.attr.exclude_host || evsel->core.attr.exclude_guest) {
> +               return scnprintf(msg, size, "AMD IBS doesn't support privilege filtering. Try "
> +                                "again without the privilege modifiers (like 'k') at the end.");
> +       }
> +
> +       return 0;
> +}
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f607b5bddc76..762e2b2634a5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2924,25 +2924,19 @@ static bool find_process(const char *name)
>         return ret ? false : true;
>  }
>
> -static bool is_amd(const char *arch, const char *cpuid)
> +int __weak arch_evsel__open_strerror(struct evsel *evsel __maybe_unused,
> +                                    char *msg __maybe_unused,
> +                                    size_t size __maybe_unused)
>  {
> -       return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
> -}
> -
> -static bool is_amd_ibs(struct evsel *evsel)
> -{
> -       return evsel->core.attr.precise_ip
> -           || (evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3));
> +       return 0;
>  }
>
>  int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                          int err, char *msg, size_t size)
>  {
> -       struct perf_env *env = evsel__env(evsel);
> -       const char *arch = perf_env__arch(env);
> -       const char *cpuid = perf_env__cpuid(env);
>         char sbuf[STRERR_BUFSIZE];
>         int printed = 0, enforced = 0;
> +       int ret;
>
>         switch (err) {
>         case EPERM:
> @@ -3044,16 +3038,6 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                         return scnprintf(msg, size,
>         "Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
>                                         evsel__name(evsel));
> -               if (is_amd(arch, cpuid)) {
> -                       if (is_amd_ibs(evsel)) {
> -                               if (evsel->core.attr.exclude_kernel)
> -                                       return scnprintf(msg, size,
> -       "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
> -                               if (!evsel->core.system_wide)
> -                                       return scnprintf(msg, size,
> -       "AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
> -                       }
> -               }
>
>                 break;
>         case ENODATA:
> @@ -3063,6 +3047,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                 break;
>         }
>
> +       ret = arch_evsel__open_strerror(evsel, msg, size);
> +       if (ret)
> +               return ret;
> +
>         return scnprintf(msg, size,
>         "The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
>         "/bin/dmesg | grep -i perf may provide additional information.\n",
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 9f06d6cd5379..848534ec74fa 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -311,6 +311,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
>
>  void arch_evsel__set_sample_weight(struct evsel *evsel);
>  void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
> +int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t size);
>
>  int evsel__set_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
> --
> 2.41.0
>
