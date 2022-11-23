Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED5E636834
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiKWSEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239297AbiKWSCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:25 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEA99371F;
        Wed, 23 Nov 2022 10:02:24 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 136so17438688pga.1;
        Wed, 23 Nov 2022 10:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVc+cia53gYtJDOA2aNz2UfR6QciW5fvjNYuKXlTXq4=;
        b=CVU4aHfH1HjPYDPbgIAAAamraN9t24VDNKqRMivTDypso3RSvXpqA3MFB9n+mCtog5
         pijZ5QdJRp87JBFrf3Ww6F0AdPdDUDr9XlrICyukYBt+leeGh+llI2CUk96OjdUXMfor
         muKQ3M3l7WA2qLfztGoxphabOD3XeIwhwndqtdgvK93WJrwC5R4WAeVCE8MT6ZUluWc/
         j412ZWOTU4++8uCJgkV7FKFjzaHuQZHEHyCW36vBCALmh/QegKRzWY1wYPir0Lr7b5MK
         WqbqGelDFP6+pYFJCDsP8+s+253mgjQEUO76UnfzQiWU34DBE59z+YlfevnF/+mfcd5z
         DPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gVc+cia53gYtJDOA2aNz2UfR6QciW5fvjNYuKXlTXq4=;
        b=H/8OSAF0n64w2RWUN4zEXvGKSTiQSzU9iIJm4J7zK3El/ZHeUYq5rcNgxbMRIf/HUp
         ydVcMJbvbcV4+LlTkacWvVgQjpuvOtEwbX/84n54q7FqFTue5ZswpilmJiRc+Oheei5a
         BNmyo9ltaSoRck7+zNQ/GGu0Np4lsfA7BRJWof/Sg+iXDCDcHkFOwHuNxIp1xfSlFbIa
         uVWAFEqh0z09Gpk4vnUGgvbtHvce2U85K3f7rqMBu36xCNLiij89eY0xor+mMjag+c0z
         SmuQHrA22W+OrsmpU1YB9MpOxZWPLxx6mAR2AkgwWbI5z/lQnic2q5sAiYjYeSIFT4fZ
         BJVg==
X-Gm-Message-State: ANoB5pmfOZzOaxc7TskGKJi9RfxLNqdPXJOuW5JlGmjYr8x5DiE3Ey1G
        X4QPIHHJ27PSYTqrHMfLw0h8zhRenZs=
