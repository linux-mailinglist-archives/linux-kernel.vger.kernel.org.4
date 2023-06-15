Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B700730ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbjFOFuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjFOFud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:50:33 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974622727
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:50:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f98276f89cso106331cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686808223; x=1689400223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN7MujmvNUTGye6GDbct2aPod7Fi2Qz4HFiOrDXh53k=;
        b=yGN+tz1C6BAOYYmAlTEvjQ4tkLu2eLJDbL9yaRaopUz1ZCa2aWhbIwiCuZ7zImrYmw
         HDZLJFLYw+IXR40dtvvh1Qgl80VkXeLRYCBHZcFD0N3af7JY02/Nxd5RCUhQj2Cy5PNf
         /kCslie2wKXX1exOi8XxlsqGu00mFRfMvusIQx+7yXDMX2d1225AgXLjymO7i9jCJrqC
         v22NaCLZrwKxH7ip0YUs32cI4DnnoHcBzg4nvx6psjkEX1PtPFd14Gfm0tvYDFsSNlO4
         nQTXLkSXrxyH12OX44YDojDBgTGrOBeMGII2Xgyir7uqCik7TlbhFpXJWg3Xuh/30xZ9
         TINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808223; x=1689400223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LN7MujmvNUTGye6GDbct2aPod7Fi2Qz4HFiOrDXh53k=;
        b=V0ZIv5tkX3OPQOnzkGzJRmQChCsAQ7Ec8lEMCtXOq1jUoSzM2Mgx0MnIGWBApemk2D
         CdeDBS5cFtJuZNj3iwiMR75HjtNU2wiQb/L9ITGtfMdVYDvGeCjrD7gopL+OUrSMeR9z
         IUrGP/v2BlTDTH6f5Qfg2KZJ64RTlMLCEZG4nuutEAejCuqIuzT5YCGemUyBgNYBR9A0
         56b4OHM7BBTr7OBCFJULdqnIc57kjSbTrg/j00jMWskQso0WgaAnUwvvzK25uOmGb0r0
         +TCSZZ40YyZkdd9NYmR+6dJ8B8wUcVB/sssie6++2FMVqVgGCDe93js2OYdLfQKKieor
         pP/Q==
X-Gm-Message-State: AC+VfDypDqk6JL9yGQSH8kdTkxX8FMV0yZgkCEhpOS0VIprN2RIyNGp1
        MBJMjwMuQgXCE9axHcArbd2VXbpxavbwcBZBYbrQHw==
X-Google-Smtp-Source: ACHHUZ4RiFyf7wFzj97tpIHjOnrgn/00yHkgQTRDT+HrhaO+E7943D5GsBLYe0u9DDBt2UszLk4ksWRJnQuqmqoIQ6k=
X-Received: by 2002:a05:622a:1212:b0:3fa:3c8f:3435 with SMTP id
 y18-20020a05622a121200b003fa3c8f3435mr79050qtx.27.1686808222748; Wed, 14 Jun
 2023 22:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230615001735.3643996-1-kan.liang@linux.intel.com> <20230615001735.3643996-3-kan.liang@linux.intel.com>
