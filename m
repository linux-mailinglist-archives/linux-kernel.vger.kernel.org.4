Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D186020C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiJRCD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJRCDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:03:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9388C039;
        Mon, 17 Oct 2022 19:02:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g28so12746385pfk.8;
        Mon, 17 Oct 2022 19:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0E8rkAsDwyeX4tn3K6WoCLFrxZKVhY8mXbbIgxSuio=;
        b=ggm0tMmo6pyzZqN5ivcwQIoAr1arw8s/NfPfGzCuDvGNev+E2ssNO8RgP8gavTe9s9
         Nu9pGZMYbU88ApAkKSofkvXdqL9nv5BiGzqBRvGjohl72JXba9lr8f/q5u5sX9wqGY3I
         2HxcvqQCio6wHBM4/4gyZOphiTY7F7gi1/WOo141TnkWUQ6YZR0oHN+8GpCrGnP4lVFf
         dYoeQEzS1o5FhfNaCDlOdkWePvyaXMbut8n04ho2d8egClGL6pL/UOyZiPLbq7UiyqXA
         djZglrSRScOBUXA3J+8FFztYdR2x6gcIKuHCJt2YzR5cQuCdwTQnFBRWLpWCAYT7kUgM
         uwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0E8rkAsDwyeX4tn3K6WoCLFrxZKVhY8mXbbIgxSuio=;
        b=sWOlZZ9Up+Wc5p2HoM6+/6/HMrwmkBLWQvbotKUcjtpZkXbG46aNOd1mTid1Ry4O+O
         DuS28Zh0c7qUPwigWeJ34PEKAxkHvZU/RZ1VEHFxiDseBgrmmo1LtWLaza1lDM7Sshvm
         05vOJ8DHiwP1JKfy+UrkmPI0YFzKHtTHuqy+qSF53Ww4wPrnYW6gxeyrGO5I/ybHD9So
         Qb0KAzV4Uxf7LZZtEb98Qwi+/8m1D4vcxpesvAqJCd7WWsXNAxqHK++iHu/Rnyl2f9G8
         JwMZ9t8GLKECYrbxHARDgyb2RgzYZ1iWyK5WbHXNFOCGMnRizhL/eNDUoVut2FA0FrtN
         ALvA==
X-Gm-Message-State: ACrzQf1uO3ykARTL0dAhP+K+EE7TWXBfYZfXNfl95jjOVAOngu49mPQE
        YPOF3EXt4djvz+7bFZrktyw=
X-Google-Smtp-Source: AMsMyM5FlpJnwDlrj4goDUNw1lHG2vYVXNqgmzdZuG1hjQ+k1NLSkSqprRRgSBhLlgnTDI/gXTqdXA==
X-Received: by 2002:a63:1e16:0:b0:430:5c4a:a3b5 with SMTP id e22-20020a631e16000000b004305c4aa3b5mr661662pge.37.1666058565360;
        Mon, 17 Oct 2022 19:02:45 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:44 -0700 (PDT)
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
Subject: [PATCH 08/20] perf stat: Allocate evsel->stats->aggr properly
Date:   Mon, 17 Oct 2022 19:02:15 -0700
Message-Id: <20221018020227.85905-9-namhyung@kernel.org>
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

The perf_stat_config.aggr_map should have a correct size of the
aggregation map.  Use it to allocate aggr_counts.

Also AGGR_NONE with per-core events can be tricky because it doesn't
aggreate basically but it needs to do so for per-core events only.
So only per-core evsels will have stats->aggr data.

Note that other caller of evlist__alloc_stat() might not have
stat_config or aggr_map.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-script.c     | 4 ++--
 tools/perf/builtin-stat.c       | 6 +++---
 tools/perf/tests/parse-metric.c | 2 +-
 tools/perf/tests/pmu-events.c   | 2 +-
 tools/perf/util/stat.c          | 9 +++++++--
 tools/perf/util/stat.h          | 3 ++-
 6 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7ca238277d83..d7ec8c1af293 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2049,7 +2049,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	u64 val;
 
 	if (!evsel->stats)
-		evlist__alloc_stats(script->session->evlist, false);
+		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
 	if (evsel_script(leader)->gnum++ == 0)
 		perf_stat__reset_shadow_stats();
 	val = sample->period * evsel->scale;
@@ -3632,7 +3632,7 @@ static int set_maps(struct perf_script *script)
 
 	perf_evlist__set_maps(&evlist->core, script->cpus, script->threads);
 
-	if (evlist__alloc_stats(evlist, true))
+	if (evlist__alloc_stats(&stat_config, evlist, /*alloc_raw=*/true))
 		return -ENOMEM;
 
 	script->allocated = true;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9053fd4d15a7..92a8e4512f98 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2121,7 +2121,7 @@ static int set_maps(struct perf_stat *st)
 
 	perf_evlist__set_maps(&evsel_list->core, st->cpus, st->threads);
 
-	if (evlist__alloc_stats(evsel_list, true))
+	if (evlist__alloc_stats(&stat_config, evsel_list, /*alloc_raw=*/true))
 		return -ENOMEM;
 
 	st->maps_allocated = true;
@@ -2568,10 +2568,10 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
-	if (evlist__alloc_stats(evsel_list, interval))
+	if (perf_stat_init_aggr_mode())
 		goto out;
 
-	if (perf_stat_init_aggr_mode())
+	if (evlist__alloc_stats(&stat_config, evsel_list, interval))
 		goto out;
 
 	/*
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 68f5a2a03242..21b7ac00d798 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -103,7 +103,7 @@ static int __compute_metric(const char *name, struct value *vals,
 	if (err)
 		goto out;
 
-	err = evlist__alloc_stats(evlist, false);
+	err = evlist__alloc_stats(/*config=*/NULL, evlist, /*alloc_raw=*/false);
 	if (err)
 		goto out;
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 097e05c796ab..5d0d3b239a68 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -889,7 +889,7 @@ static int test__parsing_callback(const struct pmu_event *pe, const struct pmu_e
 		goto out_err;
 	}
 
-	err = evlist__alloc_stats(evlist, false);
+	err = evlist__alloc_stats(/*config=*/NULL, evlist, /*alloc_raw=*/false);
 	if (err)
 		goto out_err;
 	/*
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c9d5aa295b54..374149628507 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -211,12 +211,17 @@ static int evsel__alloc_stats(struct evsel *evsel, int nr_aggr, bool alloc_raw)
 	return 0;
 }
 
-int evlist__alloc_stats(struct evlist *evlist, bool alloc_raw)
+int evlist__alloc_stats(struct perf_stat_config *config,
+			struct evlist *evlist, bool alloc_raw)
 {
 	struct evsel *evsel;
+	int nr_aggr = 0;
+
+	if (config && config->aggr_map)
+		nr_aggr = config->aggr_map->nr;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__alloc_stats(evsel, 0, alloc_raw))
+		if (evsel__alloc_stats(evsel, nr_aggr, alloc_raw))
 			goto out_free;
 	}
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 42453513ffea..0980875b9be1 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -267,7 +267,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct runtime_stat *st);
 void perf_stat__collect_metric_expr(struct evlist *);
 
-int evlist__alloc_stats(struct evlist *evlist, bool alloc_raw);
+int evlist__alloc_stats(struct perf_stat_config *config,
+			struct evlist *evlist, bool alloc_raw);
 void evlist__free_stats(struct evlist *evlist);
 void evlist__reset_stats(struct evlist *evlist);
 void evlist__reset_prev_raw_counts(struct evlist *evlist);
-- 
2.38.0.413.g74048e4d9e-goog

