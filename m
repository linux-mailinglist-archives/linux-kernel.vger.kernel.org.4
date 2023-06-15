Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A20730ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjFOFvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbjFOFvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:51:19 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B82961
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:51:04 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f98276f89cso106621cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686808264; x=1689400264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsujUUkIkGPb1RjMWNMneyCY+OpEp4SMkg0gPmgmeUE=;
        b=mlAZdFUeclS9DSi1vYvLCC4ojnFxhm3xDeWmMBT9aqGrkJxw2o60JYFKNn50vwrFO6
         E8F4Co3vexcVliW9eh/PVrGDfKBH7/MnXD8xAdQd1LVJD3ylzKUZw7EZkAh/dZtslWsI
         Rr7+MnhO6N20zguLB0CPKX0UcBEZ9PCM3KIWQQUK/6XMRkWFWTdPOPf3vKPIbOaLrF5V
         3kFbwxPrdEXlmSZ8BRZfBol1J9ggJYBHUZsFYVu/ZjkeCno/OT5PAPvZ+6fNCERJqA9E
         5N7GlefGzoEiF3Grks8X9qJf2UhP23xLMQhz1RbodiQSJmCQ1G5++70tWjU9NFzo/zOx
         7TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808264; x=1689400264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsujUUkIkGPb1RjMWNMneyCY+OpEp4SMkg0gPmgmeUE=;
        b=BWVKzMzhXl4Xm5JtFk1PzxZ5Q+eeHOyUXZ1TI10KdztIilchiOogYQ3/MTn3q42Rur
         jv6GTJVlXkGK89ZFPpHUo841aFva3p1vlT6fYxKVptwKk4dotLOcAvhctXBfjqPKiZGB
         4cB4u+towN7XW1bSdSlLVfpY2/qd1WEYeim3rgsoeJDb5/YIGXZlnVnPE02O38lKvEHL
         tydXvYO0vPBUjUv3HvdoT5GK+kjXRag1XRe4MDCIuMqYKCfezKy6gD+7SAJwihN/p7AY
         7pL74ICPP8YjD6HfGUefpWBRYN+j/6IQLbCyMGaP5CYelCxIufr+cAzGm8EeavOnQu98
         mkwA==
X-Gm-Message-State: AC+VfDyPfjAysjpkKmMY9uSfMPhmszlPj+EuEbaahmvoVFX2fx+FXaHw
        IctZj0hS8/BuAQQiqZ4zjGq8dgcVFXDc7/0wZTPexw==
X-Google-Smtp-Source: ACHHUZ5Uu0FVxoIBwPYCt4nTv+IsX/esPM7txZQn4rZdA2/67Zxorp+WhMMGXyQ/gkUpfRN8lM5zIAUgfG1qv5a6Hk0=
X-Received: by 2002:ac8:5b08:0:b0:3e3:8c75:461 with SMTP id
 m8-20020ac85b08000000b003e38c750461mr82908qtw.6.1686808263729; Wed, 14 Jun
 2023 22:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230615001735.3643996-1-kan.liang@linux.intel.com> <20230615001735.3643996-4-kan.liang@linux.intel.com>
