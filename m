Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20906ECF88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjDXNsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjDXNs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:48:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E7977AAB;
        Mon, 24 Apr 2023 06:48:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC817D75;
        Mon, 24 Apr 2023 06:49:04 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.58.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2263A3F64C;
        Mon, 24 Apr 2023 06:48:14 -0700 (PDT)
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
Subject: [PATCH 4/7] perf: cs-etm: Validate options after applying them
Date:   Mon, 24 Apr 2023 14:47:44 +0100
Message-Id: <20230424134748.228137-5-james.clark@arm.com>
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

Currently the cs_etm_set_option() function both validates and applies
the config options. Because it's only called when they are added
automatically, there are some paths where the user can apply the option
on the command line and skip the validation. By moving it to the end it
covers both cases.

Also, options don't need to be re-applied anyway, Perf handles parsing
and applying the config terms automatically.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 152 +++++++++++++-----------------
 1 file changed, 68 insertions(+), 84 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index f9b9ebf7fffc..af0a2400c655 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -69,21 +69,29 @@ static const char * const metadata_ete_ro[] = {
 static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
 static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu);
 
-static int cs_etm_set_context_id(struct auxtrace_record *itr,
-				 struct evsel *evsel, int cpu)
+static int cs_etm_validate_context_id(struct auxtrace_record *itr,
+				      struct evsel *evsel, int cpu)
 {
-	struct cs_etm_recording *ptr;
-	struct perf_pmu *cs_etm_pmu;
+	struct cs_etm_recording *ptr =
+		container_of(itr, struct cs_etm_recording, itr);
+	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	char path[PATH_MAX];
-	int err = -EINVAL;
+	int err;
 	u32 val;
-	u64 contextid;
+	u64 contextid =
+		evsel->core.attr.config &
+		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
+		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));
 
-	ptr = container_of(itr, struct cs_etm_recording, itr);
-	cs_etm_pmu = ptr->cs_etm_pmu;
+	if (!contextid)
+		return 0;
 
