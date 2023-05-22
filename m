Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5385870BA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjEVK1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjEVK0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:26:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D8BC119;
        Mon, 22 May 2023 03:26:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB34D11FB;
        Mon, 22 May 2023 03:27:08 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 388563F6C4;
        Mon, 22 May 2023 03:26:21 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        siyanteng@loongson.cn
Cc:     James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf cs-etm: Copy kernel coresight-pmu.h header
Date:   Mon, 22 May 2023 11:26:04 +0100
Message-Id: <20230522102604.1081416-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the kernel version of the header to fix the header diff build
warning. Some new definitions were only added to the tools side header,
but these are only used in Perf so move them to a different header.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/include/linux/coresight-pmu.h | 13 -------------
 tools/perf/util/cs-etm.h            | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index cef3b1c25335..51ac441a37c3 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -21,19 +21,6 @@
  */
 #define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
 
-/* CoreSight trace ID is currently the bottom 7 bits of the value */
-#define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
-
-/*
- * perf record will set the legacy meta data values as unused initially.
- * This allows perf report to manage the decoders created when dynamic
- * allocation in operation.
- */
-#define CORESIGHT_TRACE_ID_UNUSED_FLAG	BIT(31)
-
-/* Value to set for unused trace ID values */
-#define CORESIGHT_TRACE_ID_UNUSED_VAL	0x7F
-
 /*
  * Below are the definition of bit offsets for perf option, and works as
  * arbitrary values for all ETM versions.
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 70cac0375b34..ecca40787ac9 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -227,6 +227,19 @@ struct cs_etm_packet_queue {
 #define INFO_HEADER_SIZE (sizeof(((struct perf_record_auxtrace_info *)0)->type) + \
 			  sizeof(((struct perf_record_auxtrace_info *)0)->reserved__))
 
+/* CoreSight trace ID is currently the bottom 7 bits of the value */
+#define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
+
+/*
+ * perf record will set the legacy meta data values as unused initially.
+ * This allows perf report to manage the decoders created when dynamic
+ * allocation in operation.
+ */
+#define CORESIGHT_TRACE_ID_UNUSED_FLAG	BIT(31)
+
+/* Value to set for unused trace ID values */
+#define CORESIGHT_TRACE_ID_UNUSED_VAL	0x7F
+
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 struct perf_event_attr *cs_etm_get_default_config(struct perf_pmu *pmu);
-- 
2.34.1

