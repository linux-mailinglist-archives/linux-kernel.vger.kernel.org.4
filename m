Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10822749E21
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjGFNtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGFNtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:49:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615D81997
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:49:42 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-401f4408955so246581cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688651381; x=1691243381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qjrs9y1+GJUuPnn18k+vb9OkRR0jNttB2jc3w3xRULQ=;
        b=5wUT4ToI98Qy4bdev4umtuVDFIUEPoTE+oSuKc/mLtcojiO2BHtIjQXC4F6xzk5Sji
         aDxsP5IUh+5Nm5lNfZz3cfStZmqY36KL5bChjDdkfqjN/S6PO8DXqMRaYz2ahtskGXbY
         fm2HHIhp+1DzTihITsv8g8GHjXQvoMpnyCf3W/Cu8qWkYzBrflk5DnQiwg9sVuQr0kVn
         Ghh1mOmRFrUPsfXBe5SLBJec1cuLu2sNMNjZ93xYC1MHSZVqAmPIK1rgFSvm6QOSLv8g
         Ngi1racyE2IWKuZjo57dkCcxvdKxDINepAxSCFyV2ad7XANbyFZY0r7L7KhoFZvlljZh
         2njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651381; x=1691243381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qjrs9y1+GJUuPnn18k+vb9OkRR0jNttB2jc3w3xRULQ=;
        b=i1Zu1SnnblIU5AOfRRFFuwjkCpLpqptEzgXKHOFZ07JKx9QbVnMYH8Utrq6JAficH5
         ZYbZK9JO11/iHlcJ8XCuY9Pz8RUwv6myCs6Zll0Fu2YGyp/hpc2gOkO3WXnpU8zzAj9U
         24+MpdTSx/n0gwWZXYN/mbe9jsvwIW+V2RGWoiKdhNXfc2Jk7UvI2p2AmPCzzQXgIVF+
         myYI3OAC2hg2Rmt3wTtxvCIPChrzEapKTeJmNPFLqoLHo3I40//pcgLM/sdZB3b4HiKn
         YWX80zBjvDcoB0tMQVL+ZYRqAtFk64JHLifQ8fhSC8SsAtqiJv/o84Ii+EY+O4XR84S8
         vQ9w==
X-Gm-Message-State: ABy/qLas3lNeMIqn4Jd3UgGBMu7PTQL8KNxzxe3ENduuExzZ3YJhDX4G
        H8obQV/Exu55i1rylzDcDJosJ6DnwiIlM6w/6IPPpQ==
X-Google-Smtp-Source: APBJJlH977fTwY4ekritFy0dCZ7iWDMdIA/nBhEdFTp+WSE+WFPNMHbU07a9N6mpwG5Wo+f8+BSUUKO/5YLOrnb9CA8=
X-Received: by 2002:ac8:5b05:0:b0:3ef:2f55:2204 with SMTP id
 m5-20020ac85b05000000b003ef2f552204mr239850qtw.6.1688651381265; Thu, 06 Jul
 2023 06:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230706063440.54189-1-sandipan.das@amd.com>
In-Reply-To: <20230706063440.54189-1-sandipan.das@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Jul 2023 06:49:29 -0700
Message-ID: <CAP-5=fVdVSL4H1qWLZMiU3H2-bOJ0RkFOfq4Jxz1qw0-8EoYFw@mail.gmail.com>
Subject: Re: [PATCH v2] perf vendor events amd: Fix large metrics
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        ayush.jain3@amd.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
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

