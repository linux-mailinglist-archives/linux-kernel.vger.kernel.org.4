Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD96F0D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjD0VCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 17:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjD0VCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:02:51 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A361FE5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:02:49 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-32ec968434eso504335ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682629369; x=1685221369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouBq30mUFSEiOBYVUCCDbv8YsA/H6ZIZmXUDEO6WZA0=;
        b=Z410b/UI/Ebkt4WXElqI2T957mJsD2OY4HaAeYeSGMsTtYEBzImJTZcIx7A5kybzcd
         8q9AlVHvadcDoCMd3zpKVZHSJvKN1vl4oXIUm8eqbP5vGKbneCFM8Raz7KkWtwqkWJR+
         fzHI6cLbluuWEO6z1EkAwJR/3fW1cVGAsdQ3jSGo38Yh+fxn5T219pv/cLXDOaflMQmX
         +cWyCK50IpdPwMT6tmHwYKZe7IYWjFgo8aSjt9cMHFfhVBMhvyOjWMiLIeJ2prRrq1fW
         UFu2VW29+eyMkTi/jbN3dPFGKp94p1rpt1kNEBoBycWsxKuxgXPYUjUhXRDy6KvuEGNh
         3LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682629369; x=1685221369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouBq30mUFSEiOBYVUCCDbv8YsA/H6ZIZmXUDEO6WZA0=;
        b=FpTv+KMmwVb/PU5KlOhuHpzF27aSD3rridQAPlcAbNumXcZ1sBTMUYXZSKMLDYmkuJ
         nSAbtP1FubBSfrIyCY3Ru4Qr0th76QNV0N4gC5hHKPtLvxcHZmEFf6WbOLHjqrnbM68E
         lS4Q99atJIjApn+BtkzSt29ySLAn97z3MP+4IDUoaDIQaJ2yOkKoS7VaS1ZVPAlK15zj
         S1u4nYA1P7z3U0XFMYK8K13jnw7ndrAzBoZoGhZ3UFQoxK9aBXkvS8GWATKe+7JBzSrR
         IPE2Bw205OUCyDufATteUGGknjmZVV+nUJ4LW1rKli9jUNvfp1ZoDkvYPKZkpyUgJLFx
         bhgQ==
X-Gm-Message-State: AC+VfDydRycqZnXMn2QJoTLHoze4TOA9Dw23V72kKyZT53ZM3R/O3R78
        4Fok4lP/AnxN+AJZhLCYwZkSQ6Lyk3H95oBwmcxZvQ==
X-Google-Smtp-Source: ACHHUZ7I0WSMkds9FDVzlmllkA0ORVSKEvWRCV/QSciMXWtk5wwkGdySbM0xQIPO4qBmZQfOgr1Zsz5HYfL4oE6IvUU=
X-Received: by 2002:a05:6e02:152c:b0:322:c2fc:5e47 with SMTP id
 i12-20020a056e02152c00b00322c2fc5e47mr91271ilu.4.1682629368467; Thu, 27 Apr
 2023 14:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com> <20230426070050.1315519-22-irogers@google.com>
 <6396e5dc-bf53-ce0d-15ea-0a1aedecf691@arm.com> <CAP-5=fXwn43dFLhhXzpd3WWxc2-Vb0uOxhbZvDn9yg5-U_gffg@mail.gmail.com>
In-Reply-To: <CAP-5=fXwn43dFLhhXzpd3WWxc2-Vb0uOxhbZvDn9yg5-U_gffg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 14:02:32 -0700
Message-ID: <CAP-5=fXqd+ja15PHrRkSNXg92nQ2Y_8rujht-Quj4rmR26caEw@mail.gmail.com>
Subject: Re: [PATCH v1 21/40] perf parse-events: Wildcard legacy cache events
To:     James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Samantha Alt <samantha.alt@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Apr 26, 2023 at 10:50=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Apr 26, 2023 at 3:11=E2=80=AFAM James Clark <james.clark@arm.com>=
 wrote:
