Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6C7626694
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiKLDXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiKLDWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:22:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859836A77E;
        Fri, 11 Nov 2022 19:22:53 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u6so5662064plq.12;
        Fri, 11 Nov 2022 19:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxQ/iN4XHg0FIQpCgFQhcD29e8GRZB9Mx4/w+wLAp6k=;
        b=JpwS4rTVbq8z4URe3Q/HHFLpCAKd2Y/ZmR5sUXhhacWWYfAhrucKxKvtTb3iAIpmlp
         8SugwyqwsG/VR0tEFc+1XrY7J7z/9R+feg2280FzJD3Xyl4v8lwKK7Yovzub28hH87u7
         pyU8GRNXRNVpdB6uV3z0CrPcMULbxXgZK9mPwmvR1t3Uf0al+sb2gsGzXjBtYQUw89iA
         XTO9BRSjAxP1JzE/xRk2VYj+hwLoia/AbS29KdaetGoRPO9A+veHM+wzYcotOV/g24yi
         K587VZ39Qz38Eyw/VO3rXfFYBRKLFjGmb9xLntew7xeK7839Mav4n+c/CKmQkujuYlAb
         5aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AxQ/iN4XHg0FIQpCgFQhcD29e8GRZB9Mx4/w+wLAp6k=;
        b=e6eCvupmrAEep+vRywa7ctLyj3TXHyjxvMvqK6NzNY0E6xlJhWY6kgIvy6paD6ndEG
         WCcrlx4I3lo8wvU+FuFxrPc5EwbfUkyzU+MRhisbGNZeh8cVjUwXQisTMjdTPNJXFAVP
         AOkmQJMxg06/XppGptIOycg5kkZnTSgcF044/QBAFGvlBSkzrX1hqaMvQXOcwuDaISzJ
         ltHIZj/U/4htps7znTWvD4ktcblU5Bm1TYmXnNSs86Cyykm+8UXDxFDNrAKjk5H5bfBu
         GFPt3M/Cetz+x07dcpSYpHCt/JfQFDWbl7isO6/l0chI3zUKpJczHWPTkBvSTQZ+8/OI
         4ysw==
X-Gm-Message-State: ANoB5plz/xht8BQRew4YQ3fF/SRjSwlwtc9acI3vjbg28JWKs505fBeL
        iR81ezuuDArwyL5WlErfbvs=
X-Google-Smtp-Source: AA0mqf4606ED6timfNL2L8mg5XBbLtvW2+VAjwGOz2ssGGBLlIyPjgj/B7f36Qhjt0wUWJOouwH14g==
X-Received: by 2002:a17:90a:eb92:b0:213:32de:be32 with SMTP id o18-20020a17090aeb9200b0021332debe32mr4973130pjy.2.1668223372955;
        Fri, 11 Nov 2022 19:22:52 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:22:52 -0800 (PST)
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
Subject: [PATCH 03/11] perf stat: Fix --metric-only --json output
Date:   Fri, 11 Nov 2022 19:22:36 -0800
Message-Id: <20221112032244.1077370-4-namhyung@kernel.org>
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

Fixes: df936cadfb58 ("perf stat: Add JSON output option")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index c7b3a1e10263..96ad0c71adc2 100644
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
2.38.1.493.g58b659f92b-goog

