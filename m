Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792C9730EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbjFOFwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbjFOFwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:52:37 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F562719
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:52:21 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f98276f89cso107001cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686808341; x=1689400341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvV1s9Ybihpk3I08Qn1WFec9efz9VOUQvHz72+VgOEs=;
        b=7dB/GwIzS6IYN7XoGva93cZMfroWWgR9CNQQLJ28Crgkocf/mOANnSUoUhR8kdnj8c
         x0wgOUoqpwUT+Y15Efe4mmpRNLio/84LxSZSWdRWNihX6sT2xE8dhUJP+ypNrvs5CT4d
         Clw6NwecyRZ38q8LcI9/JmamPX6Js6H41yErMOj83tmvgRdeaYx1vO93HqP0yn07CZRT
         BMP+ypzqMCUYp196eF0L9i0Uhpc1zLfj1PuaF4FZDuLvz4EjKjCoQz3ac7dKJj9Y0KH3
         xVr3VTlMZCi/65ytGLFKuAgQgFLTewhquLdf4Ym8Vbq3e7E+LnhwDWA5xy8RzjUkbdam
         rijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808341; x=1689400341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvV1s9Ybihpk3I08Qn1WFec9efz9VOUQvHz72+VgOEs=;
        b=gSZZLmIK4hWR0Ckb62+c3RhadewOeV+FPB5Dg0meDw7K53AP2xPw6QGLXQuUOqqBua
         eTOg6kIurbITzHm7QVXnTOIaGVjDVR2cBZhuh2m9B4j6Yi3opbFb8dE1c1Eso48cWBQ/
         ZL8HPSQi9kZAud/hAsMjJwmOw9qp0thF84qcc0e9T6U2NG07gasJtwu1UT91zY1nzfCN
         U5B8rzAtSzcTjJphBAwJLZZ+Iw3QFIl3EcXUwLTPMwlUPQtQSg5CDhbvD09IGKcV2TMC
         qPxIoanZwF5+cNtsaPqJxaDUADWlpbGvBkWscrwStn7wD9TFrhijCCn63FZNdSP/0BWX
         rDIA==
X-Gm-Message-State: AC+VfDynJAZKHrO7OpeSITqJGfAe8m0cqxnUFPEd+bKT3b4PhpH+6izM
        dxG52z0ESjCVh+DvP8ioARzG4sMTLOVLUKITBM0CJQ==
X-Google-Smtp-Source: ACHHUZ7qgU3dpu4rIAx7AdmLtPFfR31Y7hYmj0/gpfjYTm1nVXytuQSca5mvnmmqFgME6Rir4dNf27KXa7PsZfwIs+0=
X-Received: by 2002:a05:622a:1ba9:b0:3fa:7dbf:f268 with SMTP id
 bp41-20020a05622a1ba900b003fa7dbff268mr60622qtb.23.1686808340786; Wed, 14 Jun
 2023 22:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230615001735.3643996-1-kan.liang@linux.intel.com>
 <20230615001735.3643996-5-kan.liang@linux.intel.com> <CAP-5=fWbLkyQpxxhfCmqit7p4WgHVUOCjsADm-XojcT5ppcv7g@mail.gmail.com>
