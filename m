Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B5A636848
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbiKWSFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbiKWSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:03:04 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906AD642F;
        Wed, 23 Nov 2022 10:02:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 9so1289771pfx.11;
        Wed, 23 Nov 2022 10:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTDdto5/eoDl85LlqvUb3DgMBRg+irZ3fXZplmAmP/4=;
        b=RLxVPfndBEBdljQ6gVY3mhbDKukmqmEcOIg4Q+pjS4LHRqm5wBHtggVHo/n7bNsAE/
         +g48UoG0UvFjeyogFsfA5/t8p4wCKlFzmWxYA+rTPmNEQZpb+WGt8G1psMGz9/Io9ALz
         qgPGUVI0NqMogwZ5iIO0q2IYifR1RHfGZquKge1jyxcrOLAGIml/fyk8YSm0FJg6JEe7
         IsgJX9P3N6HzH0Rozj0pMW0B8aI5IiHvfhkgNH9cWXx3tmtb6xYVbIjYkg30I8n+3ac4
         jOftQ1EAHPacjPSuPp9ao2K+Aj9+IxbuYBCBWStrxRm9vRdcIFNWTqIMVp0MmmtYONg4
         wsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PTDdto5/eoDl85LlqvUb3DgMBRg+irZ3fXZplmAmP/4=;
        b=ysaEIIV4OlKQ3O9urR15CSzewfdUbMyvVJfS3XpHsxWZM/w+m8dW57Ql2o7wKvxv0r
         rNrfY6eVbrz8vrfrdnQlg19MjvHs9FWNmCX0oxD0m2LynTLkVT+lXs7Nvwgff9lLXtWv
         pUgZbpORbRFCCcLnO7ZyW9jKPAHH+9znaXqGV7AXtJtpkJDRGZKCIvYytYkdURDswOsE
         h6qnV9aXQot8fYSJR7KQYHXTjpbBsX2fw8r3jWkBXGHDjrt7IqWVkNIEdXc+2h6BmSYS
         sdoiVVRCZ/DuzehO9oUal1+HRuA+coCosgRFIMJwgvzxvQO0i/lHCheJ5PglVpfguYJv
         06Sg==
X-Gm-Message-State: ANoB5pmVhwVgUIXlPQT+J58C14xia6/rnuyqb1KZrnAKHF6wnBGFTXgI
        1pPNDEw9afpznoEvJRnYyVo=
X-Google-Smtp-Source: AA0mqf5pPCKGwfwcY/7kDm8gj5HW/1JL6TCc5g2G+MRpRVl/LkRjvbSH4K6hbVbrodccL2fjVMWn5w==
X-Received: by 2002:a63:5359:0:b0:46f:7e1c:e6e6 with SMTP id t25-20020a635359000000b0046f7e1ce6e6mr27668686pgl.138.1669226549483;
        Wed, 23 Nov 2022 10:02:29 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:29 -0800 (PST)
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
Subject: [PATCH 13/15] perf stat: Fix JSON output in metric-only mode
Date:   Wed, 23 Nov 2022 10:02:06 -0800
Message-Id: <20221123180208.2068936-14-namhyung@kernel.org>
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

It generated a broken JSON output when aggregation mode or cgroup is
used with --metric-only option.  Also get rid of the header line and
make the output single line for each entry.

It needs to know whether the current metric is the first one or not.
So add 'first' field in the outstate and mark it false after printing.

