Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A6D6E68B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjDRPzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjDRPzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:55:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF996A78
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:55:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f08b6a9f8aso58215e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681833318; x=1684425318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pY9pHq2dLU+St3NtjkMXoaWK13Cg/WiXep4UpYBIrPw=;
        b=mm8wh/FA5a4YQFZ/iAjX7fNpwhPH2eRnAfJLRjxFmcE1yFZ9rVIyc4VoANT2TORCvd
         piR+Xj7jxuJz9T2yG/+bgMA74j11th+pwpc/X7Biiduw+HK9hqZsYAVrMfQl6xzh1xkv
         kfeUehN6KNSTG/ef8Ia+GQzfZ47axFK1Alfbb+IvzHlikbVujTOFWMVYnrDgzMnfO47k
         17VauL27vMldDTQk9YUFIGkbwpeEvKByF9wXiXm4FkpX6BMTbVBoyzuONCnlGlBHLXIE
         0vf1hJPt5d/HUlcnI7H2SKTQY8PZjlVtbOyPlrGiC+YhWKg6P9JUc2KdoPoGnrrlkuNZ
         ntLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833318; x=1684425318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pY9pHq2dLU+St3NtjkMXoaWK13Cg/WiXep4UpYBIrPw=;
        b=EKQ3qFk8z2lAwWJAL2f09jjEbJT/u8BqHQfl+gQ7GzBNs3Wm8e2o5Bgx3qR5zp/orU
         1i2AMnZNuZrluqpfsWkTWpnXZMJGzlfHplMrADZKws7ChJFiwRqg80BVjVhPiUSyHtAw
         y1hImUEBkfGLT9vGlFep0LdSR6BrdmEafbEKIfosiQDYGTaeHs/iZI1JQi2949Cu+A8O
         cJCAenC2vK22J8Y5N7DMP9YoeynLj88LJlyn9c2olGdYqvdyu9bsOAbmfygeOyNy4ZwS
         EtQjtToa8EC6bsD3kT4D0t3/i7tSN1SKtii8kooFRjS/j7wMQIj9Ws85+6lEToDZhz0Y
         Dy7g==
X-Gm-Message-State: AAQBX9dcRmLdlC3DaxnYdt7ulgcjClp7LU1FTyt8bmDRLF5BdOzUCB1s
        UGwbHR/50aQd1FaAtySxQAJL/nnTzqhnMI2ya6EzWg==
X-Google-Smtp-Source: AKy350bJQ5DYzvXJKpTEBvO2yIbqvTi0KxkrimYpzhxKffSt3yNKaKZCVEYlf4iOu3eMnvQ1FTZRWAuTH58moz688qI=
X-Received: by 2002:a05:600c:470b:b0:3f0:aeef:e2da with SMTP id
 v11-20020a05600c470b00b003f0aeefe2damr174184wmo.3.1681833318274; Tue, 18 Apr
 2023 08:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <ZD68RYCVT8hqPuxr@kernel.org>
In-Reply-To: <ZD68RYCVT8hqPuxr@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 Apr 2023 08:55:04 -0700
Message-ID: <CAP-5=fXr6Nc9qkaN+yHJRDNsg6nMxJiV9p7o9OR5cByeey-w0w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix use before NULL check introduced by
 map__dso() introduction
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
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

On Tue, Apr 18, 2023 at 8:50=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> James Clark noticed that the recent 63df0e4bc368adbd ("perf map: Add
> accessor for dso") patch accessed map->dso before the 'map' variable was
> NULL checked, which is a change in logic that leads to segmentation
> faults, so comb thru that patch to fix similar cases.
>
> Fixes: 63df0e4bc368adbd ("perf map: Add accessor for dso")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will@kernel.org>
> To: James Clark <james.clark@arm.com>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sorry for the breakage!
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c    | 7 +++----
>  tools/perf/ui/browsers/hists.c | 4 ++--
>  tools/perf/util/sort.c         | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 8fba247b798ca307..006f522d0e7f6a18 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1075,8 +1075,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
>                 return 0;
>         }
>
> -       dso =3D map__dso(al.map);
> -       if (!thread__find_map(thread, *cpumode, start, &al) || !dso) {
> +       if (!thread__find_map(thread, *cpumode, start, &al) || (dso =3D m=
ap__dso(al.map)) =3D=3D NULL) {
>                 pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", st=
art, end);
>                 return 0;
>         }
> @@ -1106,9 +1105,9 @@ static int map__fprintf_srccode(struct map *map, u6=
4 addr, FILE *fp, struct srcc
>         unsigned line;
>         int len;
>         char *srccode;
> -       struct dso *dso =3D map__dso(map);
> +       struct dso *dso;
>
> -       if (!map || !dso)
> +       if (!map || (dso =3D map__dso(map)) =3D=3D NULL)
>                 return 0;
>         srcfile =3D get_srcline_split(dso,
>                                     map__rip_2objdump(map, addr),
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index ab70e5f5fad236e5..69c81759a64f938f 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2499,9 +2499,9 @@ add_annotate_opt(struct hist_browser *browser __may=
be_unused,
>                  struct map_symbol *ms,
>                  u64 addr)
>  {
> -       struct dso *dso =3D map__dso(ms->map);
> +       struct dso *dso;
>
> -       if (!ms->map || !dso || dso->annotate_warned)
> +       if (!ms->map || (dso =3D map__dso(ms->map)) =3D=3D NULL || dso->a=
nnotate_warned)
>                 return 0;
>
>         if (!ms->sym)
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f2ffaf90648e469e..31b1cd0935e277ba 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1568,7 +1568,7 @@ static int hist_entry__dcacheline_snprintf(struct h=
ist_entry *he, char *bf,
>
>         if (he->mem_info) {
>                 struct map *map =3D he->mem_info->daddr.ms.map;
> -               struct dso *dso =3D map__dso(map);
> +               struct dso *dso =3D map ? map__dso(map) : NULL;
>
>                 addr =3D cl_address(he->mem_info->daddr.al_addr, chk_doub=
le_cl);
>                 ms =3D &he->mem_info->daddr.ms;
> --
> 2.39.2
>
