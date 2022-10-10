Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1815F97E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJJFhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiJJFgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ACE52DFE;
        Sun,  9 Oct 2022 22:36:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 70so8971006pjo.4;
        Sun, 09 Oct 2022 22:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX5y0ikZAYW5Bpjhz7zWhzB3ocG6z5CCRYX/NNZXFqk=;
        b=de8NgJKNG/Yczz2o4tiR66Sxg+06ca7DvGQmJdRKNDSJbwxLsuhDJhvT7w07OUaBPz
         tQmWiFZydGyeVSCHzhi9SJc1FepW4k5RkRJqp6vTdeivVewZCZfdSXpPSnSfOaqWluoS
         m1z5zBXb7KoRlnrSdZ9ibrNXRw4ttLRMLaR6IrbIbb8sTLw0X5ZgCEMKvokM4k7G+6C8
         VoFus8JOTB99kVJGmbqSwDalpMmGJBvtO3REYV1RhYwX7PD3jo7lWZkp0JG9Dj6WarUP
         BXeat8uFWv2E3+qkzRI0Xfk4Au31E7QCe1lXvjtyb610p3+8RmRnBDJW3DENk6ePoA1r
         joUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GX5y0ikZAYW5Bpjhz7zWhzB3ocG6z5CCRYX/NNZXFqk=;
        b=48AoEFXz7ntEeT18IhlWDpPXsWMErdtqkeeUTLCWHEEfsgCYzgC2/zsIHL3zs5iu5a
         +cj6zJ6IMLsjISxt62ucZU+0QQXNVIAn0jEEz/PMle/LezI9SD9gc1dnZP208DH4Ji0W
         /4nkMnO+AqM632wBJX7vknGykZ+tASganYD9J7R+hzQCymzC85c/lE5Mh9wFPmsMi1L6
         uZ6lNQDldTp7NVI5f6NO3EFLJdwKa5E7KiznQD3FLZqlaABo0t9mBARBxUgGr79xBqjp
         kqzwuczqSEVsuSy8Ly6Xg70vqLsAOfJWWz9zBGWHtNYuaboT5Nhfheae0TEbAtnnbJNQ
         zFyg==
X-Gm-Message-State: ACrzQf2fPfnmGPa91OuSJbBXcjQ1ilx9Nsw5wRUOqcUTlTrFeECbgxHh
        7NNWRBCoI9qxbG7iSnFD6cE=
X-Google-Smtp-Source: AMsMyM7a6E0TCpDTolR9sp2x19rqP9jSbj4S5/lwASDJ4HpGNcoNR7JTk0YVInFSqvb7luUXOH1OIA==
X-Received: by 2002:a17:90a:8b93:b0:20a:bd84:5182 with SMTP id z19-20020a17090a8b9300b0020abd845182mr30706631pjn.161.1665380186549;
        Sun, 09 Oct 2022 22:36:26 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:26 -0700 (PDT)
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
Subject: [PATCH 16/19] perf stat: Add perf_stat_process_shadow_stats()
Date:   Sun,  9 Oct 2022 22:35:57 -0700
Message-Id: <20221010053600.272854-17-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221010053600.272854-1-namhyung@kernel.org>
References: <20221010053600.272854-1-namhyung@kernel.org>
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

This function updates the shadow stats using the aggregated counts
uniformly since it uses the aggr_counts for the every aggr mode.

It'd have duplicate shadow stats for each items for now since the
display routines will update them once again.  But that'd be fine
as it shows the average values and it'd be gone eventually.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  1 +
 tools/perf/util/stat.c    | 50 ++++++++++++++++++++-------------------
 tools/perf/util/stat.h    |  1 +
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c127e784a7be..d92815f4eae0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -489,6 +489,7 @@ static void process_counters(void)
 
 	perf_stat_merge_counters(&stat_config, evsel_list);
 	perf_stat_process_percore(&stat_config, evsel_list);
+	perf_stat_process_shadow_stats(&stat_config, evsel_list);
 }
 
 static void process_interval(void)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index d788d0e85204..f2a3761dacff 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -454,7 +454,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		aggr_counts->val += count->val;
 		aggr_counts->ena += count->ena;
 		aggr_counts->run += count->run;
-		goto update;
+		return 0;
 	}
 
 	if (ps->aggr) {
@@ -491,32 +491,10 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 	}
 
-update:
-	switch (config->aggr_mode) {
-	case AGGR_THREAD:
-	case AGGR_CORE:
-	case AGGR_DIE:
-	case AGGR_SOCKET:
-	case AGGR_NODE:
-	case AGGR_NONE:
-		if ((config->aggr_mode == AGGR_NONE) && (!evsel->percore)) {
-			perf_stat__update_shadow_stats(evsel, count->val,
-						       cpu_map_idx, &rt_stat);
-		}
-
-		if (config->aggr_mode == AGGR_THREAD) {
-			perf_stat__update_shadow_stats(evsel, count->val,
-						       thread, &rt_stat);
-		}
-		break;
-	case AGGR_GLOBAL:
+	if (config->aggr_mode == AGGR_GLOBAL) {
 		aggr->val += count->val;
 		aggr->ena += count->ena;
 		aggr->run += count->run;
-	case AGGR_UNSET:
-	case AGGR_MAX:
-	default:
-		break;
 	}
 
 	return 0;
@@ -742,6 +720,30 @@ void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *e
 		evsel__process_percore(evsel);
 }
 
+static void evsel__update_shadow_stats(struct evsel *evsel)
+{
+	struct perf_stat_evsel *ps = evsel->stats;
+	int i;
+
+	if (ps->aggr == NULL)
+		return;
+
+	for (i = 0; i < ps->nr_aggr; i++) {
+		struct perf_counts_values *aggr_counts = &ps->aggr[i].counts;
+
+		perf_stat__update_shadow_stats(evsel, aggr_counts->val, i, &rt_stat);
+	}
+}
+
+void perf_stat_process_shadow_stats(struct perf_stat_config *config __maybe_unused,
+				    struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel__update_shadow_stats(evsel);
+}
+
 int perf_event__process_stat_event(struct perf_session *session,
 				   union perf_event *event)
 {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index ac85ed46aa59..e51214918c7f 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -273,6 +273,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
 void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
 void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist);
+void perf_stat_process_shadow_stats(struct perf_stat_config *config, struct evlist *evlist);
 
 struct perf_tool;
 union perf_event;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

