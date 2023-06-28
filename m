Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EA9741B61
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjF1WAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjF1WAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:00:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7C42110;
        Wed, 28 Jun 2023 14:59:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-668730696a4so24196b3a.1;
        Wed, 28 Jun 2023 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687989599; x=1690581599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PZlq4yMYKdGEJ6txfGDwtgvTCnN4Ca9yeJpIFs0PNzM=;
        b=nJfUr9dfvrXFnIfQI5mk9V6c9wG8odqz6NjeZuK+r5Csli6VxPLMtWi/g/SdP8pctL
         YaGjT1mAA3ZN23ESAQqRzopmvDLraEanlK+Zg42QY6ORjDaPyLkxcvTi8Jsgv7xaEIGa
         1HtnyuapsvTMjtMjAjx4pHwcQTiQgRqW7bS+aeMRSyW54OTBMaTroIjLWTc4Hhh/htPY
         P1XsZj0chWdpeSs9VETuNvIxhjg8BAm8YUJm59oECNRrQzYhrW4DbXXG+0tvXWZDB9s4
         Hu8T7oRJH0JECAibNP1PUrLmAAmszosTxTlP9hIH0Fp1QrF8DFUa3t7n1DrTvleLNg8A
         Ke2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989599; x=1690581599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZlq4yMYKdGEJ6txfGDwtgvTCnN4Ca9yeJpIFs0PNzM=;
        b=OrNoi8LySVk/+PrPqezVmg/lUOlDT64Y9G9Y+LPBo8c3eKjnwn3kxpQFFwXaDFk6bK
         ekZ1edsglA0Fh1Ctk3350abFtp4ibbnIUiDyHiIImKvAbMwhK0uWnidNVtINoetO0cZY
         60jq/KkSFpse6PX84RSWxrmZYKtQoiTCamgp2ezSPP2qDOqYGiqZfTgbNGF18BBe2k+b
         eA8GKrF/dXeW6Wyv6Zm+otPPqKKpzg5e3KuCQH74r/vKm/GsQMVO84Aut4LKDfUFA3JN
         oxtjmdxawyTh8HoQXq1CraZGWZRYs+P45k1wXdn5cvu25gpJ+FNjpYoqNbyAbEllV7iW
         jLig==
X-Gm-Message-State: AC+VfDzVircH4ewVpOo8JnJ57UjoMqegsxb9HD0nDJhrLCCSxChE0DXP
        GRs7IFQKgUCDQQMVz1pX/pG5vsrcDMA=
X-Google-Smtp-Source: ACHHUZ4XP9kn32b740V2Mql0mj5mbJLaswYIAf0qJZQXiVhc6NxdohEN5FtwPMb0OwyuFDC09Ydckw==
X-Received: by 2002:a05:6a00:b55:b0:668:6eed:7c12 with SMTP id p21-20020a056a000b5500b006686eed7c12mr27826645pfo.22.1687989598272;
        Wed, 28 Jun 2023 14:59:58 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:3be0:5647:6591:9cca])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b0063d2dae6247sm5499129pfo.77.2023.06.28.14.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:59:57 -0700 (PDT)
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
Subject: [GIT PULL] perf tools changes for v6.5
Date:   Wed, 28 Jun 2023 14:59:54 -0700
Message-ID: <20230628215954.1230048-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
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

Please consider pulling perf tool changes.  I'm doing this on behalf of
Arnaldo as he's on vacation.  This is my first pull request and hope I
didn't break anything. :)

Thanks,
Namhyung


