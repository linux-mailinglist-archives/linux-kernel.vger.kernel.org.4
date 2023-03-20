Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6730A6C095D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCTDim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCTDih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:38:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2213FF965
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:38:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m13-20020a25800d000000b00b3dfeba6814so11670205ybk.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283514;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lEZYqTvAXtJtxMDl8FDOj3xVdVn2rBr2WTRC9CD3FD4=;
        b=KFItMDuePrfwDcnb1SmdlpjX8taeFZPACRXcf15WX7MqLcnAJlyKa9KmGXj1Yzgmtk
         eqWVLKwVu9twVUm1fNYgZ8Ekl7xFzAysVN7/VvufpyL+WorUE15pPj00TCmZx8NEUsWv
         E+oiV+2W/Wa4UAHxlnsYcMol+hWAVT8cazSWCH4xjhSyf4bQFcuWLNIjLXgGDGzri2dO
         PHo+RGR3s8+jUsI307wlqZJNu/S+xEY95joHun7MWI7ab0p1NUShBIIbHmn89rBUVNpl
         QcRVvKiDDMUoP2tUHFWmMeUTJiqlRI1hO3TLjRxxy7FhjO3MjTk6VnYifSm0qBBHsrBo
         sIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283514;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEZYqTvAXtJtxMDl8FDOj3xVdVn2rBr2WTRC9CD3FD4=;
        b=wAyzG6UOTMmvzQcV9CWuQMve9KiMSHn27j3xpmf4H2kDcWHi+grHFUj46yIBkidpT2
         8p2jbvQxkkkapfaBtw8gefXB8+GrIQrb3W/maHc1CxoFRUk2T7QkDVXXBssnnX0U7QBn
         MgRLNhb6G9A8Kkvg4uQycVfzVplbZsNXASR+Dhs6jvR+OiGO3xzUTCegSA2Yc0Ec0SYg
         9xyI3/bR10iVr2xlZ8pLFTSnClj8A9HSIdI+xiqIpCqGRD+iGe4r6neHvj0+zxm0acmw
         VxKJo29L8VfSwEJ34BydU3NBJgFE0jX2YRrWhzVsnRKZe+bueaAIa9foYQCzggj+9fnh
         DyVQ==
X-Gm-Message-State: AO0yUKU6T1DACaOl2/ajagnAZqWn+TYY2Nvd4P92ysrpLsZh/9kwp2ty
        vPj4wd7vhrH0GJsbUQZYsV4ijN7KYSM3
X-Google-Smtp-Source: AK7set9GQPL6P42ccI2PNSi17+UzRDe7MRmYUnCtluB0ZBEOKulpbRg3LrtW/zlgiUMlOipWp+RB2uzm8GM2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a05:6902:114b:b0:b09:6f3d:ea1f with SMTP
 id p11-20020a056902114b00b00b096f3dea1fmr4617820ybu.4.1679283514323; Sun, 19
 Mar 2023 20:38:34 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:37:48 -0700
Message-Id: <20230320033810.980165-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 00/22] Reference count checker and related fixes
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
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

v4. rebases on to acme's perf-tools-next, fixes more issues with
    map/maps and breaks apart the accessor functions to reduce
    individual patch sizes. The accessor functions are mechanical
    changes where the single biggest one is refactoring use of
    map->dso to be map__dso(map). A summary of the sizes of each patch
    is:

92e1b65b136b perf map: Add reference count checking
 12 files changed, 136 insertions(+), 114 deletions(-)
7fef12ca75a1 perf maps: Add reference count checking.
 8 files changed, 64 insertions(+), 56 deletions(-)
1a57842b86fd perf namespaces: Add reference count checking
 7 files changed, 83 insertions(+), 62 deletions(-)
6e50b206b364 perf cpumap: Add reference count checking
 6 files changed, 81 insertions(+), 71 deletions(-)
d64ebe641edd libperf: Add reference count checking macros.
 1 file changed, 94 insertions(+)
e0c3f6d95483 perf map: Changes to reference counting
 11 files changed, 114 insertions(+), 44 deletions(-)
d34755aef532 perf maps: Modify maps_by_name to hold a reference to a map
 2 files changed, 33 insertions(+), 18 deletions(-)
24c5eb40b0b4 perf test: Add extra diagnostics to maps test
 1 file changed, 36 insertions(+), 15 deletions(-)
1f1540178acf perf map: Add accessors for pgoff and reloc
 9 files changed, 33 insertions(+), 23 deletions(-)
a9f0c85f6269 perf map: Add accessors for prot, priv and flags
 6 files changed, 28 insertions(+), 12 deletions(-)
ee07e4fbbf8f perf map: Add helper for map_ip and unmap_ip
 23 files changed, 80 insertions(+), 65 deletions(-)
a2ff37e2d9c1 perf map: Rename map_ip and unmap_ip
 6 files changed, 13 insertions(+), 13 deletions(-)
285214010556 perf map: Add accessor for start and end
 24 files changed, 114 insertions(+), 103 deletions(-)
bcd608c93c81 perf map: Add accessor for dso
 48 files changed, 404 insertions(+), 293 deletions(-)
