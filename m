Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C296747FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjGEI1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjGEI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:27:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D63E5184;
        Wed,  5 Jul 2023 01:27:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFA6E169C;
        Wed,  5 Jul 2023 01:27:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC4D73F73F;
        Wed,  5 Jul 2023 01:27:03 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf test: Fix event parsing test on Arm
Date:   Wed,  5 Jul 2023 09:26:51 +0100
Message-Id: <20230705082653.23566-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705082653.23566-1-james.clark@arm.com>
References: <20230705082653.23566-1-james.clark@arm.com>
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

The test looks for a PMU from sysfs with type = PERF_TYPE_RAW when
opening a raw event. Arm doesn't have a real raw PMU, only core PMUs
with unique types other than raw.

Instead of looking for a matching PMU, just test that the event type
was parsed as raw and skip the PMU search on Arm. The raw event type
test should also apply to all platforms so add it outside of the ifdef.

Fixes: aefde50a446b ("perf test: Fix parse-events tests for >1 core PMU")
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/parse-events.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 133218e51ab4..21f79aa31233 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -108,10 +108,21 @@ static int test__checkevent_raw(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 0 != evlist->core.nr_entries);
 
 	perf_evlist__for_each_evsel(&evlist->core, evsel) {
-		struct perf_pmu *pmu = NULL;
+		struct perf_pmu *pmu __maybe_unused = NULL;
 		bool type_matched = false;
 
 		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
+		TEST_ASSERT_VAL("event not parsed as raw type",
+				evsel->attr.type == PERF_TYPE_RAW);
+#if defined(__aarch64__)
+		/*
+		 * Arm doesn't have a real raw type PMU in sysfs, so raw events
+		 * would never match any PMU. However, RAW events on Arm will
+		 * always successfully open on the first available core PMU
+		 * so no need to test for a matching type here.
+		 */
+		type_matched = raw_type_match = true;
+#else
 		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 			if (pmu->type == evsel->attr.type) {
 				TEST_ASSERT_VAL("PMU type expected once", !type_matched);
@@ -120,6 +131,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 					raw_type_match = true;
 			}
 		}
+#endif
 		TEST_ASSERT_VAL("No PMU found for type", type_matched);
 	}
 	TEST_ASSERT_VAL("Raw PMU not matched", raw_type_match);
-- 
2.34.1