In-Reply-To: <20230615001735.3643996-3-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 22:50:10 -0700
Message-ID: <CAP-5=fUy5QHcLpMD14VQD1N5CR3wf=b5DjhCDiqcHOfx+JjZ1w@mail.gmail.com>
Subject: Re: [PATCH V2 2/8] perf metric: JSON flag to default metric group
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 5:18=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> For the default output, the default metric group could vary on different
> platforms. For example, on SPR, the TopdownL1 and TopdownL2 metrics
> should be displayed in the default mode. On ICL, only the TopdownL1
> should be displayed.
>
> Add a flag so we can tag the default metric group for different
> platforms rather than hack the perf code.
>
> The flag is added to Intel TopdownL1 since ICL and ADL, TopdownL2 metrics
> since SPR.
>
> Add a new field, DefaultMetricgroupName, in the JSON file to indicate
> the real metric group name.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arch/x86/alderlake/adl-metrics.json       | 45 ++++++++------
>  .../arch/x86/alderlaken/adln-metrics.json     | 25 ++++----
>  .../arch/x86/icelake/icl-metrics.json         | 20 ++++---
>  .../arch/x86/icelakex/icx-metrics.json        | 20 ++++---
>  .../arch/x86/sapphirerapids/spr-metrics.json  | 60 +++++++++++--------
>  .../arch/x86/tigerlake/tgl-metrics.json       | 20 ++++---
>  6 files changed, 114 insertions(+), 76 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> index c9f7e3d4ab08..85fb975b6f56 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> @@ -129,33 +129,36 @@
>      },
>      {
>          "BriefDescription": "Counts the total number of issue slots  tha=
t were not consumed by the backend due to backend stalls",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_core_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.1",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "Counts the total number of issue slots  th=
at were not consumed by the backend due to backend stalls.  Note that uops =
must be available for consumption in order for this event to count.  If a u=
op is not available (IQ is empty), this event will not count.   The rest of=
 these subevents count backend stalls, in cycles, due to an outstanding req=
uest which is memory bound vs core bound.   The subevents are not slot base=
d events and therefore can not be precisely added or subtracted from the Ba=
ckend_Bound_Aux subevents which are slot based.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
>          "BriefDescription": "Counts the total number of issue slots  tha=
t were not consumed by the backend due to backend stalls",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "tma_backend_bound",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound_aux",
>          "MetricThreshold": "tma_backend_bound_aux > 0.2",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "Counts the total number of issue slots  th=
at were not consumed by the backend due to backend stalls.  Note that UOPS =
must be available for consumption in order for this event to count.  If a u=
op is not available (IQ is empty), this event will not count.  All of these=
 subevents count backend stalls, in slots, due to a resource limitation.   =
These are not cycle based events and therefore can not be precisely added o=
r subtracted from the Backend_Bound subevents which are cycle based.  These=
 subevents are supplementary to Backend_Bound and can be used to analyze re=
sults from a resource perspective at allocation.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
>          "BriefDescription": "Counts the total number of issue slots that=
 were not consumed by the backend because allocation is stalled due to a mi=
spredicted jump or a machine clear",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "(tma_info_core_slots - (cpu_atom@TOPDOWN_FE_BOUND=
.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) /=
 tma_info_core_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "Counts the total number of issue slots tha=
t were not consumed by the backend because allocation is stalled due to a m=
ispredicted jump or a machine clear. Only issue slots wasted due to fast nu=
kes such as memory ordering nukes are counted. Other nukes are not accounte=
d for. Counts all issue slots blocked during this recovery window including=
 relevant microcode flows and while uops are not yet available in the instr=
uction queue (IQ). Also includes the issue slots that were consumed by the =
backend but were thrown away because they were younger than the mispredict =
or machine clear.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
> @@ -295,11 +298,12 @@
>      },
>      {
>          "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to frontend stalls.",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_core_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.2",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -722,11 +726,12 @@
>      },
>      {
>          "BriefDescription": "Counts the numer of issue slots  that resul=
t in retirement slots.",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.75",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -832,22 +837,24 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where no uops are being delivered due to a lack of required resources for a=
ccepting new uops in the Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdow=
n\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retir=
ing@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 where no uops are being delivered due to a lack of required resources for =
accepting new uops in the Backend. Backend is the portion of the processor =
core where the out-of-order scheduler dispatches ready uops into their resp=
ective execution units; and once completed these uops get retired according=
 to program order. For example; stalls due to data-cache misses or stalls d=
ue to the divider unit being overloaded are both categorized under Backend =
Bound. Backend Bound is further divided into two main categories: Memory Bo=
und and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
wasted due to incorrect speculations",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound +=
 tma_retiring), 0)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 wasted due to incorrect speculations. This include slots used to issue uop=
s that do not eventually get retired and slots for which the issue-pipeline=
 was blocked due to recovery from earlier incorrect speculation. For exampl=
e; wasted work due to miss-predicted branches are categorized under Bad Spe=
culation category. Incorrect data speculation followed by Memory Ordering N=
ukes is another example.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -1112,11 +1119,12 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where the processor's Frontend undersupplies its Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdow=
n\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retir=
ing@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / =
tma_info_thread_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 where the processor's Frontend undersupplies its Backend. Frontend denotes=
 the first part of the processor core responsible to fetch operations that =
