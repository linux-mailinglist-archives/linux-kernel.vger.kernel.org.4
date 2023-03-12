Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4286B62E2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 03:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCLCRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 21:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCLCRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 21:17:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844C94DBE9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:17:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w200-20020a25c7d1000000b00b3215dc7b87so4948533ybe.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587433;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wBN6kOg1n+q3+bF/95Ea+KPTQzf/X12Cj3eCZI6a8o=;
        b=NKLUv7GEbOI99SCLfcPT3EMuBG2FtYBhAnRlQRk1jKGWi8EVBqZgTCAeO3/cjnICBm
         69Z12UAsCCyjvtIrF5JHv/HSL4+LNS+bwlh35Rpp/pdMIV8LQ+y3iLECHg69/QFYDX+k
         aAayIwycKGu5DMgZOP+dagFujN5XCnErWDL7niaRTO3U/cHOorzrr01cNg3BDVp0Wq4v
         0d+znAw4/yrdekd+kNVavJifm+gnwM00moEWAco9dBmKj5+KehOhIC/909/fRqidCAoY
         hybs9/8hGBDS9Zk5/fQIiYRcEY8439DB757UPRVa8U8ym1U8lJWPp6sNCB07x1BXhhHJ
         rAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587433;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wBN6kOg1n+q3+bF/95Ea+KPTQzf/X12Cj3eCZI6a8o=;
        b=GIJlI1J0nMwRwoo5tw2+z9qjtk6IjPNvA2yZcRcG2RuyDg4hLF1lOB050ugkfuXkOs
         oMyOyS+q7bAnM7Q0JE+v7bI1CpDx6gsafEFV2txMqxFe1454B44HRCYOsnqM5syuVl0U
         awdew1RETl3Yp+yIR5p5gNC3hKEOrFU/GCzlyePx4sbecEpsYz3oMOyooaMzq6+9512d
         R9C7Tk31L+3mivWugoBjUfY2WtN0W9k9cqT2xrnEa0hx2FdBtG7sjtDhid+z7r+FWdxv
         PK6acsYnVW/2A0nRE2DILuQAiDnElZz9zO+CnKlxrGuS1q9hZLOJ1UjuAB5xaUy9lTvs
         Hmiw==
X-Gm-Message-State: AO0yUKUcVzFv53/KebT+CUlVJyO51207Ifjd0jISgSNdcBjdn5NQncZI
        t2H+Fi7rtpDE7yI75DSfGyUkCIhP+ojE
X-Google-Smtp-Source: AK7set8dle2bnf4VmVFwWjoNIzi0P41W2RqDzM7t8DLsLhKPKk+4jNUQFAiMZqWXlwqIp8Vn47nWDye+VNlW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a5b:384:0:b0:a65:8cd3:fc4 with SMTP id
 k4-20020a5b0384000000b00a658cd30fc4mr18430629ybp.5.1678587433215; Sat, 11 Mar
 2023 18:17:13 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:42 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-11-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 10/11] perf evlist: Remove nr_groups
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintaining the number of groups during event parsing is problematic
and since changing to sort/regroup events can only be computed by a
linear pass over the evlist. As the value is generally only used in
tests, rather than hold it in a variable compute it by passing over
the evlist when necessary.

This change highlights that libpfm's counting of groups with a single
entry disagreed with regular event parsing. The libpfm tests are
updated accordingly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c                  | 18 +++++++++++++++++-
 tools/lib/perf/include/internal/evlist.h |  1 -
 tools/lib/perf/include/perf/evlist.h     |  1 +
 tools/perf/builtin-record.c              |  2 +-
 tools/perf/builtin-report.c              |  2 +-
 tools/perf/tests/bpf.c                   |  1 -
 tools/perf/tests/parse-events.c          | 22 +++++++++++-----------
 tools/perf/tests/pfm.c                   | 12 ++++++------
 tools/perf/util/evlist.c                 |  2 +-
 tools/perf/util/evlist.h                 |  6 ++++++
 tools/perf/util/header.c                 |  3 +--
 tools/perf/util/parse-events.c           |  1 -
 tools/perf/util/parse-events.h           |  1 -
 tools/perf/util/parse-events.y           | 10 ----------
 tools/perf/util/pfm.c                    |  1 -
 15 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 2d6121e89ccb..81e8b5fcd8ba 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -703,7 +703,23 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 		struct perf_evsel *first = list_entry(evlist->entries.next,
 						struct perf_evsel, node);
 
-		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
 		__perf_evlist__set_leader(&evlist->entries, first);
 	}
 }
