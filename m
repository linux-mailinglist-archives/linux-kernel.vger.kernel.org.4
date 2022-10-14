Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0202C5FE8D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJNGRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJNGQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B291905E7;
        Thu, 13 Oct 2022 23:16:25 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 204so3997552pfx.10;
        Thu, 13 Oct 2022 23:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deC1Ch/LRE/b9oWyC7BPXVLD02u5pO6qtdU3irPGc8w=;
        b=KHSL8W0nox/llcdMA89ep9ycYbcTlAQhpmmj5AhrLmIoNRE77aU1JGyXgDMUWxMiFz
         1NsYYb5Y7WGy5+NrqV+xIezxghWtnpWS4HphitnlesYX5be5V/ySfGkzWoFN6XYdOV73
         IgoYD9YKua+kRAHO3f9x2+mrkXBVAg/mxn2fyQOC6sDt6Og+PYcu78S6Kk0mW4kyHjq2
         tsloPvFQsErWaGvERJXSbloRQNUnRI5JAYu0eoAX+Hz3C5JojFVdHpGKTfYsZby6reJp
         pcO2e2eyYOFRYhOhjDFznW5zUHJJgKypr3KoSxGNkMU5DdGRdNv2MRvYoj7tU+V5PZ03
         sNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=deC1Ch/LRE/b9oWyC7BPXVLD02u5pO6qtdU3irPGc8w=;
        b=qezwmBILhJYC5dHRUTWo/BSarKQgg5hBIJ91/4tfnSbpaxMxBzFRDY/P0GCLYCuyZC
         FMJySs5adEk/969SnaqD0O/34tSekasIc29ZVPXStdkbQg8pq/rrBGeTCsi0cJuIw6uH
         1KYAXpGRH0rd4PM/WlMZFhoKm85BCO777+rX43XTtkpIp9buoQmfJUr6kPielC2uqWOR
         dWIVQLDcjaAYLmpUFdysWmQItC8Qt4fi++gRrvEaDQQEaawCNas1+ALYZtdr99te5Evt
         HC4v4uDMTehuNS4Rc2fDUUhpmGSHka+CMqMdVAu+zU3pCuQrxl1QwBbG/ZBA7eMXNTwp
         u08w==
X-Gm-Message-State: ACrzQf2bD44m9jRt/2Y2Hqs7cgXuYtq9meY3vPEZ2uChSCNLwQyk15nw
        QExwlY1+gnoO+3pSK/mxtEE=
X-Google-Smtp-Source: AMsMyM7ggt8lQN+os/uPlnCfql+aV2zpDnbXALElqWLaPN0FfQ1skbGsyCX9JKD911P3H8bNFChyCw==
X-Received: by 2002:a63:b5d:0:b0:45f:d7d0:5808 with SMTP id a29-20020a630b5d000000b0045fd7d05808mr3203471pgl.330.1665728183760;
        Thu, 13 Oct 2022 23:16:23 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:23 -0700 (PDT)
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
Subject: [PATCH 19/19] perf stat: Remove unused perf_counts.aggr field
Date:   Thu, 13 Oct 2022 23:15:50 -0700
Message-Id: <20221014061550.463644-20-namhyung@kernel.org>
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

The aggr field in the struct perf_counts is to keep the aggregated value
in the AGGR_GLOBAL for the old code.  But it's not used anymore.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/counts.c |  1 -
 tools/perf/util/counts.h |  1 -
 tools/perf/util/stat.c   | 35 ++---------------------------------
 3 files changed, 2 insertions(+), 35 deletions(-)

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
index 14c45f4cfdd3..6ab9c58beca7 100644
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
@@ -423,7 +401,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		       int cpu_map_idx, int thread,
 		       struct perf_counts_values *count)
 {
-	struct perf_counts_values *aggr = &evsel->counts->aggr;
 	struct perf_stat_evsel *ps = evsel->stats;
 	static struct perf_counts_values zero;
 	bool skip = false;
@@ -493,12 +470,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
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
 
@@ -523,13 +494,10 @@ static int process_counter_maps(struct perf_stat_config *config,
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
 
@@ -540,6 +508,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	if (config->aggr_mode != AGGR_GLOBAL)
 		return 0;
 
+	count = ps->aggr[0].counts.values;
 	update_stats(&ps->res_stats, *count);
 
 	if (verbose > 0) {
-- 
2.38.0.413.g74048e4d9e-goog

