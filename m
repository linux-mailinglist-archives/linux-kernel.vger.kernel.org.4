Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C0F730ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjFOFto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFOFtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:49:42 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6F010E9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:49:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9b7de94e7so155401cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686808180; x=1689400180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OtevX4Ed8o9vOu7pBdbUE0N/6rDWNEIM9CMGtbBiG8=;
        b=uWJspio/ujbSrKrhjccdYpKoLZsnkwm2YqgJ5Wq9LWi1jTHtdfZkgus3kXPbvMe1UA
         xv3Ou7GZxdhRKNr8ntrPNg1CYHhzSThtm+w/7FuvHOkFp4z+VUGvHu8FnW/1wY6oPryR
         +luuGPw11CHqV65nP6gnXBaB0rzSml/T6qWODxyj0Ro35RE6gHAJpTp0sZVnSnTH4GWv
         9h4jId8My+q0cOY4dbgPs5TND0rQ00KN//5giMLVhVGUcHiKdk7CDzqhUCVHIrYOdYsc
         EC5xyQUvSaYZ7Wuq3r3astskW7hK3+sO54V9KHgfWtpDH8uuixzZHVdyjaK0/nsL1Pfs
         7kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808180; x=1689400180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OtevX4Ed8o9vOu7pBdbUE0N/6rDWNEIM9CMGtbBiG8=;
        b=Sq156B7B0LRZOYNxW2TZ6VQjDInJEBUDEg/hUv2eo3IIhw6TE8WaLUsn2N5LS9H3Iw
         8Bf5FHSHMXwGC/LkxRU9wJAKgtpQSbmFvQ0FDkbxYFOYZKx5lIK4s8zfpXfJMxhoZHo4
         b+432gfG+4C2E6B/I/GXx4UfzU8lmYPV5CvpU2SQKFoWW676j2jCqgSgifF0luQhenee
         R0P8xa2P1QiSqQkS7rqyFFLUc4yOCSUV9fTdo34R/2h/pdBwsfkkEO0CnslxuEt6Vqgj
         gCBXdCSf+9OD9vhRM2FupA/4ZhsKSdtoXp8nlMr/+UbsFDhkc6iL2IQmintncOwEjUil
         tlyQ==
X-Gm-Message-State: AC+VfDzBOLnnhqy7uCbdOIV3SaPbdUNpA/h3VThb5ePzJUtKx0CMCV1w
        DRlFvZWx33eQn3q8eWGEmfq0uUfB+WpGluzLhxbmYA==
X-Google-Smtp-Source: ACHHUZ7RNsojShxUmQ/UvuWDYnPae06STozzKgRTOJNOQEoo2GLqpr4YDs4raGdjATmEs7zmc+BRLQAf2XDZ7512P5A=
X-Received: by 2002:a05:622a:1988:b0:3f9:6930:1308 with SMTP id
 u8-20020a05622a198800b003f969301308mr76070qtc.13.1686808180514; Wed, 14 Jun
 2023 22:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230615001735.3643996-1-kan.liang@linux.intel.com> <20230615001735.3643996-2-kan.liang@linux.intel.com>
In-Reply-To: <20230615001735.3643996-2-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 22:49:28 -0700
Message-ID: <CAP-5=fV2_7yWftPwd50r-OhxTdT3TKdZEdVsZAY7SE3UHRa=2A@mail.gmail.com>
Subject: Re: [PATCH V2 1/8] perf evsel: Fix the annotation for hardware events
 on hybrid
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
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

On Wed, Jun 14, 2023 at 5:18=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The annotation for hardware events is wrong on hybrid. For example,
>
>  # ./perf stat -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>          32,148.85 msec cpu-clock                        #   32.000 CPUs =
utilized
>                374      context-switches                 #   11.633 /sec
>                 33      cpu-migrations                   #    1.026 /sec
>                295      page-faults                      #    9.176 /sec
>         18,979,960      cpu_core/cycles/                 #  590.378 K/sec
>        261,230,783      cpu_atom/cycles/                 #    8.126 M/sec=
                       (54.21%)
>         17,019,732      cpu_core/instructions/           #  529.404 K/sec
>         38,020,470      cpu_atom/instructions/           #    1.183 M/sec=
                       (63.36%)
>          3,296,743      cpu_core/branches/               #  102.546 K/sec
>          6,692,338      cpu_atom/branches/               #  208.167 K/sec=
                       (63.40%)
>             96,421      cpu_core/branch-misses/          #    2.999 K/sec
>          1,016,336      cpu_atom/branch-misses/          #   31.613 K/sec=
                       (63.38%)
>
> The hardware events have extended type on hybrid, but the evsel__match()
> doesn't take it into account.
>
> Filter the config on hybrid before checking.
>
> With the patch,
>
>  # ./perf stat -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>          32,139.90 msec cpu-clock                        #   32.003 CPUs =
utilized
>                343      context-switches                 #   10.672 /sec
>                 32      cpu-migrations                   #    0.996 /sec
>                 73      page-faults                      #    2.271 /sec
>         13,712,841      cpu_core/cycles/                 #    0.000 GHz
>        258,301,691      cpu_atom/cycles/                 #    0.008 GHz  =
                       (54.20%)
>         12,428,163      cpu_core/instructions/           #    0.91  insn =
per cycle
>         37,786,557      cpu_atom/instructions/           #    2.76  insn =
per cycle              (63.35%)
>          2,418,826      cpu_core/branches/               #   75.259 K/sec
>          6,965,962      cpu_atom/branches/               #  216.739 K/sec=
                       (63.38%)
>             72,150      cpu_core/branch-misses/          #    2.98% of al=
l branches
>          1,032,746      cpu_atom/branch-misses/          #   42.70% of al=
l branches             (63.35%)
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evsel.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index b365b449c6ea..cc6fb3049b99 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -10,6 +10,7 @@
>  #include <internal/evsel.h>
>  #include <perf/evsel.h>
>  #include "symbol_conf.h"
> +#include "pmus.h"
>
>  struct bpf_object;
>  struct cgroup;
> @@ -350,9 +351,19 @@ u64 format_field__intval(struct tep_format_field *fi=
eld, struct perf_sample *sam
>
>  struct tep_format_field *evsel__field(struct evsel *evsel, const char *n=
ame);
>
> -#define evsel__match(evsel, t, c)              \
> -       (evsel->core.attr.type =3D=3D PERF_TYPE_##t &&      \
> -        evsel->core.attr.config =3D=3D PERF_COUNT_##c)
> +static inline bool __evsel__match(const struct evsel *evsel, u32 type, u=
64 config)
> +{
> +       if (evsel->core.attr.type !=3D type)
> +               return false;
> +
> +       if ((type =3D=3D PERF_TYPE_HARDWARE || type =3D=3D PERF_TYPE_HW_C=
ACHE)  &&
> +           perf_pmus__supports_extended_type())
> +               return (evsel->core.attr.config & PERF_HW_EVENT_MASK) =3D=
=3D config;
> +
> +       return evsel->core.attr.config =3D=3D config;
> +}
> +
> +#define evsel__match(evsel, t, c) __evsel__match(evsel, PERF_TYPE_##t, P=
ERF_COUNT_##c)
>
>  static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
>  {
> --
> 2.35.1
>
