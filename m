Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD956F4734
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjEBPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjEBPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:30:11 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EC02733
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:30:08 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33124b0dd85so102215ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683041407; x=1685633407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZx06idcsC+EaYZQXKoSd4jywVamtp3q4gWRtfyTqgg=;
        b=xAs0rTT2QFWK99x8lOrIpGnrlln4Mlhai3kbLqnDZbDQnrq70VBST4DjGw43P5uk1A
         K5i/aHRYjxz3AXWbPfQegJkXdfy20+u4LUdhn8BpWyVETCDkCfxB4EvfTnQB5j+wLb3u
         jworDFcgWU40GR2YWfqN+PvvWIS+mvIn7VBheywB4qMEBB4RTzVRnIP3WqP7TKaspb7l
         hSAymP5M9Sk9Gj9ojI0l8yLaxjuLKQA5EbU1cbbe0I30w91E0uyJqcaencz6MsuJc2HU
         IWKA9qiIlaDLWv7J6MkHF2sfSuKJCW92GSwSOJrg5dvGy35qmwMig77W7Wb4h3d1pj7F
         LBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683041407; x=1685633407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZx06idcsC+EaYZQXKoSd4jywVamtp3q4gWRtfyTqgg=;
        b=CgylAiuq4VE49eD6YmGpoPN3HKyV8+l4Im25Bx/2VL0TxRG96O4F7xpuXqCa/3HYyU
         6zlVJmOjJqN2n3iIoy8f70rs3P253bZ6bp53EYOjVCspmIzfcuzhxloGceD8UjKvKvyB
         3NLfNxzR0reNz2oWrHa06QZKu1wPt00elB/zHYBfpHyjI1XPMJF5JHCHE3bVrxG/y4+w
         5KLNWwVNnsi+4BJPUkBmWQWqDbb+jwiaT9T7s0UAviTxMFt/3/qBG7ehH0IG0sNoU2h6
         Sf3gr/hpv7hcVl1MY45uxX4TCbhKLpEqWZTzbZoiZftNxhTkhQHs2lxH1tolhB6iGAqu
         ogKQ==
X-Gm-Message-State: AC+VfDyYvOkL1rUSlN/F1G+LMnazm3qOdj1oEMVng/I9nFDhZTdaBJcS
        h2azGZzdoCAd7FYb7pcqwJ70o35wFAQGOzCM2excVg==
X-Google-Smtp-Source: ACHHUZ5eaSJQDXEHiQ+36CcSzlqC/Gcfm8EGUpky83nDzDApu5gY75S68WkDGMC1iUTLWnzTXzhxWI9SDhvdXE6/RQM=
X-Received: by 2002:a05:6e02:2189:b0:315:8e3a:f546 with SMTP id
 j9-20020a056e02218900b003158e3af546mr366020ila.6.1683041406792; Tue, 02 May
 2023 08:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com> <20230429053506.1962559-13-irogers@google.com>
 <31dbae6c-4cbe-d7e2-bc78-beed959cbddc@amd.com> <CAP-5=fW-_2OxYFTVuZgSPAPEH7DLGm1xS_Nijb0cTj3YKBQ7-A@mail.gmail.com>
