Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC30372EC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbjFMTfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFMTfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:35:38 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9588D1A5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:35:36 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f9d619103dso50941cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686684935; x=1689276935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiAF3kAOYkUZZIcSDbIuL88XjyxUPzE0weWW6oYui9Q=;
        b=jZGmjwN2X1fPuoZu0p1Or24B8ISkCIC4KlvDwAQ0sPFNB4Y6rB1uyVtWZAKqmjQ+R8
         mJAXJC1SnePo+97kZ0OwmuHH+d0AFtJXr8uFo+U6hjkhCigx4hSmGdzqFf5uLBKbue8e
         yBc+nGy6j2vWHgHQCkCOXtvTyWltMBods0zKIUKr5HMe0RwK7XBk/jFiUVWdE/SaKfbf
         xJX57AFDM/3/cpUuZNiJRQ8C65Oxd3PLb2VVn/fQdCrlV46hJ/QoATvNewBExZcl+5AR
         wNYKbQmqNWUxrbRaq26HBYYfx7JiDbLww8dL/zB7Xg+lyWddIqIiRombr7cRcx+p6hKD
         xqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684935; x=1689276935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiAF3kAOYkUZZIcSDbIuL88XjyxUPzE0weWW6oYui9Q=;
        b=Cfz5OmT01BOt+s3iONV+CI3UJqppkfV+Q/te5uoT2UkvPNrQzVJW42ow93YF4bkr2/
         7vqgrqkEUsHm1DUHvLUuaSGRGR9CjsR5+O2r1yLRSILgJc4J4tOIfuXNd2xwKjPliH2K
         drzxhCm6Xg6eEtQK6E299lqoBv1QU6SBZnX3pNFKTJw0OB+mV+q/1x+iK77FtHjgqDoY
         QM+wmYn1neiErmHFLFa010od2SRboFa+npGP8e6Dy+My7Mw69a3IhFzIRuiQbmTL6ISE
         Ffzvb0cHwVWHrnqRRRVzZ+/MdkYqAhYhJlFKeNleMGmgh60aZzCEmDwSM8AC4dBJs8+m
         c8VA==
X-Gm-Message-State: AC+VfDyIfRcPaCMvFcnahE1cFpxEsC1IWjZH2mE5/vgA81t4nHh7M72B
        Q0deaFL11/d+Cr20RqJtVbDkCJ1wuPRSup4c0XGjyA==
X-Google-Smtp-Source: ACHHUZ4FrNChAbBbzoooEPuLjh5XF49D88KtX77mgzfKA3ftGtZ3VjZhnKIQACGTx26uoruAzfNl17JOHBeQ9QAH3HM=
X-Received: by 2002:ac8:5814:0:b0:3f9:b81c:3a0f with SMTP id
 g20-20020ac85814000000b003f9b81c3a0fmr27920qtg.17.1686684935598; Tue, 13 Jun
 2023 12:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com> <20230607162700.3234712-3-kan.liang@linux.intel.com>
In-Reply-To: <20230607162700.3234712-3-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 12:35:24 -0700
Message-ID: <CAP-5=fVz1zgwdJVs1V7putUdp9wf-QKWH1Ky-heLoHWgnJu6dg@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf evsel: Fix the annotation for hardware events on hybrid
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 9:27=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The annotation for hardware events is wrong on hybrid. For example,
>
>  # ./perf stat -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>          32,148.85 msec cpu-clock                        #   32.000 CPUs =
utilized
>                374      context-switches                 #   11.633 /sec
>                 33      cpu-migrations                   #    1.026 /sec
>                295      page-faults                      #    9.176 /sec
>         18,979,960      cpu_core/cycles/                 #  590.378 K/sec
>        261,230,783      cpu_atom/cycles/                 #    8.126 M/sec=
                       (54.21%)
>         17,019,732      cpu_core/instructions/           #  529.404 K/sec
>         38,020,470      cpu_atom/instructions/           #    1.183 M/sec=
                       (63.36%)
