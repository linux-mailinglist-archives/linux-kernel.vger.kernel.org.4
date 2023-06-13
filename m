Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E2572ECE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjFMU2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFMU2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:28:21 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F122E6C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:28:17 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f9d619103dso5011cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686688097; x=1689280097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLpIwUZaGPhSALIA2mrDIZLNKptBYDZ2/mJmf9bhsFw=;
        b=Wvrfhu49GU8sylSzUXn8gUo4n1SAZ9LnbI55fkyUbmoAyxd72jgqjinba2qZ1E48k+
         CUc/gbUnrYwGmxsryYeOBstIoxcyn9OV6rV3HGmMmL2IJlig93qHVHPiBMLjglrYS4tx
         6fr3OE6l4LHhCxaCaqIXi+tPhz/AiiEPEPyJH3vpLT8Iynghg/ZiAaUO+j7oOzLJroHw
         jS9RnaUsZLnhq3mO+5lzljXZHNGthNkBZ9A8/hjMADOLCFJtfGkAEQ7GrBAkapYDD8x2
         jaIz8WmntJVwT7HPZtYmDeJBy+FDk/wPCwzu5yypvfidBQpeZmaVYuCb3DmWA4uYrtjZ
         HaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688097; x=1689280097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLpIwUZaGPhSALIA2mrDIZLNKptBYDZ2/mJmf9bhsFw=;
        b=lqjsSHB4WguIhycDoVBNaFEpcJ6WbLEFcrI25GyCRLxM/kYphRylbpBsy/ipPr/+sp
         c24V2gqP+AL9UYsvpkU6jndz8cBXQfQjgn7OoYEoIwzxDB1gcVsx8MUfmX6j22m3BkPX
         zumk/LTwLxrJk3ZtippbqebYXrrpkel+MwZdaRWpzGBwqhnHSbxoQml9sBIXfzPX4yRR
         91XYovuFBuLwI4hAlFYSQ0qbQhWylQhSb76mBxWQeIFW/JaL26xfCdqE2H6sSYdt5opT
         KtR7xjakPc41gvil/7RfOR0lHemkyfGj+K6mYA+Em5O99On6mSFuukR8YMLOlM6/MdUg
         JQ4g==
X-Gm-Message-State: AC+VfDzSOhcvWfEKdy1VV6kwcTLUbBeM7whA5q4Cgj8fL3aLRdD9mdOf
        5bS9gU/FmJ0CoLAPc7yiQnpLG/yAYgElHYs1r0t4xg==
X-Google-Smtp-Source: ACHHUZ4sY0ofBSOBJ7kyTZ3XzWRb6Nbml61bRdx8ICpPPfPewbHI+1UWdPRF90xT3hXDrhvfPqxmilVI50cU0kC8F0w=
X-Received: by 2002:ac8:5bd3:0:b0:3f9:a770:7279 with SMTP id
 b19-20020ac85bd3000000b003f9a7707279mr40771qtb.9.1686688096175; Tue, 13 Jun
 2023 13:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
 <20230607162700.3234712-4-kan.liang@linux.intel.com> <CAP-5=fUSKwTd8BKYfL+mwo=JmJb2qeR+BJ+1Br83jEiXtfjn7A@mail.gmail.com>
 <ae4ff916-5e79-0340-06d5-e4634913ba2e@linux.intel.com>
In-Reply-To: <ae4ff916-5e79-0340-06d5-e4634913ba2e@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 13:28:04 -0700
Message-ID: <CAP-5=fVTDPCeaHHt9uQWdeczOKYDFNNuWFBxN-0pcsAjjvuR6g@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf metric: JSON flag to default metric group
To:     "Liang, Kan" <kan.liang@linux.intel.com>, ahmad.yasin@intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com
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