> >
> >
> >
> > On 26/04/2023 08:00, Ian Rogers wrote:
> > > It is inconsistent that "perf stat -e instructions-retired" wildcard
> > > opens on all PMUs while legacy cache events like "perf stat -e
> > > L1-dcache-load-miss" do not. A behavior introduced by hybrid is that =
a
> > > legacy cache event like L1-dcache-load-miss should wildcard open on
> > > all hybrid PMUs. A call to is_event_supported is necessary for each
> > > PMU, a failure of which results in the event not being added. Rather
> > > than special case that logic, move it into the main legacy cache even=
t
> > > case and attempt to open legacy cache events on all PMUs.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/parse-events-hybrid.c | 33 -------------
> > >  tools/perf/util/parse-events-hybrid.h |  7 ---
> > >  tools/perf/util/parse-events.c        | 70 ++++++++++++++-----------=
--
> > >  tools/perf/util/parse-events.h        |  3 +-
> > >  tools/perf/util/parse-events.y        |  2 +-
> > >  5 files changed, 39 insertions(+), 76 deletions(-)
> > >
> > > diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/=
parse-events-hybrid.c
> > > index 7c9f9150bad5..d2c0be051d46 100644
> > > --- a/tools/perf/util/parse-events-hybrid.c
> > > +++ b/tools/perf/util/parse-events-hybrid.c
> > > @@ -179,36 +179,3 @@ int parse_events__add_numeric_hybrid(struct pars=
e_events_state *parse_state,
> > >       return add_raw_hybrid(parse_state, list, attr, name, metric_id,
> > >                             config_terms);
> > >  }
> > > -
> > > -int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
> > > -                                struct perf_event_attr *attr,
> > > -                                const char *name,
> > > -                                const char *metric_id,
> > > -                                struct list_head *config_terms,
> > > -                                bool *hybrid,
> > > -                                struct parse_events_state *parse_sta=
te)
> > > -{
> > > -     struct perf_pmu *pmu;
> > > -     int ret;
> > > -
> > > -     *hybrid =3D false;
> > > -     if (!perf_pmu__has_hybrid())
> > > -             return 0;
> > > -
> > > -     *hybrid =3D true;
> > > -     perf_pmu__for_each_hybrid_pmu(pmu) {
> > > -             LIST_HEAD(terms);
> > > -
> > > -             if (pmu_cmp(parse_state, pmu))
> > > -                     continue;
> > > -
> > > -             copy_config_terms(&terms, config_terms);
> > > -             ret =3D create_event_hybrid(PERF_TYPE_HW_CACHE, idx, li=
st,
> > > -                                       attr, name, metric_id, &terms=
, pmu);
> > > -             free_config_terms(&terms);
> > > -             if (ret)
> > > -                     return ret;
> > > -     }
> > > -
> > > -     return 0;
> > > -}
> > > diff --git a/tools/perf/util/parse-events-hybrid.h b/tools/perf/util/=
parse-events-hybrid.h
> > > index cbc05fec02a2..bc2966e73897 100644
> > > --- a/tools/perf/util/parse-events-hybrid.h
> > > +++ b/tools/perf/util/parse-events-hybrid.h
> > > @@ -15,11 +15,4 @@ int parse_events__add_numeric_hybrid(struct parse_=
events_state *parse_state,
> > >                                    struct list_head *config_terms,
> > >                                    bool *hybrid);
> > >
> > > -int parse_events__add_cache_hybrid(struct list_head *list, int *idx,
> > > -                                struct perf_event_attr *attr,
> > > -                                const char *name, const char *metric=
_id,
> > > -                                struct list_head *config_terms,
> > > -                                bool *hybrid,
> > > -                                struct parse_events_state *parse_sta=
te);
> > > -
> > >  #endif /* __PERF_PARSE_EVENTS_HYBRID_H */
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-e=
vents.c
> > > index 9b2d7b6572c2..e007b2bc1ab4 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -471,46 +471,50 @@ static int parse_events__decode_legacy_cache(co=
nst char *name, int pmu_type, __u
> > >
> > >  int parse_events_add_cache(struct list_head *list, int *idx, const c=
har *name,
> > >                          struct parse_events_error *err,
> > > -                        struct list_head *head_config,
> > > -                        struct parse_events_state *parse_state)
> > > +                        struct list_head *head_config)
> > >  {
> > > -     struct perf_event_attr attr;
> > > -     LIST_HEAD(config_terms);
> > > -     const char *config_name, *metric_id;
> > > -     int ret;
> > > -     bool hybrid;
> > > +     struct perf_pmu *pmu =3D NULL;
> > > +     bool found_supported =3D false;
> > > +     const char *config_name =3D get_config_name(head_config);
> > > +     const char *metric_id =3D get_config_metric_id(head_config);
> > >
> > > +     while ((pmu =3D perf_pmu__scan(pmu)) !=3D NULL) {
> > > +             LIST_HEAD(config_terms);
> > > +             struct perf_event_attr attr;
> > > +             int ret;
> > >
> > > -     memset(&attr, 0, sizeof(attr));
> > > -     attr.type =3D PERF_TYPE_HW_CACHE;
> > > -     ret =3D parse_events__decode_legacy_cache(name, /*pmu_type=3D*/=
0, &attr.config);
> > > -     if (ret)
> > > -             return ret;
> > > +             /*
> > > +              * Skip uncore PMUs for performance. Software PMUs can =
open
> > > +              * PERF_TYPE_HW_CACHE, so skip.
> > > +              */
> > > +             if (pmu->is_uncore || pmu->type =3D=3D PERF_TYPE_SOFTWA=
RE)
> > > +                     continue;
> > >
> > > -     if (head_config) {
> > > -             if (config_attr(&attr, head_config, err,
> > > -                             config_term_common))
> > > -                     return -EINVAL;
> > > +             memset(&attr, 0, sizeof(attr));
> > > +             attr.type =3D PERF_TYPE_HW_CACHE;
> > >
> > > -             if (get_config_terms(head_config, &config_terms))
> > > -                     return -ENOMEM;
> > > -     }
> > > +             ret =3D parse_events__decode_legacy_cache(name, pmu->ty=
pe, &attr.config);
> > > +             if (ret)
> > > +                     return ret;
> > >
> > > -     config_name =3D get_config_name(head_config);
> > > -     metric_id =3D get_config_metric_id(head_config);
> > > -     ret =3D parse_events__add_cache_hybrid(list, idx, &attr,
> > > -                                          config_name ? : name,
> > > -                                          metric_id,
> > > -                                          &config_terms,
> > > -                                          &hybrid, parse_state);
> > > -     if (hybrid)
> > > -             goto out_free_terms;
> > > +             if (!is_event_supported(PERF_TYPE_HW_CACHE, attr.config=
))
> > > +                     continue;
> >
> > Hi Ian,
> >
> > I get a test failure on Arm from this commit. I think it's related to
> > this check for support that's failing but I'm not sure what the
> > resolution should be.
>
> Yes, I brought in a behavior from hybrid to fail at parse time if a
> legacy cache event isn't supported. The issue is the perf_event_open
> may fail because of permissions and I think we probably need to
> special case that and allow the parsing to succeed otherwise tests
> like this will need to skip. I naively tested on a raspberry pi, which
> has no metrics, and so I'll try again tomorrow on a neoverse.

So, following discussion with Stephane we think the right approach is
to not use a "is_event_supported" test at parse time. The event parser
should take an event name and create a perf_event_attr only. Removing
the is_event_supported test will change Intel hybrid behavior.
Wildcarded events will always try to open on both PMUs, the
expectation is that the event that failed to open will report "<not
counted>". I'll add this change in v2.

Thanks,
Ian

> > I also couldn't see why the metrics in
> > test_soc/cpu/metrics.json aren't run on x86 (assuming they're generic
> > 'test anywhere' type metrics?).
>
> The testing code is split into a bunch of places for historical
> reasons, but the test_soc is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/tests/pmu-events.c?h=3Dv6.3#n1031
> '''
> $ gdb --args perf test -vv -F 10
> (gdb) b test__pmu_event_table
> Breakpoint 1 at 0x199d7c: file tests/pmu-events.c, line 467.
> (gdb) r
> Starting program: /tmp/perf/perf test -vv -F 10
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1"=
.
> 10: PMU events                                                      :
> 10.1: PMU event table sanity                                        :
> --- start ---
>
> Breakpoint 1, test__pmu_event_table (test=3D0x5555560bd080
> <suite.pmu_events>, subtest=3D0) at tes
> ts/pmu-events.c:467
> 467                     find_sys_events_table("pmu_events__test_soc_sys")=
;
> '''
>
> Something I observed is that tests/parse-events.c isn't testing
> against an ARM PMU and so skips a lot of testing. There should likely
> be a helper so that the string in that test can be dependent on the
> test platform. I worry this may expose some latent ARM issues with
> things like obscure modifiers.
>
> Thanks,
> Ian
>
> >   $ perf test -vvv "parsing of PMU event table metrics with fake"
> >   ...
> >   parsing 'dcache_miss_cpi': 'l1d\-loads\-misses / inst_retired.any'
> >   parsing metric: l1d\-loads\-misses / inst_retired.any
> >   Attempting to add event pmu 'inst_retired.any' with
> > 'inst_retired.any,' that may result in non-fatal errors
> >   After aliases, add event pmu 'inst_retired.any' with
> > 'inst_retired.any,' that may result in non-fatal errors
> >   inst_retired.any -> fake_pmu/inst_retired.any/
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             3
> >     config                           0x800010000
> >     disabled                         1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> >   sys_perf_event_open failed, error -2
> >
> >   check_parse_fake failed
> >   test child finished with -1
> >   ---- end ----
> >   PMU events subtest 4: FAILED!
> >
> > >
> > > -     ret =3D add_event(list, idx, &attr, config_name ? : name, metri=
c_id,
> > > -                     &config_terms);
> > > -out_free_terms:
> > > -     free_config_terms(&config_terms);
> > > -     return ret;
> > > +             found_supported =3D true;
> > > +
> > > +             if (head_config) {
> > > +                     if (config_attr(&attr, head_config, err,
> > > +                                             config_term_common))
> > > +                             return -EINVAL;
> > > +
> > > +                     if (get_config_terms(head_config, &config_terms=
))
> > > +                             return -ENOMEM;
> > > +             }
> > > +
> > > +             ret =3D add_event(list, idx, &attr, config_name ? : nam=
e, metric_id, &config_terms);
> > > +             free_config_terms(&config_terms);
> > > +     }
> > > +     return found_supported ? 0: -EINVAL;
> > >  }
> > >
> > >  #ifdef HAVE_LIBTRACEEVENT
> > > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-e=
vents.h
> > > index 5acb62c2e00a..0c26303f7f63 100644
> > > --- a/tools/perf/util/parse-events.h
> > > +++ b/tools/perf/util/parse-events.h
> > > @@ -172,8 +172,7 @@ int parse_events_add_tool(struct parse_events_sta=
te *parse_state,
> > >                         int tool_event);
> > >  int parse_events_add_cache(struct list_head *list, int *idx, const c=
har *name,
> > >                          struct parse_events_error *error,
> > > -                        struct list_head *head_config,
> > > -                        struct parse_events_state *parse_state);
> > > +                        struct list_head *head_config);
> > >  int parse_events_add_breakpoint(struct list_head *list, int *idx,
> > >                               u64 addr, char *type, u64 len);
> > >  int parse_events_add_pmu(struct parse_events_state *parse_state,
> > > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-e=
vents.y
> > > index f84fa1b132b3..cc7528558845 100644
> > > --- a/tools/perf/util/parse-events.y
> > > +++ b/tools/perf/util/parse-events.y
> > > @@ -476,7 +476,7 @@ PE_LEGACY_CACHE opt_event_config
> > >
> > >       list =3D alloc_list();
> > >       ABORT_ON(!list);
> > > -     err =3D parse_events_add_cache(list, &parse_state->idx, $1, err=
or, $2, parse_state);
> > > +     err =3D parse_events_add_cache(list, &parse_state->idx, $1, err=
or, $2);
> > >
> > >       parse_events_terms__delete($2);
> > >       free($1);
