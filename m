Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE535FE8C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiJNGQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJNGQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:19 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0529117406;
        Thu, 13 Oct 2022 23:16:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bh13so3497886pgb.4;
        Thu, 13 Oct 2022 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0E8rkAsDwyeX4tn3K6WoCLFrxZKVhY8mXbbIgxSuio=;
        b=cqiWLYbYVaZqA1AN5JxDT/T/fdaoDMt/9viiEZ70RhnVJMAhC6et+7dSvEPhDz9naQ
         MxxKsPwYPq2+alYkqJuN0OhwkBig/XsnASr6Qr+bUKu8TFvpuakQdFuZdHkKZfN219PM
         /ktu+5SurxQOYpC+rij/45vfwW+wBcimh/QC72HniikR5ApzFI2kKZRM+6iYmm0b2a2c
         GI5FyBx2h6T9sjw39qf25o9TaMKuF2Y0Wr+B1FWeBbd8DwScGYP2G7K0J133K0Dl1PXL
         ZKiogNWA92yuYpYdKe1m8rWfcr3oPSW4VtaIM/xizkxtPf3K9qld5irLzWcLwpafPLZ3
         zxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0E8rkAsDwyeX4tn3K6WoCLFrxZKVhY8mXbbIgxSuio=;
        b=I5bsAi+fNp44bLZOF4Ct5acfRGpfWape9f0HhJ/jV2D0a3tN8g1cb1OZ/DmFHQNB2u
         BncnQlMTn7+WthlVtG2wFsc5p4ugh37x8k+8cBz8Kb/vjTacEBqOC/3iPagt4H/upqUU
         wUUAzEsJtuywiYJRvBQxLQ4cBfU2KlfXL8U1KFwZfJmRuvm6yy7BTVFhryJ2gcInwbhj
         QoA+yAK1cn+JlhbNJG57Mu8xFnFqOZqeKCnDrRVqY/zR4VGtxnca2PHMWv6bcdwvxqZz
         VioSqziqdLaUpYFk21vpbC6HhfXzlKIRy2V/pAcND0jOxKLK2Czi7b7Ur9RWPc7VGjz1
         u1bg==
X-Gm-Message-State: ACrzQf0eywLVwDsojzJTZOLyry8qtTF36PLUl8NOE8x/TlhrzoI1cZny
        7SOZMSYfQIRjbju5rnNMKbo=
X-Google-Smtp-Source: AMsMyM4vSxViTqJTOLcOUW/9i34/kR5amphiB3EeaOq0MdXb1Puoy2eJFdgBgLgDyoeLzEISxlyWuw==
X-Received: by 2002:a63:4e5a:0:b0:438:9513:da55 with SMTP id o26-20020a634e5a000000b004389513da55mr3121140pgl.381.1665728165550;
        Thu, 13 Oct 2022 23:16:05 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:05 -0700 (PDT)
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
Subject: [PATCH 08/19] perf stat: Allocate evsel->stats->aggr properly
Date:   Thu, 13 Oct 2022 23:15:39 -0700
Message-Id: <20221014061550.463644-9-namhyung@kernel.org>
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

