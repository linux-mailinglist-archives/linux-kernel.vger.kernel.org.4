Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7936EEEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbjDZHHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjDZHHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:07:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEE249D4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:05:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b99f3aee8e0so9385082276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492720; x=1685084720;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpUWqNL0tOEngg8yuOrwHuZx1oPdLKlDkdLSWdUpIbg=;
        b=H9/xEHdW0rbpUs3lnjyxtiTbkIPJvy45jI5bNCaQPJo7vROp1aYS4E18+wfVQV82Qy
         j0FIxLbIcEUcPtGUyVocFYIdkKDh4uuJdpKACCWaGEW4r4F4t8c+3DTCFrZvjIEYW4cx
         N1ZOy5xgym5ozlXvMxx4zWMhgRKcALQqN4mZsWmiXMS3Ys9jx/oTtXw0P19LYhv8/MjQ
         Fx+hE5SGi0osuaFG6gEQSEEkZbWmOS98PJl7TZT44f1hwKns4ZuqP9OIiCkkVsjOyN/G
         znipYkwiznoLaGWoIciso6WZkT+Q0/p/7Ed6MKk3n+5dv8cW22TvFEsn+AokubsjPIzZ
         4qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492720; x=1685084720;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpUWqNL0tOEngg8yuOrwHuZx1oPdLKlDkdLSWdUpIbg=;
        b=PKbciE8STjk/QOhLC046+A/bMfQN5il1RJgcPMezT4Vbi9+1SrKQDjUsXlxWETGg+L
         VwDd+qirvTAoNGsJVnMi1ZoAeegUcJUldJDpifjCP7mmnk0NQgks+gB4nMuuelnn8xBS
         goigm5woS6xgXve/xpgD0C8ATExPU+LZR0Ti+8YfPsV9XKidYMJVBLJhmGVQQFDprGn8
         0f/gsrOot2KP9lTWiUKolYwo4oepaBdwtz0zWLGI27JjmngGF7R/OHqrSBT6S7QMq/OY
         XpVLSFyoJTFJ0BE7v1fw4HmAgQI1wIbn7I2EdbdQU8LCoNgWqi8ODzkELxVZAr5zH89h
         7C2w==
X-Gm-Message-State: AC+VfDyIsRAHoYBakmUxm3Hapwl4ck7xLiVMxArbDjGjd/OauZMXw+6X
        zWdfBYH5G6COYTwR1gxyj2izlHHXfuW1
X-Google-Smtp-Source: ACHHUZ65Ydc2KtN7BWaC/ktnakyD7s40B2e42pMLpiPw3w+MRMRsBxzYMRNaXC4/qxOnDGXQtCDs+HCM1Gdc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a81:25c1:0:b0:556:aa28:f9c5 with SMTP id
 l184-20020a8125c1000000b00556aa28f9c5mr944980ywl.2.1682492719959; Wed, 26 Apr
 2023 00:05:19 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:41 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-32-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 31/40] perf parse-events: Avoid error when assigning a term
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
index 4c21bef882ff..06042f450ece 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1485,6 +1485,16 @@ static int test__sym_event_dc(struct evlist *evlist)
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
@@ -1857,6 +1867,11 @@ static const struct evlist_test test__events[] = {
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
@@ -2038,6 +2053,12 @@ static const struct evlist_test test__events_pmu[] = {
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
index 27c179323b6d..98e424257278 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2578,6 +2578,15 @@ int parse_events_term__str(struct parse_events_term **term,
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