are executed later on by the Backend part. Within the Frontend; a branch pr=
edictor predicts the next address to fetch; cache-lines are fetched from th=
e memory subsystem; parsed into instructions; and lastly decoded into micro=
-operations (uops). Ideally the Frontend can issue Pipeline_Width uops ever=
y cycle to the Backend. Frontend Bound denotes unutilized issue-slots when =
there is no Backend stall; i.e. bubbles where Frontend delivered no uops wh=
ile Backend could have accepted them. For example; stalls due to instructio=
n-cache misses would be categorized under Frontend Bound. Sample with: FRON=
TEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -2316,11 +2324,12 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
utilized by useful work i.e. issued uops that eventually get retired",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > =
0.1",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 utilized by useful work i.e. issued uops that eventually get retired. Idea=
lly; all pipeline slots would be attributed to the Retiring category.  Reti=
ring of 100% would indicate the maximum Pipeline_Width throughput was achie=
ved.  Maximizing Retiring typically increases the Instructions-per-cycle (s=
ee IPC metric). Note that a high Retiring value does not necessary mean the=
re is no room for more performance.  For example; Heavy-operations or Micro=
code Assists are categorized under Retiring. They often indicate suboptimal=
 performance and can often be optimized or avoided. Sample with: UOPS_RETIR=
ED.SLOTS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json =
b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> index ed9ff25a03cf..0f1628d698da 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> @@ -94,31 +94,34 @@
>      },
>      {
>          "BriefDescription": "Counts the total number of issue slots  tha=
t were not consumed by the backend due to backend stalls",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_core_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.1",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "Counts the total number of issue slots  th=
at were not consumed by the backend due to backend stalls.  Note that uops =
must be available for consumption in order for this event to count.  If a u=
op is not available (IQ is empty), this event will not count.   The rest of=
 these subevents count backend stalls, in cycles, due to an outstanding req=
uest which is memory bound vs core bound.   The subevents are not slot base=
d events and therefore can not be precisely added or subtracted from the Ba=
ckend_Bound_Aux subevents which are slot based.",
>          "ScaleUnit": "100%"
>      },
>      {
>          "BriefDescription": "Counts the total number of issue slots  tha=
t were not consumed by the backend due to backend stalls",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "tma_backend_bound",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound_aux",
>          "MetricThreshold": "tma_backend_bound_aux > 0.2",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "Counts the total number of issue slots  th=
at were not consumed by the backend due to backend stalls.  Note that UOPS =
must be available for consumption in order for this event to count.  If a u=
op is not available (IQ is empty), this event will not count.  All of these=
 subevents count backend stalls, in slots, due to a resource limitation.   =
These are not cycle based events and therefore can not be precisely added o=
r subtracted from the Backend_Bound subevents which are cycle based.  These=
 subevents are supplementary to Backend_Bound and can be used to analyze re=
sults from a resource perspective at allocation.",
>          "ScaleUnit": "100%"
>      },
>      {
>          "BriefDescription": "Counts the total number of issue slots that=
 were not consumed by the backend because allocation is stalled due to a mi=
spredicted jump or a machine clear",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "(tma_info_core_slots - (TOPDOWN_FE_BOUND.ALL + TO=
PDOWN_BE_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / tma_info_core_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "Counts the total number of issue slots tha=
t were not consumed by the backend because allocation is stalled due to a m=
ispredicted jump or a machine clear. Only issue slots wasted due to fast nu=
kes such as memory ordering nukes are counted. Other nukes are not accounte=
d for. Counts all issue slots blocked during this recovery window including=
 relevant microcode flows and while uops are not yet available in the instr=
uction queue (IQ). Also includes the issue slots that were consumed by the =
backend but were thrown away because they were younger than the mispredict =
or machine clear.",
>          "ScaleUnit": "100%"
>      },
> @@ -243,11 +246,12 @@
>      },
>      {
>          "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to frontend stalls.",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_core_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.2",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "ScaleUnit": "100%"
>      },
>      {
> @@ -612,11 +616,12 @@
>      },
>      {
>          "BriefDescription": "Counts the numer of issue slots  that resul=
t in retirement slots.",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
> -        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.75",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "ScaleUnit": "100%"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> index 20210742171d..cc4edf855064 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> @@ -111,21 +111,23 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where no uops are being delivered due to a lack of required resources for a=
ccepting new uops in the Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@I=
NT_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_thread_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 where no uops are being delivered due to a lack of required resources for =
accepting new uops in the Backend. Backend is the portion of the processor =
core where the out-of-order scheduler dispatches ready uops into their resp=
ective execution units; and once completed these uops get retired according=
 to program order. For example; stalls due to data-cache misses or stalls d=
ue to the divider unit being overloaded are both categorized under Backend =
Bound. Backend Bound is further divided into two main categories: Memory Bo=
und and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%"
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
wasted due to incorrect speculations",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound +=
 tma_retiring), 0)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 wasted due to incorrect speculations. This include slots used to issue uop=
