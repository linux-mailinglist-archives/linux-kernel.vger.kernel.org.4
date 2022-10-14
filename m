Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4435FE8CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJNGQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJNGQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459017400;
        Thu, 13 Oct 2022 23:16:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d10so4021200pfh.6;
        Thu, 13 Oct 2022 23:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O82+8QMAp8RP+N1H707IzqXEjvaKP67GyMX407VeP1E=;
        b=UjyPEgCV/P4txxO8/7n0vXdf68rbMK9RCtZgyHbQegC7UZ2kGXIdQQjenFFTVQO1Sf
         8SEMep9jfVxs9De7toZJTP2IbShr6e9YhUK8MiPCv6NnYvqARaSn6INvjq/BSq35Z4xJ
         3+5Mh8YGJP4N5oWVuwbHaWzHxaUcX1jVZfwGGErMj0/kJ5IGX8UEoo7xKT5Hrv81Ab8x
         ARFSsZQCd4JwYFE/Zi/RoR0apsTWn+0JISeP5QVm7zT4AAgR0L+Fu0hxwZHJ5UUp2EJy
         tSh9V/c5Dcq4YhlMYAEywr5WGe2L0SFksWsqGcPoi9tzzFtP8lJ2G6OvYKtHUe2STDlP
         tCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O82+8QMAp8RP+N1H707IzqXEjvaKP67GyMX407VeP1E=;
        b=fhazD90KAX8yRVQVdSAaEseiROSuaaOLDxMtPM1ysYiITJ9atFeA6X2SWEUCxmHjC6
         tQCyShoOe5HVw9mf69dlSEpZbvythQ90DD2gThAJsQCed8YpOHVs8uSUKY9A8ZDPZ1SH
         T3viPYeiKOJaOPzv82Sw2fEmkGlujEsxSTY7uj0zSiXjS9ZF00H7KObecjT4dDHB7at2
         w/y6VonLrkWoYGNNZ+K2eArXjdwmp5mpf0DTfagkH85BH3oxG73KMsikNmCQgxPPo3F2
         CwGxIt6fBuVS/qOMoKjh8luOealwYBzW3bzRMdWy1UHCtl9kWOe9PMSAKXs/MsInUy9k
         3KTg==
X-Gm-Message-State: ACrzQf2IQ6ECfHT+eVuIDsjSmqvH/WfqCjzcid7QqzgbXnHZKwmA7xsC
        Yogdlf8pWi6qESXcoqB3+tA=
X-Google-Smtp-Source: AMsMyM7XbceeTZ+jKUwhfRwj0XHF4nLQm0SsYQiyF1srKkFEh3lg4khswlm1gpGEwZkUD771Dek1pA==
X-Received: by 2002:a63:5415:0:b0:439:e932:e025 with SMTP id i21-20020a635415000000b00439e932e025mr3177531pgb.63.1665728163957;
        Thu, 13 Oct 2022 23:16:03 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:03 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 07/19] perf stat: Add struct perf_stat_aggr to perf_stat_evsel
Date:   Thu, 13 Oct 2022 23:15:38 -0700
Message-Id: <20221014061550.463644-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014061550.463644-1-namhyung@kernel.org>
References: <20221014061550.463644-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf_stat_aggr struct is to keep aggregated counter values and the
states according to the aggregation mode.  The number of entries is
depends on the mode and this is a preparation for the later use.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat.c | 34 +++++++++++++++++++++++++++-------
 tools/perf/util/stat.h | 19 +++++++++++++++++++
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 8ec8bb4a9912..c9d5aa295b54 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -133,15 +133,33 @@ static void perf_stat_evsel_id_init(struct evsel *evsel)
 static void evsel__reset_stat_priv(struct evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
+	struct perf_stat_aggr *aggr = ps->aggr;
 
 	init_stats(&ps->res_stats);
+
+	if (aggr)
+		memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
 }
 
-static int evsel__alloc_stat_priv(struct evsel *evsel)
+
+static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
 {
-	evsel->stats = zalloc(sizeof(struct perf_stat_evsel));
-	if (evsel->stats == NULL)
+	struct perf_stat_evsel *ps;
+
+	ps = zalloc(sizeof(*ps));
+	if (ps == NULL)
 		return -ENOMEM;
+
+	if (nr_aggr) {
+		ps->nr_aggr = nr_aggr;
+		ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
+		if (ps->aggr == NULL) {
+			free(ps);
+			return -ENOMEM;
+		}
+	}
+
+	evsel->stats = ps;
 	perf_stat_evsel_id_init(evsel);
 	evsel__reset_stat_priv(evsel);
 	return 0;
@@ -151,8 +169,10 @@ static void evsel__free_stat_priv(struct evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
 
-	if (ps)
+	if (ps) {
+		zfree(&ps->aggr);
 		zfree(&ps->group_data);
+	}
 	zfree(&evsel->stats);
 }
 
@@ -181,9 +201,9 @@ static void evsel__reset_prev_raw_counts(struct evsel *evsel)
 		perf_counts__reset(evsel->prev_raw_counts);
 }
 
-static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
+static int evsel__alloc_stats(struct evsel *evsel, int nr_aggr, bool alloc_raw)
 {
-	if (evsel__alloc_stat_priv(evsel) < 0 ||
+	if (evsel__alloc_stat_priv(evsel, nr_aggr) < 0 ||
 	    evsel__alloc_counts(evsel) < 0 ||
 	    (alloc_raw && evsel__alloc_prev_raw_counts(evsel) < 0))
 		return -ENOMEM;
@@ -196,7 +216,7 @@ int evlist__alloc_stats(struct evlist *evlist, bool alloc_raw)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__alloc_stats(evsel, alloc_raw))
+		if (evsel__alloc_stats(evsel, 0, alloc_raw))
 			goto out_free;
 	}
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b0899c6e002f..42453513ffea 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -8,6 +8,7 @@
 #include <sys/resource.h>
 #include "cpumap.h"
 #include "rblist.h"
+#include "counts.h"
 
 struct perf_cpu_map;
 struct perf_stat_config;
@@ -42,9 +43,27 @@ enum perf_stat_evsel_id {
 	PERF_STAT_EVSEL_ID__MAX,
 };
 
+/* hold aggregated event info */
+struct perf_stat_aggr {
+	/* aggregated values */
+	struct perf_counts_values	counts;
+	/* number of entries (CPUs) aggregated */
+	int				nr;
+	/* whether any entry has failed to read/process event */
+	bool				failed;
+};
+
+/* per-evsel event stats */
 struct perf_stat_evsel {
+	/* used for repeated runs */
 	struct stats		 res_stats;
+	/* evsel id for quick check */
 	enum perf_stat_evsel_id	 id;
+	/* number of allocated 'aggr' */
+	int			 nr_aggr;
+	/* aggregated event values */
+	struct perf_stat_aggr	*aggr;
+	/* used for group read */
 	u64			*group_data;
 };
 
-- 
2.38.0.413.g74048e4d9e-goog

