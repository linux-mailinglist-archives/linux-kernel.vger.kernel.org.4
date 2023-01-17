Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDB366D6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjAQHaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjAQHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:30:01 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496B722A38;
        Mon, 16 Jan 2023 23:29:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VZm6e4A_1673940594;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZm6e4A_1673940594)
          by smtp.aliyun-inc.com;
          Tue, 17 Jan 2023 15:29:54 +0800
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
Subject: [PATCH v8 6/9] perf vendor events arm64: Add cache metrics for neoverse-n2-v2
Date:   Tue, 17 Jan 2023 15:29:30 +0800
Message-Id: <1673940573-90503-7-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673940573-90503-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1673940573-90503-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cache related metrics.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json     | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
index 60bbd8f..08c6aaa 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
@@ -62,5 +62,82 @@
         "MetricGroup": "TLB",
         "MetricName": "itlb_walk_rate",
         "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "L1I_CACHE_REFILL / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of L1 I-Cache misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "l1i_cache_mpki",
+        "ScaleUnit": "1MPKI"
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
+        "ScaleUnit": "1MPKI"
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
+        "ScaleUnit": "1MPKI"
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
+        "ScaleUnit": "1MPKI"
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
+        "ScaleUnit": "1MPKI"
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