s that do not eventually get retired and slots for which the issue-pipeline=
 was blocked due to recovery from earlier incorrect speculation. For exampl=
e; wasted work due to miss-predicted branches are categorized under Bad Spe=
culation category. Incorrect data speculation followed by Memory Ordering N=
ukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -372,11 +374,12 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where the processor's Frontend undersupplies its Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.=
UOP_DROPPING / tma_info_thread_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 where the processor's Frontend undersupplies its Backend. Frontend denotes=
 the first part of the processor core responsible to fetch operations that =
are executed later on by the Backend part. Within the Frontend; a branch pr=
edictor predicts the next address to fetch; cache-lines are fetched from th=
e memory subsystem; parsed into instructions; and lastly decoded into micro=
-operations (uops). Ideally the Frontend can issue Pipeline_Width uops ever=
y cycle to the Backend. Frontend Bound denotes unutilized issue-slots when =
there is no Backend stall; i.e. bubbles where Frontend delivered no uops wh=
ile Backend could have accepted them. For example; stalls due to instructio=
n-cache misses would be categorized under Frontend Bound. Sample with: FRON=
TEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -1378,11 +1381,12 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
utilized by useful work i.e. issued uops that eventually get retired",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_inf=
o_thread_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > =
0.1",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 utilized by useful work i.e. issued uops that eventually get retired. Idea=
lly; all pipeline slots would be attributed to the Retiring category.  Reti=
ring of 100% would indicate the maximum Pipeline_Width throughput was achie=
ved.  Maximizing Retiring typically increases the Instructions-per-cycle (s=
ee IPC metric). Note that a high Retiring value does not necessary mean the=
re is no room for more performance.  For example; Heavy-operations or Micro=
code Assists are categorized under Retiring. They often indicate suboptimal=
 performance and can often be optimized or avoided. Sample with: UOPS_RETIR=
ED.SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> index ef25cda019be..6f25b5b7aaf6 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> @@ -315,21 +315,23 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where no uops are being delivered due to a lack of required resources for a=
ccepting new uops in the Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@I=
NT_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_thread_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 where no uops are being delivered due to a lack of required resources for =
accepting new uops in the Backend. Backend is the portion of the processor =
core where the out-of-order scheduler dispatches ready uops into their resp=
ective execution units; and once completed these uops get retired according=
 to program order. For example; stalls due to data-cache misses or stalls d=
ue to the divider unit being overloaded are both categorized under Backend =
Bound. Backend Bound is further divided into two main categories: Memory Bo=
und and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%"
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
wasted due to incorrect speculations",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound +=
 tma_retiring), 0)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 wasted due to incorrect speculations. This include slots used to issue uop=
s that do not eventually get retired and slots for which the issue-pipeline=
 was blocked due to recovery from earlier incorrect speculation. For exampl=
e; wasted work due to miss-predicted branches are categorized under Bad Spe=
culation category. Incorrect data speculation followed by Memory Ordering N=
ukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -576,11 +578,12 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where the processor's Frontend undersupplies its Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.=
UOP_DROPPING / tma_info_thread_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 where the processor's Frontend undersupplies its Backend. Frontend denotes=
 the first part of the processor core responsible to fetch operations that =
are executed later on by the Backend part. Within the Frontend; a branch pr=
edictor predicts the next address to fetch; cache-lines are fetched from th=
e memory subsystem; parsed into instructions; and lastly decoded into micro=
-operations (uops). Ideally the Frontend can issue Pipeline_Width uops ever=
y cycle to the Backend. Frontend Bound denotes unutilized issue-slots when =
there is no Backend stall; i.e. bubbles where Frontend delivered no uops wh=
ile Backend could have accepted them. For example; stalls due to instructio=
n-cache misses would be categorized under Frontend Bound. Sample with: FRON=
TEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -1674,11 +1677,12 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
utilized by useful work i.e. issued uops that eventually get retired",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_inf=
o_thread_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > =
0.1",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 utilized by useful work i.e. issued uops that eventually get retired. Idea=
lly; all pipeline slots would be attributed to the Retiring category.  Reti=
ring of 100% would indicate the maximum Pipeline_Width throughput was achie=
ved.  Maximizing Retiring typically increases the Instructions-per-cycle (s=
ee IPC metric). Note that a high Retiring value does not necessary mean the=
re is no room for more performance.  For example; Heavy-operations or Micro=
code Assists are categorized under Retiring. They often indicate suboptimal=
 performance and can often be optimized or avoided. Sample with: UOPS_RETIR=
