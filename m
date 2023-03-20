Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061A36C238D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCTVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCTVXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:23:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D83520686
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544d2dc2649so89027767b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347383;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JoxCGzwoNxMNf6h7IxJDrhVxKGanKm4jEu+1jKn9MQ8=;
        b=CC74bgqB7hmvyDaaA6d+wflRfoeN2vNIDQQcz3fxofwo98uyRZAz6t5P1wf7YO+ypZ
         jK4KrXHXuSoMtGm9LhmNRevTl+Mc/u+dCvmozVhhsd8ZMID1Dn6JQjzYgAAyOdOtDpum
         3N345h8cplcZeve6VBYbUfiyM7JQLeBt7rP8u/oMul1HScf21yiBGgcJiSIOki00OoM+
         vIS4IWrVLSzhfzsmS5gmyWVJDe1t1Nt5kSoStPesNrT1et3vnmROQPnZO7RTWcdXVIpe
         Zsja+k1+wqlfgxCOwClHEyyyJaVq1Lp2+d6nlu/8uIbg+N84X4I2mWYODimeDF7ywvlq
         fhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347383;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JoxCGzwoNxMNf6h7IxJDrhVxKGanKm4jEu+1jKn9MQ8=;
        b=uyd+Iia0BA27Pq/mtMUfR83oNNkZregRQQSRa1kzH/Nm18rVlxWIFjJ+HAHQImOPxD
         746yRwgI724PTZOyfbOnWxO8NBBOIlxquX7ngCutPQveo/CPsO5qTD7elm7FdbMkFolv
         UYjWwGQgjaUlqeglf8GxRB7omwnf17drkWomTS/M709gxhjQDoqE8apBJZRfyuO/Hq43
         BLA3bHN/BQa/U7TtX6/Lb2g574E9CkIBJDsw7cbpoVZhfP/g4QAkl35QfD7OyZeRg9xp
         TxJuu9IqcMoLdKKqFjPqMxB9sNfPYZJQydCq7dCDyfWMvi/EXokTHu4g1Bpe1OdQ9Uyn
         Iu2A==
X-Gm-Message-State: AO0yUKXtuibWcK6TarJ15AcBD9t9sWbNn1yIiP0lu17+JRmHyZKySH4u
        qrWA0pXhGsvgDxQBLW4h2w+V++cC17H0
X-Google-Smtp-Source: AK7set/TFRMgMsJrgMOU62LHw53sX046VvQ/XtYiYHjkklzkotQh3bP9yhFAoBKoubK1Ei21d3RNjXU+M5XO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a81:a783:0:b0:545:1d7f:ac7a with SMTP id
 e125-20020a81a783000000b005451d7fac7amr2489989ywh.7.1679347382744; Mon, 20
 Mar 2023 14:23:02 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:31 -0700
Message-Id: <20230320212248.1175731-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 00/17] Reference count checker and related fixes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf tool has a class of memory problems where reference counts
are used incorrectly. Memory/address sanitizers and valgrind don't
provide useful ways to debug these problems, you see a memory leak
where the only pertinent information is the original allocation
site. What would be more useful is knowing where a get fails to have a
corresponding put, where there are double puts, etc.

This work was motivated by the roll-back of:
https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
where fixing a missed put resulted in a use-after-free in a different
context. There was a sense in fixing the issue that a game of
wac-a-mole had been embarked upon in adding missed gets and puts.

The basic approach of the change is to add a level of indirection at
the get and put calls. Get allocates a level of indirection that, if
no corresponding put is called, becomes a memory leak (and associated
stack trace) that leak sanitizer can report. Similarly if two puts are
called for the same get, then a double free can be detected by address
sanitizer. This can also detect the use after put, which should also
yield a segv without a sanitizer.

Adding reference count checking to cpu map was done as a proof of
concept, it yielded little other than a location where the use of get
could be cleaner by using its result. Reference count checking on
nsinfo identified a double free of the indirection layer and the
related threads, thereby identifying a data race as discussed here:
 https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
Accordingly the dso->lock was extended and use to cover the race.

The v3 version addresses problems in v2, in particular using macros to
avoid #ifdefs. The v3 version applies the reference count checking
approach to two more data structures, maps and map. While maps was
straightforward, struct map showed a problem where reference counted
thing can be on lists and rb-trees that are oblivious to the
reference count. To sanitize this, struct map is changed so that it is
referenced by either a list or rb-tree node and not part of it. This
simplifies the reference count and the patches have caught and fixed a
number of missed or mismatched reference counts relating to struct
map.