+
+int perf_evlist__nr_groups(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+	int nr_groups = 0;
+
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		/*
+		 * evsels by default have a nr_members of 1, and they are their
+		 * own leader. If the nr_members is >1 then this is an
+		 * indication of a group.
+		 */
+		if (evsel->leader == evsel && evsel->nr_members > 1)
+			nr_groups++;
+	}
+	return nr_groups;
+}
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 850f07070036..3339bc2f1765 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -17,7 +17,6 @@ struct perf_mmap_param;
 struct perf_evlist {
 	struct list_head	 entries;
 	int			 nr_entries;
-	int			 nr_groups;
 	bool			 has_user_cpus;
 	bool			 needs_map_propagation;
 	/**
diff --git a/tools/lib/perf/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
index 9ca399d49bb4..e894b770779e 100644
--- a/tools/lib/perf/include/perf/evlist.h
+++ b/tools/lib/perf/include/perf/evlist.h
@@ -47,4 +47,5 @@ LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
 	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
 
 LIBPERF_API void perf_evlist__set_leader(struct perf_evlist *evlist);
+LIBPERF_API int perf_evlist__nr_groups(struct perf_evlist *evlist);
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6..e71c110a0cd4 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2474,7 +2474,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		rec->tool.ordered_events = false;
 	}
 
-	if (!rec->evlist->core.nr_groups)
+	if (evlist__nr_groups(rec->evlist) == 0)
 		perf_header__clear_feat(&session->header, HEADER_GROUP_DESC);
 
 	if (data->is_pipe) {
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2ee2ecca208e..6400615b5e98 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1481,7 +1481,7 @@ int cmd_report(int argc, const char **argv)
 
 	setup_forced_leader(&report, session->evlist);
 
-	if (symbol_conf.group_sort_idx && !session->evlist->core.nr_groups) {
+	if (symbol_conf.group_sort_idx && evlist__nr_groups(session->evlist) == 0) {
 		parse_options_usage(NULL, options, "group-sort-idx", 0);
 		ret = -EINVAL;
 		goto error;
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index ae9223f27cfb..8beb46066034 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -153,7 +153,6 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	}
 
 	evlist__splice_list_tail(evlist, &parse_state.list);
-	evlist->core.nr_groups = parse_state.nr_groups;
 
 	evlist__config(evlist, &opts, NULL);
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 71a5cb343311..ffa6f0a90741 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -53,7 +53,7 @@ static int test__checkevent_tracepoint(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist__nr_groups(evlist));
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong sample_type",
 		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
@@ -66,7 +66,7 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 	struct evsel *evsel;
 
 	TEST_ASSERT_VAL("wrong number of entries", evlist->core.nr_entries > 1);
-	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 0 == evlist__nr_groups(evlist));
 
 	evlist__for_each_entry(evlist, evsel) {
 		TEST_ASSERT_VAL("wrong type",
@@ -677,7 +677,7 @@ static int test__group1(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
 
 	/* instructions:k */
 	evsel = leader = evlist__first(evlist);
@@ -719,7 +719,7 @@ static int test__group2(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 3 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
 
 	/* faults + :ku modifier */
 	evsel = leader = evlist__first(evlist);
@@ -775,7 +775,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist__nr_groups(evlist));
 
 	/* group1 syscalls:sys_enter_openat:H */
 	evsel = leader = evlist__first(evlist);
@@ -868,7 +868,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
 
 	/* cycles:u + p */
 	evsel = leader = evlist__first(evlist);
@@ -912,7 +912,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 5 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 2 == evlist__nr_groups(evlist));
 
 	/* cycles + G */
 	evsel = leader = evlist__first(evlist);
