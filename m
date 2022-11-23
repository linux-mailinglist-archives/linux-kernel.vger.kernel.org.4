Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91190636818
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbiKWSDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239359AbiKWSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:20 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C160F9;
        Wed, 23 Nov 2022 10:02:18 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v28so18006470pfi.12;
        Wed, 23 Nov 2022 10:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSagVML7GgOqlOudGxczoz0/8G87CcGh9QY51qbKYAY=;
        b=ixqc+fmP1EpYwjc94PYCfvYVyvk1b5Q7/lCMMoLyMbzTKtNetDuy/0FhIf8rhhTEi5
         G4jqBVVV8NG8HitM5TUlTJMExA1DX4cKRAip8OLufvcBZwHPqYIaCKGd1BpzWYFLkD1o
         gylPTOpMhucAftwmh9v0CPo4ak1alld20Q7R5poqnbOfhPjkMhGRiTlAzQ0xDA/Vn/f5
         x5tOxSMR7KphqJEMgcy7jTa5InRL8z8Zvabm/RiTmV2+kz58p1yIZey+nwChvk6z58GA
         ji+Gl+OvcYIomtG2t/V2aYdP8YgqrST/zg/oQpt9Tx77R5boFq4izG9abLuzrq6RI45n
         QzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XSagVML7GgOqlOudGxczoz0/8G87CcGh9QY51qbKYAY=;
        b=XgMWds5uELM4fZFBTrQYAmej/wyEb4pCuW6vOCiseeY82n+HDVx648DtNp4Hxm1wWs
         ZXOSB4AsRjDzD/SXk02yM9gQiHgeePOQl1GIEAz+OcSg5G+9BJCoIYN5mmcJGRk31Z+S
         0nNcA4zwVGTz+0c/e9QPlY68AjAwGATIL3snhYnBVcaq3iFVfE6K8zJOd8zIduIu6xxN
         L4kXP5WmqyB5WEGLKzTJCTFQCJzAlxcGY3m9GrbzxtuYViL9G3pwnMk4k4TBslLgvxuL
         8P24VeShSrXEKKT8vpW6GYkq2/UbNGjwMSgUvUa+un1fD+l5F0ewwzr0Vu+hLpfx8A7t
         4ruA==
X-Gm-Message-State: ANoB5pmYnTJTzGyYPxReYvfk/KNTF/XQrq0gEm90I9xwQP0/rxaJ+ZQH
        2h5JFig93nXAYj/vhGRLsCw=
X-Google-Smtp-Source: AA0mqf6KzYb+/auV2JdDKMMa0tioOSOQjN7DGFDSezEYynfNyIFk8ympGBU0GuWU3Nh4oYZfsvtRrw==
X-Received: by 2002:a63:5b44:0:b0:46f:c9e8:5752 with SMTP id l4-20020a635b44000000b0046fc9e85752mr8580769pgm.157.1669226538136;
        Wed, 23 Nov 2022 10:02:18 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:17 -0800 (PST)
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
Subject: [PATCH 05/15] perf stat: Remove prefix argument in print_metric_headers()
Date:   Wed, 23 Nov 2022 10:01:58 -0800
Message-Id: <20221123180208.2068936-6-namhyung@kernel.org>
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

It always passes a whitespace to the function, thus we can just add it to the
function body.  Furthermore, it's only used in the normal output mode.

Well, actually CSV used it but it doesn't need to since we don't care about the
indentation or alignment in the CSV output.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 744b7a40f59a..deed6ccf072f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -996,10 +996,9 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 }
 
 static void print_metric_headers_std(struct perf_stat_config *config,
-				     const char *prefix, bool no_indent)
+				     bool no_indent)
 {
-	if (prefix)
-		fprintf(config->output, "%s", prefix);
+	fputc(' ', config->output);
 
 	if (!no_indent) {
 		int len = aggr_header_lens[config->aggr_mode];
@@ -1012,11 +1011,8 @@ static void print_metric_headers_std(struct perf_stat_config *config,
 }
 
 static void print_metric_headers_csv(struct perf_stat_config *config,
-				     const char *prefix,
 				     bool no_indent __maybe_unused)
 {
-	if (prefix)
-		fprintf(config->output, "%s", prefix);
 	if (config->interval)
 		fputs("time,", config->output);
 	if (!config->iostat_run)
@@ -1024,7 +1020,6 @@ static void print_metric_headers_csv(struct perf_stat_config *config,
 }
 
 static void print_metric_headers_json(struct perf_stat_config *config,
-				      const char *prefix __maybe_unused,
 				      bool no_indent __maybe_unused)
 {
 	if (config->interval)
@@ -1032,8 +1027,7 @@ static void print_metric_headers_json(struct perf_stat_config *config,
 }
 
 static void print_metric_headers(struct perf_stat_config *config,
-				 struct evlist *evlist,
-				 const char *prefix, bool no_indent)
+				 struct evlist *evlist, bool no_indent)
 {
 	struct evsel *counter;
 	struct outstate os = {
@@ -1047,11 +1041,11 @@ static void print_metric_headers(struct perf_stat_config *config,
 	};
 
 	if (config->json_output)
-		print_metric_headers_json(config, prefix, no_indent);
+		print_metric_headers_json(config, no_indent);
 	else if (config->csv_output)
-		print_metric_headers_csv(config, prefix, no_indent);
+		print_metric_headers_csv(config, no_indent);
 	else
-		print_metric_headers_std(config, prefix, no_indent);
+		print_metric_headers_std(config, no_indent);
 
 	if (config->iostat_run)
 		iostat_print_header_prefix(config);
@@ -1132,7 +1126,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
 	}
 
 	if (config->metric_only)
-		print_metric_headers(config, evlist, " ", true);
+		print_metric_headers(config, evlist, true);
 	else
 		fprintf(output, " %*s %*s events\n",
 			COUNTS_LEN, "counts", config->unit_width, "unit");
@@ -1168,7 +1162,7 @@ static void print_header_std(struct perf_stat_config *config,
 	fprintf(output, ":\n\n");
 
 	if (config->metric_only)
-		print_metric_headers(config, evlist, " ", false);
+		print_metric_headers(config, evlist, false);
 }
 
 static void print_header_csv(struct perf_stat_config *config,
@@ -1178,7 +1172,7 @@ static void print_header_csv(struct perf_stat_config *config,
 			     const char **argv __maybe_unused)
 {
 	if (config->metric_only)
-		print_metric_headers(config, evlist, " ", true);
+		print_metric_headers(config, evlist, true);
 }
 static void print_header_json(struct perf_stat_config *config,
 			      struct target *_target __maybe_unused,
@@ -1187,7 +1181,7 @@ static void print_header_json(struct perf_stat_config *config,
 			      const char **argv __maybe_unused)
 {
 	if (config->metric_only)
-		print_metric_headers(config, evlist, " ", true);
+		print_metric_headers(config, evlist, true);
 }
 
 static void print_header(struct perf_stat_config *config,
-- 
2.38.1.584.g0f3c55d4c2-goog