On Tue, Jun 13, 2023 at 1:10=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-06-13 3:44 p.m., Ian Rogers wrote:
> > On Wed, Jun 7, 2023 at 9:27=E2=80=AFAM <kan.liang@linux.intel.com> wrot=
e:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> For the default output, the default metric group could vary on differe=
nt
> >> platforms. For example, on SPR, the TopdownL1 and TopdownL2 metrics
> >> should be displayed in the default mode. On ICL, only the TopdownL1
> >> should be displayed.
> >>
> >> Add a flag so we can tag the default metric group for different
> >> platforms rather than hack the perf code.
> >>
> >> The flag is added to Intel TopdownL1 since ICL and TopdownL2 metrics
> >> since SPR.
> >>
> >> Add a new field, DefaultMetricgroupName, in the JSON file to indicate
> >> the real metric group name.
> >>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  .../arch/x86/alderlake/adl-metrics.json       | 20 ++++---
> >>  .../arch/x86/icelake/icl-metrics.json         | 20 ++++---
> >>  .../arch/x86/icelakex/icx-metrics.json        | 20 ++++---
> >>  .../arch/x86/sapphirerapids/spr-metrics.json  | 60 +++++++++++-------=
-
> >>  .../arch/x86/tigerlake/tgl-metrics.json       | 20 ++++---
> >>  5 files changed, 84 insertions(+), 56 deletions(-)
> >>
> >> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json=
 b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> >> index c9f7e3d4ab08..e78c85220e27 100644
> >> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> >> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> >> @@ -832,22 +832,24 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts where no uops are being delivered due to a lack of required resources fo=
r accepting new uops in the Backend",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_backend_bound",
> >>          "MetricThreshold": "tma_backend_bound > 0.2",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots where no uops are being delivered due to a lack of required resources f=
or accepting new uops in the Backend. Backend is the portion of the process=
or core where the out-of-order scheduler dispatches ready uops into their r=
espective execution units; and once completed these uops get retired accord=
ing to program order. For example; stalls due to data-cache misses or stall=
s due to the divider unit being overloaded are both categorized under Backe=
nd Bound. Backend Bound is further divided into two main categories: Memory=
 Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
> >>          "ScaleUnit": "100%",
> >>          "Unit": "cpu_core"
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts wasted due to incorrect speculations",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_boun=
d + tma_retiring), 0)",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_bad_speculation",
> >>          "MetricThreshold": "tma_bad_speculation > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots wasted due to incorrect speculations. This include slots used to issue =
uops that do not eventually get retired and slots for which the issue-pipel=
ine was blocked due to recovery from earlier incorrect speculation. For exa=
mple; wasted work due to miss-predicted branches are categorized under Bad =
Speculation category. Incorrect data speculation followed by Memory Orderin=
g Nukes is another example.",
> >>          "ScaleUnit": "100%",
> >>          "Unit": "cpu_core"
> >> @@ -1112,11 +1114,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts where the processor's Frontend undersupplies its Backend",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@=
 / tma_info_thread_slots",
> >> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_frontend_bound",
> >>          "MetricThreshold": "tma_frontend_bound > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots where the processor's Frontend undersupplies its Backend. Frontend deno=
tes the first part of the processor core responsible to fetch operations th=
at are executed later on by the Backend part. Within the Frontend; a branch=
 predictor predicts the next address to fetch; cache-lines are fetched from=
 the memory subsystem; parsed into instructions; and lastly decoded into mi=
cro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops e=
very cycle to the Backend. Frontend Bound denotes unutilized issue-slots wh=
en there is no Backend stall; i.e. bubbles where Frontend delivered no uops=
 while Backend could have accepted them. For example; stalls due to instruc=
tion-cache misses would be categorized under Frontend Bound. Sample with: F=
RONTEND_RETIRED.LATENCY_GE_4_PS",
> >>          "ScaleUnit": "100%",
> >>          "Unit": "cpu_core"
> >> @@ -2316,11 +2319,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts utilized by useful work i.e. issued uops that eventually get retired",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdo=
wn\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-reti=
ring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_retiring",
> >>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations=
 > 0.1",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots utilized by useful work i.e. issued uops that eventually get retired. I=