-	if (!cs_etm_is_etmv4(itr, cpu))
-		goto out;
+	/* Not supported in etmv3 */
+	if (!cs_etm_is_etmv4(itr, cpu)) {
+		pr_err("%s: contextid not supported in ETMv3, disable with %s/contextid=0/\n",
+		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
+		return -EINVAL;
+	}
 
 	/* Get a handle on TRCIDR2 */
 	snprintf(path, PATH_MAX, "cpu%d/%s",
@@ -92,27 +100,13 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
 
 	/* There was a problem reading the file, bailing out */
 	if (err != 1) {
-		pr_err("%s: can't read file %s\n",
-		       CORESIGHT_ETM_PMU_NAME, path);
-		goto out;
+		pr_err("%s: can't read file %s\n", CORESIGHT_ETM_PMU_NAME,
+		       path);
+		return err;
 	}
 
-	/* User has configured for PID tracing, respects it. */
-	contextid = evsel->core.attr.config &
-			(BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_CTXTID2));
-
-	/*
-	 * If user doesn't configure the contextid format, parse PMU format and
-	 * enable PID tracing according to the "contextid" format bits:
-	 *
-	 *   If bit ETM_OPT_CTXTID is set, trace CONTEXTIDR_EL1;
-	 *   If bit ETM_OPT_CTXTID2 is set, trace CONTEXTIDR_EL2.
-	 */
-	if (!contextid)
-		contextid = perf_pmu__format_bits(&cs_etm_pmu->format,
-						  "contextid");
-
-	if (contextid & BIT(ETM_OPT_CTXTID)) {
+	if (contextid &
+	    perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1")) {
 		/*
 		 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
 		 * tracing is supported:
@@ -122,14 +116,14 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
 		 */
 		val = BMVAL(val, 5, 9);
 		if (!val || val != 0x4) {
-			pr_err("%s: CONTEXTIDR_EL1 isn't supported\n",
-			       CORESIGHT_ETM_PMU_NAME);
-			err = -EINVAL;
-			goto out;
+			pr_err("%s: CONTEXTIDR_EL1 isn't supported, disable with %s/contextid1=0/\n",
+			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
+			return -EINVAL;
 		}
 	}
 
-	if (contextid & BIT(ETM_OPT_CTXTID2)) {
+	if (contextid &
+	    perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2")) {
 		/*
 		 * TRCIDR2.VMIDOPT[30:29] != 0 and
 		 * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
@@ -138,35 +132,34 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
 		 * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
 		 */
 		if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
-			pr_err("%s: CONTEXTIDR_EL2 isn't supported\n",
-			       CORESIGHT_ETM_PMU_NAME);
-			err = -EINVAL;
-			goto out;
+			pr_err("%s: CONTEXTIDR_EL2 isn't supported, disable with %s/contextid2=0/\n",
+			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
+			return -EINVAL;
 		}
 	}
 
-	/* All good, let the kernel know */
-	evsel->core.attr.config |= contextid;
-	err = 0;
-
-out:
-	return err;
+	return 0;
 }
 
-static int cs_etm_set_timestamp(struct auxtrace_record *itr,
-				struct evsel *evsel, int cpu)
+static int cs_etm_validate_timestamp(struct auxtrace_record *itr,
+				     struct evsel *evsel, int cpu)
 {
-	struct cs_etm_recording *ptr;
-	struct perf_pmu *cs_etm_pmu;
+	struct cs_etm_recording *ptr =
+		container_of(itr, struct cs_etm_recording, itr);
+	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	char path[PATH_MAX];
-	int err = -EINVAL;
+	int err;
 	u32 val;
 
-	ptr = container_of(itr, struct cs_etm_recording, itr);
-	cs_etm_pmu = ptr->cs_etm_pmu;
+	if (!(evsel->core.attr.config &
+	      perf_pmu__format_bits(&cs_etm_pmu->format, "timestamp")))
+		return 0;
 
-	if (!cs_etm_is_etmv4(itr, cpu))
-		goto out;
+	if (!cs_etm_is_etmv4(itr, cpu)) {
+		pr_err("%s: timestamp not supported in ETMv3, disable with %s/timestamp=0/\n",
+		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
+		return -EINVAL;
+	}
 
 	/* Get a handle on TRCIRD0 */
 	snprintf(path, PATH_MAX, "cpu%d/%s",
@@ -177,7 +170,7 @@ static int cs_etm_set_timestamp(struct auxtrace_record *itr,
 	if (err != 1) {
 		pr_err("%s: can't read file %s\n",
 		       CORESIGHT_ETM_PMU_NAME, path);
-		goto out;
+		return err;
 	}
 
 	/*
@@ -189,24 +182,21 @@ static int cs_etm_set_timestamp(struct auxtrace_record *itr,
 	 */
 	val &= GENMASK(28, 24);
 	if (!val) {
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
-	/* All good, let the kernel know */
-	evsel->core.attr.config |= (1 << ETM_OPT_TS);
-	err = 0;
-
-out:
-	return err;
+	return 0;
 }
 
-#define ETM_SET_OPT_CTXTID	(1 << 0)
-#define ETM_SET_OPT_TS		(1 << 1)
-#define ETM_SET_OPT_MASK	(ETM_SET_OPT_CTXTID | ETM_SET_OPT_TS)
-
-static int cs_etm_set_option(struct auxtrace_record *itr,
-			     struct evsel *evsel, u32 option)
+/*
+ * Check whether the requested timestamp and contextid options should be
+ * available on all requested CPUs and if not, tell the user how to override.
+ * The kernel will silently disable any unavailable options so a warning here
+ * first is better. In theory the kernel could still disable the option for
+ * some other reason so this is best effort only.
+ */
+static int cs_etm_validate_config(struct auxtrace_record *itr,
+				  struct evsel *evsel)
 {
 	int i, err = -EINVAL;
 	struct perf_cpu_map *event_cpus = evsel->evlist->core.user_requested_cpus;
@@ -220,18 +210,11 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 		    !perf_cpu_map__has(online_cpus, cpu))
 			continue;
 
-		if (option & BIT(ETM_OPT_CTXTID)) {
-			err = cs_etm_set_context_id(itr, evsel, i);
-			if (err)
-				goto out;
-		}
-		if (option & BIT(ETM_OPT_TS)) {
-			err = cs_etm_set_timestamp(itr, evsel, i);
-			if (err)
-				goto out;
-		}
-		if (option & ~(BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS)))
-			/* Nothing else is currently supported */
+		err = cs_etm_validate_context_id(itr, evsel, i);
+		if (err)
+			goto out;
+		err = cs_etm_validate_timestamp(itr, evsel, i);
+		if (err)
 			goto out;
 	}
 
@@ -447,10 +430,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 * when a context switch happened.
 	 */
 	if (!perf_cpu_map__empty(cpus)) {
-		err = cs_etm_set_option(itr, cs_etm_evsel,
-					BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS));
-		if (err)
-			goto out;
+		cs_etm_evsel->core.attr.config |=
+			perf_pmu__format_bits(&cs_etm_pmu->format, "timestamp");
+		cs_etm_evsel->core.attr.config |=
+			perf_pmu__format_bits(&cs_etm_pmu->format, "contextid");
 	}
 
 	/* Add dummy event to keep tracking */
@@ -466,6 +449,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (!perf_cpu_map__empty(cpus))
 		evsel__set_sample_bit(evsel, TIME);
 
+	err = cs_etm_validate_config(itr, cs_etm_evsel);
 out:
 	return err;
 }
-- 
2.34.1

