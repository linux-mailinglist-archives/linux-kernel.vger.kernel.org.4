Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2C75F1392
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiI3UVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiI3UVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:21:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C006917C232;
        Fri, 30 Sep 2022 13:21:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so10120879pjs.1;
        Fri, 30 Sep 2022 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=afOdAtbVr8CZasnuoKPPBTl38yrTRQkWcVjl3k0D4Y0=;
        b=VgGsWyqQdfoK9WevyfVeuj9bzvkwjXym3zoMcRJa0UzixcyBtVgUW6gZ1kwp4BmHPJ
         QvUQJh6kWXk+zT0Or9Hv0hp8w3pORdO3cdu3LVrlumDbM1lbDrW6OkkOfHDh7hJFsLa3
         mev8E7nWtHZ8RCaXcqKEwK93GaRDWku7vly909MF6qzpWrxgW7zrz7m9kY+nVizGKBoo
         IjWz8eq0icg9NIOa0AsCOSywvbNa3dK+96doODGqKMl7PNMwGcWk2L8CXWJgMFst1fU1
         pS9JBxg28Ldd/YBIq2VOJkiNXn80OGpGOYN/uJ3ci/yJCxu1heiHMVwZCn+seiqEgmDe
         bN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=afOdAtbVr8CZasnuoKPPBTl38yrTRQkWcVjl3k0D4Y0=;
        b=mKUb5v+97E8+eXuNnefrC3C7vWSEOqeVzz95D9e/CKl8y+aLezP8hNP75FnWVkFCGn
         SqVKeWlikU1s8WvMkU3etThyJjZ35bO4J7++R+j1xH7ViN82BEs6QyxkT7OJYvl4veZ+
         KrBG3O/s8v5q/09S1z/X9PMegSWQDsz1y+U5YQvYPnymdm8ggAZ/jJNdkf8jZjyPS4xI
         iUAC9Wco8BAZ7bMYzJ4SmZoWDxVE1W1y/3yZW+HY5sxQUL+QQo2au9yh+dfT42uT2HhQ
         au07fUwj0NLCTzEif/v8ZOSuO/ZAi6CVdiL0CzNECtfZXMBiyx5QhFxKbzDyZC6IZ9ua
         EMdQ==
X-Gm-Message-State: ACrzQf0ZrP4HW7dBX8OH09CYH59MRjTz/PhSmi2C1yH8cAJKlR8ymAF4
        oQcXMY0DbfCxNIp6tYtPTKA=
X-Google-Smtp-Source: AMsMyM6xXN3xh9LvhD8qn91lRoyMX0/R+7v3OaK5eIp+WsAws/YxQs/810heOcCQfT6IiAVLA7zrqQ==
X-Received: by 2002:a17:903:509:b0:179:ffcf:d275 with SMTP id jn9-20020a170903050900b00179ffcfd275mr10588974plb.150.1664569286688;
        Fri, 30 Sep 2022 13:21:26 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id s10-20020a63e80a000000b0042fe1914e26sm2105540pgh.37.2022.09.30.13.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:21:26 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: [PATCH 4/7] perf stat: Use thread map index for shadow stat
Date:   Fri, 30 Sep 2022 13:21:07 -0700
Message-Id: <20220930202110.845199-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930202110.845199-1-namhyung@kernel.org>
References: <20220930202110.845199-1-namhyung@kernel.org>
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

When AGGR_THREAD is active, it aggregates the values for each thread.
Previously it used cpu map index which is invalid for AGGR_THREAD so
it had to use separate runtime stats with index 0.

But it can just use the rt_stat with thread_map_index.  Rename the
first_shadow_map_idx() and make it return the thread index.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 20 +++++++++-----------
 tools/perf/util/stat-shadow.c  |  2 +-
 tools/perf/util/stat.c         |  8 ++------
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 234491f43c36..570e2c04d47d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -442,7 +442,7 @@ static void print_metric_header(struct perf_stat_config *config,
 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
 }
 
-static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
+static int first_shadow_map_idx(struct perf_stat_config *config,
 				struct evsel *evsel, const struct aggr_cpu_id *id)
 {
 	struct perf_cpu_map *cpus = evsel__cpus(evsel);
@@ -452,6 +452,9 @@ static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
 	if (config->aggr_mode == AGGR_NONE)
 		return perf_cpu_map__idx(cpus, id->cpu);
 
+	if (config->aggr_mode == AGGR_THREAD)
+		return id->thread;
+
 	if (!config->aggr_get_id)
 		return 0;
 
@@ -646,7 +649,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	}
 
 	perf_stat__print_shadow_stats(config, counter, uval,
-				first_shadow_cpu_map_idx(config, counter, &id),
+				first_shadow_map_idx(config, counter, &id),
 				&out, &config->metric_events, st);
 	if (!config->csv_output && !config->metric_only && !config->json_output) {
 		print_noise(config, counter, noise);
@@ -676,7 +679,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 				val += perf_counts(counter->counts, idx, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
-					first_shadow_cpu_map_idx(config, counter, &id),
+					first_shadow_map_idx(config, counter, &id),
 					&rt_stat);
 		}
 	}
@@ -979,14 +982,9 @@ static void print_aggr_thread(struct perf_stat_config *config,
 			fprintf(output, "%s", prefix);
 
 		id = buf[thread].id;
-		if (config->stats)
-			printout(config, id, 0, buf[thread].counter, buf[thread].uval,
-				 prefix, buf[thread].run, buf[thread].ena, 1.0,
-				 &config->stats[id.thread]);
-		else
-			printout(config, id, 0, buf[thread].counter, buf[thread].uval,
-				 prefix, buf[thread].run, buf[thread].ena, 1.0,
-				 &rt_stat);
+		printout(config, id, 0, buf[thread].counter, buf[thread].uval,
+			 prefix, buf[thread].run, buf[thread].ena, 1.0,
+			 &rt_stat);
 		fputc('\n', output);
 	}
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 945c40c10423..0676ee9986ff 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -33,7 +33,7 @@ struct saved_value {
 	struct evsel *evsel;
 	enum stat_type type;
 	int ctx;
-	int map_idx;  /* cpu map index */
+	int map_idx;  /* cpu or thread map index */
 	struct cgroup *cgrp;
 	struct runtime_stat *stat;
 	struct stats stats;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index e1d3152ce664..21137c9d5259 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -389,12 +389,8 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 
 		if (config->aggr_mode == AGGR_THREAD) {
-			if (config->stats)
-				perf_stat__update_shadow_stats(evsel,
-					count->val, 0, &config->stats[thread]);
-			else
-				perf_stat__update_shadow_stats(evsel,
-					count->val, 0, &rt_stat);
+			perf_stat__update_shadow_stats(evsel, count->val,
+						       thread, &rt_stat);
 		}
 		break;
 	case AGGR_GLOBAL:
-- 
2.38.0.rc1.362.ged0d419d3c-goog

