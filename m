Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07B3628D04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiKNXD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbiKNXDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:00 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C67D1BEB7;
        Mon, 14 Nov 2022 15:02:38 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r18so11564306pgr.12;
        Mon, 14 Nov 2022 15:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQA2ZacCoh/AZvzO4JvdY6xJYRgMztnwPe0iUU1Auf8=;
        b=YkO4x0Bw9IlbNI4xkAxR7I7V+we8MKO3/m8fpQwL+jO7uua/DLgZ71nEjrtOdR4qqW
         mRsLCi5tU7C3ZtFHyQ86It9WodsRsqljaFIfPbSbZEUxKVXKTSHVpqbC/i5irvrAvpzv
         rI602hCFVJWBzDVWnUdyf3yesVdSAeu6igM/m6eNgsK3QATy/sRL3ATAkQR+9NiXXkiT
         oqimadSmxNHbipGIVuCGQCJpIjUmn+0sc1VZJjwxQS8YPbwsj8dlZbuISpf/xAzCHci/
         Ydy9n3gD+3FGMmpX5Hbgri/kCAZG88cwOntzENde8WKK+POOKTxTwJ09p7P3hFjqNpBJ
         X13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQA2ZacCoh/AZvzO4JvdY6xJYRgMztnwPe0iUU1Auf8=;
        b=qLaQ3q1T/BwICn3gC5hdmTSqgb6BTeuqY4Kv7urV7YiNbFPOtvzUMlXBcjF2HVkw3p
         GMOibQ1pnHnvJlnYtHU4VDNRBllQ3krwyCZ0feLSNJxrzd2WXyrk741dX8iClFGGEfAI
         XBTGdh2hYkdvz0QL5RF5HBbThO91wRyZW0SwRcQFrdhqraxTJowcWlwr2YQggFWXH0r3
         yocyztJvV/pXc/rLFea/yy6iFgodic3wbl6LGn0GVl7spbOuJDQx6tylbZJ+Tz1vCdTn
         Vkw9+unaEuMtHaBbR9DUIthNkRyKZJ85eEf+zUCrgFrCRb0W8TL5m94dLXGD848B73/t
         yhXA==
X-Gm-Message-State: ANoB5pnirEeo4ftcFUkUNQADu2naMshyUsX2ERqe8aDjJUaCDv3z5PNa
        lVLJ8HKEZYJfdT6x83pFgLE=
X-Google-Smtp-Source: AA0mqf6vLnDzZtFdVVTWyDbkPHKbkW1bMRe3169tDO+quo29tD6Asfa3m4uoCHIPSjbyzSkxS3FfRA==
X-Received: by 2002:a63:c51:0:b0:475:7677:fa7f with SMTP id 17-20020a630c51000000b004757677fa7fmr11336058pgm.598.1668466957570;
        Mon, 14 Nov 2022 15:02:37 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:37 -0800 (PST)
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
Subject: [PATCH 05/19] perf stat: Split aggr_printout() function
Date:   Mon, 14 Nov 2022 15:02:13 -0800
Message-Id: <20221114230227.1255976-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221114230227.1255976-1-namhyung@kernel.org>
References: <20221114230227.1255976-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aggr_printout() function is to print aggr_id and count (nr).
Split it for each output mode to simplify the code.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 220 ++++++++++++++++++---------------
 1 file changed, 121 insertions(+), 99 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index af2a561eb20c..ed421f6d512f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -135,124 +135,135 @@ static void print_cgroup(struct perf_stat_config *config, struct evsel *evsel)
 	}
 }
 
