Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4734F6ECF86
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjDXNsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjDXNsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:48:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 041318682;
        Mon, 24 Apr 2023 06:48:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7726ED75;
        Mon, 24 Apr 2023 06:48:52 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.58.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D20D3F64C;
        Mon, 24 Apr 2023 06:48:05 -0700 (PDT)
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
Subject: [PATCH 2/7] perf tools: Add util function for overriding user set config values
Date:   Mon, 24 Apr 2023 14:47:42 +0100
Message-Id: <20230424134748.228137-3-james.clark@arm.com>
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

There is some duplicated code to only override config values if they
haven't already been set by the user so make a util function for this.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 26 ++-----------------------
 tools/perf/arch/x86/util/intel-pt.c  | 22 ++-------------------
 tools/perf/util/evsel.c              | 29 ++++++++++++++++++++++++++++
 tools/perf/util/evsel.h              |  3 +++
 4 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index ef497a29e814..3b1676ff03f9 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -36,29 +36,6 @@ struct arm_spe_recording {
 	bool			*wrapped;
 };
 
-static void arm_spe_set_timestamp(struct auxtrace_record *itr,
-				  struct evsel *evsel)
-{
-	struct arm_spe_recording *ptr;
-	struct perf_pmu *arm_spe_pmu;
-	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
-	u64 user_bits = 0, bit;
-
-	ptr = container_of(itr, struct arm_spe_recording, itr);
-	arm_spe_pmu = ptr->arm_spe_pmu;
-
-	if (term)
-		user_bits = term->val.cfg_chg;
-
-	bit = perf_pmu__format_bits(&arm_spe_pmu->format, "ts_enable");
-
-	/* Skip if user has set it */
-	if (bit & user_bits)
-		return;
-
-	evsel->core.attr.config |= bit;
-}
-
 static size_t
 arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		       struct evlist *evlist __maybe_unused)
@@ -238,7 +215,8 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	 */
 	if (!perf_cpu_map__empty(cpus)) {
 		evsel__set_sample_bit(arm_spe_evsel, CPU);
-		arm_spe_set_timestamp(itr, arm_spe_evsel);
+		evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
+					   "ts_enable", 1);
 	}
 
 	/*
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 2cff11de9d8a..17336da08b58 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -576,25 +576,6 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
 	return err;
 }
 
-static void intel_pt_config_sample_mode(struct perf_pmu *intel_pt_pmu,
-					struct evsel *evsel)
-{
-	u64 user_bits = 0, bits;
-	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
-
-	if (term)
-		user_bits = term->val.cfg_chg;
-
-	bits = perf_pmu__format_bits(&intel_pt_pmu->format, "psb_period");
-
-	/* Did user change psb_period */
-	if (bits & user_bits)
-		return;
-
-	/* Set psb_period to 0 */
-	evsel->core.attr.config &= ~bits;
-}
-
 static void intel_pt_min_max_sample_sz(struct evlist *evlist,
 				       size_t *min_sz, size_t *max_sz)
 {
@@ -686,7 +667,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		return 0;
 
 	if (opts->auxtrace_sample_mode)
-		intel_pt_config_sample_mode(intel_pt_pmu, intel_pt_evsel);
+		evsel__set_config_if_unset(intel_pt_pmu, intel_pt_evsel,
+					   "psb_period", 0);
 
 	err = intel_pt_validate_config(intel_pt_pmu, intel_pt_evsel);
 	if (err)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a85a987128aa..cdf1445136ad 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3216,3 +3216,32 @@ void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader)
 		leader->core.nr_members--;
 	}
 }
+
+/*
+ * Set @config_name to @val as long as the user hasn't already set or cleared it
+ * by passing a config term on the command line.
+ *
+ * @val is the value to put into the bits specified by @config_name rather than
+ * the bit pattern. It is shifted into position by this function, so to set
+ * something to true, pass 1 for val rather than a pre shifted value.
+ */
+#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
+void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
+				const char *config_name, u64 val)
+{
+	u64 user_bits = 0, bits;
+	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
+
+	if (term)
+		user_bits = term->val.cfg_chg;
+
+	bits = perf_pmu__format_bits(&pmu->format, config_name);
+
+	/* Do nothing if the user changed the value */
+	if (bits & user_bits)
+		return;
+
+	/* Otherwise replace it */
+	evsel->core.attr.config &= ~bits;
+	evsel->core.attr.config |= field_prep(bits, val);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 68072ec655ce..4120f5ff673d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -529,4 +529,7 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel);
 	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
 
 u64 evsel__bitfield_swap_branch_flags(u64 value);
+void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
+				const char *config_name, u64 val);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.34.1

