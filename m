Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA2712C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbjEZSeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242500AbjEZSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:13 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D0134
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2534d7abebeso834111a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126050; x=1687718050;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IVzXsABWVrToZ7tRwJqLE05TXfsenHHrgF1lCArhyQ8=;
        b=5DYIRQ/PY53leU21RViYdnXrQS4045s8ZG4DtABzUSV2B1DWp7Z+3Ng2a95y+VsNdG
         /EOh0yYGdGZrs0Xoh3KnpybfJFL98Sh0oBEDUTpnL6TvVAsINKu4aBq3dxxaRToOyhB6
         Kgs77o1IXKrk+QZ82PSejlOp6Jb1g9ImA5SIrSp2srHUQIofsTlDP3H4ek1nKt/HwpjZ
         QisdWKCRIi4awYrSNgE2l9tJUX1vTaWOzq/AQLIEQIlOZplDj/OJ2fIEeTqEWTJwdm+a
         QWJPuxE4nIsfMuO0lUgAKPiq3RQvpc85UZAySI6P+SL9+DLV7cIVuL0Q/8O5gjnNZVBe
         ELGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126050; x=1687718050;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVzXsABWVrToZ7tRwJqLE05TXfsenHHrgF1lCArhyQ8=;
        b=RYBLRwa+JSU6fkH6p9Fx5zU9oQQZDfOz90rXGHc/t1okfNq0kBUbqRQXsmihfsAaSZ
         jKhAIam2QEClA5nP4dD5kihMxOP9y6Px56qlt5QeQycoQHOc62AzYuhmClb8aueG2/mg
         0NRni/6JHqX+sGtlKpwE+mhQ50ji33ymdZK4L1pNB5QN/gUrfgGZ0O6Q86ZPycexye4L
         t4U7pOUzCZCE4DBO0r/cnkp7HbcvKQxFMOpD9isRAdnIW0YS+wrx83+YM33ipRm3NfVE
         QUCS9RzIXtUmRBu66Cu9CsS7LtS5r8jwrwlOh4jt3nh2aBNS5dQz8gJ+ODi3VXrIx6I+
         Xzog==
X-Gm-Message-State: AC+VfDyyy0hc09Zm/yhW+0TZFx7NL39tf4u3xFxmae1wG38lQSoGBR6D
        gI53jT4AHsnMhw5DtzKZ+fnyd/spbtCl
X-Google-Smtp-Source: ACHHUZ64A571kAdtoquIAqZhXYDAWk7Pcy8C1D6koWOlDQ3LjZVliWTNq+S9lKeEEbW0qROw3Le1Flt/WvXS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:90a:9904:b0:246:6a3a:6aec with SMTP id
 b4-20020a17090a990400b002466a3a6aecmr716829pjp.4.1685126049889; Fri, 26 May
 2023 11:34:09 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:45 -0700
Message-Id: <20230526183401.2326121-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 00/16] Address some perf memory/data size issues
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to reduce the data size of the perf command. Before these patches
a stripped non-debug binary was:

$ size -A perf
perf  :
section                  size       addr
.interp                    28        848
.note.gnu.property         32        880
.note.gnu.build-id         36        912
.note.ABI-tag              32        948
.gnu.hash               24628        984
.dynsym                 88920      25616
.dynstr                 70193     114536
.gnu.version             7410     184730
.gnu.version_r            800     192144
.rela.dyn              460824     192944
.rela.plt               14784     653768
.init                      23     671744
.plt                     9872     671776
.plt.got                   24     681648
.text                 2279182     681680
.noinstr.text             476    2960864
.fini                       9    2961340
.rodata               7042922    2961408
.eh_frame_hdr           42844   10004332
.eh_frame              226496   10047176
.tbss                      48   10279720
.init_array                16   10279720
.fini_array                 8   10279736
.data.rel.ro            53376   10279744
.dynamic                  736   10333120
.got                      328   10333856
.got.plt                 4952   10334184
.data                  391088   10339136
.bss                   285776   10730240
.comment                   31          0
Total                11005894

