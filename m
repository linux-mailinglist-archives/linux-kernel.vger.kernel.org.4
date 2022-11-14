Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60EA628D10
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiKNXEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbiKNXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:31 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1361CFD7;
        Mon, 14 Nov 2022 15:02:52 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so12505020pfb.0;
        Mon, 14 Nov 2022 15:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1MFej65CJ+NfpSltvQHgaIoZB+GNGl8r1EVGrPKTcw=;
        b=IW59hFHwqet/9Q/o/UQ0AVw+mr0ZNMfZjssD1fodhAMyVGc2eH+XfTVtKBHHBqJb+/
         1R7WCwgfTFYpGCqd5w2+nLn7cTLdvw6SMoD5w5FIYKfZ6mMXfNliPgBDtjuUCApb+YLC
         1eh6rALcUJ+GVOlGsDJ7nzr35xz1QK2ZYFEGEmA6j663ZRW4KsCqjkREJo7UYcPGrZIp
         b8YoHQzBRCJnYxoWs/7qGzbzcEKUcubEyBVJA/H/2B3+wlZaHeDhZbzXJMSVynlABCWi
         +8gBiIknECUMF4KRSZRvzdW6k4mWVMWVNWnmF8cFPM0YFHd5U7BawFF/gYJ+ZuqjT72s
         qeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a1MFej65CJ+NfpSltvQHgaIoZB+GNGl8r1EVGrPKTcw=;
        b=c9Q865EwcUVMMB75CU14xR0t613DzzzFLR06rhTEsftCkVI7zRuM6X1XlxNe6zfR3S
         38sA8BGaciHVCOlMROztB34XMauDtr0B8fkGu98TY/mbl2X4zy356m8ZD6yqYrOaoP6N
         X+0DWoXwp1oDv+b+8Sz3BFe/meDSl/DOy3+/fyawSvfW+V9jAaQb5WvskZVUKeOeApu2
         oSlVjlTlsGzU28mIj5EYFAIknxdfEEZVO/x7cAUFVmrV8UttYPz7MDuc5SFAg62UzEOq
         5nK2DYVSy2OhXUVXjC29LmaLKSFky2nyKXbRwDZQB0hjFB7xL+7NSZOLKxprfjN1nIQC
         ZP4Q==
X-Gm-Message-State: ANoB5pkPwhqE4L/hmyHthdDIZ/1Kj7Ht1NdH+QJcG8FzwB/Wzl3QeLxJ
        EWKWFZ+f31r+uVx1Mx7jMmQ=
X-Google-Smtp-Source: AA0mqf7AbQUxfLKKrIeLSw2aMRv8qsVKLl7ikB9tyPzfvE7g5pkbFbbjgarBMx0+lJafOWK3cUNwmw==
X-Received: by 2002:aa7:956d:0:b0:56e:924e:ee22 with SMTP id x13-20020aa7956d000000b0056e924eee22mr15655339pfq.34.1668466971685;
        Mon, 14 Nov 2022 15:02:51 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:51 -0800 (PST)
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
Subject: [PATCH 14/19] perf stat: Rework header display
Date:   Mon, 14 Nov 2022 15:02:22 -0800
Message-Id: <20221114230227.1255976-15-namhyung@kernel.org>
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

There are print_header() and print_interval() to print header lines before
actual counter values.  Also print_metric_headers() needs to be called for
the metric-only case.

Let's move all these logics to a single place including num_print_iv to
refresh the headers for interval mode.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 185 +++++++++++++++++++--------------
 1 file changed, 106 insertions(+), 79 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index cc8bb6d07dcb..f97817628478 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1034,94 +1034,129 @@ static void prepare_interval(struct perf_stat_config *config,
 				 ts->tv_sec, ts->tv_nsec);
 }
 
