Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63D46602BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjAFPGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjAFPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:05:49 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214F35E0BE;
        Fri,  6 Jan 2023 07:05:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VZ-UXmq_1673017540;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZ-UXmq_1673017540)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 23:05:41 +0800
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
Subject: [PATCH v6 2/7] perf vendor events arm64: Add topdown L1 metrics for neoverse-n2-v2
Date:   Fri,  6 Jan 2023 23:05:24 +0800
Message-Id: <1673017529-1429208-3-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the wrong count of stall_slot and stall_slot_frontend on
neoverse-n2, the real stall_slot and real stall_slot_frontend need to
subtract cpu_cycles, so overwrite the "MetricExpr" for neoverse-n2.
Reference from ARM neoverse-n2 errata notice [0], D117.

Since neoverse-n2/neoverse-v2 does not yet support topdown L2, metric
groups such as Cache, TLB, Branch, InstructionsMix and PEutilization
will be added to further analysis of performance bottlenecks in the
following patches. Reference from ARM PMU guide [1][2].

[0] https://documentation-service.arm.com/static/636a66a64e6cf12278ad89cb?token=
[1] https://documentation-service.arm.com/static/628f8fa3dfaf015c2b76eae8?token=
[2] https://documentation-service.arm.com/static/62cfe21e31ea212bb6627393?token=

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
new file mode 100644
index 0000000..4e7417f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
@@ -0,0 +1,17 @@
+[
+    {
+        "ArchStdEvent": "FRONTEND_BOUND",
+        "MetricExpr": "((stall_slot_frontend) if (#slots - 5) else (stall_slot_frontend - cpu_cycles)) / (#slots * cpu_cycles)"
+    },
+    {
+        "ArchStdEvent": "BAD_SPECULATION",
+        "MetricExpr": "(1 - op_retired / op_spec) * (1 - (stall_slot if (#slots - 5) else (stall_slot - cpu_cycles)) / (#slots * cpu_cycles))"
+    },
+    {
+        "ArchStdEvent": "RETIRING",
+        "MetricExpr": "(op_retired / op_spec) * (1 - (stall_slot if (#slots - 5) else (stall_slot - cpu_cycles)) / (#slots * cpu_cycles))"
+    },
+    {
+        "ArchStdEvent": "BACKEND_BOUND"
+    }
+]
-- 
1.8.3.1

