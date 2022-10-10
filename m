Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFD35F97D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiJJFgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiJJFgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEAD3ED4A;
        Sun,  9 Oct 2022 22:36:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so12133157pjs.4;
        Sun, 09 Oct 2022 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBGwGb+l6It1yeeb0G/Y3FEabn+39BCUm7zik0b+zE4=;
        b=YcvamKp2nIa3Tv+g7gzWVX79EHVDtslkhQmizDk5UvfiuV0FL204S/pCCjm8rFK7S5
         hKIiTT3C5XWbOE8gB3PN5oM9dkxWNXIfGS0McD5ZOcsfwUUJcwY6DtTJugqejbX2yqlp
         E0N0AeN/HlZhS2qP2m6ubwiK63ou7wf0CeKd3LKdQp1pesN1wSdSGP6fOvu2/9Nt5zzQ
         pDd6FFfjy2zx2Hh9+MJ4Kji4Dpg0mPA0E9oBjpQy0vNptC3iA35ISBkEH9ZIhDgWFtrJ
         R50x3QjCiaCwXmp93HeWY/1pkTTlPVjCJ5y3opqc9kj1LvGCcfHIb5iKakdpMjWi9k93
         nTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dBGwGb+l6It1yeeb0G/Y3FEabn+39BCUm7zik0b+zE4=;
        b=fmxXocylobeBTfyQVUiVu2oN9jY1q8eemTTkADstKgyOOihv6k/YMCo0aXkGRPo6nn
         g0eDVilYdDnPug3IuJ/aUTUtLA1HWa/vXt9+I9QzLrYljdfsulEJ6l3Nn+ajNZUVb9VB
         57ati486epNh82NjRyqfPYfM1WiXBEegeiwZchdC7wEg7ZMXVoqjiSm38TBBvFStpcLv
         WjyvfZp7mlIwSYj3uE0xMCiRJiu6+oXrbh9j7/dNRJoeYs+4EdlTHZVbB32tFJMk1D3l
         /UKn74xGC8lD8kj25eIiI4fIsUnrlG52XwfG7bIPKjFvdGR+IjWpGoyDKDHyMEehJ1jl
         cShQ==
X-Gm-Message-State: ACrzQf1MYDCDUj6MKvrU533kONiKgDfEl1GQcBXVSV71Mn2td6rIrkQr
        a8jgp1xiatk50098wOu+W8E=
X-Google-Smtp-Source: AMsMyM43yBwUJHGnq1zJK87ABn9Bh90AkbUYOiP59/vFVS9LFnljNCT7VUJRLj0LDmM7VDVRFTK49A==
X-Received: by 2002:a17:90b:384f:b0:20d:4761:3394 with SMTP id nl15-20020a17090b384f00b0020d47613394mr2989008pjb.144.1665380175078;
        Sun, 09 Oct 2022 22:36:15 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:14 -0700 (PDT)
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
Date:   Sun,  9 Oct 2022 22:35:49 -0700
Message-Id: <20221010053600.272854-9-namhyung@kernel.org>
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

The perf_stat_config.aggr_map should have a correct size of the
aggregation map.  Use it to allocate aggr_counts.

Also AGGR_NONE with per-core events can be tricky because it doesn't
aggreate basically but it needs to do so for per-core events only.
So only per-core evsels will have stats->aggr data.

Note that other caller of evlist__alloc_stat() might not have
stat_config or aggr_map.

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
index 7ca238277d83..691915a71c86 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2049,7 +2049,7 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	u64 val;
 
 	if (!evsel->stats)
-		evlist__alloc_stats(script->session->evlist, false);
+		evlist__alloc_stats(&stat_config, script->session->evlist, false);
 	if (evsel_script(leader)->gnum++ == 0)
 		perf_stat__reset_shadow_stats();
 	val = sample->period * evsel->scale;
@@ -3632,7 +3632,7 @@ static int set_maps(struct perf_script *script)
 
 	perf_evlist__set_maps(&evlist->core, script->cpus, script->threads);
 
-	if (evlist__alloc_stats(evlist, true))
+	if (evlist__alloc_stats(&stat_config, evlist, true))
 		return -ENOMEM;
 
 	script->allocated = true;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e5ddf60ab31d..eaddafbd7ff2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2124,7 +2124,7 @@ static int set_maps(struct perf_stat *st)
 
 	perf_evlist__set_maps(&evsel_list->core, st->cpus, st->threads);
 
-	if (evlist__alloc_stats(evsel_list, true))
+	if (evlist__alloc_stats(&stat_config, evsel_list, true))
 		return -ENOMEM;
 
 	st->maps_allocated = true;
@@ -2571,10 +2571,10 @@ int cmd_stat(int argc, const char **argv)
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
index 68f5a2a03242..cb3a9b795c0f 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -103,7 +103,7 @@ static int __compute_metric(const char *name, struct value *vals,
 	if (err)
 		goto out;
 
-	err = evlist__alloc_stats(evlist, false);
+	err = evlist__alloc_stats(NULL, evlist, false);
 	if (err)
 		goto out;
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 097e05c796ab..a5e1028dacfc 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -889,7 +889,7 @@ static int test__parsing_callback(const struct pmu_event *pe, const struct pmu_e
 		goto out_err;
 	}
 
-	err = evlist__alloc_stats(evlist, false);
+	err = evlist__alloc_stats(NULL, evlist, false);
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
index ea356e5aa351..74bd51a3cb36 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -257,7 +257,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct runtime_stat *st);
 void perf_stat__collect_metric_expr(struct evlist *);
 
-int evlist__alloc_stats(struct evlist *evlist, bool alloc_raw);
+int evlist__alloc_stats(struct perf_stat_config *config,
+			struct evlist *evlist, bool alloc_raw);
 void evlist__free_stats(struct evlist *evlist);
 void evlist__reset_stats(struct evlist *evlist);
 void evlist__reset_prev_raw_counts(struct evlist *evlist);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