deally; all pipeline slots would be attributed to the Retiring category.  R=
etiring of 100% would indicate the maximum Pipeline_Width throughput was ac=
hieved.  Maximizing Retiring typically increases the Instructions-per-cycle=
 (see IPC metric). Note that a high Retiring value does not necessary mean =
there is no room for more performance.  For example; Heavy-operations or Mi=
crocode Assists are categorized under Retiring. They often indicate subopti=
mal performance and can often be optimized or avoided. Sample with: UOPS_RE=
TIRED.SLOTS",
> >>          "ScaleUnit": "100%",
> >>          "Unit": "cpu_core"
> >
> > For Alderlake the Default metric group is added for all cpu_core
> > metrics but not cpu_atom. This will lead to only getting metrics for
> > performance cores while the workload could be running on atoms. This
> > could lead to a false conclusion that the workload has no issues with
> > the metrics. I think this behavior is surprising and should be called
> > out as intentional in the commit message.
> >
>
> The e-core doesn't have enough counters to calculate all the Topdown
> events. It will trigger the multiplexing. We try to avoid it in the
> default mode.
> I will update the commit in V2.

Is multiplexing a worse crime than only giving output for half the
cores? Both can be misleading. Perhaps the safest thing is to not use
Default on hybrid platforms.

Thanks,
Ian

> Thanks,
> Kan
>
> > Thanks,
> > Ian
> >
> >> diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b=
/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> >> index 20210742171d..cc4edf855064 100644
> >> --- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> >> +++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> >> @@ -111,21 +111,23 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts where no uops are being delivered due to a lack of required resources fo=
r accepting new uops in the Backend",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cp=
u@INT_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_thread_slots",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_backend_bound",
> >>          "MetricThreshold": "tma_backend_bound > 0.2",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots where no uops are being delivered due to a lack of required resources f=
or accepting new uops in the Backend. Backend is the portion of the process=
or core where the out-of-order scheduler dispatches ready uops into their r=
espective execution units; and once completed these uops get retired accord=
ing to program order. For example; stalls due to data-cache misses or stall=
s due to the divider unit being overloaded are both categorized under Backe=
nd Bound. Backend Bound is further divided into two main categories: Memory=
 Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
> >>          "ScaleUnit": "100%"
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts wasted due to incorrect speculations",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_boun=
d + tma_retiring), 0)",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_bad_speculation",
> >>          "MetricThreshold": "tma_bad_speculation > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots wasted due to incorrect speculations. This include slots used to issue =
uops that do not eventually get retired and slots for which the issue-pipel=
ine was blocked due to recovery from earlier incorrect speculation. For exa=
mple; wasted work due to miss-predicted branches are categorized under Bad =
Speculation category. Incorrect data speculation followed by Memory Orderin=
g Nukes is another example.",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -372,11 +374,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts where the processor's Frontend undersupplies its Backend",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MI=
SC.UOP_DROPPING / tma_info_thread_slots",
> >> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_frontend_bound",
> >>          "MetricThreshold": "tma_frontend_bound > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots where the processor's Frontend undersupplies its Backend. Frontend deno=
tes the first part of the processor core responsible to fetch operations th=
at are executed later on by the Backend part. Within the Frontend; a branch=
 predictor predicts the next address to fetch; cache-lines are fetched from=
 the memory subsystem; parsed into instructions; and lastly decoded into mi=
cro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops e=
very cycle to the Backend. Frontend Bound denotes unutilized issue-slots wh=
en there is no Backend stall; i.e. bubbles where Frontend delivered no uops=
 while Backend could have accepted them. For example; stalls due to instruc=
tion-cache misses would be categorized under Frontend Bound. Sample with: F=
RONTEND_RETIRED.LATENCY_GE_4_PS",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -1378,11 +1381,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts utilized by useful work i.e. issued uops that eventually get retired",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_=
info_thread_slots",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_retiring",
> >>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations=
 > 0.1",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots utilized by useful work i.e. issued uops that eventually get retired. I=
