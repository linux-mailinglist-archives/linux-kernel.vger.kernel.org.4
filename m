Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B861D6F4D00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjEBWli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEBWl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:41:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99186272B
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:40:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f6bef3d4aso9045066276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067253; x=1685659253;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BX+wo12NQqjkG8fkdhxrtw5rHRURfV8DWGPIMVVXPZo=;
        b=jY1k2M0HBIeDTiWg0fv95l2HIE9v6FnHmXzEqYWxpVONa8HrzcblzBmmv5G+VH5lGc
         6IyNnPFzIjrt8KiDSKO1vSXlOCZosH+xespOL9kSxzyKBgItosPRAG6TnTWnK31//CZu
         wTjKGlvln6ZSMOQsEg03/dH1YIZwqR2mBhRGEbCc3FihZbv+DRTlqAj3zZzoUGQ8L98b
         1MGnSVPgASF8CxcDPme6XRlFdB7VIVhmsYVeairqma5D+1hMBDEgKG6S/yQzAAn1Mc/U
         eULo6Q7xK19ULL1yJkXNFh6S6m5nSsWPJKr/4X/cCIxfoQ7QIOh3rGooefcbQTqEtDjM
         rojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067253; x=1685659253;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX+wo12NQqjkG8fkdhxrtw5rHRURfV8DWGPIMVVXPZo=;
        b=YmiCiNP2kO0kniziqq7T3m8rlNlt0oea614T58VTDDW+qXM6Cr1ga881zln0jFb2Jq
         /JeNiUjvX6WXOHx+TsTuuNoXtuStn9kOgLnDx2siokD33nuA9BXjIj65vww0v0IoQpwE
         l6kpDU00YAgZs1Whm1g2bkc9z3xhxaXpn8jgns4ku1jirxSvLmnINXwiDiDystDQLXjn
         OqgDi7d1OlVIRo9B6Li0PhcLliVBCWj6ejAsx/sWkD353gV1Z8+c7q3/g1Qxvuw0L5qE
         qieOv31Syzsnj3JXywWOYjeI6qbjY7m0xHfsZ71pkdcmUKSrb9Mc+491x8iGVOlRQQeE
         iWdA==
X-Gm-Message-State: AC+VfDwUtQgGg8zgtQWVTMqXFAuOaro1xHKhVWqzMaQHJf2T91obEvRR
        egNWWqXyhxNgvHA5/sLlkexyboILp3oT
X-Google-Smtp-Source: ACHHUZ70i3gpaxdmSUa18mV3yojjR/gFy4NlVLSd9oaXrd39WKJMtXfkJvPt9KwbDIjBe6rQHnqBXuXKEwSH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1081:b0:b9d:d5dc:5971 with SMTP
 id v1-20020a056902108100b00b9dd5dc5971mr6038137ybu.2.1683067253491; Tue, 02
 May 2023 15:40:53 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:21 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-15-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 14/44] perf test: Roundtrip name, don't assume 1 event per name
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
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

Opening hardware names and a legacy cache event on a hybrid PMU opens
it on each PMU. Parsing and checking indexes fails, as the parsed
index is double the expected. Avoid checking the index by just
comparing the names immediately after the parse.

This change removes hard coded hybrid logic and removes assumptions
about the expansion of an event. On hybrid the PMUs may or may not
support an event and so using a distance isn't a consistent solution.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/evsel-roundtrip-name.c | 119 ++++++++++--------------
 1 file changed, 49 insertions(+), 70 deletions(-)

diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index e94fed901992..15ff86f9da0b 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -4,114 +4,93 @@
 #include "parse-events.h"
 #include "tests.h"
 #include "debug.h"
-#include "pmu.h"
-#include "pmu-hybrid.h"
-#include <errno.h>
 #include <linux/kernel.h>
 
 static int perf_evsel__roundtrip_cache_name_test(void)
 {
-	char name[128];
-	int type, op, err = 0, ret = 0, i, idx;
-	struct evsel *evsel;
-	struct evlist *evlist = evlist__new();
+	int ret = TEST_OK;
 
-        if (evlist == NULL)
-                return -ENOMEM;
-
-	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
-		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
+	for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
+		for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
 			/* skip invalid cache type */
 			if (!evsel__is_cache_op_valid(type, op))
 				continue;
 
-			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
-				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
-				err = parse_event(evlist, name);
-				if (err)
-					ret = err;
-			}
-		}
-	}
-
-	idx = 0;
-	evsel = evlist__first(evlist);
+			for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
+				char name[128];
+				struct evlist *evlist = evlist__new();
+				struct evsel *evsel;
+				int err;
 
