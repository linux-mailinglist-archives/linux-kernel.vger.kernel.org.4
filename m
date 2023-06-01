Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C777195A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjFAIbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjFAIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:30:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB701BB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:30:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5655d99da53so16941627b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685608217; x=1688200217;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYv2/QogVthwJS3CciRPFzYudxjLtShAgk+9HPnqfKY=;
        b=GprwQcjnt3Q9HqPaKVHhVAeOmhNWdVIjyAgsdcsOyKC8zn1824rL5zhpnqN2fs84mA
         T+cgvKMoxeufMHlSlybfsGhW9LlzlCP+SuhsCIg8x2b4ME1DaZFxNvU1MG6uTjxzKmkK
         e0crguWoMLc96GZECrIvbMVmbZ4AKx2KhIg2o3vNZzsKfRwfVztdamYGGlmgb/YV/AOg
         gu9Dk/b7aIO7gYHgl5dPChTbZiJ2v7s6fA3dYE/6BLt6SQqei/VlV0xVTVsI0zcLJom0
         DZT52m9qmzPC9ieH668YNR/0iFyFkCQj1opVIbag9ElPP8Dx0QexM5hnXxM235RgB1Ax
         li5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608217; x=1688200217;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYv2/QogVthwJS3CciRPFzYudxjLtShAgk+9HPnqfKY=;
        b=HGHCHrl6FAcg8RnnZPe52dvdT4bi43Rabt578QmUBsBK0l3jdESEnuBfGbNCwW73KV
         zpCFcxp0vAmgJS9g3a5yMQw2UdW8SEP5r+FVxRMuCam8AUp4Ddz1ZObqMxvCX0kg+DoF
         9c2AI4fzhIn/jBVqhmmpC51Uf+CdBePZkkM/CT5esSEW8w16Kj13kDgNsLx/KroftYok
         PPmDMHxm9q07DsbtsmVaz61K5IYV9deT21l/ZlQ3IJVUda5I4gmN/OmNk7kuWDOyqHUW
         rDYNf0Yd8mKB98UINDoct2Ssw+zu5FwgTBXK01yGYvlTqkmihPUmHkvO2qifOB0y1hHe
         738Q==
X-Gm-Message-State: AC+VfDxs1uUGyH9M0VgHgm2sNjxe/+VVTknyoL9vqH7g3769ao0U3ZaZ
        pYGIWe3qRoFWLzKCNOygpNuSeuSYcsdb
X-Google-Smtp-Source: ACHHUZ6pIBd5sLNTgc7MNEBXHw2j9otr4E4F7+BYAICh8dH7TYmV5KFeUrhHqOgp4VXHcoi/paVYUW/n+laP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a344:94b4:9b8d:a089])
 (user=irogers job=sendgmr) by 2002:a81:414b:0:b0:568:ed75:8b2f with SMTP id
 f11-20020a81414b000000b00568ed758b2fmr721124ywk.0.1685608217631; Thu, 01 Jun
 2023 01:30:17 -0700 (PDT)
Date:   Thu,  1 Jun 2023 01:29:54 -0700
In-Reply-To: <20230601082954.754318-1-irogers@google.com>
Message-Id: <20230601082954.754318-5-irogers@google.com>
Mime-Version: 1.0
References: <20230601082954.754318-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 4/4] perf test: Update parse-events expectations
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events opening on
multiple PMUs, the test expectations need updating to test for
multiple events. TODOs are added to document existing hybrid perf
bugs.

Tested on hybrid alderlake and non-hybrid tigerlake.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 1108 ++++++++++++++++---------------
 1 file changed, 590 insertions(+), 518 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 9d05bc551791..bba1cd655a1d 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -324,13 +324,17 @@ static int test__checkevent_numeric_modifier(struct evlist *evlist)
 
 static int test__checkevent_symbolic_name_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct perf_evsel *evsel;
 
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == perf_pmus__num_core_pmus());
 
+	perf_evlist__for_each_entry(&evlist->core, evsel) {
+		TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->attr.precise_ip);
+	}
 	return test__checkevent_symbolic_name(evlist);
 }
 
@@ -620,24 +624,28 @@ static int test__checkevent_pmu_events(struct evlist *evlist)
 
 static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
