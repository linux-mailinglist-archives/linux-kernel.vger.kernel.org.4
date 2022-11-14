Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD81628D05
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiKNXDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbiKNXDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:04 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368211C10E;
        Mon, 14 Nov 2022 15:02:39 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f3so5166342pgc.2;
        Mon, 14 Nov 2022 15:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWTJCUMMuG2d3heYPVKFPEFB7/flVbDDi20CjhO794s=;
        b=R9u8RjqhVZWOBpKgyOUL5+DiZvnxa6VpfFHjCrqW/mCfnsIqkvsKjce/wZVvuP2p+u
         3jAfi4UxZEWCYB8W8t3/3yC7uJFfRz6TBJgiT4Gsu4jfbwfY9AoIxiSk2DDkjBVIKqxn
         qRpx3N9JHrAwtOKePCTQY3zQX3OzUB/Vj7qPayR1WatwKytaDj/drmvIiF22gSb/KSHt
         3mmNMpKiTcc3+g3b4OX5HWCVPPiiiX1FchwDFten3nEjGwPl0EWRkVyjIGaFF1UMK6jn
         lVlSAe9rYNom0hN2gljFgq7hhAJKgkNZRRLOftUdAPe0Yze98IeODkH6fbRDLFQ+K5a1
         1zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gWTJCUMMuG2d3heYPVKFPEFB7/flVbDDi20CjhO794s=;
        b=Q0E/59KShW9MYovlEfkAXGYq9u2pz+C7C2OtTtw27z4jDuAD1VZ1bpqwhsskafHKQT
         2DnRiPSz2KWeZ+lFFYb8pkwnsvq3nhSWrM8TlDQe+RhEE6duguLTyWWYu7kXQDzhh50A
         4ebOz7llap7CDHb9O9WRlUwfp1nfFjLVcXlgExdpUncNTxSJT3up6JyTcaVzA06t88S2
         U+0eFV5Wm5oTpIhjRDUFTW8mgeMX7mg2bc+vmFFFes53ES2F8hXPJ4ebvJxVdNNKbyw+
         yF0B0v6RvkmVjCBJtCNU+Z0EQ6QtgEdsbkg8cGJCA56aOiSjwmfR73gjvGLZ+kMdyN8z
         RXFw==
X-Gm-Message-State: ANoB5pl3MECrfCFL1OIMzgCWMlbH8HNT86freVXIwqw8o7qJJAwIiN9o
        bMUnmYJZn9BWFwWXgOoKtmQ=
X-Google-Smtp-Source: AA0mqf7KIRLjR6xF9YgSGRHmvxg7MWHFTFXgYnNLBMSEKgVR8VlWsqPhpMptr2yALWML2G+t1NsyBQ==
X-Received: by 2002:a63:1b54:0:b0:476:a08b:b106 with SMTP id b20-20020a631b54000000b00476a08bb106mr2765184pgm.77.1668466959061;
        Mon, 14 Nov 2022 15:02:39 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:38 -0800 (PST)
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
Subject: [PATCH 06/19] perf stat: Factor out print_counter_value() function
Date:   Mon, 14 Nov 2022 15:02:14 -0800
Message-Id: <20221114230227.1255976-7-namhyung@kernel.org>
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

And split it for each output mode like others.  I believe it makes the
code simpler and more intuitive.  Now abs_printout() becomes just to
call sub-functions.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 81 ++++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ed421f6d512f..a72c7442ff3d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -517,46 +517,71 @@ static void print_metric_header(struct perf_stat_config *config,
 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
 }
 
-static void abs_printout(struct perf_stat_config *config,
-			 struct aggr_cpu_id id, int nr, struct evsel *evsel, double avg)
+static void print_counter_value_std(struct perf_stat_config *config,
+				    struct evsel *evsel, double avg)
 {
 	FILE *output = config->output;
 	double sc =  evsel->scale;
 	const char *fmt;
 
-	if (config->csv_output) {
-		fmt = floor(sc) != sc ?  "%.2f%s" : "%.0f%s";
-	} else {
-		if (config->big_num)
-			fmt = floor(sc) != sc ? "%'18.2f%s" : "%'18.0f%s";
-		else
-			fmt = floor(sc) != sc ? "%18.2f%s" : "%18.0f%s";
-	}
+	if (config->big_num)
+		fmt = floor(sc) != sc ? "%'18.2f " : "%'18.0f ";
+	else
+		fmt = floor(sc) != sc ? "%18.2f " : "%18.0f ";
 
-	aggr_printout(config, evsel, id, nr);
+	fprintf(output, fmt, avg);
 
-	if (config->json_output)
-		fprintf(output, "\"counter-value\" : \"%f\", ", avg);
-	else
-		fprintf(output, fmt, avg, config->csv_sep);
+	if (evsel->unit)
+		fprintf(output, "%-*s ", config->unit_width, evsel->unit);
 
-	if (config->json_output) {
-		if (evsel->unit) {
-			fprintf(output, "\"unit\" : \"%s\", ",
-				evsel->unit);
-		}
-	} else {
-		if (evsel->unit)
-			fprintf(output, "%-*s%s",
-				config->csv_output ? 0 : config->unit_width,
-				evsel->unit, config->csv_sep);
-	}
+	fprintf(output, "%-*s", 32, evsel__name(evsel));
+}
 
+static void print_counter_value_csv(struct perf_stat_config *config,
+				    struct evsel *evsel, double avg)
+{
+	FILE *output = config->output;
+	double sc =  evsel->scale;
+	const char *sep = config->csv_sep;
+	const char *fmt = floor(sc) != sc ? "%.2f%s" : "%.0f%s";
+
+	fprintf(output, fmt, avg, sep);
+
+	if (evsel->unit)
+		fprintf(output, "%s%s", evsel->unit, sep);
+
+	fprintf(output, "%s", evsel__name(evsel));
+}
+
+static void print_counter_value_json(struct perf_stat_config *config,
+				     struct evsel *evsel, double avg)
+{
+	FILE *output = config->output;
+
+	fprintf(output, "\"counter-value\" : \"%f\", ", avg);
+
+	if (evsel->unit)
+		fprintf(output, "\"unit\" : \"%s\", ", evsel->unit);
+
+	fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
+}
+
+static void print_counter_value(struct perf_stat_config *config,
+				struct evsel *evsel, double avg)
+{
 	if (config->json_output)
-		fprintf(output, "\"event\" : \"%s\", ", evsel__name(evsel));
+		print_counter_value_json(config, evsel, avg);
+	else if (config->csv_output)
+		print_counter_value_csv(config, evsel, avg);
 	else
-		fprintf(output, "%-*s", config->csv_output ? 0 : 32, evsel__name(evsel));
+		print_counter_value_std(config, evsel, avg);
+}
 
+static void abs_printout(struct perf_stat_config *config,
+			 struct aggr_cpu_id id, int nr, struct evsel *evsel, double avg)
+{
+	aggr_printout(config, evsel, id, nr);
+	print_counter_value(config, evsel, avg);
 	print_cgroup(config, evsel);
 }
 
-- 
2.38.1.493.g58b659f92b-goog

