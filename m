Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C73E627688
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiKNHm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiKNHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:42:47 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538418B16;
        Sun, 13 Nov 2022 23:42:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VUjWi2q_1668411761;
Received: from j66e01291.sqa.eu95.tbsite.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VUjWi2q_1668411761)
          by smtp.aliyun-inc.com;
          Mon, 14 Nov 2022 15:42:42 +0800
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
Subject: [RFC PATCH v2 5/6] perf vendor events arm64: Add PE utilization metrics for neoverse-n2
Date:   Mon, 14 Nov 2022 15:41:59 +0800
Message-Id: <1668411720-3581-6-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PE utilization related metrics.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arch/arm64/arm/neoverse-n2/metrics.json        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
index e960a66..3c14971 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
@@ -152,5 +152,33 @@
         "BriefDescription": "The rate of branches mis-predited to the overall branches",
         "MetricGroup": "Branch",
         "MetricName": "branch_miss_pred_rate"
+    },
+    {
+        "MetricExpr": "instructions / CPU_CYCLES",
+        "PublicDescription": "The average number of instructions executed for each cycle.",
+        "BriefDescription": "Instructions per cycle",
+        "MetricGroup": "PEutilization",
+        "MetricName": "ipc"
+    },
+    {
+        "MetricExpr": "OP_RETIRED / OP_SPEC",
+        "PublicDescription": "Fraction of operations retired",
+        "BriefDescription": "Fraction of operations retired",
+        "MetricGroup": "PEutilization",
+        "MetricName": "retired_rate"
+    },
+    {
+        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
+        "PublicDescription": "Fraction of operations wasted",
+        "BriefDescription": "Fraction of operations wasted",
+        "MetricGroup": "PEutilization",
+        "MetricName": "wasted_rate"
+    },
+    {
+        "MetricExpr": "(1 - STALL_SLOT / (CPU_CYCLES * 5)) * OP_RETIRED / OP_SPEC",
+        "PublicDescription": "Utilization of CPU",
+        "BriefDescription": "Utilization of CPU",
+        "MetricGroup": "PEutilization",
+        "MetricName": "cpu_utilization"
     }
 ]
\ No newline at end of file
-- 
1.8.3.1

