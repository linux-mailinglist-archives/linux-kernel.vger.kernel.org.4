Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CD565BF2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjACLkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbjACLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:39:59 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9D1BEE;
        Tue,  3 Jan 2023 03:39:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VYn6ldT_1672745992;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VYn6ldT_1672745992)
          by smtp.aliyun-inc.com;
          Tue, 03 Jan 2023 19:39:53 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v5 3/6] perf vendor events arm64: Add cache metrics for neoverse-n2
Date:   Tue,  3 Jan 2023 19:39:33 +0800
Message-Id: <1672745976-2800146-4-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cache related metrics.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 .../arch/arm64/arm/neoverse-n2/metrics.json        | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
index 8a74e07..f81b40d 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
@@ -75,5 +75,82 @@
         "MetricGroup": "TLB",
         "MetricName": "itlb_walk_rate",
         "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "L1I_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of L1 I-Cache misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "l1i_cache_mpki",
+        "ScaleUnit": "MPKI"
+    },
+    {
+        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
+        "BriefDescription": "The rate of L1 I-Cache misses to the overall L1 I-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l1i_cache_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "L1D_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of L1 D-Cache misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "l1d_cache_mpki",
+        "ScaleUnit": "MPKI"
+    },
+    {
+        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
+        "BriefDescription": "The rate of L1 D-Cache misses to the overall L1 D-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l1d_cache_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "L2D_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of L2 D-Cache misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "l2d_cache_mpki",
+        "ScaleUnit": "MPKI"
+    },
+    {
+        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
+        "BriefDescription": "The rate of L2 D-Cache misses to the overall L2 D-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l2d_cache_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "L3D_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of L3 D-Cache misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "l3d_cache_mpki",
+        "ScaleUnit": "MPKI"
+    },
+    {
+        "MetricExpr": "L3D_CACHE_REFILL / L3D_CACHE",
+        "BriefDescription": "The rate of L3 D-Cache misses to the overall L3 D-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l3d_cache_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "LL_CACHE_MISS_RD / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of LL Cache read misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "ll_cache_read_mpki",
+        "ScaleUnit": "MPKI"
+    },
+    {
+        "MetricExpr": "LL_CACHE_MISS_RD / LL_CACHE_RD",
+        "BriefDescription": "The rate of LL Cache read misses to the overall LL Cache read",
+        "MetricGroup": "Cache",
+        "MetricName": "ll_cache_read_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "(LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD",
+        "BriefDescription": "The rate of LL Cache read hit to the overall LL Cache read",
+        "MetricGroup": "Cache",
+        "MetricName": "ll_cache_read_hit_rate",
+        "ScaleUnit": "100%"
     }
 ]
-- 
1.8.3.1

