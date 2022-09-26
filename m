Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD495EB1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIZUIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiIZUIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:08:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E33163F02;
        Mon, 26 Sep 2022 13:08:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b21so7224481plz.7;
        Mon, 26 Sep 2022 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=IOT7jzMOg4ykF0pG9M1eK7xPNIKdwWwmdCoPtWAbkrY=;
        b=eLNLCcy5SKVpDxbxxdUX9m817iFX58sa8dCbsC6MShx2isMKgi1bgIHt+xJA3C4hLl
         rC84H1CNscAqy+WgtFYJ6jyFlc/9mg58aNYd/+16sH1aev3+rWqKs2f6t8trek9VJboE
         7hTNtzB3g2fQ87fnSZ0d49u5QwYYCbr74VyLdij0ujh+df1S6Os448m0zraGCBNbV9hQ
         xYmuAOtePuTE/qhiarmVaEsJHPJ0Vyzt31/1H2Y8pdGOIfjJ9lHgqvovyCxVMXl3vOQE
         Ui5T4V64Hle0gLRiQgRS39DCYObUjzxcEdigPvrFMKtBCH3mL0Gzy+/3e39s2gXY2GQ0
         y31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=IOT7jzMOg4ykF0pG9M1eK7xPNIKdwWwmdCoPtWAbkrY=;
        b=sq2FCSTUGSAw5M8cPu8cKLsfVSti3pgItOtw8JswvLI84hvPtdSou1Or43RUHdw05M
         v212Epr506suBA70flPsY+wOUr1B6AaBBaiIP6oXFTqi50mYwdYZLPifKad0PixVrbLt
         ODLd0qQGZeeUs3MpE3rkC/PvI+vf7arfDGsPD/9HebQrk+mUC/133OO1ulzqcSZ2PCiU
         LKqNWGB/w1hZBtEo/SSLEyUCZdTn02oSrFjzZbOWN9cAOzF6WTuy1yU8CuWyxTeavVDY
         PykZ9SGSY8Mw+8usVx557g2/NgbCleU85zovntR9lx3UwWHT2AlbRmwlA39uy/2dTUyv
         xPxg==
X-Gm-Message-State: ACrzQf0Xn6vb4+Xhqt8Iqdr5eFpThHU2Le3eapgL2v8CMRB+RlJDM9Bx
        4qT3r3due4nT3/TIU7xsuN0=
X-Google-Smtp-Source: AMsMyM5qhjQ0NYbvDo/PChJbJfq86/5GisIURQZZ4mCKF+qz8rq8wgB3okczRjaw2zwVJHJtuJXBAA==
X-Received: by 2002:a17:90b:5096:b0:202:df4f:89a with SMTP id rt22-20020a17090b509600b00202df4f089amr501448pjb.25.1664222885621;
        Mon, 26 Sep 2022 13:08:05 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:2d32:19ce:817e:166])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78bd5000000b00540c24ba181sm12510148pfd.120.2022.09.26.13.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:08:05 -0700 (PDT)
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCH 4/6] perf stat: Use thread map index for shadow stat
Date:   Mon, 26 Sep 2022 13:07:55 -0700
Message-Id: <20220926200757.1161448-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926200757.1161448-1-namhyung@kernel.org>
References: <20220926200757.1161448-1-namhyung@kernel.org>
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

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 20 +++++++++-----------
 tools/perf/util/stat.c         |  8 ++------
 2 files changed, 11 insertions(+), 17 deletions(-)

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
2.37.3.998.g577e59143f-goog

