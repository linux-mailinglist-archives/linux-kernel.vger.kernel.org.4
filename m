Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671336F4D17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjEBWpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjEBWpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:45:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D392635BF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:44:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a8075bd7cso7758993276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067395; x=1685659395;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgxNy0ApXBVjzvhQZgVvxx7rNPPhGpKow0V3CkUrSSM=;
        b=hBl2zlApmK/DF51KUpwd95LcHd56hvZaXqxjDJJ9bKdL8d/ljP8HNkT4WX/m5bJWtS
         gGh/Zv2WIYEPwQRQ0aQpZt3YLOvIPJv5XHM3GqtSrfnNdOO1XK6dCLxBEEiQRMBJKkiG
         59ZuLftpveBWITKoO+zEprZ3rI/vwf7/XkeIlCrX2D+vipWGyJXtWU4UT8x8a++d+kzY
         n59CntWOWDnAz/FCGUrv9XUpTkXZWXbnE+8imtFZ/pW+MSMXm222CLd4jnNo+i+EJSga
         7k631Oph6eR361e6qyjgQCRZB7dgFFhWecYn0dY+4t87nauVYy7qrMdlxCE9mmbUKKBo
         ygCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067395; x=1685659395;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgxNy0ApXBVjzvhQZgVvxx7rNPPhGpKow0V3CkUrSSM=;
        b=IRffTLAaSrkxmvkV5CbXZiIB+XbhP1TJndD/tFSJPSQcsViTOMOHBk00JF7pWHDnwE
         tgl6z4jU0FPlI+Rlj8JFEzvQhtY9JBkv6jr5txDU2g6ViI9I7iJFcCfS4diLrvu1ahIy
         k/ZP73aaRPHQGCNYnPxzWtGyu1wUiRZueNsDaUF98m5RtavpxANeNhhCQpYgJV9mQsaE
         bU9IU076TyJ0l5lO7zsFK5WQFo1yKGsSlWZ/EjoOIA7+1Qb73c9xGJG0C+T9mTKIZul6
         vjJQiG/FuwJ2kXP6+EI7ojJ4Q6kLup0qiXL/BrlEIlKlsJCwxM83t37TqtnBCQzDNM/2
         pfpw==
X-Gm-Message-State: AC+VfDwRwNpLYznZepBu84JFYMDbmsYyQt2kp8DGepHUNyLtIxL49RXn
        pA3GL48G2J+RzwHmWT20f/fiKGJgFEN7
X-Google-Smtp-Source: ACHHUZ7LNMMVhEJZZrX8sDNyDbONiX9SJSvoR3ihvfRCdx9SKcU8VKRA3bjAmDpCkaqRv5x0u3+ElwMoTDf8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a05:6902:100e:b0:b8b:f584:6b73 with SMTP
 id w14-20020a056902100e00b00b8bf5846b73mr7537984ybt.10.1683067394974; Tue, 02
 May 2023 15:43:14 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:41 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-35-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 34/44] perf parse-events: Avoid error when assigning a term
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
$ perf stat -e 'cycles/name=name/' true
event syntax error: 'cycles/name=name/'
                                \___ parser error
'''
by turning the term back to a string if it is on the right. Add PMU
and generic parsing tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 21 +++++++++++++++++++++
 tools/perf/util/parse-events.c  |  9 +++++++++
 tools/perf/util/parse-events.h  |  3 +++
 tools/perf/util/parse-events.y  |  8 ++++++++
 4 files changed, 41 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 9ca8e19bda00..eb893cc15878 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1499,6 +1499,16 @@ static int test__sym_event_dc(struct evlist *evlist)
 	return TEST_OK;
 }
 
+static int test__term_equal_term(struct evlist *evlist)
+{
+	struct evsel *evsel = evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong type", evsel->core.attr.type == PERF_TYPE_HARDWARE);
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_CPU_CYCLES));
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "name") == 0);
+	return TEST_OK;
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 static int count_tracepoints(void)
 {
@@ -1871,6 +1881,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__exclusive_group,
 		/* 7 */
 	},
+	{
+		.name  = "cycles/name=name/",
+		.check = test__term_equal_term,
+		/* 8 */
+	},
 };
 
 static const struct evlist_test test__events_pmu[] = {
@@ -2052,6 +2067,12 @@ static const struct evlist_test test__events_pmu[] = {
 		.check = test__exclusive_group,
 		/* 9 */
 	},
+	{
+		.name  = "cpu/cycles,name=name/",
+		.valid = test__pmu_cpu_valid,
+		.check = test__term_equal_term,
+		/* 0 */
+	},
 };
 
 struct terms_test {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index dea27bc0b376..5d5d77fa398b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2581,6 +2581,15 @@ int parse_events_term__str(struct parse_events_term **term,
 	return new_term(term, &temp, str, 0);
 }
 
+int parse_events_term__term(struct parse_events_term **term,
+			    int term_lhs, int term_rhs,
+			    void *loc_term, void *loc_val)
+{
+	return parse_events_term__str(term, term_lhs, NULL,
+				      strdup(config_term_names[term_rhs]),
+				      loc_term, loc_val);
+}
+
 int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 7fe80b416143..2a8cafe0ee8f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -148,6 +148,9 @@ int parse_events_term__num(struct parse_events_term **term,
 int parse_events_term__str(struct parse_events_term **term,
 			   int type_term, char *config, char *str,
 			   void *loc_term, void *loc_val);
+int parse_events_term__term(struct parse_events_term **term,
+			    int term_lhs, int term_rhs,
+			    void *loc_term, void *loc_val);
 int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term);
 void parse_events_term__delete(struct parse_events_term *term);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 819a5123fd77..0aaebc57748e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -848,6 +848,14 @@ PE_TERM '=' PE_TERM_HW
 	$$ = term;
 }
 |
+PE_TERM '=' PE_TERM
+{
+	struct parse_events_term *term;
+
+	ABORT_ON(parse_events_term__term(&term, (int)$1, (int)$3, &@1, &@3));
+	$$ = term;
+}
+|
 PE_TERM '=' PE_VALUE
 {
 	struct parse_events_term *term;
-- 
2.40.1.495.gc816e09b53d-goog

