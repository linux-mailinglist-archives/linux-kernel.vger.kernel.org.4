Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4DF6020CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiJRCEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiJRCDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:03:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06AA8D0FD;
        Mon, 17 Oct 2022 19:02:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g28so12746616pfk.8;
        Mon, 17 Oct 2022 19:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MimTLujqV6UiVtggvclgfKIAxzqzEE9ZfQLvshn5bEw=;
        b=DAKz5ea30SrWcT7uhN7sNcCUTQDPiWNvnXT3B+pxgwRGK4ZPDMiF4MQH7Avvi5TkfW
         Y0dWDzdlX89H7Tu8pgJTy1DO8g00o2EcqRwWT2obChtGgTk6yUl2TzItc0/5YVve8NYp
         gl65yIDzN/hzZrV2BNqyAXrGXaii2bMQbfzaIt1QTnyazX1fg1TIkykxaR7xbIfingh0
         vi13WZSbT6+nwV2GeidKRUVfgFMLk3hxep1fd44P6w7CYdpaJ5YIzNYOskRGkIiNXJg5
         clXTacZQXPyglEhu+PO+D45Iy4npiuGIdB5ViRJ+ntF8Lmtzgwm8FZM3hsZvqjLwySE1
         Y1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MimTLujqV6UiVtggvclgfKIAxzqzEE9ZfQLvshn5bEw=;
        b=g90V5lbmgCh9qat0id923L3GRRTmpkSiq5SLa8YOwPjPvbdoCe9atBV+yfSbwwDPlW
         hkpUwu8muc01Ise4VOOyVBd8Wrm1XYwyiK82YoDLXPxYrT/6kqSFpzujoddfTtmKWKKO
         ZJyRVsuVPM3aY+Dk82yhefkEL1TSgnuYhiPC+xoSzb4gqJ64PX6B1rImiVsFOifT/87d
         m9fWJ/XftNXAfQJYJBVnqOr45dCSZDDJaYWEHs1No/eGGhsH7WkLKGRUQgOuM6kBA5kH
         FvKbLzRSzKXnUz9ksZObWrnjXGx8cViY9wl0fjbfZVuNzpdn9lnmLhHwDwAEoW4M1Vho
         5psA==
X-Gm-Message-State: ACrzQf0/BfANQuqERAmfReqbloZxbNkVRT/+C5zqQj9lWK5LegrlvCJg
        BBZFb+TeHTL6pMzVCdvjHR8=
X-Google-Smtp-Source: AMsMyM6iE5ORqlt8uO7Pv6G0QxzYxx7j1RXLW7i//IeVsx1joZlXmI1UF+11701AD+eJw2MKjmDKgg==
X-Received: by 2002:a63:1d22:0:b0:439:3e7c:8af7 with SMTP id d34-20020a631d22000000b004393e7c8af7mr671426pgd.78.1666058574090;
        Mon, 17 Oct 2022 19:02:54 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:53 -0700 (PDT)
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
Subject: [PATCH 13/20] perf stat: Reset aggr counts for each interval
Date:   Mon, 17 Oct 2022 19:02:20 -0700
Message-Id: <20221018020227.85905-14-namhyung@kernel.org>
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
index 1b9048115a18..a4066f0d3637 100644
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

