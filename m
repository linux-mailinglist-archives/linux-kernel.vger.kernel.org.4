Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C70713305
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjE0HZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjE0HYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:24:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4B5E4E
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4eefebso3250125276.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172200; x=1687764200;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqP1dRbi0z833EHF751vl8giti0HXs5ukSY7qCN1g0w=;
        b=2kBMBGQCNCVPXKwPpkHyJBWvUoRDkBN/sKyHrI22HZN4kVsv1tjrWZ1+1PyWumUUv4
         zmyxWFFQEX4TwMCeQWgZjlKqEpQjscS8OTAupUoKjx/2DHjLKJNLeoMJi5KX7li4KSUB
         Qp8tHNHvi7EPYLlOLpYoisV7UZnQn3yaT34IxQELV4ljKiJtnZ7Jz3JCT+nEcA0v6wLT
         yccndEwXdPCDPf4b5HVj0nCugelJgh2HQ15UGQ1KG+2lof65+sVsjhmxPnVqM319BNo7
         AOfSZKbKkHM3SZGtatcGRyMz2X/CrAZsvykgUcZU2AZ8wWEbboqeuvprtTZefHOQ9L1b
         XfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172200; x=1687764200;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqP1dRbi0z833EHF751vl8giti0HXs5ukSY7qCN1g0w=;
        b=IHJ5BIjmPlIuN1w5U3IfhbQJgqt8En+JzO9cAel/gsUc4mON5C0DgtW/3vi+kWxTyM
         4UyEN40+CP3RMzTgl7F/j13MOu2Sxywb+fpvFACXaIubKxXrjiyQglGIuEH6VRpaFqXn
         Lo4RJN7fAdjaus9y+DEQP9Kfp0HcaY3H5PECsvAznQyLYYvE+wD7OphAzKfLCbLh/+cm
         YH5Kj9t/GVmoUVhPsFe0BicT7mZ1DLhaZ9QPfsRSPfLPYKAtpY221AfIY2fwwfEi5yvg
         7aU1QKtfwQynkgvSSViatHDPvQquyUZ7xX0djlr78zAj34NJbe42Z/vuXYX20s63geCx
         wssQ==
X-Gm-Message-State: AC+VfDwvS4B3xc0E+AfokOPyIBnl6NHL0s2VfH7CUA8fzopa9aZ3itYb
        GDf20tSPIlbTBPd0DsmaENjGfaomNxMc
X-Google-Smtp-Source: ACHHUZ76o+c/sYmGbWvbAaIBR4uAUeBzaLsvkyOeiJjP693g36lTy8NpDAqBGh9DNxkz1LfXqYWApOmzVF7I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:5ca:0:b0:bad:252:9f73 with SMTP id
 193-20020a2505ca000000b00bad02529f73mr1645263ybf.0.1685172200050; Sat, 27 May
 2023 00:23:20 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:56 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-21-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 20/34] perf header: Avoid hybrid PMU list in write_pmu_caps
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

Avoid perf_pmu__for_each_hybrid_pmu by iterating all PMUs are dumping
the core ones. This will eventually allow removal of the hybrid PMU
list.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/header.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 560871736764..37fa66b1ca77 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -51,7 +51,6 @@
 #include "bpf-event.h"
 #include "bpf-utils.h"
 #include "clockid.h"
-#include "pmu-hybrid.h"
 
 #include <linux/ctype.h>
 #include <internal/lib.h>
@@ -1605,17 +1604,21 @@ static int write_pmu_caps(struct feat_fd *ff,
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
2.41.0.rc0.172.g3f132b7071-goog

