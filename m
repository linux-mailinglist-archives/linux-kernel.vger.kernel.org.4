Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D757A6DB6C6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDGXEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDGXEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:04:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531ACC08
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 16:04:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z4-20020a25bb04000000b00b392ae70300so43700581ybg.21
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680908669;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uTKSSYmniB+LEnhXxM03AxYTLMkdjrfWvT6FhNB+Q7g=;
        b=nN+dsEwkyiIogTmorI5uSQRsi9cy/FJYwLwU11t1d42HAoqT+L/2mZxubGGkmZS1X1
         Av+OCpdIUNl0h5XMEKU5Wie0Wn+H4dqiHsrhlPYEBy9Jpf2G9dwxKsGNaa19QIo3QW0s
         WNUPb+VEX/PFnz75sD/E1MJgpFiUMGAj7cfmaNzITKVwTlv7KocEFMU3vnpYWedtkTjA
         iSTxh5IaKbAj3Ig1fQoMcxte9DO/9PkN6NYU1FxQ/B0QmeTbQtC1AaE544B5/JAYPTes
         EjpYd/ooxMLzA9lTG6QljMFqlmmoSEQmHUhQXEq+MbdZvThkRd/OZ1/LgsjiuMiOV5zM
         OufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680908669;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTKSSYmniB+LEnhXxM03AxYTLMkdjrfWvT6FhNB+Q7g=;
        b=XIT4YH2ksXaISUFlQE1IV8NBSqsxp5pH2FLOCvTMeTQKC87FIzwQMo1Qfugipx8lsq
         2VcqrU5Rql7ED1Gq2I6T9S6hwT0F1WUYaBhGaBRDQ7Y7mPPSM1s2Z14aqcerzibB1vQv
         Z5M3jHTbHjI8thvMgf8mhR3nZ/vd2mUEOQekBDh+/HmasWl+1+D9exLVV0jdc0xoJ+pm
         DquL1OeCZyj2gw8quoulavLYOjx0HtF4SLrCiZnIj2qp7VmIvxE0Z9alpmJdDRDOSQgN
         Hy5pK9ciN06O04uy+ac31qajfRbX2HAmRq0hfOG3BRGzitu4gwJ6ps6I2CAz33ZshW8M
         05Lg==
X-Gm-Message-State: AAQBX9cyecd0J3gyWOFFJO20kdAEPVImZEIBxiIS63RGrPItSAPQExPV
        bH+PNP1oTc1k5kcd1K7zRg5bERtF2uig
X-Google-Smtp-Source: AKy350Z0K/5LChd8MuOvH3Yl5jqduZI2YW0nHSl1ZgLzbixzQua92cYH6Wpgv4HMaak6d8T2CY26ma/oDEqx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b240:9cdf:7861:b23e])
 (user=irogers job=sendgmr) by 2002:a25:7341:0:b0:acd:7374:f15b with SMTP id
 o62-20020a257341000000b00acd7374f15bmr2616504ybc.13.1680908669372; Fri, 07
 Apr 2023 16:04:29 -0700 (PDT)
Date:   Fri,  7 Apr 2023 16:04:00 -0700
Message-Id: <20230407230405.2931830-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v7 0/5] Reference count checker and related fixes
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

A wider discussion of the approach is on the mailing list:
 https://lore.kernel.org/linux-perf-users/YffqnynWcc5oFkI5@kernel.org/T/#mf25ccd7a2e03de92cec29d36e2999a8ab5ec7f88
Comparing it to a past approach:
 https://lore.kernel.org/all/20151209021047.10245.8918.stgit@localhost.localdomain/
and to ref_tracker:
 https://lwn.net/Articles/877603/

v7. rebase on top of merged and Arnaldo fixed changes. The remaining 5
    patches no longer refactor APIs but just add the necessary
    reference count checking macros and usage.
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

Ian Rogers (5):
  libperf: Add reference count checking macros.
  perf cpumap: Add reference count checking
  perf namespaces: Add reference count checking
  perf maps: Add reference count checking.
  perf map: Add reference count checking

 tools/lib/perf/Makefile                    |   2 +-
 tools/lib/perf/cpumap.c                    |  94 ++++++++-------
 tools/lib/perf/include/internal/cpumap.h   |   4 +-
 tools/lib/perf/include/internal/rc_check.h |  94 +++++++++++++++
 tools/perf/builtin-inject.c                |   2 +-
 tools/perf/builtin-top.c                   |   4 +-
 tools/perf/tests/cpumap.c                  |   4 +-
 tools/perf/tests/hists_link.c              |   2 +-
 tools/perf/tests/maps.c                    |  20 ++--
 tools/perf/tests/thread-maps-share.c       |  29 ++---
 tools/perf/tests/vmlinux-kallsyms.c        |   4 +-
 tools/perf/util/annotate.c                 |   2 +-
 tools/perf/util/cpumap.c                   |  40 +++----
 tools/perf/util/dso.c                      |   2 +-
 tools/perf/util/dsos.c                     |   2 +-
 tools/perf/util/machine.c                  |  27 +++--
 tools/perf/util/map.c                      |  69 ++++++-----
 tools/perf/util/map.h                      |  32 ++---
 tools/perf/util/maps.c                     |  64 +++++-----
 tools/perf/util/maps.h                     |  17 +--
 tools/perf/util/namespaces.c               | 132 ++++++++++++---------
 tools/perf/util/namespaces.h               |   3 +-
 tools/perf/util/pmu.c                      |   8 +-
 tools/perf/util/symbol-elf.c               |  26 ++--
 tools/perf/util/symbol.c                   |  55 +++++----
 tools/perf/util/unwind-libdw.c             |   2 +-
 tools/perf/util/unwind-libunwind-local.c   |   2 +-
 tools/perf/util/unwind-libunwind.c         |   2 +-
 28 files changed, 448 insertions(+), 296 deletions(-)
 create mode 100644 tools/lib/perf/include/internal/rc_check.h

-- 
2.40.0.577.gac1e443424-goog

