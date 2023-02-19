Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C071069BFE5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBSJxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBSJxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:53:35 -0500
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B022689
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:53:30 -0800 (PST)
Received: by mail-oo1-f73.google.com with SMTP id e22-20020a4a5516000000b0051faef7ba52so52529oob.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEW8cpP+9cEKKFEdVgrXtSkmKtdo53fKw92TT63XLiE=;
        b=n4X3/MyCrrOq2mj67RyYv+wSgQgAcXUl5ZNGMxwZaz9J4PgnjVhdA1gdEU4c7rVlKF
         RD00qyZUg2Nu0n9I83joDDS11WMNhVImRYuGl74bUdlm/NTcCXRU+s9231VSqdViQ5y5
         IOjhRW1LL0rd9D6VBrftyxEETIGZdePeZwPEUGiN5/i9rfa+KjDdpnTAf03uChXg7LNL
         HofGnGJrz33+hAH8qvx1150CJ4NN8RVbooFRVWHl3Pa2X5o7hZoSId7AYt1X7xwfP/qF
         /RVOFCjEigymUkIoiJhHOh3HzHiK5xYr4mOzg/3XkdKF3C1nQhiXmDqDiljssst6B9/K
         PH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEW8cpP+9cEKKFEdVgrXtSkmKtdo53fKw92TT63XLiE=;
        b=kgJJp+WcvgAl44DbCiNEl1dcgHkTGfw86fkMQ9ZSdvydvNixJvxAytpOo0F/zBNIgy
         D0uynyqWcIpcDhpzPuOCKnB74J+BozTZdDnnOspPcmoBmJOR25KVnkOnD7nko6TBb39J
         sUU0RzMBIdZbwsYtEdMyv324oGBYZ7B/3TCTe6hCjWrQv5Ro07ZTHIlFVXNF96my3MkP
         AJkM2nkkWEJ1XU8IMms2moBXnCnMfMXO/rrAaC69GRLGchueK/S8zIVwRg6SEsSp2gOm
         CtGtijeqyeucg0ePeOpQQYQoXCKxdx29/Ye14i/rSbCIe9G9ANwXE0TsPXqOQm74OFA3
         7N1g==
X-Gm-Message-State: AO0yUKUJoyVA7/XzTZE+steRHwHPSueR89738jfqBe+zGKwz94j/hfVU
        WMxjG2v5t7o4X5jhvaHrgzPeW1cN/NaX
X-Google-Smtp-Source: AK7set8spPyZO4MEjdB9EukutZFjqKW246tjX03kiCSEfiRaEKKsqhZirSzcKYSMxMoXEmrbZbYuYr3mLKct
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:11cd:b0:8a3:d147:280b with SMTP
 id n13-20020a05690211cd00b008a3d147280bmr181444ybu.3.1676799294311; Sun, 19
 Feb 2023 01:34:54 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:39 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-43-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 42/51] perf doc: Refresh topdown documentation
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf stat now supports --topdown for any platform with the TopdownL1
metric group including Intel before Icelake. Tweak the documentation
to reflect this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt | 27 +++++-----
 tools/perf/Documentation/topdown.txt   | 70 +++++++++++---------------
 2 files changed, 44 insertions(+), 53 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 18abdc1dce05..29bdcfa93f04 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -394,10 +394,10 @@ See perf list output for the possible metrics and metricgroups.
 Do not aggregate counts across all monitored CPUs.
 
 --topdown::
-Print complete top-down metrics supported by the CPU. This allows to
-determine bottle necks in the CPU pipeline for CPU bound workloads,
-by breaking the cycles consumed down into frontend bound, backend bound,
-bad speculation and retiring.
+Print top-down metrics supported by the CPU. This allows to determine
+bottle necks in the CPU pipeline for CPU bound workloads, by breaking
+the cycles consumed down into frontend bound, backend bound, bad
+speculation and retiring.
 
 Frontend bound means that the CPU cannot fetch and decode instructions fast
 enough. Backend bound means that computation or memory access is the bottle
@@ -430,15 +430,18 @@ CPUs the workload runs on. If needed the CPUs can be forced using
 taskset.
 
 --td-level::
-Print the top-down statistics that equal to or lower than the input level.
-It allows users to print the interested top-down metrics level instead of
-the complete top-down metrics.
+Print the top-down statistics that equal the input level. It allows
+users to print the interested top-down metrics level instead of the
+level 1 top-down metrics.
+
+As the higher levels gather more metrics and use more counters they
+will be less accurate. By convention a metric can be examined by
+appending '_group' to it and this will increase accuracy compared to
+gathering all metrics for a level. For example, level 1 analysis may
+highlight 'tma_frontend_bound'. This metric may be drilled into with
+'tma_frontend_bound_group' with
+'perf stat -M tma_frontend_bound_group...'.
 
-The availability of the top-down metrics level depends on the hardware. For
-example, Ice Lake only supports L1 top-down metrics. The Sapphire Rapids
-supports both L1 and L2 top-down metrics.
-
-Default: 0 means the max level that the current hardware support.
 Error out if the input is higher than the supported max level.
 
 --no-merge::
diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
index a15b93fdcf50..ae0aee86844f 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -1,46 +1,35 @@
-Using TopDown metrics in user space
------------------------------------
+Using TopDown metrics
+---------------------
 
-Intel CPUs (since Sandy Bridge and Silvermont) support a TopDown
-methodology to break down CPU pipeline execution into 4 bottlenecks:
-frontend bound, backend bound, bad speculation, retiring.
+TopDown metrics break apart performance bottlenecks. Starting at level
+1 it is typical to get metrics on retiring, bad speculation, frontend
+bound, and backend bound. Higher levels provide more detail in to the
+level 1 bottlenecks, such as at level 2: core bound, memory bound,
+heavy operations, light operations, branch mispredicts, machine
+clears, fetch latency and fetch bandwidth. For more details see [1][2][3].
 
-For more details on Topdown see [1][5]
+perf stat --topdown implements this using available metrics that vary
+per architecture.
 
-Traditionally this was implemented by events in generic counters
-and specific formulas to compute the bottlenecks.
-
-perf stat --topdown implements this.
-
-Full Top Down includes more levels that can break down the
-bottlenecks further. This is not directly implemented in perf,
-but available in other tools that can run on top of perf,
-such as toplev[2] or vtune[3]
+% perf stat -a --topdown -I1000
+#           time      %  tma_retiring %  tma_backend_bound %  tma_frontend_bound %  tma_bad_speculation
+     1.001141351                 11.5                 34.9                  46.9                    6.7
+     2.006141972                 13.4                 28.1                  50.4                    8.1
+     3.010162040                 12.9                 28.1                  51.1                    8.0
+     4.014009311                 12.5                 28.6                  51.8                    7.2
+     5.017838554                 11.8                 33.0                  48.0                    7.2
+     5.704818971                 14.0                 27.5                  51.3                    7.3
+...
 
-New Topdown features in Ice Lake
-===============================
+New Topdown features in Intel Ice Lake
+======================================
 
 With Ice Lake CPUs the TopDown metrics are directly available as
 fixed counters and do not require generic counters. This allows
 to collect TopDown always in addition to other events.
 
-% perf stat -a --topdown -I1000
-#           time             retiring      bad speculation       frontend bound        backend bound
-     1.001281330                23.0%                15.3%                29.6%                32.1%
-     2.003009005                 5.0%                 6.8%                46.6%                41.6%
-     3.004646182                 6.7%                 6.7%                46.0%                40.6%
-     4.006326375                 5.0%                 6.4%                47.6%                41.0%
-     5.007991804                 5.1%                 6.3%                46.3%                42.3%
-     6.009626773                 6.2%                 7.1%                47.3%                39.3%
-     7.011296356                 4.7%                 6.7%                46.2%                42.4%
-     8.012951831                 4.7%                 6.7%                47.5%                41.1%
-...
-
-This also enables measuring TopDown per thread/process instead
-of only per core.
-
-Using TopDown through RDPMC in applications on Ice Lake
-======================================================
+Using TopDown through RDPMC in applications on Intel Ice Lake
+=============================================================
 
 For more fine grained measurements it can be useful to
 access the new  directly from user space. This is more complicated,
@@ -301,8 +290,8 @@ This "opens" a new measurement period.
 A program using RDPMC for TopDown should schedule such a reset
 regularly, as in every few seconds.
 
-Limits on Ice Lake
-==================
+Limits on Intel Ice Lake
+========================
 
 Four pseudo TopDown metric events are exposed for the end-users,
 topdown-retiring, topdown-bad-spec, topdown-fe-bound and topdown-be-bound.
@@ -318,8 +307,8 @@ a sampling read group. Since the SLOTS event must be the leader of a TopDown
 group, the second event of the group is the sampling event.
 For example, perf record -e '{slots, $sampling_event, topdown-retiring}:S'
 
-Extension on Sapphire Rapids Server
-===================================
+Extension on Intel Sapphire Rapids Server
+=========================================
 The metrics counter is extended to support TMA method level 2 metrics.
 The lower half of the register is the TMA level 1 metrics (legacy).
 The upper half is also divided into four 8-bit fields for the new level 2
@@ -338,7 +327,6 @@ other four level 2 metrics by subtracting corresponding metrics as below.
 
 
 [1] https://software.intel.com/en-us/top-down-microarchitecture-analysis-method-win
-[2] https://github.com/andikleen/pmu-tools/wiki/toplev-manual
-[3] https://software.intel.com/en-us/intel-vtune-amplifier-xe
+[2] https://sites.google.com/site/analysismethods/yasin-pubs
+[3] https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
 [4] https://github.com/andikleen/pmu-tools/tree/master/jevents
-[5] https://sites.google.com/site/analysismethods/yasin-pubs
-- 
2.39.2.637.g21b0678d19-goog