In-Reply-To: <20230615001735.3643996-4-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 22:50:52 -0700
Message-ID: <CAP-5=fUDg4aN-oQ6TkxFiTEwZJur_YS9cH05U4yUP8FzQaF28A@mail.gmail.com>
Subject: Re: [PATCH V2 3/8] perf stat,jevents: Introduce Default tags for the
 default mode
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
> Introduce a new metricgroup, Default, to tag all the metric groups which
> will be collected in the default mode.
>
> Add a new field, DefaultMetricgroupName, in the JSON file to indicate
> the real metric group name. It will be printed in the default output
> to replace the event names.
>
> There is nothing changed for the output format.
>
> On SPR, both TopdownL1 and TopdownL2 are displayed in the default
> output.
>
> On ARM, Intel ICL and later platforms (before SPR), only TopdownL1 is
> displayed in the default output.
>
> Suggested-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c          | 4 ++--
>  tools/perf/pmu-events/jevents.py   | 5 +++--
>  tools/perf/pmu-events/pmu-events.h | 1 +
>  tools/perf/util/metricgroup.c      | 6 ++++++
>  4 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index fc615bdeed4f..55601b4b5c34 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2154,14 +2154,14 @@ static int add_default_attributes(void)
>                  * Add TopdownL1 metrics if they exist. To minimize
>                  * multiplexing, don't request threshold computation.
>                  */
> -               if (metricgroup__has_metric(pmu, "TopdownL1")) {
> +               if (metricgroup__has_metric(pmu, "Default")) {
>                         struct evlist *metric_evlist =3D evlist__new();
>                         struct evsel *metric_evsel;
>
>                         if (!metric_evlist)
>                                 return -1;
>
> -                       if (metricgroup__parse_groups(metric_evlist, pmu,=
 "TopdownL1",
> +                       if (metricgroup__parse_groups(metric_evlist, pmu,=
 "Default",
>                                                         /*metric_no_group=
=3D*/false,
>                                                         /*metric_no_merge=
=3D*/false,
>                                                         /*metric_no_thres=
hold=3D*/true,
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 7ed258be1829..12e80bb7939b 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -54,8 +54,8 @@ _json_event_attributes =3D [
>  # Attributes that are in pmu_metric rather than pmu_event.
>  _json_metric_attributes =3D [
>      'pmu', 'metric_name', 'metric_group', 'metric_expr', 'metric_thresho=
ld',
> -    'desc', 'long_desc', 'unit', 'compat', 'metricgroup_no_group', 'aggr=
_mode',
> -    'event_grouping'
> +    'desc', 'long_desc', 'unit', 'compat', 'metricgroup_no_group',
> +    'default_metricgroup_name', 'aggr_mode', 'event_grouping'
>  ]
>  # Attributes that are bools or enum int values, encoded as '0', '1',...
>  _json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', =
'perpkg']
> @@ -307,6 +307,7 @@ class JsonEvent:
>      self.metric_name =3D jd.get('MetricName')
>      self.metric_group =3D jd.get('MetricGroup')
>      self.metricgroup_no_group =3D jd.get('MetricgroupNoGroup')
> +    self.default_metricgroup_name =3D jd.get('DefaultMetricgroupName')
>      self.event_grouping =3D convert_metric_constraint(jd.get('MetricCons=
traint'))
>      self.metric_expr =3D None
>      if 'MetricExpr' in jd:
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/p=
mu-events.h
> index 8cd23d656a5d..caf59f23cd64 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -61,6 +61,7 @@ struct pmu_metric {
>         const char *desc;
>         const char *long_desc;
>         const char *metricgroup_no_group;
> +       const char *default_metricgroup_name;
>         enum aggr_mode_class aggr_mode;
>         enum metric_event_groups event_grouping;
>  };
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 74f2d8efc02d..8b19644ade7d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -137,6 +137,11 @@ struct metric {
>          * output.
>          */
>         const char *metric_unit;
> +       /**
> +        * Optional name of the metric group reported
> +        * if the Default metric group is being processed.
> +        */
> +       const char *default_metricgroup_name;
>         /** Optional null terminated array of referenced metrics. */
>         struct metric_ref *metric_refs;
>         /**
> @@ -219,6 +224,7 @@ static struct metric *metric__new(const struct pmu_me=
tric *pm,
>
>         m->pmu =3D pm->pmu ?: "cpu";
>         m->metric_name =3D pm->metric_name;
> +       m->default_metricgroup_name =3D pm->default_metricgroup_name;
>         m->modifier =3D NULL;
>         if (modifier) {
>                 m->modifier =3D strdup(modifier);
> --
> 2.35.1
>
