Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D6620138
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiKGVdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiKGVd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:33:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B065B1087;
        Mon,  7 Nov 2022 13:33:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so11115477pjs.4;
        Mon, 07 Nov 2022 13:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU4ETOkJBeJhSBeHInOj845NFGd1yJAeswjzuBLmc/c=;
        b=eungdUUVcH+EwVUeFD1iyPkNP2trdMfx+ha6MJtTRKbg6VneXkw/DV6FfYrf4HNAOO
         tUvqDOlNAvv2e5ABQRxmLd0WtI2bgfiDFXkb6kOneau3LHHlYpZeF7zVPZsHlUQjMAXn
         PthKxHaNQkSv14q/YIfOYaZLXnTVUNieDSHXGJc7/9T5WLC0jBVatr1hQs4bKYkFj3D7
         l7bv5cH8jljFLkx4RhWF9Q4GWrHD0gVwgVv7TcMV5Zm+gWSC8t8ve5AW7wGZnL1eA4iE
         VPHZbj3IfngL/oIuUtrUhBzFWTw9Nu1plH8lQTojWe3zx1soCPLaONdqF8YPRjODAma1
         Vabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lU4ETOkJBeJhSBeHInOj845NFGd1yJAeswjzuBLmc/c=;
        b=TjKiW+Ee6b7OMrWgtoTJE6qDK4mCGBR7S2T78jnncOjio3nrM3T5mf/Ty7zjXLXNaV
         Bh0aNGNBGHf1WMJ9H3BZTocPkCZtzwBR4bEbAIOZXuzPgR32p//29ef1aioFLGbsRBYE
         CctsusO/qO0IIEMk6wDfbPpbdc9bWEd+CGPo/BnxX0her2mng4anb/+8Dk8mLfAAqCqE
         QhycyV6itYwZxNS4DRdfS4M4WaxwrBh4RkZY9ajqP+9531HuuiqwQu6S2TimcuMp0iq0
         xanVuWfbo6TOkKif6jc2ysfVuU+bAxs+jOa3OUPyoVEGTyNe849iw79Z9lTd+QxkrdQK
         +jjw==
X-Gm-Message-State: ACrzQf3ABlK5kvklOQJY6obzZQJnHA4iaXfIAsw5gml80yi3QlssbXy2
        68ADqJPYzJEawG6y9jnwr+c=
X-Google-Smtp-Source: AMsMyM7V4g1CyinSyzdAcspGEGvDKGdkE0oCuY7985o01F0tIozbAzksldNDaVTGEchyLZnH9kJSFw==
X-Received: by 2002:a17:902:ebc5:b0:186:b848:c6a with SMTP id p5-20020a170902ebc500b00186b8480c6amr52209955plg.46.1667856805071;
        Mon, 07 Nov 2022 13:33:25 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5850:5958:9c77:f623])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm5366413pln.297.2022.11.07.13.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:33:24 -0800 (PST)
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
        James Clark <james.clark@arm.com>
Subject: [PATCH 5/9] perf stat: Fix --metric-only --json output
Date:   Mon,  7 Nov 2022 13:33:10 -0800
Message-Id: <20221107213314.3239159-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221107213314.3239159-1-namhyung@kernel.org>
References: <20221107213314.3239159-1-namhyung@kernel.org>
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

Currently it prints all metric headers for JSON output.  But actually it
skips some metrics with valid_only_metric().  So the output looks like:

  $ perf stat --metric-only --json true
  {"unit" : "CPUs utilized", "unit" : "/sec", "unit" : "/sec", "unit" : "/sec", "unit" : "GHz", "unit" : "insn per cycle", "unit" : "/sec", "unit" : "branch-misses of all branches"}
  {"metric-value" : "3.861"}{"metric-value" : "0.79"}{"metric-value" : "3.04"}

As you can see there are 8 units in the header but only 3 metric-values
are there.  It should skip the unused headers as well.  Also each unit
should be printed as a separate object like metric values.

With this patch:

  $ perf stat --metric-only --json true
  {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
  {"metric-value" : "4.166"}{"metric-value" : "0.73"}{"metric-value" : "2.96"}

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 115477461224..515fb6db3d67 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -430,12 +430,12 @@ static void print_metric_header(struct perf_stat_config *config,
 	    os->evsel->priv != os->evsel->evlist->selected->priv)
 		return;
 
-	if (!valid_only_metric(unit) && !config->json_output)
+	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
 
 	if (config->json_output)
-		fprintf(os->fh, "\"unit\" : \"%s\"", unit);
+		fprintf(os->fh, "{\"unit\" : \"%s\"}", unit);
 	else if (config->csv_output)
 		fprintf(os->fh, "%s%s", unit, config->csv_sep);
 	else
@@ -847,10 +847,6 @@ static void print_metric_headers(struct perf_stat_config *config,
 		.new_line = new_line_metric,
 		.force_header = true,
 	};
-	bool first = true;
-
-	if (config->json_output && !config->interval)
-		fprintf(config->output, "{");
 
 	if (prefix && !config->json_output)
 		fprintf(config->output, "%s", prefix);
@@ -871,18 +867,12 @@ static void print_metric_headers(struct perf_stat_config *config,
 	evlist__for_each_entry(evlist, counter) {
 		os.evsel = counter;
 
-		if (!first && config->json_output)
-			fprintf(config->output, ", ");
-		first = false;
-
 		perf_stat__print_shadow_stats(config, counter, 0,
 					      0,
 					      &out,
 					      &config->metric_events,
 					      &rt_stat);
 	}
-	if (config->json_output)
-		fprintf(config->output, "}");
 	fputc('\n', config->output);
 }
 
@@ -954,14 +944,8 @@ static void print_interval(struct perf_stat_config *config,
 		}
 	}
 
-	if ((num_print_interval == 0 || config->interval_clear)
-			 && metric_only && !config->json_output)
+	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
 		print_metric_headers(config, evlist, " ", true);
-	if ((num_print_interval == 0 || config->interval_clear)
-			 && metric_only && config->json_output) {
-		fprintf(output, "{");
-		print_metric_headers(config, evlist, " ", true);
-	}
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
 }
-- 
2.38.1.431.g37b22c650d-goog

