Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7715FA7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJJWx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJJWxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:53:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A8B79ECF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:53:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bi26-20020a05600c3d9a00b003c1e11f54d2so6105855wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/7dBLvcYggq0WlSYa7mtXAxbb5Cng6Hp/hFVrEbwzw=;
        b=J9LdGmZKcfPt6F+ikOtoqh9Xvdmp7IkzhQK98M3fOznPeTEkmpk8yNzmy4+48rE0J0
         7Kcuh57dA8NWOo6YjdkC3X0GOodDM9zHsWMa4JBHnfThfd832MT05WWtJZpGucf0UKGY
         DcuwAOQTKOz9kcSQ08tmvmjAYfsEGP5pQOJS2DIwnE9/ph0dihRl84L5zkDbqFSiXjnT
         lD4BKHxL2F8SZSX4C+FzLEkLGgfq714K7JwzTqgc0LjPUXCtK3zYbMvbYxPFGtx41rV/
         ndE7zwIxVrjPrg2LvF43vS1C3jOwPRTPJG1IFcVMWIYrzZGzzwAy20Sa6oR/g/nX9B49
         XsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/7dBLvcYggq0WlSYa7mtXAxbb5Cng6Hp/hFVrEbwzw=;
        b=dxz0kxhMFH5vBTBmHIfMAv87ilbDa1H3pFk1uzBmIq76nW50xcPw85szsGdKlVp6su
         z5jUn4DhrWJ/urIbFxv/q0W1pB2d4i0J0MCCWatEt4rXap+ADIDZK1SV+VP8tN6mC0eX
         1VTJgBbsgqhqmbHz4hGGefghZiO7x0/CpPSXn+r22C2Ln8t4/VHlgrBgnox3W44P5+7J
         bHt/ssF3R8a2F7wOktMntyIEXJlN88fc2BO5jyRWCwNyEBvEyzAnFiSbRKhMh4XIiUeR
         5a/WxJBCSUUwKDm0lDYYsokL06ttplM7FWDnXJVg6eoQ+TbLhJVyf5aXJ2MlkufYwPEd
         L51A==
X-Gm-Message-State: ACrzQf377XDhjqot2YEMmqS36+ZVqB0Ta4CEGZdG2hhiZ2A9CeS4wi0K
        MCX7aniOGkNETX8ZpN9Sl6VZprIoBAfJX2vN6hJWKA==
X-Google-Smtp-Source: AMsMyM5/vTRfmBmpbvrKwlrvzMtzpAS136crdZ8ProtuYh2cC6nFUKMMnFyYj8u5fIH7nXBFKndBuY7I5+XzeB3p3sA=
X-Received: by 2002:a05:600c:88a:b0:3c5:c9e3:15cc with SMTP id
 l10-20020a05600c088a00b003c5c9e315ccmr7002458wmp.67.1665442402945; Mon, 10
 Oct 2022 15:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-7-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 15:53:10 -0700
Message-ID: <CAP-5=fWe5sgNJTYyLf26jmF6whHVGth5Ss+0TE_JNOJ_gEs76g@mail.gmail.com>
Subject: Re: [PATCH 06/19] perf stat: Add 'needs_sort' argument to cpu_aggr_map__new()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
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

On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> In case of no aggregation, it needs to keep the original (cpu) ordering
> in the aggr_map so that it can be in sync with the cpu map.  This will
> make the code easier to handle AGGR_NONE similar to others.
>

The CPU map is sorted and so sorting the aggr_map should be fine. If
the data is already sorted then it is O(n) to sort. I think this is
preferable to having additional complexity around whether the aggr_map
is sorted.

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 7 +++++--
>  tools/perf/util/cpumap.c  | 6 ++++--
>  tools/perf/util/cpumap.h  | 2 +-
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b00ef20aef5b..e5ddf60ab31d 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1461,8 +1461,9 @@ static int perf_stat_init_aggr_mode(void)
>         aggr_cpu_id_get_t get_id = aggr_mode__get_aggr(stat_config.aggr_mode);
>
>         if (get_id) {
> +               bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
>                 stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
> -                                                        get_id, /*data=*/NULL);
> +                                                        get_id, /*data=*/NULL, needs_sort);
>                 if (!stat_config.aggr_map) {
>                         pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
>                         return -1;
> @@ -1677,11 +1678,13 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
>  {
>         struct perf_env *env = &st->session->header.env;
>         aggr_cpu_id_get_t get_id = aggr_mode__get_aggr_file(stat_config.aggr_mode);
> +       bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
>
>         if (!get_id)
>                 return 0;
>
> -       stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus, get_id, env);
> +       stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
> +                                                get_id, env, needs_sort);
>         if (!stat_config.aggr_map) {
>                 pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
>                 return -1;
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 60209fe87456..6e3fcf523de9 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -234,7 +234,7 @@ static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
>
>  struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
>                                        aggr_cpu_id_get_t get_id,
> -                                      void *data)
> +                                      void *data, bool needs_sort)
>  {
>         int idx;
>         struct perf_cpu cpu;
> @@ -270,8 +270,10 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
>                 if (trimmed_c)
>                         c = trimmed_c;
>         }
> +
>         /* ensure we process id in increasing order */
> -       qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
> +       if (needs_sort)
> +               qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
>
>         return c;
>
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index b2ff648bc417..da28b3146ef9 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -97,7 +97,7 @@ typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(struct perf_cpu cpu, void *data)
>   */
>  struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
>                                        aggr_cpu_id_get_t get_id,
> -                                      void *data);
> +                                      void *data, bool needs_sort);
>
>  bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
>  bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a);
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
