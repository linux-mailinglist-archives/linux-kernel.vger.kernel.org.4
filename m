Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2108D6C1D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjCTRHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjCTRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:07:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754AC38036
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:01:29 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3e292a249b6so123871cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679331623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhdWsx+uSxYC6rEEfsBJjByPa1hBOm14dxdTbSxdwaQ=;
        b=NPQYWd8CEHuvTS+aqQZrOjyCkM41SRfK3DFs8dDH5xhTeMDaartbax0LWpUpMMSaI1
         /BnmYP3IJi6iCH72iCXDKgOuMZLYH5M+wYS4BwkDazGQlSRswEN/gHocKaZv+8ikNW0v
         2B60sYL7Z4XujjOvrjW3EkvzerxRRPiluaPN1/lF095ozEU778eYutIOITeHfZD3Zf/E
         Sat0pp0+GJWWw0XyCynCPzuyv60N4jEVhwS2fxS0QVGVkNANBBetZ3ZnT8oqIP1ieL7S
         XsN4mTQrvMYq8WfTqGBtsZaWJ+Ex1QhQHU9YkeK/cs0kjq2NpslcV+g8RygE19XJ8u6S
         hZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhdWsx+uSxYC6rEEfsBJjByPa1hBOm14dxdTbSxdwaQ=;
        b=eq+sDIVuUiYIvdbRdHCmsi5CYKK354352tRZolIBc0X9OrsS4T0srfkJHKSo1rBImM
         rUGFB94uVvdeVG6JRaVERY3BIPYeD+Ti3VhpEUKYvmpPADNEOU0OR6y2dMGPllcxCGck
         2bVPgO0DckMlSLvOp6Ujh3P2P3+t+kTu3dUeIawiMeOvbKAsTXtuEsBR8YPyeZ6w9dP3
         P/rfskRyMBGvXkTfr4YcMAeCkp69KCs3k6fXGyagQb3mvFqcZ1n9tkYpexRcf2d62sQZ
         /d2sngtuXzLy4ksYGUOmLAZfEQu/iiSwZdPQbzezrKYHlChfb8VW46fFm3Mjs7gME/gd
         dhZg==
X-Gm-Message-State: AO0yUKVudNcF+KsfV4l7QKHVwwCBU7GbBDyqNoKUykr7DF5Tn/4v9707
        MjkV5BvQOBQ71egf9rryOQ37ftN5vCT8ALw3IRdICA==
X-Google-Smtp-Source: AK7set8iDpET8GS8/X8LPHezAoNAxltPa9oQIVilei1U19seuTT9YDgGdxzWBj0pwoa4W4Ym5pjFym2SMzcUdjX9x3Y=
X-Received: by 2002:a05:622a:164a:b0:3ab:6af8:4182 with SMTP id
 y10-20020a05622a164a00b003ab6af84182mr745034qtj.3.1679331622871; Mon, 20 Mar
 2023 10:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com> <20230320033810.980165-18-irogers@google.com>
 <32654889-2e76-1a09-acef-e9b4378f855f@intel.com>
In-Reply-To: <32654889-2e76-1a09-acef-e9b4378f855f@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 10:00:11 -0700
Message-ID: <CAP-5=fWHDZOCgmm7x+Lcgh6Gx+5orSGaDs7XmeL6hxTL8Kwx5A@mail.gmail.com>
Subject: Re: [PATCH v4 17/22] perf map: Changes to reference counting
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
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

On Mon, Mar 20, 2023 at 4:19=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 20/03/23 05:38, Ian Rogers wrote:
> > When a pointer to a map exists do a get, when that pointer is
> > overwritten or freed, put the map. This avoids issues with gets and
> > puts being inconsistently used causing, use after puts, etc. For
> > example, the map in struct addr_location is changed to hold a
> > reference count.
>
> I am not sure I understand the reason for that.  A thread's address
> mappings are inherently transitory with respect to perf (MMAP) event
> processing.  Holding on to a reference to a thread's map is not a
> valid thing to do if more perf events can be processed in the meantime.
> Reference counting seems to hide the problem in that case, since
> the solution is: don't keep the reference.

Agreed. I think the code is complex enough that we just need to do
proper reference counting so that we don't get use after frees, etc.
I've tried to fix things here by only following what leak tracker is
telling me, rather than fully wholesale getting/putting.

