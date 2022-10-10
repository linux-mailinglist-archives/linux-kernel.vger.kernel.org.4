Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F45F97DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiJJFhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiJJFgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE75751A36;
        Sun,  9 Oct 2022 22:36:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x6so9426496pll.11;
        Sun, 09 Oct 2022 22:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVp7QO5gScJA8AxQSNpgBWJ7D8KPtvuVD0QAyAFrK9k=;
        b=pgSUYrhUsHdMphQ2ELS8NgtgoQwE17K+FELU1Gul8g23xltkGaenWl85mWB/PXcetp
         aQSIFit/CcNr60DZHtPok4yIF51qJCwMzKKZCTg+aJvWfS0hPlPSgPoGicuxjK6RlMC2
         cnlJaCufUtfobqF1lh/tVq3Nj0kueP56xWU3U7MZXEmKVylU7TPrH1X+hoiEeVvzxofY
         KhwsIgOnqpxG9Rj1wyTEa9Qq7AwB1kPkLmrBuTzRSPgUeGu5YbERIE3TUS+PRdAogAVH
         msT8HrDaySwnjuZ+Z1/FUJNJivK8ID9+xgWvlafyCR9Ew2KTV2QjnfXkyDRCZqrgbFkf
         1W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IVp7QO5gScJA8AxQSNpgBWJ7D8KPtvuVD0QAyAFrK9k=;
        b=XceIsm8MDp3nU3oGumxsfMJ62UTpHJtjJOvwMiaOCwmLmBoJnnuxa1tE/NBRjDZ6W2
         O1NNFxl1o1APfMkd5uj4UT/zMqjNNC5iH14znps+VWoSOl/8HWUlI4+qbNJfN82LIT8E
         jJyI4k1wcnP/B78PBVKOZSByYhCpW4PraRUvNhhtB03ctZ+r8aloyh/73a8JpACbCwHx
         LXvpN6h7JdR15Arkqvhfv76U5WKrnrgynCDvNl2vDW3vnfmPvsgSUWOPoffFKwKAJvDj
         tqQ0dasFhsjotz0ajbEWEH3n5ndf4R+CktBE5MW6cQhwoGGSmqBUF5bmmtkirujvH/a7
         rnLw==
X-Gm-Message-State: ACrzQf0k8EhgCO7gZ5g+O6Wc5Wc+oxv47+tjSq2bASW50gZcc0zG/hrZ
        +rXOagvEu9kQ1Hvh/6vf/XA=
X-Google-Smtp-Source: AMsMyM7w6jDKcYFzMgtGxHebXMX1mCzNtzlWwgvrGNMy8+yl606mCRN5M6pYVp1P3SIdWjKVuHDW3Q==
X-Received: by 2002:a17:90b:1b10:b0:20d:30a5:49a9 with SMTP id nu16-20020a17090b1b1000b0020d30a549a9mr6670303pjb.77.1665380182237;
        Sun, 09 Oct 2022 22:36:22 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:21 -0700 (PDT)
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
Date:   Sun,  9 Oct 2022 22:35:54 -0700
Message-Id: <20221010053600.272854-14-namhyung@kernel.org>
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

It'd do more processing with aggregation.  Let's split the function so that it
can be shared with by process_stat_round_event() too.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 38036f40e993..49a7e290d778 100644
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
@@ -2098,13 +2104,11 @@ static int process_stat_round_event(struct perf_session *session,
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
2.38.0.rc1.362.ged0d419d3c-goog

