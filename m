Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A755B736425
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjFTHNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjFTHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:12:53 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74167100;
        Tue, 20 Jun 2023 00:12:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VlamlbJ_1687245166;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VlamlbJ_1687245166)
          by smtp.aliyun-inc.com;
          Tue, 20 Jun 2023 15:12:47 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.g.garry@oracle.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v4 3/4] perf vendor events: Add JSON metrics for Yitian 710 DDR
Date:   Tue, 20 Jun 2023 15:12:35 +0800
Message-Id: <1687245156-61215-4-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for T-HEAD Yitian 710 SoC DDR.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 .../arch/arm64/freescale/yitian710/sys/metrics.json  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
new file mode 100644
index 0000000..bc865b3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
@@ -0,0 +1,20 @@
+[
+	{
+		"MetricName": "ddr_read_bandwidth.all",
+		"BriefDescription": "The ddr read bandwidth(MB/s).",
+		"MetricGroup": "ali_drw",
+		"MetricExpr": "hif_rd * 64 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "ali_drw",
+		"Compat": "ali_drw_pmu"
+	},
+	{
+		"MetricName": "ddr_write_bandwidth.all",
+		"BriefDescription": "The ddr write bandwidth(MB/s).",
+		"MetricGroup": "ali_drw",
+		"MetricExpr": "(hif_wr + hif_rmw) * 64 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "ali_drw",
+		"Compat": "ali_drw_pmu"
+	}
+]
-- 
1.8.3.1

