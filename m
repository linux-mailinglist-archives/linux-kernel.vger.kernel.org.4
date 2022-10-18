Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C360E6020D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiJRCE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiJRCD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:03:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879298E455;
        Mon, 17 Oct 2022 19:03:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so15973717pjg.1;
        Mon, 17 Oct 2022 19:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eqf99fYG2bxqOCUE0EsbHGsdrtUHS7k4C0PA8A7LPhA=;
        b=krDtDn294PHFNxNUjn3QOGC128mXt4iEr8yQacbsB4ANbJQfKuosMJ8HzlOc/7jy8X
         PhnLHfdIdKFOArFh2qxy5Fvc2SQ+pjC3adAqBXGnF2rTFHbTUaGrnsP4QuIf7V7rvoZZ
         Gl3pSs99C49Rv45o0RpLZaYg2zD3Kn/1qBb87iYoIfT2wojwfF9kXpjEgYNCCjsQUN7k
         J0m9LFocsfjSXxSgR8NaFr96yNv2XTCGMgcQ9fNA3IOTULcEJCBfbSphBNYnTejfnn6g
         PqfJ0ZI7Erq2CqCMRMGzGuLgl/hjxZCmdBrS9uAcyn7W4nPWr3VGxap3iZ1mX7j6bEtO
         A3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eqf99fYG2bxqOCUE0EsbHGsdrtUHS7k4C0PA8A7LPhA=;
        b=V9/2zdQSMvnQ6lDMHtMDY+mk2vBlR+0FaAJh0hpNrqsCg+N8ksKzT/308nB6akCPzf
         eTOnylJ8+56r2oklt7fXm0uQHGUpgqVZFtnFbYN8+RcBs0VyiwJ/AXUrpLD4O+fui8nP
         EoW2mKhqV+DUW5OEJcHKqZogJfNUjL6s6M5KPLE8UR7WAKBtPqSqRNebf8pX2+1PsA5S
         TlxFUlH5KI0dvOKLWSCRXHh2sPdiWxenAyPycrtxZB+K13489V+utpMk21N82Hi9TCoQ
         hDbksmf6Tj2F1yT2CqLkuHO/CEJ88enCSFvOq0Db2ZkxbPOdGoo1li4fHzf926ciyOic
         v+Dw==
X-Gm-Message-State: ACrzQf33Mk6Yz6D9f9ls+1Xcve7FzAHLQgta6WwB5rBO2xBVCthDewrs
        J5wQUZXGso/rwepY6JiqK9s=
X-Google-Smtp-Source: AMsMyM4827oULehA0H70d5kavuokQzc9BZOQTS/xMpgBs5VgkpYLAZk1bZIPF4ONjibntr1iokpeTw==
X-Received: by 2002:a17:90b:1b4d:b0:20d:7bbf:46f0 with SMTP id nv13-20020a17090b1b4d00b0020d7bbf46f0mr844247pjb.77.1666058581153;
        Mon, 17 Oct 2022 19:03:01 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:03:00 -0700 (PDT)
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 17/20] perf stat: Add perf_stat_process_shadow_stats()
Date:   Mon, 17 Oct 2022 19:02:24 -0700
Message-Id: <20221018020227.85905-18-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018020227.85905-1-namhyung@kernel.org>
References: <20221018020227.85905-1-namhyung@kernel.org>
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
index 26c48ef7ca92..c0955a0427ab 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -474,7 +474,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		aggr_counts->val += count->val;
 		aggr_counts->ena += count->ena;
 		aggr_counts->run += count->run;
-		goto update;
+		return 0;
 	}
 
 	if (ps->aggr) {
@@ -511,32 +511,10 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
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
@@ -762,6 +740,30 @@ void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *e
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

