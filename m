Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8505F97D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiJJFge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiJJFgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4367D32DA0;
        Sun,  9 Oct 2022 22:36:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z20so9429005plb.10;
        Sun, 09 Oct 2022 22:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82fdBXEXmwLSz+/ZriZh/JUm9OSuSmvUd7c6dWjnfLE=;
        b=glK54UMYibgzSu3OSDWgJA8I7assPSVRp98H2g5yk8gOYfTQEXwmdeb7E6nkcE/VV9
         qgoQ/zPL3ww6Q/bboMc1pus+5RL8ZYC0nQsb6GrU9EjBvitToWD5xCowio3slnf0sr3g
         OiWAsSRiIa1KwX+w5pF1BW+91W8QnXHeYXBq7Bi7603OD3BJBk1Ed2AEKmMI+ezB6XpE
         sTYqkB7YfV570O5eCXejjtN+JpyxkyazTSeafhvajaErSrkX7tVTaP8/XG4QpqK7Org2
         /5z9YG5PoxrUPWf2t60gJNl5M+4gG5JkTsaYil3Xkh+T+AcBQxgJiLH/rC51+HQafi5V
         jS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=82fdBXEXmwLSz+/ZriZh/JUm9OSuSmvUd7c6dWjnfLE=;
        b=4MIDTjs00yf5XzPdKrBRIAUrTvEJ4l5WhGYbmvmT880hQbV2uD1m0Z1TbK3I4wWjjJ
         XQQibakd37w9/mVOo2Q97OqI9Onn96TpjAk12rrq5yf6fH7nN3pwS2FA24C6AqF4K+e9
         rkfUOzLMOFjv8sN8vK5PgWKGmkhnzbkQxJmoThozbdpIUQWkdHowOPfqU5OQ+7g6bNaq
         aOMYRuvdtvXWJIzc6pe9yKQRBZpCBe/+dsz//2/6j6dirH9ozsWQjiPleQ4DOQt0rSd8
         afA/FBAFK3pRuQjAwdYVtr08/Mb6MikAfrnuZbJ99R2YuUnEZoOapQQhSKzv2lc5QGEv
         UrNQ==
X-Gm-Message-State: ACrzQf1eAqfjKuapGC6WluPysR+LUgJ93MBwmRsn/YQaiI5NC1XDdzUI
        wGCacJlyLaR/HRUeKC/ZthI=
X-Google-Smtp-Source: AMsMyM4YIWFUnJgLC1+sbps0q1gbqRBYjGTH6meomF/QqMOUMT/HF2HMRL6pEX+Kj1e79y4I1JWJOQ==
X-Received: by 2002:a17:903:11c7:b0:178:af17:e93e with SMTP id q7-20020a17090311c700b00178af17e93emr17192088plh.78.1665380173613;
        Sun, 09 Oct 2022 22:36:13 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:13 -0700 (PDT)
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
Subject: [PATCH 07/19] perf stat: Add struct perf_stat_aggr to perf_stat_evsel
Date:   Sun,  9 Oct 2022 22:35:48 -0700
Message-Id: <20221010053600.272854-8-namhyung@kernel.org>
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

The perf_stat_aggr struct is to keep aggregated counter values and the
states according to the aggregation mode.  The number of entries is
depends on the mode and this is a preparation for the later use.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat.c | 34 +++++++++++++++++++++++++++-------
 tools/perf/util/stat.h |  9 +++++++++
 2 files changed, 36 insertions(+), 7 deletions(-)

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
index b0899c6e002f..ea356e5aa351 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -8,6 +8,7 @@
 #include <sys/resource.h>
 #include "cpumap.h"
 #include "rblist.h"
+#include "counts.h"
 
 struct perf_cpu_map;
 struct perf_stat_config;
@@ -42,9 +43,17 @@ enum perf_stat_evsel_id {
 	PERF_STAT_EVSEL_ID__MAX,
 };
 
+struct perf_stat_aggr {
+	struct perf_counts_values	counts;
+	int				nr;
+	bool				failed;
+};
+
 struct perf_stat_evsel {
 	struct stats		 res_stats;
 	enum perf_stat_evsel_id	 id;
+	int			 nr_aggr;
+	struct perf_stat_aggr	*aggr;
 	u64			*group_data;
 };
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