The patches are arranged so that API refactors and bug fixes appear
first, then the reference count checker itself appears. This allows
for the refactor and fixes to be applied upstream first, as has
already happened with cpumap.

A wider discussion of the approach is on the mailing list:
 https://lore.kernel.org/linux-perf-users/YffqnynWcc5oFkI5@kernel.org/T/#mf25ccd7a2e03de92cec29d36e2999a8ab5ec7f88
Comparing it to a past approach:
 https://lore.kernel.org/all/20151209021047.10245.8918.stgit@localhost.localdomain/
and to ref_tracker:
 https://lwn.net/Articles/877603/

v5. rebase removing 5 merged changes. Add map_list_node__new to the
    1st patch (perf map: Move map list node into symbol) as suggested
    by Arnaldo. Remove unnecessary map__puts from patch 12 (perf map:
    Changes to reference counting) as suggested by Adrian. A summary
    of the sizes of the remaining patches is:
74fd7ffafdd0 perf map: Add reference count checking
 12 files changed, 136 insertions(+), 114 deletions(-)
4719196db8d3 perf maps: Add reference count checking.
 8 files changed, 64 insertions(+), 56 deletions(-)
03943e7594cf perf namespaces: Add reference count checking
 7 files changed, 83 insertions(+), 62 deletions(-)
0bb382cc52d7 perf cpumap: Add reference count checking
 6 files changed, 81 insertions(+), 71 deletions(-)
ef39f550c40d libperf: Add reference count checking macros.
 1 file changed, 94 insertions(+)
d9ac37c750e0 perf map: Changes to reference counting
 11 files changed, 112 insertions(+), 44 deletions(-)
476014bc9b55 perf maps: Modify maps_by_name to hold a reference to a map
 2 files changed, 33 insertions(+), 18 deletions(-)
91384676fddd perf test: Add extra diagnostics to maps test
 1 file changed, 36 insertions(+), 15 deletions(-)
fdc30434f826 perf map: Add accessors for pgoff and reloc
 9 files changed, 33 insertions(+), 23 deletions(-)
368fe015adb2 perf map: Add accessors for prot, priv and flags
 6 files changed, 28 insertions(+), 12 deletions(-)
2c6a8169826a perf map: Add helper for map_ip and unmap_ip
 23 files changed, 80 insertions(+), 65 deletions(-)
929e59d49f4b perf map: Rename map_ip and unmap_ip
 6 files changed, 13 insertions(+), 13 deletions(-)
4a38194aaaf5 perf map: Add accessor for start and end
 24 files changed, 114 insertions(+), 103 deletions(-)
02b63e5c415e perf map: Add accessor for dso
 48 files changed, 404 insertions(+), 293 deletions(-)
9324af6ccf42 perf maps: Add functions to access maps
 20 files changed, 175 insertions(+), 111 deletions(-)
5c590d36a308 perf maps: Remove rb_node from struct map
 16 files changed, 291 insertions(+), 184 deletions(-)
af1d142eb777 perf map: Move map list node into symbol
 2 files changed, 63 insertions(+), 35 deletions(-)
 
v4. rebases on to acme's perf-tools-next, fixes more issues with
    map/maps and breaks apart the accessor functions to reduce
    individual patch sizes. The accessor functions are mechanical
    changes where the single biggest one is refactoring use of
    map->dso to be map__dso(map).

The v3 change is available here:
https://lore.kernel.org/lkml/20220211103415.2737789-1-irogers@google.com/

