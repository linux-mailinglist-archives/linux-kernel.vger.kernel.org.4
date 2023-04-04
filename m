Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E5D6D69BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjDDRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjDDRCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186F4D1;
        Tue,  4 Apr 2023 10:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A23FC6312F;
        Tue,  4 Apr 2023 17:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09AAC433EF;
        Tue,  4 Apr 2023 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680627760;
        bh=akrizyzM1K7otsB+h6lzX8Kh+SM+AgLJ8vgEh34k9/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kawqr7wIdrbQpgzkkC75dU20MsRtE8kvwR7inMSPFBWcdEN1Mt9OxsZOmL61g/YcV
         uUI137uBnFMgZEEhE3fsg7RvkiQAqNutu5AHVAq8CqNnuOyQemyDV21i7q0lxxc+am
         QfT2G/cn0kmxN5rHr6h+kZifIPJyz3gHZ9nW+y5C9uel+tErl0M9cvtahUVucJCxdt
         eVXUNEDxf+H+06dqXSOM3OSGuReEZ3caLTfEmk8TilZ/ByfUs4LksGEyikoFaNtPZP
         ePcDpauFGYtVnTrpA7mWX+3qyvpG4/mwpU665c93n7k9FxQxpK7C9TmKi2HsqGOV0m
         4ilkvs8y5/wxQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C8CA84052D; Tue,  4 Apr 2023 14:02:36 -0300 (-03)
Date:   Tue, 4 Apr 2023 14:02:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH v5 00/17] Reference count checker and related fixes
Message-ID: <ZCxYLAMrdNyiLVvr@kernel.org>
References: <20230320212248.1175731-1-irogers@google.com>
 <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 04, 2023 at 08:58:55AM -0700, Ian Rogers escreveu:
> Ping. It would be nice to have this landed or at least the first 10
> patches that refactor the map API and are the bulk of the
> lines-of-code changed. Having those landed would make it easier to
> rebase in the future, but I also think the whole series is ready to
> go.

I'm trying to get it to compile:

  CC      /tmp/build/perf-tools-next/util/bpf-event.o
In file included from util/machine.h:7,
                 from util/session.h:8,
                 from util/unwind-libunwind-local.c:35:
util/unwind-libunwind-local.c: In function ‘read_unwind_spec_eh_frame’:
util/maps.h:29:18: error: assignment to ‘struct map *’ from incompatible pointer type ‘struct map_rb_node *’ [-Werror=incompatible-pointer-types]
   29 |         for (map = maps__first(maps); map; map = map_rb_node__next(map))
      |                  ^
