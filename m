Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2956462768A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiKNHnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiKNHm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:42:58 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E270E18B37;
        Sun, 13 Nov 2022 23:42:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VUjWi3C_1668411762;
Received: from j66e01291.sqa.eu95.tbsite.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VUjWi3C_1668411762)
          by smtp.aliyun-inc.com;
          Mon, 14 Nov 2022 15:42:43 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: [RFC PATCH v2 6/6] perf vendor events arm64: Add instruction mix metrics for neoverse-n2
Date:   Mon, 14 Nov 2022 15:42:00 +0800
Message-Id: <1668411720-3581-7-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com>
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

Add instruction mix related metrics.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arch/arm64/arm/neoverse-n2/metrics.json        | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
index 3c14971..8ff1dfe 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
@@ -180,5 +180,68 @@
         "BriefDescription": "Utilization of CPU",
         "MetricGroup": "PEutilization",
         "MetricName": "cpu_utilization"
+    },
+    {
+        "MetricExpr": "LD_SPEC / INST_SPEC",
+        "PublicDescription": "The rate of load instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of load instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "load_spec_rate"
+    },
+    {
+        "MetricExpr": "ST_SPEC / INST_SPEC",
+        "PublicDescription": "The rate of store instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of store instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "store_spec_rate"
+    },
+    {
+        "MetricExpr": "DP_SPEC / INST_SPEC",
+        "PublicDescription": "The rate of integer data-processing instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of integer data-processing instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "date_process_spec_rate"
+    },
+    {
+        "MetricExpr": "ASE_SPEC / INST_SPEC",
+        "PublicDescription": "The rate of advanced SIMD instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of advanced SIMD instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "advanced_simd_spec_rate"
+    },
+    {
+        "MetricExpr": "VFP_SPEC / INST_SPEC",
+        "PublicDescription": "The rate of floating point instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of floating point instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "float_point_spec_rate"
+    },
+    {
+        "MetricExpr": "CRYPTO_SPEC / INST_SPEC",
+        "PublicDescription": "The rate of crypto instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of crypto instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "crypto_spec_rate"
+    },
+    {
+        "MetricExpr": "BR_IMMED_SPEC / INST_SPEC",
+        "PublicDescription": "The rate of branch immediate instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of branch immediate instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "branch_immed_spec_rate"
+    },
+    {
+        "MetricExpr": "BR_RETURN_SPEC / INST_SPEC",
+        "PublicDescription": "The rate of procedure return instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of procedure return instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "branch_return_spec_rate"
+    },
+    {
+        "MetricExpr": "BR_INDIRECT_SPEC / INST_SPEC",
+        "PublicDescription": "The rate of indirect branch instructions speculatively executed to overall instructions speclatively executed",
+        "BriefDescription": "The rate of indirect branch instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "branch_indirect_spec_rate"
     }
 ]
\ No newline at end of file
-- 
1.8.3.1

