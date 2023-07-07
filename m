Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6100674A9E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjGGE0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGGE0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:26:52 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9B6128;
        Thu,  6 Jul 2023 21:26:49 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56597d949b1so1019314eaf.1;
        Thu, 06 Jul 2023 21:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688704009; x=1691296009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sslbkYZ03ZbwNoyFkZQWJcWXRDoRvq2WZzO4r7Qr4yE=;
        b=GndchWyAu6ec/KeA9rwMGsmwqjkHIvlfY2qod7+RaLGp6QYLCKoPJmrx5nLDua+4O/
         B/DqLwvH/17zRHWO8c7Ix5061WJMRc18wSeaGGblTTmYTwIXTLEhkFDTjTzJmWtaeS43
         pmQXLXlJD6IqeVBLvBgA0UF8ZOPmbKJs03HnmtrUIi8P/MC57x99B3n8mETA39iG84ZO
         sk94i/o5yMsn86nNDPVGt1XToRYjhPaFWhFYgfodt7pngogUqgj6qJyYXmfQ6PYqEzPg
         THd6nHlF9luQhiwTD7gj4+bbBWVDQ+lMnmSoCCo2ttBybIGR1oj5vGeG7gKA6m7Rejya
         xMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704009; x=1691296009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sslbkYZ03ZbwNoyFkZQWJcWXRDoRvq2WZzO4r7Qr4yE=;
        b=Z/NpC2xm3JillvI3B4SZfaww2cYdX6dPFoE2Kp086uBOAcE3ma9p4yiBf/AaPNN8g9
         562YAvQhKbukjJ42h5MsfQVzg+3hyEQ9LLLQsYnE5pD4CcAca9i2vS/zI5ZdKcl9fw9P
         Q8Rl7JQPtsLxoH/+ivqmS27V02KhDApOPwBWhtQ0YZ2s7C1PmLGp5l9TurdqR+PfO16J
         TZDSJ2KxCXLp4NcyKz3wCSUH/t83LX9dF71jvXxWI7JG28WwrqHJc5fKbEUalx3SjQgC
         RWm4tQQqYXWzt0gY+AGpQnsfQXKQGtnV+R7jvFFqL1BYRMt11EFeBiBf2b+QJ1S+YOeA
         SyBQ==
X-Gm-Message-State: ABy/qLbr4IX8lsAZPuqIwlEBUWk+1P7Z0FOohXxKU+Dnc9d6RivgDeLq
        OcjRBSD2y9V0mNSN649ODio=
X-Google-Smtp-Source: APBJJlHj1F+ZqePkfDV8dtqKSQ7zS+yzOcLO3DTesmRyq0wOn3+2wMCzsZfTuNtYYDGfdP4i+jJ9Uw==
X-Received: by 2002:a05:6358:3399:b0:134:e035:70be with SMTP id i25-20020a056358339900b00134e03570bemr5043628rwd.12.1688704008659;
        Thu, 06 Jul 2023 21:26:48 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:c8fe:688e:3a03:5d5d])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902f68100b001b3f9a5d4besm2156042plg.255.2023.07.06.21.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 21:26:47 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf tools changes for v6.5: 2nd batch
Date:   Thu,  6 Jul 2023 21:26:44 -0700
Message-ID: <20230707042644.94061-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider pulling more perf tool changes.  These are remaining
changes and fixes for this cycle.  The last two fixes are relatively
new but other changes have been sitting on -next for a number of days.

Thanks,
Namhyung