deally; all pipeline slots would be attributed to the Retiring category.  R=
etiring of 100% would indicate the maximum Pipeline_Width throughput was ac=
hieved.  Maximizing Retiring typically increases the Instructions-per-cycle=
 (see IPC metric). Note that a high Retiring value does not necessary mean =
there is no room for more performance.  For example; Heavy-operations or Mi=
crocode Assists are categorized under Retiring. They often indicate subopti=
mal performance and can often be optimized or avoided. Sample with: UOPS_RE=
TIRED.SLOTS",
> >>          "ScaleUnit": "100%"
> >>      },
> >> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json =
b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> >> index ef25cda019be..6f25b5b7aaf6 100644
> >> --- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> >> +++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> >> @@ -315,21 +315,23 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts where no uops are being delivered due to a lack of required resources fo=
r accepting new uops in the Backend",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cp=
u@INT_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_thread_slots",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_backend_bound",
> >>          "MetricThreshold": "tma_backend_bound > 0.2",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots where no uops are being delivered due to a lack of required resources f=
or accepting new uops in the Backend. Backend is the portion of the process=
or core where the out-of-order scheduler dispatches ready uops into their r=
espective execution units; and once completed these uops get retired accord=
ing to program order. For example; stalls due to data-cache misses or stall=
s due to the divider unit being overloaded are both categorized under Backe=
nd Bound. Backend Bound is further divided into two main categories: Memory=
 Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
> >>          "ScaleUnit": "100%"
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts wasted due to incorrect speculations",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_boun=
d + tma_retiring), 0)",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_bad_speculation",
> >>          "MetricThreshold": "tma_bad_speculation > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots wasted due to incorrect speculations. This include slots used to issue =
uops that do not eventually get retired and slots for which the issue-pipel=
ine was blocked due to recovery from earlier incorrect speculation. For exa=
mple; wasted work due to miss-predicted branches are categorized under Bad =
Speculation category. Incorrect data speculation followed by Memory Orderin=
g Nukes is another example.",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -576,11 +578,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts where the processor's Frontend undersupplies its Backend",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MI=
SC.UOP_DROPPING / tma_info_thread_slots",
> >> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_frontend_bound",
> >>          "MetricThreshold": "tma_frontend_bound > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots where the processor's Frontend undersupplies its Backend. Frontend deno=
tes the first part of the processor core responsible to fetch operations th=
at are executed later on by the Backend part. Within the Frontend; a branch=
 predictor predicts the next address to fetch; cache-lines are fetched from=
 the memory subsystem; parsed into instructions; and lastly decoded into mi=
cro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops e=
very cycle to the Backend. Frontend Bound denotes unutilized issue-slots wh=
en there is no Backend stall; i.e. bubbles where Frontend delivered no uops=
 while Backend could have accepted them. For example; stalls due to instruc=
tion-cache misses would be categorized under Frontend Bound. Sample with: F=
RONTEND_RETIRED.LATENCY_GE_4_PS",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -1674,11 +1677,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts utilized by useful work i.e. issued uops that eventually get retired",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_=
info_thread_slots",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_retiring",
> >>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations=
 > 0.1",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots utilized by useful work i.e. issued uops that eventually get retired. I=
deally; all pipeline slots would be attributed to the Retiring category.  R=
etiring of 100% would indicate the maximum Pipeline_Width throughput was ac=
hieved.  Maximizing Retiring typically increases the Instructions-per-cycle=
 (see IPC metric). Note that a high Retiring value does not necessary mean =
