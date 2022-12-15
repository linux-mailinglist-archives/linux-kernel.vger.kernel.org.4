Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4B64D6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiLOGtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLOGs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:48:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166EB5D6A6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:48:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-348608c1cd3so25630337b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7f+ftDEB/XscFJQDpfXWmmpJPgxMHqMoLjSg/qOK9g=;
        b=DWsBZH37GRXxHtflTCQN9bo03XMR7qc20sxsCAhEK/A4YJEBPiiOU8w9w6ChVpVDYT
         0WpEBRSZthDDZxWmyqgxLewggozNJgkkQ/FRMshUTlEHdfQHRY102tQKMEVrJ9zUV3UW
         TFvxeUh2ijVtW+OeByPfgHVP7gpZf2+AQFgOA47bdKdbLmcskoCCuL2Gf4yQUMNyVlyp
         skj+1uj/rtUB1Q5nlDBX5xsF6HVaquYIdD8ZncMgbGCCz4HloSyl3yHTHvvGZ33lhnn7
         VKBeMNPC5fsIsi3vs6bWmCpVPWqJoAFulOCJ37Jj85E5QZc1D+gd5aocHGa6cOGi9BQ5
         1Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7f+ftDEB/XscFJQDpfXWmmpJPgxMHqMoLjSg/qOK9g=;
        b=1mjl6JhmhKP3OOtuX2xVnOxAGSAPF52TYoPz5xdIZmR4ZZ/9JRkV1V8KpXiRoft3HV
         eY5N0KRUlsycYIBaJZICpiKbvf80j3V5JkK78k+KZIs8gO6D+mscKtDYWjz5/DLu5zu8
         W6O8VM57yBV2bhv+Li3oO+x7DcBuLH6eENUt0fPtubGp5+J5qUmfYiTB6ATCcyTW1atY
         0fAX5UTq3l9EmJ2PdqbVKuXKI6WSsM6mcJMAtp/QaPr00OsqDEdA31bdTRXJ6AdlOgl3
         8g7qTetQRPUUfeqVxeaeb9utDUdGIBkoftwV7LcBBXrMN+CklS0mxbUnp6sH2Wrw/xl6
         OL7w==
X-Gm-Message-State: ANoB5pm/6Hs0s2SsYBaS7o/s0qu0uWMK56MAaF2/FLQfa+h4wAsTnuxg
        9Fgkmeaq5NwmToMlS77ozpnHt1ovt10x
X-Google-Smtp-Source: AA0mqf4STu49h1zw79zmzo9IK81NSrN8nlXXJuttIezlpXhv+yPMwpGKoY9evu6yecQcZl41LHZdr3mnRdT7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c7dc:d96f:4f9:f59d])
 (user=irogers job=sendgmr) by 2002:a0d:d9d1:0:b0:3f5:7f7d:2d4f with SMTP id
 b200-20020a0dd9d1000000b003f57f7d2d4fmr14134112ywe.276.1671086911361; Wed, 14
 Dec 2022 22:48:31 -0800 (PST)
Date:   Wed, 14 Dec 2022 22:47:26 -0800
In-Reply-To: <20221215064755.1620246-1-irogers@google.com>
Message-Id: <20221215064755.1620246-4-irogers@google.com>
Mime-Version: 1.0
References: <20221215064755.1620246-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 03/32] perf vendor events intel: Refresh alderlake-n metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Garry <john.g.garry@oracle.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
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

Update the alderlake-n metrics using the new tooling from:
https://github.com/intel/perfmon
The metrics are unchanged but the formulas differ due to parentheses,
use of exponents and removal of redundant operations like "* 1".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlaken/adln-metrics.json     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index c57e9f325fb0..9a352a8b6b70 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -165,14 +165,14 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stalled due to stores or loads. ",
-        "MetricExpr": "min((TOPDOWN_BE_BOUND.ALL / SLOTS), (LD_HEAD.ANY_AT_RET / CLKS) + tma_store_bound)",
+        "MetricExpr": "min(tma_backend_bound, LD_HEAD.ANY_AT_RET / CLKS + tma_store_bound)",
         "MetricGroup": "TopdownL2;tma_backend_bound_group",
         "MetricName": "tma_load_store_bound",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stalled due to store buffer full.",
-        "MetricExpr": "tma_mem_scheduler * (MEM_SCHEDULER_BLOCK.ST_BUF / MEM_SCHEDULER_BLOCK.ALL)",
+        "MetricExpr": "tma_st_buffer",
         "MetricGroup": "TopdownL3;tma_load_store_bound_group",
         "MetricName": "tma_store_bound",
         "ScaleUnit": "100%"
@@ -214,21 +214,21 @@
     },
     {
         "BriefDescription": "Counts the number of cycles a core is stalled due to a demand load which hit in the L2 Cache.",
-        "MetricExpr": "(MEM_BOUND_STALLS.LOAD_L2_HIT / CLKS) - (MEM_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_STALLS.LOAD)",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / CLKS - MEM_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_STALLS.LOAD",
         "MetricGroup": "TopdownL3;tma_load_store_bound_group",
         "MetricName": "tma_l2_bound",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of cycles a core is stalled due to a demand load which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
-        "MetricExpr": "(MEM_BOUND_STALLS.LOAD_LLC_HIT / CLKS) - (MEM_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND_STALLS.LOAD)",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / CLKS - MEM_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND_STALLS.LOAD",
         "MetricGroup": "TopdownL3;tma_load_store_bound_group",
         "MetricName": "tma_l3_bound",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stalled due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
-        "MetricExpr": "(MEM_BOUND_STALLS.LOAD_DRAM_HIT / CLKS) - (MEM_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOUND_STALLS.LOAD)",
+        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / CLKS - MEM_BOUND_STALLS_AT_RET_CORRECTION * MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOUND_STALLS.LOAD",
         "MetricGroup": "TopdownL3;tma_load_store_bound_group",
         "MetricName": "tma_dram_bound",
         "ScaleUnit": "100%"
@@ -401,12 +401,12 @@
         "MetricName": "Load_Splits"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricName": "IpBranch"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number means higher occurrence rate)",
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
         "MetricName": "IpCall"
     },
@@ -492,22 +492,22 @@
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in the L2",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / (MEM_BOUND_STALLS.IFETCH)",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / MEM_BOUND_STALLS.IFETCH",
         "MetricName": "Inst_Miss_Cost_L2Hit_Percent"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / (MEM_BOUND_STALLS.IFETCH)",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / MEM_BOUND_STALLS.IFETCH",
         "MetricName": "Inst_Miss_Cost_L3Hit_Percent"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in DRAM",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_DRAM_HIT / (MEM_BOUND_STALLS.IFETCH)",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_DRAM_HIT / MEM_BOUND_STALLS.IFETCH",
         "MetricName": "Inst_Miss_Cost_DRAMHit_Percent"
     },
     {
         "BriefDescription": "load ops retired per 1000 instruction",
-        "MetricExpr": "1000 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
         "MetricName": "MemLoadPKI"
     },
     {
-- 
2.39.0.314.g84b9a713c41-goog

