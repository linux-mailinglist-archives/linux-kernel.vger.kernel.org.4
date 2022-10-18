Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8794B6020C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJRCDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiJRCC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:02:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2658BBB0;
        Mon, 17 Oct 2022 19:02:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so12679456pjl.0;
        Mon, 17 Oct 2022 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O82+8QMAp8RP+N1H707IzqXEjvaKP67GyMX407VeP1E=;
        b=gC20X17cP9M8w1boudX6rq/hky6XA6ioZRiVt17X/mFlXGMZJ2f0K8DaJH9WAqf6LH
         LXQhJM/c/o16N3eOSrh1Rsk1A+AEDQs2w55BP7aQRR5CTduFsNKx7Q/O85hviN3jdThs
         782p1kOIgp27KSd1pAPAUmW+jhdJhD3FVLPc3gi16NYuoee4rkAfVKvxmH8qnYUFRqfD
         De9GYIz8C0kjre5SXoJHXI4pJHS9w4dpFHFceZvqDQx/0fr08+PZPJJ/92198le7sd4M
         NbuMsh905SpLg0tnDyeGiQqoELJoQtzf+SfeUzD5ySMyZ7lSAZzm01vlL17/4Ww8tz9W
         Hb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O82+8QMAp8RP+N1H707IzqXEjvaKP67GyMX407VeP1E=;
        b=DaUtOVLV4ssKxdArNXRS+ZdKHwp25+dc1Hxj09dsscUcWDHCz435+z3D93XBn1xK7d
         QWOS3LO0T0edSkvFrq36rrGfgQ0b8MpoSUGNeBPzvzsj8mSqHg2mRc4rKEAwoWIKRyJR
         InDQFruIqKfbmsfzqnClczBZXzSUV9dSOVv6wNkyzCk1fVkuyvfBDzQCjtVEY3wJLP5J
         2cg3Ij0UvECO1RW7TB9G7SMzREC9RS96Ws+zqEzskfdiqQXYvEn+LTcRYzvWKhGfOilz
         YFXFprwlibQhI2C75yMPRlZXemKHKTD2YDaaaT4YziQYfMqVFShG1XGxGlznBg7gNIuS
         k99A==
X-Gm-Message-State: ACrzQf0Rl5uXrRqOTAJ3c8yjJYSUEHTJho2PsBI0XeovbFYdkjgj0hVk
        pfxXD4EBTKidgxSgPLQ2M3w=
X-Google-Smtp-Source: AMsMyM6wFcUsxfFfaxX47sUa6ucF0RPvyZVOX9rZsEYZ5OVu8idOHPAah+3PpMwn9Xr84XwnRSdRMA==
X-Received: by 2002:a17:902:7c91:b0:17f:6711:1fac with SMTP id y17-20020a1709027c9100b0017f67111facmr834165pll.118.1666058563165;
        Mon, 17 Oct 2022 19:02:43 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:42 -0700 (PDT)
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
Subject: [PATCH 07/20] perf stat: Add struct perf_stat_aggr to perf_stat_evsel
Date:   Mon, 17 Oct 2022 19:02:14 -0700
Message-Id: <20221018020227.85905-8-namhyung@kernel.org>
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

The perf_stat_aggr struct is to keep aggregated counter values and the
states according to the aggregation mode.  The number of entries is
depends on the mode and this is a preparation for the later use.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat.c | 34 +++++++++++++++++++++++++++-------
 tools/perf/util/stat.h | 19 +++++++++++++++++++
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 8ec8bb4a9912..c9d5aa295b54 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -133,15 +133,33 @@ static void perf_stat_evsel_id_init(struct evsel *evsel)
 static void evsel__reset_stat_priv(struct evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
+	struct perf_stat_aggr *aggr = ps->aggr;
 
 	init_stats(&ps->res_stats);
+
+	if (aggr)
+		memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
 }
 
-static int evsel__alloc_stat_priv(struct evsel *evsel)
+
+static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
 {
-	evsel->stats = zalloc(sizeof(struct perf_stat_evsel));
-	if (evsel->stats == NULL)
+	struct perf_stat_evsel *ps;
+
+	ps = zalloc(sizeof(*ps));
+	if (ps == NULL)
 		return -ENOMEM;
+
+	if (nr_aggr) {
+		ps->nr_aggr = nr_aggr;
+		ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
+		if (ps->aggr == NULL) {
+			free(ps);
+			return -ENOMEM;
+		}
+	}
+
+	evsel->stats = ps;
 	perf_stat_evsel_id_init(evsel);
 	evsel__reset_stat_priv(evsel);
 	return 0;
@@ -151,8 +169,10 @@ static void evsel__free_stat_priv(struct evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
 
-	if (ps)
+	if (ps) {
+		zfree(&ps->aggr);
 		zfree(&ps->group_data);
+	}
 	zfree(&evsel->stats);
 }
 
@@ -181,9 +201,9 @@ static void evsel__reset_prev_raw_counts(struct evsel *evsel)
 		perf_counts__reset(evsel->prev_raw_counts);
 }
 
-static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
+static int evsel__alloc_stats(struct evsel *evsel, int nr_aggr, bool alloc_raw)
 {
-	if (evsel__alloc_stat_priv(evsel) < 0 ||
+	if (evsel__alloc_stat_priv(evsel, nr_aggr) < 0 ||
 	    evsel__alloc_counts(evsel) < 0 ||
 	    (alloc_raw && evsel__alloc_prev_raw_counts(evsel) < 0))
 		return -ENOMEM;
@@ -196,7 +216,7 @@ int evlist__alloc_stats(struct evlist *evlist, bool alloc_raw)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__alloc_stats(evsel, alloc_raw))
+		if (evsel__alloc_stats(evsel, 0, alloc_raw))
 			goto out_free;
 	}
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b0899c6e002f..42453513ffea 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -8,6 +8,7 @@
 #include <sys/resource.h>
 #include "cpumap.h"
 #include "rblist.h"
+#include "counts.h"
 
 struct perf_cpu_map;
 struct perf_stat_config;
@@ -42,9 +43,27 @@ enum perf_stat_evsel_id {
 	PERF_STAT_EVSEL_ID__MAX,
 };
 
+/* hold aggregated event info */
+struct perf_stat_aggr {
+	/* aggregated values */
+	struct perf_counts_values	counts;
+	/* number of entries (CPUs) aggregated */
+	int				nr;
+	/* whether any entry has failed to read/process event */
+	bool				failed;
+};
+
+/* per-evsel event stats */
 struct perf_stat_evsel {
+	/* used for repeated runs */
 	struct stats		 res_stats;
+	/* evsel id for quick check */
 	enum perf_stat_evsel_id	 id;
+	/* number of allocated 'aggr' */
+	int			 nr_aggr;
+	/* aggregated event values */
+	struct perf_stat_aggr	*aggr;
+	/* used for group read */
 	u64			*group_data;
 };
 
-- 
2.38.0.413.g74048e4d9e-goog

