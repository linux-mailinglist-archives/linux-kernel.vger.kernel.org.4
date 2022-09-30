Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22795F138E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiI3UVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiI3UVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:21:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B284CBADC;
        Fri, 30 Sep 2022 13:21:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so10114820pjh.2;
        Fri, 30 Sep 2022 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=LX3MaxzLM/91wKTPvvXsaRbQgWzN38y7nF5WahrQ8cw=;
        b=DPgrIj014QFaxm/FGWoOMGVak/ONhu8chQBNyVyWvz9fnDvkT+2dwzO5jb17kF308b
         BmokHv1qJCo9Dw+vMf+B/2+M4SId0LVA1b8dzYh7QtxtZtKYOoeRyUeWIBM1Biv1S4Py
         atm1l9YLb8oZ3zm5UJQaYdRZLnLypJxhz0G3YcCF47LPvO4tP69KAW94/MEN2bNbG99a
         kZqrkHVhX91VYQwigx4+X8xEHfxUVU1JIQRTdmcwNJ8JT8YnzePRuyxZfO2irV6ltMD1
         7fUdxjDMfSDjch2ed5F8kiGqRHR4BEeBiDN778PbsQL1WgEc2r5tK+plu9yYqH46PT9E
         xG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=LX3MaxzLM/91wKTPvvXsaRbQgWzN38y7nF5WahrQ8cw=;
        b=oaNaM+b2z1YvGUPzjITlxbP8Amh/rYxobEG8ABJ89b3hQR0Sm3Ka2yNm6NuHJzr+53
         SOJkAIhMXRxsdgEWx8r9+2alKugnqrRlEBZrNI97pMWnzBLAsmtzkdir7TlaRZXgNVxv
         6evqnqLZFeK1Z+tNFSdiaRYHz0Q/6BgCtOkfxju5Pu6xBA0xZf3ljdpyh9TdEYuzSDxm
         bhHmgVc500AnuNcQm5ReHorg/m1NISZcYj1mtHta1N3Jzs8Sj8SMmjuZCpeVhgjkyN7c
         lxlqINdlXrMpjQjpcXHOesc+prGenVE3SYWG3GRbPD7Me2/wz1EVx7vuCpVVQTAwKYO+
         UPRg==
X-Gm-Message-State: ACrzQf2xPwKbeCQX3OaDd5rH0QvW44tt4BuusgY+MYc0Xxuc9nZXBkMs
        eC/gpnuVLuf7bjOEgkC6b4WeJhO5UlU=
X-Google-Smtp-Source: AMsMyM4pnkrsx7pSqH8sj5biSo8WmUgMq3GjVKIbSEaZjku2097SudWuSIdooQOWvXU+IAKrm7uSZA==
X-Received: by 2002:a17:902:ce8f:b0:176:d5af:a175 with SMTP id f15-20020a170902ce8f00b00176d5afa175mr10954746plg.123.1664569288032;
        Fri, 30 Sep 2022 13:21:28 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id s10-20020a63e80a000000b0042fe1914e26sm2105540pgh.37.2022.09.30.13.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:21:27 -0700 (PDT)
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
Subject: [PATCH 5/7] perf stat: Kill unused per-thread runtime stats
Date:   Fri, 30 Sep 2022 13:21:08 -0700
Message-Id: <20220930202110.845199-6-namhyung@kernel.org>
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

Now it's using the global rt_stat, no need to use per-thread stats.  Let
get rid of them.

Reviewed-by: James Clark <james.clark@arm.com>
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
index 93f6ca0d9761..b0899c6e002f 100644
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
2.38.0.rc1.362.ged0d419d3c-goog

