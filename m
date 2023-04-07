Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF06E6DA6CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjDGBMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjDGBM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:12:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E3183D1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 18:12:26 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3e673b5f558so372771cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 18:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680829946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMSSVss8QLM38/pFC/aiSOCI3kV85pD5wzZ0Szro3DQ=;
        b=fO5+tygxq7/qPh5wwDtiHJ4t6qpKndMfvcI0Qd472am5HL1UQFXauv+zvo7r3v0f6m
         DffKhgR+ZtM8iOK9d+omyYILb1/c7fsVDeXoelLorcMG9UZy+RPot9o7cgyek9pjyrTA
         du6sNw4J3XhNU3mXVw7iENim8eG62OpLOlKuQqonjvVGBRN1gdeu8743r3GZwif0XgK/
         YMVkAJQvxPhSuLUMk5nCoFEk+THVsDwiYgRoslmZco8OJ2sjEJhvJ6dYDKRFus/Hknpv
         J3x+VOJ19qwk4Q0x/f/2ltb7/VldQD+VtTB10iu2kt1xSN2ODd28jfpEsVg9upHFZJg8
         K7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680829946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMSSVss8QLM38/pFC/aiSOCI3kV85pD5wzZ0Szro3DQ=;
        b=PUZPrHcVelIwShKFPtLeR+YVnkBg6PEmwg1JlYjOuLad+gwW3Tg8+sTyL8+di+0YQC
         SRJWxB8K3fhHVgqF5LKl5rObrddaRnF4ilUUpzaq6KT92wtL/0yks7v7cjBf1dYBKP1l
         1kfouGKyiDa/C5H0AlVVh+hTf/JTF4rbpKkTc9RiPLt1k8vRcMND3lRq+moSkBIigkdm
         UEUhuey9DU3qOi545ieN9GsUHUnAHLe9iuju3Ccs1os1h/1Pdyh12szHSoQqlmB8E+1c
         aixltwze6BqKE8HAGQqONG5J9x3g952PLblBQ51UgB5QBkTc8dfxwSW+YKLR1ZGpIFGl
         5nyg==
X-Gm-Message-State: AAQBX9ccZbtpYOAomlNlySkYEkc6YRt6ZJZe1LgMZZ7Oz+xbVtU0QF9n
        /1/s+9Rjybd8P7MyU9nKwfJG4bh90c3WhHkT0boH5A==
X-Google-Smtp-Source: AKy350Zniv58WFidpTZnP7ox4IAR9B5tdGLb2ipAzdDu1nXZpEa+uSaNJUa8YFyG4cb9y3JVpOTgE7Mpt8P5OQw7EOM=
X-Received: by 2002:a05:622a:1a94:b0:3b9:f696:c762 with SMTP id
 s20-20020a05622a1a9400b003b9f696c762mr65227qtc.19.1680829945209; Thu, 06 Apr
 2023 18:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230404205954.2245628-1-irogers@google.com> <20230404205954.2245628-3-irogers@google.com>
 <ZC9shhTLH3Vhwc9I@kernel.org>
In-Reply-To: <ZC9shhTLH3Vhwc9I@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Apr 2023 18:12:13 -0700
Message-ID: <CAP-5=fVwUCZ6kC7L=g8vQCXcTonZ43wFSM59fgh78KSQUqKSYw@mail.gmail.com>
Subject: Re: [PATCH v6 02/12] perf map: Add helper for map_ip and unmap_ip
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 6:06=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Tue, Apr 04, 2023 at 01:59:44PM -0700, Ian Rogers escreveu:
> > Later changes will add reference count checking for struct map, add a
> > helper function to invoke the map_ip and unmap_ip function
> > pointers. The helper allows the reference count check to be in fewer
> > places.
>
> Fixing these:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ find tools/perf/ -name "*.[ch]" =
| xargs grep -- '->map_ip('
> tools/perf/arch/s390/annotate/instructions.c:       map__rip_2objdump(tar=
get.ms.map, map->map_ip(target.ms.map, target.addr)) =3D=3D
> tools/perf/util/cs-etm.c:       offset =3D al.map->map_ip(al.map, address=
);

Agreed on fixing these.

> tools/perf/util/annotate.c:         map__rip_2objdump(target.ms.map, map-=
>map_ip(target.ms.map, target.addr)) =3D=3D
> tools/perf/util/annotate.c:         map__rip_2objdump(target.ms.map, map-=
>map_ip(target.ms.map, target.addr)) =3D=3D

Here the dispatched function pointer is from map and the first
argument is target.ms.map, so the helper function doesn't apply.

> tools/perf/util/map.c: * e.g. map__rip_2objdump(map->map_ip(map, map__obj=
dump_2mem(map, ip))) =3D=3D ip
> tools/perf/util/map.h:  return map->map_ip(map, ip);

This is a comment and the helper definition.

> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ find tools/perf/ -name "*.[ch]" =
| xargs grep -- '->unmap_ip('
> tools/perf/arch/powerpc/util/sym-handling.c:                    if (map->=
unmap_ip(map, sym->start) =3D=3D tev->point.address) {

Agreed on fixing this.

Thanks,
Ian

> tools/perf/util/map.h:  return map->unmap_ip(map, ip);
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/s390/annotate/instructions.c     |  3 ++-
> >  tools/perf/builtin-kallsyms.c                    |  2 +-
> >  tools/perf/builtin-kmem.c                        |  2 +-
> >  tools/perf/builtin-lock.c                        |  4 ++--
> >  tools/perf/builtin-script.c                      |  2 +-
> >  tools/perf/tests/vmlinux-kallsyms.c              | 10 +++++-----
> >  tools/perf/util/annotate.c                       | 16 +++++++++-------
> >  tools/perf/util/bpf_lock_contention.c            |  4 ++--
> >  tools/perf/util/dlfilter.c                       |  2 +-
> >  tools/perf/util/dso.c                            |  6 ++++--
> >  tools/perf/util/event.c                          |  8 ++++----
> >  tools/perf/util/evsel_fprintf.c                  |  2 +-
> >  tools/perf/util/intel-pt.c                       | 10 +++++-----
> >  tools/perf/util/machine.c                        | 16 ++++++++--------
> >  tools/perf/util/map.c                            | 10 +++++-----
> >  tools/perf/util/map.h                            | 10 ++++++++++
> >  tools/perf/util/maps.c                           |  8 ++++----
> >  tools/perf/util/probe-event.c                    |  8 ++++----
> >  .../util/scripting-engines/trace-event-python.c  |  2 +-
> >  tools/perf/util/sort.c                           | 12 ++++++------
> >  tools/perf/util/symbol.c                         |  4 ++--
> >  tools/perf/util/thread.c                         |  2 +-
> >  tools/perf/util/unwind-libdw.c                   |  2 +-
> >  tools/perf/util/unwind-libunwind-local.c         |  2 +-
> >  24 files changed, 81 insertions(+), 66 deletions(-)
> >
> > diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/=
arch/s390/annotate/instructions.c
> > index 0e136630659e..6548933e8dc0 100644
> > --- a/tools/perf/arch/s390/annotate/instructions.c
> > +++ b/tools/perf/arch/s390/annotate/instructions.c
> > @@ -39,7 +39,8 @@ static int s390_call__parse(struct arch *arch, struct=
 ins_operands *ops,
> >       target.addr =3D map__objdump_2mem(map, ops->target.addr);
> >
> >       if (maps__find_ams(ms->maps, &target) =3D=3D 0 &&
> > -         map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, t=
arget.addr)) =3D=3D ops->target.addr)
> > +         map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, t=
arget.addr)) =3D=3D
> > +         ops->target.addr)
> >               ops->target.sym =3D target.ms.sym;
> >
> >       return 0;
> > diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsym=
s.c
> > index 5638ca4dbd8e..3751df744577 100644
> > --- a/tools/perf/builtin-kallsyms.c
> > +++ b/tools/perf/builtin-kallsyms.c
> > @@ -39,7 +39,7 @@ static int __cmd_kallsyms(int argc, const char **argv=
)
> >               dso =3D map__dso(map);
> >               printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "=
-%#" PRIx64")\n",
> >                       symbol->name, dso->short_name, dso->long_name,
> > -                     map->unmap_ip(map, symbol->start), map->unmap_ip(=
map, symbol->end),
> > +                     map__unmap_ip(map, symbol->start), map__unmap_ip(=
map, symbol->end),
> >                       symbol->start, symbol->end);
> >       }
> >
> > diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> > index 4d4b770a401c..fcd2ef3bd3f5 100644
> > --- a/tools/perf/builtin-kmem.c
> > +++ b/tools/perf/builtin-kmem.c
> > @@ -1024,7 +1024,7 @@ static void __print_slab_result(struct rb_root *r=
oot,
> >
> >               if (sym !=3D NULL)
> >                       snprintf(buf, sizeof(buf), "%s+%" PRIx64 "", sym-=
>name,
> > -                              addr - map->unmap_ip(map, sym->start));
> > +                              addr - map__unmap_ip(map, sym->start));
> >               else
> >                       snprintf(buf, sizeof(buf), "%#" PRIx64 "", addr);
> >               printf(" %-34s |", buf);
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 32ec58fb80e4..04345b2e7101 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -900,7 +900,7 @@ static int get_symbol_name_offset(struct map *map, =
struct symbol *sym, u64 ip,
> >               return 0;
> >       }
> >
> > -     offset =3D map->map_ip(map, ip) - sym->start;
> > +     offset =3D map__map_ip(map, ip) - sym->start;
> >
> >       if (offset)
> >               return scnprintf(buf, size, "%s+%#lx", sym->name, offset)=
;
> > @@ -1070,7 +1070,7 @@ static int report_lock_contention_begin_event(str=
uct evsel *evsel,
> >                               return -ENOMEM;
> >                       }
> >
> > -                     addrs[filters.nr_addrs++] =3D kmap->unmap_ip(kmap=
, sym->start);
> > +                     addrs[filters.nr_addrs++] =3D map__unmap_ip(kmap,=
 sym->start);
