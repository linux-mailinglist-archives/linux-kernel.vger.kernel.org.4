Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA26EEEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbjDZHHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbjDZHHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:07:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A79E49F4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:05:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso1476619276.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492727; x=1685084727;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ0x6N0RNGSt0AF/fHZKh2i20S0O9mJpVpnE3xtP9Qs=;
        b=dLfPuoZPECVNAa8PJubrzET3fdMuNPpnEJhZwWXqjBenElR9cXO6ly6IIczs/OfWFq
         8zQ0iFqlh+vakxj7BJ+u+aB8MWOX5vie45jmde2bTaJglKhPaaeN/JpYQSTP6CpW19Cf
         qsuOvULaFoWvN82XLXCYcH6+QgybmOwh+qxAky2avg0CHNN76ooZ5qHCyY+S3uzK7ZlO
         ZtQn7E3q1D4kf86EnVcWhbF/zq+gLO381XLBr+rPYfPl2ZtRxrPh/jONbn+++HhZJfgF
         9jSccJ+XSOxtHZq1yMMH0uPYZ9zqxrSuDfcxcs1aVmpRf4cbjimlWfDB8REZCwk6dNA0
         JlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492727; x=1685084727;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ0x6N0RNGSt0AF/fHZKh2i20S0O9mJpVpnE3xtP9Qs=;
        b=intW01jYlsaJ25PcoknzMjhiWerndcMQ1q74/qmFkyAiWom5fYCJhBtL9NoHr0L04G
         +Cv4VgdNlaHXXDNCW8NqcTbmpqOEcn6idEaIkdALhw5MHXI+tHHbmP2/alGzRYEULjZT
         Z/j0ctsEJPkLCMvciqJ8cBPHncWhsXKQBzlgPbaKiG/g6htfbTkT2znnBxalLMfxCs5o
         fWwSP3RavDCq1g6lhMr8IRE788f8M7u00mLY7ccDt/hU2tnkFBGMYK/f0AwE325XFyoE
         x/3+l72i+gg8aWvz9Alp29x+VhgkQaB8Xim8U9WsHLrAuMPbH8gc6qCkFSlaCde1F7uF
         LlYA==
X-Gm-Message-State: AAQBX9dgO0Hs+/WDo+5litVa426nvIGkQ87irPR58toZ2mad/iwp823E
        FGC052ulVg2PT98AMVQUWril0Wfwit/F
X-Google-Smtp-Source: AKy350a+sScxF4h4rmGICB8SVQvSJ8OaNlw1N3UYC3rgi0avDPGMbp+Zo/s/ohkk0badWy0fLCwZbdQ9GbCB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:ccd6:0:b0:b8b:fe5f:2eaa with SMTP id
 l205-20020a25ccd6000000b00b8bfe5f2eaamr7789005ybf.2.1682492727239; Wed, 26
 Apr 2023 00:05:27 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:42 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-33-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 32/40] perf parse-events: Avoid error when assigning a
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
        autolearn=ham autolearn_force=no version=3.4.6
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
index 06042f450ece..c44f0ffa51c5 100644
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