there is no room for more performance.  For example; Heavy-operations or Mi=
crocode Assists are categorized under Retiring. They often indicate subopti=
mal performance and can often be optimized or avoided. Sample with: UOPS_RE=
TIRED.SLOTS",
> >>          "ScaleUnit": "100%"
> >>      },
> >> diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics=
.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> >> index 4f3dd85540b6..c732982f70b5 100644
> >> --- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> >> +++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> >> @@ -340,31 +340,34 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts where no uops are being delivered due to a lack of required resources fo=
r accepting new uops in the Backend",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tm=
a_info_thread_slots",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_backend_bound",
> >>          "MetricThreshold": "tma_backend_bound > 0.2",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots where no uops are being delivered due to a lack of required resources f=
or accepting new uops in the Backend. Backend is the portion of the process=
or core where the out-of-order scheduler dispatches ready uops into their r=
espective execution units; and once completed these uops get retired accord=
ing to program order. For example; stalls due to data-cache misses or stall=
s due to the divider unit being overloaded are both categorized under Backe=
nd Bound. Backend Bound is further divided into two main categories: Memory=
 Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
> >>          "ScaleUnit": "100%"
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts wasted due to incorrect speculations",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_boun=
d + tma_retiring), 0)",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_bad_speculation",
> >>          "MetricThreshold": "tma_bad_speculation > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots wasted due to incorrect speculations. This include slots used to issue =
uops that do not eventually get retired and slots for which the issue-pipel=
ine was blocked due to recovery from earlier incorrect speculation. For exa=
mple; wasted work due to miss-predicted branches are categorized under Bad =
Speculation category. Incorrect data speculation followed by Memory Orderin=
g Nukes is another example.",
> >>          "ScaleUnit": "100%"
> >>      },
> >>      {
> >>          "BriefDescription": "This metric represents fraction of slots=
 the CPU has wasted due to Branch Misprediction",
> >> +        "DefaultMetricgroupName": "TopdownL2",
> >>          "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bo=
und + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0=
 * tma_info_thread_slots",
> >> -        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueBM",
> >> +        "MetricGroup": "BadSpec;BrMispredicts;Default;TmaL2;TopdownL2=
;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
> >>          "MetricName": "tma_branch_mispredicts",
> >>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_sp=
eculation > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL2",
> >> +        "MetricgroupNoGroup": "TopdownL2;Default",
> >>          "PublicDescription": "This metric represents fraction of slot=
s the CPU has wasted due to Branch Misprediction.  These slots are either w=
asted by uops fetched from an incorrectly speculated program path; or stall=
s when the out-of-order part of the machine needs to recover its state from=
 a speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metr=
ics: tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispr=
edictions, tma_mispredicts_resteers",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -407,11 +410,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This metric represents fraction of slots=
 where Core non-memory issues were of a bottleneck",
> >> +        "DefaultMetricgroupName": "TopdownL2",
> >>          "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
> >> -        "MetricGroup": "Backend;Compute;TmaL2;TopdownL2;tma_L2_group;=
tma_backend_bound_group",
> >> +        "MetricGroup": "Backend;Compute;Default;TmaL2;TopdownL2;tma_L=
2_group;tma_backend_bound_group",
> >>          "MetricName": "tma_core_bound",
> >>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound =
> 0.2",
> >> -        "MetricgroupNoGroup": "TopdownL2",
> >> +        "MetricgroupNoGroup": "TopdownL2;Default",
> >>          "PublicDescription": "This metric represents fraction of slot=
s where Core non-memory issues were of a bottleneck.  Shortage in hardware =
compute resources; or dependencies in software's instructions are both cate=
gorized under Core Bound. Hence it may indicate the machine ran out of an o=
ut-of-order resource; certain execution units are overloaded or dependencie=
s in program's data- or instruction-flow are limiting the performance (e.g.=
 FP-chained long-latency arithmetic operations).",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -509,21 +513,23 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This metric represents fraction of slots=
 the CPU was stalled due to Frontend bandwidth issues",
