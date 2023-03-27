Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76D66C99B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjC0Cqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjC0Cqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:46:30 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F244B1;
        Sun, 26 Mar 2023 19:46:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VeeqFPn_1679885184;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VeeqFPn_1679885184)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 10:46:25 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH RFC 2/4] perf vendor events: Add JSON metrics for cmn700
Date:   Mon, 27 Mar 2023 10:46:10 +0800
Message-Id: <1679885172-95021-3-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for cmn700. Currently just add part of cmn700 PMU
events and metrics which are general and compatible for any SoC.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../pmu-events/arch/arm64/arm/cmn700/sys/cmn.json  | 188 +++++++++++++++++++++
 .../arch/arm64/arm/cmn700/sys/metrics.json         |  74 ++++++++
 tools/perf/pmu-events/jevents.py                   |   1 +
 3 files changed, 263 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/cmn.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/cmn.json b/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/cmn.json
new file mode 100644
index 0000000..a060d1d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/cmn.json
@@ -0,0 +1,188 @@
+[
+	{
+		"EventName": "hnf_cache_miss",
+		"BriefDescription": "Counts total cache misses in first lookup result (high priority)",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_slc_sf_cache_access",
+		"BriefDescription": "Counts number of cache accesses in first access (high priority)",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_cache_fill",
+		"BriefDescription": "Counts total allocations in HN SLC (all cache line allocations to SLC)",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_pocq_retry",
+		"BriefDescription": "Counts number of retried requests",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_pocq_reqs_recvd",
+		"BriefDescription": "Counts number of requests that HN receives",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_sf_hit",
+		"BriefDescription": "Counts number of SF hits",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_sf_evictions",
+		"BriefDescription": "Counts number of SF eviction cache invalidations initiated",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_dir_snoops_sent",
+		"BriefDescription": "Counts number of directed snoops sent (not including SF back invalidation)",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_brd_snoops_sent",
+		"BriefDescription": "Counts number of multicast snoops sent (not including SF back invalidation)",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_mc_retries",
+		"BriefDescription": "Counts number of retried transactions by the MC",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_mc_reqs",
+		"BriefDescription": "Counts number of requests that are sent to MC",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hnf_qos_hh_retry",
+		"BriefDescription": "Counts number of times a HighHigh priority request is protocolretried at the HN‑F",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "rnid_s0_rdata_beats",
+		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 0. This event measures the read bandwidth, including CMO responses.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "rnid_s1_rdata_beats",
+		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 1. This event measures the read bandwidth, including CMO responses.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "rnid_s2_rdata_beats",
+		"BriefDescription": "Number of RData beats (RVALID and RREADY) dispatched on port 2. This event measures the read bandwidth, including CMO responses.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "rnid_rxdat_flits",
+		"BriefDescription": "Number of RXDAT flits received. This event measures the true read data bandwidth, excluding CMOs.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "rnid_txdat_flits",
+		"BriefDescription": "Number of TXDAT flits dispatched. This event measures the write bandwidth.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "rnid_txreq_flits_total",
+		"BriefDescription": "Number of TXREQ flits dispatched. This event measures the total request bandwidth.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "rnid_txreq_flits_retried",
+		"BriefDescription": "Number of retried TXREQ flits dispatched. This event measures the retry rate.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "sbsx_txdat_flitv",
+		"BriefDescription": "Number of TXDAT flits dispatched from XP to SBSX. This event is a measure of the write bandwidth.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "sbsx_txrsp_retryack",
+		"BriefDescription": "Number of RXREQ flits dispatched. This event is a measure of the retry rate.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "sbsx_arvalid_no_arready",
+		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on AR channel.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "sbsx_awvalid_no_awready",
+		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on AW channel.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "sbsx_wvalid_no_wready",
+		"BriefDescription": "Number of cycles the SBSX bridge is stalled because of backpressure on W channel.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hni_txdat_stall",
+		"BriefDescription": "TXDAT valid but no link credit available.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hni_txrsp_retryack",
+		"BriefDescription": "Number of RXREQ flits dispatched. This event is a measure of the retry rate.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hni_arvalid_no_arready",
+		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on AR channel.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hni_awvalid_no_awready",
+		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on AW channel.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hni_wvalid_no_wready",
+		"BriefDescription": "Number of cycles the HN-I bridge is stalled because of backpressure on W channel.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hni_arready_no_arvalid",
+		"BriefDescription": "Number of cycles the AR channel is waiting for new requests from HN-I bridge.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"EventName": "hni_awready_no_awvalid",
+		"BriefDescription": "Number of cycles the AW channel is waiting for new requests from HN-I bridge.",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	}
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json
new file mode 100644
index 0000000..430567b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json
@@ -0,0 +1,74 @@
+[
+	{
+		"MetricName": "slc_miss_rate",
+		"BriefDescription": "The system level cache miss rate include.",
+		"MetricGroup": "cmn700",
+		"MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
+		"ScaleUnit": "100%",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"MetricName": "hnf_message_retry_rate",
+		"BriefDescription": "HN-F message retry rate indicates whether a lack of credits is causing the bottlenecks.",
+		"MetricGroup": "cmn700",
+		"MetricExpr": "hnf_pocq_retry / hnf_pocq_reqs_recvd",
+		"ScaleUnit": "100%",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"MetricName": "sf_hit_rate",
+		"BriefDescription": "Snoop filter hit rate can be used to measure the Snoop Filter efficiency.",
+		"MetricGroup": "cmn700",
+		"MetricExpr": "hnf_sf_hit / hnf_slc_sf_cache_access",
+		"ScaleUnit": "100%",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"MetricName": "mc_message_retry_rate",
+		"BriefDescription": "The memory controller request retries rate indicates whether the memory controller is the bottleneck.",
+		"MetricGroup": "cmn700",
+		"MetricExpr": "hnf_mc_retries / hnf_mc_reqs",
+		"ScaleUnit": "100%",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"MetricName": "rni_actual_read_bandwidth.all",
+		"BriefDescription": "This event measure the actual bandwidth(MB/sec) that RN-I bridge sends to the interconnect.",
+		"MetricGroup": "cmn700",
+		"MetricExpr": "rnid_rxdat_flits * 32 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"MetricName": "rni_actual_write_bandwidth.all",
+		"BriefDescription": "This event measures the actual write bandwidth(MB/sec) at RN-I bridges.",
+		"MetricGroup": "cmn700",
+		"MetricExpr": "rnid_txdat_flits * 32 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"MetricName": "rni_retry_rate",
+		"BriefDescription": "RN-I bridge retry rate indicates whether the memory controller is the bottleneck.",
+		"MetricGroup": "cmn700",
+		"MetricExpr": "rnid_txreq_flits_retried / rnid_txreq_flits_total",
+		"ScaleUnit": "100%",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	},
+	{
+		"MetricName": "sbsx_actual_write_bandwidth.all",
+		"BriefDescription": "sbsx actual write bandwidth(MB/sec).",
+		"MetricGroup": "cmn700",
+		"MetricExpr": "sbsx_txdat_flitv * 32 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "cmn700",
+		"Compat": "CMN700"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2bcd07c..20ed492 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -256,6 +256,7 @@ class JsonEvent:
           'DFPMC': 'amd_df',
           'cpu_core': 'cpu_core',
           'cpu_atom': 'cpu_atom',
+          'cmn700': 'cmn700',
       }
       return table[unit] if unit in table else f'uncore_{unit.lower()}'
 
-- 
1.8.3.1

