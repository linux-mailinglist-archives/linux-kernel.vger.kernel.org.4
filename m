Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8776A85D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCBQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCBQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:06:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4D0515DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:06:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id az36so11046651wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 08:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677773168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45um0PPdrlY43VdRNnyAzfel5NrZe30rf+cZnQhohI0=;
        b=XU4UgxFTlcPnuoa4qsyIziynGo54xUe6JLltmdIdh7WfyCnEnFjXQ5Y2zTgTLQfSOK
         4QtHXKclzgFSiQ6VQd7RhOpb5GmaRx3ajv+jsTlR9bq/OthC3VkFFE8NpKUyB6qoTn/r
         dvLiPdIctMf7h8iR8J0+bhKlP0qPoHo71Wvy64TFwuNR95J8mYtCcLy+nVlRx+Kxg4IY
         cBc0wIJu9gbtP8AvNi2FjtnlftYuw5JzUzEVDuwhPSjzrLJMES1Zt2GE2RYonylvm8iR
         X2UDcQ23ZOns1iFK5dot00/neagEFWcGA7lA9fyKkdWLzF1G2+zXLJszCyYoIWtSLMRH
         hgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677773168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45um0PPdrlY43VdRNnyAzfel5NrZe30rf+cZnQhohI0=;
        b=jXTAueRwvp1sIFKUdee6PLja/P1gCog/O8Ll30v98ANTc2L3Oc+mHxh3LFQ61Uqutu
         /7mwfJ4A4KNhSIMzmo99OFh2MZyuN0sUmnqTHQhpTjAIdoGTdBy7sBqbZOKSJEfTUKqj
         7QQafvPBPbuWei0SQ7DSrDVzAGPQmus4h4WgVB6tUTDh2Z4T0+vNVDjdtUqZeIBqAGjw
         C1bduKWc6K51pG4ax1Qm5dOM1OwdLL0TKiF9sMwH1AkguNi4GWj9C7TXAM+Vg9IFY9gH
         MirSmcjlOqXNJuIYIf2kLYW6nXjvPBOwUW0u7EpbpxbatSbsB2xrIjSa4deW6JdN0hHj
         +E+Q==
X-Gm-Message-State: AO0yUKVjWdgb3PmK7gHbuBwyu8CZDppzR16sfj0hBS0QChePFDhQZQy/
        pMrtVYpYzdmch02mzuY194IT2e7X0m4610rsdvebUg==
X-Google-Smtp-Source: AK7set+PtyNU/IlP+xgwkG23mEgycytRqwSDF0d4R084E5ctDT1y318peW4VQq4ZGRPap3XwE6xGXyir+Z3PYmu8TAA=
X-Received: by 2002:a05:600c:3c81:b0:3df:97fd:2222 with SMTP id
 bg1-20020a05600c3c8100b003df97fd2222mr3102833wmb.8.1677773167447; Thu, 02 Mar
 2023 08:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com> <20230302041211.852330-4-irogers@google.com>
 <ZACzkOmDFuRQ5MiR@kernel.org>
In-Reply-To: <ZACzkOmDFuRQ5MiR@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 08:05:53 -0800
Message-ID: <CAP-5=fX-F9UChi-sRcPTnRLYdU8n3B1jtk1QWEfKPdYYZDPP1A@mail.gmail.com>
Subject: Re: [PATCH v1 03/10] perf record: Early auxtrace initialization
 before event parsing
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
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
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 2, 2023 at 6:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Mar 01, 2023 at 08:12:04PM -0800, Ian Rogers escreveu:
> > This allows event parsing to use the evsel__is_aux_event function,
> > which is important when determining event grouping.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/auxtrace.c | 17 +++++++++++++----
> >  tools/perf/builtin-record.c         |  6 ++++++
> >  tools/perf/util/auxtrace.h          |  2 ++
> >  3 files changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/=
util/auxtrace.c
> > index 3da506e13f49..de1e4842ea2e 100644
> > --- a/tools/perf/arch/x86/util/auxtrace.c
> > +++ b/tools/perf/arch/x86/util/auxtrace.c
> > @@ -15,6 +15,19 @@
> >  #include "../../../util/intel-bts.h"
> >  #include "../../../util/evlist.h"
> >
> > +void auxtrace__early_init(void)
> > +{
> > +     struct perf_pmu *intel_pt_pmu;
> > +     struct perf_pmu *intel_bts_pmu;
> > +
> > +     intel_pt_pmu =3D perf_pmu__find(INTEL_PT_PMU_NAME);
> > +     if (intel_pt_pmu)
> > +             intel_pt_pmu->auxtrace =3D true;
> > +     intel_bts_pmu =3D perf_pmu__find(INTEL_BTS_PMU_NAME);
> > +     if (intel_bts_pmu)
> > +             intel_bts_pmu->auxtrace =3D true;
> > +}
> > +
> >  static
> >  struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evl=
ist,
> >                                                   int *err)
> > @@ -26,11 +39,7 @@ struct auxtrace_record *auxtrace_record__init_intel(=
struct evlist *evlist,
> >       bool found_bts =3D false;
> >
> >       intel_pt_pmu =3D perf_pmu__find(INTEL_PT_PMU_NAME);
> > -     if (intel_pt_pmu)
> > -             intel_pt_pmu->auxtrace =3D true;
>
> In this case, can't we do it as:
>
>         if (intel_pt_pmu =3D=3D NULL && intel_bts_pmu =3D=3D NULL)
>                 auxtrace__early_init();
>
> To avoid possibly doing the finds again?
>
> - Arnaldo

So this code is called after parse events and has the evlist. The
early init code is called before parse events so that the aux trace
PMUs are flagged for the sake of the is_aux call in evsel__pmu_name,
as aux events must be grouped with their different PMU type leader. It
won't be possible to combine the calls but I plan to look at
restructuring how PMUs are accessed so that searches are less
necessary.

Thanks,
Ian

> >       intel_bts_pmu =3D perf_pmu__find(INTEL_BTS_PMU_NAME);
> > -     if (intel_bts_pmu)
> > -             intel_bts_pmu->auxtrace =3D true;
> >
> >       evlist__for_each_entry(evlist, evsel) {
> >               if (intel_pt_pmu && evsel->core.attr.type =3D=3D intel_pt=
_pmu->type)
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 8374117e66f6..a0870c076dc0 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3940,6 +3940,10 @@ static int record__init_thread_masks(struct reco=
rd *rec)
> >       return ret;
> >  }
> >
> > +__weak void auxtrace__early_init(void)
> > +{
> > +}
> > +
> >  int cmd_record(int argc, const char **argv)
> >  {
> >       int err;
> > @@ -3985,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
> >       if (err)
> >               return err;
> >
> > +     auxtrace__early_init();
> > +
> >       argc =3D parse_options(argc, argv, record_options, record_usage,
> >                           PARSE_OPT_STOP_AT_NON_OPTION);
> >       if (quiet)
> > diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> > index 29eb82dff574..49a86aa6ac94 100644
> > --- a/tools/perf/util/auxtrace.h
> > +++ b/tools/perf/util/auxtrace.h
> > @@ -457,6 +457,8 @@ struct addr_filters {
> >
> >  struct auxtrace_cache;
> >
> > +void auxtrace__early_init(void);
> > +
> >  #ifdef HAVE_AUXTRACE_SUPPORT
> >
> >  u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
> > --
> > 2.39.2.722.g9855ee24e9-goog
> >
>
> --
>
> - Arnaldo
