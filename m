Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDA06E063F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDMFKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjDMFKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:10:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E5C6EBA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:10:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54be7584b28so259110297b3.16
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681362650; x=1683954650;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3U/UkZyLHB6ljiv4pSojGVthduu/8Vy9B+bhziCi4Y=;
        b=QPDgGpswUcuTd1THiOH7b0kkxLJTJXytXpF7l2vX1wh7m/eR/ym2kr361GSbwlQtW7
         VKWqh/vJD/8c/uQ13ikswcZR7ZsVquNhztdJg+rGGTGYa01TsDSA3M+D5jc/3flZ23J/
         G2TFJ9PCZagKtF8g8ufutob7SSv4gupHOut7NTcctV8DNrkvcEOqlQJ6fldKwXRZyFtA
         rL31rvCK/Nt+mYs75fIl59OVXN/hhIgi6LmGkWbaa3rUfZPIT2f7xV6E9s5iyNBvltrD
         /eHPlVKxxKyIr+SDswC5Xpg6XQeiVHeHjjqXee/zibtOUX39ifNqc3YLzIjoWQP80r14
         p3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362650; x=1683954650;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3U/UkZyLHB6ljiv4pSojGVthduu/8Vy9B+bhziCi4Y=;
        b=d0OyQY9brI2qM5DaSgIml6zHoP+EiPx0X3n5sfgsy3elhoBufaT6ZEnfl2KIvidPS4
         91STlOxJAhy1RK5eJFv5jbnSNQNKzA501L+Z1/j43Fc5hZisDXgmx0KZegjY2l1zHA0R
         vnVEfNogI2gCvjmQDLyk/k4ftPGefXibxhnCDyTy3RQxjrqdir/NT0hr86/KQ50QqN9A
         0S4zpmT0Wpv6/Z08Ql9ANSjzE0exm9Zy3Q1z3/sfZ0mjhk9AGUSuCyjlycCtubW/Id2i
         4E02fNvAgiUdllnn46nGFpd7ZqRavllvYC+MWXOusCrMLnjUrFDuisPfGjbruVIbFxIP
         daqw==
X-Gm-Message-State: AAQBX9dxxHg8zeiSszeBR+xUY792wAnY4EKJBxBn7eXOVDqgqMNnEUwY
        em1As7AX1tpA1zv8UAGTRQwRvAEYQ1jl
X-Google-Smtp-Source: AKy350bCIJuWCCbNPmg0SxPl9w19MaXZfluVl+GpnD7IJkDK6JM+QOuYk0Sa36zwpEvXjdyUzJook5ieVgqY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8fe:b894:ec92:d5cd])
 (user=irogers job=sendgmr) by 2002:a81:4514:0:b0:54f:b931:adf0 with SMTP id
 s20-20020a814514000000b0054fb931adf0mr696947ywa.2.1681362649887; Wed, 12 Apr
 2023 22:10:49 -0700 (PDT)
Date:   Wed, 12 Apr 2023 22:09:51 -0700
In-Reply-To: <20230413051011.3440849-1-irogers@google.com>
Message-Id: <20230413051011.3440849-2-irogers@google.com>
Mime-Version: 1.0
References: <20230413051011.3440849-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 01/21] perf vendor events intel: Update alderlake to v1.20
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
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

Update from v1.19 to v1.20 affecting the performance/goldencove
events. Adds cmask=1 for ARITH.IDIV_ACTIVE, and updates event
descriptions.

A number of events have their topic (derived from the filename)
changed to be more accurate than 'uncore-other'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/alderlake/other.json  |  3 +-
 .../arch/x86/alderlake/pipeline.json          |  4 +-
 .../x86/alderlake/uncore-interconnect.json    | 90 +++++++++++++++++++
 .../arch/x86/alderlake/uncore-other.json      | 88 ------------------
 .../x86/alderlaken/uncore-interconnect.json   | 26 ++++++
 .../arch/x86/alderlaken/uncore-other.json     | 24 -----
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  4 +-
 7 files changed, 123 insertions(+), 116 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/perf/pmu-events/arch/x86/alderlake/other.json
index 329c611d7cf7..1db73e020215 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -162,10 +162,11 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "XQ.FULL_CYCLES",
+        "BriefDescription": "Cycles the uncore cannot take further requests",
         "CounterMask": "1",
         "EventCode": "0x2d",
         "EventName": "XQ.FULL_CYCLES",
+        "PublicDescription": "number of cycles when the thread is active and the uncore cannot take any further requests (for example prefetches, loads or stores initiated by the Core that miss the L2 cache).",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
index f848530fbf07..cb5b8611064b 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -31,6 +31,7 @@
     },
     {
         "BriefDescription": "This event counts the cycles the integer divider is busy.",
+        "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
         "SampleAfterValue": "1000003",
@@ -1079,9 +1080,10 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "MISC2_RETIRED.LFENCE",
+        "BriefDescription": "LFENCE instructions retired",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
+        "PublicDescription": "number of LFENCE retired instructions",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
new file mode 100644
index 000000000000..34fc052d00e4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
@@ -0,0 +1,90 @@
+[
+    {
+        "BriefDescription": "Number of requests allocated in Coherency Tracker.",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of any coherent request at memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of coherent reads pending on data return from memory controller that were issued by any core.",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_DAT_OCCUPANCY.ALL",
+        "EventCode": "0x85",
+        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_OCCUPANCY.RD]",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.RD]",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_OCCUPANCY.DRD]",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUEST.DRD]",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "ARB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
index 5f3b4c6e2e39..2af92e43b28a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
@@ -1,92 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of requests allocated in Coherency Tracker.",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of any coherent request at memory controller that were issued by any core.",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of coherent reads pending on data return from memory controller that were issued by any core.",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_REQ_TRK_REQUEST.DRD",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_DAT_OCCUPANCY.ALL",
-        "EventCode": "0x85",
-        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_OCCUPANCY.RD]",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.RD]",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_OCCUPANCY.DRD]",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUEST.DRD]",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "ARB"
-    },
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles.",
         "EventCode": "0xff",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
new file mode 100644
index 000000000000..4af695a5e755
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
@@ -0,0 +1,26 @@
+[
+    {
+        "BriefDescription": "Number of requests allocated in Coherency Tracker.",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC.",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "ARB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
index f9e7777cd2be..2af92e43b28a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
@@ -1,28 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of requests allocated in Coherency Tracker.",
-        "EventCode": "0x84",
-        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
-        "EventCode": "0x80",
-        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
-    {
-        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC.",
-        "EventCode": "0x81",
-        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "ARB"
-    },
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles.",
         "EventCode": "0xff",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 97b3ffc284a6..9e7545d09b23 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.19,alderlake,core
-GenuineIntel-6-BE,v1.19,alderlaken,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.20,alderlake,core
+GenuineIntel-6-BE,v1.20,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v27,broadwell,core
 GenuineIntel-6-56,v9,broadwellde,core
-- 
2.40.0.577.gac1e443424-goog