Before:
  # perf stat -a -j --metric-only true
  {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
  {{"metric-value" : "0.797"}{"metric-value" : "1.65"}{"metric-value" : "0.89"}
   ^

  # perf stat -a -j --metric-only --per-socket true
  {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
  {"socket" : "S0", "aggregate-number" : 8, {"metric-value" : "0.295"}{"metric-value" : "1.88"}{"metric-value" : "0.64"}
                                           ^

After:
  # perf stat -a -j --metric-only true
  {"GHz" : "0.990", "insn per cycle" : "2.06", "branch-misses of all branches" : "0.59"}

  # perf stat -a -j --metric-only --per-socket true
  {"socket" : "S0", "aggregate-number" : 8, "GHz" : "0.439", "insn per cycle" : "2.14", "branch-misses of all branches" : "0.51"}

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 42 +++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 335627e8542d..43640115454c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -279,9 +279,6 @@ static void print_aggr_id_json(struct perf_stat_config *config,
 {
 	FILE *output = config->output;
 
-	if (!config->interval)
-		fputc('{', output);
-
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
 		fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-number\" : %d, ",
@@ -335,6 +332,7 @@ static void aggr_printout(struct perf_stat_config *config,
 struct outstate {
 	FILE *fh;
 	bool newline;
+	bool first;
 	const char *prefix;
 	int  nfields;
 	int  nr;
@@ -491,6 +489,7 @@ static void print_metric_only(struct perf_stat_config *config,
 
 	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
 	fprintf(out, "%*s ", mlen, str);
+	os->first = false;
 }
 
 static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused,
@@ -512,6 +511,7 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 		ends++;
 	*ends = 0;
 	fprintf(out, "%s%s", vals, config->csv_sep);
+	os->first = false;
 }
 
 static void print_metric_only_json(struct perf_stat_config *config __maybe_unused,
@@ -532,7 +532,8 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
-	fprintf(out, "{\"metric-value\" : \"%s\"}", vals);
+	fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
+	os->first = false;
 }
 
 static void new_line_metric(struct perf_stat_config *config __maybe_unused,
@@ -561,7 +562,7 @@ static void print_metric_header(struct perf_stat_config *config,
 	unit = fixunit(tbuf, os->evsel, unit);
 
 	if (config->json_output)
-		fprintf(os->fh, "{\"unit\" : \"%s\"}", unit);
+		return;
 	else if (config->csv_output)
 		fprintf(os->fh, "%s%s", unit, config->csv_sep);
 	else
@@ -821,6 +822,8 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 	run = aggr->counts.run;
 
 	if (!metric_only) {
+		if (config->json_output)
+			fputc('{', output);
 		if (os->prefix)
 			fprintf(output, "%s", os->prefix);
 		else if (config->summary && config->csv_output &&
@@ -844,9 +847,12 @@ static void print_metric_begin(struct perf_stat_config *config,
 	struct aggr_cpu_id id;
 	struct evsel *evsel;
 
+	os->first = true;
 	if (!config->metric_only)
 		return;
 
+	if (config->json_output)
+		fputc('{', config->output);
 	if (os->prefix)
 		fprintf(config->output, "%s", os->prefix);
 
@@ -855,7 +861,7 @@ static void print_metric_begin(struct perf_stat_config *config,
 	aggr = &evsel->stats->aggr[aggr_idx];
 	aggr_printout(config, evsel, id, aggr->nr);
 
-	print_cgroup(config, os->cgrp);
+	print_cgroup(config, os->cgrp ? : evsel->cgrp);
 }
 
 static void print_metric_end(struct perf_stat_config *config)
@@ -863,6 +869,8 @@ static void print_metric_end(struct perf_stat_config *config)
 	if (!config->metric_only)
 		return;
 
+	if (config->json_output)
+		fputc('}', config->output);
 	fputc('\n', config->output);
 }
 
@@ -1005,11 +1013,9 @@ static void print_metric_headers_csv(struct perf_stat_config *config,
 		fputs(aggr_header_csv[config->aggr_mode], config->output);
 }
 
-static void print_metric_headers_json(struct perf_stat_config *config,
+static void print_metric_headers_json(struct perf_stat_config *config __maybe_unused,
 				      bool no_indent __maybe_unused)
 {
-	if (config->interval)
-		fputs("{\"unit\" : \"sec\"}", config->output);
 }
 
 static void print_metric_headers(struct perf_stat_config *config,
@@ -1049,7 +1055,9 @@ static void print_metric_headers(struct perf_stat_config *config,
 					      &config->metric_events,
 					      &rt_stat);
 	}
-	fputc('\n', config->output);
+
+	if (!config->json_output)
+		fputc('\n', config->output);
 }
 
 static void prepare_interval(struct perf_stat_config *config,
@@ -1058,17 +1066,14 @@ static void prepare_interval(struct perf_stat_config *config,
 	if (config->iostat_run)
 		return;
 
-	if (config->csv_output)
+	if (config->json_output)
+		scnprintf(prefix, len, "\"interval\" : %lu.%09lu, ",
+			  (unsigned long) ts->tv_sec, ts->tv_nsec);
+	else if (config->csv_output)
 		scnprintf(prefix, len, "%lu.%09lu%s",
 			  (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
-	else if (!config->json_output)
-		scnprintf(prefix, len, "%6lu.%09lu ",
-			  (unsigned long) ts->tv_sec, ts->tv_nsec);
-	else if (!config->metric_only)
-		scnprintf(prefix, len, "{\"interval\" : %lu.%09lu, ",
-			  (unsigned long) ts->tv_sec, ts->tv_nsec);
 	else
-		scnprintf(prefix, len, "{\"interval\" : %lu.%09lu}",
+		scnprintf(prefix, len, "%6lu.%09lu ",
 			  (unsigned long) ts->tv_sec, ts->tv_nsec);
 }
 
@@ -1365,6 +1370,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	char buf[64];
 	struct outstate os = {
 		.fh = config->output,
+		.first = true,
 	};
 
 	if (config->iostat_run)
-- 
2.38.1.584.g0f3c55d4c2-goog