> >                  Reference count checking and address sanitizer were
> > used to identify issues.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/code-reading.c       |  1 +
> >  tools/perf/tests/hists_cumulate.c     | 10 ++++
> >  tools/perf/tests/hists_filter.c       | 10 ++++
> >  tools/perf/tests/hists_link.c         | 18 +++++-
> >  tools/perf/tests/hists_output.c       | 10 ++++
> >  tools/perf/tests/mmap-thread-lookup.c |  1 +
> >  tools/perf/util/callchain.c           |  9 +--
> >  tools/perf/util/event.c               |  8 ++-
> >  tools/perf/util/hist.c                | 10 ++--
> >  tools/perf/util/machine.c             | 79 ++++++++++++++++-----------
> >  tools/perf/util/map.c                 |  2 +-
> >  11 files changed, 114 insertions(+), 44 deletions(-)
> >
> > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-re=
ading.c
> > index 1545fcaa95c6..efe026a35010 100644
> > --- a/tools/perf/tests/code-reading.c
> > +++ b/tools/perf/tests/code-reading.c
> > @@ -366,6 +366,7 @@ static int read_object_code(u64 addr, size_t len, u=
8 cpumode,
> >       }
> >       pr_debug("Bytes read match those read by objdump\n");
> >  out:
> > +     map__put(al.map);
>
> Given that it is 'al' that is going away, wouldn't it be
> more logical to have here:
>
>         addr_location__exit(&al);
>
> where:
>
> void addr_location__exit(struct addr_location *al)
> {
>         if (al->map) {
>                 map__put(al->map);
>                 al->map =3D NULL;
>         }
> }

I think making addr_location have an init, exit, etc. would be good.
There are some troublesome cases like struct hist_iter_ops where the
iteration function pass an addr_location. Wrt this patch series I
think we should try to land what's here and follow up. The biggest
issue the reference counting / address and leak sanitizer code is
pointing at is leaks with thread, so I'd prefer to follow up on that
first.

