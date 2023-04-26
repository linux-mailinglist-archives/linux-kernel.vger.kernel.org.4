Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B966EEEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbjDZHKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbjDZHJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:09:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595ED46B6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:07:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b999367041aso6732042276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492796; x=1685084796;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMkOwzwif+XT0+nBV5mOmwMnUg0kBSArT43+8IsF+QA=;
        b=TUyKxSBBJc+RdtsM0Ipk1QAqXQ79rrp0vRDC3FEwlgTCwqqLPydawMNTsnW0gTK4N3
         48XHpnfBQ3hx8uJhkXefmyIXDz1RxgNEJ9BPoj6/cqdzbF/dAnXw92ZbTYvEFKJDe1Mi
         W5UljueUV9xRwFYxsh+bd9YxpefkIwAvcnaHt8eQn4yTg557+osTCe7g/ITNtKmgkEmB
         5iRMmjSwhPIjSZRoj5g9pcz6vxnOc+NK06r6hdFSC1nc9qYo1w5tdP+YOqKMg4Oyhj3z
         0mFsXen70PxG0g96Ts5sKRRZhaLTNb40/eLK5nxdAno6kjp4q2IF0vec/4UHY0ilQXob
         mtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492796; x=1685084796;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMkOwzwif+XT0+nBV5mOmwMnUg0kBSArT43+8IsF+QA=;
        b=iAnAiC5xwss6THGps82BeGwraWgYW/g/F7W187dJ+8APnLJxXLGORoZIZRP1NGjOMK
         JqpuDMDqFEZ0wEBQ+3+X3/yeexeWFKOj6eqIDu/oI5RCFlgQFGXEiwuKMeV9J+ngbMn2
         IKNdy3uQvnwXfBIjQI6H3xI/sSTQp3KEeDngj3IW3igXAUX6oGsc01Kx/IZXki4WC1k7
         eqF21NNqfKURJ7bkbOn5lWzC2838LfPlof4zv9u70qSUi4J8udpoNMu+Z93ssujduP54
         fHK8MooutoigFfOPRGGH3vtGnsYcjPQ0na3oPsnECuywe4VjBE2dfUMDdV/H4+lxNI11
         n6uA==
X-Gm-Message-State: AAQBX9eJhbQ8zZWCX/ANB4ZRQ7GMCIPkOETH5oUcTIji94srsKjSJVI6
        c4MquuYoi6VAt9ZCPca/66WzRJHddxVw
X-Google-Smtp-Source: AKy350bTJLOxcltCw5a6MXyD2IISezfFvAcGUVYrqdRXnBze4q7xvqgQDhzkkf95a6knq7Tm4DsBwtS33P3x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:d0c7:0:b0:b97:2ecf:ff6d with SMTP id
 h190-20020a25d0c7000000b00b972ecfff6dmr11084850ybg.5.1682492796043; Wed, 26
 Apr 2023 00:06:36 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:50 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-41-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 40/40] perf metrics: Be PMU specific in event match
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

