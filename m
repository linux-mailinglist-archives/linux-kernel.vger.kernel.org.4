Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B1369BFD5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBSJqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjBSJqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:46:50 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFA02117
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:46:10 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5368a7c71e3so14518577b3.17
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1c75G2QRp2XfNcd0fyJt7z2QBiUcClmUEJnZutpl3U=;
        b=lQc7DLqjY+G0h68iUyNnQt0s8JbFjdLvt6vUD0X3O7LQXsct1au6ugX7YKcPBS3UPJ
         AsAznm2proFWTuMGysZno/FG9nfkQj2SekacMWMc3JcdaBlyiBSXOGz0lhlEgLdgGAxp
         WDR9gSMRJuJm8sfYf4Js7MhM80qTW0YRs+7lkwr6P601fxAf4quXfIGXkK94Dp9yf7NJ
         VG/TQ0DMh2RX36SsfyliyUni4YrostDu/WgZ0dbrvUcDxYX103Xt5iUnMSJxA78X1q/J
         xUWr1XsXdm9DAOmntwU2JGUE0TJhIpozeTXHwgCbdlqWpR3m96Aghhr+kQKjI1/QS/RH
         /euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1c75G2QRp2XfNcd0fyJt7z2QBiUcClmUEJnZutpl3U=;
        b=llgK7Nw4Pphw43ybly1oN1M1N4Cb55k/5qGhN4zZUchu+hwOLHYvWK58jAil6yKJVm
         DW5IqOIRn6FwRgnU28k8KEQ5xNQlHXHx8vHo3rvaDWYWrgz5WOEHcsW75wdyoH8xTKux
         u8tyme7y2TMMjZmok5fTlOxrKJlXdo3za7FfyrFRh4oqzc4EtIITxUJEInK103BHijSF
         f/CnsLy7ieAvOJE/T9yvB+th76RrDRJtyOUijZgsRgt14lqiFgP2myJAz9CBe9XNjnXh
         1j7tZUEq95n3IprW+ut+IUkS0KcOXJZRyZmUHqhLSHdnssNo8mQQl6IaD9HE0QSWnszF
         IyfQ==
X-Gm-Message-State: AO0yUKVeuL3hHObA3WAm0zg0UhE8Y3V/HIutTME3mrUk1ozs4LZlxWJI
        khpbRslGiDoa06I0PIUoOlrFo2FEkEPb
X-Google-Smtp-Source: AK7set+0phLS9+KCkYB1hD6t9OHjqMNjyrH3Ll05ZAB31Ht5Vz9xAKErSbBOtdwOA5pdD6xB9HPX23EwfbRP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a0d:d6c1:0:b0:514:dae0:21ef with SMTP id
 y184-20020a0dd6c1000000b00514dae021efmr2065215ywd.133.1676799319684; Sun, 19
 Feb 2023 01:35:19 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:42 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-46-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 45/51] perf stat: Remove perf_stat_evsel_id
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_stat_evsel_id was used for hard coded metrics. These have now
migrated to json metrics and so the id values are no longer necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 31 -------------------------------
 tools/perf/util/stat.h | 12 ------------
 2 files changed, 43 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index d51d7457f12d..8d83d2f4a082 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -77,36 +77,6 @@ double rel_stddev_stats(double stddev, double avg)
 	return pct;
 }
 
-bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id)
-{
-	struct perf_stat_evsel *ps = evsel->stats;
-
-	return ps->id == id;
-}
-
-#define ID(id, name) [PERF_STAT_EVSEL_ID__##id] = #name
-static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
-	ID(NONE,		x),
-};
-#undef ID
-
-static void perf_stat_evsel_id_init(struct evsel *evsel)
-{
-	struct perf_stat_evsel *ps = evsel->stats;
-	int i;
-
-	/* ps->id is 0 hence PERF_STAT_EVSEL_ID__NONE by default */
-
-	for (i = 0; i < PERF_STAT_EVSEL_ID__MAX; i++) {
-		if (!strcmp(evsel__name(evsel), id_str[i]) ||
-		    (strstr(evsel__name(evsel), id_str[i]) && evsel->pmu_name
-		     && strstr(evsel__name(evsel), evsel->pmu_name))) {
-			ps->id = i;
-			break;
-		}
-	}
-}
-
 static void evsel__reset_aggr_stats(struct evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
@@ -166,7 +136,6 @@ static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
 		return -ENOMEM;
 	}
 
-	perf_stat_evsel_id_init(evsel);
 	evsel__reset_stat_priv(evsel);
 	return 0;
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 9af4af3bc3f2..df6068a3f7bb 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -19,11 +19,6 @@ struct stats {
 	u64 max, min;
 };
 
-enum perf_stat_evsel_id {
-	PERF_STAT_EVSEL_ID__NONE = 0,
-	PERF_STAT_EVSEL_ID__MAX,
-};
-
 /* hold aggregated event info */
 struct perf_stat_aggr {
 	/* aggregated values */
@@ -40,8 +35,6 @@ struct perf_stat_aggr {
 struct perf_stat_evsel {
 	/* used for repeated runs */
 	struct stats		 res_stats;
-	/* evsel id for quick check */
-	enum perf_stat_evsel_id	 id;
 	/* number of allocated 'aggr' */
 	int			 nr_aggr;
 	/* aggregated event values */
@@ -187,11 +180,6 @@ static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rus
 struct evsel;
 struct evlist;
 
-bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id);
-
-#define perf_stat_evsel__is(evsel, id) \
-	__perf_stat_evsel__is(evsel, PERF_STAT_EVSEL_ID__ ## id)
-
 extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
 extern struct rusage_stats ru_stats;
-- 
2.39.2.637.g21b0678d19-goog

