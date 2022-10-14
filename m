Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761335FE8CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJNGRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJNGQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB77136403;
        Thu, 13 Oct 2022 23:16:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so5612453pjq.4;
        Thu, 13 Oct 2022 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrftxqnxBQhQyNqtAur/XWhtXNA2wVab7OVanH9H7Pg=;
        b=c3fIuwtmaBt9mfWZ4j5zR22hLm8LbjaLsAPWfJq4UrfiRVC3t7PgVzEwCrtyJanIlF
         /z7l+8220JoQ8hem3hUQVvRESKwaqi+G3cSvgnuYzshMj5gO73uD6Kk2035cA/ep61J4
         IzoApHPcQGcUo801GKjkkLWPSw7npjAlyb2LNt1+gjcCuytoOcd0H0TYWDxlLQ+rK30/
         3V/oP8QAVfWXGXJBOd5nvWXf9DCp+CVCFTk0e2Q85lZSyauoVUVIVVr8gtgi2A6Bbm3e
         Fb7y2+UHbfWjGqlsHf+HNMLuqdqFwJWbeDVR9axTCik/I8/Od0OrJb6h9Rtq+7f7LBej
         n94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrftxqnxBQhQyNqtAur/XWhtXNA2wVab7OVanH9H7Pg=;
        b=K/xskpqnx4xMcLBm76TrAW151l0Vx36VY9WQDjTs6Dc+WLMlEQN/ARCr0MaydraJTV
         BJJYbYbLSAj2VeuE1PdJRN8/me3a1CFa87R0H5Uao1/t6SmfGKc4dpRXMO7nicEwMvDI
         grKBdZvnlpeTsVy/84BY98iCinm4YS6sfYSp5FXX6EHE7B/AJXvMJJVQxywoAaQdC+Fz
         UEaAeuTgpAFTl9lkpUFXydR2980aVjvdwX3gjuKnJBdRDwPBiXgmzjeRAM91gq/c2fsk
         h3nlYnw/VUeQvprucr6/N/P6iBCIuCbEmuYFuRMZtvcvc+VEEFLN/XKsqsH1E2nZ9rSa
         LP9w==
X-Gm-Message-State: ACrzQf1HMcfgd76qO5+aI+Ay3Q9giq6avqalAsC0OcNrnLh2TIUvPWAe
        lwCLqEFqXvPr5IwE3Clb/B0=
X-Google-Smtp-Source: AMsMyM5rDjWWuYiUsBLAQlx+5M4rDFEoAmtKqW290ZbJe3laY6mi/CBgd8X+3+JVmYe+KncwIMbLYw==
X-Received: by 2002:a17:902:b944:b0:179:fdb0:1c39 with SMTP id h4-20020a170902b94400b00179fdb01c39mr3787948pls.98.1665728173755;
        Thu, 13 Oct 2022 23:16:13 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:13 -0700 (PDT)
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
Subject: [PATCH 13/19] perf stat: Split process_counters()
Date:   Thu, 13 Oct 2022 23:15:44 -0700
Message-Id: <20221014061550.463644-14-namhyung@kernel.org>
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

It'd do more processing with aggregation.  Let's split the function so that it
can be shared with by process_stat_round_event() too.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bff28a199dfd..838d29590bed 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -465,15 +465,19 @@ static int read_bpf_map_counters(void)
 	return 0;
 }
 
-static void read_counters(struct timespec *rs)
+static int read_counters(struct timespec *rs)
 {
-	struct evsel *counter;
-
 	if (!stat_config.stop_read_counter) {
 		if (read_bpf_map_counters() ||
 		    read_affinity_counters(rs))
-			return;
+			return -1;
 	}
+	return 0;
+}
+
+static void process_counters(void)
+{
+	struct evsel *counter;
 
 	evlist__for_each_entry(evsel_list, counter) {
 		if (counter->err)
@@ -494,7 +498,8 @@ static void process_interval(void)
 	perf_stat__reset_shadow_per_stat(&rt_stat);
 	evlist__reset_aggr_stats(evsel_list);
 
-	read_counters(&rs);
+	if (read_counters(&rs) == 0)
+		process_counters();
 
 	if (STAT_RECORD) {
 		if (WRITE_STAT_ROUND_EVENT(rs.tv_sec * NSEC_PER_SEC + rs.tv_nsec, INTERVAL))
@@ -980,7 +985,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * avoid arbitrary skew, we must read all counters before closing any
 	 * group leaders.
 	 */
-	read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
+	if (read_counters(&(struct timespec) { .tv_nsec = t1-t0 }) == 0)
+		process_counters();
 
 	/*
 	 * We need to keep evsel_list alive, because it's processed
@@ -2099,13 +2105,11 @@ static int process_stat_round_event(struct perf_session *session,
 				    union perf_event *event)
 {
 	struct perf_record_stat_round *stat_round = &event->stat_round;
-	struct evsel *counter;
 	struct timespec tsh, *ts = NULL;
 	const char **argv = session->header.env.cmdline_argv;
 	int argc = session->header.env.nr_cmdline;
 
-	evlist__for_each_entry(evsel_list, counter)
-		perf_stat_process_counter(&stat_config, counter);
+	process_counters();
 
 	if (stat_round->type == PERF_STAT_ROUND_TYPE__FINAL)
 		update_stats(&walltime_nsecs_stats, stat_round->time);
-- 
2.38.0.413.g74048e4d9e-goog

