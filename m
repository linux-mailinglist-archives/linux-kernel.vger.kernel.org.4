Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC447712F48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbjEZVzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbjEZVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:55:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C23E41
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba802c775caso2665541276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138092; x=1687730092;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwNQ71nzWAtCurlrP6FCuEtDPR9XmwsHJykHXM8qing=;
        b=0ZoF1unr/orlOsISPFYBj91qnKAXDq0B3EiiKU5OTSFpjOBXJA0aWUu1j90QwPC9U5
         zQZY2svERZPcvFvL5HADSim5BXMLe99VMVh5TaUANLTqD7x57rwQnP1Yj6t1NAJZ1BB9
         s2feus1/WhOreHXwAcdg/EC9WX3hMLCAq32rjeeqqhUEz1bGCoUAKsC9/ygb8/bPWQRY
         JKzFdUN8fKyeG+O7DZke/2EGzjVo/PX1PD3tMR3oHXRh/0Bu1UyUfE+STE6HwpM4LzL7
         qV8BwVBzee3XEg2GNqk8HKXajmUgGUssAU+mSA+Ysk8uY/HepVstX0wwIYt+3XZa4buC
         3wBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138092; x=1687730092;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwNQ71nzWAtCurlrP6FCuEtDPR9XmwsHJykHXM8qing=;
        b=j4wdB6JF4qraaYbHfskRjAt5qPf8gJjkLyyozyJWTwsHNJMuRYIUjRWx71cGBwm6cd
         iiKgEBw63/FOJgMzIXjPKsST5Mn7UQ4UmRzpQmFnPfX2lqiBpIcCwMyy2jbWe92M7xHy
         L52Lb07q/r2dH7HwDyQWCxV3ST2Kf3JgQYYsMpp2vSv/I3aDeIEYoQyTyNtc3vimh/1u
         9dkD65wDaZh+hl04U/WkldNwmR79Pazg+4Pe4N9woPXHysyojgrdW2m8wq4+cMI2mJAI
         HJoNpQE8gZM9qj+EIz9nYXXglPN39t+A+6F9w3qF60VJ1IBax105mTidRwD+/EwSup4i
         didg==
X-Gm-Message-State: AC+VfDyd/B0ayZ+y3XmrTZpBKHD3mFPRQsPrQUCOCDSxTReubr2yAQy7
        7sOr2iTLavaJ6fiF5fU7AlvKJOJHdjvR
X-Google-Smtp-Source: ACHHUZ4HPM1O+jGGQYqWpg/LatJr3hW14F3fnfsoBZ0mfOfU/MqJU94PR4Mc+EfWfWfhhCNIIU52c8Dpgsvi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:2646:0:b0:bad:41b:f343 with SMTP id
 m67-20020a252646000000b00bad041bf343mr1730299ybm.1.1685138092595; Fri, 26 May
 2023 14:54:52 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:52 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-18-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 17/35] perf pmu: Rewrite perf_pmu__has_hybrid to avoid list
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than list empty on perf_pmu__hybrid_pmus, detect if any core
PMUs match the hybrid name. Computed values held in statics to avoid
recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 83c7eeb8abea..5a7bfbf621d0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -60,8 +60,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-static bool hybrid_scanned;
-
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
 
 /*
@@ -2013,12 +2011,20 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 
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
2.41.0.rc0.172.g3f132b7071-goog

