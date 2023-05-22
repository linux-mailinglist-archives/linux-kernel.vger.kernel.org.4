Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CBD70B541
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjEVGoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjEVGoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:44:05 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B489E40
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:54 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1ae8ed1c293so11475385ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737833; x=1687329833;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wY12k1F5dOPmIa0ikykHN2ccarTwqFRAmkOKXrH13wU=;
        b=2VubbBxC7SiuoDKB/MAjz1AyE91qcGOI3gAFX+O+h98PNa+/AOLmXiTcQNj35qdvGi
         5sdEkIn7TR+FtSzi81M8ZbsqvKi4CK5TEtis1ZZ7l2pW10E3a9EDpGXp/gPOSn4kCmBS
         PRvYHeDkjO192X2t2le0lojDNk20x1MmMrAaQ4zIGqDLfxc/g7aPiSxfSvdY1iLOkUY+
         nM3AcHDW1A2p05Cr8SlrDS4wY1FlPOkpgooicnN+08ft1d7bSQINpa/R7aPer6HqWEYE
         6P5pgis7h9FnEBg5GEKw13ti0LIPVc65TT4U7Mje+kUGLdIbksls4/rsWFsB8actKpFL
         nHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737833; x=1687329833;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY12k1F5dOPmIa0ikykHN2ccarTwqFRAmkOKXrH13wU=;
        b=EFNFngq84SXiAXD8mOQZOdAVxiTzZvipJ1DLlBIfUrgN/TCmvnaE1VLCgiXz7YMXB2
         sgU7dtYRpGaHCEbitjVR2WZVTyx4GWuIdHQhgANDBwk/JUrMyBgAGg6U16ymYUBnviiP
         4IimJFtk3yxjGsAdM1kjKYtKIkY8LLE+WKrIHZUOXfLjXzxw2PvNXiGA+bE4Y1D78d4Q
         uC5dIqJshVG1xRtAnvUNmnIoLLv3q+g5YLM0RV5ZWz/yjh6j5K5CTmeHyYxtD1KrtRHg
         bAf54vkfUi7afn0H+v8pGEv4pEqoVSl8lE4G7ZDAVIMmo6/jAyXmwE42O6J5dDiacOoq
         12/Q==
X-Gm-Message-State: AC+VfDwh1dGYwRvx2/aYcK6KgMko06mGGkDgR0V2QYV6IlcEcApPXg5s
        51WAp8Ni0UsxHatbeDYDPReigkaRpcyI
X-Google-Smtp-Source: ACHHUZ7RTmbSeAZX0hhQh6vBvLsB75U+w1V7MkmWtfmbzfrbFZyAQderN0XWHUlGDMNmQUiYGrKTJOUDDuEz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a17:903:710:b0:1ac:921c:87f6 with SMTP id
 kk16-20020a170903071000b001ac921c87f6mr2268283plb.8.1684737833230; Sun, 21
 May 2023 23:43:53 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:15 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-9-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 08/23] perf pmu: Rewrite perf_pmu__has_hybrid to avoid list
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than list empty on perf_pmu__hybrid_pmus, detect if any core
PMUs match the hybrid name. Computed values held in statics to avoid
recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 930ec3786964..2da28739e0d3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -60,8 +60,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-static bool hybrid_scanned;
-
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
 
 /*
@@ -2026,12 +2024,20 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 
 bool perf_pmu__has_hybrid(void)
 {
+	static bool hybrid_scanned, has_hybrid;
+
 	if (!hybrid_scanned) {
+		struct perf_pmu *pmu = NULL;
+
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+			if (pmu->is_core && is_pmu_hybrid(pmu->name)) {
+				has_hybrid = true;
+				break;
+			}
+		}
 		hybrid_scanned = true;
-		perf_pmu__scan(NULL);
 	}
-
-	return !list_empty(&perf_pmu__hybrid_pmus);
+	return has_hybrid;
 }
 
 int perf_pmu__match(char *pattern, char *name, char *tok)
-- 
2.40.1.698.g37aff9b760-goog

