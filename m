Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF216ECF85
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjDXNsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjDXNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:48:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B2957AB5;
        Mon, 24 Apr 2023 06:48:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D33FEC;
        Mon, 24 Apr 2023 06:48:48 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.58.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F007E3F64C;
        Mon, 24 Apr 2023 06:48:00 -0700 (PDT)
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
Subject: [PATCH 1/7] perf: cs-etm: Fix timeless decode mode detection
Date:   Mon, 24 Apr 2023 14:47:41 +0100
Message-Id: <20230424134748.228137-2-james.clark@arm.com>
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

In this context, timeless refers to the trace data rather than the perf
event data. But when detecting whether there are timestamps in the trace
data or not, the presence of a timestamp flag on any perf event is used.

Since commit f42c0ce573df ("perf record: Always get text_poke events
with --kcore option") timestamps were added to a tracking event when
--kcore is used which breaks this detection mechanism. Fix it by
detecting if trace timestamps exist by looking at the ETM config flags.
This would have always been a more accurate way of doing it anyway.

This fixes the following error message when using --kcore with
Coresight:

  $ perf record --kcore -e cs_etm// --per-thread
  $ perf report
  The perf.data/data data has no samples!

Fixes: f42c0ce573df ("perf record: Always get text_poke events with --kcore option")
Reported-by: Yang Shi <shy828301@gmail.com>
Link: https://lore.kernel.org/lkml/CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com/
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8dd81ddd9e4e..50593289d53c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2684,26 +2684,29 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 	return 0;
 }
 
-static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
+static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
 {
 	struct evsel *evsel;
 	struct evlist *evlist = etm->session->evlist;
-	bool timeless_decoding = true;
 
 	/* Override timeless mode with user input from --itrace=Z */
-	if (etm->synth_opts.timeless_decoding)
-		return true;
+	if (etm->synth_opts.timeless_decoding) {
+		etm->timeless_decoding = true;
+		return 0;
+	}
 
 	/*
-	 * Circle through the list of event and complain if we find one
-	 * with the time bit set.
+	 * Find the cs_etm evsel and look at what its timestamp setting was
 	 */
-	evlist__for_each_entry(evlist, evsel) {
-		if ((evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
-			timeless_decoding = false;
-	}
+	evlist__for_each_entry(evlist, evsel)
+		if (cs_etm__evsel_is_auxtrace(etm->session, evsel)) {
+			etm->timeless_decoding =
+				!(evsel->core.attr.config & BIT(ETM_OPT_TS));
+			return 0;
+		}
 
-	return timeless_decoding;
+	pr_err("CS ETM: Couldn't find ETM evsel\n");
+	return -EINVAL;
 }
 
 /*
@@ -3155,7 +3158,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->snapshot_mode = (ptr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
-	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
 
 	/* Use virtual timestamps if all ETMs report ts_source = 1 */
 	etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
@@ -3172,6 +3174,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
 	session->auxtrace = &etm->auxtrace;
 
+	err = cs_etm__setup_timeless_decoding(etm);
+	if (err)
+		return err;
+
 	etm->unknown_thread = thread__new(999999999, 999999999);
 	if (!etm->unknown_thread) {
 		err = -ENOMEM;
-- 
2.34.1

