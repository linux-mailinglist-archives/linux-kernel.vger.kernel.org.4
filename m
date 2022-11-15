Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0681B629FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiKOQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiKOQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:53:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB166165
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:53:52 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 6-20020a1c0206000000b003cfdd569507so170602wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOJ4Z5mZv4W8JCPO7EvpVr0JxH6HzcH6zX+25sE/5es=;
        b=J3QSci5xMMQN5lH0ukm751u0yupM1cn55aJzyida+Gkr8sEiWrzDyqmDRnz/5fkil+
         dm8CvN13rNhMngPhC+zgLvDeLb5j2bt8z2QkjzdJENO0MhapJAZ9LySS2P+Pk6S9B9Du
         GzgpWxjGrK/+BP5OAbIFZlXPFUQlIhju5uR8UjRYSDayb9Aah1oVYQZSMykHJ7E6KsXM
         6nPROyuhsWTnxBAHI9pkhfiaddG4FW1NOb2sf2iJsrCcT5GmK6QTFVfKYneWMeBfbjzw
         N7xEuBfwMew2FNnY+DyYBvrX7szVhsplmBVuO+xWhx2pASB33N1Txz+yc0BQN2Mdp/eE
         7XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOJ4Z5mZv4W8JCPO7EvpVr0JxH6HzcH6zX+25sE/5es=;
        b=deD9sM7NWXSTLS3lvtyJQbRtJhsHb9V7jC+UleaA66J+G06HM1PXa6igmxiiv0gELr
         IUFzsUGggv9miMcEnuOGQbeTH+motMhSXa8B8tsJ/P8qEcE4MbqOdfCCmM3nUeuILkIC
         7mkpFbf9gTI7CJQvdoLqi74FWiAuSrCP0tmwE4NTgSNu76S1BsFTzR3q/Q0hxvaSTqUj
         Dr6y3iu/SamLYamCRvR0tA821ZIZhNfU3MueE0Mr5Irt73KKEmx1IkObWQxMSlegI13I
         /WKQHCzUHEzpw5rrTJb4KLeCq9SF3FQ7SPmGU8DFXiVKiMpztW38C/qDUb5Q9IXKneZR
         vPCQ==
X-Gm-Message-State: ANoB5pla8nBhrRYQ42ToGv2MhvyeyN1YWrobKgm7y5ZZpV8ueDMEW52f
        mqbPxLBooKH/wUtape4ld20KgGY8BuEUI+ktnFi0Pw==
X-Google-Smtp-Source: AA0mqf5FZfBjnEQS4n9aMxGS5OyiW1DT/Zi15sIZTgWq15LU2ilXfYX89jIMjz+0nZ3D+dF4js+/GF0ydCMs+kw2F4M=
X-Received: by 2002:a05:600c:4487:b0:3cf:b2a6:267d with SMTP id
 e7-20020a05600c448700b003cfb2a6267dmr2191384wmo.67.1668531229916; Tue, 15 Nov
 2022 08:53:49 -0800 (PST)
MIME-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com> <20221114210723.2749751-10-irogers@google.com>
 <Y3OWyLWvZ/K5KnuL@kernel.org>
In-Reply-To: <Y3OWyLWvZ/K5KnuL@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Nov 2022 08:53:36 -0800
Message-ID: <CAP-5=fXTqD-QHrrQufXcx=uBgjS1Ae33CCwPaXHJH=rtXFqjRA@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] perf list: Reorganize to use callbacks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 5:40 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Nov 14, 2022 at 01:07:22PM -0800, Ian Rogers escreveu:
> > Rather than controlling the list output with passed flags, add
> > callbacks that are called when an event or metric are
> > encountered. State is passed to the callback so that command line
> > options can be respected, alternatively the callbacks can be changed.
> >
> > Fix a few bugs:
> >  - wordwrap to columns metric descriptions and expressions;
> >  - remove unnecessary whitespace after PMU event names;
> >  - the metric filter is a glob but matched using strstr which will
> >    always fail, switch to using a proper globmatch,
> >  - the detail flag gives details for extra kernel PMU events like
> >    branch-instructions.
> >
> > In metricgroup.c switch from struct mep being a rbtree of metricgroups
> > containing a list of metrics, to the tree directly containing all the
> > metrics. In general the alias for a name is passed to the print
> > routine rather than being contained in the name with OR.
>
> =E2=AC=A2[acme@toolbox perf]$ gcc --version | head -1
> gcc (GCC) 12.2.1 20220819 (Red Hat 12.2.1-2)
> =E2=AC=A2[acme@toolbox perf]$
>
>   CC      /tmp/build/perf/util/s390-sample-raw.o
> util/print-events.c: In function =E2=80=98print_sdt_events=E2=80=99:
> util/print-events.c:183:33: error: ignoring return value of =E2=80=98aspr=
intf=E2=80=99 declared with attribute =E2=80=98warn_unused_result=E2=80=99 =
[-Werror=3Dunused-result]
>   183 |                                 asprintf(&evt_name, "%s@%s(%.12s)=
", sdt_name->s, path, bid);
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: /tmp=
/build/perf/util/print-events.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>
> Since we have a test for evt_name later on, I fixed this with:
>
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index 5210a168d54f9eb5..2646ae18d9f9b57b 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -180,7 +180,8 @@ void print_sdt_events(const struct print_callbacks *p=
rint_cb, void *print_state)
>                         char *path =3D build_id_cache__origname(bid);
>
>                         if (path) {
> -                               asprintf(&evt_name, "%s@%s(%.12s)", sdt_n=
ame->s, path, bid);
> +                               if (asprintf(&evt_name, "%s@%s(%.12s)", s=
dt_name->s, path, bid) < 0)
> +                                       evt_name =3D NULL;
>                                 free(path);
>                         }
>                 }


Looks good, thanks!

Ian

