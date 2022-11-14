Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6A628D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiKNXDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiKNXDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:03:22 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9E71C42F;
        Mon, 14 Nov 2022 15:02:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so245078pjh.1;
        Mon, 14 Nov 2022 15:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7m9PL079tg/puX/nq7Az2YxT2Xrw40LYwiV1eclCi4=;
        b=WcjbZOKxKvBXN4WxmPs2lROepvw+yn3b3+EGv2GpJr9neKf4nzac32FG8OSOcxTa3q
         0Trreim1TFPzeWHHQpelNVUVy7+OnRfmVvDx+tOBv2B+jvjPUfN+RB2Z1njxyTLf67y+
         gMp1gRvmbJuQ4ScE+LSM1eCN6d8cKq92QAPdpPby2Yz595G0TGyfyBA2TQ4i/6VyR6SN
         pq5bwQqrHMIO45ziQVcxyJ2eGBePtgQgw5eQOEJaWK/708H6fATL2ZSOTQx5dEmYlwyh
         Yd9gCjlXDFq1iQGQTx/zA5gtZeDblqbDqdqtqiGck7yRliL/E8C2YDXYYthTDWfcPc7o
         xOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k7m9PL079tg/puX/nq7Az2YxT2Xrw40LYwiV1eclCi4=;
        b=ycBGlI+HIDO9m5W+z/SqjpRYCpIT2W7eg07JpOaMbeXhlXT/aaR1pLVIN85nSGd8Jk
         NRpCS+KEX8eMtalv1r/m2SXAOBe8+Hs2A44wA6mP+MDi51XlViWLMxDPAm7IiN8oZ0Oj
         n3Hg6klhhrus+Q/E1NMcfjvJNEbo3m6zmkNjFKbAxZWTPZ15CBMJtLy6d99WKSGnPX+m
         h5AhjkvpAxqWuBsGhzmXi6L2Iy36moK4peI716cZy4l21dlhFh/7XKmOnK0y6IaHCPUT
         mN7S4t5AHl5x3Lkn3ctf6YCJn/Dj0oXjsowuzAkdcpPgiz2khtW1xHIuCB+/CtBB26se
         hl7g==
X-Gm-Message-State: ANoB5pksEAKts4mkWMFntslxBe9RfnKa0USy2uezgOf4at4kB02XDVvD
        4ugiUKDmeSu4VKbEH6wDPGQ=
X-Google-Smtp-Source: AA0mqf6CJbvkIe2PJUI9RYlPfMvgnzUQqs4XX3hF/CBeFwAfYEWQ51tEN/5Pmey6DNqig7rxSiHYkg==
X-Received: by 2002:a17:90a:14a4:b0:212:d62a:aeb8 with SMTP id k33-20020a17090a14a400b00212d62aaeb8mr15214486pja.221.1668466965385;
        Mon, 14 Nov 2022 15:02:45 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:44 -0800 (PST)
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
Subject: [PATCH 10/19] perf stat: Split print_metric_headers() function
Date:   Mon, 14 Nov 2022 15:02:18 -0800
Message-Id: <20221114230227.1255976-11-namhyung@kernel.org>
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

The print_metric_headers() shows metric headers a little bit for each
mode.  Split it out to make the code clearer.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 52 ++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e66f766a3d78..bb2791459f5f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -924,6 +924,37 @@ static const char *aggr_header_csv[] = {
 	[AGGR_GLOBAL] 	=	""
 };
 
+static void print_metric_headers_std(struct perf_stat_config *config,
+				     const char *prefix, bool no_indent)
+{
+	if (prefix)
+		fprintf(config->output, "%s", prefix);
+	if (!no_indent) {
+		fprintf(config->output, "%*s",
+			aggr_header_lens[config->aggr_mode], "");
+	}
+}
+
+static void print_metric_headers_csv(struct perf_stat_config *config,
+				     const char *prefix,
+				     bool no_indent __maybe_unused)
+{
+	if (prefix)
+		fprintf(config->output, "%s", prefix);
+	if (config->interval)
+		fputs("time,", config->output);
+	if (!config->iostat_run)
+		fputs(aggr_header_csv[config->aggr_mode], config->output);
+}
+
+static void print_metric_headers_json(struct perf_stat_config *config,
+				      const char *prefix __maybe_unused,
+				      bool no_indent __maybe_unused)
+{
+	if (config->interval)
+		fputs("{\"unit\" : \"sec\"}", config->output);
+}
+
 static void print_metric_headers(struct perf_stat_config *config,
 				 struct evlist *evlist,
 				 const char *prefix, bool no_indent)
@@ -939,22 +970,13 @@ static void print_metric_headers(struct perf_stat_config *config,
 		.force_header = true,
 	};
 
-	if (prefix && !config->json_output)
-		fprintf(config->output, "%s", prefix);
+	if (config->json_output)
+		print_metric_headers_json(config, prefix, no_indent);
+	else if (config->csv_output)
+		print_metric_headers_csv(config, prefix, no_indent);
+	else
+		print_metric_headers_std(config, prefix, no_indent);
 
-	if (!config->csv_output && !config->json_output && !no_indent)
-		fprintf(config->output, "%*s",
-			aggr_header_lens[config->aggr_mode], "");
-	if (config->csv_output) {
-		if (config->interval)
-			fputs("time,", config->output);
-		if (!config->iostat_run)
-			fputs(aggr_header_csv[config->aggr_mode], config->output);
-	}
-	if (config->json_output) {
-		if (config->interval)
-			fputs("{\"unit\" : \"sec\"}", config->output);
-	}
 	if (config->iostat_run)
 		iostat_print_header_prefix(config);
 
-- 
2.38.1.493.g58b659f92b-goog

