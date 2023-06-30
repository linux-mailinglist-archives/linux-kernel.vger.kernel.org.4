Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAB74431C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjF3URI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjF3URG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:17:06 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F32D52
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:17:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401d1d967beso69681cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688156224; x=1690748224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhewT4f0UOSioUznQR6E30vq7XPstuamVEJFO+KirRA=;
        b=nOeY49aXkTzXdNCKWDJ1WxBzQ3TJch54HvwT4fmA3hhzd05Roz5SufF48M/uwZE88L
         z9ZZTVoctCVlSKFUQHrnUEjN+G4UpT++Z9OEQXjpOswTqzPVGWLhMqiIX9/7m6KHswdl
         5fKI0Fy6zDKoR2rjAFPJUpw2lYhT1djlTsDppQjNw47jt+LV65VA+tQ7VFNwJ+7raKEg
         JmbvNS+5omqUGMhZ0BsqGLW+gMM+PS1UJov1WXdcyHWgQZZOzTtXPSgQkGyOpAdh7VR7
         j8g/4XYJWFpxMo+7aTF4KzQuhD7OuVMxyPZ/TY2CEZSns08kEKY5oR7E5rBVRXT3wD2y
         tX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688156224; x=1690748224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhewT4f0UOSioUznQR6E30vq7XPstuamVEJFO+KirRA=;
        b=QpF3vxi7MIneI/T2c4NL+ImTvMsyT4dAnLh+wvnjKxCix44cs4W9R1tWrbdgzdsiSt
         AVyhJG0CpOjgCDhpV+kOO+VrvX/FQNhTwPSlwtvz4echB+rJZl0NJ6qBw+CVWU1xm7Zb
         jowmWkkPKJ9woDPLhK7fowZmD/0ecRSiM2jO3X2vxlPHpnh4UbzOmQB/Ir9sWod8pj9s
         H+gokOgQGw09TqvqdCFqc++B8GtgXlSm9Y8h/a1HaOJ6df8wcWqjCr0zsUnqSrdUaz4P
         0HLMzlTmIVj7/1GaE2XcgA8J0eNz8VXZ/yyUc6TXtrB0zqBGLIEFRlEfUsa5QcgBciFu
         VLwg==
X-Gm-Message-State: ABy/qLb7b4pd6cUaENhd3eCQ0M5B2N+USi3HuV56ECTyu1zHQYEVdtq4
        ibsI6MweXOECILvgZB2MPNMF56Dl4olenlZ1m/sMGg==
X-Google-Smtp-Source: APBJJlHhdB8Pmy4C63TnFuiw+Fg8ml6gqXXkudlDW7XmkU66eyXD69lowEw/CN+3QPpU3s07T2Pt4hlaz3SxyI0jTRc=
X-Received: by 2002:ac8:7f82:0:b0:3ed:210b:e698 with SMTP id
 z2-20020ac87f82000000b003ed210be698mr33968qtj.7.1688156224033; Fri, 30 Jun
 2023 13:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com> <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
In-Reply-To: <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 13:16:52 -0700
Message-ID: <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
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

On Fri, Jun 30, 2023 at 12:00=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Jun 28, 2023 at 3:30=E2=80=AFAM John Garry <john.g.garry@oracle.c=
om> wrote:
> >
> > Add a function to get the events table associated with a metric table f=
or
> > struct pmu_sys_events.
> >
> > We could also use something like:
> > struct pmu_sys_events *sys =3D container_of(metrics, struct pmu_sys_eve=
nts,
> >                                                 metric_table);
> >
> > to lookup struct pmu_sys_events, but that relies on the user always pas=
sing
> > a sys events metric struct pointer, so this way is safer, but slower.
>
> If an event is specific to a particular PMU, shouldn't the metric name
> the PMU with the event? For example:
>
> MetricName: "IPC",
> MetricExpr: "instructions / cycles",
>
> Here instructions and cycles can wildcard match on BIG.little/hybrid
> systems and so we get an IPC metric for each PMU - although, I suspect
> this isn't currently quite working. We can also, and currently, do:
>
> MetricName: "IPC",
> MetricExpr: "cpu_atom@instructions@ / cpu_atom@cycles@",
> ...
> MetricName: "IPC",
> MetricExpr: "cpu_core@instructions@ / cpu_core@cycles@",
>
> The @ is used to avoid parsing confusion with / meaning divide. The
> PMUs for the events are explicitly listed here. We could say the PMU
> is implied but then it gets complex for uncore events, for metrics
> that mix core and uncore events.

So looking at the later patches, they are making it so the PMU doesn't
need to be specified, so I think it is the same issue as here. My
thought was that the PMU would always be required for metrics like
memory bandwidth per million instructions, ie >1 PMU. I know this
makes the metrics longer, I've tried to avoid writing json metrics and
have used Python to write them in my own work:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/metric.py?h=3Dperf-tools-next#n411

Thanks,
Ian

> Thanks,
> Ian
>
>
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  tools/perf/pmu-events/empty-pmu-events.c |  6 ++++++
> >  tools/perf/pmu-events/jevents.py         | 11 +++++++++++
> >  tools/perf/pmu-events/pmu-events.h       |  3 +++
> >  3 files changed, 20 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-=
events/empty-pmu-events.c
> > index a630c617e879..ae431b6bdf91 100644
> > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > @@ -290,6 +290,12 @@ int pmu_metrics_table_for_each_metric(const struct=
 pmu_metrics_table *table, pmu
> >         return 0;
> >  }
> >
> > +const struct pmu_events_table *
> > +sys_events_find_events_table(__maybe_unused const struct pmu_metrics_t=
able *metrics)
> > +{
> > +       return NULL;
> > +}
> > +
> >  const struct pmu_events_table *perf_pmu__find_events_table(struct perf=
_pmu *pmu)
> >  {
> >         const struct pmu_events_table *table =3D NULL;
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index 80b569b8634b..947e8b1efa26 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -786,6 +786,17 @@ int pmu_metrics_table_for_each_metric(const struct=
 pmu_metrics_table *table,
> >          return 0;
> >  }
> >
> > +const struct pmu_events_table *
> > +sys_events_find_events_table(const struct pmu_metrics_table *metrics)
> > +{
> > +       for (const struct pmu_sys_events *tables =3D &pmu_sys_event_tab=
les[0];
> > +             tables->name; tables++) {
> > +               if (&tables->metric_table =3D=3D metrics)
> > +                       return &tables->event_table;
> > +       }
> > +       return NULL;
> > +}
> > +
> >  const struct pmu_events_table *perf_pmu__find_events_table(struct perf=
_pmu *pmu)
> >  {
> >          const struct pmu_events_table *table =3D NULL;
> > diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events=
/pmu-events.h
> > index caf59f23cd64..a3642c08e39d 100644
> > --- a/tools/perf/pmu-events/pmu-events.h
> > +++ b/tools/perf/pmu-events/pmu-events.h
> > @@ -77,6 +77,9 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_me=
tric *pm,
> >                                   const struct pmu_metrics_table *table=
,
> >                                   void *data);
> >
> > +const struct pmu_events_table *
> > +sys_events_find_events_table(const struct pmu_metrics_table *metrics);
> > +
> >  int pmu_events_table_for_each_event(const struct pmu_events_table *tab=
le, pmu_event_iter_fn fn,
> >                                     void *data);
> >  int pmu_metrics_table_for_each_metric(const struct pmu_metrics_table *=
table, pmu_metric_iter_fn fn,
> > --
> > 2.35.3
> >
