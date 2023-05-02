Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629406F4834
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjEBQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjEBQTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:19:50 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919CE1992
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:19:45 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3311833ba3dso114285ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683044385; x=1685636385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CMyijs+XNrKux/SQRcQVuldFctn4dvQkkq0tZYcvyY=;
        b=rzKBaXoDGM+0wyev7OMKFK8+fyj11vVAS2euLP3VSuPPGHa22qBjScIViNWdXSF6WC
         K4yFjq9NKBWaY+WQi6Erw7TSLPH0bsj4U91NxkRbTzWym61W5rQMK/MMkjWFQk8zm8+Z
         JGSYPIDoMCaUoaBBy6PRLEGDpbHKCk/uMt468odXDcB0Ndbejsrh30URbB7L4k9Jd8i8
         KlEP08EQuTV6pD2R0TZ9r4XIAr3Wg9P9QYwf+7UO4xrKt8WnqFGnrjkgTA+9eKD+ZyWy
         TtEpPt0L+OnHjwbFuvCyg6s3ZiXmJCchRVuJc5tzQd9SNX5VxZ72LtaOKNsdjxah6TVW
         hNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683044385; x=1685636385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CMyijs+XNrKux/SQRcQVuldFctn4dvQkkq0tZYcvyY=;
        b=RxORnbvCd7vPZimBeWJ97f5cRa+Fw8BET8+wf9wpov/BvABfDsdCpqh8mHayH2jDlJ
         8e9y2eiOlMHcrRNd9IKcc3H2AInM1b3Rtvx17OfBjYb1MApEweg+mxbSRvLcfe6L4ndJ
         sPsp7NmSD+zacHGZkhLOnpISCrmWbd4baa3Z+qBln74890sWRB9vehxr9dmuEPXnYCb9
         rVf8ghQS3hOLlEx3akn9Dwpc+3llol1EipC0OA3P4vpBIXwuunYuLmvJ6D+cZwYOk7Ly
         t5F4byw7eWfsmo0QNKLyDpndD+PILOA28OdDWH80x+81YtEPh3nlnX64tiL682Ep/o3c
         HR4w==
X-Gm-Message-State: AC+VfDxPWQNp++AOdpXPdDkeqONthwy8nM8ByXsIv+HEeX9yYh0wOW+K
        BxdwKbKoxgxjOo6RGB7CrMSK1O5T7ToHGHydyb8C3Q==
X-Google-Smtp-Source: ACHHUZ7FLgkyhcnnIXkXfwOL6Q9i02uNPMkVWwVsmOFu/Du+tyrnxMHiS1Tdp0RijGB97br0MjJbrKVwAGN9k5QpjM0=
X-Received: by 2002:a05:6e02:1ba6:b0:330:eb79:91ad with SMTP id
 n6-20020a056e021ba600b00330eb7991admr254048ili.9.1683044384639; Tue, 02 May
 2023 09:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com> <20230429053506.1962559-15-irogers@google.com>
 <e3a87977-02a1-eb34-593e-844adc6669b7@amd.com>
In-Reply-To: <e3a87977-02a1-eb34-593e-844adc6669b7@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 May 2023 09:19:32 -0700
Message-ID: <CAP-5=fWY2SYdiogQoxEkAMAc8+_S5Mt3PgO1_=AhbKY3aicgYg@mail.gmail.com>
Subject: Re: [PATCH v3 14/46] perf test: Mask config then test
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

On Tue, May 2, 2023 at 3:44=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> > @@ -87,7 +92,7 @@ static int test__checkevent_raw(struct evlist *evlist=
)
> >
> >       TEST_ASSERT_VAL("wrong number of entries", 1 =3D=3D evlist->core.=
nr_entries);
> >       TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.at=
tr.type);
> > -     TEST_ASSERT_VAL("wrong config", 0x1a =3D=3D evsel->core.attr.conf=
ig);
> > +     TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
>
> Extended 'type' via 'config' is applicable only to HW and HW_CACHE types.
> I think we should not apply test_config() for other types. Even if they
> are ineffective in these tests (because we are not setting upper bits),
> they are semantically wrong IMO.
>
> In fact, AMD EventSelect is 12 bits and upper 4 bits are located at 35:32
> in PerfEvtSel register. So for RAW events, upper bits MUST NOT be ignored=
.

Thanks Ravi, this is important and I'll update the tests as you
suggest. I'd been iterating on this, which is why the test is this
way. We have two parsing cases, one where the type is explicitly given
like:
$ perf stat -e '4:0xC0' true
and another where the raw config is wildcard applied like:
$ perf stat -e 'rC0' true
The question is which PMUs should the 0xC0 raw event be opened on? The
answer in the code is to ignore all PMUs that aren't the "core" PMUs,
so cpu, cpu_atom, cpu_core, armv8... This matches existing behavior
but it wasn't clear to me that this was intentional. I think in the
future the wildcard application can be made more efficient to ignore
unnecessary PMUs and avoid the sysfs scan. Something that is a bit of
an issue in the event parsing is what exactly should be applied by
wildcard matching and there are inconsistencies.

Thanks,
Ian

> > @@ -139,8 +142,7 @@ static int test__checkevent_symbolic_alias(struct e=
vlist *evlist)
> >
> >       TEST_ASSERT_VAL("wrong number of entries", 1 =3D=3D evlist->core.=
nr_entries);
> >       TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE =3D=3D evsel->co=
re.attr.type);
> > -     TEST_ASSERT_VAL("wrong config",
> > -                     PERF_COUNT_SW_PAGE_FAULTS =3D=3D evsel->core.attr=
.config);
> > +     TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_=
PAGE_FAULTS));
>
> Ditto for PERF_TYPE_SOFTWARE. We should not use test_config().
>
>
> > @@ -160,7 +162,7 @@ static int test__checkevent_breakpoint(struct evlis=
t *evlist)
> >
> >       TEST_ASSERT_VAL("wrong number of entries", 1 =3D=3D evlist->core.=
nr_entries);
> >       TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT =3D=3D evsel->=
core.attr.type);
> > -     TEST_ASSERT_VAL("wrong config", 0 =3D=3D evsel->core.attr.config)=
;
> > +     TEST_ASSERT_VAL("wrong config", test_config(evsel, 0));
>
> Ditto for PERF_TYPE_BREAKPOINT.