-
-static void aggr_printout(struct perf_stat_config *config,
-			  struct evsel *evsel, struct aggr_cpu_id id, int nr)
+static void print_aggr_id_std(struct perf_stat_config *config,
+			      struct evsel *evsel, struct aggr_cpu_id id, int nr)
 {
+	FILE *output = config->output;
 
+	switch (config->aggr_mode) {
+	case AGGR_CORE:
+		fprintf(output, "S%d-D%d-C%*d %*d ",
+			id.socket, id.die, -8, id.core, 4, nr);
+		break;
+	case AGGR_DIE:
+		fprintf(output, "S%d-D%*d %*d ",
+			id.socket, -8, id.die, 4, nr);
+		break;
+	case AGGR_SOCKET:
+		fprintf(output, "S%*d %*d ",
+			-5, id.socket, 4, nr);
+		break;
+	case AGGR_NODE:
+		fprintf(output, "N%*d %*d ",
+			-5, id.node, 4, nr);
+		break;
+	case AGGR_NONE:
+		if (evsel->percore && !config->percore_show_thread) {
+			fprintf(output, "S%d-D%d-C%*d ",
+				id.socket, id.die, -3, id.core);
+		} else if (id.cpu.cpu > -1) {
+			fprintf(output, "CPU%*d ",
+				-7, id.cpu.cpu);
+		}
+		break;
+	case AGGR_THREAD:
+		fprintf(output, "%*s-%*d ",
+			16, perf_thread_map__comm(evsel->core.threads, id.thread_idx),
+			-8, perf_thread_map__pid(evsel->core.threads, id.thread_idx));
+		break;
+	case AGGR_GLOBAL:
+	case AGGR_UNSET:
+	case AGGR_MAX:
+	default:
+		break;
+	}
+}
 
