Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3D769BFBC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjBSJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBSJhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:37:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C4E3BE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:36:34 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53687b09838so19197907b3.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ivvDzCiOjMDLj/gcFt7rd0F2g23q1K7jFLZUP1Bknc=;
        b=pYOV+yD5JlC63LIjHOEgCbCoVbA5/K+27F7L88dBNxpq0XtFj0mZZlqIwBeS92aa/g
         4kDUIW6Ukpzk0fFBdMUaZQ9gpbxcONzq+Wex72Os29VOJJeKmMByz2aAyDl1kZOJhSvz
         gMyXVIcQ66hX6vSSMEXC6o0ZfK1beKFKsed7fXcseehPo4dxwSPM0pj09N90AAhkjkgC
         RqmIIPmMTskb/OWIeVf6wOoMaMNj2sJEn+pKMsU2ZwLxQqfbvK/cKpI5GR39iETOkuxK
         apz9HUvn1dPJ6d+YgJ5aG1cft6QskyAlLCTBnyeqR6tQvJk1kYio9jElUCO1VUWcZ9I6
         YNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ivvDzCiOjMDLj/gcFt7rd0F2g23q1K7jFLZUP1Bknc=;
        b=n2U5+OsFgVwTFNqn7byaXNR0d+BcIPstM1up1jSGuipmj7SJeyDZPr9/rVO3ya7LeQ
         Rd7Sxq38N0OPxpkSk5G4vMNEyq4eC9yU8/MrkdMuNEBQg+zfOV6MPV/9MLKnPMQDD0JB
         rxpvWC1jEgoY33TuSo0t4kBmO1GUAv2LkKc3kHeqgzU2fCVnWzrgpSWbeNukvpj22Mja
         /cH6W5FFLwML83m0iu9GOaotJ6eSO2nYInfuThTeAFz6lwKZeZwp3KhjogW3fO8Sa5+0
         j4bFDBp+QGt9VNYRvNjGFTFqs11hrTiBLCK6fC9+dAlqg2UpXXgBTH5mtPeiKJIgwX0L
         4eyw==
X-Gm-Message-State: AO0yUKVfKLy7jtTPDWZmOThhYf7JgZ9klf6aoTMGeWAlz6ghsXW+4Z63
        pfNb9mwfiBnRfsRvJoJHeFRFGLXu5SmL
X-Google-Smtp-Source: AK7set8yN+kBbD9ri+YxCMZN5KWjv18FQjaq/9X1tHGt8jIhLEZWXlDKUsXy15DHn+Gq5dx+2iMz3JjgRtb3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:291:b0:9a0:1d7b:707b with SMTP id
 v17-20020a056902029100b009a01d7b707bmr49325ybh.4.1676799268239; Sun, 19 Feb
 2023 01:34:28 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:36 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-40-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 39/51] perf stat: Add TopdownL1 metric as a default if present
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are no events and on Intel, the topdown events will be
added by default if present. To display the metrics associated with
these request special handling in stat-shadow.c. To more easily update
these metrics use the json metric version via the TopdownL1
group. This makes the handling less platform specific.

Modify the metricgroup__has_metric code to also cover metric groups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c  |  6 +++---
 tools/perf/arch/x86/util/topdown.c | 30 ------------------------------
 tools/perf/arch/x86/util/topdown.h |  1 -
 tools/perf/builtin-stat.c          | 14 ++++++++++++++
 tools/perf/util/metricgroup.c      |  6 ++----
 5 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/e=
vlist.c
index cb59ce9b9638..8a7ae4162563 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -59,10 +59,10 @@ int arch_evlist__add_default_attrs(struct evlist *evlis=
t,
 				   struct perf_event_attr *attrs,
 				   size_t nr_attrs)
 {
-	if (nr_attrs)
-		return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
+	if (!nr_attrs)
+		return 0;
=20
-	return topdown_parse_events(evlist);
+	return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
 }
=20
 struct evsel *arch_evlist__leader(struct list_head *list)
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/=
topdown.c
index 54810f9acd6f..eb3a7d9652ab 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -9,11 +9,6 @@
 #include "topdown.h"
 #include "evsel.h"
