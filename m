Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D5628D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiKNXEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiKNXD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:28 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FC41CB0A;
        Mon, 14 Nov 2022 15:02:49 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k15so12492285pfg.2;
        Mon, 14 Nov 2022 15:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdSXH2XNQ9roh/KzmA1z2gWpKkgATPTblDS61GUpaBA=;
        b=ZT5M/yamNTOk1Rn4OcEY45AtaAUNBZtM/Sgo0tJSRMJZlx5aRes24EQbnklxKvzNEe
         vbUxlPeCZSvib23VaNatAHR1hKo/7UiHQslWW9n1eNKA4hlNoryFwytlyiNYg/lFiG7L
         P+f/BgNTA0dyKGGd0GePVy1Ipuhxed4CNMfRbgdGfWRCv5iNiWDig6GdRVcKIzNSFWDQ
         vCjL//uC77ytjKWfsOPUftbLkArQgt1Ps7P2jXqxdMcbWWauFbWbhWcs9uWrtNwL8ql7
         iMG9KfBkPVaUmdJvUJKiE55OobsmepWhpKrxQygs8XPTAd+3SDOG/v02M0xXFEVswt+9
         KPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NdSXH2XNQ9roh/KzmA1z2gWpKkgATPTblDS61GUpaBA=;
        b=QZO5XYQtTIONLRjl/sXqJbficyPJYmBTHwA41ckzhsA3JIWFfRg1MlEeXxY8rAxrrq
         bydPkLjha/i4/diI2kgnRaUHsqpYxVY8rZS+szzP9rhD2Wp67QnSG+CNc5xhUzaqnAQT
         r2jpib0CIRzcz1tXJCKOqrZ/SVaKfbk69HDwa75A5rgZCW7Q5DnBHyj6tHiHD2X7wVTd
         yBhpRp55bbcfBACMY9zHUMTahT+L9othtVDTrY4m+pmWJoKgroH6LjWqhZWDbEBcBwd8
         G7X2+OLjMCI7Mci4DMmcosIfaugH078JGlmiI9APrp27C/fTygKPOzn6wr8W+o7Z2Lms
         ETRQ==
X-Gm-Message-State: ANoB5pnH0cKeN41bz/yJ8JW021nhg9YWZhZFxO+vIjPi/EtJjSMAHkUy
        BfmxBAquMsiIhqrQVQoske8=
X-Google-Smtp-Source: AA0mqf7zBE/3J/Ok62CY0Mg1NnBPmHFyw8CB9CZewTn6i9C1g5zTU2D02fWdNhAjkeER797wIyqpsQ==
X-Received: by 2002:a63:f747:0:b0:434:7885:6adf with SMTP id f7-20020a63f747000000b0043478856adfmr13396224pgk.236.1668466968477;
        Mon, 14 Nov 2022 15:02:48 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:48 -0800 (PST)
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
Subject: [PATCH 12/19] perf stat: Cleanup interval print alignment
Date:   Mon, 14 Nov 2022 15:02:20 -0800
Message-Id: <20221114230227.1255976-13-namhyung@kernel.org>
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

Instead of using magic values, define symbolic constants and use them.
Also add aggr_header_std[] array to simplify aggr_mode handling.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 165 ++++++++++++++++++---------------
 1 file changed, 91 insertions(+), 74 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index c234be656db9..f983432aaddd 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -25,6 +25,45 @@
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
 