> >> +        "DefaultMetricgroupName": "TopdownL2",
> >>          "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)=
",
> >> -        "MetricGroup": "FetchBW;Frontend;TmaL2;TopdownL2;tma_L2_group=
;tma_frontend_bound_group;tma_issueFB",
> >> +        "MetricGroup": "Default;FetchBW;Frontend;TmaL2;TopdownL2;tma_=
L2_group;tma_frontend_bound_group;tma_issueFB",
> >>          "MetricName": "tma_fetch_bandwidth",
> >>          "MetricThreshold": "tma_fetch_bandwidth > 0.1 & tma_frontend_=
bound > 0.15 & tma_info_thread_ipc / 6 > 0.35",
> >> -        "MetricgroupNoGroup": "TopdownL2",
> >> +        "MetricgroupNoGroup": "TopdownL2;Default",
> >>          "PublicDescription": "This metric represents fraction of slot=
s the CPU was stalled due to Frontend bandwidth issues.  For example; ineff=
iciencies at the instruction decoders; or restrictions for caching in the D=
SB (decoded uops cache) are categorized under Fetch Bandwidth. In such case=
s; the Frontend typically delivers suboptimal amount of uops to the Backend=
. Sample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIR=
ED.LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_d=
sb_switches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage,=
 tma_info_inst_mix_iptb, tma_lcp",
> >>          "ScaleUnit": "100%"
> >>      },
> >>      {
> >>          "BriefDescription": "This metric represents fraction of slots=
 the CPU was stalled due to Frontend latency issues",
> >> +        "DefaultMetricgroupName": "TopdownL2",
> >>          "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound =
+ topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_M=
ISC.UOP_DROPPING / tma_info_thread_slots",
> >> -        "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_fro=
ntend_bound_group",
> >> +        "MetricGroup": "Default;Frontend;TmaL2;TopdownL2;tma_L2_group=
;tma_frontend_bound_group",
> >>          "MetricName": "tma_fetch_latency",
> >>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bo=
und > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL2",
> >> +        "MetricgroupNoGroup": "TopdownL2;Default",
> >>          "PublicDescription": "This metric represents fraction of slot=
s the CPU was stalled due to Frontend latency issues.  For example; instruc=
tion-cache misses; iTLB misses or fetch stalls after a branch misprediction=
 are categorized under Frontend Latency. In such cases; the Frontend eventu=
ally delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENC=
Y_GE_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -611,11 +617,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts where the processor's Frontend undersupplies its Backend",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MI=
SC.UOP_DROPPING / tma_info_thread_slots",
> >> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_frontend_bound",
> >>          "MetricThreshold": "tma_frontend_bound > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots where the processor's Frontend undersupplies its Backend. Frontend deno=
tes the first part of the processor core responsible to fetch operations th=
at are executed later on by the Backend part. Within the Frontend; a branch=
 predictor predicts the next address to fetch; cache-lines are fetched from=
 the memory subsystem; parsed into instructions; and lastly decoded into mi=
cro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops e=
very cycle to the Backend. Frontend Bound denotes unutilized issue-slots wh=
en there is no Backend stall; i.e. bubbles where Frontend delivered no uops=
 while Backend could have accepted them. For example; stalls due to instruc=
tion-cache misses would be categorized under Frontend Bound. Sample with: F=
RONTEND_RETIRED.LATENCY_GE_4_PS",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -630,11 +637,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This metric represents fraction of slots=
 where the CPU was retiring heavy-weight operations -- instructions that re=
quire two or more uops or micro-coded sequences",
> >> +        "DefaultMetricgroupName": "TopdownL2",
> >>          "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound =
+ topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * t=
ma_info_thread_slots",
> >> -        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retir=
ing_group",
> >> +        "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;t=
ma_retiring_group",
> >>          "MetricName": "tma_heavy_operations",
> >>          "MetricThreshold": "tma_heavy_operations > 0.1",
> >> -        "MetricgroupNoGroup": "TopdownL2",
> >> +        "MetricgroupNoGroup": "TopdownL2;Default",
> >>          "PublicDescription": "This metric represents fraction of slot=
s where the CPU was retiring heavy-weight operations -- instructions that r=
equire two or more uops or micro-coded sequences. This highly-correlates wi=
th the uop length of these instructions/sequences. Sample with: UOPS_RETIRE=
D.HEAVY",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -1486,11 +1494,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This metric represents fraction of slots=
 where the CPU was retiring light-weight operations -- instructions that re=
quire no more than one uop (micro-operation)",
> >> +        "DefaultMetricgroupName": "TopdownL2",
> >>          "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
> >> -        "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retir=
ing_group",
> >> +        "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;t=
ma_retiring_group",
> >>          "MetricName": "tma_light_operations",
> >>          "MetricThreshold": "tma_light_operations > 0.6",
> >> -        "MetricgroupNoGroup": "TopdownL2",
> >> +        "MetricgroupNoGroup": "TopdownL2;Default",
> >>          "PublicDescription": "This metric represents fraction of slot=
s where the CPU was retiring light-weight operations -- instructions that r=
equire no more than one uop (micro-operation). This correlates with total n=
umber of instructions used by the program. A uops-per-instruction (see UopP=
I metric) ratio of 1 or less should be expected for decently optimized soft=
ware running on Intel Core/Xeon products. While this often indicates effici=
ent X86 instructions were executed; high value does not necessarily mean be=
tter performance cannot be achieved. Sample with: INST_RETIRED.PREC_DIST",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -1540,11 +1549,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This metric represents fraction of slots=
 the CPU has wasted due to Machine Clears",
> >> +        "DefaultMetricgroupName": "TopdownL2",
> >>          "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispre=
dicts)",
> >> -        "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
> >> +        "MetricGroup": "BadSpec;Default;MachineClears;TmaL2;TopdownL2=
;tma_L2_group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
> >>          "MetricName": "tma_machine_clears",
> >>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_specul=
ation > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL2",
> >> +        "MetricgroupNoGroup": "TopdownL2;Default",
> >>          "PublicDescription": "This metric represents fraction of slot=
s the CPU has wasted due to Machine Clears.  These slots are either wasted =
by uops fetched prior to the clear; or stalls the out-of-order portion of t=
he machine needs to recover its state after the clear. For example; this ca=
n happen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-=
Modifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metr=
ics: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_fal=
se_sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_rem=
ote_cache",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -1576,11 +1586,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This metric represents fraction of slots=
 the Memory subsystem within the Backend was a bottleneck",
