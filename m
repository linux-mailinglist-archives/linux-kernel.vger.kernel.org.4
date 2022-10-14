Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513995FE8CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJNGRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJNGQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:23 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955601743A;
        Thu, 13 Oct 2022 23:16:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i3so3998961pfk.9;
        Thu, 13 Oct 2022 23:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lynXu2I6TliNPQCV9P5RsT9ATOJ+ZfidVJk5ANgD79M=;
        b=OYcmKu3kjB3HvGxuTTwLuam6FSSjVCZuSV6oKOoPqnGeJbykKHx5NC+IBUHAmHscaf
         dyrVG9ZkDvJZj0pPeh9n7UuFsY0ZXwZrvTU1dmbqOUEcR6XvmXIg7dZMiZLI1mDrDV6a
         ziASt0nvhqdbWBTkHkn+Krs5DDs/xRVbt8NUB8pKUgeNghMOtBnYWV45baqFXQutLZ98
         m8DVfYo22kcKvfAF5Tb8zVbm4UHXsUhjW3aC+f+z4hi1v6CRJY9BcCa27nKiM/QxGXKd
         +1oUpmETzJvSBz5TErsy5/ASZo/+5oRa19A9Swx6dgR43/Y+Le3X2FMFtWahQgN1B2Uf
         g2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lynXu2I6TliNPQCV9P5RsT9ATOJ+ZfidVJk5ANgD79M=;
        b=FFYOFuTUJhc88GOvjHnLBzpRwcVAh3rLE6NMDO1mmlUUIbr2fkA6v9fzOQh+BkOQ2v
         1ua1sxNMhCOPNIE8CHl4/JRMVN25/hF/hitxZa3/9W71uovkut+bgi9RQB/Bu7QD/Tya
         f1hSc8xFNfUNmPq7Fv7LqjPZchNRrOE+tUKmlFzMF8iJAMCRqGh0VgMkl8wMihwWgx2O
         jE2M0XzAfvcIQ/ie6wCQWDGi+piH+Z8RGdp+pE2yV/JzMntd2FACLO5ol5ZtqIVPzJJW
         Z6SieVCDAIrTRSteLbY7MPg3oQjo1bw2y7tI++09CMSEVw4rwBqqcJ5o/fCr3kZOm/DR
         xtmQ==
X-Gm-Message-State: ACrzQf0idYlPKbvKowZqADAXf+2VVjZsQ6CTztgxDTXwfDMfbgYZIMqn
        YnvnQUNHDGFFOiAOgt4b9y0=
X-Google-Smtp-Source: AMsMyM7n6DryhoO4e47NQWnKFZIpDRJJS3ZUJ73nfmsCD1LRrD7NpC7bdInL/c8jRdKi6eVPQWfUQw==
X-Received: by 2002:a63:1750:0:b0:43a:9392:2676 with SMTP id 16-20020a631750000000b0043a93922676mr3221273pgx.463.1665728172135;
        Thu, 13 Oct 2022 23:16:12 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:11 -0700 (PDT)
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
Subject: [PATCH 12/19] perf stat: Reset aggr counts for each interval
Date:   Thu, 13 Oct 2022 23:15:43 -0700
Message-Id: <20221014061550.463644-13-namhyung@kernel.org>
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

The evsel->stats->aggr->count should be reset for interval processing
since we want to use the values directly for display.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  3 +++
 tools/perf/util/stat.c    | 20 +++++++++++++++++---
 tools/perf/util/stat.h    |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2a6a5d0c5563..bff28a199dfd 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -492,6 +492,8 @@ static void process_interval(void)
 	diff_timespec(&rs, &ts, &ref_time);
 
 	perf_stat__reset_shadow_per_stat(&rt_stat);
+	evlist__reset_aggr_stats(evsel_list);
+
 	read_counters(&rs);
 
 	if (STAT_RECORD) {
@@ -965,6 +967,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		evlist__copy_prev_raw_counts(evsel_list);
 		evlist__reset_prev_raw_counts(evsel_list);
+		evlist__reset_aggr_stats(evsel_list);
 		perf_stat__reset_shadow_per_stat(&rt_stat);
 	} else {
 		update_stats(&walltime_nsecs_stats, t1 - t0);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index d0e5c4c402aa..847481cc3d5a 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -130,17 +130,23 @@ static void perf_stat_evsel_id_init(struct evsel *evsel)
 	}
 }
 
-static void evsel__reset_stat_priv(struct evsel *evsel)
+static void evsel__reset_aggr_stats(struct evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
 	struct perf_stat_aggr *aggr = ps->aggr;
 
-	init_stats(&ps->res_stats);
-
 	if (aggr)
 		memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
 }
 
+static void evsel__reset_stat_priv(struct evsel *evsel)
+{
+	struct perf_stat_evsel *ps = evsel->stats;
+
+	init_stats(&ps->res_stats);
+	evsel__reset_aggr_stats(evsel);
+}
+
 static int evsel__alloc_aggr_stats(struct evsel *evsel, int nr_aggr)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
@@ -276,6 +282,14 @@ void evlist__reset_stats(struct evlist *evlist)
 	}
 }
 
+void evlist__reset_aggr_stats(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel__reset_aggr_stats(evsel);
+}
+
 void evlist__reset_prev_raw_counts(struct evlist *evlist)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 4c00f814bd79..809f9f0aff0c 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -276,6 +276,7 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist);
 void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
 
 int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
+void evlist__reset_aggr_stats(struct evlist *evlist);
 
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
-- 
2.38.0.413.g74048e4d9e-goog