X-Google-Smtp-Source: AA0mqf4HmRUlXMmLaZi9evey93jcM7NtYVq3CFuyp+i43mDPgNK6io5x7SwIPTbdfFLTGwxnTF5KQg==
X-Received: by 2002:a65:638a:0:b0:46f:1261:ab62 with SMTP id h10-20020a65638a000000b0046f1261ab62mr10227094pgv.414.1669226543726;
        Wed, 23 Nov 2022 10:02:23 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:23 -0800 (PST)
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 09/15] perf stat: Pass struct outstate to print_metric_begin()
Date:   Wed, 23 Nov 2022 10:02:02 -0800
Message-Id: <20221123180208.2068936-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123180208.2068936-1-namhyung@kernel.org>
References: <20221123180208.2068936-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It passes prefix and cgroup pointers but the outstate already has them.
Let's pass the outstate pointer instead.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 50 +++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 70aebf359e16..3ed63061d6f8 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -843,8 +843,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 
 static void print_metric_begin(struct perf_stat_config *config,
 			       struct evlist *evlist,
-			       const char *prefix, int aggr_idx,
-			       struct cgroup *cgrp)
+			       struct outstate *os, int aggr_idx)
 {
 	struct perf_stat_aggr *aggr;
 	struct aggr_cpu_id id;
@@ -853,15 +852,15 @@ static void print_metric_begin(struct perf_stat_config *config,
 	if (!config->metric_only)
 		return;
 
-	if (prefix)
-		fprintf(config->output, "%s", prefix);
+	if (os->prefix)
+		fprintf(config->output, "%s", os->prefix);
 
 	evsel = evlist__first(evlist);
 	id = config->aggr_map->map[aggr_idx];
 	aggr = &evsel->stats->aggr[aggr_idx];
 	aggr_printout(config, evsel, id, aggr->nr);
 
-	print_cgroup(config, cgrp);
+	print_cgroup(config, os->cgrp);
 }
 
 static void print_metric_end(struct perf_stat_config *config)
@@ -877,6 +876,9 @@ static void print_aggr(struct perf_stat_config *config,
 		       const char *prefix)
 {
 	struct evsel *counter;
+	struct outstate os = {
+		.prefix = prefix,
+	};
 	int s;
 
 	if (!config->aggr_map || !config->aggr_get_id)
@@ -887,7 +889,7 @@ static void print_aggr(struct perf_stat_config *config,
 	 * Without each counter has its own line.
 	 */
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		print_metric_begin(config, evlist, prefix, s, /*cgrp=*/NULL);
+		print_metric_begin(config, evlist, &os, s);
 
 		evlist__for_each_entry(evlist, counter) {
 			if (counter->merged_stat)
@@ -904,26 +906,28 @@ static void print_aggr_cgroup(struct perf_stat_config *config,
 			      const char *prefix)
 {
 	struct evsel *counter, *evsel;
-	struct cgroup *cgrp = NULL;
+	struct outstate os = {
+		.prefix = prefix,
+	};
 	int s;
 
 	if (!config->aggr_map || !config->aggr_get_id)
 		return;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (cgrp == evsel->cgrp)
+		if (os.cgrp == evsel->cgrp)
 			continue;
 
-		cgrp = evsel->cgrp;
+		os.cgrp = evsel->cgrp;
 
 		for (s = 0; s < config->aggr_map->nr; s++) {
-			print_metric_begin(config, evlist, prefix, s, cgrp);
+			print_metric_begin(config, evlist, &os, s);
 
 			evlist__for_each_entry(evlist, counter) {
 				if (counter->merged_stat)
 					continue;
 
-				if (counter->cgrp != cgrp)
+				if (counter->cgrp != os.cgrp)
 					continue;
 
 				print_counter_aggrdata(config, counter, s, prefix);
@@ -956,6 +960,9 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 {
 	int all_idx;
 	struct perf_cpu cpu;
+	struct outstate os = {
+		.prefix = prefix,
+	};
 
 	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.user_requested_cpus) {
 		struct evsel *counter;
@@ -973,8 +980,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 
 			id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
-				print_metric_begin(config, evlist, prefix,
-						   counter_idx, /*cgrp=*/NULL);
+				print_metric_begin(config, evlist, &os, counter_idx);
 				first = false;
 			}
 			val = ps->aggr[counter_idx].counts.val;
@@ -1347,22 +1353,23 @@ static void print_percore(struct perf_stat_config *config,
 static void print_cgroup_counter(struct perf_stat_config *config, struct evlist *evlist,
 				 const char *prefix)
 {
-	struct cgroup *cgrp = NULL;
 	struct evsel *counter;
+	struct outstate os = {
+		.prefix = prefix,
+	};
 
 	evlist__for_each_entry(evlist, counter) {
-		if (cgrp != counter->cgrp) {
-			if (cgrp != NULL)
+		if (os.cgrp != counter->cgrp) {
+			if (os.cgrp != NULL)
 				print_metric_end(config);
 
-			cgrp = counter->cgrp;
-			print_metric_begin(config, evlist, prefix,
-					   /*aggr_idx=*/0, cgrp);
+			os.cgrp = counter->cgrp;
+			print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
 		}
 
 		print_counter(config, counter, prefix);
 	}
-	if (cgrp)
+	if (os.cgrp)
 		print_metric_end(config);
 }
 
@@ -1405,8 +1412,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		} else if (config->cgroup_list) {
 			print_cgroup_counter(config, evlist, os.prefix);
 		} else {
-			print_metric_begin(config, evlist, os.prefix,
-					   /*aggr_idx=*/0, /*cgrp=*/NULL);
+			print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
 			evlist__for_each_entry(evlist, counter) {
 				print_counter(config, counter, os.prefix);
 			}
-- 
2.38.1.584.g0f3c55d4c2-goog

