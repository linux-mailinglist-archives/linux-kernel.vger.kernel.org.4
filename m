Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE695F97DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiJJFhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiJJFg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0211C901;
        Sun,  9 Oct 2022 22:36:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l1so9408129pld.13;
        Sun, 09 Oct 2022 22:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTw0uZaEmiJ8khO64LdMRhY5Te3L66NJGNmxBf93CO8=;
        b=E9XDvhH88MS3xy/V83BIMqCWAzB8TGk7+Q0pKTXtyd0TsKNoGz+nchVu/PBVgKuaap
         jMrgElIoW/HxqSLHIU22nQZ2Z/qqTW7qKdHhqEe1k8j8KH/YqaSGIu10R9sD4QiF211r
         StVe9gg+pj2gZkRx8jlJpvyVu9spzCw5i2PCOXGGpIyH21OicOS0Wuh7WyDL6JS8AU5q
         rgjLfqSUIrWKo87NyF3hNIoV7H+c3iR1zd0HTGBRZbuR5ePebEVyrh/5IbZT6Nfr2Ukb
         aj9gXKarna6BZJtmCcG3qeMI1ibJ9kpCE9Hyw6le5RkmUQ0Owb4d0ObEKW10JhWUEiEj
         bViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NTw0uZaEmiJ8khO64LdMRhY5Te3L66NJGNmxBf93CO8=;
        b=5/A3KOhasy58jG9DtRTOeM8tTWIqzQbJgkdIqYaeFmoEkxivKVl1b4Hug6Ky7Be+RE
         E42XYwrbSZMba30jxG7Iq5W8Fv412QmjesqiguVncuajH0lp2BA8bzJx0RlcXK9LqTrL
         CXKTsLv6Qbw85csAKPu7YU6J9yh7/sAsQU+k+VviItun6N5bV2mjPDRf77bGvMvxNPyS
         PyT1UT0k+kNKjCtAWZLZZARzVl/3XmkmGWVvq50PF2jPJV+FJxxP7wp0wO3KsuAr+2+t
         1VqZc3AKjYKmirQVa2MMJi9VNgxWBIM2cEPTH89KvZIYS0zFwCT1vih+Vh96ciyu5W6V
         hplw==
X-Gm-Message-State: ACrzQf2+odNY2yNNn6tldHwBb314hrrfeAK6AbqeRbLD81liuv6y476N
        KPJuO3jKWgP0zJcz8DR6ezA=
X-Google-Smtp-Source: AMsMyM4IrCfUbWQLfLDDLD4yiZA1jKkyPTm3idAra1LnA7KGtAEIkXrBJH2Jy9fsDniNnUK0Yxqedw==
X-Received: by 2002:a17:90a:e00a:b0:209:1545:74a7 with SMTP id u10-20020a17090ae00a00b00209154574a7mr19099946pjy.72.1665380179399;
        Sun, 09 Oct 2022 22:36:19 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:19 -0700 (PDT)
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
Subject: [PATCH 11/19] perf stat: Allocate aggr counts for recorded data
Date:   Sun,  9 Oct 2022 22:35:52 -0700
Message-Id: <20221010053600.272854-12-namhyung@kernel.org>
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

In the process_stat_config_event() it sets the aggr_mode that means the
earlier evlist__alloc_stats() cannot allocate the aggr counts due to the
missing aggr_mode.

Do it after setting the aggr_map using evlist__alloc_aggr_stats().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  8 ++++++++
 tools/perf/util/stat.c    | 39 +++++++++++++++++++++++++++++++--------
 tools/perf/util/stat.h    |  2 ++
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c76240cfc635..983f38cd4caa 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2139,6 +2139,14 @@ int process_stat_config_event(struct perf_session *session,
 	else
 		perf_stat_init_aggr_mode_file(st);
 
+	if (stat_config.aggr_map) {
+		int nr_aggr = stat_config.aggr_map->nr;
+
+		if (evlist__alloc_aggr_stats(session->evlist, nr_aggr) < 0) {
+			pr_err("cannot allocate aggr counts\n");
+			return -1;
+		}
+	}
 	return 0;
 }
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 013dbe1c5d28..279aa4ea342d 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -141,6 +141,31 @@ static void evsel__reset_stat_priv(struct evsel *evsel)
 		memset(aggr, 0, sizeof(*aggr) * ps->nr_aggr);
 }
 
+static int evsel__alloc_aggr_stats(struct evsel *evsel, int nr_aggr)
+{
+	struct perf_stat_evsel *ps = evsel->stats;
+
+	if (ps == NULL)
+		return 0;
+
+	ps->nr_aggr = nr_aggr;
+	ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
+	if (ps->aggr == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__alloc_aggr_stats(evsel, nr_aggr) < 0)
+			return -1;
+	}
+	return 0;
+}
 
 static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
 {
@@ -150,16 +175,14 @@ static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
 	if (ps == NULL)
 		return -ENOMEM;
 
-	if (nr_aggr) {
-		ps->nr_aggr = nr_aggr;
-		ps->aggr = calloc(nr_aggr, sizeof(*ps->aggr));
-		if (ps->aggr == NULL) {
-			free(ps);
-			return -ENOMEM;
-		}
+	evsel->stats = ps;
+
+	if (nr_aggr && evsel__alloc_aggr_stats(evsel, nr_aggr) < 0) {
+		evsel->stats = NULL;
+		free(ps);
+		return -ENOMEM;
 	}
 
-	evsel->stats = ps;
 	perf_stat_evsel_id_init(evsel);
 	evsel__reset_stat_priv(evsel);
 	return 0;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 74bd51a3cb36..936c0709ce0d 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -265,6 +265,8 @@ void evlist__reset_prev_raw_counts(struct evlist *evlist);
 void evlist__copy_prev_raw_counts(struct evlist *evlist);
 void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
 
+int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
+
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
 struct perf_tool;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

