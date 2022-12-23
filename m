Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7165507C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiLWMj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiLWMjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:39:42 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01841B7AC;
        Fri, 23 Dec 2022 04:39:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VXwwMZL_1671799173;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VXwwMZL_1671799173)
          by smtp.aliyun-inc.com;
          Fri, 23 Dec 2022 20:39:34 +0800
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
Subject: [PATCH v4 4/6] perf vendor events arm64: Add branch metrics for neoverse-n2
Date:   Fri, 23 Dec 2022 20:37:23 +0800
Message-Id: <1671799045-1108027-5-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671799045-1108027-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1671799045-1108027-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add branch related metrics.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../arch/arm64/arm/neoverse-n2/metrics.json           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
index 817d80c..73d50f6 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
@@ -145,5 +145,24 @@
         "MetricGroup": "Cache",
         "MetricName": "ll_cache_read_hit_rate",
         "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "BR_MIS_PRED_RETIRED / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of branches mis-predicted per kilo instructions",
+        "MetricGroup": "Branch",
+        "MetricName": "branch_mpki"
+    },
+    {
+        "MetricExpr": "BR_RETIRED / INST_RETIRED * 1000",
+        "BriefDescription": "The rate of branches retired per kilo instructions",
+        "MetricGroup": "Branch",
+        "MetricName": "branch_pki"
+    },
+    {
+        "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
+        "BriefDescription": "The rate of branches mis-predited to the overall branches",
+        "MetricGroup": "Branch",
+        "MetricName": "branch_miss_pred_rate",
+        "ScaleUnit": "100%"
     }
 ]
-- 
1.8.3.1

