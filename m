Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738F728BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjFHXi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjFHXi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:38:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D5A3583
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:38:19 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33ed16b1360so50985ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686267498; x=1688859498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp/9POZM+KSk/Puo0CGh5BoXNxCg9MCE79dJ8CyzMbY=;
        b=x89+2IXEYnuJJWvQFBoh7DUc7GNmBRPm9m51Vqtza/mu4rdXKmTdXTOln4O2qtITKD
         7ufD7QV4ZR4ArOl5vs0OVL7emQeXdJudgYA4ZHQyB4lt05jqRZfxhO1MidSpGzkKsGKa
         TFlYmwn6wnWXpq/GgLqM7Z1FI6/XdGIiccd9BsMxsPY1VLInXwj+8/NpGXiYmAJdCiK1
         3OluSFEvkfycgMZMRQy6wQoG3cKI65YXh4iaG9mJqro6ji0mI1lUPSTnll13FgtD/FAo
         T6AxJ8TdX/SqLRz9O4U8JYa1RoI/XD14Ekwh+EFhOHcAbGHrhfM3tarZuf37BLAUguJc
         jjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686267498; x=1688859498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp/9POZM+KSk/Puo0CGh5BoXNxCg9MCE79dJ8CyzMbY=;
        b=QGO4/NWdErLZD5VgpSZU+4mDnHjRU1tmISxVkflPNCdN7I8ymhDQpUHvD4sC7A54QG
         ZHV0R3YIzLEuYX2BhnZC2af/KP3Ou9lDe3VwRJVTnfXZtMqJV1Za8Li7eqRzcYoWtitK
         2aZ9y5O2X41fzo54QoYkfn7Xaldu28nglGhQKAkMJbvXlR1Xz9SaSEAjpgNpHTUByehq
         ZJBDztP0pC/D1ClCOws5emMZ9uEpOzInyBBM1Mh+TgC1h/PBpxh43k4szhCDYKK8RszK
         uPi3PK+17/rlBoiDWPGghge//MW3pqBrvmFkRoCcGN5ImMn7sRe4jjLY4ETG9lMbQP8d
         pkPQ==
X-Gm-Message-State: AC+VfDyHp0cHv7yYAQfvIzShX99Bn3QJsE+5NmBX8dKmhVgQ6Iv9Fs4j
        9xGRf0nk+BkDAVs2DQChmPkO5RmoNRM8RCa3aGwVDw==
X-Google-Smtp-Source: ACHHUZ6qQ/McoXLXbStSsmkU55JfqWAXYeqrjmAtBC3ocJ41T89r47nouNbqQc0tweH1DBPXNdWyLgYiuooFRXGPcNI=
X-Received: by 2002:a92:c24a:0:b0:338:9f6a:d547 with SMTP id
 k10-20020a92c24a000000b003389f6ad547mr386966ilo.21.1686267498281; Thu, 08 Jun
 2023 16:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230608232400.3056312-1-namhyung@kernel.org> <20230608232400.3056312-2-namhyung@kernel.org>
