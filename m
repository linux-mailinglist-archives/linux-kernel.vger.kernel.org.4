Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128F4626692
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiKLDW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLDWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:22:52 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37BF6A747;
        Fri, 11 Nov 2022 19:22:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c2so5666325plz.11;
        Fri, 11 Nov 2022 19:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcoM9akctXagDD4pJeclGlmLvOUIRQorPmWBAJ2dUvo=;
        b=NYGDRsGbezN7aCIRSJJau2ba0Fvlx5Y2SsEQH/7FJLRpyZrqRbuvEBaAyVtRaRlN5D
         EbwIOV4v+EdwQvy/CbAzTS86jTv+Bb2F52Ez0MPM1l5w1VJR7vlOOyqp0VZrhhBls2RP
         XafUHId5pxu7VsHQESMceuyRL32Bc4pmzgv43BrU8aKYBplRT1vIVEM3hRiitsmrDyX6
         EJr7/ONsFtZBEgXCIuQ3YO6z0gCZGZGcFb5GS4+QKf0Q/IbJUc6yGnMXkLNfbmAs4xn4
         +jEnPPdt0o/qh4EmFOpfWLKv+l72QT2IZ+qoAA3Bk+oaX05m/1kfyL2uRvXvqBqrnJAW
         wKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UcoM9akctXagDD4pJeclGlmLvOUIRQorPmWBAJ2dUvo=;
        b=SfZBP6s6X66lLIgqWEWTurld6VCmOVNL+tifpyAuIHVrmxny8Hca5iSGz9gj9JgXOj
         0wEk2+JQXyIgdyQnAUfdZ+f/nqfp7lwolXFHf0TgUnqsvg9bwwtVxMKpB3W/Ua9GQAqn
         G/KDIoO+xqOXx/GLGNHI9aZVxBMBLdFPGVZwRl6h8T9OREZsro7PFdyM8LPKMxLW+uN6
         5utLGUNgmeE+blD6dgZsQ2yMFepTPmH9K/WiD8TfXfGaWH09qFdg4ecqpcVVu7pEoYsM
         Dd9OJNj4V4jyCLe+pttlqrSrmt11kQx+N08PAckgdPw2NxdJYMytPq3w1ABRgFJqtJ98
         sVCw==
X-Gm-Message-State: ANoB5pm/fBDpPtFV0cEnGkrKfirTCWKT1Jg55b2cvjZYpfC/0rzJFQKq
        NXywUpOveSojg/fzzU5XLhI=
X-Google-Smtp-Source: AA0mqf7Ru5hvYtSMzhKkQhhpgi9g2qCjqt2k5ogZFNuIWL/W9Rl64UGCRXbpFzletEZRDxTZACKd5w==
X-Received: by 2002:a17:902:d191:b0:186:c483:f017 with SMTP id m17-20020a170902d19100b00186c483f017mr5332657plb.136.1668223371117;
        Fri, 11 Nov 2022 19:22:51 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:22:50 -0800 (PST)
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
Subject: [PATCH 02/11] perf stat: Move common code in print_metric_headers()
Date:   Fri, 11 Nov 2022 19:22:35 -0800
Message-Id: <20221112032244.1077370-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221112032244.1077370-1-namhyung@kernel.org>
References: <20221112032244.1077370-1-namhyung@kernel.org>
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

The struct perf_stat_output_ctx is set in a loop with the same values.
Move the code out of the loop and keep the loop minimal.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ea41e6308c50..c7b3a1e10263 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -837,11 +837,16 @@ static void print_metric_headers(struct perf_stat_config *config,
 				 struct evlist *evlist,
 				 const char *prefix, bool no_indent)
 {
-	struct perf_stat_output_ctx out;
 	struct evsel *counter;
 	struct outstate os = {
 		.fh = config->output
 	};
+	struct perf_stat_output_ctx out = {
+		.ctx = &os,
+		.print_metric = print_metric_header,
+		.new_line = new_line_metric,
+		.force_header = true,
+	};
 	bool first = true;
 
 	if (config->json_output && !config->interval)
@@ -865,13 +870,11 @@ static void print_metric_headers(struct perf_stat_config *config,
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
 		os.evsel = counter;
-		out.ctx = &os;
-		out.print_metric = print_metric_header;
+
 		if (!first && config->json_output)
 			fprintf(config->output, ", ");
 		first = false;
-		out.new_line = new_line_metric;
-		out.force_header = true;
+
 		perf_stat__print_shadow_stats(config, counter, 0,
 					      0,
 					      &out,
-- 
2.38.1.493.g58b659f92b-goog

