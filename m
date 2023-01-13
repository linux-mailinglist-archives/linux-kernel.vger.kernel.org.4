Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48226692ED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbjAMJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbjAMJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:27:26 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6314843A1F;
        Fri, 13 Jan 2023 01:22:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VZUDRVd_1673601762;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZUDRVd_1673601762)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 17:22:42 +0800
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
Subject: [PATCH v7 9/9] perf vendor events arm64: Add instruction mix metrics for neoverse-n2-v2
Date:   Fri, 13 Jan 2023 17:22:20 +0800
Message-Id: <1673601740-122788-10-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add instruction mix related metrics.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json     | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
index 3d6ac0c..8ad15b7 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
@@ -206,5 +206,68 @@
         "MetricGroup": "PEutilization",
         "MetricName": "cpu_utilization",
         "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "LD_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of load instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "load_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "ST_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of store instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "store_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "DP_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of integer data-processing instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "data_process_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "ASE_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of advanced SIMD instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "advanced_simd_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "VFP_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of floating point instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "float_point_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "CRYPTO_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of crypto instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "crypto_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "BR_IMMED_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of branch immediate instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "branch_immed_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "BR_RETURN_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of procedure return instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "branch_return_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "BR_INDIRECT_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of indirect branch instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "branch_indirect_spec_rate",
+        "ScaleUnit": "100%"
     }
 ]
-- 
1.8.3.1