ED.SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.js=
on b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> index 4f3dd85540b6..c732982f70b5 100644
> --- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> @@ -340,31 +340,34 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where no uops are being delivered due to a lack of required resources for a=
ccepting new uops in the Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_i=
nfo_thread_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 where no uops are being delivered due to a lack of required resources for =
accepting new uops in the Backend. Backend is the portion of the processor =
core where the out-of-order scheduler dispatches ready uops into their resp=
ective execution units; and once completed these uops get retired according=
 to program order. For example; stalls due to data-cache misses or stalls d=
ue to the divider unit being overloaded are both categorized under Backend =
Bound. Backend Bound is further divided into two main categories: Memory Bo=
und and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%"
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
wasted due to incorrect speculations",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound +=
 tma_retiring), 0)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 wasted due to incorrect speculations. This include slots used to issue uop=
s that do not eventually get retired and slots for which the issue-pipeline=
 was blocked due to recovery from earlier incorrect speculation. For exampl=
e; wasted work due to miss-predicted branches are categorized under Bad Spe=
culation category. Incorrect data speculation followed by Memory Ordering N=
ukes is another example.",
>          "ScaleUnit": "100%"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots th=
e CPU has wasted due to Branch Misprediction",
> +        "DefaultMetricgroupName": "TopdownL2",
>          "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound=
 + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * =
tma_info_thread_slots",
> -        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_gro=
up;tma_bad_speculation_group;tma_issueBM",
> +        "MetricGroup": "BadSpec;BrMispredicts;Default;TmaL2;TopdownL2;tm=
a_L2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specu=
lation > 0.15",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
>          "PublicDescription": "This metric represents fraction of slots t=
he CPU has wasted due to Branch Misprediction.  These slots are either wast=
ed by uops fetched from an incorrectly speculated program path; or stalls w=
hen the out-of-order part of the machine needs to recover its state from a =
speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics=
: tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredi=
ctions, tma_mispredicts_resteers",
>          "ScaleUnit": "100%"
>      },
> @@ -407,11 +410,12 @@
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots wh=
ere Core non-memory issues were of a bottleneck",
> +        "DefaultMetricgroupName": "TopdownL2",
>          "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
> -        "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;tma=
_backend_bound_group",
> +        "MetricGroup": "Backend;Compute;Default;TmaL2;TopdownL2;tma_L2_g=
roup;tma_backend_bound_group",
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0=
.2",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
>          "PublicDescription": "This metric represents fraction of slots w=
here Core non-memory issues were of a bottleneck.  Shortage in hardware com=
pute resources; or dependencies in software's instructions are both categor=
ized under Core Bound. Hence it may indicate the machine ran out of an out-=
of-order resource; certain execution units are overloaded or dependencies i=
n program's data- or instruction-flow are limiting the performance (e.g. FP=
-chained long-latency arithmetic operations).",
>          "ScaleUnit": "100%"
>      },
> @@ -509,21 +513,23 @@
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots th=
e CPU was stalled due to Frontend bandwidth issues",
> +        "DefaultMetricgroupName": "TopdownL2",
>          "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
> -        "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group;tm=
a_frontend_bound_group;tma_issueFB",
> +        "MetricGroup": "Default;FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_=
group;tma_frontend_bound_group;tma_issueFB",
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_bou=
nd > 0.15 & tma_info_thread_ipc / 6 > 0.35",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
>          "PublicDescription": "This metric represents fraction of slots t=
he CPU was stalled due to Frontend bandwidth issues.  For example; ineffici=
encies at the instruction decoders; or restrictions for caching in the DSB =
(decoded uops cache) are categorized under Fetch Bandwidth. In such cases; =
the Frontend typically delivers suboptimal amount of uops to the Backend. S=
ample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.=
LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_=
switches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tm=
a_info_inst_mix_iptb, tma_lcp",
>          "ScaleUnit": "100%"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots th=
e CPU was stalled due to Frontend latency issues",
> +        "DefaultMetricgroupName": "TopdownL2",
>          "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC=
.UOP_DROPPING / tma_info_thread_slots",
> -        "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_fronte=
nd_bound_group",
> +        "MetricGroup": "Default;Frontend;TmaL2;TopdownL2;tma_L2_group;tm=
a_frontend_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound=
 > 0.15",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
