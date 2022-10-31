Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD26B613439
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJaLL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJaLLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:11:48 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02ACB847;
        Mon, 31 Oct 2022 04:11:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VTVxoIB_1667214703;
Received: from j66e01291.sqa.eu95.tbsite.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VTVxoIB_1667214703)
          by smtp.aliyun-inc.com;
          Mon, 31 Oct 2022 19:11:44 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Subject: [PATCH RFC 3/6] perf vendor events arm64: Add cache metrics for neoverse-n2
Date:   Mon, 31 Oct 2022 19:11:31 +0800
Message-Id: <1667214694-89839-4-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cache related metrics.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arch/arm64/arm/neoverse-n2/metrics.json        | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
index 066d905..2dc6d9e 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
@@ -54,5 +54,82 @@
         "BriefDescription": "The rate of DTLB Walks to the overall TLB lookups",
         "MetricGroup": "TLB",
         "MetricName": "dtlb_walk_rate"
+    },
+    {
+        "MetricExpr": "L1I_CACHE_REFILL / INST_RETIRED * 1000",
+        "PublicDescription": "The rate of L1 I-Cache misses per kilo instructions",
+        "BriefDescription": "The rate of L1 I-Cache misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "l1i_cache_mpki"
+    },
+    {
+        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
+        "PublicDescription": "The rate of L1 I-Cache misses to the overall L1 I-Cache",
+        "BriefDescription": "The rate of L1 I-Cache misses to the overall L1 I-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l1i_cache_miss_rate"
+    },
+    {
+        "MetricExpr": "L1D_CACHE_REFILL / INST_RETIRED * 1000",
+        "PublicDescription": "The rate of L1 D-Cache misses per kilo instructions",
+        "BriefDescription": "The rate of L1 D-Cache misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "l1d_cache_mpki"
+    },
+    {
+        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
+        "PublicDescription": "The rate of L1 D-Cache misses to the overall L1 D-Cache",
+        "BriefDescription": "The rate of L1 D-Cache misses to the overall L1 D-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l1d_cache_miss_rate"
+    },
+    {
+        "MetricExpr": "L2D_CACHE_REFILL / INST_RETIRED * 1000",
+        "PublicDescription": "The rate of L2 D-Cache misses per kilo instructions",
+        "BriefDescription": "The rate of L2 D-Cache misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "l2d_cache_mpki"
+    },
+    {
+        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
+        "PublicDescription": "The rate of L2 D-Cache misses to the overall L2 D-Cache",
+        "BriefDescription": "The rate of L2 D-Cache misses to the overall L2 D-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l2d_cache_miss_rate"
+    },
+    {
+        "MetricExpr": "L3D_CACHE_REFILL / INST_RETIRED * 1000",
+        "PublicDescription": "The rate of L3 D-Cache misses per kilo instructions",
+        "BriefDescription": "The rate of L3 D-Cache misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "l3d_cache_mpki"
+    },
+    {
+        "MetricExpr": "L3D_CACHE_REFILL / L3D_CACHE",
+        "PublicDescription": "The rate of L3 D-Cache misses to the overall L3 D-Cache",
+        "BriefDescription": "The rate of L3 D-Cache misses to the overall L3 D-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l3d_cache_miss_rate"
+    },
+    {
+        "MetricExpr": "LL_CACHE_MISS_RD / INST_RETIRED * 1000",
+        "PublicDescription": "The rate of LL Cache read misses per kilo instructions",
+        "BriefDescription": "The rate of LL Cache read misses per kilo instructions",
+        "MetricGroup": "Cache",
+        "MetricName": "ll_cache_read_mpki"
+    },
+    {
+        "MetricExpr": "LL_CACHE_MISS_RD / LL_CACHE_RD",
+        "PublicDescription": "The rate of LL Cache read misses to the overall LL Cache read",
+        "BriefDescription": "The rate of LL Cache read misses to the overall LL Cache read",
+        "MetricGroup": "Cache",
+        "MetricName": "ll_cache_read_miss_rate"
+    },
+    {
+        "MetricExpr": "(LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD",
+        "PublicDescription": "The rate of LL Cache read hit to the overall LL Cache read",
+        "BriefDescription": "The rate of LL Cache read hit to the overall LL Cache read",
+        "MetricGroup": "Cache",
+        "MetricName": "ll_cache_read_hit_rate"
     }
 ]
\ No newline at end of file
-- 
1.8.3.1

