Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3675F97DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiJJFhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiJJFg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA9051A20;
        Sun,  9 Oct 2022 22:36:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 78so9423293pgb.13;
        Sun, 09 Oct 2022 22:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBycnqrUFJrsOi/+zdHGgl1vFz+CiORWzGfom+ATHAE=;
        b=CLMpSTKdpy1WyMIwY3QU3fNnrnsVhqEB904fAVVosG/uMq0eGb2jO2bc1o2gUo1I+D
         pNN3/QFEDjf9cYEN1+61LZ+hRsMkNOM0cKF33JGpKusEVnXqRZIHIPioenxWiktfqOyW
         m6YCa3jYgbzxNNC5c8YgE+LaOSdaiEViMPLvTanfVP+5EQw4BrMf8r8Cncr/TpMTm5TU
         7Vc90MxOLCMauQQDMg/d+Nlqkr1Qs2na3CCENmTI2T9haxESvCX/dA5qCrZmJRT7nYDv
         m5P933Y1k2mnQRrUOwg/UwwasJMt9a9WNUIGuBj0MtjQXhBbrgFpaCEeqaCHEIA4pc83
         QBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBycnqrUFJrsOi/+zdHGgl1vFz+CiORWzGfom+ATHAE=;
        b=LCDy3Mfs11ftLgKGUe4JAj05pe8GmDkbghPAOyNlmITWjeFAMTNsxM595S5WLEj4Ci
         E0As/J9MQQnpet3h6OTwKGgPfMXpx7eSyrU/a3hm1ux+JRWvKp5sFyjkMTdNjQQGfMeO
         FHLGG/0vpq26zFal7zN4/OZchvhsbSPC5W5LrgtOPIKLQILI/5IlTxQgJp18InxawEf/
         cELL0Xa1TKnVHX4tAPHKFL9ppH7lK0h9gQWpJt6HHNDoljxFEosb+POX2F1GodoaXLRg
         ULZpsZhocd9P9PXM5d1m9LAEuTD+HvLMTDtejqOAgXAKhP04/m+YpBB5ipqEK5GU2MTh
         njlw==
X-Gm-Message-State: ACrzQf2GRbcsdet8lsFtRKu7oax8s/TYJX2xkTO9P/f2tnCpHr/kaKEE
        BsSaS+k+kJSLhOfPYCryb90=
X-Google-Smtp-Source: AMsMyM5G3UyEJB4rCeVqTmbBgPe/chnCVANUMQuKbURDWEqvaPaqpALT0HF9KJkXbccQXq16x7nExQ==
X-Received: by 2002:a63:d1b:0:b0:42b:828b:f14a with SMTP id c27-20020a630d1b000000b0042b828bf14amr15427387pgl.235.1665380180775;
        Sun, 09 Oct 2022 22:36:20 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:20 -0700 (PDT)
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
Subject: [PATCH 12/19] perf stat: Reset aggr counts for each interval
Date:   Sun,  9 Oct 2022 22:35:53 -0700
Message-Id: <20221010053600.272854-13-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221010053600.272854-1-namhyung@kernel.org>
References: <20221010053600.272854-1-namhyung@kernel.org>
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

The evsel->stats->aggr->count should be reset for interval processing
since we want to use the values directly for display.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  3 +++
 tools/perf/util/stat.c    | 13 +++++++++++++
 tools/perf/util/stat.h    |  1 +
 3 files changed, 17 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 983f38cd4caa..38036f40e993 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -492,6 +492,8 @@ static void process_interval(void)
 	diff_timespec(&rs, &ts, &ref_time);
 
 	perf_stat__reset_shadow_per_stat(&rt_stat);
+	evlist__reset_aggr_stats(evsel_list);
+
 	read_counters(&rs);
 
 	if (STAT_RECORD) {
@@ -965,6 +967,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		evlist__copy_prev_raw_counts(evsel_list);
 		evlist__reset_prev_raw_counts(evsel_list);
+		evlist__reset_aggr_stats(evsel_list);
 		perf_stat__reset_shadow_per_stat(&rt_stat);
 	} else {
 		update_stats(&walltime_nsecs_stats, t1 - t0);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 279aa4ea342d..4edfc1c5dc07 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -276,6 +276,19 @@ void evlist__reset_stats(struct evlist *evlist)
 	}
 }
 
+void evlist__reset_aggr_stats(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct perf_stat_evsel *ps = evsel->stats;
+		struct perf_stat_aggr *aggr = ps->aggr;
+
+		if (aggr)
+			memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
+	}
+}
+
 void evlist__reset_prev_raw_counts(struct evlist *evlist)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 936c0709ce0d..3a876ad2870b 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -266,6 +266,7 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist);
 void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
 
 int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
+void evlist__reset_aggr_stats(struct evlist *evlist);
 
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