In-Reply-To: <20230608232400.3056312-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 8 Jun 2023 16:38:06 -0700
Message-ID: <CAP-5=fVmhdnRipBFZz++OzYB_8tMSQjPXQ1L9pJ1WZHTdErsBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf list: Check if libpfm4 event is supported
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Thu, Jun 8, 2023 at 4:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Some of its event info cannot be used directly due to missing default
> attributes.  Let's check if the event is supported before printing
> like we do for hw and cache events.
>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers>@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/pfm.c | 58 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 50 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> index 076aecc22c16..4c1024c343dd 100644
> --- a/tools/perf/util/pfm.c
> +++ b/tools/perf/util/pfm.c
> @@ -13,6 +13,8 @@
>  #include "util/pmus.h"
>  #include "util/pfm.h"
>  #include "util/strbuf.h"
> +#include "util/cpumap.h"
> +#include "util/thread_map.h"
>
>  #include <string.h>
>  #include <linux/kernel.h>
> @@ -123,6 +125,36 @@ int parse_libpfm_events_option(const struct option *=
opt, const char *str,
>         return -1;
>  }
>
> +static bool is_libpfm_event_supported(const char *name, struct perf_cpu_=
map *cpus,
> +                                     struct perf_thread_map *threads)
> +{
> +       struct perf_pmu *pmu;
> +       struct evsel *evsel;
> +       struct perf_event_attr attr =3D {};
> +       bool result =3D true;
> +       int ret;
> +
> +       ret =3D pfm_get_perf_event_encoding(name, PFM_PLM0|PFM_PLM3,
> +                                         &attr, NULL, NULL);
> +       if (ret !=3D PFM_SUCCESS)
> +               return false;
> +
> +       pmu =3D perf_pmus__find_by_type((unsigned int)attr.type);
> +       evsel =3D parse_events__add_event(0, &attr, name, /*metric_id=3D*=
/NULL, pmu);
> +       if (evsel =3D=3D NULL)
> +               return false;
> +
> +       evsel->is_libpfm_event =3D true;
> +
> +       if (evsel__open(evsel, cpus, threads) < 0)
> +               result =3D false;
> +
> +       evsel__close(evsel);
> +       evsel__delete(evsel);
> +
> +       return result;
> +}
> +
>  static const char *srcs[PFM_ATTR_CTRL_MAX] =3D {
>         [PFM_ATTR_CTRL_UNKNOWN] =3D "???",
>         [PFM_ATTR_CTRL_PMU] =3D "PMU",
> @@ -146,6 +178,8 @@ print_libpfm_event(const struct print_callbacks *prin=
t_cb, void *print_state,
>  {
>         int j, ret;
>         char topic[80], name[80];
> +       struct perf_cpu_map *cpus =3D perf_cpu_map__empty_new(1);
> +       struct perf_thread_map *threads =3D thread_map__new_by_tid(0);
>
>         strbuf_setlen(buf, 0);
>         snprintf(topic, sizeof(topic), "pfm %s", pinfo->name);
> @@ -185,14 +219,15 @@ print_libpfm_event(const struct print_callbacks *pr=
int_cb, void *print_state,
>                                     ainfo.name, ainfo.desc);
>                 }
>         }
> -       print_cb->print_event(print_state,
> -                       pinfo->name,
> -                       topic,
> -                       name, info->equiv,
> -                       /*scale_unit=3D*/NULL,
> -                       /*deprecated=3D*/NULL, "PFM event",
> -                       info->desc, /*long_desc=3D*/NULL,
> -                       /*encoding_desc=3D*/buf->buf);
> +
> +       if (is_libpfm_event_supported(name, cpus, threads)) {
> +               print_cb->print_event(print_state, pinfo->name, topic,
> +                                     name, info->equiv,
> +                                     /*scale_unit=3D*/NULL,
> +                                     /*deprecated=3D*/NULL, "PFM event",
> +                                     info->desc, /*long_desc=3D*/NULL,
> +                                     /*encoding_desc=3D*/buf->buf);
> +       }
>
>         pfm_for_each_event_attr(j, info) {
>                 pfm_event_attr_info_t ainfo;
> @@ -215,6 +250,10 @@ print_libpfm_event(const struct print_callbacks *pri=
nt_cb, void *print_state,
>                         print_attr_flags(buf, &ainfo);
>                         snprintf(name, sizeof(name), "%s::%s:%s",
>                                  pinfo->name, info->name, ainfo.name);
> +
> +                       if (!is_libpfm_event_supported(name, cpus, thread=
s))
> +                               continue;
> +
>                         print_cb->print_event(print_state,
>                                         pinfo->name,
>                                         topic,
> @@ -225,6 +264,9 @@ print_libpfm_event(const struct print_callbacks *prin=
t_cb, void *print_state,
>                                         /*encoding_desc=3D*/buf->buf);
>                 }
>         }
> +
> +       perf_cpu_map__put(cpus);
> +       perf_thread_map__put(threads);
>  }
>
>  void print_libpfm_events(const struct print_callbacks *print_cb, void *p=
rint_state)
> --
> 2.41.0.162.gfafddb0af9-goog
>
