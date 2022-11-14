Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37298628D07
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiKNXDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiKNXDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141D01C131;
        Mon, 14 Nov 2022 15:02:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p21so11500850plr.7;
        Mon, 14 Nov 2022 15:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XtdOOIqcdV1KgiG/01v+Rj8BokEmQ43hQ9dFYU/fNg=;
        b=ei84jXWjNfmnH9OUB1u5al/lYsHMGOntgzm0Q5K+8D47aWFOFNF9PikTTkgU1qzsZD
         UmRBYU4J1y9wr+QP7oFH3pe5LtCFle0bGq8arql1ouwgtBOFZuJQQFGO6qIWE0SimoK7
         iWk3UNLloqElE1gsyRP8Lvh5LAeh9eYRAAht85lQUNulIxTlK45HXq1fZ29aPmjLzuL1
         8fNxjaES1Z57CwrUKDd/mnHVrfq0PFeebKgoel3EoUmhdANJ3WdTD9K6RUv/22PN0Yq1
         4XyBVZHOJI9Lvp8miDaILeUSiVol+GsO6BO/cj5FKkHFAh0svzNJViRsZVZqHRUVy0ik
         9OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+XtdOOIqcdV1KgiG/01v+Rj8BokEmQ43hQ9dFYU/fNg=;
        b=XfHA6lT4G7xWx+rllPBZI0s/lBlzF0PS3gjLtnxGD8djZxOe2uVH6S5QNzAuDgKM3r
         mJ28KpWoDeUAv7A94B9ndwNrf1c0oVrE+Lk+TqF/HppD8hqAuzk+IOnxQeh0lrHqCDbe
         mO1pEYKy9xtwFWK/K3Q07gjtMnvqhT4lQvC31mjAEk3d2k4HyYj5/pnOzbMkgqC/tb97
         Rb7ytlpipmesnMEsb5WhqDt2l3pjt/7kuK1iF7cWNfkrip2GaHr4A5uB1+asVo2KMmye
         eZz+oqV8E7EUntG1V9tWgIa/RvlGNhpBXVzx13/8snp+5GxFrkUxUeXcnI83+VC3SLPK
         LYzg==
X-Gm-Message-State: ANoB5pkgr2l88sCAM2hAgUMEwfJR7DA2pkAOKGxbIyD49Qfc/M9ZHL/f
        4cxawKeMGR0MI0MuJhIPsGw=
X-Google-Smtp-Source: AA0mqf7rdaUq+jdzSbAtikgHm9cnhmYBiObpl+h5pXUJyYLh9rNbSBTQZ4KhUl+TWpkGH/nqBm9wCw==
X-Received: by 2002:a17:902:f7c3:b0:176:e414:722 with SMTP id h3-20020a170902f7c300b00176e4140722mr1409144plw.26.1668466960520;
        Mon, 14 Nov 2022 15:02:40 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:40 -0800 (PST)
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
Subject: [PATCH 07/19] perf stat: Handle bad events in abs_printout()
Date:   Mon, 14 Nov 2022 15:02:15 -0800
Message-Id: <20221114230227.1255976-8-namhyung@kernel.org>
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