-	if (config->json_output && !config->interval)
-		fprintf(config->output, "{");
+static void print_aggr_id_csv(struct perf_stat_config *config,
+			      struct evsel *evsel, struct aggr_cpu_id id, int nr)
+{
+	FILE *output = config->output;
+	const char *sep = config->csv_sep;
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		if (config->json_output) {
-			fprintf(config->output,
-				"\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
-				id.socket,
-				id.die,
-				id.core,
-				nr);
-		} else {
-			fprintf(config->output, "S%d-D%d-C%*d%s%*d%s",
-				id.socket,
-				id.die,
-				config->csv_output ? 0 : -8,
-				id.core,
-				config->csv_sep,
-				config->csv_output ? 0 : 4,
-				nr,
-				config->csv_sep);
-		}
+		fprintf(output, "S%d-D%d-C%d%s%d%s",
+			id.socket, id.die, id.core, sep, nr, sep);
 		break;
 	case AGGR_DIE:
-		if (config->json_output) {
-			fprintf(config->output,
-				"\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
-				id.socket,
-				id.die,
-				nr);
-		} else {
-			fprintf(config->output, "S%d-D%*d%s%*d%s",
-				id.socket,
-				config->csv_output ? 0 : -8,
-				id.die,
-				config->csv_sep,
-				config->csv_output ? 0 : 4,
-				nr,
-				config->csv_sep);
-		}
+		fprintf(output, "S%d-D%d%s%d%s",
+			id.socket, id.die, sep, nr, sep);
 		break;
 	case AGGR_SOCKET:
-		if (config->json_output) {
-			fprintf(config->output,
-				"\"socket\" : \"S%d\", \"aggregate-number\" : %d, ",
-				id.socket,
-				nr);
-		} else {
-			fprintf(config->output, "S%*d%s%*d%s",
-				config->csv_output ? 0 : -5,
-				id.socket,
-				config->csv_sep,
-				config->csv_output ? 0 : 4,
-				nr,
-				config->csv_sep);
-		}
+		fprintf(output, "S%d%s%d%s",
+			id.socket, sep, nr, sep);
 		break;
 	case AGGR_NODE:
-		if (config->json_output) {
-			fprintf(config->output, "\"node\" : \"N%d\", \"aggregate-number\" : %d, ",
-				id.node,
-				nr);
-		} else {
-			fprintf(config->output, "N%*d%s%*d%s",
-				config->csv_output ? 0 : -5,
-				id.node,
-				config->csv_sep,
-				config->csv_output ? 0 : 4,
-				nr,
-				config->csv_sep);
-		}
+		fprintf(output, "N%d%s%d%s",
+			id.node, sep, nr, sep);
 		break;
 	case AGGR_NONE:
-		if (config->json_output) {
-			if (evsel->percore && !config->percore_show_thread) {
-				fprintf(config->output, "\"core\" : \"S%d-D%d-C%d\"",
-					id.socket,
-					id.die,
-					id.core);
-			} else if (id.cpu.cpu > -1) {
-				fprintf(config->output, "\"cpu\" : \"%d\", ",
-					id.cpu.cpu);
-			}
-		} else {
-			if (evsel->percore && !config->percore_show_thread) {
-				fprintf(config->output, "S%d-D%d-C%*d%s",
-					id.socket,
-					id.die,
-					config->csv_output ? 0 : -3,
-					id.core, config->csv_sep);
-			} else if (id.cpu.cpu > -1) {
-				fprintf(config->output, "CPU%*d%s",
-					config->csv_output ? 0 : -7,
-					id.cpu.cpu, config->csv_sep);
-			}
+		if (evsel->percore && !config->percore_show_thread) {
+			fprintf(output, "S%d-D%d-C%d%s",
+				id.socket, id.die, id.core, sep);
+		} else if (id.cpu.cpu > -1) {
+			fprintf(output, "CPU%d%s",
+				id.cpu.cpu, sep);
 		}
 		break;
 	case AGGR_THREAD:
-		if (config->json_output) {
-			fprintf(config->output, "\"thread\" : \"%s-%d\", ",
-				perf_thread_map__comm(evsel->core.threads, id.thread_idx),
-				perf_thread_map__pid(evsel->core.threads, id.thread_idx));
-		} else {
-			fprintf(config->output, "%*s-%*d%s",
-				config->csv_output ? 0 : 16,
-				perf_thread_map__comm(evsel->core.threads, id.thread_idx),
-				config->csv_output ? 0 : -8,
-				perf_thread_map__pid(evsel->core.threads, id.thread_idx),
-				config->csv_sep);
+		fprintf(output, "%s-%d%s",
+			perf_thread_map__comm(evsel->core.threads, id.thread_idx),
+			perf_thread_map__pid(evsel->core.threads, id.thread_idx),
+			sep);
+		break;
+	case AGGR_GLOBAL:
+	case AGGR_UNSET:
+	case AGGR_MAX:
+	default:
+		break;
+	}
+}
+
+static void print_aggr_id_json(struct perf_stat_config *config,
+			       struct evsel *evsel, struct aggr_cpu_id id, int nr)
+{
+	FILE *output = config->output;
+
+	if (!config->interval)
+		fputc('{', output);
+
+	switch (config->aggr_mode) {
+	case AGGR_CORE:
+		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
+			id.socket, id.die, id.core, nr);
+		break;
+	case AGGR_DIE:
+		fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
+			id.socket, id.die, nr);
+		break;
+	case AGGR_SOCKET:
+		fprintf(output, "\"socket\" : \"S%d\", \"aggregate-number\" : %d, ",
+			id.socket, nr);
+		break;
+	case AGGR_NODE:
+		fprintf(output, "\"node\" : \"N%d\", \"aggregate-number\" : %d, ",
+			id.node, nr);
+		break;
+	case AGGR_NONE:
+		if (evsel->percore && !config->percore_show_thread) {
+			fprintf(output, "\"core\" : \"S%d-D%d-C%d\"",
+				id.socket, id.die, id.core);
+		} else if (id.cpu.cpu > -1) {
+			fprintf(output, "\"cpu\" : \"%d\", ",
+				id.cpu.cpu);
 		}
 		break;
+	case AGGR_THREAD:
+		fprintf(output, "\"thread\" : \"%s-%d\", ",
+			perf_thread_map__comm(evsel->core.threads, id.thread_idx),
+			perf_thread_map__pid(evsel->core.threads, id.thread_idx));
+		break;
 	case AGGR_GLOBAL:
 	case AGGR_UNSET:
 	case AGGR_MAX:
@@ -261,6 +272,17 @@ static void aggr_printout(struct perf_stat_config *config,
 	}
 }
 
+static void aggr_printout(struct perf_stat_config *config,
+			  struct evsel *evsel, struct aggr_cpu_id id, int nr)
+{
+	if (config->json_output)
+		print_aggr_id_json(config, evsel, id, nr);
+	else if (config->csv_output)
+		print_aggr_id_csv(config, evsel, id, nr);
+	else
+		print_aggr_id_std(config, evsel, id, nr);
+}
+
 struct outstate {
 	FILE *fh;
 	bool newline;
-- 
2.38.1.493.g58b659f92b-goog

