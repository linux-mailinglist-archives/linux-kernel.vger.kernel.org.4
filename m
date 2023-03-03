Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D037B6A8EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCCBlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCCBlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:41:22 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0A9559FF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:40:51 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id b16so849452iln.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 17:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677807649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khggf42f3YtYMUMSDZgfUfR5xZivtQixxKEQHB+U/2U=;
        b=bSeSZ/wX7VaE+bq7L7DqwWnMDj5bnLLqWA2wuyFBTnLO27ActjA7a7/wsIQ0GZm8df
         WhdMHzafizgiHHAM4xDA6+nS+eKChBzvaAn5X+bLbiELJu8JKaxYW/hlyvvm/daGpkaR
         lJ4SrFXS5xxSd4Uk/Tqv7tHZvC2T0yaMcdTvVKuUAphM9hFOeNBfOuDMYVnFpHbW6lDf
         MKFYAHPVCM1DwXKmgsBIjivUbOPrdAUwS8Gg96FQ7FAvJcBn2TMRZXpRwvSsy1TfrGZ6
         j/QT3PY5wecPKdXejt7hYg0BOqQ4tVko87hxsVOqSNbNZCVXUfN/+nVs2irb8GLPredX
         TJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677807649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khggf42f3YtYMUMSDZgfUfR5xZivtQixxKEQHB+U/2U=;
        b=Hjjc0wBSfNQ67G1/2G2k+vnpdFD071HE9OsMP368mD7J9jpfGk7Yx4Z5vqIcASH5o/
         0av/q6r7BZzT5Nus6ihhMnJ5P/f7mUYpwVSYKyMhX1lesFFaPvDa6BdCDvD7/miagSQn
         7YBb4NuXDiXgftNcV1+2N5qx56CZxKzFHQmvTjpE8J1+itdfKSwdvVsRUD/qV1gVoI/k
         t8vWSLIaZX2oI9LU4ynuTQ2eqQ5p2kRvi0e1fBTZsBkseeTyr+PRtDQiG9/QkNsG0J7M
         ONggMaiTUCVEQtL2niYEOEtsf/ltnadgDYd84N90GkZHm0hpgIB8GMPjI/kzRjK+vTZl
         GqzQ==
X-Gm-Message-State: AO0yUKVAmFk6Pe9CjRZPpqvDdlwmxUpJagq7jYndsX9uktoI0KgIweYf
        unl/ILfM+EO8/T6/Q7Ej6OhMYoNnMdoXspQhpF7kGw==
X-Google-Smtp-Source: AK7set8PocFGZyyZlPbbwqXwSdOAGD/q0nDcEI9b/NO5N35Wovb9Ysg/2M2bM5ab5lmxzcck10q/tlUZwtDGsq4gjpA=
X-Received: by 2002:a05:6e02:f87:b0:310:9afc:aa6 with SMTP id
 v7-20020a056e020f8700b003109afc0aa6mr242914ilo.0.1677807648960; Thu, 02 Mar
 2023 17:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com> <20230302212531.1043318-6-irogers@google.com>
 <CAM9d7cgwM8Jf1iTgoy6=3kMc1EKG5J=Zqg9q2W4Aq+kdLkyjQQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgwM8Jf1iTgoy6=3kMc1EKG5J=Zqg9q2W4Aq+kdLkyjQQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 17:40:30 -0800
Message-ID: <CAP-5=fWB1BdQ0mKY3MDt7TgfmP_2w4CgEaDYFMrChPt-G9emSA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] perf evsel: Allow const evsel for certain accesses
To:     Namhyung Kim <namhyung@kernel.org>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 4:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Thu, Mar 2, 2023 at 1:26 PM Ian Rogers <irogers@google.com> wrote:
> >
> > List sorting, added later to evlist, passes const elements requiring
> > helper functions to also be const. Make the argument to
> > evsel__find_pmu, evsel__is_aux_event and evsel__leader const.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.c  | 2 +-
> >  tools/perf/util/evsel.h  | 6 +++---
> >  tools/perf/util/pmu.c    | 6 +++---
> >  tools/perf/util/python.c | 2 +-
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 51e8ce6edddc..2dc2c24252bb 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3139,7 +3139,7 @@ bool evsel__is_hybrid(const struct evsel *evsel)
> >         return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
> >  }
> >
> > -struct evsel *evsel__leader(struct evsel *evsel)
> > +struct evsel *evsel__leader(const struct evsel *evsel)
>
> It seems like it should return const struct evsel *, right?

Yes, but that breaks things :-)

> >  {
> >         return container_of(evsel->core.leader, struct evsel, core);
> >  }
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 814a49ebb7e3..676c499323e9 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -212,8 +212,8 @@ int evsel__object_config(size_t object_size,
> >                          int (*init)(struct evsel *evsel),
> >                          void (*fini)(struct evsel *evsel));
> >
> > -struct perf_pmu *evsel__find_pmu(struct evsel *evsel);
> > -bool evsel__is_aux_event(struct evsel *evsel);
> > +struct perf_pmu *evsel__find_pmu(const struct evsel *evsel);
> > +bool evsel__is_aux_event(const struct evsel *evsel);
> >
> >  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
> >
> > @@ -505,7 +505,7 @@ int evsel__store_ids(struct evsel *evsel, struct ev=
list *evlist);
> >
> >  void evsel__zero_per_pkg(struct evsel *evsel);
> >  bool evsel__is_hybrid(const struct evsel *evsel);
> > -struct evsel *evsel__leader(struct evsel *evsel);
> > +struct evsel *evsel__leader(const struct evsel *evsel);
> >  bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
> >  bool evsel__is_leader(struct evsel *evsel);
> >  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 43b6182d96b7..45d9b8e28e16 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -988,7 +988,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pm=
u)
> >         return NULL;
> >  }
> >
> > -struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
> > +struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
> >  {
> >         struct perf_pmu *pmu =3D NULL;
> >
> > @@ -1000,11 +1000,11 @@ struct perf_pmu *evsel__find_pmu(struct evsel *=
evsel)
> >                         break;
> >         }
> >
> > -       evsel->pmu =3D pmu;
> > +       ((struct evsel *)evsel)->pmu =3D pmu;
>
> Maybe we can move it out of the function and make callers set it.

Right, I considered this a case where in C++ we'd use mutable so
casting away the const wasn't the worst offense.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >         return pmu;
> >  }
> >
> > -bool evsel__is_aux_event(struct evsel *evsel)
> > +bool evsel__is_aux_event(const struct evsel *evsel)
> >  {
> >         struct perf_pmu *pmu =3D evsel__find_pmu(evsel);
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 42e8b813d010..ab48ffbb6448 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -83,7 +83,7 @@ const char *perf_env__arch(struct perf_env *env __may=
be_unused)
> >   * far, for the perf python binding known usecases, revisit if this be=
come
> >   * necessary.
> >   */
> > -struct perf_pmu *evsel__find_pmu(struct evsel *evsel __maybe_unused)
> > +struct perf_pmu *evsel__find_pmu(const struct evsel *evsel __maybe_unu=
sed)
> >  {
> >         return NULL;
> >  }
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
> >