In-Reply-To: <CAP-5=fW-_2OxYFTVuZgSPAPEH7DLGm1xS_Nijb0cTj3YKBQ7-A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 May 2023 08:29:55 -0700
Message-ID: <CAP-5=fX2ya1eLs-3bVk0f-CwqYvx06XOrPD87mNE4WRmfMKUJw@mail.gmail.com>
Subject: Re: [PATCH v3 12/46] perf test: Test more sysfs events
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
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
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 8:16=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, May 2, 2023 at 3:27=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
> >
> > > @@ -2225,74 +2226,82 @@ static int test_pmu(void)
> > >
> > >  static int test__pmu_events(struct test_suite *test __maybe_unused, =
int subtest __maybe_unused)
> > >  {
> > > -     struct stat st;
> > > -     char path[PATH_MAX];
> > > -     struct dirent *ent;
> > > -     DIR *dir;
> > > -     int ret;
> > > +     struct perf_pmu *pmu;
> > > +     int ret =3D TEST_OK;
> > >
> > > -     if (!test_pmu())
> > > -             return TEST_SKIP;
> > > +     perf_pmus__for_each_pmu(pmu) {
> >
> > 'pmus' list might be empty and, if so, we need to fill it first with:
> >
> >         if (list_empty(&pmus))
> >                 perf_pmu__scan(NULL);
> >
> > before iterating over it. Other option is to add this code to
> > perf_pmus__for_each_pmu() macro itself.
> >
> > With that, the test fails for me:
> >
> > $ sudo ./perf test 6
> >   6: Parse event definition strings                                  :
> >   6.1: Test event parsing                                            : =
Ok
> >   6.2: Test parsing of "hybrid" CPU events                           : =
Skip (not hybrid)
> >   6.3: Parsing of all PMU events from sysfs                          : =
FAILED!
> >
> > > +             struct stat st;
> > > +             char path[PATH_MAX];
> > > +             struct dirent *ent;
> > > +             DIR *dir;
> > > +             int err;
> > >
> > > -     snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu/event=
s/",
> > > -              sysfs__mountpoint());
> > > +             snprintf(path, PATH_MAX, "%s/bus/event_source/devices/%=
s/events/",
> > > +                     sysfs__mountpoint(), pmu->name);
> > >
> > > -     ret =3D stat(path, &st);
> > > -     if (ret) {
> > > -             pr_debug("omitting PMU cpu events tests: %s\n", path);
> > > -             return TEST_OK;
> > > -     }
> > > +             err =3D stat(path, &st);
> > > +             if (err) {
> > > +                     pr_debug("skipping PMU %s events tests: %s\n", =
pmu->name, path);
> > > +                     ret =3D combine_test_results(ret, TEST_SKIP);
> >
> > combine_test_results(ret, TEST_OK); probably? Since many pmus don't exp=
ose
> > events via sysfs.
>
> Thanks Ravi! The following looks to address the issues and I'll add it to=
 v4.
>
> '''
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index 35b35a5c795c..2ff61ee8f970 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -559,7 +559,8 @@ static int test__checkevent_pmu_events(struct
> evlist *evlist)
>        struct evsel *evsel =3D evlist__first(evlist);
>
>        TEST_ASSERT_VAL("wrong number of entries", 1 =3D=3D evlist->core.n=
r_entries);
> -       TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.at=
tr.type);
> +       TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.at=
tr.type ||
> +                                     strncmp(evsel->pmu_name, "cpu/", 4)=
);

This should be strcmp(evsel->pmu_name, "cpu"). Or we could drop the
assert. I'll try to keep what's covered currently by the test while
extending the PMUs.

Thanks,
Ian

>        TEST_ASSERT_VAL("wrong exclude_user",
>                        !evsel->core.attr.exclude_user);
>        TEST_ASSERT_VAL("wrong exclude_kernel",
> @@ -2229,6 +2230,9 @@ static int test__pmu_events(struct test_suite
> *test __maybe_unused, int subtes
> t
>        struct perf_pmu *pmu;
>        int ret =3D TEST_OK;
>
> +       if (list_empty(&pmus))
> +                perf_pmu__scan(NULL);
> +
>        perf_pmus__for_each_pmu(pmu) {
>                struct stat st;
>                char path[PATH_MAX];
> @@ -2242,7 +2246,6 @@ static int test__pmu_events(struct test_suite
> *test __maybe_unused, int subtes
> t
>                err =3D stat(path, &st);
>                if (err) {
>                        pr_debug("skipping PMU %s events tests: %s\n",
> pmu->name, path);
> -                       ret =3D combine_test_results(ret, TEST_SKIP);
>                        continue;
>                }
> '''
