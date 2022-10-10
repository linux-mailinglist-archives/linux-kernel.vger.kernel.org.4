Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25FF5F97D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiJJFgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiJJFgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FA7C2D;
        Sun,  9 Oct 2022 22:36:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so2401177pjb.2;
        Sun, 09 Oct 2022 22:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF8kS7IC9JmJWu9CYOcUcUJa+w2IlroRMDwbSXBYpmk=;
        b=Yc8pHoS+9/AC7UuJ/pmqRT8wRDxYpXIm/mBBrtek1R4uxS3iNwqlKwu1zHWW1Qu0CV
         Yq/gUBUOtklBxVI2zT+MWCz2apKJLZfLGDciPLGSjGm5RSlq1TkEC3Ef9PvJrJ7fhgqY
         4KkmReo3mGiTMGxf9pUfahS04mxmZC4hrmms9X/yuWwJ7W1HngMEKNBTuVaK3rBgGBXw
         Y+RjAbosp8GJYpY0USrkDGfc6ocNBDs+WUPS9Oni6lgMuhdI9j8BIDlfH5ktepflbz5M
         W++eC12Z/13CeTGu/0acXueD6NI2VN1pvut+eSSBLutqXGv8c5ERnrLiDIZumx+kuEej
         i/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nF8kS7IC9JmJWu9CYOcUcUJa+w2IlroRMDwbSXBYpmk=;
        b=w1zeFDEEMpsxwq762K1u6y/tF/iy9j4ejJikwQ1Te65bmCmmsIDkvdP4IbxPpnPuQc
         3Hnw9U5JWvkj5jiFNQa12aZJStGEc0+yAJ/8PpT44FUwzCWylM3+nptQCkNGduCmyuxa
         hVbVYYUE54ZNdP11eqxdNnRjESqxok2SDZ53WJUj06vFJFHOzFFMrlaGp8G21G6bG8LG
         xx9n4hsw92OG2CDRHQw+7FJhb90m7/iS4FRTmXiw3KW1RbH2f/fzzT2G+5BSnOdxWB2c
         tZ4W4awHq6EyqW4A0FdGzXIhxb7w9ohpmt+S/4vA3hBAgVBV2Sl+IuxBw4tWcTCOXPHL
         ek6w==
X-Gm-Message-State: ACrzQf18CwZfT2ltAh/3QaZ1J3rRRbZbijtvOZ+fI1EGqqjhDbfVU3Cl
        dHeHuR72qNbpVZ5mHowhtlM=
X-Google-Smtp-Source: AMsMyM7GovfJMFHHeCX8D2vgcYLfofnuje5OANpz82zMrTWJMMclqmfitALDMVe3Gvk2ZW7Cqf6/FA==
X-Received: by 2002:a17:902:cf03:b0:179:b7fe:dc90 with SMTP id i3-20020a170902cf0300b00179b7fedc90mr17863467plg.112.1665380167525;
        Sun, 09 Oct 2022 22:36:07 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:07 -0700 (PDT)
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
Subject: [PATCH 03/19] perf stat: Use evsel__is_hybrid() more
Date:   Sun,  9 Oct 2022 22:35:44 -0700
Message-Id: <20221010053600.272854-4-namhyung@kernel.org>
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

In the stat-display code, it needs to check if the current evsel is
hybrid but it uses perf_pmu__has_hybrid() which can return true for
non-hybrid event too.  I think it's better to use evsel__is_hybrid().

Also remove a NULL check for the 'config' parameter in the
hybrid_merge() since it's called after config->no_merge check.

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
2.38.0.rc1.362.ged0d419d3c-goog