@@ -998,7 +998,7 @@ static int test__group_gh1(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
 
 	/* cycles + :H group modifier */
 	evsel = leader = evlist__first(evlist);
@@ -1038,7 +1038,7 @@ static int test__group_gh2(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
 
 	/* cycles + :G group modifier */
 	evsel = leader = evlist__first(evlist);
@@ -1078,7 +1078,7 @@ static int test__group_gh3(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
 
 	/* cycles:G + :u group modifier */
 	evsel = leader = evlist__first(evlist);
@@ -1118,7 +1118,7 @@ static int test__group_gh4(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist->core.nr_groups);
+	TEST_ASSERT_VAL("wrong number of groups", 1 == evlist__nr_groups(evlist));
 
 	/* cycles:G + :uG group modifier */
 	evsel = leader = evlist__first(evlist);
diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
index 71b76deb1f92..2e38dfa34b6c 100644
--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -76,7 +76,7 @@ static int test__pfm_events(struct test_suite *test __maybe_unused,
 				count_pfm_events(&evlist->core),
 				table[i].nr_events);
 		TEST_ASSERT_EQUAL(table[i].events,
-				evlist->core.nr_groups,
+				evlist__nr_groups(evlist),
 				0);
 
 		evlist__delete(evlist);
@@ -103,22 +103,22 @@ static int test__pfm_group(struct test_suite *test __maybe_unused,
 		{
 			.events = "{instructions}",
 			.nr_events = 1,
-			.nr_groups = 1,
+			.nr_groups = 0,
 		},
 		{
 			.events = "{instructions},{}",
 			.nr_events = 1,
-			.nr_groups = 1,
+			.nr_groups = 0,
 		},
 		{
 			.events = "{},{instructions}",
 			.nr_events = 1,
-			.nr_groups = 1,
+			.nr_groups = 0,
 		},
 		{
 			.events = "{instructions},{instructions}",
 			.nr_events = 2,
-			.nr_groups = 2,
+			.nr_groups = 0,
 		},
 		{
 			.events = "{instructions,cycles},{instructions,cycles}",
@@ -161,7 +161,7 @@ static int test__pfm_group(struct test_suite *test __maybe_unused,
 				count_pfm_events(&evlist->core),
 				table[i].nr_events);
 		TEST_ASSERT_EQUAL(table[i].events,
-				evlist->core.nr_groups,
+				evlist__nr_groups(evlist),
 				table[i].nr_groups);
 
 		evlist__delete(evlist);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 817df2504a1e..a5f406c468f8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1777,7 +1777,7 @@ bool evlist__exclude_kernel(struct evlist *evlist)
  */
 void evlist__force_leader(struct evlist *evlist)
 {
-	if (!evlist->core.nr_groups) {
+	if (evlist__nr_groups(evlist) == 0) {
 		struct evsel *leader = evlist__first(evlist);
 
 		evlist__set_leader(evlist);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index d89d8f92802b..46cf402add93 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -9,6 +9,7 @@
 #include <api/fd/array.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
+#include <perf/evlist.h>
 #include "events_stats.h"
 #include "evsel.h"
 #include <pthread.h>
@@ -255,6 +256,11 @@ static inline struct evsel *evlist__last(struct evlist *evlist)
 	return container_of(evsel, struct evsel, core);
 }
 
+static inline int evlist__nr_groups(struct evlist *evlist)
+{
+	return perf_evlist__nr_groups(&evlist->core);
+}
+
 int evlist__strerror_open(struct evlist *evlist, int err, char *buf, size_t size);
 int evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size);
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 404d816ca124..276870221ce0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -786,7 +786,7 @@ static int write_pmu_mappings(struct feat_fd *ff,
 static int write_group_desc(struct feat_fd *ff,
 			    struct evlist *evlist)
 {
-	u32 nr_groups = evlist->core.nr_groups;
+	u32 nr_groups = evlist__nr_groups(evlist);
 	struct evsel *evsel;
 	int ret;
 
@@ -2807,7 +2807,6 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 	 * Rebuild group relationship based on the group_desc
 	 */
 	session = container_of(ff->ph, struct perf_session, header);
-	session->evlist->core.nr_groups = nr_groups;
 
 	i = nr = 0;
 	evlist__for_each_entry(session->evlist, evsel) {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 93a90651266f..9ec3c1dc81e0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2260,7 +2260,6 @@ int __parse_events(struct evlist *evlist, const char *str,
 	if (!ret) {
 		struct evsel *last;
 
-		evlist->core.nr_groups += parse_state.nr_groups;
 		last = evlist__last(evlist);
 		last->cmdline_group_boundary = true;
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index fdac44dc696b..767ad1729228 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -122,7 +122,6 @@ struct parse_events_error {
 struct parse_events_state {
 	struct list_head	   list;
 	int			   idx;
-	int			   nr_groups;
 	struct parse_events_error *error;
 	struct evlist		  *evlist;
 	struct list_head	  *terms;
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f1b153c72d67..3a04602d2982 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -49,14 +49,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 	free(list_evsel);
 }
 
-static void inc_group_count(struct list_head *list,
-		       struct parse_events_state *parse_state)
-{
-	/* Count groups only have more than 1 members */
-	if (!list_is_last(list->next, list))
-		parse_state->nr_groups++;
-}
-
 %}
 
 %token PE_START_EVENTS PE_START_TERMS
@@ -201,7 +193,6 @@ PE_NAME '{' events '}'
 {
 	struct list_head *list = $3;
 
-	inc_group_count(list, _parse_state);
 	/* Takes ownership of $1. */
 	parse_events__set_leader($1, list);
 	$$ = list;
@@ -211,7 +202,6 @@ PE_NAME '{' events '}'
 {
 	struct list_head *list = $2;
 
-	inc_group_count(list, _parse_state);
 	parse_events__set_leader(NULL, list);
 	$$ = list;
 }
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index b59ba825ddc9..6c11914c179f 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -112,7 +112,6 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
 				   "cannot close a non-existing event group\n");
 				goto error;
 			}
-			evlist->core.nr_groups++;
 			grp_leader = NULL;
 			grp_evt = -1;
 		}
-- 
2.40.0.rc1.284.g88254d51c5-goog

