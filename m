Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABC36281BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiKNN6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiKNN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:58:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0510625EAD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:58:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso10734314wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EO/Pqtiei9vpd8nzNVPXlc5XKBs6c32L3Re7V6has9w=;
        b=hk9U6KeMh8wOPecY1j2O+XJqhHxiaiNkYwMT7pkryIoLf7qk0gGsPC9BFDRRNxzgqg
         AdLi1Yk2rkH3XIsV3uNAgSFyKkdKScQ80wWq0Xgd9W3f7ja28sfnMDbGsPvq7Eqcpfg7
         OupKmy/eeAhJZCiUOII2jcHnoi+JkRgxtW56EvK4rQHi8Wefjapzzqc9yCT3tysPV++X
         zwO9bAXup2Ct7e73ondMtc2Cw8d7h+1inN0RmpnDu2JCmA1R7+9SUIqEb3RaKym31cFi
         1BBkPAp05mSCugNUMR5OlwItlqkEACdO7qSC/ly8TqOvh1nk4JTxm4PuG68olcTrMW7u
         xLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EO/Pqtiei9vpd8nzNVPXlc5XKBs6c32L3Re7V6has9w=;
        b=mDB76xk34P0j+dWCSPX+9RUurxVTDARzde1YzBIWksDZn1Zc3lLtZxww2isUGm79FT
         BnzLRi4yU1ZoYShio9Z3mUmQErWLm+oheKOo/mg/g65DTCkQodL/TBUMQIegdDlQfzbL
         gVff/AFnLbxQq5XRcltPhN61UaXicTpV+u1BDcMq0a0CRV4GeDz+/V/Jdlc8HxkLKfR5
         AjfcSAE7VwOoMj5/i1wiNGNmvUSvzp5FpTiwvMgBd+MJ6xfJKU+DOYw5i9uDrN6gl0uo
         3VTMzFg7MfkVWWHewincwfto2on98elJ1dBp18YmKMsV/eHDjOiTGTgzJ9Hhw00MYXRl
         MU1g==
X-Gm-Message-State: ANoB5pmuzPl3K5BwT1rpACF6/EHaC8R6TIN5f3fB3+fWli6bC8uwOblF
        LWNh0ag/TfTWh+O+CWY0Px2SMdQqbPFQ+SKWoe+R/w==
X-Google-Smtp-Source: AA0mqf75EToT+RCEN74k7sOvL0CSo37F+9aarF/0UaZD2ORomJHzt0AKhQfsptokjfkmcy4cGo73IAYWE2GgwzNKKcM=
X-Received: by 2002:a7b:c40b:0:b0:3c6:c109:2d9 with SMTP id
 k11-20020a7bc40b000000b003c6c10902d9mr8130656wmi.149.1668434300219; Mon, 14
 Nov 2022 05:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com> <20221114075127.2650315-5-irogers@google.com>
 <63b7b6d5-f441-7ebc-fd3f-9d5f36d2938d@linux.intel.com>
