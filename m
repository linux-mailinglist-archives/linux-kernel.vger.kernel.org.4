Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B65EB1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiIZUI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiIZUIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:08:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E8072B64;
        Mon, 26 Sep 2022 13:08:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p14so4710330pjd.3;
        Mon, 26 Sep 2022 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=yVWViY7fxIIM4RCB3cCJEIT4RK67T32Qj8MOeBmOq/s=;
        b=HvizWQuJA+CZnTwc6xXTbxk0huqgmphMNleLZLQudFjL/H49y/yfQ+rD8WS/xOv8i8
         SLmfTXyxaTCf+XLyf3xHqDiNEa1VtJ9A7P2ejXXYLEHewbbXKD1sHC2ZM++pXqWxO3fA
         IQsReZ/E+DgNlLK2N7dmHxoqr6jXlbvvNcGsQ7mwG+iFH0DdsnX3rm0gLGSwNLX5jGOM
         lhjTWxi3wzViFikO7M/rWJud4xkWVDNlW/L7vdK9iieS4fE3f69BzocqNM1a77oa4Ok7
         NPzW6SdlxmuLAcJOVyQKWrAfKCy7dmU1ppJo8QCqWkPsvAAYPTS4puPWwEzqZfMmvbvM
         Tqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=yVWViY7fxIIM4RCB3cCJEIT4RK67T32Qj8MOeBmOq/s=;
        b=bq0b0qEIDI2Mng6nuYCSwhIHPyFUusO3b9hkLp0CGYiZS3VvRWaWtendR0PMsH3BbC
         7kWA7HWsIroYTIuefZv33As4Rt+pn+kyJGFGtjMEnD3FOoS1LOnDP0XKDHQ8TQvEdTdy
         ENsncsyhl2KeAVz5qnM+GvPENt/nJmWQi9XbWxoy4q0ZN5vq+oW5ULSo/vnyDJnuRvmw
         xGYdB6ya2qJdVvMvknr1UsO5dDYrSZ2O7zvG0GhKisMt7LqCnm5avO1bL+CS6aMYqJED
         TaY/bFqbTNYIpaRZGSLHdbxLB/jTvdu9rRyzovg60BeILMS5zExPaYvH8EizY40DQK5T
         A8VA==
X-Gm-Message-State: ACrzQf3Y33NWEPuJURwuFTEB4cy0nzW7drTpNzxtHMKvIZ77Udig+ikp
        XAt2+Tp4FX2Qg/CSkbdVuZE=
X-Google-Smtp-Source: AMsMyM58d9Vvo7w/7a102mYJkv4B/CATdvJqKDxsW+jP7CHAmrSGDLqQqYEJ2MxNGz0D1htehg7Ksg==
X-Received: by 2002:a17:90b:4a50:b0:203:1204:5bc4 with SMTP id lb16-20020a17090b4a5000b0020312045bc4mr493910pjb.79.1664222886921;
        Mon, 26 Sep 2022 13:08:06 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:2d32:19ce:817e:166])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78bd5000000b00540c24ba181sm12510148pfd.120.2022.09.26.13.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:08:06 -0700 (PDT)
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
Subject: [PATCH 5/6] perf stat: Kill unused per-thread runtime stats
Date:   Mon, 26 Sep 2022 13:07:56 -0700
Message-Id: <20220926200757.1161448-6-namhyung@kernel.org>
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

Now it's using the global rt_stat, no need to use per-thread stats.  Let
get rid of them.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 54 ---------------------------------------
 tools/perf/util/stat.h    |  2 --
 2 files changed, 56 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e05fe72c1d87..b86ebb25a799 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -292,13 +292,8 @@ static inline void diff_timespec(struct timespec *r, struct timespec *a,
 
 static void perf_stat__reset_stats(void)
 {
-	int i;
-
 	evlist__reset_stats(evsel_list);
 	perf_stat__reset_shadow_stats();
-
-	for (i = 0; i < stat_config.stats_num; i++)
-		perf_stat__reset_shadow_per_stat(&stat_config.stats[i]);
 }
 
 static int process_synthesized_event(struct perf_tool *tool __maybe_unused,
@@ -489,46 +484,6 @@ static void read_counters(struct timespec *rs)
 	}
 }
 
-static int runtime_stat_new(struct perf_stat_config *config, int nthreads)
-{
-	int i;
-
-	config->stats = calloc(nthreads, sizeof(struct runtime_stat));
-	if (!config->stats)
-		return -1;
-
-	config->stats_num = nthreads;
-
-	for (i = 0; i < nthreads; i++)
-		runtime_stat__init(&config->stats[i]);
-
-	return 0;
-}
-
-static void runtime_stat_delete(struct perf_stat_config *config)
-{
-	int i;
-
-	if (!config->stats)
-		return;
-
-	for (i = 0; i < config->stats_num; i++)
-		runtime_stat__exit(&config->stats[i]);
-
-	zfree(&config->stats);
-}
-
-static void runtime_stat_reset(struct perf_stat_config *config)
-{
-	int i;
-
-	if (!config->stats)
-		return;
-
-	for (i = 0; i < config->stats_num; i++)
-		perf_stat__reset_shadow_per_stat(&config->stats[i]);
-}
-
 static void process_interval(void)
 {
 	struct timespec ts, rs;
@@ -537,7 +492,6 @@ static void process_interval(void)
 	diff_timespec(&rs, &ts, &ref_time);
 
 	perf_stat__reset_shadow_per_stat(&rt_stat);
-	runtime_stat_reset(&stat_config);
 	read_counters(&rs);
 
 	if (STAT_RECORD) {
@@ -1018,7 +972,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		evlist__copy_prev_raw_counts(evsel_list);
 		evlist__reset_prev_raw_counts(evsel_list);
-		runtime_stat_reset(&stat_config);
 		perf_stat__reset_shadow_per_stat(&rt_stat);
 	} else {
 		update_stats(&walltime_nsecs_stats, t1 - t0);
@@ -2514,12 +2467,6 @@ int cmd_stat(int argc, const char **argv)
 	 */
 	if (stat_config.aggr_mode == AGGR_THREAD) {
 		thread_map__read_comms(evsel_list->core.threads);
-		if (target.system_wide) {
-			if (runtime_stat_new(&stat_config,
-				perf_thread_map__nr(evsel_list->core.threads))) {
-				goto out;
-			}
-		}
 	}
 
 	if (stat_config.aggr_mode == AGGR_NODE)
@@ -2660,7 +2607,6 @@ int cmd_stat(int argc, const char **argv)
 	evlist__delete(evsel_list);
 
 	metricgroup__rblist_exit(&stat_config.metric_events);
-	runtime_stat_delete(&stat_config);
 	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
 
 	return status;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 3eba38a1a149..43cb3f13d4d6 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -153,8 +153,6 @@ struct perf_stat_config {
 	int			 run_count;
 	int			 print_free_counters_hint;
 	int			 print_mixed_hw_group_error;
-	struct runtime_stat	*stats;
-	int			 stats_num;
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
 	struct rusage		 ru_data;
-- 
2.37.3.998.g577e59143f-goog

