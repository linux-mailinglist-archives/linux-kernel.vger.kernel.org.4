Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983C55F3B34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJDCQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJDCQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:16:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE15F3C8D9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:16:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-348608c1cd3so128156817b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=wOCqkT73lJOPzqaB3XEFUXibp2QpYAyxpfecU9cIBE4=;
        b=JZhzkD5ZqZtOT3UKRzXlsN0OQks5rBzok3hFTCsqpWyhl/VqLajyu6ZGb4tXq/aHB+
         LFaqL8zUcTccXJUlCicXWA4dxAjXc84C3adPultI/ppkxOhfBe255mBJPrIiqlKDvYtO
         wDm0y6ktV2vIqb2U8gluFuavvcIWkb9+Tfuhcyuzxrla8s3OMMIDC1XKkwI3IYL8V1w4
         Zo6Ih79avQhkW6WOkeCXTHLOHLIywt3p0p3GlbHLszWCwXKeZobFKBZ4h37SVsJun61U
         SaRGMrJ4FNKGdpF7tBWHm47UY8kdH4S4T8TxP4O6IE8LTSzX60UApeO+TV5h3HcgPkJH
         Jmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=wOCqkT73lJOPzqaB3XEFUXibp2QpYAyxpfecU9cIBE4=;
        b=vVSnIEfp4oQBRB0KZZvwXy4qzzjYgYoz04D5O4svoNtyAYx2TGlmsPD8ZV6fZfVH+g
         j0A99g+UrOSO9vRyXBG++O41i/fdglH9HXjSW0ra46DwNsrIw+95MgqCIrwSoAnG46Yf
         klPs3cpSyh+XreQpz5T1RQGkFpsvO50HmdtEdlfTWFCt9STjygotk8iUVAnE4qtGR/rG
         GntUgXGK704JqPosHrt2K6+8iAe2GMqNM9pMS8AyT7Nocv/RPrjC2VcZuJB5lQ1McQav
         MZNuTR3POZoUFzvdPJbaP+VtQIdjplUontanHRpUag4WEWWzd1qtyDknzz3Xfnm3Jp5N
         jmgA==
X-Gm-Message-State: ACrzQf1cpOv9TD8UYBvcFb55rMzYedGeR/Lq294fVPEbaMSoxILx8FAw
        YIs19XtvtFQYHM7CEBHESR67BHrBJu7b
X-Google-Smtp-Source: AMsMyM5ufCSceSnxBnOra9CRgFOpPjR8kby9rXIFwIYlKYsssFTdf639OMMNcDBPrjE8GHuJbsPrOmPOkt9F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a81:8ac1:0:b0:357:335:fc2a with SMTP id
 a184-20020a818ac1000000b003570335fc2amr14746770ywg.334.1664849782333; Mon, 03
 Oct 2022 19:16:22 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:51 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-3-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 02/23] perf test: Adjust case of test metrics
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Icelake and later architectures have slots events and SLOTS metrics
meaning case sensitivity is important. Make the test metrics case
agree with the name of the metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json | 6 +++---
 tools/perf/pmu-events/empty-pmu-events.c                  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
index 42d9b5242fd7..70ec8caaaf6f 100644
--- a/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
+++ b/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
@@ -34,15 +34,15 @@
     "MetricName": "DCache_L2_All_Miss"
   },
   {
-    "MetricExpr": "dcache_l2_all_hits + dcache_l2_all_miss",
+    "MetricExpr": "DCache_L2_All_Hits + DCache_L2_All_Miss",
     "MetricName": "DCache_L2_All"
   },
   {
-    "MetricExpr": "d_ratio(dcache_l2_all_hits, dcache_l2_all)",
+    "MetricExpr": "d_ratio(DCache_L2_All_Hits, DCache_L2_All)",
     "MetricName": "DCache_L2_Hits"
   },
   {
-    "MetricExpr": "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
+    "MetricExpr": "d_ratio(DCache_L2_All_Miss, DCache_L2_All)",
     "MetricName": "DCache_L2_Misses"
   },
   {
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 5ed8c0aa4817..480e8f0d30c8 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -142,15 +142,15 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 		.metric_name	= "DCache_L2_All_Miss",
 	},
 	{
-		.metric_expr	= "dcache_l2_all_hits + dcache_l2_all_miss",
+		.metric_expr	= "DCache_L2_All_Hits + DCache_L2_All_Miss",
 		.metric_name	= "DCache_L2_All",
 	},
 	{
-		.metric_expr	= "d_ratio(dcache_l2_all_hits, dcache_l2_all)",
+		.metric_expr	= "d_ratio(DCache_L2_All_Hits, DCache_L2_All)",
 		.metric_name	= "DCache_L2_Hits",
 	},
 	{
-		.metric_expr	= "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
+		.metric_expr	= "d_ratio(DCache_L2_All_Miss, DCache_L2_All)",
 		.metric_name	= "DCache_L2_Misses",
 	},
 	{
-- 
2.38.0.rc1.362.ged0d419d3c-goog

