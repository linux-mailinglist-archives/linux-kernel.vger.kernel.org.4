Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB51D6FBAF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjEHWTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHWTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:19:03 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A383C3B
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 15:19:01 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f396606ab0so29321cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683584341; x=1686176341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCuWEM+/+k0Hql5FRWsc3HAhfzT+UCFW3skGrNQX8f4=;
        b=e+mULCFJup7aF/lsiFIA3sBlACIq57LfMbhbMU9KOLEGIRmmaL0VhThoYBUqmsQCoW
         2bVUheXFY188eVOylaxzgBIEfFbyQU0rHwUJiWM91ufEOl0pjRAGl83+vJAiWyZiXGxn
         L/gGYuHKkSg5b5lAZ8y609ULUUNBQG5Zr2cDT6Kr2KkHea6CcYEvqknLQsm9WIUIO322
         SS8EvqP/eFAB0YKKJivFgTUv3w6moh+QRzhUjnZDglyGhOkATvCYkysUT8Oz2kmXwmbx
         BgnPTtqIHopBMDWHXUTFu6LhHGWrd/kAfHiDFjixobV1bAJkFT829weK9+F1lwmK+g1i
         ztUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683584341; x=1686176341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCuWEM+/+k0Hql5FRWsc3HAhfzT+UCFW3skGrNQX8f4=;
        b=Yyhqi2vAVYRzns7dgfWPmzkj5TDTuzPY6MRKtULImK89k7lGa/3eaNC4VRe8njgulj
         iOEq15zIr2jBUJ3CCub3h7EMJR7A4kYd7aLkgzUO5Sfb1ZFH1vz89wiXQsdUj5VEEHVX
         xzn59pNG/5VM6vgv/pqi2TMVySv8T6IG6wb1axLYrqDmp9ztWwJGy9Sib5zGtFZaVTfv
         jg0LXxBb0qArVhC5BB+IG8paUHJfXg+r4X4wS9jbxM6eFe6koLj3q5xhDFX4i+7PaJGN
         dgqXgb41MFL0q8C+CjWFZ/tjcgJ49aYftFWZMnsTW2M/aMn/pWhnSoXliR31D93dJngt
         INoQ==
X-Gm-Message-State: AC+VfDy4dNM7JDhPSlkRO6c0JEO8uQBtWUw748Hl45PRSxqHBJmGtI8i
        r6VEm9opXyB0pkcs2E3LLShTkLLueu0n45bcxc8p5g==
X-Google-Smtp-Source: ACHHUZ5JLTSWsJkp9+NFuKURcp3h9dUzP2f50CpOOyBRuG7HynNsWaE935rN7Q3GxhqvUGSg0FKsexIKDI63lyCfVS0=
X-Received: by 2002:a05:622a:4a:b0:3f3:8d17:ab9 with SMTP id
 y10-20020a05622a004a00b003f38d170ab9mr15885qtw.13.1683584340774; Mon, 08 May
 2023 15:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230508093952.27482-1-adrian.hunter@intel.com> <20230508093952.27482-3-adrian.hunter@intel.com>
