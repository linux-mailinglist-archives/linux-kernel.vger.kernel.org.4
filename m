Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7425872EC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbjFMT7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbjFMT7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:59:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878701732
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:59:35 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9b7de94e7so61481cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686686374; x=1689278374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWV4DFWiyG4Y2gp1F3lQmlOfZ0g9f1+o7b1sfIWxN8o=;
        b=xF8nsIGqZpmzkzXfWBRX8HaN6qBTGNTuBKxXTlHdPNnO17gUJHJcEzMv1wVOeGHHPe
         96jjt0n7+ECnGXTZVCzEB1oHri5EOqcxpXrcci5+uXeFVjLRPGtOfe6wVotAYNPXoIpf
         XbVOVGB7XHwJyYKGSa1bExzC3ExfF3O5p0JFnL7pspZHWIVyLMO/K4mD0wFWeDauhyqB
         iMuslgIxC+tgAy4KZNKi8BdAeZISwebp6VvyQETVg6XHBQAWhbxgaUONABvgcdVLErtT
         UZ+wpy57kuFy+L3SEbujxMUWcnCcmhMgH6Sxs80M5YnwPxTgeCVWc/GyHm/IAx4K5YCI
         0LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686686374; x=1689278374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWV4DFWiyG4Y2gp1F3lQmlOfZ0g9f1+o7b1sfIWxN8o=;
        b=PICAreHS73qM9IHrKZL5o0zc1TiHcOPfKB8rhRRB1vVXNk/BUuu+tNIlyzjEFz3OKJ
         4wuCqQj0QSwNEC30WIHnpZl5AxME5Xsa+1rirnA/5dTzV7DNoEiHscpLY6yOzASF8k1l
         Qz86yUZTqFRLZDEhMk+lWQ5XVZy6btiG0x7yJFo3THaID1dfHc4iG+WNEP/yNwU81u7F
         SpuQ37dd/MhT7zzayaLKSLTGcSz3RGpcqlqj3pqMLpN53sviz+TL/ii0XVli74AJnMZw
         5LasH7kvFJYjfmZ8h9ZirEiKsNEQiODXgZsaizd96Xmmz6okJF5s7O9nQLZYauxMnilV
         dgBA==
X-Gm-Message-State: AC+VfDyQtfPUYjqGZExiYWzc9y0lybkdQ7KKATE3Z7gMMsYG4WwWsMIk
        0OawhwatUg8uWahhC/gf5UyeA8qkNfU7bi/Z+hScqQ==
X-Google-Smtp-Source: ACHHUZ74BGFtSbd/xN8foJZ5lpV2qvcGtNn2WorQx/FePZ23Ktnlyjq3EhaWijZOdmQx2K8MJnWqF1Emp0Xy2XeryTQ=
X-Received: by 2002:a05:622a:43:b0:3ed:210b:e698 with SMTP id
 y3-20020a05622a004300b003ed210be698mr39221qtw.7.1686686374446; Tue, 13 Jun
 2023 12:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com> <20230607162700.3234712-6-kan.liang@linux.intel.com>
In-Reply-To: <20230607162700.3234712-6-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 12:59:23 -0700
Message-ID: <CAP-5=fU_5fkJZ49B2yxkS4usuKw9fXZ=o-oJo3n5-j5YTAWNvA@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf stat,jevents: Introduce Default tags for the
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 9:27=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
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
> ---
>  tools/perf/builtin-stat.c          | 4 ++--
>  tools/perf/pmu-events/jevents.py   | 5 +++--
>  tools/perf/pmu-events/pmu-events.h | 1 +
>  tools/perf/util/metricgroup.c      | 3 +++
>  4 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c87c6897edc9..2269b3e90e9b 100644
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
> index 74f2d8efc02d..efafa02db5e5 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -137,6 +137,8 @@ struct metric {
>          * output.
>          */
>         const char *metric_unit;
> +       /** Optional default metric group name */
> +       const char *default_metricgroup_name;

Adding a bit more to the comment would be useful, like:

Optional name of the metric group reported if the Default metric group
is being processed.

>         /** Optional null terminated array of referenced metrics. */
>         struct metric_ref *metric_refs;
>         /**
> @@ -219,6 +221,7 @@ static struct metric *metric__new(const struct pmu_me=
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
