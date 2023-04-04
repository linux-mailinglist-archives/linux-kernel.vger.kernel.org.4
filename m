Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640A66D6E89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbjDDVA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjDDVA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:00:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4074C1F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:00:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q15-20020a63d60f000000b00502e1c551aaso10067445pgg.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680642020;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E72anTF+m9p2XMQCnePCzHs8PJXkkiUiGWLNYcnkI5E=;
        b=V5VdeesVgHMRHs7jYzVAzB4N4K1xh37ljpwDHNRho8nc5DYEt/oRd3NxzOxIB2I+i9
         PFDNVWRDou/kPwFYCN5mXxirhzlfAP2i39DHrvQmJTcr2trfdXwEI6jFSdC0NA+o27o2
         ik3aNmwPsjgF4r3BYWhmw64nQWhL3tModU6BeAsIsT9TwVqSmSw94UcWtsQBuQbI8sdl
         WM/wq2qPfUWzKjYcGnVhuW8JrHXU/KoiPLQEJcl+WWPo8/x6kAz9euIT8zfbbraEp/S4
         I2ROTNZhgEduyzoVrPfG4FuomZSx/gif+98GqHS4tSBeQpVWGgasR0T9VUV5yrmHQCSt
         q3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642020;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E72anTF+m9p2XMQCnePCzHs8PJXkkiUiGWLNYcnkI5E=;
        b=g56uyvNxa1R8UHdMrdEN7OrjBuMfjBefq16dGAYP65QiMliIUnDVIWDuKv0Ls1GOeI
         bG7vW31JcbDxdR9eufxzTN3R/R/HomzTKFWYaCmFGFImVPdI1cFDYLF3WWGWRUM29HUx
         YO+CtLNOMh2KJjSyO2lVprSvpcC1xcHdpv/FzWzmsIMfQFD9uO+SGHiqBhZcrYdN705h
         EQYYIRYRDMXkDkdoJWuV2whLR1bE5UnIDjvtcXvncMLKgyW9uqblZOqd+AKkIWOYKiZw
         yhrkFOwDCsXdEs/KOTjld1w0rbsYYVq4IGIJGDmPQoVBTVy6ruRPgfLwnDk1TOmnWkYe
         FlIA==
X-Gm-Message-State: AAQBX9cVWUHDVA1su0Rr9DrLH1eh8lOvhQGupkidvb4T+3id707LcZFb
        9JIjYis17dGz1VhIJ26bS+eDH1A0DgZ2
X-Google-Smtp-Source: AKy350Z21LbMubmGWlJbX9O8Nztw4PDfQKcyPQ9OV92Ns68hiCJRvGA6SnDYYVdufuaLyAfpXtjHqKshZ51b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a17:90a:3dc3:b0:23f:63b3:f164 with SMTP id
 i61-20020a17090a3dc300b0023f63b3f164mr1496550pjc.3.1680642020433; Tue, 04 Apr
 2023 14:00:20 -0700 (PDT)
Date:   Tue,  4 Apr 2023 13:59:42 -0700
Message-Id: <20230404205954.2245628-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v6 00/12] Reference count checker and related fixes
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

v6. rebase removing 5 merged changes. Fix missed issues with libunwind.
v5. rebase removing 5 merged changes. Add map_list_node__new to the
    1st patch (perf map: Move map list node into symbol) as suggested
    by Arnaldo. Remove unnecessary map__puts from patch 12 (perf map:
    Changes to reference counting) as suggested by Adrian.
v4. rebases on to acme's perf-tools-next, fixes more issues with
    map/maps and breaks apart the accessor functions to reduce
    individual patch sizes. The accessor functions are mechanical
    changes where the single biggest one is refactoring use of
    map->dso to be map__dso(map).

The v3 change is available here:
https://lore.kernel.org/lkml/20220211103415.2737789-1-irogers@google.com/

Ian Rogers (12):
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
 tools/lib/perf/cpumap.c                       |  94 +++++++------
 tools/lib/perf/include/internal/cpumap.h      |   4 +-
 tools/lib/perf/include/internal/rc_check.h    |  94 +++++++++++++
 tools/perf/arch/s390/annotate/instructions.c  |   4 +-
 tools/perf/arch/x86/util/event.c              |   2 +-
 tools/perf/builtin-inject.c                   |   4 +-
 tools/perf/builtin-kallsyms.c                 |   2 +-
 tools/perf/builtin-kmem.c                     |   4 +-
 tools/perf/builtin-lock.c                     |   4 +-
 tools/perf/builtin-report.c                   |  11 +-
 tools/perf/builtin-script.c                   |   6 +-
 tools/perf/builtin-top.c                      |   4 +-
 tools/perf/tests/code-reading.c               |   1 +
 tools/perf/tests/cpumap.c                     |   4 +-
 tools/perf/tests/hists_cumulate.c             |  10 ++
 tools/perf/tests/hists_filter.c               |  10 ++
 tools/perf/tests/hists_link.c                 |  18 ++-
 tools/perf/tests/hists_output.c               |  10 ++
 tools/perf/tests/maps.c                       |  67 ++++++---
 tools/perf/tests/mmap-thread-lookup.c         |   1 +
 tools/perf/tests/thread-maps-share.c          |  29 ++--
 tools/perf/tests/vmlinux-kallsyms.c           |  22 +--
 tools/perf/util/annotate.c                    |  20 +--
 tools/perf/util/bpf_lock_contention.c         |   4 +-
 tools/perf/util/callchain.c                   |   9 +-
 tools/perf/util/cpumap.c                      |  40 +++---
 tools/perf/util/dlfilter.c                    |   2 +-
 tools/perf/util/dso.c                         |   8 +-
 tools/perf/util/dsos.c                        |   2 +-
 tools/perf/util/event.c                       |  14 +-
 tools/perf/util/evsel_fprintf.c               |   2 +-
 tools/perf/util/hist.c                        |  10 +-
 tools/perf/util/intel-pt.c                    |  10 +-
 tools/perf/util/machine.c                     | 126 ++++++++++-------
 tools/perf/util/map.c                         |  95 +++++++------
 tools/perf/util/map.h                         |  57 ++++++--
 tools/perf/util/maps.c                        | 100 +++++++------
 tools/perf/util/maps.h                        |  17 +--
 tools/perf/util/namespaces.c                  | 132 ++++++++++--------
 tools/perf/util/namespaces.h                  |   3 +-
 tools/perf/util/pmu.c                         |   8 +-
 tools/perf/util/probe-event.c                 |  14 +-
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/sort.c                        |  18 +--
 tools/perf/util/symbol-elf.c                  |  26 ++--
 tools/perf/util/symbol.c                      |  88 +++++++-----
 tools/perf/util/thread.c                      |   2 +-
 tools/perf/util/unwind-libdw.c                |  10 +-
 tools/perf/util/unwind-libunwind-local.c      |   4 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 51 files changed, 766 insertions(+), 466 deletions(-)
 create mode 100644 tools/lib/perf/include/internal/rc_check.h

-- 
2.40.0.348.gf938b09366-goog

