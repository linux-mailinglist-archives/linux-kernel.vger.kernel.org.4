Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B357100C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbjEXWUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbjEXWTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:19:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B55E57
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83fed51adso2722048276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966763; x=1687558763;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FXlJjlrAGttKZp5HRCBcxE0XLHUZdESbTdmHXPLxLA=;
        b=3yVSTrx8Mj/sAfPpyXcwtDmu1s8wS3BNQY4DcgjkHCjjNuG5f7fYODkaec1jAeMHbk
         948ZhQzCP9ucuU/NerNvGaFaen9uEJ9nmi1II9/hV574vTT53wF27P20ZcAaG1RnwKqd
         yG7WaUiezHKd+3MJ07j64jrUuIouyvhnDapEvya2xXQiigMIxwHcdge2VsIWApiot4DT
         4A4zchwqlLnhrSZuEE+VGXAl6UTB6it4E1cOg9G9rzLmozPXPgoF0pMaIZznyq/gStZn
         KFpBK1yug2lMGKgn8aEioYpAI/StTlSnDr/Z8lt6LIydmB0T/gUCyxzaS8JkJtXQRX64
         XeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966763; x=1687558763;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FXlJjlrAGttKZp5HRCBcxE0XLHUZdESbTdmHXPLxLA=;
        b=CoAvVYx0ZmsbCcOVHxVFrzPYH3H/MwbWaxRcYjR6HLpIFLo2xOg1AiEHJH3O4EJNBV
         op7HLnkFJ2fM0pt037ZCLaJ3SY7DgULy7jgj/TrZwoTaDQF+zTigm9JQRKFJXXrEATxi
         O9fdNEafIdsslXIvvtelI2+t4CdL1GYX6AfrletQxwmcd+v0X4xotuf4g9NM+GuMrZLk
         DhXW/9TkQ6STwJmSMrJqfWSpF/xgjyw1npexVuPKqFci1SYosroKKUdxf5BBpFM8jVbD
         kHp9ogsHc++yJt6b9mv7OmK24iRJgI0cuw6yjk+7tkWYzU1UIcwaP7v+wJItcKAwIrhm
         GDpg==
X-Gm-Message-State: AC+VfDwRNFQ90NMpBbRbV1QtiDiTwYj8qWPwP0QT9HYarJehP7ubWPVf
        J1OtXDG2UDapoWOrE5ZTg32UDZ1J2xhL
X-Google-Smtp-Source: ACHHUZ4PfyjIYTN0Xg7UbZJBhh6EAlz+Yf/YFps+nRbKyTsxLZxmw/LJCUOuf9Y9hPOCl8LRyMul4sWoKjea
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a05:6902:b21:b0:bac:6d5a:f69f with SMTP id
 ch33-20020a0569020b2100b00bac6d5af69fmr554341ybb.10.1684966763374; Wed, 24
 May 2023 15:19:23 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:17 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-22-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 21/35] perf header: Avoid hybrid PMU list in write_pmu_caps
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

Avoid perf_pmu__for_each_hybrid_pmu by iterating all PMUs are dumping
the core ones. This will eventually allow removal of the hybrid PMU
list.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 276870221ce0..e24cc8f316cd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -51,7 +51,6 @@
 #include "bpf-event.h"
 #include "bpf-utils.h"
 #include "clockid.h"
-#include "pmu-hybrid.h"
 
 #include <linux/ctype.h>
 #include <internal/lib.h>
@@ -1589,17 +1588,21 @@ static int write_pmu_caps(struct feat_fd *ff,
 	 * Write hybrid pmu caps first to maintain compatibility with
 	 * older perf tool.
 	 */
-	pmu = NULL;
-	perf_pmu__for_each_hybrid_pmu(pmu) {
-		ret = __write_pmu_caps(ff, pmu, true);
-		if (ret < 0)
-			return ret;
+	if (perf_pmu__has_hybrid()) {
+		pmu = NULL;
+		while ((pmu = perf_pmu__scan(pmu))) {
+			if (!pmu->is_core)
+				continue;
+
+			ret = __write_pmu_caps(ff, pmu, true);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	pmu = NULL;
 	while ((pmu = perf_pmu__scan(pmu))) {
-		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
-		    !pmu->nr_caps || perf_pmu__is_hybrid(pmu->name))
+		if (pmu->is_core || !pmu->nr_caps)
 			continue;
 
 		ret = __write_pmu_caps(ff, pmu, true);
-- 
2.40.1.698.g37aff9b760-goog