>          3,296,743      cpu_core/branches/               #  102.546 K/sec
>          6,692,338      cpu_atom/branches/               #  208.167 K/sec=
                       (63.40%)
>             96,421      cpu_core/branch-misses/          #    2.999 K/sec
>          1,016,336      cpu_atom/branch-misses/          #   31.613 K/sec=
                       (63.38%)
>
> The hardware events have extended type on hybrid, but the evsel__match()
> doesn't take it into account.
>
> Add a mask to filter the extended type on hybrid when checking the config=
.
>
> With the patch,
>
>  # ./perf stat -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>          32,139.90 msec cpu-clock                        #   32.003 CPUs =
utilized
>                343      context-switches                 #   10.672 /sec
>                 32      cpu-migrations                   #    0.996 /sec
>                 73      page-faults                      #    2.271 /sec
>         13,712,841      cpu_core/cycles/                 #    0.000 GHz
>        258,301,691      cpu_atom/cycles/                 #    0.008 GHz  =
                       (54.20%)
>         12,428,163      cpu_core/instructions/           #    0.91  insn =
per cycle
>         37,786,557      cpu_atom/instructions/           #    2.76  insn =
per cycle              (63.35%)
>          2,418,826      cpu_core/branches/               #   75.259 K/sec
>          6,965,962      cpu_atom/branches/               #  216.739 K/sec=
                       (63.38%)
>             72,150      cpu_core/branch-misses/          #    2.98% of al=
l branches
>          1,032,746      cpu_atom/branch-misses/          #   42.70% of al=
l branches             (63.35%)
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/evsel.h       | 12 ++++++-----
>  tools/perf/util/stat-shadow.c | 39 +++++++++++++++++++----------------
>  2 files changed, 28 insertions(+), 23 deletions(-)
>
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index b365b449c6ea..36a32e4ca168 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -350,9 +350,11 @@ u64 format_field__intval(struct tep_format_field *fi=
eld, struct perf_sample *sam
>
>  struct tep_format_field *evsel__field(struct evsel *evsel, const char *n=
ame);
>
> -#define evsel__match(evsel, t, c)              \
> +#define EVSEL_EVENT_MASK                       (~0ULL)
> +
> +#define evsel__match(evsel, t, c, m)                   \
>         (evsel->core.attr.type =3D=3D PERF_TYPE_##t &&      \
> -        evsel->core.attr.config =3D=3D PERF_COUNT_##c)
> +        (evsel->core.attr.config & m) =3D=3D PERF_COUNT_##c)

The EVSEL_EVENT_MASK here isn't very intention revealing, perhaps we
can remove it and do something like:

static inline bool __evsel__match(const struct evsel *evsel, u32 type,
u64 config)
{
  if ((type =3D=3D PERF_TYPE_HARDWARE || type =3D=3DPERF_TYPE_HW_CACHE)  &&
perf_pmus__supports_extended_type())
     return (evsel->core.attr.config & PERF_HW_EVENT_MASK) =3D=3D config;

  return evsel->core.attr.config =3D=3D config;
}
#define evsel__match(evsel, t, c) __evsel__match(evsel, PERF_TYPE_##t,
PERF_COUNT_##c)

Thanks,
Ian

>
>  static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
>  {
> @@ -438,13 +440,13 @@ bool evsel__is_function_event(struct evsel *evsel);
>
>  static inline bool evsel__is_bpf_output(struct evsel *evsel)
>  {
> -       return evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
> +       return evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT, EVSEL_EVENT_M=
ASK);
>  }
>
>  static inline bool evsel__is_clock(const struct evsel *evsel)
>  {
> -       return evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
> -              evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
> +       return evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK, EVSEL_EVENT_MA=
SK) ||
> +              evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK, EVSEL_EVENT_M=
ASK);
>  }
>
>  bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msg=
size);
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 1566a206ba42..074f38b57e2d 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -6,6 +6,7 @@
>  #include "color.h"
>  #include "debug.h"
>  #include "pmu.h"
> +#include "pmus.h"
>  #include "rblist.h"
>  #include "evlist.h"
>  #include "expr.h"
> @@ -78,6 +79,8 @@ void perf_stat__reset_shadow_stats(void)
>
>  static enum stat_type evsel__stat_type(const struct evsel *evsel)
>  {
> +       u64 mask =3D perf_pmus__supports_extended_type() ? PERF_HW_EVENT_=
MASK : EVSEL_EVENT_MASK;
> +
>         /* Fake perf_hw_cache_op_id values for use with evsel__match. */
>         u64 PERF_COUNT_hw_cache_l1d_miss =3D PERF_COUNT_HW_CACHE_L1D |
>                 ((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
> @@ -97,41 +100,41 @@ static enum stat_type evsel__stat_type(const struct =
evsel *evsel)
>
>         if (evsel__is_clock(evsel))
>                 return STAT_NSECS;
> -       else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
> +       else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES, mask))
>                 return STAT_CYCLES;
> -       else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS))
> +       else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS, mask))
>                 return STAT_INSTRUCTIONS;
> -       else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND=
))
> +       else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND=
, mask))
>                 return STAT_STALLED_CYCLES_FRONT;
> -       else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)=
)
> +       else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND,=
 mask))