The following changes since commit 4d60e83dfcee794213878155463d8f7353a80864:

  perf test: Skip metrics w/o event name in stat STD output linter (2023-06-23 21:35:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tags/perf-tools-for-v6.5-2-2023-07-06

for you to fetch changes up to bcd981db12e6d26111609802fc7c358f30a8c72a:

  perf test: Fix event parsing test when PERF_PMU_CAP_EXTENDED_HW_TYPE isn't supported. (2023-07-05 12:23:00 -0700)

----------------------------------------------------------------
perf tools changes and fixes for v6.5: 2nd batch

Build:

 - Allow to generate vmlinux.h from BTF using `make GEN_VMLINUX_H=1`
   and skip if the vmlinux has no BTF.

 - Replace deprecated clang -target xxx option by --target=xxx.

perf record:

 - Print event attributes with well known type and config symbols in the
   debug output like below:

    # perf record -e cycles,cpu-clock -C0 -vv true
    <SNIP>
    ------------------------------------------------------------
    perf_event_attr:
      type                             0 (PERF_TYPE_HARDWARE)
      size                             136
      config                           0 (PERF_COUNT_HW_CPU_CYCLES)
      { sample_period, sample_freq }   4000
      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
      read_format                      ID
      disabled                         1
      inherit                          1
      freq                             1
      sample_id_all                    1
      exclude_guest                    1
    ------------------------------------------------------------
    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
    ------------------------------------------------------------
    perf_event_attr:
      type                             1 (PERF_TYPE_SOFTWARE)
      size                             136
      config                           0 (PERF_COUNT_SW_CPU_CLOCK)
      { sample_period, sample_freq }   4000
      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
      read_format                      ID
      disabled                         1
      inherit                          1
      freq                             1
      sample_id_all                    1
      exclude_guest                    1

 - Update AMD IBS event error message since it now support per-process
   profiling but no priviledge filters.

    $ sudo perf record -e ibs_op//k -C 0
    Error:
    AMD IBS doesn't support privilege filtering. Try again without
    the privilege modifiers (like 'k') at the end.

perf lock contention:

 - Support CSV style output using -x option

    $ sudo perf lock con -ab -x, sleep 1
    # output: contended, total wait, max wait, avg wait, type, caller
    19, 194232, 21415, 10222, spinlock, process_one_work+0x1f0
    15, 162748, 23843, 10849, rwsem:R, do_user_addr_fault+0x40e
    4, 86740, 23415, 21685, rwlock:R, ep_poll_callback+0x2d
    1, 84281, 84281, 84281, mutex, iwl_mvm_async_handlers_wk+0x135
    8, 67608, 27404, 8451, spinlock, __queue_work+0x174
    3, 58616, 31125, 19538, rwsem:W, do_mprotect_pkey+0xff
    3, 52953, 21172, 17651, rwlock:W, do_epoll_wait+0x248
    2, 30324, 19704, 15162, rwsem:R, do_madvise+0x3ad
    1, 24619, 24619, 24619, spinlock, rcu_core+0xd4

 - Add --output option to save the data to a file not to be interfered
   by other debug messages.

Test:

 - Fix event parsing test on ARM where there's no raw PMU nor supports
   PERF_PMU_CAP_EXTENDED_HW_TYPE.

 - Update the lock contention test case for CSV output.

 - Fix a segfault in the daemon command test.

Vendor events (JSON):

 - Add has_event() to check if the given event is available on system
   at runtime.  On Intel machines, some transaction events may not be
   present when TSC extensions are disabled.

 - Update Intel event metrics.

Misc:

 - Sort symbols by name using an external array of pointers instead of
   a rbtree node in the symbol.  This will save 16-bytes or 24-bytes
   per symbol whether the sorting is actually requested or not.

 - Fix unwinding DWARF callstacks using libdw when --symfs option is
   used.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Fangrui Song (1):
      perf: Replace deprecated -target with --target= for Clang

Ian Rogers (21):
      perf build: Add ability to build with a generated vmlinux.h
      perf bpf: Move the declaration of struct rq
      perf test: Add build tests for BUILD_BPF_SKEL
      perf build: Filter out BTF sources without a .BTF section
      perf dso: Sort symbols under lock
      perf symbol: Remove symbol_name_rb_node
      perf symbol: Remove now unused symbol_conf.sort_by_name
      perf pmu: Correct auto_merge_stats test
      perf pmus: Add placeholder core PMU
      perf expr: Add has_event function
      perf jevents: Support for has_event function
      perf vendor metrics intel: Make transaction metrics conditional
      perf vendor events intel: Add rocketlake events/metrics
      perf vendor events intel: Update meteorlake to 1.03
      perf vendor events intel: Update cascadelakex to 1.19
      perf vendor events intel: Update icelake to 1.19
      perf vendor events intel: Update icelakex to 1.21
      perf vendor events intel: Update sapphirerapids to 1.14
      perf vendor events intel: Update skylake to 57
      perf vendor events intel: Update skylakex to 1.31
      perf vendor events intel: Update tigerlake to 1.13

James Clark (3):
      perf symbol: Fix uninitialized return value in symbols__find_by_name()
      perf test: Fix event parsing test on Arm
      perf test: Fix event parsing test when PERF_PMU_CAP_EXTENDED_HW_TYPE isn't supported.

Jiri Olsa (1):
      perf tools: Add missing else to cmd_daemon subcommand condition

Namhyung Kim (6):
      perf test: Fix a compile error on pe-file-parsing.c
      perf tools: Do not remove addr_location.thread in thread__find_map()
      perf lock: Remove stale comments
      perf lock contention: Add -x option for CSV style output
      perf lock contention: Add --output option
      perf test: Test perf lock contention CSV output

Ravi Bangoria (1):
      perf evsel amd: Fix IBS error message

Vincent Whitchurch (1):
      perf: unwind: Fix symfs with libdw

Yang Jihong (4):
      perf trace-event-info: Add tracepoint_id_to_name() helper
      perf tools: Extend PRINT_ATTRf to support printing of members with a value of 0
      perf tools: Add printing perf_event_attr type symbol in perf_event_attr__fprintf()
      perf tools: Add printing perf_event_attr config symbol in perf_event_attr__fprintf()

 tools/perf/Documentation/perf-config.txt           |    2 +-
 tools/perf/Documentation/perf-lock.txt             |    8 +
 tools/perf/Makefile.config                         |   17 +-
 tools/perf/Makefile.perf                           |   45 +-
 tools/perf/arch/x86/util/evsel.c                   |   20 +
 tools/perf/builtin-daemon.c                        |    2 +-
 tools/perf/builtin-kallsyms.c                      |    1 -
 tools/perf/builtin-lock.c                          |  385 +++--
 tools/perf/builtin-report.c                        |    1 -
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |    8 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |    8 +-
 .../pmu-events/arch/x86/cascadelakex/frontend.json |   43 +-
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |   17 +-
 .../arch/x86/cascadelakex/uncore-interconnect.json |    2 +-
 .../arch/x86/cascadelakex/uncore-memory.json       |    2 +-
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |    8 +-
 .../perf/pmu-events/arch/x86/icelake/frontend.json |   32 +-
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |    8 +-
 .../perf/pmu-events/arch/x86/icelake/pipeline.json |    6 +-
 .../pmu-events/arch/x86/icelakex/frontend.json     |   32 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |    8 +-
 .../pmu-events/arch/x86/icelakex/pipeline.json     |    4 +-
 .../arch/x86/icelakex/uncore-interconnect.json     |    2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   17 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |  811 ++++++++++
 .../arch/x86/meteorlake/floating-point.json        |  143 ++
 .../pmu-events/arch/x86/meteorlake/frontend.json   |  410 +++++
 .../pmu-events/arch/x86/meteorlake/memory.json     |  142 +-
 .../perf/pmu-events/arch/x86/meteorlake/other.json |   57 +-
 .../pmu-events/arch/x86/meteorlake/pipeline.json   | 1211 ++++++++++++++-
 .../arch/x86/meteorlake/uncore-cache.json          |   18 +
 .../arch/x86/meteorlake/uncore-interconnect.json   |   42 +
 .../arch/x86/meteorlake/uncore-memory.json         |  126 ++
 .../arch/x86/meteorlake/virtual-memory.json        |  257 ++++
 .../perf/pmu-events/arch/x86/rocketlake/cache.json |  894 +++++++++++
 .../arch/x86/rocketlake/floating-point.json        |  105 ++
 .../pmu-events/arch/x86/rocketlake/frontend.json   |  377 +++++
 .../pmu-events/arch/x86/rocketlake/memory.json     |  394 +++++
 .../arch/x86/rocketlake/metricgroups.json          |  113 ++
 .../perf/pmu-events/arch/x86/rocketlake/other.json |  242 +++
 .../pmu-events/arch/x86/rocketlake/pipeline.json   |  801 ++++++++++
 .../arch/x86/rocketlake/rkl-metrics.json           | 1571 ++++++++++++++++++++
 .../arch/x86/rocketlake/uncore-interconnect.json   |   74 +
 .../arch/x86/rocketlake/uncore-other.json          |    9 +
 .../arch/x86/rocketlake/virtual-memory.json        |  165 ++
 .../arch/x86/sapphirerapids/pipeline.json          |    2 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       |    8 +-
 .../arch/x86/sapphirerapids/uncore-cache.json      |  308 ++++
 .../x86/sapphirerapids/uncore-interconnect.json    |    2 +-
 .../perf/pmu-events/arch/x86/skylake/frontend.json |   43 +-
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |   17 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |    8 +-
 .../pmu-events/arch/x86/skylakex/frontend.json     |   43 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     |   17 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |    8 +-
 .../arch/x86/skylakex/uncore-interconnect.json     |    2 +-
 .../arch/x86/skylakex/uncore-memory.json           |    2 +-
 .../pmu-events/arch/x86/tigerlake/frontend.json    |   32 +-
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |    6 +-
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |    8 +-
 tools/perf/pmu-events/metric.py                    |    8 +-
 tools/perf/tests/builtin-test.c                    |    1 -
 tools/perf/tests/expr.c                            |    4 +
 tools/perf/tests/make                              |    4 +
 tools/perf/tests/parse-events.c                    |  100 +-
 tools/perf/tests/pe-file-parsing.c                 |    3 +-
 tools/perf/tests/shell/lock_contention.sh          |   36 +
 tools/perf/util/bpf_skel/.gitignore                |    1 +
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |    2 -
 tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h   |   10 +
 tools/perf/util/dso.c                              |    7 +-
 tools/perf/util/dso.h                              |    3 +-
 tools/perf/util/event.c                            |    7 +-
 tools/perf/util/evsel.c                            |   30 +-
 tools/perf/util/evsel.h                            |    1 +
 tools/perf/util/expr.c                             |   21 +
 tools/perf/util/expr.h                             |    1 +
 tools/perf/util/expr.l                             |    1 +
 tools/perf/util/expr.y                             |    8 +-
 tools/perf/util/llvm-utils.c                       |    4 +-
 tools/perf/util/map.c                              |   14 +-
 tools/perf/util/map.h                              |   12 +-
 tools/perf/util/perf_event_attr_fprintf.c          |  186 ++-
 tools/perf/util/pmu.c                              |   27 +-
 tools/perf/util/pmu.h                              |    1 +
 tools/perf/util/pmus.c                             |    7 +-
 tools/perf/util/probe-event.c                      |   16 +-
 tools/perf/util/python.c                           |    8 +
 tools/perf/util/symbol.c                           |  136 +-
 tools/perf/util/symbol.h                           |   12 +-
 tools/perf/util/symbol_conf.h                      |    1 -
 tools/perf/util/symbol_fprintf.c                   |   10 +-
 tools/perf/util/trace-event-info.c                 |   12 +
 tools/perf/util/trace-event.h                      |    6 +
 tools/perf/util/unwind-libdw.c                     |    8 +-
 95 files changed, 9361 insertions(+), 493 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/virtual-memory.json
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)


