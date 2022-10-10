Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124F65F97E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiJJFh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiJJFgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE1D52DF9;
        Sun,  9 Oct 2022 22:36:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b15so9002596pje.1;
        Sun, 09 Oct 2022 22:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzN3/Jp27IGH3bxP/WkyQ0M8l72rBBWZ6h1uVvahk+o=;
        b=CP5oxA2RWTij7e34DbaOUGkn4omtv8fr3lW8sMvpUAe2Vp3i3Kmhfd2J+qcTFZK6Qs
         eMBy2Ix6GgW59/p4qLfClzN88adPjr1bulgDgUw3Hwd/5XhcNZMoRboS02h08P016xeA
         5o9bjMqWC+ESVoRm1Ww2eJiE3gaVCsiAzLVkLlTNTKqWdsW7s2wsp++Fs+xLAlJkm35q
         qk1Hfqzzla5HbQ/P+1tliJl5cG/TxFZ4qvWj7VLsbTsUReRQAqRVQbMUOqtvvIFLrgFG
         RbsU8uzLZFEjONQAadJmMeBCFG4k60eiF2Qovjl9dbqyTm7iMxYFuoCslkG9QYrTFDTm
         Uz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzN3/Jp27IGH3bxP/WkyQ0M8l72rBBWZ6h1uVvahk+o=;
        b=EXaNa46VyR6wpOSCjq5yltQLUCr/qPVBnVDTFy9p3Y36uC6DGCG8NqEAUE3/xff7Qd
         +u3oCLR755URTPVTad1sdDXnfnKlSIIAbFC1cn6Snt25J8iV0/JzJXKN+rxpSrj79dJX
         twdPHDbywtMVmaka1ojH6xFT/Knl53+dpmyTE4mZnAz2Xb7pSw6Zo27a+AFKkwLDz/Ib
         BfNXhTN8eDq/63ynrXIT9mOLvKW1JaymxpCzhP6sZrxpUuqkSkeAjjSx0jIc12lJgRuo
         ZwUpUXeIocBoJklVPLJxQFugnLBPHbAIQySE7fligrzNmyzMiTQChI9GtiulZAhDI1hf
         4IHQ==
X-Gm-Message-State: ACrzQf3lXW3q1YKX7sh9Q4UcCgv4bx55Jru3Rr2TXsn/5FuUirayGthc
        0CwMNj6Kyw0rJ3hfK9vKRFE=
X-Google-Smtp-Source: AMsMyM4rt0TzEwk2ymxCYoKDTBhfbS2Y7a23wkgcd6zdka/Tc9I4es8nBHu3ExC8Ai8h1mUm65t7Cg==
X-Received: by 2002:a17:902:dac4:b0:178:2a6f:bc7f with SMTP id q4-20020a170902dac400b001782a6fbc7fmr18225612plx.129.1665380185137;
        Sun, 09 Oct 2022 22:36:25 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:24 -0700 (PDT)
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
Subject: [PATCH 15/19] perf stat: Add perf_stat_process_percore()
Date:   Sun,  9 Oct 2022 22:35:56 -0700
Message-Id: <20221010053600.272854-16-namhyung@kernel.org>
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

The perf_stat_process_percore() is to aggregate counts for an event per-core
even if the aggr_mode is AGGR_NONE.  This is enabled when user requested it
on the command line.

To handle that, it keeps the per-cpu counts at first.  And then it aggregates
the counts that have the same core id in the aggr->counts and updates the
values for each cpu back.

Later, per-core events will skip one of the CPUs unless percore-show-thread
option is given.  In that case, it can simply print all cpu stats with the
updated (per-core) values.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  1 +
 tools/perf/util/stat.c    | 71 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.h    |  2 ++
 3 files changed, 74 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f90e8f29cb23..c127e784a7be 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -488,6 +488,7 @@ static void process_counters(void)
 	}
 
 	perf_stat_merge_counters(&stat_config, evsel_list);
+	perf_stat_process_percore(&stat_config, evsel_list);
 }
 
 static void process_interval(void)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 1bb197782a34..d788d0e85204 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -671,6 +671,77 @@ void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *ev
 		evsel__merge_stats(evsel, config);
 }
 
+static void evsel__update_percore_stats(struct evsel *evsel, struct aggr_cpu_id *core_id)
+{
+	struct perf_stat_evsel *ps = evsel->stats;
+	struct perf_counts_values counts = { 0, };
+	struct aggr_cpu_id id;
+	struct perf_cpu cpu;
+	int idx;
+
+	/* collect per-core counts */
+	perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
+		struct perf_stat_aggr *aggr = &ps->aggr[idx];
+
+		id = aggr_cpu_id__core(cpu, NULL);
+		if (!aggr_cpu_id__equal(core_id, &id))
+			continue;
+
+		counts.val += aggr->counts.val;
+		counts.ena += aggr->counts.ena;
+		counts.run += aggr->counts.run;
+	}
+
+	/* update aggregated per-core counts for each CPU */
+	perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
+		struct perf_stat_aggr *aggr = &ps->aggr[idx];
+
+		id = aggr_cpu_id__core(cpu, NULL);
+		if (!aggr_cpu_id__equal(core_id, &id))
+			continue;
+
+		aggr->counts.val = counts.val;
+		aggr->counts.ena = counts.ena;
+		aggr->counts.run = counts.run;
+
+		aggr->used = true;
+	}
+}
+
+/* we have an aggr_map for cpu, but want to aggregate the counters per-core */
+static void evsel__process_percore(struct evsel *evsel)
+{
+	struct perf_stat_evsel *ps = evsel->stats;
+	struct aggr_cpu_id core_id;
+	struct perf_cpu cpu;
+	int idx;
+
+	if (!evsel->percore)
+		return;
+
+	perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
+		struct perf_stat_aggr *aggr = &ps->aggr[idx];
+
+		if (aggr->used)
+			continue;
+
+		core_id = aggr_cpu_id__core(cpu, NULL);
+		evsel__update_percore_stats(evsel, &core_id);
+	}
+}
+
+/* process cpu stats on per-core events */
+void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	if (config->aggr_mode != AGGR_NONE)
+		return;
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel__process_percore(evsel);
+}
+
 int perf_event__process_stat_event(struct perf_session *session,
 				   union perf_event *event)
 {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 12cc60ab04e4..ac85ed46aa59 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -46,6 +46,7 @@ enum perf_stat_evsel_id {
 struct perf_stat_aggr {
 	struct perf_counts_values	counts;
 	int				nr;
+	bool				used;
 	bool				failed;
 };
 
@@ -271,6 +272,7 @@ void evlist__reset_aggr_stats(struct evlist *evlist);
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
 void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
+void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist);
 
 struct perf_tool;
 union perf_event;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