-	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
-		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
-			/* skip invalid cache type */
-			if (!evsel__is_cache_op_valid(type, op))
-				continue;
+				if (evlist == NULL) {
+					pr_debug("Failed to alloc evlist");
+					return TEST_FAIL;
+				}
+				__evsel__hw_cache_type_op_res_name(type, op, res,
+								name, sizeof(name));
 
-			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
-				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
-				if (evsel->core.idx != idx)
+				err = parse_event(evlist, name);
+				if (err) {
+					pr_debug("Failure to parse cache event '%s' possibly as PMUs don't support it",
+						name);
+					evlist__delete(evlist);
 					continue;
-
-				++idx;
-
-				if (strcmp(evsel__name(evsel), name)) {
-					pr_debug("%s != %s\n", evsel__name(evsel), name);
-					ret = -1;
 				}
-
-				evsel = evsel__next(evsel);
+				evlist__for_each_entry(evlist, evsel) {
+					if (strcmp(evsel__name(evsel), name)) {
+						pr_debug("%s != %s\n", evsel__name(evsel), name);
+						ret = TEST_FAIL;
+					}
+				}
+				evlist__delete(evlist);
 			}
 		}
 	}
-
-	evlist__delete(evlist);
 	return ret;
 }
 
-static int __perf_evsel__name_array_test(const char *const names[], int nr_names,
-					 int distance)
+static int perf_evsel__name_array_test(const char *const names[], int nr_names)
 {
-	int i, err;
-	struct evsel *evsel;
-	struct evlist *evlist = evlist__new();
+	int ret = TEST_OK;
 
-        if (evlist == NULL)
-                return -ENOMEM;
+	for (int i = 0; i < nr_names; ++i) {
+		struct evlist *evlist = evlist__new();
+		struct evsel *evsel;
+		int err;
 
-	for (i = 0; i < nr_names; ++i) {
+		if (evlist == NULL) {
+			pr_debug("Failed to alloc evlist");
+			return TEST_FAIL;
+		}
 		err = parse_event(evlist, names[i]);
 		if (err) {
 			pr_debug("failed to parse event '%s', err %d\n",
 				 names[i], err);
-			goto out_delete_evlist;
+			evlist__delete(evlist);
+			ret = TEST_FAIL;
+			continue;
 		}
-	}
-
-	err = 0;
-	evlist__for_each_entry(evlist, evsel) {
-		if (strcmp(evsel__name(evsel), names[evsel->core.idx / distance])) {
-			--err;
-			pr_debug("%s != %s\n", evsel__name(evsel), names[evsel->core.idx / distance]);
+		evlist__for_each_entry(evlist, evsel) {
+			if (strcmp(evsel__name(evsel), names[i])) {
+				pr_debug("%s != %s\n", evsel__name(evsel), names[i]);
+				ret = TEST_FAIL;
+			}
 		}
+		evlist__delete(evlist);
 	}
-
-out_delete_evlist:
-	evlist__delete(evlist);
-	return err;
+	return ret;
 }
 
-#define perf_evsel__name_array_test(names, distance) \
-	__perf_evsel__name_array_test(names, ARRAY_SIZE(names), distance)
-
 static int test__perf_evsel__roundtrip_name_test(struct test_suite *test __maybe_unused,
 						 int subtest __maybe_unused)
 {
-	int err = 0, ret = 0;
-
-	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom"))
-		return perf_evsel__name_array_test(evsel__hw_names, 2);
+	int err = 0, ret = TEST_OK;
 
-	err = perf_evsel__name_array_test(evsel__hw_names, 1);
+	err = perf_evsel__name_array_test(evsel__hw_names, PERF_COUNT_HW_MAX);
 	if (err)
 		ret = err;
 
-	err = __perf_evsel__name_array_test(evsel__sw_names, PERF_COUNT_SW_DUMMY + 1, 1);
+	err = perf_evsel__name_array_test(evsel__sw_names, PERF_COUNT_SW_DUMMY + 1);
 	if (err)
 		ret = err;
 
-- 
2.40.1.495.gc816e09b53d-goog

