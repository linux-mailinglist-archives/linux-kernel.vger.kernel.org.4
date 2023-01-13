Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA326692EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbjAMJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbjAMJ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:27:22 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596CE4319B;
        Fri, 13 Jan 2023 01:22:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VZUDRUc_1673601757;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZUDRUc_1673601757)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 17:22:38 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v7 5/9] perf vendor events arm64: Add TLB metrics for neoverse-n2-v2
Date:   Fri, 13 Jan 2023 17:22:16 +0800
Message-Id: <1673601740-122788-6-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TLB related metrics.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json     | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
index 4e7417f..60bbd8f 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
@@ -13,5 +13,54 @@
     },
     {
         "ArchStdEvent": "BACKEND_BOUND"
+    },
+    {
+        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
+        "BriefDescription": "The rate of L1D TLB refill to the overall L1D TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "l1d_tlb_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
+        "BriefDescription": "The rate of L1I TLB refill to the overall L1I TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "l1i_tlb_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
+        "BriefDescription": "The rate of L2D TLB refill to the overall L2D TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "l2_tlb_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of TLB Walks per kilo instructions for data accesses",
+        "MetricGroup": "TLB",
+        "MetricName": "dtlb_mpki",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricExpr": "DTLB_WALK / L1D_TLB",
+        "BriefDescription": "The rate of DTLB Walks to the overall L1D TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "dtlb_walk_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of TLB Walks per kilo instructions for instruction accesses",
+        "MetricGroup": "TLB",
+        "MetricName": "itlb_mpki",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricExpr": "ITLB_WALK / L1I_TLB",
+        "BriefDescription": "The rate of ITLB Walks to the overall L1I TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "itlb_walk_rate",
+        "ScaleUnit": "100%"
     }
 ]
-- 
1.8.3.1

