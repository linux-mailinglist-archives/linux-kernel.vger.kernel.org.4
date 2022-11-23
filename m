Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9663683D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiKWSEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239404AbiKWSC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:29 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B297F97AAD;
        Wed, 23 Nov 2022 10:02:25 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j12so17327390plj.5;
        Wed, 23 Nov 2022 10:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7/IN2ZK+T3PH7QZiJw53n5Bc5bJOMsHQZPX+sQ32KA=;
        b=H2/E7pDeLeUnIttCMj54h68ZJtX3hF4JwGs4ltH0jeDgik+tJS3Pyxkv27c6oryxsX
         hCmA/MaEt37OC9aDHxYzGsVoUvWXyEawiVY8GV7kQH9vscA9liTMKP86MeXL2X/L+uz6
         hsQaAdi3bPNq4woxvUBy56trLk//HSuI8wPlQrg0AOn8cfCs60fNoaQHaua/hohGyBu0
         29HultPMnuRnRPleLeI1f5pCjqsV+PfMqBl5lt2nqN2YGK3inHnyR0SQMDuTHTqHmVKM
         1tdadkml2r1ECbpOl0182H2WJrg83s07YCYxVOCFL2lnu96l2UQIRn8TMuVJCSOnwCsM
         XXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z7/IN2ZK+T3PH7QZiJw53n5Bc5bJOMsHQZPX+sQ32KA=;
        b=kwsr4zL/84A8RIVB/DrqnTpgTSklh2H3MI59/RGs9kuf9bEM8bL/GaljH6xSd5sVWS
         6y94Hs0uIA97GpVwoSxGifdf8LBtaJGvxXviMeDdo30LCeg5IRosLTyXgMmEzGTN+g4F
         ik+icTsl5cmqhjeIvHEEAIS1OT+PttAgbLg7rLg6MTdldb2bwn4q2BelQjF3vfAt8sQR
         Be/QRwT9/kgZ0XopNyEo0ic3TbBDOa6CMJ8qxFXai+EOGYBJauKgrkO+JSSP5HNiM57G
         qlU8AGcSj2VcDTd9bcrn1lEpRCWZmal4j9W+N63ttDCt6+D8/x59K5oO5qWjVl/l4PQt
         tNsg==
X-Gm-Message-State: ANoB5pnzG9iZB9X7tS8qJVlTxyXGqgyJt/Q1gCwEVjhlGeh8bpTjtpw1
        o+jJKpmezoVzNuE8JNcDQS0=
X-Google-Smtp-Source: AA0mqf6jaECcTG/rjhI2kVRNRLvIlQ3hIxcYeY27o2IAvvhKaQE0OzBAjTTtWaSOZY9drXjojyYSBw==
X-Received: by 2002:a17:902:b611:b0:189:1c94:99c3 with SMTP id b17-20020a170902b61100b001891c9499c3mr9988999pls.140.1669226545113;
        Wed, 23 Nov 2022 10:02:25 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:24 -0800 (PST)
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 10/15] perf stat: Pass struct outstate to printout()
Date:   Wed, 23 Nov 2022 10:02:03 -0800
Message-Id: <20221123180208.2068936-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123180208.2068936-1-namhyung@kernel.org>
References: <20221123180208.2068936-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printout() takes a lot of arguments and sets an outstate with the
value.  Instead, we can fill the outstate first and then pass it to
reduce the number of arguments.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 38 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 3ed63061d6f8..dd190f71e933 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -673,22 +673,15 @@ static bool is_mixed_hw_group(struct evsel *counter)
 	return false;
 }
 
-static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int nr,
-		     struct evsel *counter, double uval,
-		     const char *prefix, u64 run, u64 ena, double noise,
+static void printout(struct perf_stat_config *config, struct outstate *os,
+		     double uval, u64 run, u64 ena, double noise,
 		     struct runtime_stat *st, int map_idx)
 {
 	struct perf_stat_output_ctx out;
-	struct outstate os = {
-		.fh = config->output,
-		.prefix = prefix ? prefix : "",
-		.id = id,
-		.nr = nr,
-		.evsel = counter,
-	};
 	print_metric_t pm;
 	new_line_t nl;
 	bool ok = true;
+	struct evsel *counter = os->evsel;
 
 	if (config->csv_output) {
 		static const int aggr_fields[AGGR_MAX] = {
@@ -704,7 +697,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 
 		pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
 		nl = config->metric_only ? new_line_metric : new_line_csv;
-		os.nfields = 3 + aggr_fields[config->aggr_mode] + (counter->cgrp ? 1 : 0);
+		os->nfields = 3 + aggr_fields[config->aggr_mode] + (counter->cgrp ? 1 : 0);
 	} else if (config->json_output) {
 		pm = config->metric_only ? print_metric_only_json : print_metric_json;
 		nl = config->metric_only ? new_line_metric : new_line_json;
@@ -715,7 +708,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 
 	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
 		if (config->metric_only) {
-			pm(config, &os, NULL, "", "", 0);
+			pm(config, os, NULL, "", "", 0);
 			return;
 		}
 
@@ -732,11 +725,11 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 
 	out.print_metric = pm;
 	out.new_line = nl;
-	out.ctx = &os;
+	out.ctx = os;
 	out.force_header = false;
 
 	if (!config->metric_only) {
-		abs_printout(config, id, nr, counter, uval, ok);
+		abs_printout(config, os->id, os->nr, counter, uval, ok);
 
 		print_noise(config, counter, noise, /*before_metric=*/true);
 		print_running(config, run, ena, /*before_metric=*/true);
@@ -814,6 +807,13 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	struct aggr_cpu_id id = config->aggr_map->map[s];
 	double avg = aggr->counts.val;
 	bool metric_only = config->metric_only;
+	struct outstate os = {
+		.fh = config->output,
+		.prefix = prefix ? prefix : "",
+		.id = id,
+		.nr = aggr->nr,
+		.evsel = counter,
+	};
 
 	if (counter->supported && aggr->nr == 0)
 		return;
@@ -834,8 +834,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 
 	uval = val * counter->scale;
 
-	printout(config, id, aggr->nr, counter, uval,
-		 prefix, run, ena, avg, &rt_stat, s);
+	printout(config, &os, uval, run, ena, avg, &rt_stat, s);
 
 	if (!metric_only)
 		fputc('\n', output);
@@ -971,14 +970,14 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			u64 ena, run, val;
 			double uval;
-			struct aggr_cpu_id id;
 			struct perf_stat_evsel *ps = counter->stats;
 			int counter_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
 
 			if (counter_idx < 0)
 				continue;
 
-			id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
+			os.evsel = counter;
+			os.id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
 				print_metric_begin(config, evlist, &os, counter_idx);
 				first = false;
@@ -988,8 +987,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			run = ps->aggr[counter_idx].counts.run;
 
 			uval = val * counter->scale;
-			printout(config, id, 0, counter, uval, prefix,
-				 run, ena, 1.0, &rt_stat, counter_idx);
+			printout(config, &os, uval, run, ena, 1.0, &rt_stat, counter_idx);
 		}
 		if (!first)
 			print_metric_end(config);
-- 
2.38.1.584.g0f3c55d4c2-goog

