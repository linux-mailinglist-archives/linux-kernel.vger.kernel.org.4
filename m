Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A329D6281E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiKNOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiKNODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:03:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B5E2B27D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:03:03 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j15so18457860wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Upo1p7yIONTS34mP2hxbi+ym/yel8/NOBaTszJc+2m8=;
        b=rS/yiHwceelQf46/zqQwOqIR1vKvGPK4tCohaDEb/jSJenMoXC9Pi1sfPDKMYl6S2Y
         iiHOZTNaD7cBMXGvSi9R0S59wJUbxxAcMpngMnyiBkuRCNY99vwEMg7F1soV8nhsZAMy
         0ISdZyYsVFvrT1I/HmHoAQxfY27a2DAOYXIOQzeCDd/rqEf2e/JBNDagwCe6nyblECh2
         puXK4iUB/ogqbYCfk1wqxfgSsYe58dM6VJzYYKoREGIHGMSlBWCvWVMVBqCj6A/vAHSn
         38YprkvpUHLPUT+o1fNAdVVXJK2QyvV1kw//KJ5mL5mqyy+yB6UzX/6EHBVQaShyxJI/
         7LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Upo1p7yIONTS34mP2hxbi+ym/yel8/NOBaTszJc+2m8=;
        b=ngipeWRZLKFhAlgaSBKwxdz/IzMKZPLY8tAIEGIh0Y6TKMEDmxkA4JpeMapMGXt7AO
         qT3R60okNAv9IjR2sJNCymLXpQTLs6tilTWKWW8klJR5M2MtDCN37Av3hn5YZnL5s2SF
         rB2jbIInt44IzQT86vOFuS6atvwE7sMO/tNFUOYRGJs0I/9XdJf+1EXcf2i7CHgkDADB
         TM5yUu+tZKKqUCVQLHkAtp35+huCDe4xyZYE3XzqBw1xtFV1eForGL+svVQbLxMG7cAx
         LfNSZXMd9Y3WPdtv1SmbczE03kDNF98SbPTK18cvq98bvs9fScIBMkEZAWAlXZg5XML8
         hgWQ==
X-Gm-Message-State: ANoB5pn8JRBFDJhe+lshDxNATTDgxLVAMBGDw2Onvd2U4eXmFSY7up4s
        iM6fkXfgAXT3ugmfNQ1MNyWQglQSNW3t3gkJDCqIEg==
X-Google-Smtp-Source: AA0mqf7GRMqgC4D/dgQNmLYxA5fvH1meawTc+pw4z6h8JxFBlpxsHBdY6Fdn+siDFl7DV1VL9dWPwxwJcJI5qS2pW7A=
X-Received: by 2002:a5d:6e89:0:b0:228:dd1d:8a42 with SMTP id
 k9-20020a5d6e89000000b00228dd1d8a42mr7711198wrz.375.1668434581479; Mon, 14
 Nov 2022 06:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com> <20221114075127.2650315-5-irogers@google.com>
 <78669391-0dec-1182-178d-aa4bbda54ea9@linux.intel.com>
In-Reply-To: <78669391-0dec-1182-178d-aa4bbda54ea9@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 06:02:48 -0800
Message-ID: <CAP-5=fVfAbhhSpGCpCZCt5J3dY7U5HfMrG2z+6yUDSy3Vr7_iQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] perf list: Generalize limiting to a PMU name
To:     "Liang, Kan" <kan.liang@linux.intel.com>
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
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

On Mon, Nov 14, 2022 at 5:58 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2022-11-14 2:51 a.m., Ian Rogers wrote:
> > Deprecate the --cputype option and add a --unit option where '--unit
> > cpu_atom' behaves like '--cputype atom'. The --unit option can be used
> > with arbitrary PMUs, for example:
> >
> > ```
> > $ perf list --unit msr pmu
> >
> > List of pre-defined events (to be used in -e or -M):
> >
> >   msr/aperf/                                         [Kernel PMU event]
> >   msr/cpu_thermal_margin/                            [Kernel PMU event]
> >   msr/mperf/                                         [Kernel PMU event]
> >   msr/pperf/                                         [Kernel PMU event]
> >   msr/smi/                                           [Kernel PMU event]
> >   msr/tsc/                                           [Kernel PMU event]
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-list.txt |  6 +++---
> >  tools/perf/builtin-list.c              | 18 ++++++++++++------
> >  tools/perf/util/metricgroup.c          |  3 ++-
> >  tools/perf/util/pmu.c                  |  4 +---
> >  4 files changed, 18 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> > index 57384a97c04f..44a819af573d 100644
> > --- a/tools/perf/Documentation/perf-list.txt
> > +++ b/tools/perf/Documentation/perf-list.txt
> > @@ -39,9 +39,9 @@ any extra expressions computed by perf stat.
> >  --deprecated::
> >  Print deprecated events. By default the deprecated events are hidden.
> >
> > ---cputype::
> > -Print events applying cpu with this type for hybrid platform
> > -(e.g. --cputype core or --cputype atom)
>
> The "--cputype" is removed from the documentation, but the code is still
> available. It sounds weird.
>
> Can we still keep the "--cputype" in the documentation? Just say that
> it's a deprecated option, please use the --unit cpu_atom instead. I
> think even better if we can throw a warning and point to --unit when the
> "--cputype" is used.

I think we want to remove --cputype widely in the code and replace
what it does with specifying a PMU name. Advertising a flag but then
warning seems strange and is a behavioral change from what is
currently done. For raw-dump we don't document it in the man page and
hide the flag, this is the pattern being followed here.

Thanks,
Ian

> Thanks,
> Kan
> > +--unit::
> > +Print PMU events and metrics limited to the specific PMU name.
> > +(e.g. --unit cpu, --unit msr, --unit cpu_core, --unit cpu_atom)
> >
> >  [[EVENT_MODIFIERS]]
> >  EVENT MODIFIERS
> > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > index 58e1ec1654ef..cc84ced6da26 100644
> > --- a/tools/perf/builtin-list.c
> > +++ b/tools/perf/builtin-list.c
> > @@ -21,7 +21,6 @@
> >
> >  static bool desc_flag = true;
> >  static bool details_flag;
> > -static const char *hybrid_type;
> >
> >  int cmd_list(int argc, const char **argv)
> >  {
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
> >  {
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
> >                       continue;
> > -             }
> >
> >               list_for_each_entry(alias, &pmu->aliases, list) {
> >                       char *name = alias->desc ? alias->name :