-
-	/* pmu-event:u */
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong exclude_user",
-			!evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel",
-			evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
-	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+	struct evsel *evsel = NULL;
 
+	/*
+	 * The wild card event will be opened at least once, but it may be
+	 * opened on each core PMU.
+	 */
+	TEST_ASSERT_VAL("wrong number of entries", evlist->core.nr_entries >= 2);
+	for (int i = 0; i < evlist->core.nr_entries - 1; i++) {
+		evsel = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		/* pmu-event:u */
+		TEST_ASSERT_VAL("wrong exclude_user",
+				!evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel",
+				evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
+		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+	}
 	/* cpu/pmu-event/u*/
 	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type ||
-				      strcmp(evsel->pmu_name, "cpu"));
+	TEST_ASSERT_VAL("wrong type", evsel__find_pmu(evsel)->is_core);
 	TEST_ASSERT_VAL("wrong exclude_user",
 			!evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel",
@@ -734,181 +742,207 @@ static int test__group1(struct evlist *evlist)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
-
-	/* instructions:k */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
-	/* cycles:upp */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	/* use of precise requires exclude_guest */
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (perf_pmus__num_core_pmus() * 2));
+	TEST_ASSERT_VAL("wrong number of groups",
+			evlist__nr_groups(evlist) == perf_pmus__num_core_pmus());
+
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* instructions:k */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
+		/* cycles:upp */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		/* use of precise requires exclude_guest */
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	}
 	return TEST_OK;
 }
 
 static int test__group2(struct evlist *evlist)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel, *leader = NULL;
 
-	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus() + 1));
+	/*
+	 * TODO: Currently the software event won't be grouped with the hardware
+	 * event except for 1 PMU.
+	 */
 	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
 
-	/* faults + :ku modifier */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
-	/* cache-references + :u modifier */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_REFERENCES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
-	/* cycles:k */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type == PERF_TYPE_SOFTWARE) {
+			/* faults + :ku modifier */
+			leader = evsel;
+			TEST_ASSERT_VAL("wrong config",
+					test_config(evsel, PERF_COUNT_SW_PAGE_FAULTS));
+			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+			continue;
+		}
+		if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
+		    test_config(evsel, PERF_COUNT_HW_CACHE_REFERENCES)) {
+			/* cache-references + :u modifier */
+			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+			if (evsel__has_leader(evsel, leader))
+				TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+			continue;
+		}
+		/* cycles:k */
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	}
 	return TEST_OK;
 }
 
 #ifdef HAVE_LIBTRACEEVENT
 static int test__group3(struct evlist *evlist __maybe_unused)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel, *group1_leader = NULL, *group2_leader = NULL;
 
-	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus() + 2));
+	/*
+	 * Currently the software event won't be grouped with the hardware event
+	 * except for 1 PMU. This means there are always just 2 groups
+	 * regardless of the number of core PMUs.
+	 */
 	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist__nr_groups(evlist));
 
