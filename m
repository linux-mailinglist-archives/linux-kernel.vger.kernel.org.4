Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475A06F836D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjEENC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjEENC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:02:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D81316089
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:02:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f33a2ddfc1so212935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683291774; x=1685883774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLhpo8p3NjaRU+xZ3FnEvwtiwQmz433qnq9rqgkiBA4=;
        b=L613O4qFFi1OZj5Cm5vsFf6UgI/6wBV5NJX8lfURSt17zWYkYJ7MVwerf1X1Rqyg08
         aWu1RwAT40Z0NtpJ5T0VLxsMZc3CDU51BFF1V3OjDBUm62bNp3Xk5q3J++IztxiexfxW
         rLbOe0pAzNUqZ0E3yvbV86QIjj/mtea+XmpTOclcN81ZqjTlXkOuSJyM4OrLFMrLRd+Y
         YmzlKNSARBT8LyWHReVuLQFgHw3RIIhHAmhw07/nw3aWOekxh7tL95GlruUUbQLxubVo
         KaU7YdlNNilm+tAkJvvRK7favcDMZwjk4EKffLZo1yugQdVu0Qqu6e16Bwoj8KOP2w49
         LXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683291774; x=1685883774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLhpo8p3NjaRU+xZ3FnEvwtiwQmz433qnq9rqgkiBA4=;
        b=RimNRCE6Nm0/kxVbUvDwXWI86ymlL0yR8/7xewpznOcNuptGT9bRKkGUNClCrAAgS5
         snFOwl9bEIxbglKWimBeZhd8gXBBKFoPm5Dbd9vDoNUiweE2cifjVdK3uGnZCq4zy/DH
         DKcXq6LNRojp4rsQ7uL+EWzzpfp1JRbygWvIzMU0k+oVk1oAVISXcC5W43O9EfVyVjFc
         EZSwvz1Q8T2jKt9xdmCSfjzhljw9VLr4oD3kTsoQNxkcdexFppkYOxoo/tdZhMw0gq86
         yAIfnmn0KE8igd0dEvVRJ2v3DjOG380CWlSu2SOQZF6Hm+53eo5Yft6rlKchMAgDDaOI
         INMA==
X-Gm-Message-State: AC+VfDxHiV21ZNrLcbmBWDQgA9rL20jZMvEekrvVMtyStZvW3UrtsFGU
        KHpCBlN9oLecscsd1lzROAYPrldUxA9LfFUKgTsLCQ==
X-Google-Smtp-Source: ACHHUZ7b/onycZz8eT2ap563s8T5JnuQGsanELUkymTDMcNrQfqR1U9Ec3PN+VY6kkvds4iu8G/VuFv790kJjpuNuHQ=
X-Received: by 2002:a05:600c:45c6:b0:3f1:74cf:8563 with SMTP id
 s6-20020a05600c45c600b003f174cf8563mr128941wmo.5.1683291773816; Fri, 05 May
 2023 06:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230505064452.9660-1-adrian.hunter@intel.com>
In-Reply-To: <20230505064452.9660-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 5 May 2023 06:02:41 -0700
Message-ID: <CAP-5=fUwwvVVa=+bHEPC+bzxQFXVoXQmd+ercYtTDRSa5jDfWw@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: Do not break up AUX event group
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

On Thu, May 4, 2023 at 11:45=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Assume AUX event group is correct and not do break it up.
>
> Example:
>
>  Before:
>
>     $ perf record --no-bpf-event -c 10 -e '{intel_pt//,tlb_flush.stlb_any=
/aux-sample-size=3D8192/pp}:u' -- sleep 0.1

Could we add this, or similar, to the intel_pt tests?

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
> Fixes: 347c2f0a0988 ("perf parse-events: Sort and group parsed events")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

These changes are related:
https://lore.kernel.org/lkml/20230502223851.2234828-5-irogers@google.com/
https://lore.kernel.org/lkml/20230502223851.2234828-20-irogers@google.com/

> ---
>  tools/perf/util/evsel.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 356c07f03be6..a34f61a5271d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -828,7 +828,11 @@ bool evsel__name_is(struct evsel *evsel, const char =
*name)
>
>  const char *evsel__group_pmu_name(const struct evsel *evsel)
>  {
> -       const struct evsel *leader;
> +       const struct evsel *leader =3D evsel__leader(evsel);
> +
> +       /* Never break AUX event groups */
> +       if (evsel__is_aux_event(leader))
> +               return leader->pmu_name;
>
>         /* If the pmu_name is set use it. pmu_name isn't set for CPU and =
software events. */

I think this comment isn't true, hence this patch. I think we should
just move the check into the return, so:
return evsel->pmu_name ?: "cpu";

Sorry for the breakage!

Thanks,
Ian

>         if (evsel->pmu_name)
> @@ -837,15 +841,9 @@ const char *evsel__group_pmu_name(const struct evsel=
 *evsel)
>          * Software events may be in a group with other uncore PMU events=
. Use
>          * the pmu_name of the group leader to avoid breaking the softwar=
e event
>          * out of the group.
> -        *
> -        * Aux event leaders, like intel_pt, expect a group with events f=
rom
> -        * other PMUs, so substitute the AUX event's PMU in this case.
>          */
> -       leader  =3D evsel__leader(evsel);
> -       if ((evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE || evsel__is=
_aux_event(leader)) &&
> -           leader->pmu_name) {
> +       if (evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE && leader->pm=
u_name)
>                 return leader->pmu_name;
> -       }
>
>         return "cpu";
>  }
> --
> 2.34.1
>
