Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6950613437
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiJaLLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJaLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:11:46 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF66B847;
        Mon, 31 Oct 2022 04:11:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VTVxoHU_1667214701;
Received: from j66e01291.sqa.eu95.tbsite.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VTVxoHU_1667214701)
          by smtp.aliyun-inc.com;
          Mon, 31 Oct 2022 19:11:42 +0800
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
Subject: [PATCH RFC 1/6] perf vendor events arm64: Add topdown L1 metrics for neoverse-n2
Date:   Mon, 31 Oct 2022 19:11:29 +0800
Message-Id: <1667214694-89839-2-git-send-email-renyu.zj@linux.alibaba.com>
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

The calculation formula of topdown L1 is from the document:
https://documentation-service.arm.com/static/60250c7395978b529036da86?token=

Since neoverse-n2 does not yet support topdown L2, metricgroups such
as Cache, TLB, Branch, InstructionsMix, and PEutilization will be
added to further analysis of performance bottlenecks in the following
patches.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arch/arm64/arm/neoverse-n2/metrics.json        | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
new file mode 100644
index 0000000..b6b3b19
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
@@ -0,0 +1,30 @@
+[
+    {
+        "MetricExpr": "stall_slot_frontend / (5 * cpu_cycles)",
+        "PublicDescription": "Frontend bound L1 topdown metric",
+        "BriefDescription": "Frontend bound L1 topdown metric",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "frontend_bound"
+    },
+    {
+        "MetricExpr": "(1 - op_retired / op_spec) * (1 - stall_slot / (5 * cpu_cycles))",
+        "PublicDescription": "Wasted L1 topdown metric",
+        "BriefDescription": "Wasted L1 topdown metric",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "wasted"
+    },
+    {
+        "MetricExpr": "(op_retired / op_spec) * (1 - stall_slot / (5 * cpu_cycles))",
+        "PublicDescription": "Retiring L1 topdown metric",
+        "BriefDescription": "Retiring L1 topdown metric",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "retiring"
+    },
+    {
+        "MetricExpr": "stall_slot_backend / (5 * cpu_cycles)",
+        "PublicDescription": "Backend Bound L1 topdown metric",
+        "BriefDescription": "Backend Bound L1 topdown metric",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "backend_bound"
+    }
+]
\ No newline at end of file
-- 
1.8.3.1