> >> +        "DefaultMetricgroupName": "TopdownL2",
> >>          "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound =
+ topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * t=
ma_info_thread_slots",
> >> -        "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_back=
end_bound_group",
> >> +        "MetricGroup": "Backend;Default;TmaL2;TopdownL2;tma_L2_group;=
tma_backend_bound_group",
> >>          "MetricName": "tma_memory_bound",
> >>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2",
> >> -        "MetricgroupNoGroup": "TopdownL2",
> >> +        "MetricgroupNoGroup": "TopdownL2;Default",
> >>          "PublicDescription": "This metric represents fraction of slot=
s the Memory subsystem within the Backend was a bottleneck.  Memory Bound e=
stimates fraction of slots where pipeline is likely stalled due to demand l=
oad or store instructions. This accounts mainly for (1) non-completed in-fl=
ight memory demand loads which coincides with execution units starvation; i=
n addition to (2) cases where stores could impose backpressure on the pipel=
ine when many of them get buffered at the same time (less common out of the=
 two).",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -1784,11 +1795,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts utilized by useful work i.e. issued uops that eventually get retired",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_=
info_thread_slots",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_retiring",
> >>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations=
 > 0.1",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots utilized by useful work i.e. issued uops that eventually get retired. I=
deally; all pipeline slots would be attributed to the Retiring category.  R=
etiring of 100% would indicate the maximum Pipeline_Width throughput was ac=
hieved.  Maximizing Retiring typically increases the Instructions-per-cycle=
 (see IPC metric). Note that a high Retiring value does not necessary mean =
there is no room for more performance.  For example; Heavy-operations or Mi=
crocode Assists are categorized under Retiring. They often indicate subopti=
mal performance and can often be optimized or avoided. Sample with: UOPS_RE=
TIRED.SLOTS",
> >>          "ScaleUnit": "100%"
> >>      },
> >> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json=
 b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