=20
-#define TOPDOWN_L1_EVENTS       "{slots,topdown-retiring,topdown-bad-spec,=
topdown-fe-bound,topdown-be-bound}"
-#define TOPDOWN_L1_EVENTS_CORE  "{slots,cpu_core/topdown-retiring/,cpu_cor=
e/topdown-bad-spec/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bound/}"
-#define TOPDOWN_L2_EVENTS       "{slots,topdown-retiring,topdown-bad-spec,=
topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,t=
opdown-fetch-lat,topdown-mem-bound}"
-#define TOPDOWN_L2_EVENTS_CORE  "{slots,cpu_core/topdown-retiring/,cpu_cor=
e/topdown-bad-spec/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bound/,c=
pu_core/topdown-heavy-ops/,cpu_core/topdown-br-mispredict/,cpu_core/topdown=
-fetch-lat/,cpu_core/topdown-mem-bound/}"
-
 /* Check whether there is a PMU which supports the perf metrics. */
 bool topdown_sys_has_perf_metrics(void)
 {
@@ -99,28 +94,3 @@ const char *arch_get_topdown_pmu_name(struct evlist *evl=
ist, bool warn)
=20
 	return pmu_name;
 }
-
-int topdown_parse_events(struct evlist *evlist)
-{
-	const char *topdown_events;
-	const char *pmu_name;
-
-	if (!topdown_sys_has_perf_metrics())
-		return 0;
-
-	pmu_name =3D arch_get_topdown_pmu_name(evlist, false);
-
-	if (pmu_have_event(pmu_name, "topdown-heavy-ops")) {
-		if (!strcmp(pmu_name, "cpu_core"))
-			topdown_events =3D TOPDOWN_L2_EVENTS_CORE;
-		else
-			topdown_events =3D TOPDOWN_L2_EVENTS;
-	} else {
-		if (!strcmp(pmu_name, "cpu_core"))
-			topdown_events =3D TOPDOWN_L1_EVENTS_CORE;
-		else
-			topdown_events =3D TOPDOWN_L1_EVENTS;
-	}
-
-	return parse_event(evlist, topdown_events);
-}
diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/=
topdown.h
index 7eb81f042838..46bf9273e572 100644
--- a/tools/perf/arch/x86/util/topdown.h
+++ b/tools/perf/arch/x86/util/topdown.h
@@ -3,6 +3,5 @@
 #define _TOPDOWN_H 1
=20
 bool topdown_sys_has_perf_metrics(void);
-int topdown_parse_events(struct evlist *evlist);
=20
 #endif
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5e13171a7bba..796e98e453f6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1996,6 +1996,7 @@ static int add_default_attributes(void)
 		stat_config.topdown_level =3D TOPDOWN_MAX_LEVEL;
=20
 	if (!evsel_list->core.nr_entries) {
+		/* No events so add defaults. */
 		if (target__has_cpu(&target))
 			default_attrs0[0].config =3D PERF_COUNT_SW_CPU_CLOCK;
=20
@@ -2011,6 +2012,19 @@ static int add_default_attributes(void)
 		}
 		if (evlist__add_default_attrs(evsel_list, default_attrs1) < 0)
 			return -1;
+		/*
+		 * Add TopdownL1 metrics if they exist. To minimize
+		 * multiplexing, don't request threshold computation.
+		 */
+		if (metricgroup__has_metric("TopdownL1") &&
+		    metricgroup__parse_groups(evsel_list, "TopdownL1",
+					    /*metric_no_group=3D*/false,
+					    /*metric_no_merge=3D*/false,
+					    /*metric_no_threshold=3D*/true,
+					    stat_config.user_requested_cpu_list,
+					    stat_config.system_wide,
+					    &stat_config.metric_events) < 0)
+			return -1;
 		/* Platform specific attrs */
 		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
 			return -1;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index afb6f2fdc24e..64a35f2787dc 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1647,10 +1647,8 @@ static int metricgroup__has_metric_callback(const st=
ruct pmu_metric *pm,
 {
 	const char *metric =3D vdata;
=20
-	if (!pm->metric_expr)
-		return 0;
-
-	if (match_metric(pm->metric_name, metric))
+	if (match_metric(pm->metric_name, metric) ||
+	    match_metric(pm->metric_group, metric))
 		return 1;
=20
 	return 0;
--=20
2.39.2.637.g21b0678d19-goog

