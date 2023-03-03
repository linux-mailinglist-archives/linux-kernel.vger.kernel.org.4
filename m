Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4592A6A8DCB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCCATI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCCATG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:19:06 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1B32E73;
        Thu,  2 Mar 2023 16:19:05 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-536be69eadfso13801407b3.1;
        Thu, 02 Mar 2023 16:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677802744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkur7b8jZEPmIF+3JE2JI9efBnZwTz/TN+SAbxotz2g=;
        b=g12kR6ybj2MHD9I8U5Jlri4vfCWw94bQzYA/vwcpkAFWfCrF2WoiP02zwdAxLFVhic
         +c15WEbb023E9SOltZWGqils5yvgp6aLsHd/LC8h1e6G0t4Iw33Zo8dL4XKNEiRl9cXH
         XsAFHLhu+1wg9duMTBrdksH6zeqYAyxaCqmlPJG93iTrXeq5mNE3MERGf5R0MnOYvv4Z
         qX5BzycOemdTv2MuXMyBesEOjiIveh/6io5R7uPPPwo4qfwc+qpq6sMW5lOYw7TV4qpx
         RhI6tbG2z9thfYZW+g/AWnvqZmXjRYlPfi+nX9BqTCy05IA1NdwukA0M9o1e6WB8M8ax
         KyOw==
X-Gm-Message-State: AO0yUKVnn1TLZZZ1CVnvkslW8FvjZPYbA+KdQlKheukgEZThXA4DysDb
        itbG+ECCy8W18+uSC1vWpHcO00UROW5v3QTwx3s=
X-Google-Smtp-Source: AK7set9sEnJ4SH/lVIvBwTVs63bUu0/IMcoEkNcPKDZzOrW2XMKkg6y+pUkXrMUn2ixCpLGmyZlP0DmDnkkONM3WCtc=
X-Received: by 2002:a81:440c:0:b0:533:99bb:c299 with SMTP id
 r12-20020a81440c000000b0053399bbc299mr7545017ywa.3.1677802744542; Thu, 02 Mar
 2023 16:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com> <20230302212531.1043318-7-irogers@google.com>
In-Reply-To: <20230302212531.1043318-7-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Mar 2023 16:18:53 -0800
Message-ID: <CAM9d7chd+fz6LCJWZHdFLmtRBYPyU-pxbtT8YzORhGGBjSCMzQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] perf evsel: Add function to compute pmu_name
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 1:26 PM Ian Rogers <irogers@google.com> wrote:
>
> The computed pmu_name respects software events and aux event groups,
> such that the pmu_name is changed to be that of the aux event leader
> or group leader for software events. This is done as a later change
> will split events that are in different PMUs into different groups.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>  tools/perf/util/evsel.h |  1 +
>  2 files changed, 25 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2dc2c24252bb..9c6b486f8bd4 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -821,6 +821,30 @@ const char *evsel__name(struct evsel *evsel)
>         return "unknown";
>  }
>
> +const char *evsel__pmu_name(const struct evsel *evsel)
> +{
> +       const struct evsel *leader;
> +
> +       /* If the pmu_name is set use it. pmu_name isn't set for CPU and software events. */
> +       if (evsel->pmu_name)
> +               return evsel->pmu_name;

I'm wondering if we can just use evsel->pmu->name if it's set.

> +       /*
> +        * Software events may be in a group with other uncore PMU events. Use
> +        * the pmu_name of the group leader to avoid breaking the software event
> +        * out of the group.
> +        *
> +        * Aux event leaders, like intel_pt, expect a group with events from
> +        * other PMUs, so substitute the AUX event's PMU in this case.
> +        */

Looks like we need to rename this function as it doesn't simply return
the pmu name in the above cases.  Maybe evsel__group_pmu_name() ?

Thanks,
Namhyung


> +       leader  = evsel__leader(evsel);
> +       if ((evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) &&
> +           leader->pmu_name) {
> +               return leader->pmu_name;
> +       }
> +
> +       return "cpu";
> +}
> +
>  const char *evsel__metric_id(const struct evsel *evsel)
>  {
>         if (evsel->metric_id)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 676c499323e9..72121194d3b1 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -280,6 +280,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
>
>  int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
>  const char *evsel__name(struct evsel *evsel);
> +const char *evsel__pmu_name(const struct evsel *evsel);
>  const char *evsel__metric_id(const struct evsel *evsel);
>
>  static inline bool evsel__is_tool(const struct evsel *evsel)
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