>          "PublicDescription": "This metric represents fraction of slots t=
he CPU was stalled due to Frontend latency issues.  For example; instructio=
n-cache misses; iTLB misses or fetch stalls after a branch misprediction ar=
e categorized under Frontend Latency. In such cases; the Frontend eventuall=
y delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_G=
E_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -611,11 +617,12 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where the processor's Frontend undersupplies its Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.=
UOP_DROPPING / tma_info_thread_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 where the processor's Frontend undersupplies its Backend. Frontend denotes=
 the first part of the processor core responsible to fetch operations that =
are executed later on by the Backend part. Within the Frontend; a branch pr=
edictor predicts the next address to fetch; cache-lines are fetched from th=
e memory subsystem; parsed into instructions; and lastly decoded into micro=
-operations (uops). Ideally the Frontend can issue Pipeline_Width uops ever=
y cycle to the Backend. Frontend Bound denotes unutilized issue-slots when =
there is no Backend stall; i.e. bubbles where Frontend delivered no uops wh=
ile Backend could have accepted them. For example; stalls due to instructio=
n-cache misses would be categorized under Frontend Bound. Sample with: FRON=
TEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -630,11 +637,12 @@
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring heavy-weight operations -- instructions that requi=
re two or more uops or micro-coded sequences",
> +        "DefaultMetricgroupName": "TopdownL2",
>          "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_=
info_thread_slots",
> -        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring=
_group",
> +        "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_=
retiring_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
>          "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring heavy-weight operations -- instructions that requ=
ire two or more uops or micro-coded sequences. This highly-correlates with =
the uop length of these instructions/sequences. Sample with: UOPS_RETIRED.H=
EAVY",
>          "ScaleUnit": "100%"
>      },
> @@ -1486,11 +1494,12 @@
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring light-weight operations -- instructions that requi=
re no more than one uop (micro-operation)",
> +        "DefaultMetricgroupName": "TopdownL2",
>          "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
> -        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring=
_group",
> +        "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_=
retiring_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
>          "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring light-weight operations -- instructions that requ=
ire no more than one uop (micro-operation). This correlates with total numb=
er of instructions used by the program. A uops-per-instruction (see UopPI m=
etric) ratio of 1 or less should be expected for decently optimized softwar=
e running on Intel Core/Xeon products. While this often indicates efficient=
 X86 instructions were executed; high value does not necessarily mean bette=
r performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
>          "ScaleUnit": "100%"
>      },
> @@ -1540,11 +1549,12 @@
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots th=
e CPU has wasted due to Machine Clears",
> +        "DefaultMetricgroupName": "TopdownL2",
>          "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredic=
ts)",
> -        "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_gro=
up;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
> +        "MetricGroup": "BadSpec;Default;MachineClears;TmaL2;TopdownL2;tm=
a_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculati=
on > 0.15",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
>          "PublicDescription": "This metric represents fraction of slots t=
he CPU has wasted due to Machine Clears.  These slots are either wasted by =
uops fetched prior to the clear; or stalls the out-of-order portion of the =
machine needs to recover its state after the clear. For example; this can h=
appen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Mod=
ifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics=
: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_=
sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote=
_cache",
>          "ScaleUnit": "100%"
>      },
> @@ -1576,11 +1586,12 @@
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots th=
e Memory subsystem within the Backend was a bottleneck",
> +        "DefaultMetricgroupName": "TopdownL2",
>          "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_=
info_thread_slots",
> -        "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend=
_bound_group",
> +        "MetricGroup": "Backend;Default;TmaL2;TopdownL2;tma_L2_group;tma=
_backend_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
>          "PublicDescription": "This metric represents fraction of slots t=
he Memory subsystem within the Backend was a bottleneck.  Memory Bound esti=
mates fraction of slots where pipeline is likely stalled due to demand load=
 or store instructions. This accounts mainly for (1) non-completed in-fligh=
