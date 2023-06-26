Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498FF73EF0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjFZXFP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 19:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjFZXFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:05:05 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC88C2136;
        Mon, 26 Jun 2023 16:04:30 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6b2e1023f30so3720541a34.1;
        Mon, 26 Jun 2023 16:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687820664; x=1690412664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8izxeq6kLMtM19QXYiUIcEVGSyfdiUaL/XPbOk4cSs=;
        b=O+M4dPs69rV7UgCN5H41mw6SmstzU/s9gb6Lum7kAfLkcXMgffZa65Echw2zaetwmU
         IzwAzb6/ib8CAfts9BJg/Lk9Z+1iTEwcFN0qANsjnmzZgXYqKrmaMATAzTfQFbihdeIA
         9polP6z+9RoeCq/YvGY1AMR9IHmVffdWGExnFbjmyxzge44WaS0aj2qnSVZQDZbupYq8
         g4LdqdLbNA5j0vaPr4OTfn6aHasifKMvJHW5mDXhyeY57UHB9RusIr/HmCXAiy0J1Rut
         rFORlWeWcmmfoZU+OzLj5KqB6jN4ZQhANFiK4dZJyJ42ceRSSm+dEs1ytTc/h9ODkCrR
         caKQ==
X-Gm-Message-State: AC+VfDwR6ayG4h111j1idzUF9l35MdaKH3ddvOxo9EwnSISwkItCa4J/
        KtGGAWH8ZuWx+K/LKC1oUr0gFnqLQurKalSZGVx1XWQCOA4=
X-Google-Smtp-Source: ACHHUZ6iN5yMDJYcQZ3dL79fH3hM/d5K1mNjOz3moBDZh6yfWTRXV3bnn108pumkEwcmcZDFgAJPmWOnsTIQw3x2kSM=
X-Received: by 2002:a05:6358:f15:b0:12f:2563:292c with SMTP id
 b21-20020a0563580f1500b0012f2563292cmr17322364rwj.27.1687820664158; Mon, 26
 Jun 2023 16:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230626103958.834-1-ravi.bangoria@amd.com>
In-Reply-To: <20230626103958.834-1-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Jun 2023 16:04:12 -0700
Message-ID: <CAM9d7cgL2+jHtyy6k19NbmW1cD+RGRkwUANDk8xH3oGqxB0qqQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf evsel amd: Fix IBS error message
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Mon, Jun 26, 2023 at 3:40 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
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
>   AMD IBS doesn't support privilege filtering. Try again with
>   exclude_{kernel|user|hv|idle|host|guest}=0.

Can we have more user-friendly messages like below?

 "Try again without the privilege modifiers like 'k' at the end."

>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> v1: https://lore.kernel.org/r/20230621062359.201-1-ravi.bangoria@amd.com
> v1->v2:
>   - Check all exclude_* flags not just exclude_kernel
>   - Move AMD specific checks under tools/perf/arch/x86/
>
>  tools/perf/arch/x86/util/evsel.c | 25 +++++++++++++++++++++++++
>  tools/perf/util/evsel.c          | 30 +++++++++---------------------
>  tools/perf/util/evsel.h          |  1 +
>  3 files changed, 35 insertions(+), 21 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 512c2d885d24..9a7141c5a4ea 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -102,3 +102,28 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
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
> +                                "again with exclude_{kernel|user|hv|idle|host|guest}=0.");
> +       }
> +
> +       if (!evsel->core.attr.sample_period) {
> +               return scnprintf(msg, size, "AMD IBS doesn't support counting mode. Try "
> +                                "again with sample_{period|freq} with non-zero value.");

Is this for perf stat?   We don't allow zero period for perf record.

  $ perf record -F 0 true
  frequency and count are zero, aborting

Then maybe it can say: "IBS doesn't support perf stat, Use perf record."

Thanks,
Namhyung


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