In-Reply-To: <CAP-5=fWbLkyQpxxhfCmqit7p4WgHVUOCjsADm-XojcT5ppcv7g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 22:52:09 -0700
Message-ID: <CAP-5=fU=jS6UmKdFziRq1Zt0c8FY+3XSrB9Xufw0BSHkGAcO-A@mail.gmail.com>
Subject: Re: [PATCH V2 4/8] perf metrics: Sort the Default metricgroup
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 9:30=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Jun 14, 2023 at 5:18=E2=80=AFPM <kan.liang@linux.intel.com> wrote=
:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > The new default mode will print the metrics as a metric group. The
> > metrics from the same metric group must be adjacent to each other in th=
e
> > metric list. But the metric_list_cmp() sorts metrics by the number of
> > events.
> >
> > Add a new sort for the Default metricgroup, which sorts by
> > default_metricgroup_name and metric_name.
> >
> > Add is_default in the struct metric_event to indicate that it's from
> > the Default metricgroup.
> >
> > Store the displayed metricgroup name of the Default metricgroup into
> > the metric expr for output.
> >
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >  tools/perf/util/metricgroup.c | 35 +++++++++++++++++++++++++++++++++++
> >  tools/perf/util/metricgroup.h |  3 +++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> > index 8b19644ade7d..acf86b15ee49 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -79,6 +79,7 @@ static struct rb_node *metric_event_new(struct rblist=
 *rblist __maybe_unused,
> >                 return NULL;
> >         memcpy(me, entry, sizeof(struct metric_event));
> >         me->evsel =3D ((struct metric_event *)entry)->evsel;
> > +       me->is_default =3D false;
> >         INIT_LIST_HEAD(&me->head);
> >         return &me->nd;
> >  }
> > @@ -1160,6 +1161,25 @@ static int metric_list_cmp(void *priv __maybe_un=
used, const struct list_head *l,
> >         return right_count - left_count;
> >  }
> >
> > +/**
> > + * default_metricgroup_cmp - Implements complex key for the Default me=
tricgroup
> > + *                          that first sorts by default_metricgroup_na=
me, then
> > + *                          metric_name.
> > + */
> > +static int default_metricgroup_cmp(void *priv __maybe_unused,
> > +                                  const struct list_head *l,
> > +                                  const struct list_head *r)
> > +{
> > +       const struct metric *left =3D container_of(l, struct metric, nd=
);
> > +       const struct metric *right =3D container_of(r, struct metric, n=
d);
> > +       int diff =3D strcmp(right->default_metricgroup_name, left->defa=
ult_metricgroup_name);
> > +
> > +       if (diff)
> > +               return diff;
> > +
> > +       return strcmp(right->metric_name, left->metric_name);
> > +}
> > +
> >  struct metricgroup__add_metric_data {
> >         struct list_head *list;
> >         const char *pmu;
> > @@ -1515,6 +1535,7 @@ static int parse_groups(struct evlist *perf_evlis=
t,
> >         LIST_HEAD(metric_list);
> >         struct metric *m;
> >         bool tool_events[PERF_TOOL_MAX] =3D {false};
> > +       bool is_default =3D !strcmp(str, "Default");
> >         int ret;
> >
> >         if (metric_events_list->nr_entries =3D=3D 0)
> > @@ -1549,6 +1570,9 @@ static int parse_groups(struct evlist *perf_evlis=
t,
> >                         goto out;
> >         }
> >
> > +       if (is_default)
> > +               list_sort(NULL, &metric_list, default_metricgroup_cmp);
> > +
> >         list_for_each_entry(m, &metric_list, nd) {
> >                 struct metric_event *me;
> >                 struct evsel **metric_events;
> > @@ -1637,6 +1661,17 @@ static int parse_groups(struct evlist *perf_evli=
st,
> >                 expr->metric_unit =3D m->metric_unit;
> >                 expr->metric_events =3D metric_events;
> >                 expr->runtime =3D m->pctx->sctx.runtime;
> > +               if (m->pmu && strcmp(m->pmu, "cpu")) {
> > +                       char *name;
> > +
> > +                       if (asprintf(&name, "%s (%s)", m->default_metri=
cgroup_name, m->pmu) < 0)
>
> With EXTRA_CFLAGS=3D"-fsanitize=3Daddress" this is causing:
>
> $ perf test 7 -vv -F
>   7: PMU events                                                      :
> ...
>   7.5: Parsing of metric thresholds with fake PMUs                   :
> ...
> =3D=3D2072355=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 6199 byte(s) in 340 object(s) allocated from:
>    #0 0x7f24cce7077b in __interceptor_strdup
> ../../../../src/libsanitizer/asan/asan_interceptors.cp
> p:439
>    #1 0x55972b328abd in asprintf util/util.c:566
>    #2 0x55972b251dbd in parse_groups util/metricgroup.c:1667
>    #3 0x55972b25231f in metricgroup__parse_groups_test util/metricgroup.c=
:1719
>    #4 0x55972b139aff in test__parsing_callback tests/pmu-events.c:837
>    #5 0x55972b5119a9 in pmu_metrics_table_for_each_metric
> /tmp/perf/pmu-events/pmu-events.c:61641
>    #6 0x55972b511fdf in pmu_for_each_core_metric
> /tmp/perf/pmu-events/pmu-events.c:61742
>    #7 0x55972b13a3bc in test__parsing tests/pmu-events.c:898
>    #8 0x55972b106cd7 in run_test tests/builtin-test.c:236
>    #9 0x55972b106f7c in test_and_print tests/builtin-test.c:265
>    #10 0x55972b107f96 in __cmd_test tests/builtin-test.c:436
>    #11 0x55972b10927a in cmd_test tests/builtin-test.c:559
>    #12 0x55972b19584a in run_builtin
> /home/irogers/kernel.org/tools/perf/perf.c:323
>    #13 0x55972b195dbb in handle_internal_command
> /home/irogers/kernel.org/tools/perf/perf.c:377
>    #14 0x55972b196183 in run_argv /home/irogers/kernel.org/tools/perf/per=
f.c:421
>    #15 0x55972b1966eb in main /home/irogers/kernel.org/tools/perf/perf.c:=
537
>    #16 0x7f24cbe46189 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>
> SUMMARY: AddressSanitizer: 6199 byte(s) leaked in 340 allocation(s)
>
> As this is mixing allocated and unallocated strings, you like want to
> strdup the unallocated ones, then add a free to the exit routine.
>
> Thanks,
> Ian

Except for the memory leak, everything looks good here. Will ack with
the memory leak fix.

Thanks,
Ian

> > +                               expr->default_metricgroup_name =3D m->d=
efault_metricgroup_name;
> > +                       else
> > +                               expr->default_metricgroup_name =3D name=
;
> > +               } else
> > +                       expr->default_metricgroup_name =3D m->default_m=
etricgroup_name;
> > +               if (is_default)
> > +                       me->is_default =3D true;
> >                 list_add(&expr->nd, &me->head);
> >         }
> >
> > diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgrou=
p.h
> > index bf18274c15df..d5325c6ec8e1 100644
> > --- a/tools/perf/util/metricgroup.h
> > +++ b/tools/perf/util/metricgroup.h
> > @@ -22,6 +22,7 @@ struct cgroup;
> >  struct metric_event {
> >         struct rb_node nd;
> >         struct evsel *evsel;
> > +       bool is_default; /* the metric evsel from the Default metricgro=
up */
> >         struct list_head head; /* list of metric_expr */
> >  };
> >
> > @@ -55,6 +56,8 @@ struct metric_expr {
> >          * more human intelligible) and then add "MiB" afterward when d=
isplayed.
> >          */
> >         const char *metric_unit;
> > +       /** Displayed metricgroup name of the Default metricgroup */
> > +       const char *default_metricgroup_name;
> >         /** Null terminated array of events used by the metric. */
> >         struct evsel **metric_events;
> >         /** Null terminated array of referenced metrics. */
> > --
> > 2.35.1
> >