In-Reply-To: <63b7b6d5-f441-7ebc-fd3f-9d5f36d2938d@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 05:58:06 -0800
Message-ID: <CAP-5=fU4T93B49W1Of-sECNfLVRoue4zYfYz8Cur0JGRrUHjDA@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] perf list: Generalize limiting to a PMU name
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Mon, Nov 14, 2022 at 12:51 AM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
>
>
> On 11/14/2022 3:51 PM, Ian Rogers wrote:
> > Deprecate the --cputype option and add a --unit option where '--unit
> > cpu_atom' behaves like '--cputype atom'. The --unit option can be used
> > with arbitrary PMUs, for example:
> >
> > ```
> > $ perf list --unit msr pmu
> >
> > List of pre-defined events (to be used in -e or -M):
> >
> >    msr/aperf/                                         [Kernel PMU event]
> >    msr/cpu_thermal_margin/                            [Kernel PMU event]
> >    msr/mperf/                                         [Kernel PMU event]
> >    msr/pperf/                                         [Kernel PMU event]
> >    msr/smi/                                           [Kernel PMU event]
> >    msr/tsc/                                           [Kernel PMU event]
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/Documentation/perf-list.txt |  6 +++---
> >   tools/perf/builtin-list.c              | 18 ++++++++++++------
> >   tools/perf/util/metricgroup.c          |  3 ++-
> >   tools/perf/util/pmu.c                  |  4 +---
> >   4 files changed, 18 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> > index 57384a97c04f..44a819af573d 100644
> > --- a/tools/perf/Documentation/perf-list.txt
> > +++ b/tools/perf/Documentation/perf-list.txt
> > @@ -39,9 +39,9 @@ any extra expressions computed by perf stat.
> >   --deprecated::
> >   Print deprecated events. By default the deprecated events are hidden.
> >
> > ---cputype::
> > -Print events applying cpu with this type for hybrid platform
> > -(e.g. --cputype core or --cputype atom)
> > +--unit::
> > +Print PMU events and metrics limited to the specific PMU name.
> > +(e.g. --unit cpu, --unit msr, --unit cpu_core, --unit cpu_atom)
> >
> >   [[EVENT_MODIFIERS]]
> >   EVENT MODIFIERS
> > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > index 58e1ec1654ef..cc84ced6da26 100644
> > --- a/tools/perf/builtin-list.c
> > +++ b/tools/perf/builtin-list.c
> > @@ -21,7 +21,6 @@
> >
> >   static bool desc_flag = true;
> >   static bool details_flag;
> > -static const char *hybrid_type;
> >
> >   int cmd_list(int argc, const char **argv)
> >   {
> > @@ -30,6 +29,8 @@ int cmd_list(int argc, const char **argv)
> >       bool long_desc_flag = false;
> >       bool deprecated = false;
> >       char *pmu_name = NULL;
> > +     const char *hybrid_name = NULL;
> > +     const char *unit_name = NULL;
> >       struct option list_options[] = {
> >               OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
> >               OPT_BOOLEAN('d', "desc", &desc_flag,
> > @@ -40,9 +41,10 @@ int cmd_list(int argc, const char **argv)
> >                           "Print information on the perf event names and expressions used internally by events."),
> >               OPT_BOOLEAN(0, "deprecated", &deprecated,
> >                           "Print deprecated events."),
> > -             OPT_STRING(0, "cputype", &hybrid_type, "hybrid cpu type",
> > -                        "Print events applying cpu with this type for hybrid platform "
> > -                        "(e.g. core or atom)"),
> > +             OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
> > +                        "Limit PMU or metric printing to the given hybrid PMU (e.g. core or atom)."),
> > +             OPT_STRING(0, "unit", &unit_name, "PMU name",
> > +                        "Limit PMU or metric printing to the specified PMU."),
> >               OPT_INCR(0, "debug", &verbose,
> >                            "Enable debugging output"),
> >               OPT_END()
> > @@ -53,6 +55,8 @@ int cmd_list(int argc, const char **argv)
> >       };
> >
> >       set_option_flag(list_options, 0, "raw-dump", PARSE_OPT_HIDDEN);
> > +     /* Hide hybrid flag for the more generic 'unit' flag. */
> > +     set_option_flag(list_options, 0, "cputype", PARSE_OPT_HIDDEN);
> >
> >       argc = parse_options(argc, argv, list_options, list_usage,
> >                            PARSE_OPT_STOP_AT_NON_OPTION);
> > @@ -62,8 +66,10 @@ int cmd_list(int argc, const char **argv)
> >       if (!raw_dump && pager_in_use())
> >               printf("\nList of pre-defined events (to be used in -e or -M):\n\n");
> >
> > -     if (hybrid_type) {
> > -             pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_type);
> > +     if (unit_name)
> > +             pmu_name = strdup(unit_name);
> > +     else if (hybrid_name) {
> > +             pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_name);
> >               if (!pmu_name)
> >                       pr_warning("WARNING: hybrid cputype is not supported!\n");
> >       }
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 4c98ac29ee13..1943fed9b6d9 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -556,11 +556,12 @@ static int metricgroup__print_callback(const struct pmu_event *pe,
> >                                      void *vdata)
> >   {
> >       struct metricgroup_print_data *data = vdata;
> > +     const char *pmu = pe->pmu ?: "cpu";
> >
> >       if (!pe->metric_expr)
> >               return 0;
> >
> > -     if (data->pmu_name && perf_pmu__is_hybrid(pe->pmu) && strcmp(data->pmu_name, pe->pmu))
> > +     if (data->pmu_name && strcmp(data->pmu_name, pmu))
> >               return 0;
> >
> >       return metricgroup__print_pmu_event(pe, data->metricgroups, data->filter,
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index a8f9f47c6ed9..9c771f136b81 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1694,10 +1694,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
> >       pmu = NULL;
> >       j = 0;
> >       while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> > -             if (pmu_name && perf_pmu__is_hybrid(pmu->name) &&
> > -                 strcmp(pmu_name, pmu->name)) {
> > +             if (pmu_name && pmu->name && strcmp(pmu_name, pmu->name))
>
> Why remove perf_pmu__is_hybrid check?

Thanks for checking! If you have the perf_pmu__is_hybrid check then
the filter only applies PMUs that are hybrid. Firstly, why have
is_hybrid in struct perf_pmu if you use this function that searches a
list?  Secondly, the point of this change is to make the PMU name
filtering a generic feature rather than one limited to specifically
PMUs called cpu_core and cpu_atom.

Thanks,
Ian

>
> >                       continue;
> > -             }
> >
> >               list_for_each_entry(alias, &pmu->aliases, list) {
> >                       char *name = alias->desc ? alias->name :
>
> --
> Zhengjun Xing