The following changes since commit c041d33bf7ec731bb71f47e4d45a7aec9e40b1b9:

  perf evsel: Separate bpf_counter_list and bpf_filters, can be used at the same time (2023-05-26 16:03:43 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tags/perf-tools-for-v6.5-1-2023-06-28

for you to fetch changes up to 4d60e83dfcee794213878155463d8f7353a80864:

  perf test: Skip metrics w/o event name in stat STD output linter (2023-06-23 21:35:45 -0700)

----------------------------------------------------------------
perf tools changes and fixes for v6.5: 1st batch

Internal cleanup:

 - Refactor PMU data management to handle hybrid systems in a generic way.
   Do more work in the lexer so that legacy event types parse more easily.
   A side-effect of this is that if a PMU is specified, scanning sysfs is
   avoided improving start-up time.

 - Fix hybrid metrics, for example, the TopdownL1 works for both performance
   and efficiency cores on Intel machines.  To support this, sort and regroup
   events after parsing.

 - Add reference count checking for the 'thread' data structure.

 - Lots of fixes for memory leaks in various places thanks to the ASAN and
   Ian's refcount checker.

 - Reduce the binary size by replacing static variables with local or
   dynamically allocated memory.

 - Introduce shared_mutex for annotate data to reduce memory footprint.

 - Make filesystem access library functions more thread safe.

Test:

 - Organize cpu_map tests into a single suite.

 - Add metric value validation test to check if the values are within correct
   value ranges.

 - Add perf stat stdio output test to check if event and metric names match.

 - Add perf data converter JSON output test.

 - Fix a lot of issues reported by shellcheck(1).  This is a preparation to
   enable shellcheck by default.

 - Make the large x86 new instructions test optional at build time using
   EXTRA_TESTS=1.

 - Add a test for libpfm4 events.

perf script:

 - Add 'dsoff' outpuf field to display offset from the DSO.

    $ perf script -F comm,pid,event,ip,dsoff
       ls 2695501 cycles:      152cc73ef4b5 (/usr/lib/x86_64-linux-gnu/ld-2.31.so+0x1c4b5)
       ls 2695501 cycles:  ffffffff99045b3e ([kernel.kallsyms])
       ls 2695501 cycles:  ffffffff9968e107 ([kernel.kallsyms])
       ls 2695501 cycles:  ffffffffc1f54afb ([kernel.kallsyms])
       ls 2695501 cycles:  ffffffff9968382f ([kernel.kallsyms])
       ls 2695501 cycles:  ffffffff99e00094 ([kernel.kallsyms])
       ls 2695501 cycles:      152cc718a8d0 (/usr/lib/x86_64-linux-gnu/libselinux.so.1+0x68d0)
       ls 2695501 cycles:  ffffffff992a6db0 ([kernel.kallsyms])

 - Adjust width for large PID/TID values.

perf report:

 - Robustify reading addr2line output for srcline by checking sentinel output
   before the actual data and by using timeout of 1 second.

 - Allow config terms (like 'name=ABC') with breakpoint events.

    $ perf record -e mem:0x55feb98dd169:x/name=breakpoint/ -p 19646 -- sleep 1

perf annotate:

 - Handle x86 instruction suffix like 'l' in 'movl' generally.

 - Parse instruction operands properly even with a whitespace.  This is needed
   for llvm-objdump output.

 - Support RISC-V binutils lookup using the triplet prefixes.

 - Add '<' and '>' key to navigate to prev/next symbols in TUI.

 - Fix instruction association and parsing for LoongArch.

perf stat:

 - Add --per-cache aggregation option, optionally specify a cache level
   like `--per-cache=L2`.

    $ sudo perf stat --per-cache -a -e ls_dmnd_fills_from_sys.ext_cache_remote --\
      taskset -c 0-15,64-79,128-143,192-207\
      perf bench sched messaging -p -t -l 100000 -g 8

      # Running 'sched/messaging' benchmark:
      # 20 sender and receiver threads per group
      # 8 groups == 320 threads run

      Total time: 7.648 [sec]

      Performance counter stats for 'system wide':

      S0-D0-L3-ID0             16         17,145,912      ls_dmnd_fills_from_sys.ext_cache_remote
      S0-D0-L3-ID8             16         14,977,628      ls_dmnd_fills_from_sys.ext_cache_remote
      S0-D0-L3-ID16            16            262,539      ls_dmnd_fills_from_sys.ext_cache_remote
      S0-D0-L3-ID24            16              3,140      ls_dmnd_fills_from_sys.ext_cache_remote
      S0-D0-L3-ID32            16             27,403      ls_dmnd_fills_from_sys.ext_cache_remote
      S0-D0-L3-ID40            16             17,026      ls_dmnd_fills_from_sys.ext_cache_remote
      S0-D0-L3-ID48            16              7,292      ls_dmnd_fills_from_sys.ext_cache_remote
      S0-D0-L3-ID56            16              2,464      ls_dmnd_fills_from_sys.ext_cache_remote
      S1-D1-L3-ID64            16         22,489,306      ls_dmnd_fills_from_sys.ext_cache_remote
      S1-D1-L3-ID72            16         21,455,257      ls_dmnd_fills_from_sys.ext_cache_remote
      S1-D1-L3-ID80            16             11,619      ls_dmnd_fills_from_sys.ext_cache_remote
      S1-D1-L3-ID88            16             30,978      ls_dmnd_fills_from_sys.ext_cache_remote
      S1-D1-L3-ID96            16             37,628      ls_dmnd_fills_from_sys.ext_cache_remote
      S1-D1-L3-ID104           16             13,594      ls_dmnd_fills_from_sys.ext_cache_remote
      S1-D1-L3-ID112           16             10,164      ls_dmnd_fills_from_sys.ext_cache_remote
      S1-D1-L3-ID120           16             11,259      ls_dmnd_fills_from_sys.ext_cache_remote

            7.779171484 seconds time elapsed

  - Change default (no event/metric) formatting for default metrics so that
    events are hidden and the metric and group appear.

     Performance counter stats for 'ls /':

                  1.85 msec task-clock                       #    0.594 CPUs utilized
                     0      context-switches                 #    0.000 /sec
                     0      cpu-migrations                   #    0.000 /sec
                    97      page-faults                      #   52.517 K/sec
             2,187,173      cycles                           #    1.184 GHz
             2,474,459      instructions                     #    1.13  insn per cycle
               531,584      branches                         #  287.805 M/sec
                13,626      branch-misses                    #    2.56% of all branches
                            TopdownL1                 #     23.5 %  tma_backend_bound
                                                      #     11.5 %  tma_bad_speculation
                                                      #     39.1 %  tma_frontend_bound
                                                      #     25.9 %  tma_retiring

 - Allow --cputype option to have any PMU name (not just hybrid).

 - Fix output value not to added when it runs multiple times with -r option.

perf list:

 - Show metricgroup description from JSON file called metricgroups.json.

 - Allow 'pfm' argument to list only libpfm4 events and check each event is
   supported before showing it.

JSON vendor events:

 - Avoid event grouping using "NO_GROUP_EVENTS" constraints.  The topdown
   events are correctly grouped even if no group exists.

 - Add "Default" metric group to print it in the default output.  And use
   "DefaultMetricgroupName" to indicate the real metric group name.

 - Add AmpereOne core PMU events.

Misc:

 - Define man page date correctly.

 - Track exception level properly on ARM CoreSight ETM.

 - Allow anonymous struct, union or enum when retrieving type names from DWARF.

 - Fix incorrect filename when calling `perf inject --jit`.

 - Handle PLT size correctly on LoongArch.

----------------------------------------------------------------
Abhirup Deb (2):
      perf tests test_arm_spe: Address shellcheck warnings about signal name case
      perf tests lock_contention: Fix shellscript errors

Aboorva Devarajan (1):
      perf tests test_task_analyzer: Fix shellcheck issues

Aditya Gupta (3):
      perf tests task_analyzer: Fix bad substitution ${$1}
      perf tests task_analyzer: Print command that failed instead of just "perf"
      perf tests task_analyzer: Skip tests if no libtraceevent support

Adrian Hunter (4):
      perf dso: Declare dso const as needed
      perf script: Refine printing of dso offset (dsoff)
      perf parse: Allow config terms with breakpoints
      perf tests: Make x86 new instructions test optional at build time

Anup Sharma (1):
      perf test: Add test validating JSON generated by 'perf data convert --to-json'

Anushree Mathur (1):
      perf tests test_arm_coresight: Shellcheck fixes

Arnaldo Carvalho de Melo (9):
      perf build: Don't use -ftree-loop-distribute-patterns and -gno-variable-location-views in the python feature test when building with clang-13
      Merge remote-tracking branch 'acme/perf-tools' into perf-tools-next
      Merge tag 'perf-tools-fixes-for-v6.4-2-2023-05-30' into perf-tools-next
      perf bench: Add missing setlocale() call to allow usage of %'d style formatting
      perf script: Fix allocation of evsel->priv related to per-event dump files
      perf srcline: Optimize comparision against SRCLINE_UNKNOWN
      perf pfm: Remove duplicate util/cpumap.h include
      perf print-events: Export is_event_supported()
      perf pmus: Check if we can encode the PMU number in perf_event_attr.type

Barnali Guha Thakurata (1):
      perf tests stat_all_metrics: Fix shellcheck warning SC2076

Ben Hutchings (2):
      perf doc: Define man page date when using asciidoctor
      perf doc: Add support for KBUILD_BUILD_TIMESTAMP

Changbin Du (3):
      perf map: Add helper map__fprintf_dsoname_dsoff
      perf script: Add new output field 'dsoff' to print dso offset
      perf ftrace: Flush output after each writing

Chenyuan Mi (1):
      perf subcmd: Fix missing check for return value of malloc() in add_cmdname()

Disha Goel (1):
      perf tests stat+json_output: Address shellcheck warnings

Geetika (1):
      perf tests test_brstack.sh: Fix all POSIX sh warnings

Ian Rogers (169):
      perf vendor events intel: Add alderlake metric constraints
      perf vendor events intel: Add icelake metric constraints
      perf vendor events intel: Add icelakex metric constraints
      perf vendor events intel: Add sapphirerapids metric constraints
      perf vendor events intel: Add tigerlake metric constraints
      perf test: Test more sysfs events
      perf test: Use valid for PMU tests
      perf test: Mask configs with extended types then test
      perf test: Test more with config_cache
      perf test: Roundtrip name, don't assume 1 event per name
      perf parse-events: Set attr.type to PMU type early
      perf parse-events: Set pmu_name whenever a pmu is given
      perf print-events: Avoid unnecessary strlist
      perf parse-events: Avoid scanning PMUs before parsing
      perf test: Move x86 hybrid tests to arch/x86
      perf test x86 hybrid: Update test expectations
      perf test x86 hybrid: Add hybrid extended type checks
      perf parse-events: Support PMUs for legacy cache events
      perf parse-events: Wildcard legacy cache events
      perf print-events: Print legacy cache events for each PMU
      perf parse-events: Support wildcards on raw events
      perf parse-events: Remove now unused hybrid logic
      perf parse-events: Minor type safety cleanup
      perf parse-events: Add pmu filter
      perf stat: Make cputype filter generic
      perf test: Fix parse-events tests for >1 core PMU
      perf parse-events: Support hardware events as terms
      perf parse-events: Avoid error when assigning a term
      perf parse-events: Avoid error when assigning a legacy cache term
      perf parse-events: Don't auto merge hybrid wildcard events
      perf parse-events: Don't reorder atom cpu events
      perf metrics: Be PMU specific for referenced metrics.
      perf stat: Command line PMU metric filtering
      perf vendor events intel: Correct alderlake metrics
      perf jevents: Don't rewrite metrics across PMUs
      perf metrics: Be PMU specific in event match
      perf stat: Don't disable TopdownL1 metric on hybrid
      perf parse-events: Reduce scope of is_event_supported
      perf test: Add cputype testing to perf stat
      perf vendor events intel: Update alderlake events/metrics
      perf vendor events intel: Update broadwell variant events/metrics
      perf vendor events intel: Update cascadelakex events/metrics
      perf vendor events intel: Update elkhartlake events
      perf vendor events intel: Update haswell(x) metrics
      perf vendor events intel: Update icelake/icelakex events/metrics
      perf vendor events intel: Update ivybridge/ivytown metrics
      perf vendor events intel: Update jaketown metrics
      perf vendor events intel: Update sandybridge metrics
      perf vendor events intel: Update sapphirerapids events/metrics
      perf vendor events intel: Update skylake/skylakex events/metrics
      perf vendor events intel: Update snowridgex events
      perf vendor events intel: Update tigerlake events/metrics
      perf jevents: Add support for metricgroup descriptions
      perf vendor events intel: Add metricgroup descriptions for all models
      perf cpumap: Add intersect function
      perf tests: Organize cpu_map tests into a single suite
      perf test python: Put perf python at start of sys.path
      perf cpumap: Add internal nr and cpu accessors
      perf cpumap: Add equal function
      libperf cpumap: Add "any CPU"/dummy test function
      perf pmu: Detect ARM and hybrid PMUs with sysfs
      perf pmu: Add is_core to pmu
      perf evsel: Add is_pmu_core inorder to interpret own_cpus
      perf pmu: Add CPU map for "cpu" PMUs
      perf evlist: Propagate user CPU maps intersecting core PMU maps
      perf evlist: Allow has_user_cpus to be set on hybrid
      perf target: Remove unused hybrid value
      perf tools: Warn if no user requested CPUs match PMU's CPUs
      perf evlist: Remove evlist__warn_hybrid_group
      perf evlist: Remove __evlist__add_default
      perf evlist: Reduce scope of evlist__has_hybrid
      perf pmu: Remove perf_pmu__hybrid_mounted
      perf pmu: Rewrite perf_pmu__has_hybrid to avoid list
      perf x86: Iterate hybrid PMUs as core PMUs
      perf topology: Avoid hybrid list for hybrid topology
      perf evsel: Compute is_hybrid from PMU being core
      perf header: Avoid hybrid PMU list in write_pmu_caps
      perf metrics: Remove perf_pmu__is_hybrid use
      perf stat: Avoid hybrid PMU list
      perf mem: Avoid hybrid PMU list
      perf pmu: Remove perf_pmu__hybrid_pmus list
      perf pmus: Prefer perf_pmu__scan over perf_pmus__for_each_pmu
      perf x86 mem: minor refactor to is_mem_loads_aux_event
      perf pmu: Separate pmu and pmus
      perf pmus: Split pmus list into core and other
      perf pmus: Allow just core PMU scanning
      perf pmus: Avoid repeated sysfs scanning
      perf pmus: Ensure all PMUs are read for find_by_type
      perf pmus: Add function to return count of core PMUs
      perf pmus: Remove perf_pmus__has_hybrid
      perf pmu: Remove is_pmu_hybrid
      perf evsel: Don't let evsel__group_pmu_name() traverse unsorted group
      perf evsel: Don't let for_each_group() treat the head of the list as one of its nodes
      perf header: Make nodes dynamic in write_mem_topology()
      perf test x86: insn-x86 test data is immutable so mark it const
      perf test x86: intel-pt-test data is immutable so mark it const
      perf trace: Make some large static arrays const to move it to .data.rel.ro
      perf trace beauty: Make MSR arrays const to move it to .data.rel.ro
      tools api fs: Avoid large static PATH_MAX arrays
      tools lib api fs tracing_path: Remove two unused MAX_PATH paths
      perf daemon: Dynamically allocate path to perf
      perf lock: Dynamically allocate lockhash_table
      perf timechart: Make large arrays dynamic
      perf probe: Dynamically allocate params memory
      perf path: Make mkpath thread safe, remove 16384 bytes from .bss
      perf scripting-engines: Move static to local variable, remove 16384 from .bss
      tools api fs: Dynamically allocate cgroupfs mount point cache, removing 4128 bytes from .bss
      perf test pmu: Avoid 2 static path arrays
      libsubcmd: Avoid two path statics, removing 8192 bytes from .bss
      perf kvm powerpc: Add missing rename opf pmu_have_event() to perf_pmus__have_event()
      perf pmu: Correct perf_pmu__auto_merge_stats() affecting hybrid
      perf evsel: Add verbose 3 print of evsel name when opening
      perf parse-events: Wildcard most "numeric" events
      perf test: Update parse-events expectations to test for multiple events
      perf pmu: Only warn about unsupported formats once
      perf pmu: Warn about invalid config for all PMUs and configs
      perf expr: Make the evaluation of & and | logical and lazy
      perf stat: Document --metric-no-threshold and threshold colors
      tools headers: Make the difference output easier to read
      perf list: Check arguments to show libpfm4 events
      perf test: Add test of libpfm4 events
      perf thread: Remove notion of dead threads
      perf thread: Make threads rbtree non-invasive
      perf thread: Add accessor functions for thread
      perf maps: Make delete static, always use put
      perf addr_location: Move to its own header
      perf addr_location: Add init/exit/copy functions
      perf thread: Add reference count checking
      perf machine: Make delete_threads part of machine__exit
      perf report: Avoid 'parent_thread' thread leak on '--tasks' processing
      perf header: Ensure bitmaps are freed
      perf stat: Avoid evlist leak
      perf intel-pt: Fix missed put and leak
      perf evlist: Free stats in all evlist destruction
      perf python: Avoid 2 leak sanitizer issues
      perf jit: Fix two thread leaks
      perf symbol-elf: Correct holding a reference
      perf maps: Fix overlapping memory leak
      perf machine: Fix leak of kernel dso
      perf machine: Don't leak module maps
      perf map/maps/thread: Changes to reference counting
      perf annotate: Fix parse_objdump_line memory leak
      perf top: Add exit routine for main thread
      perf header: Avoid out-of-bounds read
      perf callchain: Use pthread keys for tls callchain_cursor
      perf srcline: Change free_srcline to zfree_srcline
      perf hist: Fix srcline memory leak
      lib subcmd: Avoid memory leak in exclude_cmds
      perf help: Ensure clean_cmds is called on all paths
      perf bench epoll: Fix missing frees/puts on the exit path
      perf bench futex: Avoid memory leaks from pthread_attr
      perf bench sched messaging: Free contexts on exit
      perf sched: Avoid large stack allocations
      perf script: Remove some large stack allocations
      perf inject: Lazily allocate event_copy
      perf inject: Lazily allocate guest_event event_buf
      perf srcline: Make addr2line configuration failure more verbose
      perf srcline: Make sentinel reading for binutils addr2line more robust
      tools api fs: More thread safety for global filesystem variables
      perf parse-events: Avoid string for PE_BP_COLON, PE_BP_SLASH
      perf tool x86: Fix perf_env memory leak
      tools api: Add simple timeout to io read
      perf srcline: Add a timeout to reading from addr2line
      perf srcline: Fix handling of inline functions
      perf sharded_mutex: Introduce sharded_mutex
      perf annotation: Switch lock from a mutex to a sharded_mutex
      perf unwind: Fix map reference counts
      perf pmus: Add notion of default PMU for JSON events
      perf pmu: Remove a hard coded cpu PMU assumption

Ilkka Koskinen (1):
      perf vendor events arm64: Add AmpereOne core PMU events

James Clark (7):
      perf map: Fix double 'struct map' reference free found with -DREFCNT_CHECKING=1
      perf cs-etm: Only track threads instead of PID and TIDs
      perf cs-etm: Use previous thread for branch sample source IP
      perf cs-etm: Make PID format accessible from struct cs_etm_auxtrace
      perf cs-etm: Track exception level
      perf cs-etm: Add exception level consistency check
      perf tests: Fix test_arm_callgraph_fp variable expansion

K Prateek Nayak (5):
      perf: Extract building cache level for a CPU into separate function
      perf stat: Setup the foundation to allow aggregation based on cache topology
      perf stat record: Save cache level information
      perf stat: Add "--per-cache" aggregation option and document it
      pert tests: Add tests for new "perf stat --per-cache" aggregation option

Kan Liang (12):
      perf metric: Fix no group check
      pert tests: Support metricgroup perf stat JSON output
      perf vendor events arm64: Add default tags into topdown L1 metrics
      perf evsel: Fix the annotation for hardware events on hybrid
      perf metric: JSON flag to default metric group
      perf stat,jevents: Introduce Default tags for the default mode
      pert tests: Update metric-value for perf stat JSON output
      perf metrics: Sort the Default metricgroup
      perf stat: New metricgroup output for the default mode
      perf test: Move all the check functions of stat CSV output to lib
      perf test: Add test case for the standard 'perf stat' output
      perf vendor events arm64: Add default tags for Hisi hip08 L1 metrics

Korrapati Likhitha (1):
      perf tests stat+csv_output: Fix shellcheck warnings

Li Dong (1):
      tools: Fix incorrect calculation of object size by sizeof

Namhyung Kim (18):
      perf annotate: Handle "decq", "incq", "testq", "tzcnt" instructions on x86
      perf annotate: Parse x86 SIB addressing properly
      perf annotate browser: Add '<' and '>' keys for navigation
      perf test: Fix perf stat JSON output test
      perf script: Increase PID/TID width for output
      perf annotate: Handle x86 instruction suffix generally
      perf annotate: Remove x86 instructions with suffix
      perf list: Check if libpfm4 event is supported
      perf annotate: Allow whitespace between insn operands
      perf dwarf-aux: Fix off-by-one in die_get_varname()
      perf dwarf-aux: Allow unnamed struct/union/enum
      perf stat: Reset aggr stats for each run
      perf stat: Show average value on multiple runs
      perf test: Remove x permission from lib/stat_output.sh
      perf script: Initialize buffer for regs_map()
      perf test: Set PERF_EXEC_PATH for script execution
      perf test: Reorder event name checks in stat STD output linter
      perf test: Skip metrics w/o event name in stat STD output linter

Paran Lee (1):
      perf tools riscv: Add support for riscv lookup_binutils_path

Ravi Bangoria (4):
      perf tool x86: Consolidate is_amd check into single function
      perf pmus: Describe semantics of 'core_pmus' and 'other_pmus'
      perf mem amd: Fix perf_pmus__num_mem_pmus()
      perf mem: Scan all PMUs instead of just core ones

Samir Mulani (1):
      perf tests shell: Fixed shellcheck warnings

Shirisha G (1):
      perf tests daemon: Address shellcheck warnings

Sourabh Jain (1):
      perf python scripting: Get rid of unused import in arm-cs-trace-disasm

Spoorthy S (2):
      perf tests arm_callgraph_fp: Address shellcheck warnings about signal names and adding double quotes for expression
      perf tests stat+shadow_stat.sh: Fix all POSIX sh warnings found using shellcheck

Thomas Richter (1):
      perf test: fix failing test cases on linux-next for s390

Tiezhu Yang (7):
      perf tools: Declare syscalltbl_*[] as const for all archs
      perf arm64: Rename create_table_from_c() to create_sc_table()
      perf arm64: Handle __NR3264_ prefixed syscall number
      perf arm64: Use max_nr to define SYSCALLTBL_ARM64_MAX_ID
      perf LoongArch: Simplify mksyscalltbl
      perf test record+probe_libc_inet_pton.sh: Use "grep -F" instead of obsolescent "fgrep"
      perf symbol: Add LoongArch case in get_plt_sizes()

Vincent Whitchurch (1):
      perf annotate: Work with vmlinux outside symfs

WANG Rui (1):
      perf annotate: Fix instruction association and parsing for LoongArch

Weilin Wang (3):
      perf test: Add metric value validation test
      perf test: Add skip list for metrics known would fail
      perf test: Rerun failed metrics with longer workload

Yang Jihong (2):
      perf stat: Add missing newline in pr_err messages
      perf parse: Add missing newline to pr_debug message in evsel__compute_group_pmu_name()

baomingtong001@208suo.com (1):
      perf parse-events: Remove unneeded semicolon

elisabeth (1):
      perf jit: Fix incorrect file name in DWARF line table

 tools/lib/api/fs/cgroup.c                          |   17 +-
 tools/lib/api/fs/fs.c                              |  226 +-
 tools/lib/api/fs/tracing_path.c                    |   17 +-
 tools/lib/api/io.h                                 |   28 +-
 tools/lib/perf/cpumap.c                            |  125 +-
 tools/lib/perf/evlist.c                            |   25 +-
 tools/lib/perf/include/internal/evsel.h            |   15 +-
 tools/lib/perf/include/perf/cpumap.h               |   19 +
 tools/lib/perf/include/perf/event.h                |    3 +-
 tools/lib/subcmd/exec-cmd.c                        |   35 +-
 tools/lib/subcmd/help.c                            |   10 +-
 tools/perf/Documentation/Makefile                  |   15 +-
 tools/perf/Documentation/perf-script.txt           |    2 +-
 tools/perf/Documentation/perf-stat.txt             |   31 +
 tools/perf/Makefile.config                         |    5 +
 tools/perf/Makefile.perf                           |    4 +
 tools/perf/arch/arm/tests/dwarf-unwind.c           |    2 +-
 tools/perf/arch/arm/util/auxtrace.c                |    7 +-
 tools/perf/arch/arm/util/cs-etm.c                  |    4 +-
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |   17 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c         |    2 +-
 tools/perf/arch/arm64/util/pmu.c                   |    6 +-
 tools/perf/arch/common.c                           |   18 +
 tools/perf/arch/loongarch/annotate/instructions.c  |  116 +-
 .../arch/loongarch/entry/syscalls/mksyscalltbl     |   40 +-
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |    2 +-
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |    2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |    2 +-
 tools/perf/arch/powerpc/util/kvm-stat.c            |    4 +-
 tools/perf/arch/s390/annotate/instructions.c       |    3 -
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |    2 +-
 tools/perf/arch/x86/annotate/instructions.c        |   50 +-
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |    2 +-
 tools/perf/arch/x86/include/arch-tests.h           |    3 +
 tools/perf/arch/x86/tests/Build                    |    6 +-
 tools/perf/arch/x86/tests/arch-tests.c             |   14 +
 tools/perf/arch/x86/tests/dwarf-unwind.c           |    2 +-
 tools/perf/arch/x86/tests/hybrid.c                 |  288 +++
 tools/perf/arch/x86/tests/insn-x86.c               |   10 +-
 tools/perf/arch/x86/tests/intel-pt-test.c          |   14 +-
 tools/perf/arch/x86/util/Build                     |    1 +
 tools/perf/arch/x86/util/auxtrace.c                |    5 +-
 tools/perf/arch/x86/util/env.c                     |   19 +
 tools/perf/arch/x86/util/env.h                     |    7 +
 tools/perf/arch/x86/util/evlist.c                  |   29 +-
 tools/perf/arch/x86/util/evsel.c                   |   43 +-
 tools/perf/arch/x86/util/intel-bts.c               |    4 +-
 tools/perf/arch/x86/util/intel-pt.c                |    4 +-
 tools/perf/arch/x86/util/mem-events.c              |   36 +-
 tools/perf/arch/x86/util/perf_regs.c               |   15 +-
 tools/perf/arch/x86/util/pmu.c                     |   12 +
 tools/perf/arch/x86/util/topdown.c                 |    5 +-
 tools/perf/bench/epoll-ctl.c                       |    5 +
 tools/perf/bench/epoll-wait.c                      |    5 +
 tools/perf/bench/futex-lock-pi.c                   |   12 +-
 tools/perf/bench/futex-requeue.c                   |   12 +-
 tools/perf/bench/futex-wake-parallel.c             |   19 +-
 tools/perf/bench/futex-wake.c                      |   12 +-
 tools/perf/bench/pmu-scan.c                        |   60 +-
 tools/perf/bench/sched-messaging.c                 |   18 +-
 tools/perf/builtin-annotate.c                      |   32 +-
 tools/perf/builtin-bench.c                         |    2 +
 tools/perf/builtin-c2c.c                           |   31 +-
 tools/perf/builtin-config.c                        |    4 +-
 tools/perf/builtin-daemon.c                        |   44 +-
 tools/perf/builtin-diff.c                          |   24 +-
 tools/perf/builtin-ftrace.c                        |    2 +
 tools/perf/builtin-help.c                          |    4 +-
 tools/perf/builtin-inject.c                        |   35 +-
 tools/perf/builtin-kmem.c                          |   26 +-
 tools/perf/builtin-kwork.c                         |   27 +-
 tools/perf/builtin-list.c                          |   48 +-
 tools/perf/builtin-lock.c                          |   27 +-
 tools/perf/builtin-mem.c                           |   13 +-
 tools/perf/builtin-probe.c                         |  133 +-
 tools/perf/builtin-record.c                        |   42 +-
 tools/perf/builtin-report.c                        |   21 +-
 tools/perf/builtin-sched.c                         |  120 +-
 tools/perf/builtin-script.c                        |  218 +-
 tools/perf/builtin-stat.c                          |  343 +++-
 tools/perf/builtin-timechart.c                     |   59 +-
 tools/perf/builtin-top.c                           |   48 +-
 tools/perf/builtin-trace.c                         |   96 +-
 tools/perf/check-headers.sh                        |  232 ++-
 .../arch/arm64/ampere/ampereone/branch.json        |   17 +
 .../arch/arm64/ampere/ampereone/bus.json           |   32 +
 .../arch/arm64/ampere/ampereone/cache.json         |  104 +
 .../arch/arm64/ampere/ampereone/core-imp-def.json  |  698 +++++++
 .../arch/arm64/ampere/ampereone/exception.json     |   44 +
 .../arch/arm64/ampere/ampereone/instruction.json   |   89 +
 .../arch/arm64/ampere/ampereone/intrinsic.json     |   14 +
 .../arch/arm64/ampere/ampereone/memory.json        |   44 +
 .../arch/arm64/ampere/ampereone/pipeline.json      |   23 +
 .../arch/arm64/ampere/ampereone/spe.json           |   14 +
 .../arch/arm64/hisilicon/hip08/metrics.json        |   12 +-
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |    1 +
 tools/perf/pmu-events/arch/arm64/sbsa.json         |   12 +-
 .../pmu-events/arch/x86/alderlake/adl-metrics.json | 1428 +++++++------
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |    9 +
 .../perf/pmu-events/arch/x86/alderlake/memory.json |    6 +-
 .../arch/x86/alderlake/metricgroups.json           |  122 ++
 .../arch/x86/alderlaken/adln-metrics.json          |  301 ++-
 .../arch/x86/alderlaken/metricgroups.json          |   26 +
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  580 +++---
 .../arch/x86/broadwell/floating-point.json         |   15 +
 .../arch/x86/broadwell/metricgroups.json           |  107 +
 .../arch/x86/broadwellde/bdwde-metrics.json        |  556 ++---
 .../arch/x86/broadwellde/floating-point.json       |   15 +
 .../arch/x86/broadwellde/metricgroups.json         |  107 +
 .../arch/x86/broadwellx/bdx-metrics.json           |  796 +++++---
 .../arch/x86/broadwellx/floating-point.json        |   15 +
 .../arch/x86/broadwellx/metricgroups.json          |  107 +
 .../arch/x86/cascadelakex/clx-metrics.json         | 1231 ++++++-----
 .../arch/x86/cascadelakex/floating-point.json      |   31 +
 .../arch/x86/cascadelakex/metricgroups.json        |  114 ++
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |   23 +-
 .../pmu-events/arch/x86/elkhartlake/cache.json     |    7 +
 .../pmu-events/arch/x86/elkhartlake/memory.json    |    2 +
 .../pmu-events/arch/x86/elkhartlake/other.json     |   10 +
 .../pmu-events/arch/x86/elkhartlake/pipeline.json  |    3 +
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  484 ++---
 .../pmu-events/arch/x86/haswell/metricgroups.json  |  107 +
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  700 ++++---
 .../pmu-events/arch/x86/haswellx/metricgroups.json |  107 +
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |   18 +
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |  969 ++++-----
 .../pmu-events/arch/x86/icelake/metricgroups.json  |  113 +
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  | 1321 +++++++-----
 .../pmu-events/arch/x86/icelakex/metricgroups.json |  114 ++
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  526 ++---
 .../arch/x86/ivybridge/metricgroups.json           |  107 +
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  534 ++---
 .../pmu-events/arch/x86/ivytown/metricgroups.json  |  107 +
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |  224 +-
 .../pmu-events/arch/x86/jaketown/metricgroups.json |  100 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   26 +-
 .../arch/x86/sandybridge/metricgroups.json         |  100 +
 .../arch/x86/sandybridge/snb-metrics.json          |  222 +-
 .../pmu-events/arch/x86/sapphirerapids/memory.json |    6 +-
 .../arch/x86/sapphirerapids/metricgroups.json      |  118 ++
 .../arch/x86/sapphirerapids/spr-metrics.json       | 1414 ++++++++-----
 .../x86/sapphirerapids/uncore-interconnect.json    |    2 +-
 .../arch/x86/sapphirerapids/uncore-memory.json     |    8 +-
 .../arch/x86/skylake/floating-point.json           |    8 +
 .../pmu-events/arch/x86/skylake/metricgroups.json  |  113 +
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |   15 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  875 ++++----
 .../arch/x86/skylakex/floating-point.json          |   31 +
 .../pmu-events/arch/x86/skylakex/metricgroups.json |  114 ++
 .../pmu-events/arch/x86/skylakex/pipeline.json     |   23 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  | 1183 ++++++-----
 .../perf/pmu-events/arch/x86/snowridgex/cache.json |    7 +
 .../pmu-events/arch/x86/snowridgex/memory.json     |    2 +
 .../perf/pmu-events/arch/x86/snowridgex/other.json |   10 +
 .../pmu-events/arch/x86/snowridgex/pipeline.json   |    3 +
 .../arch/x86/snowridgex/uncore-interconnect.json   |   14 +-
 .../pmu-events/arch/x86/snowridgex/uncore-io.json  |    8 -
 .../arch/x86/snowridgex/uncore-memory.json         |    7 +-
 .../arch/x86/snowridgex/uncore-power.json          |    6 +-
 .../perf/pmu-events/arch/x86/tigerlake/cache.json  |   18 +
 .../arch/x86/tigerlake/metricgroups.json           |  113 +
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |    1 +
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |  987 ++++-----
 tools/perf/pmu-events/empty-pmu-events.c           |    5 +
 tools/perf/pmu-events/jevents.py                   |   60 +-
 tools/perf/pmu-events/metric.py                    |   28 +-
 tools/perf/pmu-events/metric_test.py               |    6 +-
 tools/perf/pmu-events/pmu-events.h                 |    4 +
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |    4 +-
 tools/perf/scripts/python/arm-cs-trace-disasm.py   |    1 -
 tools/perf/tests/attr.c                            |   11 +-
 tools/perf/tests/builtin-test.c                    |    4 +-
 tools/perf/tests/code-reading.c                    |    6 +-
 tools/perf/tests/cpumap.c                          |   92 +-
 tools/perf/tests/dwarf-unwind.c                    |    1 -
 tools/perf/tests/event_groups.c                    |    7 +-
 tools/perf/tests/evsel-roundtrip-name.c            |  119 +-
 tools/perf/tests/expr.c                            |   40 +
 tools/perf/tests/hists_common.c                    |    2 +-
 tools/perf/tests/hists_cumulate.c                  |   18 +-
 tools/perf/tests/hists_filter.c                    |   11 +-
 tools/perf/tests/hists_link.c                      |   20 +-
 tools/perf/tests/hists_output.c                    |   12 +-
 tools/perf/tests/make                              |    1 +
 tools/perf/tests/maps.c                            |    2 +-
 tools/perf/tests/mmap-thread-lookup.c              |    5 +-
 tools/perf/tests/parse-events.c                    | 2158 +++++++++++---------
 tools/perf/tests/parse-metric.c                    |    9 +-
 tools/perf/tests/perf-targz-src-pkg                |    5 +-
 tools/perf/tests/pmu-events.c                      |   18 +-
 tools/perf/tests/pmu.c                             |   17 +-
 tools/perf/tests/python-use.c                      |    2 +-
 tools/perf/tests/shell/buildid.sh                  |   12 +-
 tools/perf/tests/shell/daemon.sh                   |  113 +-
 .../perf/tests/shell/lib/perf_json_output_lint.py  |   13 +-
 .../perf/tests/shell/lib/perf_metric_validation.py |  574 ++++++
 .../shell/lib/perf_metric_validation_rules.json    |  398 ++++
 tools/perf/tests/shell/lib/stat_output.sh          |  169 ++
 tools/perf/tests/shell/lock_contention.sh          |   70 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |   10 +-
 .../tests/shell/record+script_probe_vfs_getname.sh |    4 +-
 tools/perf/tests/shell/stat+csv_output.sh          |  178 +-
 tools/perf/tests/shell/stat+json_output.sh         |   15 +-
 tools/perf/tests/shell/stat+shadow_stat.sh         |    4 +-
 tools/perf/tests/shell/stat+std_output.sh          |  108 +
 tools/perf/tests/shell/stat.sh                     |   44 +
 tools/perf/tests/shell/stat_all_metrics.sh         |    6 +-
 tools/perf/tests/shell/stat_all_pfm.sh             |   51 +
 tools/perf/tests/shell/stat_metrics_values.sh      |   30 +
 tools/perf/tests/shell/test_arm_callgraph_fp.sh    |   11 +-
 tools/perf/tests/shell/test_arm_coresight.sh       |    6 +-
 tools/perf/tests/shell/test_arm_spe.sh             |    2 +-
 tools/perf/tests/shell/test_brstack.sh             |   12 +-
 .../tests/shell/test_perf_data_converter_json.sh   |   72 +
 tools/perf/tests/shell/test_task_analyzer.sh       |  104 +-
 tools/perf/tests/switch-tracking.c                 |   14 +-
 tools/perf/tests/symbols.c                         |    1 -
 tools/perf/tests/tests.h                           |    4 +-
 tools/perf/tests/thread-maps-share.c               |   13 +-
 tools/perf/tests/topology.c                        |   16 +-
 tools/perf/trace/beauty/beauty.h                   |    2 +-
 tools/perf/trace/beauty/pid.c                      |    4 +-
 tools/perf/trace/beauty/tracepoints/x86_msr.sh     |    6 +-
 tools/perf/ui/browsers/annotate.c                  |   14 +-
 tools/perf/ui/browsers/hists.c                     |   19 +-
 tools/perf/ui/hist.c                               |    5 +-
 tools/perf/ui/stdio/hist.c                         |    2 +-
 tools/perf/util/Build                              |    5 +-
 tools/perf/util/addr_location.c                    |   44 +
 tools/perf/util/addr_location.h                    |   31 +
 tools/perf/util/annotate.c                         |  121 +-
 tools/perf/util/annotate.h                         |   11 +-
 tools/perf/util/arm-spe.c                          |    4 +-
 tools/perf/util/block-info.c                       |    8 +-
 tools/perf/util/build-id.c                         |    2 +
 tools/perf/util/cache.h                            |    2 +-
 tools/perf/util/callchain.c                        |   73 +-
 tools/perf/util/callchain.h                        |    8 +-
 tools/perf/util/config.c                           |   10 +-
 tools/perf/util/cpumap.c                           |   14 +-
 tools/perf/util/cpumap.h                           |   11 +-
 tools/perf/util/cputopo.c                          |   12 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   33 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |    4 +-
 tools/perf/util/cs-etm.c                           |  300 +--
 tools/perf/util/cs-etm.h                           |   13 +-
 tools/perf/util/data-convert-json.c                |   16 +-
 tools/perf/util/db-export.c                        |   30 +-
 tools/perf/util/dlfilter.c                         |   17 +-
 tools/perf/util/dso.c                              |   33 +
 tools/perf/util/dso.h                              |    8 +-
 tools/perf/util/dwarf-aux.c                        |   10 +-
 tools/perf/util/env.c                              |    5 +-
 tools/perf/util/event.c                            |   44 +-
 tools/perf/util/evlist-hybrid.c                    |  162 --
 tools/perf/util/evlist-hybrid.h                    |   15 -
 tools/perf/util/evlist.c                           |   66 +-
 tools/perf/util/evlist.h                           |   10 +-
 tools/perf/util/evsel.c                            |   92 +-
 tools/perf/util/evsel.h                            |   47 +-
 tools/perf/util/evsel_fprintf.c                    |   28 +-
 tools/perf/util/evsel_fprintf.h                    |    1 +
 tools/perf/util/expr.y                             |   86 +-
 tools/perf/util/genelf_debug.c                     |    6 +-
 tools/perf/util/header.c                           |  140 +-
 tools/perf/util/header.h                           |    4 +
 tools/perf/util/help-unknown-cmd.c                 |    3 +
 tools/perf/util/hist.c                             |   76 +-
 tools/perf/util/intel-bts.c                        |    2 +-
 tools/perf/util/intel-pt.c                         |   88 +-
 tools/perf/util/jitdump.c                          |   12 +-
 tools/perf/util/machine.c                          |  295 +--
 tools/perf/util/map.c                              |   38 +-
 tools/perf/util/map.h                              |    1 +
 tools/perf/util/maps.c                             |    5 +-
 tools/perf/util/maps.h                             |    9 +-
 tools/perf/util/mem-events.c                       |   30 +-
 tools/perf/util/metricgroup.c                      |  142 +-
 tools/perf/util/metricgroup.h                      |    6 +-
 tools/perf/util/parse-events-hybrid.c              |  214 --
 tools/perf/util/parse-events-hybrid.h              |   25 -
 tools/perf/util/parse-events.c                     |  838 ++++----
 tools/perf/util/parse-events.h                     |   69 +-
 tools/perf/util/parse-events.l                     |  131 +-
 tools/perf/util/parse-events.y                     |  265 +--
 tools/perf/util/path.c                             |   35 +-
 tools/perf/util/pfm.c                              |   63 +-
 tools/perf/util/pmu-hybrid.c                       |   72 -
 tools/perf/util/pmu-hybrid.h                       |   33 -
 tools/perf/util/pmu.c                              |  555 +----
 tools/perf/util/pmu.h                              |   49 +-
 tools/perf/util/pmus.c                             |  570 +++++-
 tools/perf/util/pmus.h                             |   20 +-
 tools/perf/util/print-events.c                     |  130 +-
 tools/perf/util/print-events.h                     |    2 +
 tools/perf/util/python-ext-sources                 |    1 -
 tools/perf/util/python.c                           |   18 +
 .../perf/util/scripting-engines/trace-event-perl.c |   15 +-
 .../util/scripting-engines/trace-event-python.c    |   49 +-
 tools/perf/util/session.c                          |    8 +-
 tools/perf/util/setup.py                           |    4 +
 tools/perf/util/sharded_mutex.c                    |   33 +
 tools/perf/util/sharded_mutex.h                    |   29 +
 tools/perf/util/sort.c                             |   14 +-
 tools/perf/util/srcline.c                          |  170 +-
 tools/perf/util/srcline.h                          |    6 +-
 tools/perf/util/stat-display.c                     |  144 +-
 tools/perf/util/stat-shadow.c                      |  131 +-
 tools/perf/util/stat.c                             |   22 +
 tools/perf/util/stat.h                             |   18 +
 tools/perf/util/symbol-elf.c                       |   12 +-
 tools/perf/util/symbol.c                           |   10 +-
 tools/perf/util/symbol.h                           |   17 +-
 tools/perf/util/synthetic-events.c                 |    1 +
 tools/perf/util/syscalltbl.c                       |   14 +-
 tools/perf/util/target.h                           |    1 -
 tools/perf/util/thread-stack.c                     |   25 +-
 tools/perf/util/thread.c                           |  222 +-
 tools/perf/util/thread.h                           |  210 +-
 tools/perf/util/unwind-libdw.c                     |   27 +-
 tools/perf/util/unwind-libunwind-local.c           |   36 +-
 tools/perf/util/unwind-libunwind.c                 |    2 +-
 tools/perf/util/vdso.c                             |    2 +-
 323 files changed, 20333 insertions(+), 11813 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/hybrid.c
 create mode 100644 tools/perf/arch/x86/util/env.c
 create mode 100644 tools/perf/arch/x86/util/env.h
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/intrinsic.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/spe.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/metricgroups.json
 create mode 100644 tools/perf/tests/shell/lib/perf_metric_validation.py
 create mode 100644 tools/perf/tests/shell/lib/perf_metric_validation_rules.json
 create mode 100644 tools/perf/tests/shell/lib/stat_output.sh
 create mode 100755 tools/perf/tests/shell/stat+std_output.sh
 create mode 100755 tools/perf/tests/shell/stat_all_pfm.sh
 create mode 100755 tools/perf/tests/shell/stat_metrics_values.sh
 create mode 100755 tools/perf/tests/shell/test_perf_data_converter_json.sh
 create mode 100644 tools/perf/util/addr_location.c
 create mode 100644 tools/perf/util/addr_location.h
 delete mode 100644 tools/perf/util/evlist-hybrid.c
 delete mode 100644 tools/perf/util/evlist-hybrid.h
 delete mode 100644 tools/perf/util/parse-events-hybrid.c
 delete mode 100644 tools/perf/util/parse-events-hybrid.h
 delete mode 100644 tools/perf/util/pmu-hybrid.c
 delete mode 100644 tools/perf/util/pmu-hybrid.h
 create mode 100644 tools/perf/util/sharded_mutex.c
 create mode 100644 tools/perf/util/sharded_mutex.h

---

Test results:

There's a failure in all metrics test.  This is a known issue and
we are working on it.

  $ make BUILD_BPF_SKEL=1 LIBPFM4=1

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
   72: Event groups                                                    : Ok
   73: Symbols                                                         : Ok
   74: Test dwarf unwind                                               : Ok
   75: Intel PT                                                        :
   75.1: Intel PT packet decoder                                       : Ok
   75.2: Intel PT hybrid CPU compatibility                             : Skip
   76: x86 bp modify                                                   : Ok
   77: x86 Sample parsing                                              : Ok
   78: x86 hybrid                                                      : Skip (not hybrid)
   79: build id cache operations                                       : Ok
   80: CoreSight / ASM Pure Loop                                       : Skip
   81: CoreSight / Memcpy 16k 10 Threads                               : Skip
   82: CoreSight / Thread Loop 10 Threads - Check TID                  : Skip
   83: CoreSight / Thread Loop 2 Threads - Check TID                   : Skip
   84: CoreSight / Unroll Loop Thread 10                               : Skip
   85: daemon operations                                               : Ok
   86: kernel lock contention analysis test                            : Ok
   87: perf pipe recording and injection test                          : Ok
   88: Add vfs_getname probe to get syscall args filenames             : Skip
   89: probe libc's inet_pton & backtrace it with ping                 : Ok
   90: Use vfs_getname probe to get syscall args filenames             : Skip
   91: Zstd perf.data compression/decompression                        : Ok
   92: perf record tests                                               : Ok
   93: perf record offcpu profiling tests                              : Ok
   94: perf stat CSV output linter                                     : Ok
   95: perf stat csv summary test                                      : Ok
   96: perf stat JSON output linter                                    : Ok
   97: perf stat metrics (shadow stat) test                            : Ok
   98: perf stat STD output linter                                     : Ok
   99: perf stat tests                                                 : Ok
  100: perf all metricgroups test                                      : Ok
  101: perf all metrics test                                           : FAILED!
  102: perf all libpfm4 events test                                    : Ok
  103: perf all PMU test                                               : Ok
  104: perf stat --bpf-counters test                                   : Skip
  105: perf stat --bpf-counters --for-each-cgroup test                 : Ok
  106: perf metrics value validation                                   : Skip
  107: Check Arm64 callgraphs are complete in fp mode                  : Skip
  108: Check Arm CoreSight trace data recording and synthesized samples: Skip
  109: Check Arm SPE trace data recording and synthesized samples      : Skip
  110: Check Arm SPE doesn't hang when there are forks                 : Skip
  111: Check branch stack sampling                                     : Skip
  112: Test data symbol                                                : Ok
  113: Miscellaneous Intel PT testing                                  : Skip
  114: Test java symbol                                                : Ok
  115: 'perf data convert --to-json' command test                      : Ok
  116: perf script task-analyzer tests                                 : Ok
  117: Check open filename arg using perf trace + vfs_getname          : Skip

