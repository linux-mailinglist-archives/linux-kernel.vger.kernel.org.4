Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181566F233A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347474AbjD2Fmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347454AbjD2FmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:42:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC1B40DC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:41:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a6eeea78cso16080540276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746828; x=1685338828;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sU/lmeLSKoR5H/nqE4K4lE0bCFvnA0wWSNvCYVNue5M=;
        b=1SNdB3zfpjsoaEe5XpzfPN15wRuQpnXQk3xDhygeew3ee3x+ETNwNjxeCOjNltPlMY
         BlP/ND4c8eOqwF5mv7PjwLao/wbeGE512eLoYwvPs1j9rSqCAh9Foh2oq22Gn4yROtUx
         sjBBvfj6Gkrv7ykLh0w7h8oJTn6rh6/IUwyCj07xx2hPkNBaHbFELLTCNLvC38l/wMgv
         nGyr/0nKOopAdhpHJy5kLPYLqQBJkn5d/VKrcPDJuQONLnBoTFauwlDOkP+faR3aWIF3
         aZBNJHS0WSMXhBWna3is3HLxIRaaWDAQbYGAVFyLzCFgukw4llAHCyf3IQiqy3KLoxy2
         hnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746828; x=1685338828;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sU/lmeLSKoR5H/nqE4K4lE0bCFvnA0wWSNvCYVNue5M=;
        b=ZM52yXNCdZajL0+Evw5kgWT9RVyvjKtwWJMX0ZzglayTKEcY7tvmC7YZWtV4x2xBCa
         Xo/McT7IGeVLVQ/5IDWbnFrtUTMSId7XTmfePe6d0JrRB/3pzXmrDy3kXB3DEVU1HPCF
         LZ1LP8e9Ca4iAJfplX4v+I/CdRg54mEZ3h5hAugwhSO31RL7U18FKRg4ktg65qPz+vuq
         48a6MdmIs0gpIalAE6O+Kt3QzqLVy3lz8dIKWoEpRKcL3mLl2gg1Go+ZgoZ81SNb57QO
         MCglTjgU5ndOArUp59e7uKsGWH9yDnYlOOmz7HBpIVGGGjaLrbRBBlVdbDQDQgGCxJ5q
         EozQ==
X-Gm-Message-State: AC+VfDxyWYnnpB9XYAFLJ96DIHX9imU5YfsMgGbno9+MaDPQYVBtiWiq
        6eFfJVDl9Dh8vLw0pfRX6chGHKMHyD+c
X-Google-Smtp-Source: ACHHUZ6sP8rizsodv0R+tY0WuOnbx9k7zg6sSLcTDfh/1UQdClcuu1PMXXkS4t3VOmC7GRDEykPNxTwZJWjX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a81:ed06:0:b0:54b:fd28:c5ff with SMTP id
 k6-20020a81ed06000000b0054bfd28c5ffmr4992847ywm.3.1682746828140; Fri, 28 Apr
 2023 22:40:28 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:57 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-38-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 37/46] perf parse-events: Avoid error when assigning a
 legacy cache term
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

Avoid the parser error:
'''
$ perf stat -e 'cycles/name=l1d/' true
event syntax error: 'cycles/name=l1d/'
                                \___ parser error
'''
by combining the name and legacy cache cases in the parser.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 21 +++++++++++++++++++++
 tools/perf/util/parse-events.y  | 10 ++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 449d7a1780f4..cf786c362861 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1495,6 +1495,16 @@ static int test__term_equal_term(struct evlist *evlist)
 	return TEST_OK;
 }
 
+static int test__term_equal_legacy(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "l1d") == 0);
+	return TEST_OK;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 static int count_tracepoints(void)
 {
@@ -1872,6 +1882,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__term_equal_term,
 		/* 8 */
 	},
+	{
+		.name  = "cycles/name=l1d/",
+		.check = test__term_equal_legacy,
+		/* 9 */
+	},
 };
 
 static const struct evlist_test test__events_pmu[] = {
@@ -2059,6 +2074,12 @@ static const struct evlist_test test__events_pmu[] = {
 		.check = test__term_equal_term,
 		/* 0 */
 	},
+	{
+		.name  = "cpu/cycles,name=l1d/",
+		.valid = test__pmu_cpu_valid,
+		.check = test__term_equal_legacy,
+		/* 1 */
+	},
 };
 
 struct terms_test {
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 0aaebc57748e..f4ee03b5976b 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -82,7 +82,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_EVENT_NAME
 %type <str> PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %type <str> PE_DRV_CFG_TERM
-%type <str> name_or_raw
+%type <str> name_or_raw name_or_legacy
 %destructor { free ($$); } <str>
 %type <term> event_term
 %destructor { parse_events_term__delete ($$); } <term>
@@ -739,6 +739,8 @@ event_term
 
 name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
 
+name_or_legacy: PE_NAME | PE_LEGACY_CACHE
+
 event_term:
 PE_RAW
 {
@@ -752,7 +754,7 @@ PE_RAW
 	$$ = term;
 }
 |
-name_or_raw '=' PE_NAME
+name_or_raw '=' name_or_legacy
 {
 	struct parse_events_term *term;
 
@@ -826,7 +828,7 @@ PE_TERM_HW
 	$$ = term;
 }
 |
-PE_TERM '=' PE_NAME
+PE_TERM '=' name_or_legacy
 {
 	struct parse_events_term *term;
 
@@ -872,7 +874,7 @@ PE_TERM
 	$$ = term;
 }
 |
-name_or_raw array '=' PE_NAME
+name_or_raw array '=' name_or_legacy
 {
 	struct parse_events_term *term;
 
-- 
2.40.1.495.gc816e09b53d-goog

