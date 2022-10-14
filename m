Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1895E5FE8D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJNGRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJNGQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DED17415;
        Thu, 13 Oct 2022 23:16:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so3890440pjf.5;
        Thu, 13 Oct 2022 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUdiNdtmy8zezeJc09AIdo+G0m43f1JOi1LO86Cu4bw=;
        b=AWLUkGA9ohhywgSiERCKEGD5fX0bBMA7Ie+PjnLZa6ISduMl4XH2odZ8/fu2letm3Q
         Z0fZbRfh94hey4ASPoZFXaY3kVQ2GOopBjGF/eDIlgkE46BTUVx7xZYuzbKxTMi0zecb
         6pj7idlKrIRrg3TGf/fd2FiVikQ92Pu6gguCKAAo1lO3yJ9pw5xq+iJkuv/aeXiNubGH
         prYHwRbXzfflWapFPywjtVOmFHgZUugA7Z6DTemYOgHKuCqHEIeQ/mrLEcSp3fMSOGbR
         j0uoYtBvqjyEbv8hCRudwiHI+bQrFXygTLyG6SXQ0+ACP1cdH/V1qXtzQvG699scM49r
         sGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qUdiNdtmy8zezeJc09AIdo+G0m43f1JOi1LO86Cu4bw=;
        b=XRgYiN7CJ+pgVWfDubT44pBK8rulQWAxjlTLD1pzDVbWemQf5LHIjHt9U2q75+t4oV
         t6Odaa0fos7bzgiJQII5onxiEaZdoonLFpyEa05XMquOUucKb2hdbq6MIr4jFCZLbtRf
         r576lax6rpERjhyITKxB24PN4yUPtNZOJ8QZk2RhDdZvGEWUXCu0Uho2GFIjQKGQuvkd
         P9HZlDjMAtsfRpkFlwmzvoHL6qKPnji2rgNV10oFr9XDrhlV49NR6knZVwA7wtroqu/D
         Y0F1QW9vBGiduWNkPDKkQBZolfmhr31rI3LZDBjnhl+Ck9fDt3xYmgZjEInDDOofnNZo
         NUVw==
X-Gm-Message-State: ACrzQf14X8rTmMUkecMyqmCRvuh09jA1oMC+y1s8fkzBurK3bA5kk3HH
        SeG9uIuB+dv6QyQX8sfwvn96TF+8Ss8=
X-Google-Smtp-Source: AMsMyM4ptG2himLhYYhqOpEAyfq0eNISZA22UYD1RBvbRWzYQR4tpSTUSqBN8terppJ29v3VCDgubQ==
X-Received: by 2002:a17:90b:4ac5:b0:20d:ae54:f08b with SMTP id mh5-20020a17090b4ac500b0020dae54f08bmr5709548pjb.174.1665728176900;
        Thu, 13 Oct 2022 23:16:16 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:16 -0700 (PDT)
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
Date:   Thu, 13 Oct 2022 23:15:46 -0700
Message-Id: <20221014061550.463644-16-namhyung@kernel.org>
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
index 877107f5a820..4ce457c94898 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -673,6 +673,77 @@ void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *ev
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

