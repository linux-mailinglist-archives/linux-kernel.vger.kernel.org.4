Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B347159DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjE3JUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjE3JUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:20:09 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43258100;
        Tue, 30 May 2023 02:19:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vjt6o0X_1685438383;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vjt6o0X_1685438383)
          by smtp.aliyun-inc.com;
          Tue, 30 May 2023 17:19:43 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v3 3/7] perf vendor events: Add JSON metrics for CMN
Date:   Tue, 30 May 2023 17:19:30 +0800
Message-Id: <1685438374-33287-4-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for arm CMN. Currently just add part of CMN PMU
metrics which are general and compatible for any SoC and CMN-ANY.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../pmu-events/arch/arm64/arm/cmn/sys/metrics.json | 74 ++++++++++++++++++++++
 tools/perf/pmu-events/jevents.py                   |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
new file mode 100644
index 0000000..e70ac1a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
@@ -0,0 +1,74 @@
+[
+	{
+		"MetricName": "slc_miss_rate",
+		"BriefDescription": "The system level cache miss rate include.",
+		"MetricGroup": "arm_cmn",
+		"MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
+	},
+	{
+		"MetricName": "hnf_message_retry_rate",
+		"BriefDescription": "HN-F message retry rate indicates whether a lack of credits is causing the bottlenecks.",
+		"MetricGroup": "arm_cmn",
+		"MetricExpr": "hnf_pocq_retry / hnf_pocq_reqs_recvd",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
+	},
+	{
+		"MetricName": "sf_hit_rate",
+		"BriefDescription": "Snoop filter hit rate can be used to measure the Snoop Filter efficiency.",
+		"MetricGroup": "arm_cmn",
+		"MetricExpr": "hnf_sf_hit / hnf_slc_sf_cache_access",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
+	},
+	{
+		"MetricName": "mc_message_retry_rate",
+		"BriefDescription": "The memory controller request retries rate indicates whether the memory controller is the bottleneck.",
+		"MetricGroup": "arm_cmn",
+		"MetricExpr": "hnf_mc_retries / hnf_mc_reqs",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
+	},
+	{
+		"MetricName": "rni_actual_read_bandwidth.all",
+		"BriefDescription": "This event measure the actual bandwidth(MB/sec) that RN-I bridge sends to the interconnect.",
+		"MetricGroup": "arm_cmn",
+		"MetricExpr": "rnid_rxdat_flits * 32 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "arm_cmn",
+		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
+	},
+	{
+		"MetricName": "rni_actual_write_bandwidth.all",
+		"BriefDescription": "This event measures the actual write bandwidth(MB/sec) at RN-I bridges.",
+		"MetricGroup": "arm_cmn",
+		"MetricExpr": "rnid_txdat_flits * 32 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "arm_cmn",
+		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
+	},
+	{
+		"MetricName": "rni_retry_rate",
+		"BriefDescription": "RN-I bridge retry rate indicates whether the memory controller is the bottleneck.",
+		"MetricGroup": "arm_cmn",
+		"MetricExpr": "rnid_txreq_flits_retried / rnid_txreq_flits_total",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
+	},
+	{
+		"MetricName": "sbsx_actual_write_bandwidth.all",
+		"BriefDescription": "sbsx actual write bandwidth(MB/sec).",
+		"MetricGroup": "arm_cmn",
+		"MetricExpr": "sbsx_txdat_flitv * 32 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "arm_cmn",
+		"Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2bcd07c..7cff2c6 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -256,6 +256,7 @@ class JsonEvent:
           'DFPMC': 'amd_df',
           'cpu_core': 'cpu_core',
           'cpu_atom': 'cpu_atom',
+          'arm_cmn': 'arm_cmn',
       }
       return table[unit] if unit in table else f'uncore_{unit.lower()}'
 
-- 
1.8.3.1