t memory demand loads which coincides with execution units starvation; in a=
ddition to (2) cases where stores could impose backpressure on the pipeline=
 when many of them get buffered at the same time (less common out of the tw=
o).",
>          "ScaleUnit": "100%"
>      },
> @@ -1784,11 +1795,12 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
utilized by useful work i.e. issued uops that eventually get retired",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_inf=
o_thread_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > =
0.1",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 utilized by useful work i.e. issued uops that eventually get retired. Idea=
lly; all pipeline slots would be attributed to the Retiring category.  Reti=
ring of 100% would indicate the maximum Pipeline_Width throughput was achie=
ved.  Maximizing Retiring typically increases the Instructions-per-cycle (s=
ee IPC metric). Note that a high Retiring value does not necessary mean the=
re is no room for more performance.  For example; Heavy-operations or Micro=
code Assists are categorized under Retiring. They often indicate suboptimal=
 performance and can often be optimized or avoided. Sample with: UOPS_RETIR=
ED.SLOTS",
>          "ScaleUnit": "100%"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/=
tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
> index d0538a754288..83346911aa63 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
> @@ -105,21 +105,23 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where no uops are being delivered due to a lack of required resources for a=
ccepting new uops in the Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cpu@I=
NT_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_thread_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 where no uops are being delivered due to a lack of required resources for =
accepting new uops in the Backend. Backend is the portion of the processor =
core where the out-of-order scheduler dispatches ready uops into their resp=
ective execution units; and once completed these uops get retired according=
 to program order. For example; stalls due to data-cache misses or stalls d=
ue to the divider unit being overloaded are both categorized under Backend =
Bound. Backend Bound is further divided into two main categories: Memory Bo=
und and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%"
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
wasted due to incorrect speculations",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound +=
 tma_retiring), 0)",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 wasted due to incorrect speculations. This include slots used to issue uop=
s that do not eventually get retired and slots for which the issue-pipeline=
 was blocked due to recovery from earlier incorrect speculation. For exampl=
e; wasted work due to miss-predicted branches are categorized under Bad Spe=
culation category. Incorrect data speculation followed by Memory Ordering N=
ukes is another example.",
>          "ScaleUnit": "100%"
>      },
> @@ -366,11 +368,12 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where the processor's Frontend undersupplies its Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.=
UOP_DROPPING / tma_info_thread_slots",
> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 where the processor's Frontend undersupplies its Backend. Frontend denotes=
 the first part of the processor core responsible to fetch operations that =
are executed later on by the Backend part. Within the Frontend; a branch pr=
edictor predicts the next address to fetch; cache-lines are fetched from th=
e memory subsystem; parsed into instructions; and lastly decoded into micro=
-operations (uops). Ideally the Frontend can issue Pipeline_Width uops ever=
y cycle to the Backend. Frontend Bound denotes unutilized issue-slots when =
there is no Backend stall; i.e. bubbles where Frontend delivered no uops wh=
ile Backend could have accepted them. For example; stalls due to instructio=
n-cache misses would be categorized under Frontend Bound. Sample with: FRON=
TEND_RETIRED.LATENCY_GE_4_PS",
>          "ScaleUnit": "100%"
>      },
> @@ -1392,11 +1395,12 @@
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
utilized by useful work i.e. issued uops that eventually get retired",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_inf=
o_thread_slots",
> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > =
0.1",
> -        "MetricgroupNoGroup": "TopdownL1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
>          "PublicDescription": "This category represents fraction of slots=
 utilized by useful work i.e. issued uops that eventually get retired. Idea=
lly; all pipeline slots would be attributed to the Retiring category.  Reti=
ring of 100% would indicate the maximum Pipeline_Width throughput was achie=
ved.  Maximizing Retiring typically increases the Instructions-per-cycle (s=
ee IPC metric). Note that a high Retiring value does not necessary mean the=
re is no room for more performance.  For example; Heavy-operations or Micro=
code Assists are categorized under Retiring. They often indicate suboptimal=
 performance and can often be optimized or avoided. Sample with: UOPS_RETIR=
ED.SLOTS",
>          "ScaleUnit": "100%"
>      },
> --
> 2.35.1
>