And after:
perf  :
section                  size       addr
.interp                    28        848
.note.gnu.property         32        880
.note.gnu.build-id         36        912
.note.ABI-tag              32        948
.gnu.hash               24628        984
.dynsym                 88944      25616
.dynstr                 70217     114560
.gnu.version             7412     184778
.gnu.version_r            816     192192
.rela.dyn              460824     193008
.rela.plt               14808     653832
.init                      23     671744
.plt                     9888     671776
.plt.got                   24     681664
.text                 2280446     681696
.noinstr.text             476    2962144
.fini                       9    2962620
.rodata               7048746    2965504
.eh_frame_hdr           42852   10014252
.eh_frame              226568   10057104
.tbss                      48   10285640
.init_array                16   10285640
.fini_array                 8   10285656
.data.rel.ro           301408   10285664
.dynamic                  736   10587072
.got                      328   10587808
.got.plt                 4960   10588136
.data                  100464   10593152
.bss                    22512   10693632
.comment                   31          0
Total                10707320

The binary has reduced in size by 298,574 bytes. The .bss, that
doesn't count toward file size, is reduced by 263,254 bytes. At
runtime this could reduce the footprint up to 561,828 bytes. This is
still just a fraction of the .rodata section's size of 7,048,746
bytes, that mainly contains the converted json events. The .rodata
section needn't all be mapped at the same time.

The changes are largely removing static variables and replacing them
with local or dynamically allocated memory. A common issue was having
paths in statics for the sake of returning a non-stack pointer to a
buffer, so the APIs were changed to pass buffers in.

v2. Address review comments from Namhyung, thanks!

Ian Rogers (16):
  perf header: Make nodes dynamic in write_mem_topology
  perf test x86: insn-x86 test data is immutable so mark it const
  perf test x86: intel-pt-test data is immutable so mark it const
  perf trace: Make some large static arrays const
  perf trace beauty: Make MSR arrays const
  tools api fs: Avoid large static PATH_MAX arrays
  tools lib api fs tracing_path: Remove two unused MAX_PATH paths
  perf daemon: Dynamically allocate path to perf
  perf lock: Dynamically allocate lockhash_table
  perf timechart: Make large arrays dynamic
  perf probe: Dynamically allocate params memory
  perf path: Make mkpath thread safe
  perf scripting-engines: Move static to local variable
  tools api fs: Dynamically allocate cgroupfs mount point cache
  perf test pmu: Avoid 2 static path arrays
  libsubcmd: Avoid two path statics

 tools/lib/api/fs/cgroup.c                     |  17 ++-
 tools/lib/api/fs/fs.c                         |  25 +++-
 tools/lib/api/fs/tracing_path.c               |  17 +--
 tools/lib/subcmd/exec-cmd.c                   |  35 +++--
 tools/perf/arch/x86/tests/insn-x86.c          |  10 +-
 tools/perf/arch/x86/tests/intel-pt-test.c     |  14 +-
 tools/perf/builtin-config.c                   |   4 +-
 tools/perf/builtin-daemon.c                   |  44 +++---
 tools/perf/builtin-help.c                     |   4 +-
 tools/perf/builtin-lock.c                     |  20 ++-
 tools/perf/builtin-probe.c                    | 133 ++++++++++--------
 tools/perf/builtin-timechart.c                |  48 +++++--
 tools/perf/builtin-trace.c                    |  33 +++--
 tools/perf/tests/pmu.c                        |  17 +--
 tools/perf/trace/beauty/beauty.h              |   2 +-
 .../perf/trace/beauty/tracepoints/x86_msr.sh  |   6 +-
 tools/perf/util/cache.h                       |   2 +-
 tools/perf/util/config.c                      |   3 +-
 tools/perf/util/header.c                      |  41 +++---
 tools/perf/util/path.c                        |  35 +----
 .../util/scripting-engines/trace-event-perl.c |   4 +-
 .../scripting-engines/trace-event-python.c    |   5 +-
 22 files changed, 297 insertions(+), 222 deletions(-)

-- 
2.41.0.rc0.172.g3f132b7071-goog