> Thanks,
>
> - Arnaldo
>
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-list.c      | 331 +++++++++++++++++++++++++-----
> >  tools/perf/util/metricgroup.c  | 243 ++++++----------------
> >  tools/perf/util/metricgroup.h  |   4 +-
> >  tools/perf/util/pmu.c          | 145 +++++--------
> >  tools/perf/util/pmu.h          |   5 +-
> >  tools/perf/util/print-events.c | 363 +++++++++++++++++----------------
> >  tools/perf/util/print-events.h |  42 ++--
> >  7 files changed, 621 insertions(+), 512 deletions(-)
> >
> > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > index cc84ced6da26..12811fc40a30 100644
> > --- a/tools/perf/builtin-list.c
> > +++ b/tools/perf/builtin-list.c
> > @@ -15,31 +15,240 @@
> >  #include "util/pmu-hybrid.h"
> >  #include "util/debug.h"
> >  #include "util/metricgroup.h"
> > +#include "util/string2.h"
> > +#include "util/strlist.h"
> >  #include <subcmd/pager.h>
> >  #include <subcmd/parse-options.h>
> >  #include <stdio.h>
> >
> > -static bool desc_flag =3D true;
> > -static bool details_flag;
> > +/**
> > + * struct print_state - State and configuration passed to the default_=
print
> > + * functions.
> > + */
> > +struct print_state {
> > +     /**
> > +      * @pmu_glob: Optionally restrict PMU and metric matching to PMU =
or
> > +      * debugfs subsystem name.
> > +      */
> > +     char *pmu_glob;
> > +     /** @event_glob: Optional pattern matching glob. */
> > +     char *event_glob;
> > +     /** @name_only: Print event or metric names only. */
> > +     bool name_only;
> > +     /** @desc: Print the event or metric description. */
> > +     bool desc;
> > +     /** @long_desc: Print longer event or metric description. */
> > +     bool long_desc;
> > +     /** @deprecated: Print deprecated events or metrics. */
> > +     bool deprecated;
> > +     /**
> > +      * @detailed: Print extra information on the perf event such as n=
ames
> > +      * and expressions used internally by events.
> > +      */
> > +     bool detailed;
> > +     /** @metrics: Controls printing of metric and metric groups. */
> > +     bool metrics;
> > +     /** @metricgroups: Controls printing of metric and metric groups.=
 */
> > +     bool metricgroups;
> > +     /** @last_topic: The last printed event topic. */
> > +     char *last_topic;
> > +     /** @last_metricgroups: The last printed metric group. */
> > +     char *last_metricgroups;
> > +     /** @visited_metrics: Metrics that are printed to avoid duplicate=
s. */
> > +     struct strlist *visited_metrics;
> > +};
> > +
> > +static void default_print_start(void *ps)
> > +{
> > +     struct print_state *print_state =3D ps;
> > +
> > +     if (!print_state->name_only && pager_in_use())
> > +             printf("\nList of pre-defined events (to be used in -e or=
 -M):\n\n");
> > +}
> > +
> > +static void default_print_end(void *print_state __maybe_unused) {}
> > +
> > +static void wordwrap(const char *s, int start, int max, int corr)
> > +{
> > +     int column =3D start;
> > +     int n;
> > +
> > +     while (*s) {
> > +             int wlen =3D strcspn(s, " \t");
> > +
> > +             if (column + wlen >=3D max && column > start) {
> > +                     printf("\n%*s", start, "");
> > +                     column =3D start + corr;
> > +             }
> > +             n =3D printf("%s%.*s", column > start ? " " : "", wlen, s=
);
> > +             if (n <=3D 0)
> > +                     break;
> > +             s +=3D wlen;
> > +             column +=3D n;
> > +             s =3D skip_spaces(s);
> > +     }
> > +}
> > +
> > +static void default_print_event(void *ps, const char *pmu_name, const =
char *topic,
> > +                             const char *event_name, const char *event=
_alias,
> > +                             const char *scale_unit __maybe_unused,
> > +                             bool deprecated, const char *event_type_d=
esc,
> > +                             const char *desc, const char *long_desc,
> > +                             const char *encoding_desc,
> > +                             const char *metric_name, const char *metr=
ic_expr)
> > +{
> > +     struct print_state *print_state =3D ps;
> > +     int pos;
> > +
> > +     if (deprecated && !print_state->deprecated)
> > +             return;
> > +
> > +     if (print_state->pmu_glob && !strglobmatch(pmu_name, print_state-=
>pmu_glob))
> > +             return;
> > +
> > +     if (print_state->event_glob &&
> > +         (!event_name || !strglobmatch(event_name, print_state->event_=
glob)) &&
> > +         (!event_alias || !strglobmatch(event_alias, print_state->even=
t_glob)) &&
> > +         (!topic || !strglobmatch_nocase(topic, print_state->event_glo=
b)))
> > +             return;
> > +
> > +     if (print_state->name_only) {
> > +             if (event_alias && strlen(event_alias))
> > +                     printf("%s ", event_alias);
> > +             else
> > +                     printf("%s ", event_name);
> > +             return;
> > +     }
> > +
> > +     if (strcmp(print_state->last_topic, topic ?: "")) {
> > +             if (topic)
> > +                     printf("\n%s:\n", topic);
> > +             free(print_state->last_topic);
> > +             print_state->last_topic =3D strdup(topic ?: "");
> > +     }
> > +
> > +     if (event_alias && strlen(event_alias))
> > +             pos =3D printf("  %s OR %s", event_name, event_alias);
> > +     else
> > +             pos =3D printf("  %s", event_name);
> > +
> > +     if (!topic && event_type_desc) {
> > +             for (; pos < 53; pos++)
> > +                     putchar(' ');
> > +             printf("[%s]\n", event_type_desc);
> > +     } else
> > +             putchar('\n');
> > +
> > +     if (desc && print_state->desc) {
> > +             printf("%*s", 8, "[");
> > +             wordwrap(desc, 8, pager_get_columns(), 0);
> > +             printf("]\n");
> > +     }
> > +
> > +     if (long_desc && print_state->long_desc) {
> > +             printf("%*s", 8, "[");
> > +             wordwrap(long_desc, 8, pager_get_columns(), 0);
> > +             printf("]\n");
> > +     }
> > +
> > +     if (print_state->detailed && encoding_desc) {
> > +             printf("%*s%s", 8, "", encoding_desc);
> > +             if (metric_name)
> > +                     printf(" MetricName: %s", metric_name);
> > +             if (metric_expr)
> > +                     printf(" MetricExpr: %s", metric_expr);
> > +             putchar('\n');
> > +     }
> > +}
> > +
> > +static void default_print_metric(void *ps,
> > +                             const char *group,
> > +                             const char *name,
> > +                             const char *desc,
> > +                             const char *long_desc,
> > +                             const char *expr,
> > +                             const char *unit __maybe_unused)
> > +{
> > +     struct print_state *print_state =3D ps;
> > +
> > +     if (print_state->event_glob &&
> > +         (!print_state->metrics || !name || !strglobmatch(name, print_=
state->event_glob)) &&
> > +         (!print_state->metricgroups || !group || !strglobmatch(group,=
 print_state->event_glob)))
> > +             return;
> > +
> > +     if (!print_state->name_only && !print_state->last_metricgroups) {
> > +             if (print_state->metricgroups) {
> > +                     printf("\nMetric Groups:\n");
> > +                     if (!print_state->metrics)
> > +                             putchar('\n');
> > +             } else {
> > +                     printf("\nMetrics:\n\n");
> > +             }
> > +     }
> > +     if (!print_state->last_metricgroups ||
> > +         strcmp(print_state->last_metricgroups, group ?: "")) {
> > +             if (group && print_state->metricgroups) {
> > +                     if (print_state->name_only)
> > +                             printf("%s ", group);
> > +                     else if (print_state->metrics)
> > +                             printf("\n%s:\n", group);
> > +                     else
> > +                             printf("%s\n", group);
> > +             }
> > +             free(print_state->last_metricgroups);
> > +             print_state->last_metricgroups =3D strdup(group ?: "");
> > +     }
> > +     if (!print_state->metrics)
> > +             return;
> > +
> > +     if (print_state->name_only) {
> > +             if (print_state->metrics &&
> > +                 !strlist__has_entry(print_state->visited_metrics, nam=
e)) {
> > +                     printf("%s ", name);
> > +                     strlist__add(print_state->visited_metrics, name);
> > +             }
> > +             return;
> > +     }
> > +     printf("  %s\n", name);
> > +
> > +     if (desc && print_state->desc) {
> > +             printf("%*s", 8, "[");
> > +             wordwrap(desc, 8, pager_get_columns(), 0);
> > +             printf("]\n");
> > +     }
> > +     if (long_desc && print_state->long_desc) {
> > +             printf("%*s", 8, "[");
> > +             wordwrap(long_desc, 8, pager_get_columns(), 0);
> > +             printf("]\n");
> > +     }
> > +     if (expr && print_state->detailed) {
> > +             printf("%*s", 8, "[");
> > +             wordwrap(expr, 8, pager_get_columns(), 0);
> > +             printf("]\n");
> > +     }
> > +}
> >
> >  int cmd_list(int argc, const char **argv)
> >  {
> >       int i, ret =3D 0;
> > -     bool raw_dump =3D false;
> > -     bool long_desc_flag =3D false;
> > -     bool deprecated =3D false;
> > -     char *pmu_name =3D NULL;
> > +     struct print_state ps =3D {};
> > +     struct print_callbacks print_cb =3D {
> > +             .print_start =3D default_print_start,
> > +             .print_end =3D default_print_end,
> > +             .print_event =3D default_print_event,
> > +             .print_metric =3D default_print_metric,
> > +     };
> >       const char *hybrid_name =3D NULL;
> >       const char *unit_name =3D NULL;
> >       struct option list_options[] =3D {
> > -             OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
> > -             OPT_BOOLEAN('d', "desc", &desc_flag,
> > +             OPT_BOOLEAN(0, "raw-dump", &ps.name_only, "Dump raw event=
s"),
> > +             OPT_BOOLEAN('d', "desc", &ps.desc,
> >                           "Print extra event descriptions. --no-desc to=
 not print."),
> > -             OPT_BOOLEAN('v', "long-desc", &long_desc_flag,
> > +             OPT_BOOLEAN('v', "long-desc", &ps.long_desc,
> >                           "Print longer event descriptions."),
> > -             OPT_BOOLEAN(0, "details", &details_flag,
> > +             OPT_BOOLEAN(0, "details", &ps.detailed,
> >                           "Print information on the perf event names an=
d expressions used internally by events."),
> > -             OPT_BOOLEAN(0, "deprecated", &deprecated,
> > +             OPT_BOOLEAN(0, "deprecated", &ps.deprecated,
> >                           "Print deprecated events."),
> >               OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
> >                          "Limit PMU or metric printing to the given hyb=
rid PMU (e.g. core or atom)."),
> > @@ -63,20 +272,28 @@ int cmd_list(int argc, const char **argv)
> >
> >       setup_pager();
> >
> > -     if (!raw_dump && pager_in_use())
> > -             printf("\nList of pre-defined events (to be used in -e or=
 -M):\n\n");
> > +     if (!ps.name_only)
> > +             setup_pager();
> >
> > +     ps.desc =3D !ps.long_desc;
> > +     ps.last_topic =3D strdup("");
> > +     assert(ps.last_topic);
> > +     ps.visited_metrics =3D strlist__new(NULL, NULL);
> > +     assert(ps.visited_metrics);
> >       if (unit_name)
> > -             pmu_name =3D strdup(unit_name);
> > +             ps.pmu_glob =3D strdup(unit_name);
> >       else if (hybrid_name) {
> > -             pmu_name =3D perf_pmu__hybrid_type_to_pmu(hybrid_name);
> > -             if (!pmu_name)
> > +             ps.pmu_glob =3D perf_pmu__hybrid_type_to_pmu(hybrid_name)=
;
> > +             if (!ps.pmu_glob)
> >                       pr_warning("WARNING: hybrid cputype is not suppor=
ted!\n");
> >       }
> >
> > +     print_cb.print_start(&ps);
> > +
> >       if (argc =3D=3D 0) {
> > -             print_events(NULL, raw_dump, !desc_flag, long_desc_flag,
> > -                             details_flag, deprecated, pmu_name);
> > +             ps.metrics =3D true;
> > +             ps.metricgroups =3D true;
> > +             print_events(&print_cb, &ps);
> >               goto out;
> >       }
> >
> > @@ -84,30 +301,33 @@ int cmd_list(int argc, const char **argv)
> >               char *sep, *s;
> >
> >               if (strcmp(argv[i], "tracepoint") =3D=3D 0)
> > -                     print_tracepoint_events(NULL, NULL, raw_dump);
> > +                     print_tracepoint_events(&print_cb, &ps);
> >               else if (strcmp(argv[i], "hw") =3D=3D 0 ||
> >                        strcmp(argv[i], "hardware") =3D=3D 0)
> > -                     print_symbol_events(NULL, PERF_TYPE_HARDWARE,
> > -                                     event_symbols_hw, PERF_COUNT_HW_M=
AX, raw_dump);
> > +                     print_symbol_events(&print_cb, &ps, PERF_TYPE_HAR=
DWARE,
> > +                                     event_symbols_hw, PERF_COUNT_HW_M=
AX);
> >               else if (strcmp(argv[i], "sw") =3D=3D 0 ||
> >                        strcmp(argv[i], "software") =3D=3D 0) {
> > -                     print_symbol_events(NULL, PERF_TYPE_SOFTWARE,
> > -                                     event_symbols_sw, PERF_COUNT_SW_M=
AX, raw_dump);
> > -                     print_tool_events(NULL, raw_dump);
> > +                     print_symbol_events(&print_cb, &ps, PERF_TYPE_SOF=
TWARE,
> > +                                     event_symbols_sw, PERF_COUNT_SW_M=
AX);
> > +                     print_tool_events(&print_cb, &ps);
> >               } else if (strcmp(argv[i], "cache") =3D=3D 0 ||
> >                        strcmp(argv[i], "hwcache") =3D=3D 0)
> > -                     print_hwcache_events(NULL, raw_dump);
> > +                     print_hwcache_events(&print_cb, &ps);
> >               else if (strcmp(argv[i], "pmu") =3D=3D 0)
> > -                     print_pmu_events(NULL, raw_dump, !desc_flag,
> > -                                             long_desc_flag, details_f=
lag,
> > -                                             deprecated, pmu_name);
> > +                     print_pmu_events(&print_cb, &ps);
> >               else if (strcmp(argv[i], "sdt") =3D=3D 0)
> > -                     print_sdt_events(NULL, NULL, raw_dump);
> > -             else if (strcmp(argv[i], "metric") =3D=3D 0 || strcmp(arg=
v[i], "metrics") =3D=3D 0)
> > -                     metricgroup__print(true, false, NULL, raw_dump, d=
etails_flag, pmu_name);
> > -             else if (strcmp(argv[i], "metricgroup") =3D=3D 0 || strcm=
p(argv[i], "metricgroups") =3D=3D 0)
> > -                     metricgroup__print(false, true, NULL, raw_dump, d=
etails_flag, pmu_name);
> > -             else if ((sep =3D strchr(argv[i], ':')) !=3D NULL) {
> > +                     print_sdt_events(&print_cb, &ps);
> > +             else if (strcmp(argv[i], "metric") =3D=3D 0 || strcmp(arg=
v[i], "metrics") =3D=3D 0) {
> > +                     ps.metricgroups =3D false;
> > +                     ps.metrics =3D true;
> > +                     metricgroup__print(&print_cb, &ps);
> > +             } else if (strcmp(argv[i], "metricgroup") =3D=3D 0 ||
> > +                        strcmp(argv[i], "metricgroups") =3D=3D 0) {
> > +                     ps.metricgroups =3D true;
> > +                     ps.metrics =3D false;
> > +                     metricgroup__print(&print_cb, &ps);
> > +             } else if ((sep =3D strchr(argv[i], ':')) !=3D NULL) {
> >                       int sep_idx;
> >
> >                       sep_idx =3D sep - argv[i];
> > @@ -118,34 +338,41 @@ int cmd_list(int argc, const char **argv)
> >                       }
> >
> >                       s[sep_idx] =3D '\0';
> > -                     print_tracepoint_events(s, s + sep_idx + 1, raw_d=
ump);
> > -                     print_sdt_events(s, s + sep_idx + 1, raw_dump);
> > -                     metricgroup__print(true, true, s, raw_dump, detai=
ls_flag, pmu_name);
> > +                     ps.pmu_glob =3D s;
> > +                     ps.event_glob =3D s + sep_idx + 1;
> > +                     print_tracepoint_events(&print_cb, &ps);
> > +                     print_sdt_events(&print_cb, &ps);
> > +                     ps.metrics =3D true;
> > +                     ps.metricgroups =3D true;
> > +                     metricgroup__print(&print_cb, &ps);
> >                       free(s);
> >               } else {
> >                       if (asprintf(&s, "*%s*", argv[i]) < 0) {
> >                               printf("Critical: Not enough memory! Tryi=
ng to continue...\n");
> >                               continue;
> >                       }
> > -                     print_symbol_events(s, PERF_TYPE_HARDWARE,
> > -                                         event_symbols_hw, PERF_COUNT_=
HW_MAX, raw_dump);
> > -                     print_symbol_events(s, PERF_TYPE_SOFTWARE,
> > -                                         event_symbols_sw, PERF_COUNT_=
SW_MAX, raw_dump);
> > -                     print_tool_events(s, raw_dump);
> > -                     print_hwcache_events(s, raw_dump);
> > -                     print_pmu_events(s, raw_dump, !desc_flag,
> > -                                             long_desc_flag,
> > -                                             details_flag,
> > -                                             deprecated,
> > -                                             pmu_name);
> > -                     print_tracepoint_events(NULL, s, raw_dump);
> > -                     print_sdt_events(NULL, s, raw_dump);
> > -                     metricgroup__print(true, true, s, raw_dump, detai=
ls_flag, pmu_name);
> > +                     ps.event_glob =3D s;
> > +                     print_symbol_events(&print_cb, &ps, PERF_TYPE_HAR=
DWARE,
> > +                                     event_symbols_hw, PERF_COUNT_HW_M=
AX);
> > +                     print_symbol_events(&print_cb, &ps, PERF_TYPE_SOF=
TWARE,
> > +                                     event_symbols_sw, PERF_COUNT_SW_M=
AX);
> > +                     print_tool_events(&print_cb, &ps);
> > +                     print_hwcache_events(&print_cb, &ps);
> > +                     print_pmu_events(&print_cb, &ps);
> > +                     print_tracepoint_events(&print_cb, &ps);
> > +                     print_sdt_events(&print_cb, &ps);
> > +                     ps.metrics =3D true;
> > +                     ps.metricgroups =3D true;
> > +                     metricgroup__print(&print_cb, &ps);
> >                       free(s);
> >               }
> >       }
> >
> >  out:
> > -     free(pmu_name);
> > +     print_cb.print_end(&ps);
> > +     free(ps.pmu_glob);
> > +     free(ps.last_topic);
> > +     free(ps.last_metricgroups);
> > +     strlist__delete(ps.visited_metrics);
> >       return ret;
> >  }
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> > index 1943fed9b6d9..76501009ead5 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -12,6 +12,7 @@
> >  #include "strbuf.h"
> >  #include "pmu.h"
> >  #include "pmu-hybrid.h"
> > +#include "print-events.h"
> >  #include "expr.h"
> >  #include "rblist.h"
> >  #include <string.h>
> > @@ -352,51 +353,65 @@ static bool match_pe_metric(const struct pmu_even=
t *pe, const char *metric)
> >              match_metric(pe->metric_name, metric);
> >  }
> >
> > +/** struct mep - RB-tree node for building printing information. */
> >  struct mep {
> > +     /** nd - RB-tree element. */
> >       struct rb_node nd;
> > -     const char *name;
> > -     struct strlist *metrics;
> > +     /** @metric_group: Owned metric group name, separated others with=
 ';'. */
> > +     char *metric_group;
> > +     const char *metric_name;
> > +     const char *metric_desc;
> > +     const char *metric_long_desc;
> > +     const char *metric_expr;
> > +     const char *metric_unit;
> >  };
> >
> >  static int mep_cmp(struct rb_node *rb_node, const void *entry)
> >  {
> >       struct mep *a =3D container_of(rb_node, struct mep, nd);
> >       struct mep *b =3D (struct mep *)entry;
> > +     int ret;
> >
> > -     return strcmp(a->name, b->name);
> > +     ret =3D strcmp(a->metric_group, b->metric_group);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return strcmp(a->metric_name, b->metric_name);
> >  }
> >
> > -static struct rb_node *mep_new(struct rblist *rl __maybe_unused,
> > -                                     const void *entry)
> > +static struct rb_node *mep_new(struct rblist *rl __maybe_unused, const=
 void *entry)
> >  {
> >       struct mep *me =3D malloc(sizeof(struct mep));
> >
> >       if (!me)
> >               return NULL;
> > +
> >       memcpy(me, entry, sizeof(struct mep));
> > -     me->name =3D strdup(me->name);
> > -     if (!me->name)
> > -             goto out_me;
> > -     me->metrics =3D strlist__new(NULL, NULL);
> > -     if (!me->metrics)
> > -             goto out_name;
> >       return &me->nd;
> > -out_name:
> > -     zfree(&me->name);
> > -out_me:
> > +}
> > +
> > +static void mep_delete(struct rblist *rl __maybe_unused,
> > +                    struct rb_node *nd)
> > +{
> > +     struct mep *me =3D container_of(nd, struct mep, nd);
> > +
> > +     zfree(&me->metric_group);
> >       free(me);
> > -     return NULL;
> >  }
> >
> > -static struct mep *mep_lookup(struct rblist *groups, const char *name)
> > +static struct mep *mep_lookup(struct rblist *groups, const char *metri=
c_group,
> > +                           const char *metric_name)
> >  {
> >       struct rb_node *nd;
> >       struct mep me =3D {
> > -             .name =3D name
> > +             .metric_group =3D strdup(metric_group),
> > +             .metric_name =3D metric_name,
> >       };
> >       nd =3D rblist__find(groups, &me);
> > -     if (nd)
> > +     if (nd) {
> > +             free(me.metric_group);
> >               return container_of(nd, struct mep, nd);
> > +     }
> >       rblist__add_node(groups, &me);
> >       nd =3D rblist__find(groups, &me);
> >       if (nd)
> > @@ -404,107 +419,37 @@ static struct mep *mep_lookup(struct rblist *gro=
ups, const char *name)
> >       return NULL;
> >  }
> >
> > -static void mep_delete(struct rblist *rl __maybe_unused,
> > -                    struct rb_node *nd)
> > -{
> > -     struct mep *me =3D container_of(nd, struct mep, nd);
> > -
> > -     strlist__delete(me->metrics);
> > -     zfree(&me->name);
> > -     free(me);
> > -}
> > -
> > -static void metricgroup__print_strlist(struct strlist *metrics, bool r=
aw)
> > -{
> > -     struct str_node *sn;
> > -     int n =3D 0;
> > -
> > -     strlist__for_each_entry (sn, metrics) {
> > -             if (raw)
> > -                     printf("%s%s", n > 0 ? " " : "", sn->s);
> > -             else
> > -                     printf("  %s\n", sn->s);
> > -             n++;
> > -     }
> > -     if (raw)
> > -             putchar('\n');
> > -}
> > -
> > -static int metricgroup__print_pmu_event(const struct pmu_event *pe,
> > -                                     bool metricgroups, char *filter,
> > -                                     bool raw, bool details,
> > -                                     struct rblist *groups,
> > -                                     struct strlist *metriclist)
> > +static int metricgroup__add_to_mep_groups(const struct pmu_event *pe,
> > +                                     struct rblist *groups)
> >  {
> >       const char *g;
> >       char *omg, *mg;
> >
> > -     g =3D pe->metric_group;
> > -     if (!g && pe->metric_name) {
> > -             if (pe->name)
> > -                     return 0;
> > -             g =3D "No_group";
> > -     }
> > -
> > -     if (!g)
> > -             return 0;
> > -
> > -     mg =3D strdup(g);
> > -
> > +     mg =3D strdup(pe->metric_group ?: "No_group");
> >       if (!mg)
> >               return -ENOMEM;
> >       omg =3D mg;
> >       while ((g =3D strsep(&mg, ";")) !=3D NULL) {
> >               struct mep *me;
> > -             char *s;
> >
> >               g =3D skip_spaces(g);
> > -             if (*g =3D=3D 0)
> > -                     g =3D "No_group";
> > -             if (filter && !strstr(g, filter))
> > -                     continue;
> > -             if (raw)
> > -                     s =3D (char *)pe->metric_name;
> > -             else {
> > -                     if (asprintf(&s, "%s\n%*s%s]",
> > -                                  pe->metric_name, 8, "[", pe->desc) <=
 0)
> > -                             return -1;
> > -                     if (details) {
> > -                             if (asprintf(&s, "%s\n%*s%s]",
> > -                                          s, 8, "[", pe->metric_expr) =
< 0)
> > -                                     return -1;
> > -                     }
> > -             }
> > -
> > -             if (!s)
> > -                     continue;
> > +             if (strlen(g))
> > +                     me =3D mep_lookup(groups, g, pe->metric_name);
> > +             else
> > +                     me =3D mep_lookup(groups, "No_group", pe->metric_=
name);
> >
> > -             if (!metricgroups) {
> > -                     strlist__add(metriclist, s);
> > -             } else {
> > -                     me =3D mep_lookup(groups, g);
> > -                     if (!me)
> > -                             continue;
> > -                     strlist__add(me->metrics, s);
> > +             if (me) {
> > +                     me->metric_desc =3D pe->desc;
> > +                     me->metric_long_desc =3D pe->long_desc;
> > +                     me->metric_expr =3D pe->metric_expr;
> > +                     me->metric_unit =3D pe->unit;
> >               }
> > -
> > -             if (!raw)
> > -                     free(s);
> >       }
> >       free(omg);
> >
> >       return 0;
> >  }
> >
> > -struct metricgroup_print_sys_idata {
> > -     struct strlist *metriclist;
> > -     char *filter;
> > -     struct rblist *groups;
> > -     bool metricgroups;
> > -     bool raw;
> > -     bool details;
> > -};
> > -
> >  struct metricgroup_iter_data {
> >       pmu_event_iter_fn fn;
> >       void *data;
> > @@ -527,61 +472,26 @@ static int metricgroup__sys_event_iter(const stru=
ct pmu_event *pe,
> >
> >               return d->fn(pe, table, d->data);
> >       }
> > -
> >       return 0;
> >  }
> >
> > -static int metricgroup__print_sys_event_iter(const struct pmu_event *p=
e,
> > -                                          const struct pmu_events_tabl=
e *table __maybe_unused,
> > -                                          void *data)
> > -{
> > -     struct metricgroup_print_sys_idata *d =3D data;
> > -
> > -     return metricgroup__print_pmu_event(pe, d->metricgroups, d->filte=
r, d->raw,
> > -                                  d->details, d->groups, d->metriclist=
);
> > -}
> > -
> > -struct metricgroup_print_data {
> > -     const char *pmu_name;
> > -     struct strlist *metriclist;
> > -     char *filter;
> > -     struct rblist *groups;
> > -     bool metricgroups;
> > -     bool raw;
> > -     bool details;
> > -};
> > -
> > -static int metricgroup__print_callback(const struct pmu_event *pe,
> > -                                    const struct pmu_events_table *tab=
le __maybe_unused,
> > -                                    void *vdata)
> > +static int metricgroup__add_to_mep_groups_callback(const struct pmu_ev=
ent *pe,
> > +                                             const struct pmu_events_t=
able *table __maybe_unused,
> > +                                             void *vdata)
> >  {
> > -     struct metricgroup_print_data *data =3D vdata;
> > -     const char *pmu =3D pe->pmu ?: "cpu";
> > +     struct rblist *groups =3D vdata;
> >
> > -     if (!pe->metric_expr)
> > -             return 0;
> > -
> > -     if (data->pmu_name && strcmp(data->pmu_name, pmu))
> > +     if (!pe->metric_name)
> >               return 0;
> >
> > -     return metricgroup__print_pmu_event(pe, data->metricgroups, data-=
>filter,
> > -                                         data->raw, data->details, dat=
a->groups,
> > -                                         data->metriclist);
> > +     return metricgroup__add_to_mep_groups(pe, groups);
> >  }
> >
> > -void metricgroup__print(bool metrics, bool metricgroups, char *filter,
> > -                     bool raw, bool details, const char *pmu_name)
> > +void metricgroup__print(const struct print_callbacks *print_cb, void *=
print_state)
> >  {
> >       struct rblist groups;
> > -     struct rb_node *node, *next;
> > -     struct strlist *metriclist =3D NULL;
> >       const struct pmu_events_table *table;
> > -
> > -     if (!metricgroups) {
> > -             metriclist =3D strlist__new(NULL, NULL);
> > -             if (!metriclist)
> > -                     return;
> > -     }
> > +     struct rb_node *node, *next;
> >
> >       rblist__init(&groups);
> >       groups.node_new =3D mep_new;
> > @@ -589,56 +499,31 @@ void metricgroup__print(bool metrics, bool metric=
groups, char *filter,
> >       groups.node_delete =3D mep_delete;
> >       table =3D pmu_events_table__find();
> >       if (table) {
> > -             struct metricgroup_print_data data =3D {
> > -                     .pmu_name =3D pmu_name,
> > -                     .metriclist =3D metriclist,
> > -                     .metricgroups =3D metricgroups,
> > -                     .filter =3D filter,
> > -                     .raw =3D raw,
> > -                     .details =3D details,
> > -                     .groups =3D &groups,
> > -             };
> > -
> >               pmu_events_table_for_each_event(table,
> > -                                             metricgroup__print_callba=
ck,
> > -                                             &data);
> > +                                             metricgroup__add_to_mep_g=
roups_callback,
> > +                                             &groups);
> >       }
> >       {
> >               struct metricgroup_iter_data data =3D {
> > -                     .fn =3D metricgroup__print_sys_event_iter,
> > -                     .data =3D (void *) &(struct metricgroup_print_sys=
_idata){
> > -                             .metriclist =3D metriclist,
> > -                             .metricgroups =3D metricgroups,
> > -                             .filter =3D filter,
> > -                             .raw =3D raw,
> > -                             .details =3D details,
> > -                             .groups =3D &groups,
> > -                     },
> > +                     .fn =3D metricgroup__add_to_mep_groups_callback,
> > +                     .data =3D &groups,
> >               };
> > -
> >               pmu_for_each_sys_event(metricgroup__sys_event_iter, &data=
);
> >       }
> >
> > -     if (!filter || !rblist__empty(&groups)) {
> > -             if (metricgroups && !raw)
> > -                     printf("\nMetric Groups:\n\n");
> > -             else if (metrics && !raw)
> > -                     printf("\nMetrics:\n\n");
> > -     }
> > -
> >       for (node =3D rb_first_cached(&groups.entries); node; node =3D ne=
xt) {
> >               struct mep *me =3D container_of(node, struct mep, nd);
> >
> > -             if (metricgroups)
> > -                     printf("%s%s%s", me->name, metrics && !raw ? ":" =
: "", raw ? " " : "\n");
> > -             if (metrics)
> > -                     metricgroup__print_strlist(me->metrics, raw);
> > +             print_cb->print_metric(print_state,
> > +                             me->metric_group,
> > +                             me->metric_name,
> > +                             me->metric_desc,
> > +                             me->metric_long_desc,
> > +                             me->metric_expr,
> > +                             me->metric_unit);
> >               next =3D rb_next(node);
> >               rblist__remove_node(&groups, node);
> >       }
> > -     if (!metricgroups)
> > -             metricgroup__print_strlist(metriclist, raw);
> > -     strlist__delete(metriclist);
> >  }
> >
> >  static const char *code_characters =3D ",-=3D@";
> > diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgrou=
p.h
> > index 732d3a0d3334..0013cf582173 100644
> > --- a/tools/perf/util/metricgroup.h
> > +++ b/tools/perf/util/metricgroup.h
> > @@ -10,6 +10,7 @@
> >  struct evlist;
> >  struct evsel;
> >  struct option;
> > +struct print_callbacks;
> >  struct rblist;
> >  struct cgroup;
> >
> > @@ -78,8 +79,7 @@ int metricgroup__parse_groups_test(struct evlist *evl=
ist,
> >                                  bool metric_no_merge,
> >                                  struct rblist *metric_events);
> >
> > -void metricgroup__print(bool metrics, bool groups, char *filter,
> > -                     bool raw, bool details, const char *pmu_name);
> > +void metricgroup__print(const struct print_callbacks *print_cb, void *=
print_state);
> >  bool metricgroup__has_metric(const char *metric);
> >  int arch_get_runtimeparam(const struct pmu_event *pe __maybe_unused);
> >  void metricgroup__rblist_exit(struct rblist *metric_events);
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 075c82dd1347..e9a4f31926bf 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -23,6 +23,7 @@
> >  #include "evsel.h"
> >  #include "pmu.h"
> >  #include "parse-events.h"
> > +#include "print-events.h"
> >  #include "header.h"
> >  #include "string2.h"
> >  #include "strbuf.h"
> > @@ -1579,13 +1580,6 @@ static char *format_alias(char *buf, int len, co=
nst struct perf_pmu *pmu,
> >       return buf;
> >  }
> >
> > -static char *format_alias_or(char *buf, int len, const struct perf_pmu=
 *pmu,
> > -                          const struct perf_pmu_alias *alias)
> > -{
> > -     snprintf(buf, len, "%s OR %s/%s/", alias->name, pmu->name, alias-=
>name);
> > -     return buf;
> > -}
> > -
> >  /** Struct for ordering events as output in perf list. */
> >  struct sevent {
> >       /** PMU for event. */
> > @@ -1629,7 +1623,7 @@ static int cmp_sevent(const void *a, const void *=
b)
> >
> >       /* Order CPU core events to be first */
> >       if (as->is_cpu !=3D bs->is_cpu)
> > -             return bs->is_cpu - as->is_cpu;
> > +             return as->is_cpu ? -1 : 1;
> >
> >       /* Order by PMU name. */
> >       a_pmu_name =3D as->pmu->name ?: "";
> > @@ -1642,27 +1636,6 @@ static int cmp_sevent(const void *a, const void =
*b)
> >       return strcmp(a_name, b_name);
> >  }
> >
> > -static void wordwrap(char *s, int start, int max, int corr)
> > -{
> > -     int column =3D start;
> > -     int n;
> > -
> > -     while (*s) {
> > -             int wlen =3D strcspn(s, " \t");
> > -
> > -             if (column + wlen >=3D max && column > start) {
> > -                     printf("\n%*s", start, "");
> > -                     column =3D start + corr;
> > -             }
> > -             n =3D printf("%s%.*s", column > start ? " " : "", wlen, s=
);
> > -             if (n <=3D 0)
> > -                     break;
> > -             s +=3D wlen;
> > -             column +=3D n;
> > -             s =3D skip_spaces(s);
> > -     }
> > -}
> > -
> >  bool is_pmu_core(const char *name)
> >  {
> >       return !strcmp(name, "cpu") || is_arm_pmu_core(name);
> > @@ -1685,24 +1658,19 @@ static bool pmu_alias_is_duplicate(struct seven=
t *alias_a,
> >       return strcmp(a_pmu_name, b_pmu_name) =3D=3D 0;
> >  }
> >
> > -void print_pmu_events(const char *event_glob, bool name_only, bool qui=
et_flag,
> > -                     bool long_desc, bool details_flag, bool deprecate=
d,
> > -                     const char *pmu_name)
> > +void print_pmu_events(const struct print_callbacks *print_cb, void *pr=
int_state)
> >  {
> >       struct perf_pmu *pmu;
> > -     struct perf_pmu_alias *alias;
> > +     struct perf_pmu_alias *event;
> >       char buf[1024];
> >       int printed =3D 0;
> >       int len, j;
> >       struct sevent *aliases;
> > -     int numdesc =3D 0;
> > -     int columns =3D pager_get_columns();
> > -     char *topic =3D NULL;
> >
> >       pmu =3D NULL;
> >       len =3D 0;
> >       while ((pmu =3D perf_pmu__scan(pmu)) !=3D NULL) {
> > -             list_for_each_entry(alias, &pmu->aliases, list)
> > +             list_for_each_entry(event, &pmu->aliases, list)
> >                       len++;
> >               if (pmu->selectable)
> >                       len++;
> > @@ -1715,32 +1683,15 @@ void print_pmu_events(const char *event_glob, b=
ool name_only, bool quiet_flag,
> >       pmu =3D NULL;
> >       j =3D 0;
> >       while ((pmu =3D perf_pmu__scan(pmu)) !=3D NULL) {
> > -             bool is_cpu;
> > +             bool is_cpu =3D is_pmu_core(pmu->name) || perf_pmu__is_hy=
brid(pmu->name);
> >
> > -             if (pmu_name && pmu->name && strcmp(pmu_name, pmu->name))
> > -                     continue;
> > -
> > -             is_cpu =3D is_pmu_core(pmu->name) || perf_pmu__is_hybrid(=
pmu->name);
> > -
> > -             list_for_each_entry(alias, &pmu->aliases, list) {
> > -                     if (alias->deprecated && !deprecated)
> > -                             continue;
> > -
> > -                     if (event_glob !=3D NULL &&
> > -                         !(strglobmatch_nocase(alias->name, event_glob=
) ||
> > -                           (!is_cpu &&
> > -                            strglobmatch_nocase(alias->name, event_glo=
b)) ||
> > -                           (alias->topic &&
> > -                            strglobmatch_nocase(alias->topic, event_gl=
ob))))
> > -                             continue;
> > -
> > -                     aliases[j].event =3D alias;
> > +             list_for_each_entry(event, &pmu->aliases, list) {
> > +                     aliases[j].event =3D event;
> >                       aliases[j].pmu =3D pmu;
> >                       aliases[j].is_cpu =3D is_cpu;
> >                       j++;
> >               }
> > -             if (pmu->selectable &&
> > -                 (event_glob =3D=3D NULL || strglobmatch(pmu->name, ev=
ent_glob))) {
> > +             if (pmu->selectable) {
> >                       aliases[j].event =3D NULL;
> >                       aliases[j].pmu =3D pmu;
> >                       aliases[j].is_cpu =3D is_cpu;
> > @@ -1750,7 +1701,12 @@ void print_pmu_events(const char *event_glob, bo=
ol name_only, bool quiet_flag,
> >       len =3D j;
> >       qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
> >       for (j =3D 0; j < len; j++) {
> > -             char *name, *desc;
> > +             const char *name, *alias =3D NULL, *scale_unit =3D NULL,
> > +                     *desc =3D NULL, *long_desc =3D NULL,
> > +                     *encoding_desc =3D NULL, *topic =3D NULL,
> > +                     *metric_name =3D NULL, *metric_expr =3D NULL;
> > +             bool deprecated =3D false;
> > +             size_t buf_used;
> >
> >               /* Skip duplicates */
> >               if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases=
[j - 1]))
> > @@ -1758,48 +1714,51 @@ void print_pmu_events(const char *event_glob, b=
ool name_only, bool quiet_flag,
> >
> >               if (!aliases[j].event) {
> >                       /* A selectable event. */
> > -                     snprintf(buf, sizeof(buf), "%s//", aliases[j].pmu=
->name);
> > +                     buf_used =3D snprintf(buf, sizeof(buf), "%s//", a=
liases[j].pmu->name) + 1;
> >                       name =3D buf;
> > -             } else if (aliases[j].event->desc) {
> > -                     name =3D aliases[j].event->name;
> >               } else {
> > -                     if (!name_only && aliases[j].is_cpu) {
> > -                             name =3D format_alias_or(buf, sizeof(buf)=
, aliases[j].pmu,
> > -                                                    aliases[j].event);
> > +                     if (aliases[j].event->desc) {
> > +                             name =3D aliases[j].event->name;
> > +                             buf_used =3D 0;
> >                       } else {
> >                               name =3D format_alias(buf, sizeof(buf), a=
liases[j].pmu,
> >                                                   aliases[j].event);
> > +                             if (aliases[j].is_cpu) {
> > +                                     alias =3D name;
> > +                                     name =3D aliases[j].event->name;
> > +                             }
> > +                             buf_used =3D strlen(buf) + 1;
> >                       }
> > -             }
> > -             if (name_only) {
> > -                     printf("%s ", name);
> > -                     continue;
> > -             }
> > -             printed++;
> > -             if (!aliases[j].event || !aliases[j].event->desc || quiet=
_flag) {
> > -                     printf("  %-50s [Kernel PMU event]\n", name);
> > -                     continue;
> > -             }
> > -             if (numdesc++ =3D=3D 0)
> > -                     printf("\n");
> > -             if (aliases[j].event->topic && (!topic ||
> > -                                             strcmp(topic, aliases[j].=
event->topic))) {
> > -                     printf("%s%s:\n", topic ? "\n" : "", aliases[j].e=
vent->topic);
> > +                     if (strlen(aliases[j].event->unit) || aliases[j].=
event->scale !=3D 1.0) {
> > +                             scale_unit =3D buf + buf_used;
> > +                             buf_used +=3D snprintf(buf + buf_used, si=
zeof(buf) - buf_used,
> > +                                             "%G%s", aliases[j].event-=
>scale,
> > +                                             aliases[j].event->unit) +=
 1;
> > +                     }
> > +                     desc =3D aliases[j].event->desc;
> > +                     long_desc =3D aliases[j].event->long_desc;
> >                       topic =3D aliases[j].event->topic;
> > +                     encoding_desc =3D buf + buf_used;
> > +                     buf_used +=3D snprintf(buf + buf_used, sizeof(buf=
) - buf_used,
> > +                                     "%s/%s/", aliases[j].pmu->name,
> > +                                     aliases[j].event->str) + 1;
> > +                     metric_name =3D aliases[j].event->metric_name;
> > +                     metric_expr =3D aliases[j].event->metric_expr;
> > +                     deprecated =3D aliases[j].event->deprecated;
> >               }
> > -             printf("  %-50s\n", name);
> > -             printf("%*s", 8, "[");
> > -             desc =3D long_desc ? aliases[j].event->long_desc : aliase=
s[j].event->desc;
> > -             wordwrap(desc, 8, columns, 0);
> > -             printf("]\n");
> > -             if (details_flag) {
> > -                     printf("%*s%s/%s/ ", 8, "", aliases[j].pmu->name,=
 aliases[j].event->str);
> > -                     if (aliases[j].event->metric_name)
> > -                             printf(" MetricName: %s", aliases[j].even=
t->metric_name);
> > -                     if (aliases[j].event->metric_expr)
> > -                             printf(" MetricExpr: %s", aliases[j].even=
t->metric_expr);
> > -                     putchar('\n');
> > -             }
> > +             print_cb->print_event(print_state,
> > +                             aliases[j].pmu->name,
> > +                             topic,
> > +                             name,
> > +                             alias,
> > +                             scale_unit,
> > +                             deprecated,
> > +                             "Kernel PMU event",
> > +                             desc,
> > +                             long_desc,
> > +                             encoding_desc,
> > +                             metric_name,
> > +                             metric_expr);
> >       }
> >       if (printed && pager_in_use())
> >               printf("\n");
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index ee02e1ef9187..69ca0004f94f 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -12,6 +12,7 @@
> >
> >  struct evsel_config_term;
> >  struct perf_cpu_map;
> > +struct print_callbacks;
> >
> >  enum {
> >       PERF_PMU_FORMAT_VALUE_CONFIG,
> > @@ -225,9 +226,7 @@ void perf_pmu__del_formats(struct list_head *format=
s);
> >  struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
> >
> >  bool is_pmu_core(const char *name);
> > -void print_pmu_events(const char *event_glob, bool name_only, bool qui=
et,
> > -                   bool long_desc, bool details_flag,
> > -                   bool deprecated, const char *pmu_name);
> > +void print_pmu_events(const struct print_callbacks *print_cb, void *pr=
int_state);
> >  bool pmu_have_event(const char *pname, const char *name);
> >
> >  int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const =
char *fmt, ...) __scanf(3, 4);
> > diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-eve=
nts.c
> > index d53dba033597..5210a168d54f 100644
> > --- a/tools/perf/util/print-events.c
> > +++ b/tools/perf/util/print-events.c
> > @@ -28,6 +28,7 @@
> >
> >  #define MAX_NAME_LEN 100
> >
> > +/** Strings corresponding to enum perf_type_id. */
> >  static const char * const event_type_descriptors[] =3D {
> >       "Hardware event",
> >       "Software event",
> > @@ -55,11 +56,9 @@ static const struct event_symbol event_symbols_tool[=
PERF_TOOL_MAX] =3D {
> >  /*
> >   * Print the events from <debugfs_mount_point>/tracing/events
> >   */
> > -void print_tracepoint_events(const char *subsys_glob,
> > -                          const char *event_glob, bool name_only)
> > +void print_tracepoint_events(const struct print_callbacks *print_cb, v=
oid *print_state)
> >  {
> >       struct dirent **sys_namelist =3D NULL;
> > -     bool printed =3D false;
> >       int sys_items =3D tracing_events__scandir_alphasort(&sys_namelist=
);
> >
> >       for (int i =3D 0; i < sys_items; i++) {
> > @@ -73,10 +72,6 @@ void print_tracepoint_events(const char *subsys_glob=
,
> >                   !strcmp(sys_dirent->d_name, ".."))
> >                       continue;
> >
> > -             if (subsys_glob !=3D NULL &&
> > -                 !strglobmatch(sys_dirent->d_name, subsys_glob))
> > -                     continue;
> > -
> >               dir_path =3D get_events_file(sys_dirent->d_name);
> >               if (!dir_path)
> >                       continue;
> > @@ -94,41 +89,41 @@ void print_tracepoint_events(const char *subsys_glo=
b,
> >                       if (tp_event_has_id(dir_path, evt_dirent) !=3D 0)
> >                               continue;
> >
> > -                     if (event_glob !=3D NULL &&
> > -                         !strglobmatch(evt_dirent->d_name, event_glob)=
)
> > -                             continue;
> > -
> >                       snprintf(evt_path, MAXPATHLEN, "%s:%s",
> >                                sys_dirent->d_name, evt_dirent->d_name);
> > -                     if (name_only)
> > -                             printf("%s ", evt_path);
> > -                     else {
> > -                             printf("  %-50s [%s]\n", evt_path,
> > -                                    event_type_descriptors[PERF_TYPE_T=
RACEPOINT]);
> > -                     }
> > -                     printed =3D true;
> > +                     print_cb->print_event(print_state,
> > +                                     /*topic=3D*/NULL,
> > +                                     /*pmu_name=3D*/NULL,
> > +                                     evt_path,
> > +                                     /*event_alias=3D*/NULL,
> > +                                     /*scale_unit=3D*/NULL,
> > +                                     /*deprecated=3D*/false,
> > +                                     "Tracepoint event",
> > +                                     /*desc=3D*/NULL,
> > +                                     /*long_desc=3D*/NULL,
> > +                                     /*encoding_desc=3D*/NULL,
> > +                                     /*metric_name=3D*/NULL,
> > +                                     /*metric_expr=3D*/NULL);
> >               }
> >               free(dir_path);
> >               free(evt_namelist);
> >       }
> >       free(sys_namelist);
> > -     if (printed && pager_in_use())
> > -             printf("\n");
> >  }
> >
> > -void print_sdt_events(const char *subsys_glob, const char *event_glob,
> > -                   bool name_only)
> > +void print_sdt_events(const struct print_callbacks *print_cb, void *pr=
int_state)
> >  {
> > -     struct probe_cache *pcache;
> > -     struct probe_cache_entry *ent;
> >       struct strlist *bidlist, *sdtlist;
> > -     struct strlist_config cfg =3D {.dont_dupstr =3D true};
> > -     struct str_node *nd, *nd2;
> > -     char *buf, *path, *ptr =3D NULL;
> > -     bool show_detail =3D false;
> > -     int ret;
> > -
> > -     sdtlist =3D strlist__new(NULL, &cfg);
> > +     struct str_node *bid_nd, *sdt_name, *next_sdt_name;
> > +     const char *last_sdt_name =3D NULL;
> > +
> > +     /*
> > +      * The implicitly sorted sdtlist will hold the tracepoint name fo=
llowed
> > +      * by @<buildid>. If the tracepoint name is unique (determined by
> > +      * looking at the adjacent nodes) the @<buildid> is dropped other=
wise
> > +      * the executable path and buildid are added to the name.
> > +      */
> > +     sdtlist =3D strlist__new(NULL, NULL);
> >       if (!sdtlist) {
> >               pr_debug("Failed to allocate new strlist for SDT\n");
> >               return;
> > @@ -138,65 +133,77 @@ void print_sdt_events(const char *subsys_glob, co=
nst char *event_glob,
> >               pr_debug("Failed to get buildids: %d\n", errno);
> >               return;
> >       }
> > -     strlist__for_each_entry(nd, bidlist) {
> > -             pcache =3D probe_cache__new(nd->s, NULL);
> > +     strlist__for_each_entry(bid_nd, bidlist) {
> > +             struct probe_cache *pcache;
> > +             struct probe_cache_entry *ent;
> > +
> > +             pcache =3D probe_cache__new(bid_nd->s, NULL);
> >               if (!pcache)
> >                       continue;
> >               list_for_each_entry(ent, &pcache->entries, node) {
> > -                     if (!ent->sdt)
> > -                             continue;
> > -                     if (subsys_glob &&
> > -                         !strglobmatch(ent->pev.group, subsys_glob))
> > -                             continue;
> > -                     if (event_glob &&
> > -                         !strglobmatch(ent->pev.event, event_glob))
> > -                             continue;
> > -                     ret =3D asprintf(&buf, "%s:%s@%s", ent->pev.group=
,
> > -                                     ent->pev.event, nd->s);
> > -                     if (ret > 0)
> > -                             strlist__add(sdtlist, buf);
> > +                     char buf[1024];
> > +
> > +                     snprintf(buf, sizeof(buf), "%s:%s@%s",
> > +                              ent->pev.group, ent->pev.event, bid_nd->=
s);
> > +                     strlist__add(sdtlist, buf);
> >               }
> >               probe_cache__delete(pcache);
> >       }
> >       strlist__delete(bidlist);
> >
> > -     strlist__for_each_entry(nd, sdtlist) {
> > -             buf =3D strchr(nd->s, '@');
> > -             if (buf)
> > -                     *(buf++) =3D '\0';
> > -             if (name_only) {
> > -                     printf("%s ", nd->s);
> > -                     continue;
> > -             }
> > -             nd2 =3D strlist__next(nd);
> > -             if (nd2) {
> > -                     ptr =3D strchr(nd2->s, '@');
> > -                     if (ptr)
> > -                             *ptr =3D '\0';
> > -                     if (strcmp(nd->s, nd2->s) =3D=3D 0)
> > -                             show_detail =3D true;
> > +     strlist__for_each_entry(sdt_name, sdtlist) {
> > +             bool show_detail =3D false;
> > +             char *bid =3D strchr(sdt_name->s, '@');
> > +             char *evt_name =3D NULL;
> > +
> > +             if (bid)
> > +                     *(bid++) =3D '\0';
> > +
> > +             if (last_sdt_name && !strcmp(last_sdt_name, sdt_name->s))=
 {
> > +                     show_detail =3D true;
> > +             } else {
> > +                     next_sdt_name =3D strlist__next(sdt_name);
> > +                     if (next_sdt_name) {
> > +                             char *bid2 =3D strchr(next_sdt_name->s, '=
@');
> > +
> > +                             if (bid2)
> > +                                     *bid2 =3D '\0';
> > +                             if (strcmp(sdt_name->s, next_sdt_name->s)=
 =3D=3D 0)
> > +                                     show_detail =3D true;
> > +                             if (bid2)
> > +                                     *bid2 =3D '@';
> > +                     }
> >               }
> > +             last_sdt_name =3D sdt_name->s;
> > +
> >               if (show_detail) {
> > -                     path =3D build_id_cache__origname(buf);
> > -                     ret =3D asprintf(&buf, "%s@%s(%.12s)", nd->s, pat=
h, buf);
> > -                     if (ret > 0) {
> > -                             printf("  %-50s [%s]\n", buf, "SDT event"=
);
> > -                             free(buf);
> > +                     char *path =3D build_id_cache__origname(bid);
> > +
> > +                     if (path) {
> > +                             asprintf(&evt_name, "%s@%s(%.12s)", sdt_n=
ame->s, path, bid);
> > +                             free(path);
> >                       }
> > -                     free(path);
> > -             } else
> > -                     printf("  %-50s [%s]\n", nd->s, "SDT event");
> > -             if (nd2) {
> > -                     if (strcmp(nd->s, nd2->s) !=3D 0)
> > -                             show_detail =3D false;
> > -                     if (ptr)
> > -                             *ptr =3D '@';
> >               }
> > +             print_cb->print_event(print_state,
> > +                             /*topic=3D*/NULL,
> > +                             /*pmu_name=3D*/NULL,
> > +                             evt_name ?: sdt_name->s,
> > +                             /*event_alias=3D*/NULL,
> > +                             /*deprecated=3D*/false,
> > +                             /*scale_unit=3D*/NULL,
> > +                             "SDT event",
> > +                             /*desc=3D*/NULL,
> > +                             /*long_desc=3D*/NULL,
> > +                             /*encoding_desc=3D*/NULL,
> > +                             /*metric_name=3D*/NULL,
> > +                             /*metric_expr=3D*/NULL);
> > +
> > +             free(evt_name);
> >       }
> >       strlist__delete(sdtlist);
> >  }
> >
> > -int print_hwcache_events(const char *event_glob, bool name_only)
> > +int print_hwcache_events(const struct print_callbacks *print_cb, void =
*print_state)
> >  {
> >       struct strlist *evt_name_list =3D strlist__new(NULL, NULL);
> >       struct str_node *nd;
> > @@ -216,9 +223,6 @@ int print_hwcache_events(const char *event_glob, bo=
ol name_only)
> >                               char name[64];
> >
> >                               __evsel__hw_cache_type_op_res_name(type, =
op, i, name, sizeof(name));
> > -                             if (event_glob !=3D NULL && !strglobmatch=
(name, event_glob))
> > -                                     continue;
> > -
> >                               if (!perf_pmu__has_hybrid()) {
> >                                       if (is_event_supported(PERF_TYPE_=
HW_CACHE,
> >                                                              type | (op=
 << 8) | (i << 16)))
> > @@ -240,55 +244,47 @@ int print_hwcache_events(const char *event_glob, =
bool name_only)
> >       }
> >
> >       strlist__for_each_entry(nd, evt_name_list) {
> > -             if (name_only) {
> > -                     printf("%s ", nd->s);
> > -                     continue;
> > -             }
> > -             printf("  %-50s [%s]\n", nd->s, event_type_descriptors[PE=
RF_TYPE_HW_CACHE]);
> > +             print_cb->print_event(print_state,
> > +                             "cache",
> > +                             /*pmu_name=3D*/NULL,
> > +                             nd->s,
> > +                             /*event_alias=3D*/NULL,
> > +                             /*scale_unit=3D*/NULL,
> > +                             /*deprecated=3D*/false,
> > +                             event_type_descriptors[PERF_TYPE_HW_CACHE=
],
> > +                             /*desc=3D*/NULL,
> > +                             /*long_desc=3D*/NULL,
> > +                             /*encoding_desc=3D*/NULL,
> > +                             /*metric_name=3D*/NULL,
> > +                             /*metric_expr=3D*/NULL);
> >       }
> > -     if (!strlist__empty(evt_name_list) && pager_in_use())
> > -             printf("\n");
> > -
> >       strlist__delete(evt_name_list);
> >       return 0;
> >  }
> >
> > -static void print_tool_event(const struct event_symbol *syms, const ch=
ar *event_glob,
> > -                          bool name_only)
> > -{
> > -     if (syms->symbol =3D=3D NULL)
> > -             return;
> > -
> > -     if (event_glob && !(strglobmatch(syms->symbol, event_glob) ||
> > -           (syms->alias && strglobmatch(syms->alias, event_glob))))
> > -             return;
> > -
> > -     if (name_only)
> > -             printf("%s ", syms->symbol);
> > -     else {
> > -             char name[MAX_NAME_LEN];
> > -
> > -             if (syms->alias && strlen(syms->alias))
> > -                     snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->sy=
mbol, syms->alias);
> > -             else
> > -                     strlcpy(name, syms->symbol, MAX_NAME_LEN);
> > -             printf("  %-50s [%s]\n", name, "Tool event");
> > -     }
> > -}
> > -
> > -void print_tool_events(const char *event_glob, bool name_only)
> > +void print_tool_events(const struct print_callbacks *print_cb, void *p=
rint_state)
> >  {
> >       // Start at 1 because the first enum entry means no tool event.
> > -     for (int i =3D 1; i < PERF_TOOL_MAX; ++i)
> > -             print_tool_event(event_symbols_tool + i, event_glob, name=
_only);
> > -
> > -     if (pager_in_use())
> > -             printf("\n");
> > +     for (int i =3D 1; i < PERF_TOOL_MAX; ++i) {
> > +             print_cb->print_event(print_state,
> > +                             "tool",
> > +                             /*pmu_name=3D*/NULL,
> > +                             event_symbols_tool[i].symbol,
> > +                             event_symbols_tool[i].alias,
> > +                             /*scale_unit=3D*/NULL,
> > +                             /*deprecated=3D*/false,
> > +                             "Tool event",
> > +                             /*desc=3D*/NULL,
> > +                             /*long_desc=3D*/NULL,
> > +                             /*encoding_desc=3D*/NULL,
> > +                             /*metric_name=3D*/NULL,
> > +                             /*metric_expr=3D*/NULL);
> > +     }
> >  }
> >
> > -void print_symbol_events(const char *event_glob, unsigned int type,
> > -                      struct event_symbol *syms, unsigned int max,
> > -                      bool name_only)
> > +void print_symbol_events(const struct print_callbacks *print_cb, void =
*print_state,
> > +                      unsigned int type, const struct event_symbol *sy=
ms,
> > +                      unsigned int max)
> >  {
> >       struct strlist *evt_name_list =3D strlist__new(NULL, NULL);
> >       struct str_node *nd;
> > @@ -305,10 +301,6 @@ void print_symbol_events(const char *event_glob, u=
nsigned int type,
> >               if (syms[i].symbol =3D=3D NULL)
> >                       continue;
> >
> > -             if (event_glob !=3D NULL && !(strglobmatch(syms[i].symbol=
, event_glob) ||
> > -                   (syms[i].alias && strglobmatch(syms[i].alias, event=
_glob))))
> > -                     continue;
> > -
> >               if (!is_event_supported(type, i))
> >                       continue;
> >
> > @@ -322,63 +314,92 @@ void print_symbol_events(const char *event_glob, =
unsigned int type,
> >       }
> >
> >       strlist__for_each_entry(nd, evt_name_list) {
> > -             if (name_only) {
> > -                     printf("%s ", nd->s);
> > -                     continue;
> > +             char *alias =3D strstr(nd->s, " OR ");
> > +
> > +             if (alias) {
> > +                     *alias =3D '\0';
> > +                     alias +=3D 4;
> >               }
> > -             printf("  %-50s [%s]\n", nd->s, event_type_descriptors[ty=
pe]);
> > +             print_cb->print_event(print_state,
> > +                             /*topic=3D*/NULL,
> > +                             /*pmu_name=3D*/NULL,
> > +                             nd->s,
> > +                             alias,
> > +                             /*scale_unit=3D*/NULL,
> > +                             /*deprecated=3D*/false,
> > +                             event_type_descriptors[type],
> > +                             /*desc=3D*/NULL,
> > +                             /*long_desc=3D*/NULL,
> > +                             /*encoding_desc=3D*/NULL,
> > +                             /*metric_name=3D*/NULL,
> > +                             /*metric_expr=3D*/NULL);
> >       }
> > -     if (!strlist__empty(evt_name_list) && pager_in_use())
> > -             printf("\n");
> > -
> >       strlist__delete(evt_name_list);
> >  }
> >
> >  /*
> >   * Print the help text for the event symbols:
> >   */
> > -void print_events(const char *event_glob, bool name_only, bool quiet_f=
lag,
> > -                     bool long_desc, bool details_flag, bool deprecate=
d,
> > -                     const char *pmu_name)
> > +void print_events(const struct print_callbacks *print_cb, void *print_=
state)
> >  {
> > -     print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
> > -                         event_symbols_hw, PERF_COUNT_HW_MAX, name_onl=
y);
> > -
> > -     print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
> > -                         event_symbols_sw, PERF_COUNT_SW_MAX, name_onl=
y);
> > -     print_tool_events(event_glob, name_only);
> > -
> > -     print_hwcache_events(event_glob, name_only);
> > -
> > -     print_pmu_events(event_glob, name_only, quiet_flag, long_desc,
> > -                     details_flag, deprecated, pmu_name);
> > -
> > -     if (event_glob !=3D NULL)
> > -             return;
> > -
> > -     if (!name_only) {
> > -             printf("  %-50s [%s]\n",
> > -                    "rNNN",
> > -                    event_type_descriptors[PERF_TYPE_RAW]);
> > -             printf("  %-50s [%s]\n",
> > -                    "cpu/t1=3Dv1[,t2=3Dv2,t3 ...]/modifier",
> > -                    event_type_descriptors[PERF_TYPE_RAW]);
> > -             if (pager_in_use())
> > -                     printf("   (see 'man perf-list' on how to encode =
it)\n\n");
> > -
> > -             printf("  %-50s [%s]\n",
> > -                    "mem:<addr>[/len][:access]",
> > -                     event_type_descriptors[PERF_TYPE_BREAKPOINT]);
> > -             if (pager_in_use())
> > -                     printf("\n");
> > -     }
> > -
> > -     print_tracepoint_events(NULL, NULL, name_only);
> > -
> > -     print_sdt_events(NULL, NULL, name_only);
> > -
> > -     metricgroup__print(true, true, NULL, name_only, details_flag,
> > -                        pmu_name);
> > -
> > -     print_libpfm_events(name_only, long_desc);
> > +     print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
> > +                     event_symbols_hw, PERF_COUNT_HW_MAX);
> > +     print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
> > +                     event_symbols_sw, PERF_COUNT_SW_MAX);
> > +
> > +     print_tool_events(print_cb, print_state);
> > +
> > +     print_hwcache_events(print_cb, print_state);
> > +
> > +     print_pmu_events(print_cb, print_state);
> > +
> > +     print_cb->print_event(print_state,
> > +                     /*topic=3D*/NULL,
> > +                     /*pmu_name=3D*/NULL,
> > +                     "rNNN",
> > +                     /*event_alias=3D*/NULL,
> > +                     /*scale_unit=3D*/NULL,
> > +                     /*deprecated=3D*/false,
> > +                     event_type_descriptors[PERF_TYPE_RAW],
> > +                     /*desc=3D*/NULL,
> > +                     /*long_desc=3D*/NULL,
> > +                     /*encoding_desc=3D*/NULL,
> > +                     /*metric_name=3D*/NULL,
> > +                     /*metric_expr=3D*/NULL);
> > +
> > +     print_cb->print_event(print_state,
> > +                     /*topic=3D*/NULL,
> > +                     /*pmu_name=3D*/NULL,
> > +                     "cpu/t1=3Dv1[,t2=3Dv2,t3 ...]/modifier",
> > +                     /*event_alias=3D*/NULL,
> > +                     /*scale_unit=3D*/NULL,
> > +                     /*deprecated=3D*/false,
> > +                     event_type_descriptors[PERF_TYPE_RAW],
> > +                     "(see 'man perf-list' on how to encode it)",
> > +                     /*long_desc=3D*/NULL,
> > +                     /*encoding_desc=3D*/NULL,
> > +                     /*metric_name=3D*/NULL,
> > +                     /*metric_expr=3D*/NULL);
> > +
> > +     print_cb->print_event(print_state,
> > +                     /*topic=3D*/NULL,
> > +                     /*pmu_name=3D*/NULL,
> > +                     "mem:<addr>[/len][:access]",
> > +                     /*scale_unit=3D*/NULL,
> > +                     /*event_alias=3D*/NULL,
> > +                     /*deprecated=3D*/false,
> > +                     event_type_descriptors[PERF_TYPE_BREAKPOINT],
> > +                     /*desc=3D*/NULL,
> > +                     /*long_desc=3D*/NULL,
> > +                     /*encoding_desc=3D*/NULL,
> > +                     /*metric_name=3D*/NULL,
> > +                     /*metric_expr=3D*/NULL);
> > +
> > +     print_tracepoint_events(print_cb, print_state);
> > +
> > +     print_sdt_events(print_cb, print_state);
> > +
> > +     metricgroup__print(print_cb, print_state);
> > +
> > +     print_libpfm_events(print_cb, print_state);
> >  }
> > diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-eve=
nts.h
> > index 1da9910d83a6..c237e53c4487 100644
> > --- a/tools/perf/util/print-events.h
> > +++ b/tools/perf/util/print-events.h
> > @@ -2,21 +2,39 @@
> >  #ifndef __PERF_PRINT_EVENTS_H
> >  #define __PERF_PRINT_EVENTS_H
> >
> > +#include <linux/perf_event.h>
> >  #include <stdbool.h>
> >
> >  struct event_symbol;
> >
> > -void print_events(const char *event_glob, bool name_only, bool quiet_f=
lag,
> > -               bool long_desc, bool details_flag, bool deprecated,
> > -               const char *pmu_name);
> > -int print_hwcache_events(const char *event_glob, bool name_only);
> > -void print_sdt_events(const char *subsys_glob, const char *event_glob,
> > -                   bool name_only);
> > -void print_symbol_events(const char *event_glob, unsigned int type,
> > -                      struct event_symbol *syms, unsigned int max,
> > -                      bool name_only);
> > -void print_tool_events(const char *event_glob, bool name_only);
> > -void print_tracepoint_events(const char *subsys_glob, const char *even=
t_glob,
> > -                          bool name_only);
> > +struct print_callbacks {
> > +     void (*print_start)(void *print_state);
> > +     void (*print_end)(void *print_state);
> > +     void (*print_event)(void *print_state, const char *topic,
> > +                     const char *pmu_name,
> > +                     const char *event_name, const char *event_alias,
> > +                     const char *scale_unit,
> > +                     bool deprecated, const char *event_type_desc,
> > +                     const char *desc, const char *long_desc,
> > +                     const char *encoding_desc,
> > +                     const char *metric_name, const char *metric_expr)=
;
> > +     void (*print_metric)(void *print_state,
> > +                     const char *group,
> > +                     const char *name,
> > +                     const char *desc,
> > +                     const char *long_desc,
> > +                     const char *expr,
> > +                     const char *unit);
> > +};
> > +
> > +/** Print all events, the default when no options are specified. */
> > +void print_events(const struct print_callbacks *print_cb, void *print_=
state);
> > +int print_hwcache_events(const struct print_callbacks *print_cb, void =
*print_state);
> > +void print_sdt_events(const struct print_callbacks *print_cb, void *pr=
int_state);
> > +void print_symbol_events(const struct print_callbacks *print_cb, void =
*print_state,
> > +                      unsigned int type, const struct event_symbol *sy=
ms,
> > +                      unsigned int max);
> > +void print_tool_events(const struct print_callbacks *print_cb, void *p=
rint_state);
> > +void print_tracepoint_events(const struct print_callbacks *print_cb, v=
oid *print_state);
> >
> >  #endif /* __PERF_PRINT_EVENTS_H */
> > --
> > 2.38.1.431.g37b22c650d-goog
>
> --
>
> - Arnaldo
