Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3316020D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiJRCEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiJRCD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:03:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F08E442;
        Mon, 17 Oct 2022 19:03:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f23so12468857plr.6;
        Mon, 17 Oct 2022 19:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WeyysPuKEEsCMTvHH/EnyiCA29OXlA8FDxwFK62GCs=;
        b=KRmnk0Cin866fAIogyaUmmnovwsXbKtc/TjuQIWfi74mXqm5PptxVE632JUaH0zqHe
         30EYPit+oFi+SljqTPGi+wyvEfxdeC8wKCu250FEGchTM2j36jmx0q/Uej6MaXqA44Sj
         k1Qz2ZX9Sl4OnWdA72iNm78iV7X+zP1EEIQN+nnl0Yicbfy9DK7BqU3E3dwor3GWwSXe
         Yz/WrE7DkqswVhA3FHMIBne/XLqexT1Re069qgW1fI+SfzQLzPe4zNO+EYslD3ammo2C
         hJQAGVdCktBFfHzNIezjBsUkIN1Y3sC73szF8C38GWT8buX8mHb7OsZTXEarpdxSAW4Q
         f2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5WeyysPuKEEsCMTvHH/EnyiCA29OXlA8FDxwFK62GCs=;
        b=W+/0vBmjPM8rLt8f6dY3QZruagyVUyl5h0ghHEfFYuyErNHgHYiKK3e/E6nL7NZoXJ
         YbUWQLywe6ZWpSMFYTccweZOsPH2TXSAMfH4SAiV5nHNSEhOQ6CaiPHhBsARhTJPOkTr
         2ErmzObTmF7QvNHe2R8l2aASgYxhzHSsjz7jQos0mGn75Rhd9HIoJofaHhJHJ0qdVEva
         TJt24B7wOwyvHiVBbq4i5IrMngP70oo18gFc7ax+QOdtrJZLVZG6ryWa+M5cNgudjCKc
         nEtBaswCK0oI7bvNIWj+KJUv5Rvl+eTtxhXDjHcz5KVCom83ppgytJHhGYWclERkPmDU
         0d/A==
X-Gm-Message-State: ACrzQf04oN5LvOv/n+EUN1d/OBFpmX3qrOzZoOf5P21XlYUcpH5AW8mW
        N8upWoYV/7tvY5UrCi+O8D0=
X-Google-Smtp-Source: AMsMyM4ZRwvEgnNFC653dnUjOty4j1q5/oyDXn2iPXP9q0GCsS+KJ5kx58/qjTsaiyseuKUA0swEbw==
X-Received: by 2002:a17:90b:4f4d:b0:20d:a08e:3876 with SMTP id pj13-20020a17090b4f4d00b0020da08e3876mr30792974pjb.0.1666058579341;
        Mon, 17 Oct 2022 19:02:59 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:59 -0700 (PDT)
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 16/20] perf stat: Add perf_stat_process_percore()
Date:   Mon, 17 Oct 2022 19:02:23 -0700
Message-Id: <20221018020227.85905-17-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018020227.85905-1-namhyung@kernel.org>
References: <20221018020227.85905-1-namhyung@kernel.org>
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
 tools/perf/util/stat.h    |  3 ++
 3 files changed, 75 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 371d6e896942..d6a006e41da0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -488,6 +488,7 @@ static void process_counters(void)
 	}
 
 	perf_stat_merge_counters(&stat_config, evsel_list);
+	perf_stat_process_percore(&stat_config, evsel_list);
 }
 
 static void process_interval(void)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index aff1e7390585..26c48ef7ca92 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -691,6 +691,77 @@ void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *ev
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
index 728bbc823b0d..d23f8743e442 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -51,6 +51,8 @@ struct perf_stat_aggr {
 	int				nr;
 	/* whether any entry has failed to read/process event */
 	bool				failed;
+	/* to mark this data is processed already */
+	bool				used;
 };
 
 /* per-evsel event stats */
@@ -281,6 +283,7 @@ void evlist__reset_aggr_stats(struct evlist *evlist);
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
 void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
+void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist);
 
 struct perf_tool;
 union perf_event;
-- 
2.38.0.413.g74048e4d9e-goog