-	/* group1 syscalls:sys_enter_openat:H */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong sample_type",
-		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
-	TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->core.attr.sample_period);
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong group name",
-		!strcmp(leader->group_name, "group1"));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
-	/* group1 cycles:kppp */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	/* use of precise requires exclude_guest */
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 3);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
-	/* group2 cycles + G modifier */
-	evsel = leader = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong group name",
-		!strcmp(leader->group_name, "group2"));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
-	/* group2 1:3 + G modifier */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 3));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
-	/* instructions:u */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
+			/* group1 syscalls:sys_enter_openat:H */
+			group1_leader = evsel;
+			TEST_ASSERT_VAL("wrong sample_type",
+					evsel->core.attr.sample_type == PERF_TP_SAMPLE_TYPE);
+			TEST_ASSERT_VAL("wrong sample_period", 1 == evsel->core.attr.sample_period);
+			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+			TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+			TEST_ASSERT_VAL("wrong group name", !strcmp(evsel->group_name, "group1"));
+			TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+			TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+			continue;
+		}
+		if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
+		    test_config(evsel, PERF_COUNT_HW_CPU_CYCLES)) {
+			if (evsel->core.attr.exclude_user) {
+				/* group1 cycles:kppp */
+				TEST_ASSERT_VAL("wrong exclude_user",
+						evsel->core.attr.exclude_user);
+				TEST_ASSERT_VAL("wrong exclude_kernel",
+						!evsel->core.attr.exclude_kernel);
+				TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+				/* use of precise requires exclude_guest */
+				TEST_ASSERT_VAL("wrong exclude guest",
+						evsel->core.attr.exclude_guest);
+				TEST_ASSERT_VAL("wrong exclude host",
+						!evsel->core.attr.exclude_host);
+				TEST_ASSERT_VAL("wrong precise_ip",
+						evsel->core.attr.precise_ip == 3);
+				if (evsel__has_leader(evsel, group1_leader)) {
+					TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+					TEST_ASSERT_VAL("wrong group_idx",
+							evsel__group_idx(evsel) == 1);
+				}
+				TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+			} else {
+				/* group2 cycles + G modifier */
+				group2_leader = evsel;
+				TEST_ASSERT_VAL("wrong exclude_kernel",
+						!evsel->core.attr.exclude_kernel);
+				TEST_ASSERT_VAL("wrong exclude_hv",
+						!evsel->core.attr.exclude_hv);
+				TEST_ASSERT_VAL("wrong exclude guest",
+						!evsel->core.attr.exclude_guest);
+				TEST_ASSERT_VAL("wrong exclude host",
+						evsel->core.attr.exclude_host);
+				TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+				TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+				if (evsel->core.nr_members == 2) {
+					TEST_ASSERT_VAL("wrong group_idx",
+							evsel__group_idx(evsel) == 0);
+				}
+				TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+			}
+			continue;
+		}
+		if (evsel->core.attr.type == 1) {
+			/* group2 1:3 + G modifier */
+			TEST_ASSERT_VAL("wrong config", test_config(evsel, 3));
+			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+			TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+			TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
+			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+			if (evsel__has_leader(evsel, group2_leader))
+				TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+			TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+			continue;
+		}
+		/* instructions:u */
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	}
 	return TEST_OK;
 }
 #endif
@@ -917,402 +951,435 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
-
-	/* cycles:u + p */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	/* use of precise requires exclude_guest */
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 1);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
-	/* instructions:kp + p */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
-	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	/* use of precise requires exclude_guest */
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (perf_pmus__num_core_pmus() * 2));
+	TEST_ASSERT_VAL("wrong number of groups",
+			perf_pmus__num_core_pmus() == evlist__nr_groups(evlist));
 
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles:u + p */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		/* use of precise requires exclude_guest */
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 1);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+
+		/* instructions:kp + p */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+		TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		/* use of precise requires exclude_guest */
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	}
 	return TEST_OK;
 }
 
 static int test__group5(struct evlist *evlist __maybe_unused)
 {
-	struct evsel *evsel, *leader;
-
-	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist__nr_groups(evlist));
-
-	/* cycles + G */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	struct evsel *evsel = NULL, *leader;
 
-	/* instructions + G */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (5 * perf_pmus__num_core_pmus()));
+	TEST_ASSERT_VAL("wrong number of groups",
+			evlist__nr_groups(evlist) == (2 * perf_pmus__num_core_pmus()));
 
-	/* cycles:G */
-	evsel = leader = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
-
-	/* instructions:G */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles + G */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
-	/* cycles */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		/* instructions + G */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
+	}
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles:G */
+		evsel = leader = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+		TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
+		/* instructions:G */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+	}
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+	}
 	return TEST_OK;
 }
 
 static int test__group_gh1(struct evlist *evlist)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus()));
+	TEST_ASSERT_VAL("wrong number of groups",
+			evlist__nr_groups(evlist) == perf_pmus__num_core_pmus());
 
-	/* cycles + :H group modifier */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-
-	/* cache-misses:G + :H group modifier */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles + :H group modifier */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 
+		/* cache-misses:G + :H group modifier */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+	}
 	return TEST_OK;
 }
 
 static int test__group_gh2(struct evlist *evlist)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
-
-	/* cycles + :G group modifier */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus()));
+	TEST_ASSERT_VAL("wrong number of groups",
+			evlist__nr_groups(evlist) == perf_pmus__num_core_pmus());
 
-	/* cache-misses:H + :G group modifier */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles + :G group modifier */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 
+		/* cache-misses:H + :G group modifier */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+	}
 	return TEST_OK;
 }
 
 static int test__group_gh3(struct evlist *evlist)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus()));
