Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B476ECF8B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjDXNtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjDXNsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:48:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E38669EEC;
        Mon, 24 Apr 2023 06:48:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E660FEC;
        Mon, 24 Apr 2023 06:49:11 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.58.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2ABA53F64C;
        Mon, 24 Apr 2023 06:48:21 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com
Cc:     denik@google.com, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] perf: cs-etm: Allow user to override timestamp and contextid settings
Date:   Mon, 24 Apr 2023 14:47:45 +0100
Message-Id: <20230424134748.228137-6-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424134748.228137-1-james.clark@arm.com>
References: <20230424134748.228137-1-james.clark@arm.com>
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

Timestamps and context tracking are automatically enabled in per-core
mode and it's impossible to override this. Use the new utility function
to set them conditionally.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 29 +++++++++++++++++++++++------
 tools/perf/arch/arm/util/pmu.c    |  2 ++
 tools/perf/util/cs-etm.h          |  2 ++
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index af0a2400c655..77cb03e6ff87 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -324,8 +324,6 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	    perf_can_record_switch_events())
 		opts->record_switch_events = true;
 
-	cs_etm_evsel->core.attr.freq = 0;
-	cs_etm_evsel->core.attr.sample_period = 1;
 	cs_etm_evsel->needs_auxtrace_mmap = true;
 	opts->full_auxtrace = true;
 
@@ -430,10 +428,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 * when a context switch happened.
 	 */
 	if (!perf_cpu_map__empty(cpus)) {
-		cs_etm_evsel->core.attr.config |=
-			perf_pmu__format_bits(&cs_etm_pmu->format, "timestamp");
-		cs_etm_evsel->core.attr.config |=
-			perf_pmu__format_bits(&cs_etm_pmu->format, "contextid");
+		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
+					   "timestamp", 1);
+		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
+					   "contextid", 1);
 	}
 
 	/* Add dummy event to keep tracking */
@@ -914,3 +912,22 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 out:
 	return NULL;
 }
+
+/*
+ * Set a default config to enable the user changed config tracking mechanism
+ * (CFG_CHG and evsel__set_config_if_unset()). If no default is set then user
+ * changes aren't tracked.
+ */
+struct perf_event_attr *
+cs_etm_get_default_config(struct perf_pmu *pmu __maybe_unused)
+{
+	struct perf_event_attr *attr;
+
+	attr = zalloc(sizeof(struct perf_event_attr));
+	if (!attr)
+		return NULL;
+
+	attr->sample_period = 1;
+
+	return attr;
+}
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 887c8addc491..860a8b42b4b5 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -12,6 +12,7 @@
 #include "arm-spe.h"
 #include "hisi-ptt.h"
 #include "../../../util/pmu.h"
+#include "../cs-etm.h"
 
 struct perf_event_attr
 *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
@@ -20,6 +21,7 @@ struct perf_event_attr
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
 		pmu->selectable = true;
+		return cs_etm_get_default_config(pmu);
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
 		return arm_spe_pmu_default_config(pmu);
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 661f029322e4..16333d35bed4 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 
 struct perf_session;
+struct perf_pmu;
 
 /*
  * Versioning header in case things need to change in the future.  That way
@@ -228,6 +229,7 @@ struct cs_etm_packet_queue {
 
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
+struct perf_event_attr *cs_etm_get_default_config(struct perf_pmu *pmu);
 
 #ifdef HAVE_CSTRACE_SUPPORT
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
-- 
2.34.1