In the printout() function, it checks if the event is bad (i.e. not
counted or not supported) and print the result.  But it does the same
what abs_printout() is doing.  So add an argument to indicate the value
is ok or not and use the same function in both cases.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 68 ++++++++++++++--------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a72c7442ff3d..fe5483893289 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -518,18 +518,22 @@ static void print_metric_header(struct perf_stat_config *config,
 }
 
 static void print_counter_value_std(struct perf_stat_config *config,
-				    struct evsel *evsel, double avg)
+				    struct evsel *evsel, double avg, bool ok)
 {
 	FILE *output = config->output;
 	double sc =  evsel->scale;
 	const char *fmt;
+	const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
 
 	if (config->big_num)
 		fmt = floor(sc) != sc ? "%'18.2f " : "%'18.0f ";
 	else
 		fmt = floor(sc) != sc ? "%18.2f " : "%18.0f ";
 
-	fprintf(output, fmt, avg);
+	if (ok)
+		fprintf(output, fmt, avg);
+	else
+		fprintf(output, "%18s ", bad_count);
 
 	if (evsel->unit)
 		fprintf(output, "%-*s ", config->unit_width, evsel->unit);
@@ -538,14 +542,18 @@ static void print_counter_value_std(struct perf_stat_config *config,
 }
 
 static void print_counter_value_csv(struct perf_stat_config *config,
-				    struct evsel *evsel, double avg)
+				    struct evsel *evsel, double avg, bool ok)
 {
 	FILE *output = config->output;
 	double sc =  evsel->scale;
 	const char *sep = config->csv_sep;
 	const char *fmt = floor(sc) != sc ? "%.2f%s" : "%.0f%s";
+	const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
 
-	fprintf(output, fmt, avg, sep);
+	if (ok)
+		fprintf(output, fmt, avg, sep);
+	else
+		fprintf(output, "%s%s", bad_count, sep);
 
 	if (evsel->unit)
 		fprintf(output, "%s%s", evsel->unit, sep);
@@ -554,11 +562,15 @@ static void print_counter_value_csv(struct perf_stat_config *config,
 }
 
 static void print_counter_value_json(struct perf_stat_config *config,
-				     struct evsel *evsel, double avg)
+				     struct evsel *evsel, double avg, bool ok)
 {
 	FILE *output = config->output;
+	const char *bad_count = evsel->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED;
 
-	fprintf(output, "\"counter-value\" : \"%f\", ", avg);
+	if (ok)
+		fprintf(output, "\"counter-value\" : \"%f\", ", avg);
+	else
+		fprintf(output, "\"counter-value\" : \"%s\", ", bad_count);
 
 	if (evsel->unit)
 		fprintf(output, "\"unit\" : \"%s\", ", evsel->unit);
@@ -567,21 +579,22 @@ static void print_counter_value_json(struct perf_stat_config *config,
 }
 
 static void print_counter_value(struct perf_stat_config *config,
-				struct evsel *evsel, double avg)
+				struct evsel *evsel, double avg, bool ok)
 {
 	if (config->json_output)
-		print_counter_value_json(config, evsel, avg);
+		print_counter_value_json(config, evsel, avg, ok);
 	else if (config->csv_output)
-		print_counter_value_csv(config, evsel, avg);
+		print_counter_value_csv(config, evsel, avg, ok);
 	else
-		print_counter_value_std(config, evsel, avg);
+		print_counter_value_std(config, evsel, avg, ok);
 }
 
 static void abs_printout(struct perf_stat_config *config,
-			 struct aggr_cpu_id id, int nr, struct evsel *evsel, double avg)
+			 struct aggr_cpu_id id, int nr,
+			 struct evsel *evsel, double avg, bool ok)
 {
 	aggr_printout(config, evsel, id, nr);
-	print_counter_value(config, evsel, avg);
+	print_counter_value(config, evsel, avg, ok);
 	print_cgroup(config, evsel);
 }
 
@@ -658,17 +671,8 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			pm(config, &os, NULL, "", "", 0);
 			return;
 		}
-		aggr_printout(config, counter, id, nr);
 
-		if (config->json_output) {
-			fprintf(config->output, "\"counter-value\" : \"%s\", ",
-					counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED);
-		} else {
-			fprintf(config->output, "%*s%s",
-				config->csv_output ? 0 : 18,
-				counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
-				config->csv_sep);
-		}
+		abs_printout(config, id, nr, counter, uval, /*ok=*/false);
 
 		if (counter->supported) {
 			if (!evlist__has_hybrid(counter->evlist)) {
@@ -678,24 +682,6 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 			}
 		}
 
-		if (config->json_output) {
-			fprintf(config->output, "\"unit\" : \"%s\", ", counter->unit);
-		} else {
-			fprintf(config->output, "%-*s%s",
-				config->csv_output ? 0 : config->unit_width,
-				counter->unit, config->csv_sep);
-		}
-
-		if (config->json_output) {
-			fprintf(config->output, "\"event\" : \"%s\", ",
-				evsel__name(counter));
-		} else {
-			fprintf(config->output, "%*s",
-				 config->csv_output ? 0 : -25, evsel__name(counter));
-		}
-
-		print_cgroup(config, counter);
-
 		if (!config->csv_output && !config->json_output)
 			pm(config, &os, NULL, NULL, "", 0);
 		print_noise(config, counter, noise);
@@ -706,7 +692,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	}
 
 	if (!config->metric_only)
-		abs_printout(config, id, nr, counter, uval);
+		abs_printout(config, id, nr, counter, uval, /*ok=*/true);
 
 	out.print_metric = pm;
 	out.new_line = nl;
-- 
2.38.1.493.g58b659f92b-goog