d921b7cb8254 perf maps: Add functions to access maps
 20 files changed, 175 insertions(+), 111 deletions(-)
3909794aab1c perf maps: Remove rb_node from struct map
 16 files changed, 291 insertions(+), 184 deletions(-)
c202320ec659 perf map: Move map list node into symbol
 2 files changed, 60 insertions(+), 35 deletions(-)
5f0c2abb3f6b perf symbol: Sort names under write lock
 1 file changed, 7 insertions(+)
38c930af7ecb perf test: Fix memory leak in symbols
 1 file changed, 1 insertion(+)
144f31b33eff perf tests: Add common error route for code-reading
 1 file changed, 23 insertions(+), 16 deletions(-)
d043380916fb perf bpf_counter: Use public cpumap accessors
 1 file changed, 3 insertions(+), 3 deletions(-)
08d8e5dd2277 perf symbol: Avoid memory leak from abi::__cxa_demangle
 1 file changed, 2 insertions(+), 3 deletions(-)

The v3 change is available here:
https://lore.kernel.org/lkml/20220211103415.2737789-1-irogers@google.com/

Ian Rogers (22):
  perf symbol: Avoid memory leak from abi::__cxa_demangle
  perf bpf_counter: Use public cpumap accessors
  perf tests: Add common error route for code-reading
  perf test: Fix memory leak in symbols
  perf symbol: Sort names under write lock
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
 tools/lib/perf/cpumap.c                       |  94 +++---
 tools/lib/perf/include/internal/cpumap.h      |   4 +-
 tools/lib/perf/include/internal/rc_check.h    |  94 ++++++
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
 tools/perf/tests/code-reading.c               |  76 +++--
 tools/perf/tests/cpumap.c                     |   4 +-
 tools/perf/tests/hists_common.c               |   8 +-
 tools/perf/tests/hists_cumulate.c             |  14 +-
 tools/perf/tests/hists_filter.c               |  14 +-
 tools/perf/tests/hists_link.c                 |  18 +-
 tools/perf/tests/hists_output.c               |  12 +-
 tools/perf/tests/maps.c                       |  69 ++--
 tools/perf/tests/mmap-thread-lookup.c         |   3 +-
 tools/perf/tests/symbols.c                    |   7 +-
 tools/perf/tests/thread-maps-share.c          |  29 +-
 tools/perf/tests/vmlinux-kallsyms.c           |  54 +--
 tools/perf/ui/browsers/annotate.c             |   9 +-
 tools/perf/ui/browsers/hists.c                |  19 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/annotate.c                    |  40 ++-
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/block-info.c                  |   4 +-
 tools/perf/util/bpf-event.c                   |  10 +-
 tools/perf/util/bpf_counter.c                 |   6 +-
 tools/perf/util/bpf_lock_contention.c         |   6 +-
 tools/perf/util/build-id.c                    |   2 +-
 tools/perf/util/callchain.c                   |  24 +-
 tools/perf/util/cpumap.c                      |  40 ++-
 tools/perf/util/data-convert-json.c           |  10 +-
 tools/perf/util/db-export.c                   |  16 +-
 tools/perf/util/demangle-cxx.cpp              |   5 +-
 tools/perf/util/dlfilter.c                    |  28 +-
 tools/perf/util/dso.c                         |   8 +-
 tools/perf/util/dsos.c                        |   2 +-
 tools/perf/util/event.c                       |  29 +-
 tools/perf/util/evsel_fprintf.c               |   4 +-
 tools/perf/util/hist.c                        |  22 +-
 tools/perf/util/intel-pt.c                    |  63 ++--
 tools/perf/util/machine.c                     | 252 ++++++++------
 tools/perf/util/map.c                         | 217 ++++++------
 tools/perf/util/map.h                         |  74 +++-
 tools/perf/util/maps.c                        | 318 +++++++++++-------
 tools/perf/util/maps.h                        |  67 +++-
 tools/perf/util/namespaces.c                  | 132 +++++---
 tools/perf/util/namespaces.h                  |   3 +-
 tools/perf/util/pmu.c                         |   8 +-
 tools/perf/util/probe-event.c                 |  62 ++--
 .../util/scripting-engines/trace-event-perl.c |  10 +-
 .../scripting-engines/trace-event-python.c    |  26 +-
 tools/perf/util/sort.c                        |  67 ++--
 tools/perf/util/symbol-elf.c                  |  41 ++-
 tools/perf/util/symbol.c                      | 316 +++++++++++------
 tools/perf/util/symbol_fprintf.c              |   2 +-
 tools/perf/util/synthetic-events.c            |  34 +-
 tools/perf/util/thread-stack.c                |   4 +-
 tools/perf/util/thread.c                      |  39 +--
 tools/perf/util/unwind-libdw.c                |  20 +-
 tools/perf/util/unwind-libunwind-local.c      |  16 +-
 tools/perf/util/unwind-libunwind.c            |  33 +-
 tools/perf/util/vdso.c                        |   7 +-
 75 files changed, 1696 insertions(+), 1062 deletions(-)
 create mode 100644 tools/lib/perf/include/internal/rc_check.h

-- 
2.40.0.rc1.284.g88254d51c5-goog