util/unwind-libunwind-local.c:328:9: note: in expansion of macro ‘maps__for_each_entry’
  328 |         maps__for_each_entry(ui->thread->maps, map) {
      |         ^~~~~~~~~~~~~~~~~~~~
util/unwind-libunwind-local.c:328:48: error: passing argument 1 of ‘map_rb_node__next’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  328 |         maps__for_each_entry(ui->thread->maps, map) {
      |                                                ^~~
      |                                                |
      |                                                struct map *
util/maps.h:29:68: note: in definition of macro ‘maps__for_each_entry’
   29 |         for (map = maps__first(maps); map; map = map_rb_node__next(map))
      |                                                                    ^~~
util/maps.h:24:59: note: expected ‘struct map_rb_node *’ but argument is of type ‘struct map *’
   24 | struct map_rb_node *map_rb_node__next(struct map_rb_node *node);
      |                                       ~~~~~~~~~~~~~~~~~~~~^~~~
util/maps.h:29:48: error: assignment to ‘struct map *’ from incompatible pointer type ‘struct map_rb_node *’ [-Werror=incompatible-pointer-types]
   29 |         for (map = maps__first(maps); map; map = map_rb_node__next(map))
      |                                                ^
util/unwind-libunwind-local.c:328:9: note: in expansion of macro ‘maps__for_each_entry’
  328 |         maps__for_each_entry(ui->thread->maps, map) {
      |         ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/unwind-libunwind-local.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf-tools-next/util/scripting-engines/perf-in.o
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:140: util] Error 2
make[2]: *** [Makefile.perf:676: /tmp/build/perf-tools-next/perf-in.o] Error 2
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf-tools-next -C tools/perf install-bin':

      260622279301      cycles:u
      285362743453      instructions:u                   #    1.09  insn per cycle

       6.001315366 seconds time elapsed

      62.979105000 seconds user
      13.088797000 seconds sys


⬢[acme@toolbox perf-tools-next]$ git log --oneline -1
51a0f26e88c893ac (HEAD) perf maps: Remove rb_node from struct map
⬢[acme@toolbox perf-tools-next]$

I'm also making some changes to reduce the number of patch lines and
conserve the project 'git blame' usefulness, not changing the logic in
your patches.

- Arnaldo
 
> Thanks,
> Ian
> 
> On Mon, Mar 20, 2023 at 2:23 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The perf tool has a class of memory problems where reference counts
> > are used incorrectly. Memory/address sanitizers and valgrind don't
> > provide useful ways to debug these problems, you see a memory leak
> > where the only pertinent information is the original allocation
> > site. What would be more useful is knowing where a get fails to have a
> > corresponding put, where there are double puts, etc.
> >
> > This work was motivated by the roll-back of:
> > https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
> > where fixing a missed put resulted in a use-after-free in a different
> > context. There was a sense in fixing the issue that a game of
> > wac-a-mole had been embarked upon in adding missed gets and puts.
> >
> > The basic approach of the change is to add a level of indirection at
> > the get and put calls. Get allocates a level of indirection that, if
> > no corresponding put is called, becomes a memory leak (and associated
> > stack trace) that leak sanitizer can report. Similarly if two puts are
> > called for the same get, then a double free can be detected by address
> > sanitizer. This can also detect the use after put, which should also
> > yield a segv without a sanitizer.
> >
> > Adding reference count checking to cpu map was done as a proof of
> > concept, it yielded little other than a location where the use of get
> > could be cleaner by using its result. Reference count checking on
> > nsinfo identified a double free of the indirection layer and the
> > related threads, thereby identifying a data race as discussed here:
> >  https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
> > Accordingly the dso->lock was extended and use to cover the race.
> >
> > The v3 version addresses problems in v2, in particular using macros to
> > avoid #ifdefs. The v3 version applies the reference count checking
> > approach to two more data structures, maps and map. While maps was
> > straightforward, struct map showed a problem where reference counted
> > thing can be on lists and rb-trees that are oblivious to the
> > reference count. To sanitize this, struct map is changed so that it is
> > referenced by either a list or rb-tree node and not part of it. This
> > simplifies the reference count and the patches have caught and fixed a
> > number of missed or mismatched reference counts relating to struct
> > map.
> >
> > The patches are arranged so that API refactors and bug fixes appear
> > first, then the reference count checker itself appears. This allows
> > for the refactor and fixes to be applied upstream first, as has
> > already happened with cpumap.
> >
> > A wider discussion of the approach is on the mailing list:
> >  https://lore.kernel.org/linux-perf-users/YffqnynWcc5oFkI5@kernel.org/T/#mf25ccd7a2e03de92cec29d36e2999a8ab5ec7f88
> > Comparing it to a past approach:
> >  https://lore.kernel.org/all/20151209021047.10245.8918.stgit@localhost.localdomain/
> > and to ref_tracker:
> >  https://lwn.net/Articles/877603/
> >
> > v5. rebase removing 5 merged changes. Add map_list_node__new to the
> >     1st patch (perf map: Move map list node into symbol) as suggested
> >     by Arnaldo. Remove unnecessary map__puts from patch 12 (perf map:
> >     Changes to reference counting) as suggested by Adrian. A summary
> >     of the sizes of the remaining patches is:
> > 74fd7ffafdd0 perf map: Add reference count checking
> >  12 files changed, 136 insertions(+), 114 deletions(-)
> > 4719196db8d3 perf maps: Add reference count checking.
> >  8 files changed, 64 insertions(+), 56 deletions(-)
> > 03943e7594cf perf namespaces: Add reference count checking
> >  7 files changed, 83 insertions(+), 62 deletions(-)
> > 0bb382cc52d7 perf cpumap: Add reference count checking
> >  6 files changed, 81 insertions(+), 71 deletions(-)
> > ef39f550c40d libperf: Add reference count checking macros.
> >  1 file changed, 94 insertions(+)
> > d9ac37c750e0 perf map: Changes to reference counting
> >  11 files changed, 112 insertions(+), 44 deletions(-)
> > 476014bc9b55 perf maps: Modify maps_by_name to hold a reference to a map
> >  2 files changed, 33 insertions(+), 18 deletions(-)
> > 91384676fddd perf test: Add extra diagnostics to maps test
> >  1 file changed, 36 insertions(+), 15 deletions(-)
> > fdc30434f826 perf map: Add accessors for pgoff and reloc
> >  9 files changed, 33 insertions(+), 23 deletions(-)
> > 368fe015adb2 perf map: Add accessors for prot, priv and flags
> >  6 files changed, 28 insertions(+), 12 deletions(-)
> > 2c6a8169826a perf map: Add helper for map_ip and unmap_ip
> >  23 files changed, 80 insertions(+), 65 deletions(-)
> > 929e59d49f4b perf map: Rename map_ip and unmap_ip
> >  6 files changed, 13 insertions(+), 13 deletions(-)
> > 4a38194aaaf5 perf map: Add accessor for start and end
> >  24 files changed, 114 insertions(+), 103 deletions(-)
> > 02b63e5c415e perf map: Add accessor for dso
> >  48 files changed, 404 insertions(+), 293 deletions(-)
> > 9324af6ccf42 perf maps: Add functions to access maps
> >  20 files changed, 175 insertions(+), 111 deletions(-)
> > 5c590d36a308 perf maps: Remove rb_node from struct map
> >  16 files changed, 291 insertions(+), 184 deletions(-)
> > af1d142eb777 perf map: Move map list node into symbol
> >  2 files changed, 63 insertions(+), 35 deletions(-)
> >
> > v4. rebases on to acme's perf-tools-next, fixes more issues with
> >     map/maps and breaks apart the accessor functions to reduce
> >     individual patch sizes. The accessor functions are mechanical
> >     changes where the single biggest one is refactoring use of
> >     map->dso to be map__dso(map).
> >
> > The v3 change is available here:
> > https://lore.kernel.org/lkml/20220211103415.2737789-1-irogers@google.com/
> >
> > Ian Rogers (17):
> >   perf map: Move map list node into symbol
> >   perf maps: Remove rb_node from struct map
> >   perf maps: Add functions to access maps
> >   perf map: Add accessor for dso
> >   perf map: Add accessor for start and end
> >   perf map: Rename map_ip and unmap_ip
> >   perf map: Add helper for map_ip and unmap_ip
> >   perf map: Add accessors for prot, priv and flags
> >   perf map: Add accessors for pgoff and reloc
> >   perf test: Add extra diagnostics to maps test
> >   perf maps: Modify maps_by_name to hold a reference to a map
> >   perf map: Changes to reference counting
> >   libperf: Add reference count checking macros.
> >   perf cpumap: Add reference count checking
> >   perf namespaces: Add reference count checking
> >   perf maps: Add reference count checking.
> >   perf map: Add reference count checking
> >
> >  tools/lib/perf/Makefile                       |   2 +-
> >  tools/lib/perf/cpumap.c                       |  94 ++---
> >  tools/lib/perf/include/internal/cpumap.h      |   4 +-
> >  tools/lib/perf/include/internal/rc_check.h    |  94 +++++
> >  tools/perf/arch/s390/annotate/instructions.c  |   4 +-
> >  tools/perf/arch/x86/tests/dwarf-unwind.c      |   2 +-
> >  tools/perf/arch/x86/util/event.c              |  13 +-
> >  tools/perf/builtin-annotate.c                 |  11 +-
> >  tools/perf/builtin-buildid-list.c             |   4 +-
> >  tools/perf/builtin-inject.c                   |  12 +-
> >  tools/perf/builtin-kallsyms.c                 |   6 +-
> >  tools/perf/builtin-kmem.c                     |   4 +-
> >  tools/perf/builtin-lock.c                     |   4 +-
> >  tools/perf/builtin-mem.c                      |  10 +-
> >  tools/perf/builtin-report.c                   |  26 +-
> >  tools/perf/builtin-script.c                   |  27 +-
> >  tools/perf/builtin-top.c                      |  17 +-
> >  tools/perf/builtin-trace.c                    |   2 +-
> >  .../scripts/python/Perf-Trace-Util/Context.c  |  13 +-
> >  tools/perf/tests/code-reading.c               |  37 +-
> >  tools/perf/tests/cpumap.c                     |   4 +-
> >  tools/perf/tests/hists_common.c               |   8 +-
> >  tools/perf/tests/hists_cumulate.c             |  14 +-
> >  tools/perf/tests/hists_filter.c               |  14 +-
> >  tools/perf/tests/hists_link.c                 |  18 +-
> >  tools/perf/tests/hists_output.c               |  12 +-
> >  tools/perf/tests/maps.c                       |  69 ++--
> >  tools/perf/tests/mmap-thread-lookup.c         |   3 +-
> >  tools/perf/tests/symbols.c                    |   6 +-
> >  tools/perf/tests/thread-maps-share.c          |  29 +-
> >  tools/perf/tests/vmlinux-kallsyms.c           |  54 +--
> >  tools/perf/ui/browsers/annotate.c             |   9 +-
> >  tools/perf/ui/browsers/hists.c                |  19 +-
> >  tools/perf/ui/browsers/map.c                  |   4 +-
> >  tools/perf/util/annotate.c                    |  40 ++-
> >  tools/perf/util/auxtrace.c                    |   2 +-
> >  tools/perf/util/block-info.c                  |   4 +-
> >  tools/perf/util/bpf-event.c                   |  10 +-
> >  tools/perf/util/bpf_lock_contention.c         |   6 +-
> >  tools/perf/util/build-id.c                    |   2 +-
> >  tools/perf/util/callchain.c                   |  24 +-
> >  tools/perf/util/cpumap.c                      |  40 ++-
> >  tools/perf/util/data-convert-json.c           |  10 +-
> >  tools/perf/util/db-export.c                   |  16 +-
> >  tools/perf/util/dlfilter.c                    |  28 +-
> >  tools/perf/util/dso.c                         |   8 +-
> >  tools/perf/util/dsos.c                        |   2 +-
> >  tools/perf/util/event.c                       |  27 +-
> >  tools/perf/util/evsel_fprintf.c               |   4 +-
> >  tools/perf/util/hist.c                        |  22 +-
> >  tools/perf/util/intel-pt.c                    |  63 ++--
> >  tools/perf/util/machine.c                     | 252 ++++++++------
> >  tools/perf/util/map.c                         | 217 ++++++------
> >  tools/perf/util/map.h                         |  74 +++-
> >  tools/perf/util/maps.c                        | 318 ++++++++++-------
> >  tools/perf/util/maps.h                        |  67 +++-
> >  tools/perf/util/namespaces.c                  | 132 +++++---
> >  tools/perf/util/namespaces.h                  |   3 +-
> >  tools/perf/util/pmu.c                         |   8 +-
> >  tools/perf/util/probe-event.c                 |  62 ++--
> >  .../util/scripting-engines/trace-event-perl.c |  10 +-
> >  .../scripting-engines/trace-event-python.c    |  26 +-
> >  tools/perf/util/sort.c                        |  67 ++--
> >  tools/perf/util/symbol-elf.c                  |  41 ++-
> >  tools/perf/util/symbol.c                      | 320 +++++++++++-------
> >  tools/perf/util/symbol_fprintf.c              |   2 +-
> >  tools/perf/util/synthetic-events.c            |  34 +-
> >  tools/perf/util/thread-stack.c                |   4 +-
> >  tools/perf/util/thread.c                      |  39 +--
> >  tools/perf/util/unwind-libdw.c                |  20 +-
> >  tools/perf/util/unwind-libunwind-local.c      |  16 +-
> >  tools/perf/util/unwind-libunwind.c            |  33 +-
> >  tools/perf/util/vdso.c                        |   7 +-
> >  73 files changed, 1665 insertions(+), 1044 deletions(-)
> >  create mode 100644 tools/lib/perf/include/internal/rc_check.h
> >
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >

-- 

- Arnaldo