On Wed, Jul 5, 2023 at 11:34=E2=80=AFPM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> There are cases where a metric requires more events than the number of
> available counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four
> data fabric counters but the "nps1_die_to_dram" metric has eight events.
> By default, the constituent events are placed in a group and since the
> events cannot be scheduled at the same time, the metric is not computed.
> The "all metrics" test also fails because of this.
>
> Use the NO_GROUP_EVENTS constraint for such metrics which anyway expect
> the user to run perf with "--metric-no-group".
>
> E.g.
>
>   $ sudo perf test -v 101
>
> Before:
>
>   101: perf all metrics test                                           :
>   --- start ---
>   test child forked, pid 37131
>   Testing branch_misprediction_ratio
>   Testing all_remote_links_outbound
>   Testing nps1_die_to_dram
>   Metric 'nps1_die_to_dram' not printed in:
>   Error:
>   Invalid event (dram_channel_data_controller_4) in per-thread mode, enab=
le system wide with '-a'.
>   Testing macro_ops_dispatched
>   Testing all_l2_cache_accesses
>   Testing all_l2_cache_hits
>   Testing all_l2_cache_misses
>   Testing ic_fetch_miss_ratio
>   Testing l2_cache_accesses_from_l2_hwpf
>   Testing l2_cache_misses_from_l2_hwpf
>   Testing op_cache_fetch_miss_ratio
>   Testing l3_read_miss_latency
>   Testing l1_itlb_misses
>   test child finished with -1
>   ---- end ----
>   perf all metrics test: FAILED!
>
> After:
>
>   101: perf all metrics test                                           :
>   --- start ---
>   test child forked, pid 43766
>   Testing branch_misprediction_ratio
>   Testing all_remote_links_outbound
>   Testing nps1_die_to_dram
>   Testing macro_ops_dispatched
>   Testing all_l2_cache_accesses
>   Testing all_l2_cache_hits
>   Testing all_l2_cache_misses
>   Testing ic_fetch_miss_ratio
>   Testing l2_cache_accesses_from_l2_hwpf
>   Testing l2_cache_misses_from_l2_hwpf
>   Testing op_cache_fetch_miss_ratio
>   Testing l3_read_miss_latency
>   Testing l1_itlb_misses
>   test child finished with 0
>   ---- end ----
>   perf all metrics test: Ok
>
> Reported-by: Ayush Jain <ayush.jain3@amd.com>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Acked-by: Ian Rogers <irogers@google.com>

Will there be a PMU driver fix so that the perf_event_open fails for
the group? That way the weak group would work.

Thanks,
Ian

> ---
>
> Previous versions can be found at:
> v1: https://lore.kernel.org/all/20230614090710.680330-1-sandipan.das@amd.=
com/
>
> Changes in v2:
> - As suggested by Ian, use the NO_GROUP_EVENTS constraint instead of
>   retrying the test scenario with --metric-no-group.
> - Change the commit message accordingly.
>
>  tools/perf/pmu-events/arch/x86/amdzen1/recommended.json | 3 ++-
>  tools/perf/pmu-events/arch/x86/amdzen2/recommended.json | 3 ++-
>  tools/perf/pmu-events/arch/x86/amdzen3/recommended.json | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen1/recommended.json
> index bf5083c1c260..4d28177325a0 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
> @@ -169,8 +169,9 @@
>    },
>    {
>      "MetricName": "nps1_die_to_dram",
> -    "BriefDescription": "Approximate: Combined DRAM B/bytes of all chann=
els on a NPS1 node (die) (may need --metric-no-group)",
> +    "BriefDescription": "Approximate: Combined DRAM B/bytes of all chann=
els on a NPS1 node (die)",
>      "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_co=
ntroller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_=
3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_=
channel_data_controller_6 + dram_channel_data_controller_7",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
>      "MetricGroup": "data_fabric",
>      "PerPkg": "1",
>      "ScaleUnit": "6.1e-5MiB"
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen2/recommended.json
> index a71694a043ba..60e19456d4c8 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
> @@ -169,8 +169,9 @@
>    },
>    {
>      "MetricName": "nps1_die_to_dram",
> -    "BriefDescription": "Approximate: Combined DRAM B/bytes of all chann=
els on a NPS1 node (die) (may need --metric-no-group)",
> +    "BriefDescription": "Approximate: Combined DRAM B/bytes of all chann=
els on a NPS1 node (die)",
>      "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_co=
ntroller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_=
3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_=
channel_data_controller_6 + dram_channel_data_controller_7",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
>      "MetricGroup": "data_fabric",
>      "PerPkg": "1",
>      "ScaleUnit": "6.1e-5MiB"
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen3/recommended.json
> index 988cf68ae825..3e9e1781812e 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
> @@ -205,10 +205,11 @@
>    },
>    {
>      "MetricName": "nps1_die_to_dram",
> -    "BriefDescription": "Approximate: Combined DRAM B/bytes of all chann=
els on a NPS1 node (die) (may need --metric-no-group)",
> +    "BriefDescription": "Approximate: Combined DRAM B/bytes of all chann=
els on a NPS1 node (die)",
>      "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_co=
ntroller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_=
3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_=
channel_data_controller_6 + dram_channel_data_controller_7",
>      "MetricGroup": "data_fabric",
>      "PerPkg": "1",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
>      "ScaleUnit": "6.1e-5MiB"
>    }
>  ]
> --
> 2.34.1
>
