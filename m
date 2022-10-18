Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925356020D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiJRCEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiJRCDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:03:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4468E797;
        Mon, 17 Oct 2022 19:03:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l1so12436037pld.13;
        Mon, 17 Oct 2022 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1udheg5sHf0ONuxdfUoe8f9Q18ghdgubAqjN0gANnY8=;
        b=Rm62ohz+DFBI6eZQNjQVIT9ILFhku/7CucD+oEe1lTPx2nneIj61QVcgLbQVNJS8wr
         SEAQOVT8IZtMNyzvXNmWihYWZ0qt27WRRfZLVI/W4LYnuQVN6E4pMpV6FJpId5XnQ5Jd
         EQj1A8vk8Rl6FwzGC4TsGaWpeHnmll90JApdakBxscK8vmwvGhXyDC54lfYV7X00+ob7
         A/n1gZs7KO4oZJcyLC5fYzEJ9ZxfU1XMkFId6dm4pNFqg4dK3SgOB07ZNop+y7K6K9tF
         Wmu+EEffujOLcEZyjNB4kyXeFMEMN5AHUrfaoRE8lMrz77njT/2pDwm46SnddKCyDqSI
         pBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1udheg5sHf0ONuxdfUoe8f9Q18ghdgubAqjN0gANnY8=;
        b=mxW1JyQxjJuWDBU0q9ewvC+t9hbo1zWc6Hfu4RU6lBoYIFFb1SH4Rax/BIdID1JqCS
         vL0yX+cIhcuOAVcGCBa0+MYZzjdv9yPp1iTTCkXnyWxUPHtTvocghpLAw8ntwumyudLp
         zRlUujT5eNlsFxK4cvCN9nSMt2nKXXAfvVO+FJA+0KcarmoqtmReHBAfNZ6kIuITeJwI
         URbq5SVhr7/rXPZ9ZQuTIPLueF2yHjlcH0qyZ5q/oDaULzmyaWL4RqZng+7ljZR2nhNn
         aJKpclP1jEMGG0JUW3XvNJgZo08nnetu+jC+KH2eP4yuwWDYvXEbzTUMa2NgZYEEuKbM
         buBg==
X-Gm-Message-State: ACrzQf32l5ZVYaRpLUpejTs3pycydpfZ+uWhSbSncO94Ff+8xYBkJMhT
        NX3k7ivpHQ2HTmTH7mWoVlU=
X-Google-Smtp-Source: AMsMyM4Mskt7MdB+oriIsrZbWriuKmqlKBko/6uWA791BfKIaoi9R5mwf73LcGHtjFtgvjTM9rs6VQ==
X-Received: by 2002:a17:903:11cd:b0:170:cde8:18b7 with SMTP id q13-20020a17090311cd00b00170cde818b7mr651563plh.165.1666058587516;
        Mon, 17 Oct 2022 19:03:07 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:03:06 -0700 (PDT)
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
Subject: [PATCH 20/20] perf stat: Remove unused perf_counts.aggr field
Date:   Mon, 17 Oct 2022 19:02:27 -0700
Message-Id: <20221018020227.85905-21-namhyung@kernel.org>
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

The aggr field in the struct perf_counts is to keep the aggregated value
in the AGGR_GLOBAL for the old code.  But it's not used anymore.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/counts.c |  1 -
 tools/perf/util/counts.h |  1 -
 tools/perf/util/stat.c   | 39 ++++++---------------------------------
 3 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 7a447d918458..11cd85b278a6 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -48,7 +48,6 @@ void perf_counts__reset(struct perf_counts *counts)
 {
 	xyarray__reset(counts->loaded);
 	xyarray__reset(counts->values);
-	memset(&counts->aggr, 0, sizeof(struct perf_counts_values));
 }
 
 void evsel__reset_counts(struct evsel *evsel)
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 5de275194f2b..42760242e0df 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -11,7 +11,6 @@ struct evsel;
 
 struct perf_counts {
 	s8			  scaled;
-	struct perf_counts_values aggr;
 	struct xyarray		  *values;
 	struct xyarray		  *loaded;
 };
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0316557adce9..3a432a949d46 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -308,8 +308,6 @@ static void evsel__copy_prev_raw_counts(struct evsel *evsel)
 				*perf_counts(evsel->prev_raw_counts, idx, thread);
 		}
 	}
-
-	evsel->counts->aggr = evsel->prev_raw_counts->aggr;
 }
 
 void evlist__copy_prev_raw_counts(struct evlist *evlist)
@@ -320,26 +318,6 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist)
 		evsel__copy_prev_raw_counts(evsel);
 }
 
-void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
-{
-	struct evsel *evsel;
-
-	/*
-	 * To collect the overall statistics for interval mode,
-	 * we copy the counts from evsel->prev_raw_counts to
-	 * evsel->counts. The perf_stat_process_counter creates
-	 * aggr values from per cpu values, but the per cpu values
-	 * are 0 for AGGR_GLOBAL. So we use a trick that saves the
-	 * previous aggr value to the first member of perf_counts,
-	 * then aggr calculation in process_counter_values can work
-	 * correctly.
-	 */
-	evlist__for_each_entry(evlist, evsel) {
-		*perf_counts(evsel->prev_raw_counts, 0, 0) =
-			evsel->prev_raw_counts->aggr;
-	}
-}
-
 static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
 {
 	uint64_t *key = (uint64_t *) __key;
@@ -442,7 +420,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		       int cpu_map_idx, int thread,
 		       struct perf_counts_values *count)
 {
-	struct perf_counts_values *aggr = &evsel->counts->aggr;
 	struct perf_stat_evsel *ps = evsel->stats;
 	static struct perf_counts_values zero;
 	bool skip = false;
@@ -511,12 +488,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 	}
 
-	if (config->aggr_mode == AGGR_GLOBAL) {
-		aggr->val += count->val;
-		aggr->ena += count->ena;
-		aggr->run += count->run;
-	}
-
 	return 0;
 }
 
@@ -541,13 +512,10 @@ static int process_counter_maps(struct perf_stat_config *config,
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter)
 {
-	struct perf_counts_values *aggr = &counter->counts->aggr;
 	struct perf_stat_evsel *ps = counter->stats;
-	u64 *count = counter->counts->aggr.values;
+	u64 *count;
 	int ret;
 
-	aggr->val = aggr->ena = aggr->run = 0;
-
 	if (counter->per_pkg)
 		evsel__zero_per_pkg(counter);
 
@@ -558,6 +526,11 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	if (config->aggr_mode != AGGR_GLOBAL)
 		return 0;
 
+	/*
+	 * GLOBAL aggregation mode only has a single aggr counts,
+	 * so we can use ps->aggr[0] as the actual output.
+	 */
+	count = ps->aggr[0].counts.values;
 	update_stats(&ps->res_stats, *count);
 
 	if (verbose > 0) {
-- 
2.38.0.413.g74048e4d9e-goog

