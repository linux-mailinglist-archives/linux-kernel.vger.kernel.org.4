Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670006F4D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjEBWqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjEBWpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:45:42 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0212D69
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:45:24 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5289f93ad94so2353883a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067453; x=1685659453;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMkOwzwif+XT0+nBV5mOmwMnUg0kBSArT43+8IsF+QA=;
        b=DiVr58NKnqrNa0PQ4s2HvZYJODLIFvfXb8It+Z4M5+iCIdFJl7S7DAEMKsQ69BcuSf
         bYCLu0BHbbJQLd77EJSH/gAjXR/uE9dl+P49sOB0DUsD6hy7B3RcRtyXcRd8LoTulUGX
         crklksll2IrovGv52zukTueeu2ssNuKvDU2+2uFy32gLhv5zaXAR/MGgu/CeJ8bk81Zs
         LYuK6W0utDlAPgW4EsrwYLrBFdoyj1YB+Zo8jNjv8sQ6m3lwmtLZ9J+s3zOKRAAl4RmL
         QMny6ECo4pJZ4eM5axsLEZn4fvwHTrJw3P5pAEGTqZXepeUJ6HHwTtE0hSBM/+NMrkqU
         nuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067453; x=1685659453;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMkOwzwif+XT0+nBV5mOmwMnUg0kBSArT43+8IsF+QA=;
        b=Fn57CiDidlOOrD2fWkSXAkklskMtq0xsUCuqTZWU8bmrVGmW8CBFfWaMJtmzvtZigE
         gkQSeeym1rK96vIEYED//2qrbP33OeVp+mLBu+HsJyiOiFxFqVkQcNVQp86gYY3lIVvJ
         Uaop3nY17ywT9b7xxlc16uYjbrfUJ2Cec4sipAMUBrSx4aEUJkGrw+ERDx1TFt4rZGZ6
         F0OZUEc4+B2SCUl9nSQYokTEfYmK7EKv50AD06bXy8Q5aygBn8igZ/LuE8etulUUk3QB
         /tWB+LUe/mD/MVS1E9tiNUAoZQObfomV9JUuMAiDZnIU9Pka1f4UDYblHsf8NVdvRYGo
         Ph/w==
X-Gm-Message-State: AC+VfDzwRNO12Ct3R1rqOap5qPW+pleHU7ZjM1/s/RPAcQkL/39smp99
        LAniCxwETTAK4Ymgm4Z3fry/eZw/Kkxy
X-Google-Smtp-Source: ACHHUZ7ap0xtN41qtnwK/fzVQw9n9WtCXHcFSd4DNZI35fUjtZVM5Xpb1//5i3q2RLMUaEOVVhPNP2dYHZv8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a63:2aca:0:b0:51f:54dc:1646 with SMTP id
 q193-20020a632aca000000b0051f54dc1646mr17578pgq.7.1683067453102; Tue, 02 May
 2023 15:44:13 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:49 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-43-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 42/44] perf metrics: Be PMU specific in event match
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

Ids/events from a metric are turned into an event string and parsed;
setup_metric_events matches the id back to the parsed evsel. With
hybrid the same event may exist on both PMUs with the same name and be
being used by metrics at the same time. A metric on cpu_core therefore
shouldn't match against evsels on cpu_atom, or the metric will compute
the wrong value. Make the matching sensitive to the PMU being parsed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4245b23d8efe..490561f430f2 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -274,7 +274,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	const char *metric_id;
 	struct evsel *ev;
 	size_t ids_size, matched_events, i;
-	bool all_pmus = !strcmp(pmu, "all");
+	bool all_pmus = !strcmp(pmu, "all") || !perf_pmu__is_hybrid(pmu);
 
 	*out_metric_events = NULL;
 	ids_size = hashmap__size(ids);
@@ -287,7 +287,10 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	evlist__for_each_entry(metric_evlist, ev) {
 		struct expr_id_data *val_ptr;
 
-		if (!all_pmus && strcmp(ev->pmu_name, pmu))
+		/* Don't match events for the wrong hybrid PMU. */
+		if (!all_pmus && ev->pmu_name &&
+		    perf_pmu__is_hybrid(ev->pmu_name) &&
+		    strcmp(ev->pmu_name, pmu))
 			continue;
 		/*
 		 * Check for duplicate events with the same name. For
@@ -304,6 +307,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		 * about this event.
 		 */
 		if (hashmap__find(ids, metric_id, &val_ptr)) {
+			pr_debug("Matched metric-id %s to %s\n", metric_id, evsel__name(ev));
 			metric_events[matched_events++] = ev;
 
 			if (matched_events >= ids_size)
@@ -1592,7 +1596,7 @@ static int parse_groups(struct evlist *perf_evlist,
 		ret = setup_metric_events(fake_pmu ? "all" : m->pmu, m->pctx->ids,
 					  metric_evlist, &metric_events);
 		if (ret) {
-			pr_debug("Cannot resolve IDs for %s: %s\n",
+			pr_err("Cannot resolve IDs for %s: %s\n",
 				m->metric_name, m->metric_expr);
 			goto out;
 		}
-- 
2.40.1.495.gc816e09b53d-goog

