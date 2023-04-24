Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6226ECF87
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjDXNs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjDXNsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:48:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27BDD9747;
        Mon, 24 Apr 2023 06:48:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99862D75;
        Mon, 24 Apr 2023 06:48:57 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.58.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3E783F64C;
        Mon, 24 Apr 2023 06:48:09 -0700 (PDT)
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
Subject: [PATCH 3/7] perf: cs-etm: Don't test full_auxtrace because it's always set
Date:   Mon, 24 Apr 2023 14:47:43 +0100
Message-Id: <20230424134748.228137-4-james.clark@arm.com>
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

There is no path in cs-etm where this isn't true so it doesn't need to
be tested. Also re-order the beginning of cs_etm_recording_options() so
that nothing is done until the early exit is passed.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 56 ++++++++++++++-----------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index e02a9bfc3d42..f9b9ebf7fffc 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -319,13 +319,6 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	bool privileged = perf_event_paranoid_check(-1);
 	int err = 0;
 
-	ptr->evlist = evlist;
-	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
-
-	if (!record_opts__no_switch_events(opts) &&
-	    perf_can_record_switch_events())
-		opts->record_switch_events = true;
-
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.type == cs_etm_pmu->type) {
 			if (cs_etm_evsel) {
@@ -333,11 +326,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 				       CORESIGHT_ETM_PMU_NAME);
 				return -EINVAL;
 			}
-			evsel->core.attr.freq = 0;
-			evsel->core.attr.sample_period = 1;
-			evsel->needs_auxtrace_mmap = true;
 			cs_etm_evsel = evsel;
-			opts->full_auxtrace = true;
 		}
 	}
 
@@ -345,6 +334,18 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (!cs_etm_evsel)
 		return 0;
 
+	ptr->evlist = evlist;
+	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
+
+	if (!record_opts__no_switch_events(opts) &&
+	    perf_can_record_switch_events())
+		opts->record_switch_events = true;
+
+	cs_etm_evsel->core.attr.freq = 0;
+	cs_etm_evsel->core.attr.sample_period = 1;
+	cs_etm_evsel->needs_auxtrace_mmap = true;
+	opts->full_auxtrace = true;
+
 	ret = cs_etm_set_sink_attr(cs_etm_pmu, cs_etm_evsel);
 	if (ret)
 		return ret;
@@ -414,8 +415,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
-	/* We are in full trace mode but '-m,xyz' wasn't specified */
-	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
+	/* Buffer sizes weren't specified with '-m,xyz' so give some defaults */
+	if (!opts->auxtrace_mmap_pages) {
 		if (privileged) {
 			opts->auxtrace_mmap_pages = MiB(4) / page_size;
 		} else {
@@ -423,7 +424,6 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 			if (opts->mmap_pages == UINT_MAX)
 				opts->mmap_pages = KiB(256) / page_size;
 		}
-
 	}
 
 	if (opts->auxtrace_snapshot_mode)
@@ -454,23 +454,17 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	}
 
 	/* Add dummy event to keep tracking */
-	if (opts->full_auxtrace) {
-		struct evsel *tracking_evsel;
-
-		err = parse_event(evlist, "dummy:u");
-		if (err)
-			goto out;
-
-		tracking_evsel = evlist__last(evlist);
-		evlist__set_tracking_event(evlist, tracking_evsel);
-
-		tracking_evsel->core.attr.freq = 0;
-		tracking_evsel->core.attr.sample_period = 1;
-
-		/* In per-cpu case, always need the time of mmap events etc */
-		if (!perf_cpu_map__empty(cpus))
-			evsel__set_sample_bit(tracking_evsel, TIME);
-	}
+	err = parse_event(evlist, "dummy:u");
+	if (err)
+		goto out;
+	evsel = evlist__last(evlist);
+	evlist__set_tracking_event(evlist, evsel);
+	evsel->core.attr.freq = 0;
+	evsel->core.attr.sample_period = 1;
+
+	/* In per-cpu case, always need the time of mmap events etc */
+	if (!perf_cpu_map__empty(cpus))
+		evsel__set_sample_bit(evsel, TIME);
 
 out:
 	return err;
-- 
2.34.1

