Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827CC7326C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjFPFsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFPFsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:48:36 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE26270C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:48:35 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3409d944009so67005ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686894515; x=1689486515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwQw4AmMsj8rS1EO+I7cEg+kMMUbG54Oey3YjSE5diw=;
        b=ew+f7NHQuAVwZ6l9cHvNdo8Rj7TGVkbcYkaVPzglzvEspiDGM9BIAbB+nOI5BFRHxq
         O3Rz+l8/avezmgajTEW6WlveMWCuo7Sr9PZARD5tSs5Hw1qgqUVZKHszLzfE3fl+JdvV
         8QrTUXpxABeNTDNnTpc8AiCLiEvexxY9J/480urLRwCoo9bCCMk3iqQ67OQpYXw5ZQWi
         g3RZ0eMDgMRMBaW5kOLu48MYKLnxD6Rr3YdTUu0oW7FlKFXy0i9oycnn1XuIU/oSPZPk
         kgKliKYW/phvNL/OBA2viXxT+OIREPXeEWyGZQUNlIUtqlBoy3G7pjpHEj9EuOYGyS9d
         YnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686894515; x=1689486515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwQw4AmMsj8rS1EO+I7cEg+kMMUbG54Oey3YjSE5diw=;
        b=kb++3gOgmVfKhqPSrw4N2C/Sy/PQCQEbDwPL5KBwcjhkeI3gr1tDclYhlNaYvufnMu
         fNFOeMLa/NNSBFwin+QX8NU9mhrzW1UVpxGWYMOjAPaG5Qk9/lyTQr0jWL6tMt6idtJK
         tjiLeeMLiQPyQ82IxvWiEAFUbIVBLmOK+Z2c0hOE/yKu1T34y6fALizPCzylbHDeCHvP
         ey1EcYX6zZKRwNT48wuDv2nyxCWvwtMuCVQ7bZCMHOYfc9aL2L6AnSI3M2My4h2qanGn
         BB5DVa2bVBKdAvqU+VUcgG36rWIvqS3kntepiGyeCdWiHYPuPfdcP1aCTULhm93uLS2R
         4xQg==
X-Gm-Message-State: AC+VfDzUlyLo+QEzywWho6b8CCoRHe6ra6u0JN5yWiiGa2c0BWBQbXXM
        qYqguNoEmGos2M0RK0bEAPyEWCTzIDliNw6xHJdLfA==
X-Google-Smtp-Source: ACHHUZ6+k9cqSN5v8etHs7GGPZ2xmMi9V0LTDQLaEsf/rzIWphENGiObZ4KJ0dLJo4Uo9R+yc3voVrQTjm4rGfUwm+c=
X-Received: by 2002:a05:6e02:12e2:b0:33b:5343:c1be with SMTP id
 l2-20020a056e0212e200b0033b5343c1bemr409461iln.29.1686894514956; Thu, 15 Jun
 2023 22:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230616031420.3751973-1-kan.liang@linux.intel.com> <20230616031420.3751973-2-kan.liang@linux.intel.com>
In-Reply-To: <20230616031420.3751973-2-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 15 Jun 2023 22:48:23 -0700
Message-ID: <CAP-5=fVDouD85kvKeq252Zv1dL9r5QgpZBsh7uX5fOP7OR_x0A@mail.gmail.com>
Subject: Re: [PATCH V4 1/5] perf metrics: Sort the Default metricgroup
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

On Thu, Jun 15, 2023 at 8:14=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The new default mode will print the metrics as a metric group. The
> metrics from the same metric group must be adjacent to each other in the
> metric list. But the metric_list_cmp() sorts metrics by the number of
> events.
>
> Add a new sort for the Default metricgroup, which sorts by
> default_metricgroup_name and metric_name.
>
> Add is_default in the struct metric_event to indicate that it's from
> the Default metricgroup.
>
> Store the displayed metricgroup name of the Default metricgroup into
> the metric expr for output.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 26 ++++++++++++++++++++++++++
>  tools/perf/util/metricgroup.h |  3 +++
>  2 files changed, 29 insertions(+)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 8b19644ade7d..a6a5ed44a679 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -79,6 +79,7 @@ static struct rb_node *metric_event_new(struct rblist *=
rblist __maybe_unused,
>                 return NULL;
>         memcpy(me, entry, sizeof(struct metric_event));
>         me->evsel =3D ((struct metric_event *)entry)->evsel;
> +       me->is_default =3D false;
>         INIT_LIST_HEAD(&me->head);
>         return &me->nd;
>  }
> @@ -1160,6 +1161,25 @@ static int metric_list_cmp(void *priv __maybe_unus=
ed, const struct list_head *l,
>         return right_count - left_count;
>  }
>
> +/**
> + * default_metricgroup_cmp - Implements complex key for the Default metr=
icgroup

nit: what is the meaning of complex key here?

> + *                          that first sorts by default_metricgroup_name=
, then
> + *                          metric_name.
> + */
> +static int default_metricgroup_cmp(void *priv __maybe_unused,
> +                                  const struct list_head *l,
> +                                  const struct list_head *r)
> +{
> +       const struct metric *left =3D container_of(l, struct metric, nd);
> +       const struct metric *right =3D container_of(r, struct metric, nd)=
;
> +       int diff =3D strcmp(right->default_metricgroup_name, left->defaul=
t_metricgroup_name);
> +
> +       if (diff)
> +               return diff;
> +
> +       return strcmp(right->metric_name, left->metric_name);
> +}
> +
>  struct metricgroup__add_metric_data {
>         struct list_head *list;
>         const char *pmu;
> @@ -1515,6 +1535,7 @@ static int parse_groups(struct evlist *perf_evlist,
>         LIST_HEAD(metric_list);
>         struct metric *m;
>         bool tool_events[PERF_TOOL_MAX] =3D {false};
> +       bool is_default =3D !strcmp(str, "Default");
>         int ret;
>
>         if (metric_events_list->nr_entries =3D=3D 0)
> @@ -1549,6 +1570,9 @@ static int parse_groups(struct evlist *perf_evlist,
>                         goto out;
>         }
>
> +       if (is_default)
> +               list_sort(NULL, &metric_list, default_metricgroup_cmp);
> +
>         list_for_each_entry(m, &metric_list, nd) {
>                 struct metric_event *me;
>                 struct evsel **metric_events;
> @@ -1637,6 +1661,8 @@ static int parse_groups(struct evlist *perf_evlist,
>                 expr->metric_unit =3D m->metric_unit;
>                 expr->metric_events =3D metric_events;
>                 expr->runtime =3D m->pctx->sctx.runtime;
> +               expr->default_metricgroup_name =3D m->default_metricgroup=
_name;
> +               me->is_default =3D is_default;
>                 list_add(&expr->nd, &me->head);
>         }
>
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index bf18274c15df..d5325c6ec8e1 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -22,6 +22,7 @@ struct cgroup;
>  struct metric_event {
>         struct rb_node nd;
>         struct evsel *evsel;
> +       bool is_default; /* the metric evsel from the Default metricgroup=
 */
>         struct list_head head; /* list of metric_expr */
>  };
>
> @@ -55,6 +56,8 @@ struct metric_expr {
>          * more human intelligible) and then add "MiB" afterward when dis=
played.
>          */
>         const char *metric_unit;
> +       /** Displayed metricgroup name of the Default metricgroup */
> +       const char *default_metricgroup_name;
>         /** Null terminated array of events used by the metric. */
>         struct evsel **metric_events;
>         /** Null terminated array of referenced metrics. */
> --
> 2.35.1
>