> >> index d0538a754288..83346911aa63 100644
> >> --- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
> >> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
> >> @@ -105,21 +105,23 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts where no uops are being delivered due to a lack of required resources fo=
r accepting new uops in the Backend",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5 * cp=
u@INT_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_thread_slots",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_backend_bound",
> >>          "MetricThreshold": "tma_backend_bound > 0.2",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots where no uops are being delivered due to a lack of required resources f=
or accepting new uops in the Backend. Backend is the portion of the process=
or core where the out-of-order scheduler dispatches ready uops into their r=
espective execution units; and once completed these uops get retired accord=
ing to program order. For example; stalls due to data-cache misses or stall=
s due to the divider unit being overloaded are both categorized under Backe=
nd Bound. Backend Bound is further divided into two main categories: Memory=
 Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
> >>          "ScaleUnit": "100%"
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts wasted due to incorrect speculations",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_boun=
d + tma_retiring), 0)",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_bad_speculation",
> >>          "MetricThreshold": "tma_bad_speculation > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots wasted due to incorrect speculations. This include slots used to issue =
uops that do not eventually get retired and slots for which the issue-pipel=
ine was blocked due to recovery from earlier incorrect speculation. For exa=
mple; wasted work due to miss-predicted branches are categorized under Bad =
Speculation category. Incorrect data speculation followed by Memory Orderin=
g Nukes is another example.",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -366,11 +368,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts where the processor's Frontend undersupplies its Backend",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MI=
SC.UOP_DROPPING / tma_info_thread_slots",
> >> -        "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_frontend_bound",
> >>          "MetricThreshold": "tma_frontend_bound > 0.15",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots where the processor's Frontend undersupplies its Backend. Frontend deno=
tes the first part of the processor core responsible to fetch operations th=
at are executed later on by the Backend part. Within the Frontend; a branch=
 predictor predicts the next address to fetch; cache-lines are fetched from=
 the memory subsystem; parsed into instructions; and lastly decoded into mi=
cro-operations (uops). Ideally the Frontend can issue Pipeline_Width uops e=
very cycle to the Backend. Frontend Bound denotes unutilized issue-slots wh=
en there is no Backend stall; i.e. bubbles where Frontend delivered no uops=
 while Backend could have accepted them. For example; stalls due to instruc=
tion-cache misses would be categorized under Frontend Bound. Sample with: F=
RONTEND_RETIRED.LATENCY_GE_4_PS",
> >>          "ScaleUnit": "100%"
> >>      },
> >> @@ -1392,11 +1395,12 @@
> >>      },
> >>      {
> >>          "BriefDescription": "This category represents fraction of slo=
ts utilized by useful work i.e. issued uops that eventually get retired",
> >> +        "DefaultMetricgroupName": "TopdownL1",
> >>          "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_=
info_thread_slots",
> >> -        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> >> +        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
> >>          "MetricName": "tma_retiring",
> >>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations=
 > 0.1",
> >> -        "MetricgroupNoGroup": "TopdownL1",
> >> +        "MetricgroupNoGroup": "TopdownL1;Default",
> >>          "PublicDescription": "This category represents fraction of sl=
ots utilized by useful work i.e. issued uops that eventually get retired. I=
deally; all pipeline slots would be attributed to the Retiring category.  R=
etiring of 100% would indicate the maximum Pipeline_Width throughput was ac=
hieved.  Maximizing Retiring typically increases the Instructions-per-cycle=
 (see IPC metric). Note that a high Retiring value does not necessary mean =
there is no room for more performance.  For example; Heavy-operations or Mi=
crocode Assists are categorized under Retiring. They often indicate subopti=
mal performance and can often be optimized or avoided. Sample with: UOPS_RE=
TIRED.SLOTS",
> >>          "ScaleUnit": "100%"
> >>      },
> >> --
> >> 2.35.1
> >>
