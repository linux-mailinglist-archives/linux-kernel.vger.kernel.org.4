Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8EF710553
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjEYFa5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 01:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjEYFa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:30:56 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E4C9C;
        Wed, 24 May 2023 22:30:54 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-456fe3597bdso113104e0c.0;
        Wed, 24 May 2023 22:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684992653; x=1687584653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Xh0Vn9KzZCtUCAw6GpkLdF92gEyREy+XoFZlbU+VHA=;
        b=QVzLW81k2zEPME0SjSKY2AUhoNqcmqObC+MO/WJ/+4WlVoec+DJ9azEEpju6fJYdn5
         Ny+VyUWNURdJ4ae1cz25aT/KojfTPNRKx2Y9i2YOVHIP/oLYbfB4gA4l/Bghj1/aRs1n
         H39zjloyyLbF2rA0/oltUObhlvXFUpI6LNO650EtwxegyKYQHpPgpniaiDcEEPfMHACv
         Jow8llcY/+Ox8LdL1MISGR3EDWyNfurNXQ3X/mWT8kxPdKsHRiG1N6JgBEGo5qxk2Y2Y
         eNh9yVYvkos8PThV5xcFIIS7AumzHJ7NSBcJ59Lwhys02by4Oj7RhTQcLXAa13msy63F
         eRZA==
X-Gm-Message-State: AC+VfDx1vtfhSpmiSV9APNJqFqQRfKGcLxdWNdQedMTmJdIjCiKegxW2
        iWS9nJLNQd7ThiW6tIq8uhJHvHi3g6aa/NCb3tU=
X-Google-Smtp-Source: ACHHUZ4gM+e0+iu5fU2ScDoza6sA0PdTWhkDFpjCnW25ahJB3HG/1nvz/Gj7cba5CyoutlltqNRnrDprrap2m9xtw/w=
X-Received: by 2002:a1f:45cf:0:b0:44f:c1a7:ceff with SMTP id
 s198-20020a1f45cf000000b0044fc1a7ceffmr581404vka.6.1684992653502; Wed, 24 May
 2023 22:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com> <20230524221831.1741381-10-irogers@google.com>
In-Reply-To: <20230524221831.1741381-10-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 24 May 2023 22:30:41 -0700
Message-ID: <CAM9d7ci21E+BFHPtbx4iO=pcgs2Y7ZCCVsjD-b5OWMdPLb0-6A@mail.gmail.com>
Subject: Re: [PATCH v3 09/35] perf evlist: Propagate user CPU maps
 intersecting core PMU maps
To:     Ian Rogers <irogers@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

Hi Ian,

On Wed, May 24, 2023 at 3:19 PM Ian Rogers <irogers@google.com> wrote:
>
> The CPU map for a non-core PMU gives a default CPU value for
> perf_event_open. For core PMUs the CPU map lists all CPUs the evsel
> may be opened on. If there are >1 core PMU, the CPU maps will list the
> CPUs for that core PMU, but the user_requested_cpus may contain CPUs
> that are invalid for the PMU and cause perf_event_open to fail. To
> avoid this, when propagating the CPU map for core PMUs intersect it
> with the CPU map of the PMU (the evsel's "own_cpus").
>
> Add comments to __perf_evlist__propagate_maps to explain its somewhat
> complex behavior.

Thanks for tackling this.  There are many assumptions on this code
which make this code hard to understand.  I think we need to list
all possible cases and make the logic as simple as possible.

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/evlist.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 81e8b5fcd8ba..b8b066d0dc5e 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -36,18 +36,33 @@ void perf_evlist__init(struct perf_evlist *evlist)
>  static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>                                           struct perf_evsel *evsel)
>  {
> -       /*
> -        * We already have cpus for evsel (via PMU sysfs) so
> -        * keep it, if there's no target cpu list defined.
> -        */

So basically this code is only needed when the user specified a cpu list.
Otherwise evsels can use their own cpus.  But it's a kind of sad that
libperf does not have a notion of PMU (with a cpu map) yet.

I think we have the following cases.  Please tell me if I miss some.

1. non-hybrid core PMU: It used to not have a cpu map, but you added it
   in this patchset to cover all (online) CPUs.  So it'd be ok to treat them as
   same as the hybrid PMUs.

2. hybrid core PMU: It has a cpu map to cover possible CPUs and the
   user requested cpu map should be intersected with its map.

3. uncore PMU: It has a cpu map to indicate CPUs to handle event
   settings but it's allowed to read the event from other CPUs (at least
   for Intel CPUs).  That means it can just use the user request cpu map.

4. dummy event: It can be marked as system-wide to get the sideband
   events from all CPUs.  Then it should ignore the user requested cpu
   map.  Otherwise it should be treated as other events.

5. tool event: It's used for perf stat and has a hardcoded cpu map for
   CPU 0.  Not sure if it can accept other CPUs but it seems we can ignore
   the user requested cpu map.

6. other event: No restrictions.  It can use the user requested cpu map.


>         if (evsel->system_wide) {
> +               /* System wide: set the cpu map of the evsel to all online CPUs. */
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__new(NULL);
> +       } else if (evlist->has_user_cpus && evsel->is_pmu_core) {
> +               /*
> +                * User requested CPUs on a core PMU, ensure the requested CPUs
> +                * are valid by intersecting with those of the PMU.
> +                */
> +               perf_cpu_map__put(evsel->cpus);
> +               evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
>         } else if (!evsel->own_cpus || evlist->has_user_cpus ||
> -                  (!evsel->requires_cpu && perf_cpu_map__empty(evlist->user_requested_cpus))) {
> +               (!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
> +               /*
> +                * The PMU didn't specify a default cpu map, this isn't a core
> +                * event and the user requested CPUs or the evlist user
> +                * requested CPUs have the "any CPU" (aka dummy) CPU value. In
> +                * which case use the user requested CPUs rather than the PMU
> +                * ones.
> +                */
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>         } else if (evsel->cpus != evsel->own_cpus) {
> +               /*
> +                * No user requested cpu map but the PMU cpu map doesn't match
> +                * the evsel's. Reset it back to the PMU cpu map.
> +                */

Not sure if it actually happens.

Thanks,
Namhyung


>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
>         }
> --
> 2.40.1.698.g37aff9b760-goog
>
