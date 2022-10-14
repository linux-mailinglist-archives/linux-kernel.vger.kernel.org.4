Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334545FE8D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJNGRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJNGQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:16:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A434136426;
        Thu, 13 Oct 2022 23:16:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d10so4021712pfh.6;
        Thu, 13 Oct 2022 23:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7heBXOXJm9mLTCEwvj7mFFaDJuLKMS1VibwOeQN7Fg=;
        b=Luvtdlbbg1izMM3Eh/t7Tm1Apo74EXjzMCTiAifcFcl/9nCM8R13VFTxWIDeBv0Hic
         mT8Qd7zcK/k21PPf4eOvckoBxtn/8h2BW4hdajlyXxOXK5qKRedTdafQeZ715Oul2NCG
         UdGkW2avX6O2rdT7e9NW4jjdIqUNErxPfBpDL9cUf8dn4nTw0AG433IZ4cAcdUlGjbH2
         RgeqDKCDhZnUz47RJO+JPaeaKaCuuweasZDT6mtUEKRYZPhnNhbyZEXehM+35a2cyHb3
         FeJf6il3j0/Mi1yQPVB6s2lFTLUxqIyaChcAHt1jZeWkKKQQvZy3uetsxwuDvSmvxAvW
         Z4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V7heBXOXJm9mLTCEwvj7mFFaDJuLKMS1VibwOeQN7Fg=;
        b=CTKDj+v9Vnouhkk1eMnh9o74tEfxWyQQ5dUFrsopFbwPxEBgc/wopDj4Q9yPGG2Bn6
         xxGctXIj26AK6Xch3A8uLX6zXqCd85RJRBwp35bR7BKrSCJWCY9K0MLAOgfs7M160uST
         gH0/YoWGULrQ3fp6uWlZCLhMGaZ/pi8ojBGMR8gTJux+9SruAnEMzP62Sqhfbsk+0iYs
         66cINlSyy2MbMbNZ9NqdoLjPCqFy9Db9Mb/Q43Gj2Sq53zLfOCwr/CwRkUVvt4HSj9Sk
         eDCBPczOf63auclh5LqwnEOBvGeMaSWV36opmq3CNd2aLNkTjK1srr2AST3ZW5K7NQa+
         KKow==
X-Gm-Message-State: ACrzQf32Fvm3BsMpNUONf7aVxdAXSx0QzwlY/5ynCEyoutaFvPasyQuC
        v3ObiaU19dt/NGf0YMAl+EM=
X-Google-Smtp-Source: AMsMyM6ozPXpGTelqHacvaMF4kPa3DXf8Z0qTO1o/rWKLMh/TASiK6mFlzSKYM69nxcDtLLWdqrKhw==
X-Received: by 2002:a63:e74d:0:b0:440:6c50:eab7 with SMTP id j13-20020a63e74d000000b004406c50eab7mr3214767pgk.308.1665728178347;
        Thu, 13 Oct 2022 23:16:18 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:16:18 -0700 (PDT)
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
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 16/19] perf stat: Add perf_stat_process_shadow_stats()
Date:   Thu, 13 Oct 2022 23:15:47 -0700
Message-Id: <20221014061550.463644-17-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014061550.463644-1-namhyung@kernel.org>
References: <20221014061550.463644-1-namhyung@kernel.org>
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

This function updates the shadow stats using the aggregated counts
uniformly since it uses the aggr_counts for the every aggr mode.

It'd have duplicate shadow stats for each items for now since the
display routines will update them once again.  But that'd be fine
as it shows the average values and it'd be gone eventually.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  1 +
 tools/perf/util/stat.c    | 50 ++++++++++++++++++++-------------------
 tools/perf/util/stat.h    |  1 +
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d6a006e41da0..d7c52cef70a3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -489,6 +489,7 @@ static void process_counters(void)
 
 	perf_stat_merge_counters(&stat_config, evsel_list);
 	perf_stat_process_percore(&stat_config, evsel_list);
+	perf_stat_process_shadow_stats(&stat_config, evsel_list);
 }
 
 static void process_interval(void)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4ce457c94898..d51ba63b9ab2 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -455,7 +455,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		aggr_counts->val += count->val;
 		aggr_counts->ena += count->ena;
 		aggr_counts->run += count->run;
-		goto update;
+		return 0;
 	}
 
 	if (ps->aggr) {
@@ -493,32 +493,10 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 	}
 
-update:
-	switch (config->aggr_mode) {
-	case AGGR_THREAD:
-	case AGGR_CORE:
-	case AGGR_DIE:
-	case AGGR_SOCKET:
-	case AGGR_NODE:
-	case AGGR_NONE:
-		if ((config->aggr_mode == AGGR_NONE) && (!evsel->percore)) {
-			perf_stat__update_shadow_stats(evsel, count->val,
-						       cpu_map_idx, &rt_stat);
-		}
-
-		if (config->aggr_mode == AGGR_THREAD) {
-			perf_stat__update_shadow_stats(evsel, count->val,
-						       thread, &rt_stat);
-		}
-		break;
-	case AGGR_GLOBAL:
+	if (config->aggr_mode == AGGR_GLOBAL) {
 		aggr->val += count->val;
 		aggr->ena += count->ena;
 		aggr->run += count->run;
-	case AGGR_UNSET:
-	case AGGR_MAX:
-	default:
-		break;
 	}
 
 	return 0;
@@ -744,6 +722,30 @@ void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *e
 		evsel__process_percore(evsel);
 }
 
+static void evsel__update_shadow_stats(struct evsel *evsel)
+{
+	struct perf_stat_evsel *ps = evsel->stats;
+	int i;
+
+	if (ps->aggr == NULL)
+		return;
+
+	for (i = 0; i < ps->nr_aggr; i++) {
+		struct perf_counts_values *aggr_counts = &ps->aggr[i].counts;
+
+		perf_stat__update_shadow_stats(evsel, aggr_counts->val, i, &rt_stat);
+	}
+}
+
+void perf_stat_process_shadow_stats(struct perf_stat_config *config __maybe_unused,
+				    struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel__update_shadow_stats(evsel);
+}
+
 int perf_event__process_stat_event(struct perf_session *session,
 				   union perf_event *event)
 {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index d23f8743e442..3d413ba8c68a 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -284,6 +284,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
 void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
 void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist);
+void perf_stat_process_shadow_stats(struct perf_stat_config *config, struct evlist *evlist);
 
 struct perf_tool;
 union perf_event;
-- 
2.38.0.413.g74048e4d9e-goog