>
> >       return err;
> >  }
> >
> > diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists=
_cumulate.c
> > index f00ec9abdbcd..8c0e3f334747 100644
> > --- a/tools/perf/tests/hists_cumulate.c
> > +++ b/tools/perf/tests/hists_cumulate.c
> > @@ -112,6 +112,7 @@ static int add_hist_entries(struct hists *hists, st=
ruct machine *machine)
> >               }
> >
> >               fake_samples[i].thread =3D al.thread;
> > +             map__put(fake_samples[i].map);
> >               fake_samples[i].map =3D al.map;
> >               fake_samples[i].sym =3D al.sym;
> >       }
> > @@ -147,6 +148,14 @@ static void del_hist_entries(struct hists *hists)
> >       }
> >  }
> >
> > +static void put_fake_samples(void)
> > +{
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(fake_samples); i++)
> > +             map__put(fake_samples[i].map);
> > +}
> > +
> >  typedef int (*test_fn_t)(struct evsel *, struct machine *);
> >
> >  #define COMM(he)  (thread__comm_str(he->thread))
> > @@ -733,6 +742,7 @@ static int test__hists_cumulate(struct test_suite *=
test __maybe_unused, int subt
> >       /* tear down everything */
> >       evlist__delete(evlist);
> >       machines__exit(&machines);
> > +     put_fake_samples();
> >
> >       return err;
> >  }
> > diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_f=
ilter.c
> > index 7c552549f4a4..98eff5935a1c 100644
> > --- a/tools/perf/tests/hists_filter.c
> > +++ b/tools/perf/tests/hists_filter.c
> > @@ -89,6 +89,7 @@ static int add_hist_entries(struct evlist *evlist,
> >                       }
> >
> >                       fake_samples[i].thread =3D al.thread;
> > +                     map__put(fake_samples[i].map);
> >                       fake_samples[i].map =3D al.map;
> >                       fake_samples[i].sym =3D al.sym;
> >               }
> > @@ -101,6 +102,14 @@ static int add_hist_entries(struct evlist *evlist,
> >       return TEST_FAIL;
> >  }
> >
> > +static void put_fake_samples(void)
> > +{
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(fake_samples); i++)
> > +             map__put(fake_samples[i].map);
> > +}
> > +
> >  static int test__hists_filter(struct test_suite *test __maybe_unused, =
int subtest __maybe_unused)
> >  {
> >       int err =3D TEST_FAIL;
> > @@ -322,6 +331,7 @@ static int test__hists_filter(struct test_suite *te=
st __maybe_unused, int subtes
> >       evlist__delete(evlist);
> >       reset_output_field();
> >       machines__exit(&machines);
> > +     put_fake_samples();
> >
> >       return err;
> >  }
> > diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_lin=
k.c
> > index e7e4ee57ce04..64ce8097889c 100644
> > --- a/tools/perf/tests/hists_link.c
> > +++ b/tools/perf/tests/hists_link.c
> > @@ -6,6 +6,7 @@
> >  #include "evsel.h"
> >  #include "evlist.h"
> >  #include "machine.h"
> > +#include "map.h"
> >  #include "parse-events.h"
> >  #include "hists_common.h"
> >  #include "util/mmap.h"
> > @@ -94,6 +95,7 @@ static int add_hist_entries(struct evlist *evlist, st=
ruct machine *machine)
> >                       }
> >
> >                       fake_common_samples[k].thread =3D al.thread;
> > +                     map__put(fake_common_samples[k].map);
> >                       fake_common_samples[k].map =3D al.map;
> >                       fake_common_samples[k].sym =3D al.sym;
> >               }
> > @@ -126,11 +128,24 @@ static int add_hist_entries(struct evlist *evlist=
, struct machine *machine)
> >       return -1;
> >  }
> >
> > +static void put_fake_samples(void)
> > +{
> > +     size_t i, j;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(fake_common_samples); i++)
> > +             map__put(fake_common_samples[i].map);
> > +     for (i =3D 0; i < ARRAY_SIZE(fake_samples); i++) {
> > +             for (j =3D 0; j < ARRAY_SIZE(fake_samples[0]); j++)
> > +                     map__put(fake_samples[i][j].map);
> > +     }
> > +}
> > +
> >  static int find_sample(struct sample *samples, size_t nr_samples,
> >                      struct thread *t, struct map *m, struct symbol *s)
> >  {
> >       while (nr_samples--) {
> > -             if (samples->thread =3D=3D t && samples->map =3D=3D m &&
> > +             if (samples->thread =3D=3D t &&
> > +                 samples->map =3D=3D m &&
> >                   samples->sym =3D=3D s)
> >                       return 1;
> >               samples++;
> > @@ -336,6 +351,7 @@ static int test__hists_link(struct test_suite *test=
 __maybe_unused, int subtest
> >       evlist__delete(evlist);
> >       reset_output_field();
> >       machines__exit(&machines);
> > +     put_fake_samples();
> >
> >       return err;
> >  }
> > diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_o=
utput.c
> > index 428d11a938f2..cebd5226bb12 100644
> > --- a/tools/perf/tests/hists_output.c
> > +++ b/tools/perf/tests/hists_output.c
> > @@ -78,6 +78,7 @@ static int add_hist_entries(struct hists *hists, stru=
ct machine *machine)
> >               }
> >
> >               fake_samples[i].thread =3D al.thread;
> > +             map__put(fake_samples[i].map);
> >               fake_samples[i].map =3D al.map;
> >               fake_samples[i].sym =3D al.sym;
> >       }
> > @@ -113,6 +114,14 @@ static void del_hist_entries(struct hists *hists)
> >       }
> >  }
> >
> > +static void put_fake_samples(void)
> > +{
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(fake_samples); i++)
> > +             map__put(fake_samples[i].map);
> > +}
> > +
> >  typedef int (*test_fn_t)(struct evsel *, struct machine *);
> >
> >  #define COMM(he)  (thread__comm_str(he->thread))
> > @@ -620,6 +629,7 @@ static int test__hists_output(struct test_suite *te=
st __maybe_unused, int subtes
> >       /* tear down everything */
> >       evlist__delete(evlist);
> >       machines__exit(&machines);
> > +     put_fake_samples();
> >
> >       return err;
> >  }
> > diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/m=
map-thread-lookup.c
> > index 5cc4644e353d..898eda55b7a8 100644
> > --- a/tools/perf/tests/mmap-thread-lookup.c
> > +++ b/tools/perf/tests/mmap-thread-lookup.c
> > @@ -203,6 +203,7 @@ static int mmap_events(synth_cb synth)
> >               }
> >
> >               pr_debug("map %p, addr %" PRIx64 "\n", al.map, map__start=
(al.map));
> > +             map__put(al.map);
> >       }
> >
> >       machine__delete_threads(machine);
> > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > index 9e9c39dd9d2b..78dc7b6f7ff7 100644
> > --- a/tools/perf/util/callchain.c
> > +++ b/tools/perf/util/callchain.c
> > @@ -589,7 +589,7 @@ fill_node(struct callchain_node *node, struct callc=
hain_cursor *cursor)
> >               }
> >               call->ip =3D cursor_node->ip;
> >               call->ms =3D cursor_node->ms;
> > -             map__get(call->ms.map);
> > +             call->ms.map =3D map__get(call->ms.map);
> >               call->srcline =3D cursor_node->srcline;
> >
> >               if (cursor_node->branch) {
> > @@ -1067,7 +1067,7 @@ int callchain_cursor_append(struct callchain_curs=
or *cursor,
> >       node->ip =3D ip;
> >       map__zput(node->ms.map);
> >       node->ms =3D *ms;
> > -     map__get(node->ms.map);
> > +     node->ms.map =3D map__get(node->ms.map);
> >       node->branch =3D branch;
> >       node->nr_loop_iter =3D nr_loop_iter;
> >       node->iter_cycles =3D iter_cycles;
> > @@ -1115,7 +1115,8 @@ int fill_callchain_info(struct addr_location *al,=
 struct callchain_cursor_node *
> >       struct machine *machine =3D maps__machine(node->ms.maps);
> >
> >       al->maps =3D node->ms.maps;
> > -     al->map =3D node->ms.map;
> > +     map__put(al->map);
> > +     al->map =3D map__get(node->ms.map);
> >       al->sym =3D node->ms.sym;
> >       al->srcline =3D node->srcline;
> >       al->addr =3D node->ip;
> > @@ -1528,7 +1529,7 @@ int callchain_node__make_parent_list(struct callc=
hain_node *node)
> >                               goto out;
> >                       *new =3D *chain;
> >                       new->has_children =3D false;
> > -                     map__get(new->ms.map);
> > +                     new->ms.map =3D map__get(new->ms.map);
> >                       list_add_tail(&new->list, &head);
> >               }
> >               parent =3D parent->parent;
> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > index 2712d1a8264e..8293c8a3406b 100644
> > --- a/tools/perf/util/event.c
> > +++ b/tools/perf/util/event.c
> > @@ -485,13 +485,14 @@ size_t perf_event__fprintf_text_poke(union perf_e=
vent *event, struct machine *ma
> >       if (machine) {
> >               struct addr_location al;
> >
> > -             al.map =3D maps__find(machine__kernel_maps(machine), tp->=
addr);
> > +             al.map =3D map__get(maps__find(machine__kernel_maps(machi=
ne), tp->addr));
> >               if (al.map && map__load(al.map) >=3D 0) {
> >                       al.addr =3D map__map_ip(al.map, tp->addr);
> >                       al.sym =3D map__find_symbol(al.map, al.addr);
> >                       if (al.sym)
> >                               ret +=3D symbol__fprintf_symname_offs(al.=
sym, &al, fp);
> >               }
> > +             map__put(al.map);
> >       }
> >       ret +=3D fprintf(fp, " old len %u new len %u\n", tp->old_len, tp-=
>new_len);
> >       old =3D true;
> > @@ -582,6 +583,7 @@ struct map *thread__find_map(struct thread *thread,=
 u8 cpumode, u64 addr,
> >       al->filtered =3D 0;
> >
> >       if (machine =3D=3D NULL) {
> > +             map__put(al->map);
>
> Often as not, addr_location is not initialized before a call
> to thread__find_map(), so this is dereferencing an uninitialized
> pointer in those cases.

Agreed. I suspect this was an earlier fix for the struct hist_iter_ops
issues and I've now dropped this and the changes below in v5.

Thanks,
Ian

> >               al->map =3D NULL;
> >               return NULL;
> >       }
> > @@ -600,6 +602,7 @@ struct map *thread__find_map(struct thread *thread,=
 u8 cpumode, u64 addr,
> >               al->level =3D 'u';
> >       } else {
> >               al->level =3D 'H';
> > +             map__put(al->map);
>
> As above
>
> >               al->map =3D NULL;
> >
> >               if ((cpumode =3D=3D PERF_RECORD_MISC_GUEST_USER ||
> > @@ -614,7 +617,7 @@ struct map *thread__find_map(struct thread *thread,=
 u8 cpumode, u64 addr,
> >               return NULL;
> >       }
> >
> > -     al->map =3D maps__find(maps, al->addr);
> > +     al->map =3D map__get(maps__find(maps, al->addr));
>
> The map__put() above suggest there should one here before
> overwriting al->map?
>
> In general, it looks like there are callers of thread__find_map()
> that are not covered by this patch?
>
> >       if (al->map !=3D NULL) {
> >               /*
> >                * Kernel maps might be changed when loading symbols so l=
oading
> > @@ -773,6 +776,7 @@ int machine__resolve(struct machine *machine, struc=
t addr_location *al,
> >   */
> >  void addr_location__put(struct addr_location *al)
> >  {
> > +     map__zput(al->map);
> >       thread__zput(al->thread);
> >  }
> >
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index fdf0562d2fd3..02b4bf31b1a7 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -450,7 +450,7 @@ static int hist_entry__init(struct hist_entry *he,
> >                       memset(&he->stat, 0, sizeof(he->stat));
> >       }
> >
> > -     map__get(he->ms.map);
> > +     he->ms.map =3D map__get(he->ms.map);
> >
> >       if (he->branch_info) {
> >               /*
> > @@ -465,13 +465,13 @@ static int hist_entry__init(struct hist_entry *he=
,
> >               memcpy(he->branch_info, template->branch_info,
> >                      sizeof(*he->branch_info));
> >
> > -             map__get(he->branch_info->from.ms.map);
> > -             map__get(he->branch_info->to.ms.map);
> > +             he->branch_info->from.ms.map =3D map__get(he->branch_info=
->from.ms.map);
> > +             he->branch_info->to.ms.map =3D map__get(he->branch_info->=
to.ms.map);
> >       }
> >
> >       if (he->mem_info) {
> > -             map__get(he->mem_info->iaddr.ms.map);
> > -             map__get(he->mem_info->daddr.ms.map);
> > +             he->mem_info->iaddr.ms.map =3D map__get(he->mem_info->iad=
dr.ms.map);
> > +             he->mem_info->daddr.ms.map =3D map__get(he->mem_info->dad=
dr.ms.map);
> >       }
> >
> >       if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 916d98885128..502e97010a3c 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -880,21 +880,29 @@ static int machine__process_ksymbol_register(stru=
ct machine *machine,
> >       struct symbol *sym;
> >       struct dso *dso;
> >       struct map *map =3D maps__find(machine__kernel_maps(machine), eve=
nt->ksymbol.addr);
> > +     bool put_map =3D false;
> > +     int err =3D 0;
> >
> >       if (!map) {
> > -             int err;
> > -
> >               dso =3D dso__new(event->ksymbol.name);
> > -             if (dso) {
> > -                     dso->kernel =3D DSO_SPACE__KERNEL;
> > -                     map =3D map__new2(0, dso);
> > -                     dso__put(dso);
> > -             }
> >
> > -             if (!dso || !map) {
> > -                     return -ENOMEM;
> > +             if (!dso) {
> > +                     err =3D -ENOMEM;
> > +                     goto out;
> >               }
> > -
> > +             dso->kernel =3D DSO_SPACE__KERNEL;
> > +             map =3D map__new2(0, dso);
> > +             dso__put(dso);
> > +             if (!map) {
> > +                     err =3D -ENOMEM;
> > +                     goto out;
> > +             }
> > +             /*
> > +              * The inserted map has a get on it, we need to put to re=
lease
> > +              * the reference count here, but do it after all accesses=
 are
> > +              * done.
> > +              */
> > +             put_map =3D true;
> >               if (event->ksymbol.ksym_type =3D=3D PERF_RECORD_KSYMBOL_T=
YPE_OOL) {
> >                       dso->binary_type =3D DSO_BINARY_TYPE__OOL;
> >                       dso->data.file_size =3D event->ksymbol.len;
> > @@ -904,9 +912,10 @@ static int machine__process_ksymbol_register(struc=
t machine *machine,
> >               map->start =3D event->ksymbol.addr;
> >               map->end =3D map__start(map) + event->ksymbol.len;
> >               err =3D maps__insert(machine__kernel_maps(machine), map);
> > -             map__put(map);
> > -             if (err)
> > -                     return err;
> > +             if (err) {
> > +                     err =3D -ENOMEM;
> > +                     goto out;
> > +             }
> >
> >               dso__set_loaded(dso);
> >
> > @@ -921,10 +930,15 @@ static int machine__process_ksymbol_register(stru=
ct machine *machine,
> >       sym =3D symbol__new(map__map_ip(map, map__start(map)),
> >                         event->ksymbol.len,
> >                         0, 0, event->ksymbol.name);
> > -     if (!sym)
> > -             return -ENOMEM;
> > +     if (!sym) {
> > +             err =3D -ENOMEM;
> > +             goto out;
> > +     }
> >       dso__insert_symbol(dso, sym);
> > -     return 0;
> > +out:
> > +     if (put_map)
> > +             map__put(map);
> > +     return err;
> >  }
> >
> >  static int machine__process_ksymbol_unregister(struct machine *machine=
,
> > @@ -1026,13 +1040,11 @@ static struct map *machine__addnew_module_map(s=
truct machine *machine, u64 start
> >               goto out;
> >
> >       err =3D maps__insert(machine__kernel_maps(machine), map);
> > -
> > -     /* Put the map here because maps__insert already got it */
> > -     map__put(map);
> > -
> >       /* If maps__insert failed, return NULL. */
> > -     if (err)
> > +     if (err) {
> > +             map__put(map);
> >               map =3D NULL;
> > +     }
> >  out:
> >       /* put the dso here, corresponding to  machine__findnew_module_ds=
o */
> >       dso__put(dso);
> > @@ -1324,6 +1336,7 @@ __machine__create_kernel_maps(struct machine *mac=
hine, struct dso *kernel)
> >       /* In case of renewal the kernel map, destroy previous one */
> >       machine__destroy_kernel_maps(machine);
> >
> > +     map__put(machine->vmlinux_map);
> >       machine->vmlinux_map =3D map__new2(0, kernel);
> >       if (machine->vmlinux_map =3D=3D NULL)
> >               return -ENOMEM;
> > @@ -1612,7 +1625,7 @@ static int machine__create_module(void *arg, cons=
t char *name, u64 start,
> >       map->end =3D start + size;
> >
> >       dso__kernel_module_get_build_id(map__dso(map), machine->root_dir)=
;
> > -
> > +     map__put(map);
> >       return 0;
> >  }
> >
> > @@ -1658,16 +1671,18 @@ static void machine__set_kernel_mmap(struct mac=
hine *machine,
> >  static int machine__update_kernel_mmap(struct machine *machine,
> >                                    u64 start, u64 end)
> >  {
> > -     struct map *map =3D machine__kernel_map(machine);
> > +     struct map *orig, *updated;
> >       int err;
> >
> > -     map__get(map);
> > -     maps__remove(machine__kernel_maps(machine), map);
> > +     orig =3D machine->vmlinux_map;
> > +     updated =3D map__get(orig);
> >
> > +     machine->vmlinux_map =3D updated;
> >       machine__set_kernel_mmap(machine, start, end);
> > +     maps__remove(machine__kernel_maps(machine), orig);
> > +     err =3D maps__insert(machine__kernel_maps(machine), updated);
> > +     map__put(orig);
> >
> > -     err =3D maps__insert(machine__kernel_maps(machine), map);
> > -     map__put(map);
> >       return err;
> >  }
> >
> > @@ -2294,7 +2309,7 @@ static int add_callchain_ip(struct thread *thread=
,
> >  {
> >       struct map_symbol ms;
> >       struct addr_location al;
> > -     int nr_loop_iter =3D 0;
> > +     int nr_loop_iter =3D 0, err;
> >       u64 iter_cycles =3D 0;
> >       const char *srcline =3D NULL;
> >
> > @@ -2355,9 +2370,11 @@ static int add_callchain_ip(struct thread *threa=
d,
> >       ms.map =3D al.map;
> >       ms.sym =3D al.sym;
> >       srcline =3D callchain_srcline(&ms, al.addr);
> > -     return callchain_cursor_append(cursor, ip, &ms,
> > -                                    branch, flags, nr_loop_iter,
> > -                                    iter_cycles, branch_from, srcline)=
;
> > +     err =3D callchain_cursor_append(cursor, ip, &ms,
> > +                                   branch, flags, nr_loop_iter,
> > +                                   iter_cycles, branch_from, srcline);
> > +     map__put(al.map);
> > +     return err;
> >  }
> >
> >  struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index 1fe367e2cf19..acbc37359e06 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -410,7 +410,7 @@ struct map *map__clone(struct map *from)
> >       map =3D memdup(from, size);
> >       if (map !=3D NULL) {
> >               refcount_set(&map->refcnt, 1);
> > -             dso__get(dso);
> > +             map->dso =3D dso__get(dso);
> >       }
> >
> >       return map;
>