In-Reply-To: <20230508093952.27482-3-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 May 2023 15:18:49 -0700
Message-ID: <CAP-5=fU-Ud7=o52VG_oJ6roQNkxTMC-LpiMFDj7CJuqFiEiihQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] perf parse-events: Do not break up AUX event group
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Mon, May 8, 2023 at 2:40=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> Do not assume which events may have a PMU name, allowing the logic to
> keep an AUX event group together.
>
> Example:
>
>  Before:
>
>     $ perf record --no-bpf-event -c 10 -e '{intel_pt//,tlb_flush.stlb_any=
/aux-sample-size=3D8192/pp}:u' -- sleep 0.1
>     WARNING: events were regrouped to match PMUs
>     Cannot add AUX area sampling to a group leader
>
>  After:
>
>     $ perf record --no-bpf-event -c 10 -e '{intel_pt//,tlb_flush.stlb_any=
/aux-sample-size=3D8192/pp}:u' -- sleep 0.1
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.078 MB perf.data ]
>     $ perf script -F-dso,+addr | grep -C5 tlb_flush.stlb_any | head -11
>     sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cc82a2 dl_mai=
n+0x9a2 =3D> 7f5350cb38f0 _dl_add_to_namespace_list+0x0
>     sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cb3908 _dl_ad=
d_to_namespace_list+0x18 =3D> 7f5350cbb080 rtld_mutex_dummy+0x0
>     sleep 20444 [003]  7939.510243:  1  branches:uH:  7f5350cc8350 dl_mai=
n+0xa50 =3D> 0 [unknown]
>     sleep 20444 [003]  7939.510244:  1  branches:uH:  7f5350cc83ca dl_mai=
n+0xaca =3D> 7f5350caeb60 _dl_process_pt_gnu_property+0x0
>     sleep 20444 [003]  7939.510245:  1  branches:uH:  7f5350caeb60 _dl_pr=
ocess_pt_gnu_property+0x0 =3D> 0 [unknown]
>     sleep 20444  7939.510245:       10 tlb_flush.stlb_any/aux-sample-size=
=3D8192/pp: 0 7f5350caeb60 _dl_process_pt_gnu_property+0x0
>     sleep 20444 [003]  7939.510254:  1  branches:uH:  7f5350cc87fe dl_mai=
n+0xefe =3D> 7f5350ccd240 strcmp+0x0
>     sleep 20444 [003]  7939.510254:  1  branches:uH:  7f5350cc8862 dl_mai=
n+0xf62 =3D> 0 [unknown]
>     sleep 20444 [003]  7939.510255:  1  branches:uH:  7f5350cc9cdc dl_mai=
n+0x23dc =3D> 0 [unknown]
>     sleep 20444 [003]  7939.510257:  1  branches:uH:  7f5350cc89f6 dl_mai=
n+0x10f6 =3D> 7f5350cb9530 _dl_setup_hash+0x0
>     sleep 20444 [003]  7939.510257:  1  branches:uH:  7f5350cc8a2d dl_mai=
n+0x112d =3D> 7f5350cb3990 _dl_new_object+0x0
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Fixes: 347c2f0a0988 ("perf parse-events: Sort and group parsed events")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/evsel.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index e18752fd9245..9fdcde5471df 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -828,11 +828,9 @@ bool evsel__name_is(struct evsel *evsel, const char =
*name)
>
>  const char *evsel__group_pmu_name(const struct evsel *evsel)
>  {
> -       struct evsel *leader, *pos;
> +       struct evsel *leader =3D evsel__leader(evsel);
> +       struct evsel *pos;
>
> -       /* If the pmu_name is set use it. pmu_name isn't set for CPU and =
software events. */
> -       if (evsel->pmu_name)
> -               return evsel->pmu_name;
>         /*
>          * Software events may be in a group with other uncore PMU events=
. Use
>          * the pmu_name of the first non-software event to avoid breaking=
 the
> @@ -841,7 +839,6 @@ const char *evsel__group_pmu_name(const struct evsel =
*evsel)
>          * Aux event leaders, like intel_pt, expect a group with events f=
rom
>          * other PMUs, so substitute the AUX event's PMU in this case.
>          */
> -       leader  =3D evsel__leader(evsel);
>         if (evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE || evsel__is_=
aux_event(leader)) {
>                 /* Starting with the leader, find the first event with a =
named PMU. */
>                 for_each_group_evsel(pos, leader) {
> @@ -850,7 +847,7 @@ const char *evsel__group_pmu_name(const struct evsel =
*evsel)
>                 }
>         }
>
> -       return "cpu";
> +       return evsel->pmu_name ?: "cpu";
>  }
>
>  const char *evsel__metric_id(const struct evsel *evsel)
> --
> 2.34.1
>