+#define METRIC_LEN   38
+#define EVNAME_LEN   32
+#define COUNTS_LEN   18
+#define INTERVAL_LEN 16
+#define CGROUP_LEN   16
+#define COMM_LEN     16
+#define PID_LEN       7
+#define CPUS_LEN      4
+
+static int aggr_header_lens[] = {
+	[AGGR_CORE] 	= 18,
+	[AGGR_DIE] 	= 12,
+	[AGGR_SOCKET] 	= 6,
+	[AGGR_NODE] 	= 6,
+	[AGGR_NONE] 	= 6,
+	[AGGR_THREAD] 	= 16,
+	[AGGR_GLOBAL] 	= 0,
+};
+
+static const char *aggr_header_csv[] = {
+	[AGGR_CORE] 	= 	"core,cpus,",
+	[AGGR_DIE] 	= 	"die,cpus,",
+	[AGGR_SOCKET] 	= 	"socket,cpus,",
+	[AGGR_NONE] 	= 	"cpu,",
+	[AGGR_THREAD] 	= 	"comm-pid,",
+	[AGGR_NODE] 	= 	"node,",
+	[AGGR_GLOBAL] 	=	""
+};
+
+static const char *aggr_header_std[] = {
+	[AGGR_CORE] 	= 	"core",
+	[AGGR_DIE] 	= 	"die",
+	[AGGR_SOCKET] 	= 	"socket",
+	[AGGR_NONE] 	= 	"cpu",
+	[AGGR_THREAD] 	= 	"comm-pid",
+	[AGGR_NODE] 	= 	"node",
+	[AGGR_GLOBAL] 	=	""
+};
+
 static void print_running_std(struct perf_stat_config *config, u64 run, u64 ena)
 {
 	if (run != ena)
@@ -116,7 +155,7 @@ static void print_noise(struct perf_stat_config *config,
 
 static void print_cgroup_std(struct perf_stat_config *config, const char *cgrp_name)
 {
-	fprintf(config->output, " %-16s", cgrp_name);
+	fprintf(config->output, " %-*s", CGROUP_LEN, cgrp_name);
 }
 
 static void print_cgroup_csv(struct perf_stat_config *config, const char *cgrp_name)
@@ -147,44 +186,46 @@ static void print_aggr_id_std(struct perf_stat_config *config,
 			      struct evsel *evsel, struct aggr_cpu_id id, int nr)
 {
 	FILE *output = config->output;
+	int idx = config->aggr_mode;
+	char buf[128];
 
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
-		fprintf(output, "S%d-D%d-C%*d %*d ",
-			id.socket, id.die, -8, id.core, 4, nr);
+		snprintf(buf, sizeof(buf), "S%d-D%d-C%d", id.socket, id.die, id.core);
 		break;
 	case AGGR_DIE:
-		fprintf(output, "S%d-D%*d %*d ",
-			id.socket, -8, id.die, 4, nr);
+		snprintf(buf, sizeof(buf), "S%d-D%d", id.socket, id.die);
 		break;
 	case AGGR_SOCKET:
-		fprintf(output, "S%*d %*d ",
-			-5, id.socket, 4, nr);
+		snprintf(buf, sizeof(buf), "S%d", id.socket);
 		break;
 	case AGGR_NODE:
-		fprintf(output, "N%*d %*d ",
-			-5, id.node, 4, nr);
+		snprintf(buf, sizeof(buf), "N%d", id.node);
 		break;
 	case AGGR_NONE:
 		if (evsel->percore && !config->percore_show_thread) {
-			fprintf(output, "S%d-D%d-C%*d ",
-				id.socket, id.die, -3, id.core);
+			snprintf(buf, sizeof(buf), "S%d-D%d-C%d ",
+				id.socket, id.die, id.core);
+			fprintf(output, "%-*s ",
+				aggr_header_lens[AGGR_CORE], buf);
 		} else if (id.cpu.cpu > -1) {
-			fprintf(output, "CPU%*d ",
-				-7, id.cpu.cpu);
+			fprintf(output, "CPU%-*d ",
+				aggr_header_lens[AGGR_NONE] - 3, id.cpu.cpu);
 		}
-		break;
+		return;
 	case AGGR_THREAD:
-		fprintf(output, "%*s-%*d ",
-			16, perf_thread_map__comm(evsel->core.threads, id.thread_idx),
-			-8, perf_thread_map__pid(evsel->core.threads, id.thread_idx));
-		break;
+		fprintf(output, "%*s-%-*d ",
+			COMM_LEN, perf_thread_map__comm(evsel->core.threads, id.thread_idx),
+			PID_LEN, perf_thread_map__pid(evsel->core.threads, id.thread_idx));
+		return;
 	case AGGR_GLOBAL:
 	case AGGR_UNSET:
 	case AGGR_MAX:
 	default:
-		break;
+		return;
 	}
+
+	fprintf(output, "%-*s %*d ", aggr_header_lens[idx], buf, 4, nr);
 }
 
 static void print_aggr_id_csv(struct perf_stat_config *config,
@@ -301,8 +342,6 @@ struct outstate {
 	struct evsel *evsel;
 };
 
-#define METRIC_LEN  38
-
 static void new_line_std(struct perf_stat_config *config __maybe_unused,
 			 void *ctx)
 {
@@ -534,19 +573,19 @@ static void print_counter_value_std(struct perf_stat_config *config,
 	const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
 
 	if (config->big_num)
-		fmt = floor(sc) != sc ? "%'18.2f " : "%'18.0f ";
+		fmt = floor(sc) != sc ? "%'*.2f " : "%'*.0f ";
 	else
-		fmt = floor(sc) != sc ? "%18.2f " : "%18.0f ";
+		fmt = floor(sc) != sc ? "%*.2f " : "%*.0f ";
 
 	if (ok)
-		fprintf(output, fmt, avg);
+		fprintf(output, fmt, COUNTS_LEN, avg);
 	else
-		fprintf(output, "%18s ", bad_count);
+		fprintf(output, "%*s ", COUNTS_LEN, bad_count);
 
 	if (evsel->unit)
 		fprintf(output, "%-*s ", config->unit_width, evsel->unit);
 
-	fprintf(output, "%-*s", 32, evsel__name(evsel));
+	fprintf(output, "%-*s", EVNAME_LEN, evsel__name(evsel));
 }
 
 static void print_counter_value_csv(struct perf_stat_config *config,
@@ -904,34 +943,19 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 	}
 }
 
-static int aggr_header_lens[] = {
-	[AGGR_CORE] = 24,
-	[AGGR_DIE] = 18,
-	[AGGR_SOCKET] = 12,
-	[AGGR_NONE] = 6,
-	[AGGR_THREAD] = 24,
-	[AGGR_NODE] = 6,
-	[AGGR_GLOBAL] = 0,
-};
-
-static const char *aggr_header_csv[] = {
-	[AGGR_CORE] 	= 	"core,cpus,",
-	[AGGR_DIE] 	= 	"die,cpus,",
-	[AGGR_SOCKET] 	= 	"socket,cpus,",
-	[AGGR_NONE] 	= 	"cpu,",
-	[AGGR_THREAD] 	= 	"comm-pid,",
-	[AGGR_NODE] 	= 	"node,",
-	[AGGR_GLOBAL] 	=	""
-};
-
 static void print_metric_headers_std(struct perf_stat_config *config,
 				     const char *prefix, bool no_indent)
 {
 	if (prefix)
 		fprintf(config->output, "%s", prefix);
+
 	if (!no_indent) {
-		fprintf(config->output, "%*s",
-			aggr_header_lens[config->aggr_mode], "");
+		int len = aggr_header_lens[config->aggr_mode];
+
+		if (nr_cgroups)
+			len += CGROUP_LEN + 1;
+
+		fprintf(config->output, "%*s", len, "");
 	}
 }
 
@@ -1025,46 +1049,39 @@ static void print_interval(struct perf_stat_config *config,
 			!config->csv_output && !config->json_output) {
 		switch (config->aggr_mode) {
 		case AGGR_NODE:
-			fprintf(output, "#           time node   cpus");
-			if (!metric_only)
-				fprintf(output, "             counts %*s events\n", unit_width, "unit");
-			break;
 		case AGGR_SOCKET:
-			fprintf(output, "#           time socket cpus");
-			if (!metric_only)
-				fprintf(output, "             counts %*s events\n", unit_width, "unit");
-			break;
 		case AGGR_DIE:
-			fprintf(output, "#           time die          cpus");
-			if (!metric_only)
-				fprintf(output, "             counts %*s events\n", unit_width, "unit");
-			break;
 		case AGGR_CORE:
-			fprintf(output, "#           time core            cpus");
-			if (!metric_only)
-				fprintf(output, "             counts %*s events\n", unit_width, "unit");
+			fprintf(output, "#%*s %-*s cpus",
+				INTERVAL_LEN - 1, "time",
+				aggr_header_lens[config->aggr_mode],
+				aggr_header_std[config->aggr_mode]);
 			break;
 		case AGGR_NONE:
-			fprintf(output, "#           time CPU    ");
-			if (!metric_only)
-				fprintf(output, "                counts %*s events\n", unit_width, "unit");
+			fprintf(output, "#%*s %-*s",
+				INTERVAL_LEN - 1, "time",
+				aggr_header_lens[config->aggr_mode],
+				aggr_header_std[config->aggr_mode]);
 			break;
 		case AGGR_THREAD:
-			fprintf(output, "#           time             comm-pid");
-			if (!metric_only)
-				fprintf(output, "                  counts %*s events\n", unit_width, "unit");
+			fprintf(output, "#%*s %*s-%-*s",
+				INTERVAL_LEN - 1, "time",
+				COMM_LEN, "comm", PID_LEN, "pid");
 			break;
 		case AGGR_GLOBAL:
 		default:
-			if (!config->iostat_run) {
-				fprintf(output, "#           time");
-				if (!metric_only)
-					fprintf(output, "             counts %*s events\n", unit_width, "unit");
-			}
+			if (!config->iostat_run)
+				fprintf(output, "#%*s",
+					INTERVAL_LEN - 1, "time");
 		case AGGR_UNSET:
 		case AGGR_MAX:
 			break;
 		}
+
+		if (!metric_only) {
+			fprintf(output, " %*s %*s events\n",
+				COUNTS_LEN, "counts", unit_width, "unit");
+		}
 	}
 
 	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
-- 
2.38.1.493.g58b659f92b-goog