>                 return STAT_STALLED_CYCLES_BACK;
> -       else if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS))
> +       else if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS, ma=
sk))
>                 return STAT_BRANCHES;
> -       else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES))
> +       else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES, mask))
>                 return STAT_BRANCH_MISS;
> -       else if (evsel__match(evsel, HARDWARE, HW_CACHE_REFERENCES))
> +       else if (evsel__match(evsel, HARDWARE, HW_CACHE_REFERENCES, mask)=
)
>                 return STAT_CACHE_REFS;
> -       else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES))
> +       else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES, mask))
>                 return STAT_CACHE_MISSES;
> -       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1D))
> +       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1D, mask))
>                 return STAT_L1_DCACHE;
> -       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1I))
> +       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1I, mask))
>                 return STAT_L1_ICACHE;
> -       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_LL))
> +       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_LL, mask))
>                 return STAT_LL_CACHE;
> -       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_DTLB))
> +       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_DTLB, mask))
>                 return STAT_DTLB_CACHE;
> -       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_ITLB))
> +       else if (evsel__match(evsel, HW_CACHE, HW_CACHE_ITLB, mask))
>                 return STAT_ITLB_CACHE;
> -       else if (evsel__match(evsel, HW_CACHE, hw_cache_l1d_miss))
> +       else if (evsel__match(evsel, HW_CACHE, hw_cache_l1d_miss, mask))
>                 return STAT_L1D_MISS;
> -       else if (evsel__match(evsel, HW_CACHE, hw_cache_l1i_miss))
> +       else if (evsel__match(evsel, HW_CACHE, hw_cache_l1i_miss, mask))
>                 return STAT_L1I_MISS;
> -       else if (evsel__match(evsel, HW_CACHE, hw_cache_ll_miss))
> +       else if (evsel__match(evsel, HW_CACHE, hw_cache_ll_miss, mask))
>                 return STAT_LL_MISS;
> -       else if (evsel__match(evsel, HW_CACHE, hw_cache_dtlb_miss))
> +       else if (evsel__match(evsel, HW_CACHE, hw_cache_dtlb_miss, mask))
>                 return STAT_DTLB_MISS;
> -       else if (evsel__match(evsel, HW_CACHE, hw_cache_itlb_miss))
> +       else if (evsel__match(evsel, HW_CACHE, hw_cache_itlb_miss, mask))
>                 return STAT_ITLB_MISS;
>         return STAT_NONE;
>  }
> --
> 2.35.1
>