+	TEST_ASSERT_VAL("wrong number of groups",
+			evlist__nr_groups(evlist) == perf_pmus__num_core_pmus());
 
-	/* cycles:G + :u group modifier */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-
-	/* cache-misses:H + :u group modifier */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles:G + :u group modifier */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 
+		/* cache-misses:H + :u group modifier */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+	}
 	return TEST_OK;
 }
 
 static int test__group_gh4(struct evlist *evlist)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus()));
+	TEST_ASSERT_VAL("wrong number of groups",
+			evlist__nr_groups(evlist) == perf_pmus__num_core_pmus());
 
-	/* cycles:G + :uG group modifier */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
-	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
-
-	/* cache-misses:H + :uG group modifier */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles:G + :uG group modifier */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
+		TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 
+		/* cache-misses:H + :uG group modifier */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
+	}
 	return TEST_OK;
 }
 
 static int test__leader_sample1(struct evlist *evlist)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus()));
 
-	/* cycles - sampling group leader */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
-
-	/* cache-misses - not sampling */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles - sampling group leader */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
-	/* branch-misses - not sampling */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+		/* cache-misses - not sampling */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
+		/* branch-misses - not sampling */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+	}
 	return TEST_OK;
 }
 
 static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (2 * perf_pmus__num_core_pmus()));
 
-	/* instructions - sampling group leader */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
-
-	/* branch-misses - not sampling */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
-	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
-	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* instructions - sampling group leader */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
+		/* branch-misses - not sampling */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
+		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
+	}
 	return TEST_OK;
 }
 
 static int test__checkevent_pinned_modifier(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct evsel *evsel = NULL;
 
-	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
-	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
-	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == perf_pmus__num_core_pmus());
 
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		evsel = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
+		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
+		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
+		TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
+		TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
+	}
 	return test__checkevent_symbolic_name(evlist);
 }
 
 static int test__pinned_group(struct evlist *evlist)
 {
-	struct evsel *evsel, *leader;
+	struct evsel *evsel = NULL, *leader;
 
-	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus()));
 
-	/* cycles - group leader */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles - group leader */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		/* TODO: The group modifier is not copied to the split group leader. */
+		if (perf_pmus__num_core_pmus() == 1)
+			TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
 
-	/* cache-misses - can not be pinned, but will go on with the leader */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
-	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
-
-	/* branch-misses - ditto */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
-	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
+		/* cache-misses - can not be pinned, but will go on with the leader */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
+		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
+		/* branch-misses - ditto */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
+		TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
+	}
 	return TEST_OK;
 }
 
@@ -1331,29 +1398,33 @@ static int test__checkevent_exclusive_modifier(struct evlist *evlist)
 
 static int test__exclusive_group(struct evlist *evlist)
 {
-	struct evsel *evsel, *leader;
-
-	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
+	struct evsel *evsel = NULL, *leader;
 
-	/* cycles - group leader */
-	evsel = leader = evlist__first(evlist);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
-	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
-	TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (3 * perf_pmus__num_core_pmus()));
 
-	/* cache-misses - can not be pinned, but will go on with the leader */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
-	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+	for (int i = 0; i < perf_pmus__num_core_pmus(); i++) {
+		/* cycles - group leader */
+		evsel = leader = (i == 0 ? evlist__first(evlist) : evsel__next(evsel));
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
+		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
+		/* TODO: The group modifier is not copied to the split group leader. */
+		if (perf_pmus__num_core_pmus() == 1)
+			TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
 
-	/* branch-misses - ditto */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
-	TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+		/* cache-misses - can not be pinned, but will go on with the leader */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CACHE_MISSES));
+		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
 
+		/* branch-misses - ditto */
+		evsel = evsel__next(evsel);
+		TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_MISSES));
+		TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
+	}
 	return TEST_OK;
 }
 static int test__checkevent_breakpoint_len(struct evlist *evlist)
@@ -1403,7 +1474,8 @@ static int test__checkevent_precise_max_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
+	TEST_ASSERT_VAL("wrong number of entries",
+			evlist->core.nr_entries == (1 + perf_pmus__num_core_pmus()));
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_SOFTWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_SW_TASK_CLOCK));
 	return TEST_OK;
-- 
2.41.0.rc0.172.g3f132b7071-goog

