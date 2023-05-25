Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A807C7105FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjEYHMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjEYHMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:12:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DAB1BD
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:11:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5618857518dso4277027b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998718; x=1687590718;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t01BI3QFegtwIlfIReuEV6hoCGeSyvhEbxHTS2cMx+k=;
        b=FPCwg08lMiPCNwwa8ZqP/YrpEbsl79h3XU6vdnS1eICf1CLFEQapbBtHWgZsGAG/7t
         bH1O4g9p/1etqstO0/DYa8FpFXfN3W51JrXFfiziLwJJUWq4zftfTtffAIT1wHLHGwhl
         XslJ21f5cpwo4tMqZs0NgdBQmpmUODKU2FIb+COScwbO3vRgFPSYSy/0DVTJ4FYKE/K3
         z5eJyXk2C8cNsSC3WwZIZ6hgFk6kHMOHBDr3s5h5uFD+oV1TsZkhCj6Wi+N6Wo8QI6KM
         PH2FlXNwokhAXr6nctamSYhNYXOLhDfAJDsHrrHOU/mT19V2VyJkFi6rGNRGXXHOvrpq
         NKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998718; x=1687590718;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t01BI3QFegtwIlfIReuEV6hoCGeSyvhEbxHTS2cMx+k=;
        b=FiIfsm1M0Armg9zHkC84PnyukIRHzqpfa0YVcTYVqOMwa/LcQ3qvPPTCLjQ405tmWs
         JkprhmspR9Y5D/yPQRSoF3NBY7p3I/QtAKvIbjSRGCZvHuzF2lUQ33VKdmK1wt2x1z3l
         ImMYSjpe1tZ/rQeG0JHD3yJ+wXmnxSiKgie0EwKQRjAxgp8SA2dqPka1HMUW3dO2DkJ7
         iAF9HQjg1DRKWqtds1WJA4szr9bEWjh3vHekspbz1pl24zli/fnmK8K8NhIJWZHfJj6O
         N/iarSKT9vhxgnvHA69zSlMAbvx414qY/fr1MD+81awD3VneVZHWQ/inFEQsjfKHQR4G
         E5PQ==
X-Gm-Message-State: AC+VfDwzb0JPGLMu2dnTtXcam4odIbYsQMyBFNEk4kW2+dPpDve9IO0U
        uJCOadw/nrAtkQBhI4PbfK6vdrHFDSyX
X-Google-Smtp-Source: ACHHUZ7k4CcS4afmm6W2+oCXTMPZQc2W1UETBWL6jFCAGbcTJ/766Ax+V3ebreUZ6SjhoIvB/uVG7XI/9DrJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:b619:0:b0:561:356b:e445 with SMTP id
 u25-20020a81b619000000b00561356be445mr13117914ywh.9.1684998718820; Thu, 25
 May 2023 00:11:58 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:17 -0700
Message-Id: <20230525071133.2066610-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 00/16] Address some perf memory/data size issues
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
        autolearn=ham autolearn_force=no version=3.4.6
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
 tools/perf/builtin-daemon.c                   |  15 +-
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
 tools/perf/util/header.c                      |  33 +++--
 tools/perf/util/path.c                        |  35 +----
 .../util/scripting-engines/trace-event-perl.c |   4 +-
 .../scripting-engines/trace-event-python.c    |   5 +-
 22 files changed, 278 insertions(+), 204 deletions(-)

-- 
2.40.1.698.g37aff9b760-goog