---
Test results:

  $ sudo ./perf test
    1: vmlinux symtab matches kallsyms                                 : Skip
    2: Detect openat syscall event                                     : Ok
    3: Detect openat syscall event on all cpus                         : Ok
    4: mmap interface tests                                            :
    4.1: Read samples using the mmap interface                         : Ok
    4.2: User space counter reading of instructions                    : Ok
    4.3: User space counter reading of cycles                          : Ok
    5: Test data source output                                         : Ok
    6: Parse event definition strings                                  :
    6.1: Test event parsing                                            : Ok
    6.2: Parsing of all PMU events from sysfs                          : Ok
    6.3: Parsing of given PMU events from sysfs                        : Ok
    6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
    6.5: Parsing of aliased events                                     : Ok
    6.6: Parsing of terms (event modifiers)                            : Ok
    7: Simple expression parser                                        : Ok
    8: PERF_RECORD_* events & perf_sample fields                       : Ok
    9: Parse perf pmu format                                           : Ok
   10: PMU events                                                      :
   10.1: PMU event table sanity                                        : Ok
   10.2: PMU event map aliases                                         : Ok
   10.3: Parsing of PMU event table metrics                            : Ok
   10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
   10.5: Parsing of metric thresholds with fake PMUs                   : Ok
   11: DSO data read                                                   : Ok
   12: DSO data cache                                                  : Ok
   13: DSO data reopen                                                 : Ok
   14: Roundtrip evsel->name                                           : Ok
   15: Parse sched tracepoints fields                                  : Ok
   16: syscalls:sys_enter_openat event fields                          : Ok
   17: Setup struct perf_event_attr                                    : Ok
   18: Match and link multiple hists                                   : Ok
   19: 'import perf' in python                                         : Ok
   20: Breakpoint overflow signal handler                              : Ok
   21: Breakpoint overflow sampling                                    : Ok
   22: Breakpoint accounting                                           : Ok
   23: Watchpoint                                                      :
   23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
   23.2: Write Only Watchpoint                                         : Ok
   23.3: Read / Write Watchpoint                                       : Ok
   23.4: Modify Watchpoint                                             : Ok
   24: Number of exit events of a simple workload                      : Ok
   25: Software clock events period values                             : Ok
   26: Object code reading                                             : Ok
   27: Sample parsing                                                  : Ok
   28: Use a dummy software event to keep tracking                     : Ok
   29: Parse with no sample_id_all bit set                             : Ok
   30: Filter hist entries                                             : Ok
   31: Lookup mmap thread                                              : Ok
   32: Share thread maps                                               : Ok
   33: Sort output of hist entries                                     : Ok
   34: Cumulate child hist entries                                     : Ok
   35: Track with sched_switch                                         : Ok
   36: Filter fds with revents mask in a fdarray                       : Ok
   37: Add fd to a fdarray, making it autogrow                         : Ok
   38: kmod_path__parse                                                : Ok
   39: Thread map                                                      : Ok
   40: LLVM search and compile                                         :
   40.1: Basic BPF llvm compile                                        : Ok
   40.2: kbuild searching                                              : Ok
   40.3: Compile source for BPF prologue generation                    : Ok
   40.4: Compile source for BPF relocation                             : Ok
   41: Session topology                                                : Ok
   42: BPF filter                                                      :
   42.1: Basic BPF filtering                                           : Ok
   42.2: BPF pinning                                                   : Ok
   42.3: BPF prologue generation                                       : Skip (clang/debuginfo isn't installed or environment missing BPF support)
   43: Synthesize thread map                                           : Ok
   44: Remove thread map                                               : Ok
   45: CPU map                                                         :
   45.1: Synthesize cpu map                                            : Ok
   45.2: Print cpu map                                                 : Ok
   45.3: Merge cpu map                                                 : Ok
   45.4: Intersect cpu map                                             : Ok
   45.5: Equal cpu map                                                 : Ok
   46: Synthesize stat config                                          : Ok
   47: Synthesize stat                                                 : Ok
   48: Synthesize stat round                                           : Ok
   49: Synthesize attr update                                          : Ok
   50: Event times                                                     : Ok
   51: Read backward ring buffer                                       : Ok
   52: Probe SDT events                                                : Skip
   53: is_printable_array                                              : Ok
   54: Print bitmap                                                    : Ok
   55: perf hooks                                                      : Ok
   56: builtin clang support                                           :
   56.1: builtin clang compile C source to IR                          : Skip (not compiled in)
   56.2: builtin clang compile C source to ELF object                  : Skip (not compiled in)
   57: unit_number__scnprintf                                          : Ok
   58: mem2node                                                        : Ok
   59: time utils                                                      : Ok
   60: Test jit_write_elf                                              : Ok
   61: Test libpfm4 support                                            :
   61.1: test of individual --pfm-events                               : Ok
   61.2: test groups of --pfm-events                                   : Ok
   62: Test api io                                                     : Ok
   63: maps__merge_in                                                  : Ok
   64: Demangle Java                                                   : Ok
   65: Demangle OCaml                                                  : Ok
   66: Parse and process metrics                                       : Ok
   67: PE file support                                                 : Skip
   68: Event expansion for cgroups                                     : Ok
   69: Convert perf time to TSC                                        :
   69.1: TSC support                                                   : Ok
   69.2: Perf time to TSC                                              : Ok
   70: dlfilter C API                                                  : Ok
   71: Sigtrap                                                         : Ok
   72: Event groups                                                    : Skip
   73: Symbols                                                         : Ok
   74: Test dwarf unwind                                               : Ok
   75: Intel PT                                                        :
   75.1: Intel PT packet decoder                                       : Ok
   75.2: Intel PT hybrid CPU compatibility                             : Skip
   76: x86 bp modify                                                   : Ok
   77: x86 Sample parsing                                              : Ok
   78: AMD IBS via core pmu                                            : Skip
   79: x86 hybrid                                                      : Skip (not hybrid)
   80: build id cache operations                                       : Ok
   81: CoreSight / ASM Pure Loop                                       : Skip
   82: CoreSight / Memcpy 16k 10 Threads                               : Skip
   83: CoreSight / Thread Loop 10 Threads - Check TID                  : Skip
   84: CoreSight / Thread Loop 2 Threads - Check TID                   : Skip
   85: CoreSight / Unroll Loop Thread 10                               : Skip
   86: daemon operations                                               : Ok
   87: kernel lock contention analysis test                            : Ok
   88: perf pipe recording and injection test                          : Ok
   89: Add vfs_getname probe to get syscall args filenames             : Skip
   90: probe libc's inet_pton & backtrace it with ping                 : Ok
   91: Use vfs_getname probe to get syscall args filenames             : Skip
   92: Zstd perf.data compression/decompression                        : Ok
   93: perf record tests                                               : Ok
   94: perf record offcpu profiling tests                              : Ok
   95: perf stat CSV output linter                                     : Ok
   96: perf stat csv summary test                                      : Ok
   97: perf stat JSON output linter                                    : Ok
   98: perf stat metrics (shadow stat) test                            : Ok
   99: perf stat STD output linter                                     : Ok
  100: perf stat tests                                                 : Ok
  101: perf all metricgroups test                                      : Ok
  102: perf all metrics test                                           : Ok
  103: perf all libpfm4 events test                                    : Ok
  104: perf all PMU test                                               : Ok
  105: perf stat --bpf-counters test                                   : Skip
  106: perf stat --bpf-counters --for-each-cgroup test                 : Ok
  107: perf metrics value validation                                   : Ok
  108: Check Arm64 callgraphs are complete in fp mode                  : Skip
  109: Check Arm CoreSight trace data recording and synthesized samples: Skip
  110: Check Arm SPE trace data recording and synthesized samples      : Skip
  111: Check Arm SPE doesn't hang when there are forks                 : Skip
  112: Check branch stack sampling                                     : Ok
  113: Test data symbol                                                : Ok
  114: Miscellaneous Intel PT testing                                  : Ok
  115: Test java symbol                                                : Skip
  116: 'perf data convert --to-json' command test                      : Ok
  117: perf script task-analyzer tests                                 : Ok
  118: Check open filename arg using perf trace + vfs_getname          : Skip