> >                       filters.addrs =3D addrs;
> >               }
> >       }
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index af0a69c7f41f..8fba247b798c 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -1088,7 +1088,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end=
,
> >       /* Load maps to ensure dso->is_64_bit has been updated */
> >       map__load(al.map);
> >
> > -     offset =3D al.map->map_ip(al.map, start);
> > +     offset =3D map__map_ip(al.map, start);
> >       len =3D dso__data_read_offset(dso, machine, offset, (u8 *)buffer,
> >                                   end - start + MAXINSN);
> >
> > diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vml=
inux-kallsyms.c
> > index 0a75623172c2..05a322ea3f9f 100644
> > --- a/tools/perf/tests/vmlinux-kallsyms.c
> > +++ b/tools/perf/tests/vmlinux-kallsyms.c
> > @@ -13,7 +13,7 @@
> >  #include "debug.h"
> >  #include "machine.h"
> >
> > -#define UM(x) kallsyms_map->unmap_ip(kallsyms_map, (x))
> > +#define UM(x) map__unmap_ip(kallsyms_map, (x))
> >
> >  static bool is_ignored_symbol(const char *name, char type)
> >  {
> > @@ -221,8 +221,8 @@ static int test__vmlinux_matches_kallsyms(struct te=
st_suite *test __maybe_unused
> >               if (sym->start =3D=3D sym->end)
> >                       continue;
> >
> > -             mem_start =3D vmlinux_map->unmap_ip(vmlinux_map, sym->sta=
rt);
> > -             mem_end =3D vmlinux_map->unmap_ip(vmlinux_map, sym->end);
> > +             mem_start =3D map__unmap_ip(vmlinux_map, sym->start);
> > +             mem_end =3D map__unmap_ip(vmlinux_map, sym->end);
> >
> >               first_pair =3D machine__find_kernel_symbol(&kallsyms, mem=
_start, NULL);
> >               pair =3D first_pair;
> > @@ -319,8 +319,8 @@ static int test__vmlinux_matches_kallsyms(struct te=
st_suite *test __maybe_unused
> >       maps__for_each_entry(maps, rb_node) {
> >               struct map *pair, *map =3D rb_node->map;
> >
> > -             mem_start =3D vmlinux_map->unmap_ip(vmlinux_map, map__sta=
rt(map));
> > -             mem_end =3D vmlinux_map->unmap_ip(vmlinux_map, map__end(m=
ap));
> > +             mem_start =3D map__unmap_ip(vmlinux_map, map__start(map))=
;
> > +             mem_end =3D map__unmap_ip(vmlinux_map, map__end(map));
> >
> >               pair =3D maps__find(kallsyms.kmaps, mem_start);
> >               if (pair =3D=3D NULL || pair->priv)
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index b9cff782d7df..36acdd1bd379 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -272,7 +272,8 @@ static int call__parse(struct arch *arch, struct in=
s_operands *ops, struct map_s
> >       target.addr =3D map__objdump_2mem(map, ops->target.addr);
> >
> >       if (maps__find_ams(ms->maps, &target) =3D=3D 0 &&
> > -         map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, t=
arget.addr)) =3D=3D ops->target.addr)
> > +         map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, t=
arget.addr)) =3D=3D
> > +         ops->target.addr)
> >               ops->target.sym =3D target.ms.sym;
> >
> >       return 0;
> > @@ -376,8 +377,8 @@ static int jump__parse(struct arch *arch, struct in=
s_operands *ops, struct map_s
> >       }
> >
> >       target.addr =3D map__objdump_2mem(map, ops->target.addr);
> > -     start =3D map->unmap_ip(map, sym->start),
> > -     end =3D map->unmap_ip(map, sym->end);
> > +     start =3D map__unmap_ip(map, sym->start);
> > +     end =3D map__unmap_ip(map, sym->end);
> >
> >       ops->target.outside =3D target.addr < start || target.addr > end;
> >
> > @@ -400,7 +401,8 @@ static int jump__parse(struct arch *arch, struct in=
s_operands *ops, struct map_s
> >        * the symbol searching and disassembly should be done.
> >        */
> >       if (maps__find_ams(ms->maps, &target) =3D=3D 0 &&
> > -         map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, t=
arget.addr)) =3D=3D ops->target.addr)
> > +         map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, t=
arget.addr)) =3D=3D
> > +         ops->target.addr)
> >               ops->target.sym =3D target.ms.sym;
> >
> >       if (!ops->target.outside) {
> > @@ -881,7 +883,7 @@ static int __symbol__inc_addr_samples(struct map_sy=
mbol *ms,
> >       unsigned offset;
> >       struct sym_hist *h;
> >
> > -     pr_debug3("%s: addr=3D%#" PRIx64 "\n", __func__, ms->map->unmap_i=
p(ms->map, addr));
> > +     pr_debug3("%s: addr=3D%#" PRIx64 "\n", __func__, map__unmap_ip(ms=
->map, addr));
> >
> >       if ((addr < sym->start || addr >=3D sym->end) &&
> >           (addr !=3D sym->end || sym->start !=3D sym->end)) {
> > @@ -1977,8 +1979,8 @@ static int symbol__disassemble(struct symbol *sym=
, struct annotate_args *args)
> >               return err;
> >
> >       pr_debug("%s: filename=3D%s, sym=3D%s, start=3D%#" PRIx64 ", end=
=3D%#" PRIx64 "\n", __func__,
> > -              symfs_filename, sym->name, map->unmap_ip(map, sym->start=
),
> > -              map->unmap_ip(map, sym->end));
> > +              symfs_filename, sym->name, map__unmap_ip(map, sym->start=
),
> > +              map__unmap_ip(map, sym->end));
> >
> >       pr_debug("annotating [%p] %30s : [%p] %30s\n",
> >                dso, dso->long_name, sym, sym->name);
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bp=
f_lock_contention.c
> > index 8a5d0eb44189..2b3bc544aa3e 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -74,7 +74,7 @@ int lock_contention_prepare(struct lock_contention *c=
on)
> >                               continue;
> >                       }
> >
> > -                     addrs[con->filters->nr_addrs++] =3D kmap->unmap_i=
p(kmap, sym->start);
> > +                     addrs[con->filters->nr_addrs++] =3D map__unmap_ip=
(kmap, sym->start);
> >                       con->filters->addrs =3D addrs;
> >               }
> >               naddrs =3D con->filters->nr_addrs;
> > @@ -233,7 +233,7 @@ static const char *lock_contention_get_name(struct =
lock_contention *con,
> >       if (sym) {
> >               unsigned long offset;
> >
> > -             offset =3D kmap->map_ip(kmap, addr) - sym->start;
> > +             offset =3D map__map_ip(kmap, addr) - sym->start;
> >
> >               if (offset =3D=3D 0)
> >                       return sym->name;
> > diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> > index fe401fa4be02..16238f823a5e 100644
> > --- a/tools/perf/util/dlfilter.c
> > +++ b/tools/perf/util/dlfilter.c
> > @@ -278,7 +278,7 @@ static __s32 dlfilter__object_code(void *ctx, __u64=
 ip, void *buf, __u32 len)
> >
> >       map =3D a.map;
> >  have_map:
> > -     offset =3D map->map_ip(map, ip);
> > +     offset =3D map__map_ip(map, ip);
> >       if (ip + len >=3D map__end(map))
> >               len =3D map__end(map) - ip;
> >       return dso__data_read_offset(map__dso(map), d->machine, offset, b=
uf, len);
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index f1a14c0ad26d..e36b418df2c6 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -1122,7 +1122,8 @@ ssize_t dso__data_read_addr(struct dso *dso, stru=
ct map *map,
> >                           struct machine *machine, u64 addr,
> >                           u8 *data, ssize_t size)
> >  {
> > -     u64 offset =3D map->map_ip(map, addr);
> > +     u64 offset =3D map__map_ip(map, addr);
> > +
> >       return dso__data_read_offset(dso, machine, offset, data, size);
> >  }
> >
> > @@ -1162,7 +1163,8 @@ ssize_t dso__data_write_cache_addr(struct dso *ds=
o, struct map *map,
> >                                  struct machine *machine, u64 addr,
> >                                  const u8 *data, ssize_t size)
> >  {
> > -     u64 offset =3D map->map_ip(map, addr);
> > +     u64 offset =3D map__map_ip(map, addr);
> > +
> >       return dso__data_write_cache_offs(dso, machine, offset, data, siz=
e);
> >  }
> >
> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > index 2ddc75dee019..2712d1a8264e 100644
> > --- a/tools/perf/util/event.c
> > +++ b/tools/perf/util/event.c
> > @@ -487,7 +487,7 @@ size_t perf_event__fprintf_text_poke(union perf_eve=
nt *event, struct machine *ma
> >
> >               al.map =3D maps__find(machine__kernel_maps(machine), tp->=
addr);
> >               if (al.map && map__load(al.map) >=3D 0) {
> > -                     al.addr =3D al.map->map_ip(al.map, tp->addr);
> > +                     al.addr =3D map__map_ip(al.map, tp->addr);
> >                       al.sym =3D map__find_symbol(al.map, al.addr);
> >                       if (al.sym)
> >                               ret +=3D symbol__fprintf_symname_offs(al.=
sym, &al, fp);
> > @@ -622,7 +622,7 @@ struct map *thread__find_map(struct thread *thread,=
 u8 cpumode, u64 addr,
> >                */
> >               if (load_map)
> >                       map__load(al->map);
> > -             al->addr =3D al->map->map_ip(al->map, al->addr);
> > +             al->addr =3D map__map_ip(al->map, al->addr);
> >       }
> >
> >       return al->map;
> > @@ -743,12 +743,12 @@ int machine__resolve(struct machine *machine, str=
uct addr_location *al,
> >               }
> >               if (!ret && al->sym) {
> >                       snprintf(al_addr_str, sz, "0x%"PRIx64,
> > -                             al->map->unmap_ip(al->map, al->sym->start=
));
> > +                              map__unmap_ip(al->map, al->sym->start));
> >                       ret =3D strlist__has_entry(symbol_conf.sym_list,
> >                                               al_addr_str);
> >               }
> >               if (!ret && symbol_conf.addr_list && al->map) {
> > -                     unsigned long addr =3D al->map->unmap_ip(al->map,=
 al->addr);
> > +                     unsigned long addr =3D map__unmap_ip(al->map, al-=
>addr);
> >
> >                       ret =3D intlist__has_entry(symbol_conf.addr_list,=
 addr);
> >                       if (!ret && symbol_conf.addr_range) {
> > diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fp=
rintf.c
> > index dff5d8c4b06d..a09ac00810b7 100644
> > --- a/tools/perf/util/evsel_fprintf.c
> > +++ b/tools/perf/util/evsel_fprintf.c
> > @@ -151,7 +151,7 @@ int sample__fprintf_callchain(struct perf_sample *s=
ample, int left_alignment,
> >                               printed +=3D fprintf(fp, " <-");
> >
> >                       if (map)
> > -                             addr =3D map->map_ip(map, node->ip);
> > +                             addr =3D map__map_ip(map, node->ip);
> >
> >                       if (print_ip) {
> >                               /* Show binary offset for userspace addr =
*/
> > diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> > index a2e62daa708e..fe893c9bab3f 100644
> > --- a/tools/perf/util/intel-pt.c
> > +++ b/tools/perf/util/intel-pt.c
> > @@ -816,7 +816,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_=
insn *intel_pt_insn,
> >                   dso__data_status_seen(dso, DSO_DATA_STATUS_SEEN_ITRAC=
E))
> >                       return -ENOENT;
> >
> > -             offset =3D al.map->map_ip(al.map, *ip);
> > +             offset =3D map__map_ip(al.map, *ip);
> >
> >               if (!to_ip && one_map) {
> >                       struct intel_pt_cache_entry *e;
> > @@ -987,7 +987,7 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *dat=
a)
> >       if (!thread__find_map(thread, cpumode, ip, &al) || !map__dso(al.m=
ap))
> >               return -EINVAL;
> >
> > -     offset =3D al.map->map_ip(al.map, ip);
> > +     offset =3D map__map_ip(al.map, ip);
> >
> >       return intel_pt_match_pgd_ip(ptq->pt, ip, offset, map__dso(al.map=
)->long_name);
> >  }
> > @@ -2749,7 +2749,7 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt=
, u64 *ptss_ip)
> >       for (sym =3D start; sym; sym =3D dso__next_symbol(sym)) {
> >               if (sym->binding =3D=3D STB_GLOBAL &&
> >                   !strcmp(sym->name, "__switch_to")) {
> > -                     ip =3D map->unmap_ip(map, sym->start);
> > +                     ip =3D map__unmap_ip(map, sym->start);
> >                       if (ip >=3D map__start(map) && ip < map__end(map)=
) {
> >                               switch_ip =3D ip;
> >                               break;
> > @@ -2767,7 +2767,7 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt=
, u64 *ptss_ip)
> >
> >       for (sym =3D start; sym; sym =3D dso__next_symbol(sym)) {
> >               if (!strcmp(sym->name, ptss)) {
> > -                     ip =3D map->unmap_ip(map, sym->start);
> > +                     ip =3D map__unmap_ip(map, sym->start);
> >                       if (ip >=3D map__start(map) && ip < map__end(map)=
) {
> >                               *ptss_ip =3D ip;
> >                               break;
> > @@ -3393,7 +3393,7 @@ static int intel_pt_text_poke(struct intel_pt *pt=
, union perf_event *event)
> >               if (!dso || !dso->auxtrace_cache)
> >                       continue;
> >
> > -             offset =3D al.map->map_ip(al.map, addr);
> > +             offset =3D map__map_ip(al.map, addr);
> >
> >               e =3D intel_pt_cache_lookup(dso, machine, offset);
> >               if (!e)
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 9d24980a0a93..d29ec4a04488 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -919,7 +919,7 @@ static int machine__process_ksymbol_register(struct=
 machine *machine,
> >               dso =3D map__dso(map);
> >       }
> >
> > -     sym =3D symbol__new(map->map_ip(map, map__start(map)),
> > +     sym =3D symbol__new(map__map_ip(map, map__start(map)),
> >                         event->ksymbol.len,
> >                         0, 0, event->ksymbol.name);
> >       if (!sym)
> > @@ -944,7 +944,7 @@ static int machine__process_ksymbol_unregister(stru=
ct machine *machine,
> >       else {
> >               struct dso *dso =3D map__dso(map);
> >
> > -             sym =3D dso__find_symbol(dso, map->map_ip(map, map__start=
(map)));
> > +             sym =3D dso__find_symbol(dso, map__map_ip(map, map__start=
(map)));
> >               if (sym)
> >                       dso__delete_symbol(dso, sym);
> >       }
> > @@ -1279,7 +1279,7 @@ int machine__map_x86_64_entry_trampolines(struct =
machine *machine,
> >
> >               dest_map =3D maps__find(kmaps, map->pgoff);
> >               if (dest_map !=3D map)
> > -                     map->pgoff =3D dest_map->map_ip(dest_map, map->pg=
off);
> > +                     map->pgoff =3D map__map_ip(dest_map, map->pgoff);
> >               found =3D true;
> >       }
> >       if (found || machine->trampolines_mapped)
> > @@ -3345,7 +3345,7 @@ char *machine__resolve_kernel_addr(void *vmachine=
, unsigned long long *addrp, ch
> >               return NULL;
> >
> >       *modp =3D __map__is_kmodule(map) ? (char *)map__dso(map)->short_n=
ame : NULL;
> > -     *addrp =3D map->unmap_ip(map, sym->start);
> > +     *addrp =3D map__unmap_ip(map, sym->start);
> >       return sym->name;
> >  }
> >
> > @@ -3388,17 +3388,17 @@ bool machine__is_lock_function(struct machine *=
machine, u64 addr)
> >                       return false;
> >               }
> >
> > -             machine->sched.text_start =3D kmap->unmap_ip(kmap, sym->s=
tart);
> > +             machine->sched.text_start =3D map__unmap_ip(kmap, sym->st=
art);
> >
> >               /* should not fail from here */
> >               sym =3D machine__find_kernel_symbol_by_name(machine, "__s=
ched_text_end", &kmap);
> > -             machine->sched.text_end =3D kmap->unmap_ip(kmap, sym->sta=
rt);
> > +             machine->sched.text_end =3D map__unmap_ip(kmap, sym->star=
t);
> >
> >               sym =3D machine__find_kernel_symbol_by_name(machine, "__l=
ock_text_start", &kmap);
> > -             machine->lock.text_start =3D kmap->unmap_ip(kmap, sym->st=
art);
> > +             machine->lock.text_start =3D map__unmap_ip(kmap, sym->sta=
rt);
> >
> >               sym =3D machine__find_kernel_symbol_by_name(machine, "__l=
ock_text_end", &kmap);
> > -             machine->lock.text_end =3D kmap->unmap_ip(kmap, sym->star=
t);
> > +             machine->lock.text_end =3D map__unmap_ip(kmap, sym->start=
);
> >       }
> >
> >       /* failed to get kernel symbols */
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index d97a6d20626f..816bffbbf344 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -519,7 +519,7 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
> >       if (dso->kernel =3D=3D DSO_SPACE__USER)
> >               return rip + dso->text_offset;
> >
> > -     return map->unmap_ip(map, rip) - map->reloc;
> > +     return map__unmap_ip(map, rip) - map->reloc;
> >  }
> >
> >  /**
> > @@ -539,24 +539,24 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
> >       const struct dso *dso =3D map__dso(map);
> >
> >       if (!dso->adjust_symbols)
> > -             return map->unmap_ip(map, ip);
> > +             return map__unmap_ip(map, ip);
> >
> >       if (dso->rel)
> > -             return map->unmap_ip(map, ip + map->pgoff);
> > +             return map__unmap_ip(map, ip + map->pgoff);
> >
> >       /*
> >        * kernel modules also have DSO_TYPE_USER in dso->kernel,
> >        * but all kernel modules are ET_REL, so won't get here.
> >        */
> >       if (dso->kernel =3D=3D DSO_SPACE__USER)
> > -             return map->unmap_ip(map, ip - dso->text_offset);
> > +             return map__unmap_ip(map, ip - dso->text_offset);
> >
> >       return ip + map->reloc;
> >  }
> >
> >  bool map__contains_symbol(const struct map *map, const struct symbol *=
sym)
> >  {
> > -     u64 ip =3D map->unmap_ip(map, sym->start);
> > +     u64 ip =3D map__unmap_ip(map, sym->start);
> >
> >       return ip >=3D map__start(map) && ip < map__end(map);
> >  }
> > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > index 9b0a84e46e48..9118eba71032 100644
> > --- a/tools/perf/util/map.h
> > +++ b/tools/perf/util/map.h
> > @@ -52,6 +52,16 @@ static inline struct dso *map__dso(const struct map =
*map)
> >       return map->dso;
> >  }
> >
> > +static inline u64 map__map_ip(const struct map *map, u64 ip)
> > +{
> > +     return map->map_ip(map, ip);
> > +}
> > +
> > +static inline u64 map__unmap_ip(const struct map *map, u64 ip)
> > +{
> > +     return map->unmap_ip(map, ip);
> > +}
> > +
> >  static inline u64 map__start(const struct map *map)
> >  {
> >       return map->start;
> > diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> > index 21010a2b8e16..0eee27e24c33 100644
> > --- a/tools/perf/util/maps.c
> > +++ b/tools/perf/util/maps.c
> > @@ -194,7 +194,7 @@ struct symbol *maps__find_symbol(struct maps *maps,=
 u64 addr, struct map **mapp)
> >       if (map !=3D NULL && map__load(map) >=3D 0) {
> >               if (mapp !=3D NULL)
> >                       *mapp =3D map;
> > -             return map__find_symbol(map, map->map_ip(map, addr));
> > +             return map__find_symbol(map, map__map_ip(map, addr));
> >       }
> >
> >       return NULL;
> > @@ -237,7 +237,7 @@ int maps__find_ams(struct maps *maps, struct addr_m=
ap_symbol *ams)
> >                       return -1;
> >       }
> >
> > -     ams->al_addr =3D ams->ms.map->map_ip(ams->ms.map, ams->addr);
> > +     ams->al_addr =3D map__map_ip(ams->ms.map, ams->addr);
> >       ams->ms.sym =3D map__find_symbol(ams->ms.map, ams->al_addr);
> >
> >       return ams->ms.sym ? 0 : -1;
> > @@ -349,8 +349,8 @@ int maps__fixup_overlappings(struct maps *maps, str=
uct map *map, FILE *fp)
> >
> >                       after->start =3D map__end(map);
> >                       after->pgoff +=3D map__end(map) - map__start(pos-=
>map);
> > -                     assert(pos->map->map_ip(pos->map, map__end(map)) =
=3D=3D
> > -                             after->map_ip(after, map__end(map)));
> > +                     assert(map__map_ip(pos->map, map__end(map)) =3D=
=3D
> > +                             map__map_ip(after, map__end(map)));
> >                       err =3D __maps__insert(maps, after);
> >                       if (err)
> >                               goto put_map;
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-even=
t.c
> > index 4d9dbeeb6014..bb44a3798df8 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -141,7 +141,7 @@ static int kernel_get_symbol_address_by_name(const =
char *name, u64 *addr,
> >               sym =3D machine__find_kernel_symbol_by_name(host_machine,=
 name, &map);
> >               if (!sym)
> >                       return -ENOENT;
> > -             *addr =3D map->unmap_ip(map, sym->start) -
> > +             *addr =3D map__unmap_ip(map, sym->start) -
> >                       ((reloc) ? 0 : map->reloc) -
> >                       ((reladdr) ? map__start(map) : 0);
> >       }
> > @@ -400,7 +400,7 @@ static int find_alternative_probe_point(struct debu=
ginfo *dinfo,
> >                                          "Consider identifying the fina=
l function used at run time and set the probe directly on that.\n",
> >                                          pp->function);
> >               } else
> > -                     address =3D map->unmap_ip(map, sym->start) - map-=
>reloc;
> > +                     address =3D map__unmap_ip(map, sym->start) - map-=
>reloc;
> >               break;
> >       }
> >       if (!address) {
> > @@ -2249,7 +2249,7 @@ static int find_perf_probe_point_from_map(struct =
probe_trace_point *tp,
> >               goto out;
> >
> >       pp->retprobe =3D tp->retprobe;
> > -     pp->offset =3D addr - map->unmap_ip(map, sym->start);
> > +     pp->offset =3D addr - map__unmap_ip(map, sym->start);
> >       pp->function =3D strdup(sym->name);
> >       ret =3D pp->function ? 0 : -ENOMEM;
> >
> > @@ -3123,7 +3123,7 @@ static int find_probe_trace_events_from_map(struc=
t perf_probe_event *pev,
> >                       goto err_out;
> >               }
> >               /* Add one probe point */
> > -             tp->address =3D map->unmap_ip(map, sym->start) + pp->offs=
et;
> > +             tp->address =3D map__unmap_ip(map, sym->start) + pp->offs=
et;
> >
> >               /* Check the kprobe (not in module) is within .text  */
> >               if (!pev->uprobes && !pev->target &&
> > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/t=
ools/perf/util/scripting-engines/trace-event-python.c
> > index cbf09eaf3734..41d4f9e6a8b7 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > @@ -471,7 +471,7 @@ static PyObject *python_process_callchain(struct pe=
rf_sample *sample,
> >                               struct addr_location node_al;
> >                               unsigned long offset;
> >
> > -                             node_al.addr =3D map->map_ip(map, node->i=
p);
> > +                             node_al.addr =3D map__map_ip(map, node->i=
p);
> >                               node_al.map  =3D map;
> >                               offset =3D get_offset(node->ms.sym, &node=
_al);
> >
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index f161589aefda..87a3ba584af5 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -364,7 +364,7 @@ static int _hist_entry__sym_snprintf(struct map_sym=
bol *ms,
> >               u64 rip =3D ip;
> >
> >               if (dso && dso->kernel && dso->adjust_symbols)
> > -                     rip =3D map->unmap_ip(map, ip);
> > +                     rip =3D map__unmap_ip(map, ip);
> >
> >               ret +=3D repsep_snprintf(bf, size, "%-#*llx %c ",
> >                                      BITS_PER_LONG / 4 + 2, rip, o);
> > @@ -375,7 +375,7 @@ static int _hist_entry__sym_snprintf(struct map_sym=
bol *ms,
> >               if (sym->type =3D=3D STT_OBJECT) {
> >                       ret +=3D repsep_snprintf(bf + ret, size - ret, "%=
s", sym->name);
> >                       ret +=3D repsep_snprintf(bf + ret, size - ret, "+=
0x%llx",
> > -                                     ip - map->unmap_ip(map, sym->star=
t));
> > +                                     ip - map__unmap_ip(map, sym->star=
t));
> >               } else {
> >                       ret +=3D repsep_snprintf(bf + ret, size - ret, "%=
.*s",
> >                                              width - ret,
> > @@ -1147,7 +1147,7 @@ static int _hist_entry__addr_snprintf(struct map_=
symbol *ms,
> >               if (sym->type =3D=3D STT_OBJECT) {
> >                       ret +=3D repsep_snprintf(bf + ret, size - ret, "%=
s", sym->name);
> >                       ret +=3D repsep_snprintf(bf + ret, size - ret, "+=
0x%llx",
> > -                                     ip - map->unmap_ip(map, sym->star=
t));
> > +                                     ip - map__unmap_ip(map, sym->star=
t));
> >               } else {
> >                       ret +=3D repsep_snprintf(bf + ret, size - ret, "%=
.*s",
> >                                              width - ret,
> > @@ -2104,9 +2104,9 @@ sort__addr_cmp(struct hist_entry *left, struct hi=
st_entry *right)
> >       struct map *right_map =3D right->ms.map;
> >
> >       if (left_map)
> > -             left_ip =3D left_map->unmap_ip(left_map, left_ip);
> > +             left_ip =3D map__unmap_ip(left_map, left_ip);
> >       if (right_map)
> > -             right_ip =3D right_map->unmap_ip(right_map, right_ip);
> > +             right_ip =3D map__unmap_ip(right_map, right_ip);
> >
> >       return _sort__addr_cmp(left_ip, right_ip);
> >  }
> > @@ -2118,7 +2118,7 @@ static int hist_entry__addr_snprintf(struct hist_=
entry *he, char *bf,
> >       struct map *map =3D he->ms.map;
> >
> >       if (map)
> > -             ip =3D map->unmap_ip(map, ip);
> > +             ip =3D map__unmap_ip(map, ip);
> >
> >       return repsep_snprintf(bf, size, "%-#*llx", width, ip);
> >  }
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index b91deb177091..9ba49c1ef6ef 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -896,8 +896,8 @@ static int maps__split_kallsyms(struct maps *kmaps,=
 struct dso *dso, u64 delta,
> >                        * So that we look just like we get from .ko file=
s,
> >                        * i.e. not prelinked, relative to initial_map->s=
tart.
> >                        */
> > -                     pos->start =3D curr_map->map_ip(curr_map, pos->st=
art);
> > -                     pos->end   =3D curr_map->map_ip(curr_map, pos->en=
d);
> > +                     pos->start =3D map__map_ip(curr_map, pos->start);
> > +                     pos->end   =3D map__map_ip(curr_map, pos->end);
> >               } else if (x86_64 && is_entry_trampoline(pos->name)) {
> >                       /*
> >                        * These symbols are not needed anymore since the
> > diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> > index bb7a2ce82d46..4b5bdc277baa 100644
> > --- a/tools/perf/util/thread.c
> > +++ b/tools/perf/util/thread.c
> > @@ -464,7 +464,7 @@ int thread__memcpy(struct thread *thread, struct ma=
chine *machine,
> >       if( !dso || dso->data.status =3D=3D DSO_DATA_STATUS_ERROR || map_=
_load(al.map) < 0)
> >               return -1;
> >
> > -     offset =3D al.map->map_ip(al.map, ip);
> > +     offset =3D map__map_ip(al.map, ip);
> >       if (is64bit)
> >               *is64bit =3D dso->is_64_bit;
> >
> > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-li=
bdw.c
> > index b79f57e5648f..538320e4260c 100644
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -115,7 +115,7 @@ static int entry(u64 ip, struct unwind_info *ui)
> >       pr_debug("unwind: %s:ip =3D 0x%" PRIx64 " (0x%" PRIx64 ")\n",
> >                al.sym ? al.sym->name : "''",
> >                ip,
> > -              al.map ? al.map->map_ip(al.map, ip) : (u64) 0);
> > +              al.map ? map__map_ip(al.map, ip) : (u64) 0);
> >       return 0;
> >  }
> >
> > diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util=
/unwind-libunwind-local.c
> > index 1c13f43e7d22..f9a52af48de4 100644
> > --- a/tools/perf/util/unwind-libunwind-local.c
> > +++ b/tools/perf/util/unwind-libunwind-local.c
> > @@ -640,7 +640,7 @@ static int entry(u64 ip, struct thread *thread,
> >       pr_debug("unwind: %s:ip =3D 0x%" PRIx64 " (0x%" PRIx64 ")\n",
> >                al.sym ? al.sym->name : "''",
> >                ip,
> > -              al.map ? al.map->map_ip(al.map, ip) : (u64) 0);
> > +              al.map ? map__map_ip(al.map, ip) : (u64) 0);
> >
> >       return cb(&e, arg);
> >  }
> > --
> > 2.40.0.348.gf938b09366-goog
> >
>
> --
>
> - Arnaldo
