Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6DA712F58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbjEZV5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244399AbjEZV44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:56:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA71310CA
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:56:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba82ed6e450so2612608276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138125; x=1687730125;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOjxsGu2+B4s1nXlsSxqdUIWzY+WQ/eQBroudZlXVAc=;
        b=3heuIJcivna50pM+nhJIiF6g54QHYqLhnoOYTDWRfe/uGH0H7OuM0NUlGBfdIEbEvc
         rBhz0+plkzaxpfydo4SF5XQwTGgZGU+UDzrIO2nTY0OIxyVc5QodUaYo9YSQNTezXEUk
         uTEJ3kDf04So354A/p1dvASNE3iPhQvUTNUBgI2kNdoxMIhaKt3Pkf01ZgeX8GOlVatJ
         R6S8oP0+OfCgY/LfTnJJyTlzBlxKwuHTdF56hV1rjOU+nsTWH31ictUoTby/cP2z0dP1
         IrwgBOkzMERCjdOUhhUYHerSGNvf6qOJxYgNVJzjinJNyF15C1insSO5x9hNu7S/2oLQ
         QVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138125; x=1687730125;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOjxsGu2+B4s1nXlsSxqdUIWzY+WQ/eQBroudZlXVAc=;
        b=RV+L5+JC1C2p2RgknZQDWPrB8kywVWZ1ADf7qu3rxFc8gft+qHdlYTKP1CHY4S5bCR
         i6QH1gS0J6QfSyBcy6X7Q0Jg9TzD8Lswb/Y9Y9qPg5A7T8I/w96stplo9VjQnrQzMv28
         2VRuvB85bywdKS+/kCNADpXd/M2oVlMnHKEI4ia4/0NhfpvJfJVKjdEozw636DeCeLGr
         h+r3sBTL9my9bQEaoFeCn1DSx1O82VluhsutXIGfYXs5zcMDzXX6yJ3HrQDviNp5/BEj
         udw4MJrsKLuoJa1GXB5Ua02gYfVFrK/XrWgH/8DSloX5I+na8Wi3gacN7PY4Rx8zYVAK
         gdQA==
X-Gm-Message-State: AC+VfDzSwWX48nKe9Hhw6CrW38ehJ9em+yLG+BuY/QabzYiOAghDnoXu
        LccAkPtbZjZYVQrj9PFj6eK50Pp2dgIm
X-Google-Smtp-Source: ACHHUZ6P7LZw8PLm0hOntGTBJwTABtv2oXXPc9NN7Hx0EtYByo5ppbaUNCOqwaYLvt4xnyMTAIuUqp9sxHtf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:8046:0:b0:ba8:8ec4:db50 with SMTP id
 a6-20020a258046000000b00ba88ec4db50mr1241672ybn.1.1685138125618; Fri, 26 May
 2023 14:55:25 -0700 (PDT)
Date:   Fri, 26 May 2023 14:54:07 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-33-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 32/35] perf pmus: Ensure all PMUs are read for find_by_type
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

perf_pmus__find_by_type may be called for something like a raw event,
in which case the PMU isn't guaranteed to have been looked up. Add a
second check to make sure all PMUs are loaded.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmus.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 2c512345191d..6ecccb5ad03e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -142,7 +142,7 @@ static void pmu_read_sysfs(bool core_only)
 	}
 }
 
-struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
+static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
 {
 	struct perf_pmu *pmu;
 
@@ -150,6 +150,7 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 		if (pmu->type == type)
 			return pmu;
 	}
+
 	list_for_each_entry(pmu, &other_pmus, list) {
 		if (pmu->type == type)
 			return pmu;
@@ -157,6 +158,18 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
+{
+	struct perf_pmu *pmu = __perf_pmus__find_by_type(type);
+
+	if (pmu || read_sysfs_all_pmus)
+		return pmu;
+
+	pmu_read_sysfs(/*core_only=*/false);
+	pmu = __perf_pmus__find_by_type(type);
+	return pmu;
+}
+
 /*
  * pmu iterator: If pmu is NULL, we start at the begin, otherwise return the
  * next pmu. Returns NULL on end.
-- 
2.41.0.rc0.172.g3f132b7071-goog