Ian Rogers (17):
  perf map: Move map list node into symbol
  perf maps: Remove rb_node from struct map
  perf maps: Add functions to access maps
  perf map: Add accessor for dso
  perf map: Add accessor for start and end
  perf map: Rename map_ip and unmap_ip
  perf map: Add helper for map_ip and unmap_ip
  perf map: Add accessors for prot, priv and flags
  perf map: Add accessors for pgoff and reloc
  perf test: Add extra diagnostics to maps test
  perf maps: Modify maps_by_name to hold a reference to a map
  perf map: Changes to reference counting
  libperf: Add reference count checking macros.
  perf cpumap: Add reference count checking
  perf namespaces: Add reference count checking
  perf maps: Add reference count checking.
  perf map: Add reference count checking

 tools/lib/perf/Makefile                       |   2 +-
 tools/lib/perf/cpumap.c                       |  94 ++---
 tools/lib/perf/include/internal/cpumap.h      |   4 +-
 tools/lib/perf/include/internal/rc_check.h    |  94 +++++
 tools/perf/arch/s390/annotate/instructions.c  |   4 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c      |   2 +-
 tools/perf/arch/x86/util/event.c              |  13 +-
 tools/perf/builtin-annotate.c                 |  11 +-
 tools/perf/builtin-buildid-list.c             |   4 +-
 tools/perf/builtin-inject.c                   |  12 +-
 tools/perf/builtin-kallsyms.c                 |   6 +-
 tools/perf/builtin-kmem.c                     |   4 +-
 tools/perf/builtin-lock.c                     |   4 +-
 tools/perf/builtin-mem.c                      |  10 +-
 tools/perf/builtin-report.c                   |  26 +-
 tools/perf/builtin-script.c                   |  27 +-
 tools/perf/builtin-top.c                      |  17 +-
 tools/perf/builtin-trace.c                    |   2 +-
 .../scripts/python/Perf-Trace-Util/Context.c  |  13 +-
 tools/perf/tests/code-reading.c               |  37 +-
 tools/perf/tests/cpumap.c                     |   4 +-
 tools/perf/tests/hists_common.c               |   8 +-
 tools/perf/tests/hists_cumulate.c             |  14 +-
 tools/perf/tests/hists_filter.c               |  14 +-
 tools/perf/tests/hists_link.c                 |  18 +-
 tools/perf/tests/hists_output.c               |  12 +-
 tools/perf/tests/maps.c                       |  69 ++--
 tools/perf/tests/mmap-thread-lookup.c         |   3 +-
 tools/perf/tests/symbols.c                    |   6 +-
 tools/perf/tests/thread-maps-share.c          |  29 +-
 tools/perf/tests/vmlinux-kallsyms.c           |  54 +--
 tools/perf/ui/browsers/annotate.c             |   9 +-
 tools/perf/ui/browsers/hists.c                |  19 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/annotate.c                    |  40 ++-
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/block-info.c                  |   4 +-
 tools/perf/util/bpf-event.c                   |  10 +-
 tools/perf/util/bpf_lock_contention.c         |   6 +-
 tools/perf/util/build-id.c                    |   2 +-
 tools/perf/util/callchain.c                   |  24 +-
 tools/perf/util/cpumap.c                      |  40 ++-
 tools/perf/util/data-convert-json.c           |  10 +-
 tools/perf/util/db-export.c                   |  16 +-
 tools/perf/util/dlfilter.c                    |  28 +-
 tools/perf/util/dso.c                         |   8 +-
 tools/perf/util/dsos.c                        |   2 +-
 tools/perf/util/event.c                       |  27 +-
 tools/perf/util/evsel_fprintf.c               |   4 +-
 tools/perf/util/hist.c                        |  22 +-
 tools/perf/util/intel-pt.c                    |  63 ++--
 tools/perf/util/machine.c                     | 252 ++++++++------
 tools/perf/util/map.c                         | 217 ++++++------
 tools/perf/util/map.h                         |  74 +++-
 tools/perf/util/maps.c                        | 318 ++++++++++-------
 tools/perf/util/maps.h                        |  67 +++-
 tools/perf/util/namespaces.c                  | 132 +++++---
 tools/perf/util/namespaces.h                  |   3 +-
 tools/perf/util/pmu.c                         |   8 +-
 tools/perf/util/probe-event.c                 |  62 ++--
 .../util/scripting-engines/trace-event-perl.c |  10 +-
 .../scripting-engines/trace-event-python.c    |  26 +-
 tools/perf/util/sort.c                        |  67 ++--
 tools/perf/util/symbol-elf.c                  |  41 ++-
 tools/perf/util/symbol.c                      | 320 +++++++++++-------
 tools/perf/util/symbol_fprintf.c              |   2 +-
 tools/perf/util/synthetic-events.c            |  34 +-
 tools/perf/util/thread-stack.c                |   4 +-
 tools/perf/util/thread.c                      |  39 +--
 tools/perf/util/unwind-libdw.c                |  20 +-
 tools/perf/util/unwind-libunwind-local.c      |  16 +-
 tools/perf/util/unwind-libunwind.c            |  33 +-
 tools/perf/util/vdso.c                        |   7 +-
 73 files changed, 1665 insertions(+), 1044 deletions(-)
 create mode 100644 tools/lib/perf/include/internal/rc_check.h

-- 
2.40.0.rc1.284.g88254d51c5-goog