-static void print_interval(struct perf_stat_config *config,
-			   struct evlist *evlist)
+static void print_header_interval_std(struct perf_stat_config *config,
+				      struct target *_target __maybe_unused,
+				      struct evlist *evlist,
+				      int argc __maybe_unused,
+				      const char **argv __maybe_unused)
 {
-	bool metric_only = config->metric_only;
-	unsigned int unit_width = config->unit_width;
 	FILE *output = config->output;
-	static int num_print_interval;
 
-	if (config->interval_clear && isatty(fileno(output)))
-		puts(CONSOLE_CLEAR);
+	switch (config->aggr_mode) {
+	case AGGR_NODE:
+	case AGGR_SOCKET:
+	case AGGR_DIE:
+	case AGGR_CORE:
+		fprintf(output, "#%*s %-*s cpus",
+			INTERVAL_LEN - 1, "time",
+			aggr_header_lens[config->aggr_mode],
+			aggr_header_std[config->aggr_mode]);
+		break;
+	case AGGR_NONE:
+		fprintf(output, "#%*s %-*s",
+			INTERVAL_LEN - 1, "time",
+			aggr_header_lens[config->aggr_mode],
+			aggr_header_std[config->aggr_mode]);
+		break;
+	case AGGR_THREAD:
+		fprintf(output, "#%*s %*s-%-*s",
+			INTERVAL_LEN - 1, "time",
+			COMM_LEN, "comm", PID_LEN, "pid");
+		break;
+	case AGGR_GLOBAL:
+	default:
+		if (!config->iostat_run)
+			fprintf(output, "#%*s",
+				INTERVAL_LEN - 1, "time");
+	case AGGR_UNSET:
+	case AGGR_MAX:
+		break;
+	}
 
-	if ((num_print_interval == 0 || config->interval_clear) &&
-			!config->csv_output && !config->json_output) {
-		switch (config->aggr_mode) {
-		case AGGR_NODE:
-		case AGGR_SOCKET:
-		case AGGR_DIE:
-		case AGGR_CORE:
-			fprintf(output, "#%*s %-*s cpus",
-				INTERVAL_LEN - 1, "time",
-				aggr_header_lens[config->aggr_mode],
-				aggr_header_std[config->aggr_mode]);
-			break;
-		case AGGR_NONE:
-			fprintf(output, "#%*s %-*s",
-				INTERVAL_LEN - 1, "time",
-				aggr_header_lens[config->aggr_mode],
-				aggr_header_std[config->aggr_mode]);
-			break;
-		case AGGR_THREAD:
-			fprintf(output, "#%*s %*s-%-*s",
-				INTERVAL_LEN - 1, "time",
-				COMM_LEN, "comm", PID_LEN, "pid");
-			break;
-		case AGGR_GLOBAL:
-		default:
-			if (!config->iostat_run)
-				fprintf(output, "#%*s",
-					INTERVAL_LEN - 1, "time");
-		case AGGR_UNSET:
-		case AGGR_MAX:
-			break;
-		}
+	if (config->metric_only)
+		print_metric_headers(config, evlist, " ", true);
+	else
+		fprintf(output, " %*s %*s events\n",
+			COUNTS_LEN, "counts", config->unit_width, "unit");
+}
 
-		if (!metric_only) {
-			fprintf(output, " %*s %*s events\n",
-				COUNTS_LEN, "counts", unit_width, "unit");
-		}
-	}
+static void print_header_std(struct perf_stat_config *config,
+			     struct target *_target, struct evlist *evlist,
+			     int argc, const char **argv)
+{
+	FILE *output = config->output;
+	int i;
+
+	fprintf(output, "\n");
+	fprintf(output, " Performance counter stats for ");
+	if (_target->bpf_str)
+		fprintf(output, "\'BPF program(s) %s", _target->bpf_str);
+	else if (_target->system_wide)
+		fprintf(output, "\'system wide");
+	else if (_target->cpu_list)
+		fprintf(output, "\'CPU(s) %s", _target->cpu_list);
+	else if (!target__has_task(_target)) {
+		fprintf(output, "\'%s", argv ? argv[0] : "pipe");
+		for (i = 1; argv && (i < argc); i++)
+			fprintf(output, " %s", argv[i]);
+	} else if (_target->pid)
+		fprintf(output, "process id \'%s", _target->pid);
+	else
+		fprintf(output, "thread id \'%s", _target->tid);
 
-	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
+	fprintf(output, "\'");
+	if (config->run_count > 1)
+		fprintf(output, " (%d runs)", config->run_count);
+	fprintf(output, ":\n\n");
+
+	if (config->metric_only)
+		print_metric_headers(config, evlist, " ", false);
+}
+
+static void print_header_csv(struct perf_stat_config *config,
+			     struct target *_target __maybe_unused,
+			     struct evlist *evlist,
+			     int argc __maybe_unused,
+			     const char **argv __maybe_unused)
+{
+	if (config->metric_only)
+		print_metric_headers(config, evlist, " ", true);
+}
+static void print_header_json(struct perf_stat_config *config,
+			      struct target *_target __maybe_unused,
+			      struct evlist *evlist,
+			      int argc __maybe_unused,
+			      const char **argv __maybe_unused)
+{
+	if (config->metric_only)
 		print_metric_headers(config, evlist, " ", true);
-	if (++num_print_interval == 25)
-		num_print_interval = 0;
 }
 
 static void print_header(struct perf_stat_config *config,
 			 struct target *_target,
+			 struct evlist *evlist,
 			 int argc, const char **argv)
 {
-	FILE *output = config->output;
-	int i;
+	static int num_print_iv;
 
 	fflush(stdout);
 
-	if (!config->csv_output && !config->json_output) {
-		fprintf(output, "\n");
-		fprintf(output, " Performance counter stats for ");
-		if (_target->bpf_str)
-			fprintf(output, "\'BPF program(s) %s", _target->bpf_str);
-		else if (_target->system_wide)
-			fprintf(output, "\'system wide");
-		else if (_target->cpu_list)
-			fprintf(output, "\'CPU(s) %s", _target->cpu_list);
-		else if (!target__has_task(_target)) {
-			fprintf(output, "\'%s", argv ? argv[0] : "pipe");
-			for (i = 1; argv && (i < argc); i++)
-				fprintf(output, " %s", argv[i]);
-		} else if (_target->pid)
-			fprintf(output, "process id \'%s", _target->pid);
-		else
-			fprintf(output, "thread id \'%s", _target->tid);
+	if (config->interval_clear)
+		puts(CONSOLE_CLEAR);
 
-		fprintf(output, "\'");
-		if (config->run_count > 1)
-			fprintf(output, " (%d runs)", config->run_count);
-		fprintf(output, ":\n\n");
+	if (num_print_iv == 0 || config->interval_clear) {
+		if (config->json_output)
+			print_header_json(config, _target, evlist, argc, argv);
+		else if (config->csv_output)
+			print_header_csv(config, _target, evlist, argc, argv);
+		else if (config->interval)
+			print_header_interval_std(config, _target, evlist, argc, argv);
+		else
+			print_header_std(config, _target, evlist, argc, argv);
 	}
+
+	if (num_print_iv++ == 25)
+		num_print_iv = 0;
 }
 
 static int get_precision(double num)
@@ -1278,18 +1313,10 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	if (interval) {
 		prefix = buf;
 		prepare_interval(config, prefix, ts);
-		print_interval(config, evlist);
-	} else {
-		print_header(config, _target, argc, argv);
 	}
 
+	print_header(config, _target, evlist, argc, argv);
 	if (metric_only) {
-		static int num_print_iv;
-
-		if (num_print_iv == 0 && !interval)
-			print_metric_headers(config, evlist, prefix, false);
-		if (num_print_iv++ == 25)
-			num_print_iv = 0;
 		if (config->aggr_mode == AGGR_GLOBAL && prefix && !config->iostat_run)
 			fprintf(config->output, "%s", prefix);
 	}
-- 
2.38.1.493.g58b659f92b-goog

