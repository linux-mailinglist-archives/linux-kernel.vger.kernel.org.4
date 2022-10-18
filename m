Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43056020C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJRCCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJRCCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:02:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE389960;
        Mon, 17 Oct 2022 19:02:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so12647378pjb.2;
        Mon, 17 Oct 2022 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asmqIEkehVBlu4ghVcVYSD1s1d8czrslDCSII7LsD/Q=;
        b=iCrejwQoNjPnaOJtP4D9FKmuMPZRa9yViKCjpstrhaXtvkYlKkEx/LHbxPZiJPSkzz
         1Pi/VnauJtLS0AEfWLHeyFUWW1khgUtngaEBXeJlTwlY8ORfYZ6JaDV42oFZutwNihI3
         /QB7Ts119MyVtyKvlysiN6c4q7kteiz/J6yAQd+PuzFvQUye88tShs5rfergZaMh05lo
         DPF0Nhc90ol7+XxKojrxN7IX74gPqG3Mu7+KNoHsKYyL8STWnqxDg08MjKUZnR7nFejk
         CdxStYCGmhscmVfCovE/VDLcXM/haPBKVSQlDhGo27EVEB2dFXnbW+rwZJYXxt8rmDAs
         /n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asmqIEkehVBlu4ghVcVYSD1s1d8czrslDCSII7LsD/Q=;
        b=sjTriuQjm/aRQJTtVGOHiK1BsUg//jpOy/LLR9mSpl+gRQv5whm68gjtAYD4FKME4E
         q46TCN5KrtJBaRAJPY5yOX6MJN+yb2fsMQBDYcYF5bXhJNh0fZRDkDhVI2Ywep2Pd3H7
         AlVUsW33ziVZkIEixKk2lxcj9Nhy0HMUsKFaHEa4Upj9PsxS81p6ODUt2FU6ag8oEFZ/
         AFqIwP1KHTu0oIbPX2ux0PNlfdly8YJL/yf5ct9IAYQ4eXx/0xk1yQtnN0XfGKZyTQPL
         fPnNx1Mbl+w0jEjtRUtiOiNga+UBKUGBfN/gTHFqnLKq8q29JOdcnHpyN/0H6M5kUVzW
         iukg==
X-Gm-Message-State: ACrzQf2ji8uS3lWF+FUf3MQNcZEwrRew4+W5teUGXx4gi2WbGR12G910
        bZoDRm/ZO99xROd/Kok00wc=
X-Google-Smtp-Source: AMsMyM4t7NOVIlX4vENAOP3uCsrQGLMcs/2oAJnl/hE+3V8ZTvnq39DjNb6rPhQ6Y++KkfbxAyYPTg==
X-Received: by 2002:a17:90b:1644:b0:20b:1cb4:2c9a with SMTP id il4-20020a17090b164400b0020b1cb42c9amr37817800pjb.193.1666058555658;
        Mon, 17 Oct 2022 19:02:35 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:35 -0700 (PDT)
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
Subject: [PATCH 03/20] perf stat: Use evsel__is_hybrid() more
Date:   Mon, 17 Oct 2022 19:02:10 -0700
Message-Id: <20221018020227.85905-4-namhyung@kernel.org>
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

In the stat-display code, it needs to check if the current evsel is
hybrid but it uses perf_pmu__has_hybrid() which can return true for
non-hybrid event too.  I think it's better to use evsel__is_hybrid().

Also remove a NULL check for the 'config' parameter in the
hybrid_merge() since it's called after config->no_merge check.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5c47ee9963a7..4113aa86772f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -704,7 +704,7 @@ static void uniquify_event_name(struct evsel *counter)
 			counter->name = new_name;
 		}
 	} else {
-		if (perf_pmu__has_hybrid()) {
+		if (evsel__is_hybrid(counter)) {
 			ret = asprintf(&new_name, "%s/%s/",
 				       counter->pmu_name, counter->name);
 		} else {
@@ -744,26 +744,14 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 	}
 }
 
-static bool is_uncore(struct evsel *evsel)
-{
-	struct perf_pmu *pmu = evsel__find_pmu(evsel);
-
-	return pmu && pmu->is_uncore;
-}
-
-static bool hybrid_uniquify(struct evsel *evsel)
-{
-	return perf_pmu__has_hybrid() && !is_uncore(evsel);
-}
-
 static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
 			 bool check)
 {
-	if (hybrid_uniquify(counter)) {
+	if (evsel__is_hybrid(counter)) {
 		if (check)
-			return config && config->hybrid_merge;
+			return config->hybrid_merge;
 		else
-			return config && !config->hybrid_merge;
+			return !config->hybrid_merge;
 	}
 
 	return false;
-- 
2.38.0.413.g74048e4d9e-goog

