Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658266692E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjAMJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbjAMJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:27:21 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389B4318C;
        Fri, 13 Jan 2023 01:22:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VZUDRTd_1673601755;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZUDRTd_1673601755)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 17:22:36 +0800
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
Subject: [PATCH v7 3/9] perf vendor events arm64: Add common topdown L1 metrics
Date:   Fri, 13 Jan 2023 17:22:14 +0800
Message-Id: <1673601740-122788-4-git-send-email-renyu.zj@linux.alibaba.com>
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

The metrics of topdown L1 are from ARM sbsa7.0 platform design doc[0],
D37-38, which are standard. So put them in the common file sbsa.json of
arm64, so that other cores besides n2/v2 can also be reused.

[0] https://documentation-service.arm.com/static/60250c7395978b529036da86?token=

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 tools/perf/pmu-events/arch/arm64/sbsa.json | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/sbsa.json

diff --git a/tools/perf/pmu-events/arch/arm64/sbsa.json b/tools/perf/pmu-events/arch/arm64/sbsa.json
new file mode 100644
index 0000000..f678c37e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
@@ -0,0 +1,30 @@
+[
+    {
+        "MetricExpr": "stall_slot_frontend / (#slots * cpu_cycles)",
+        "BriefDescription": "Frontend bound L1 topdown metric",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "frontend_bound",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "(1 - op_retired / op_spec) * (1 - stall_slot / (#slots * cpu_cycles))",
+        "BriefDescription": "Bad speculation L1 topdown metric",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "bad_speculation",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "(op_retired / op_spec) * (1 - stall_slot / (#slots * cpu_cycles))",
+        "BriefDescription": "Retiring L1 topdown metric",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "retiring",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "stall_slot_backend / (#slots * cpu_cycles)",
+        "BriefDescription": "Backend Bound L1 topdown metric",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "backend_bound",
+        "ScaleUnit": "100%"
+    }
+]
-- 
1.8.3.1

