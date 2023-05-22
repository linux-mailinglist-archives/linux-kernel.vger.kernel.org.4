Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2656170B545
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjEVGpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjEVGoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:44:32 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5102E77
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1ae4c498f0cso57154805ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737843; x=1687329843;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FXlJjlrAGttKZp5HRCBcxE0XLHUZdESbTdmHXPLxLA=;
        b=uQtwox96BxP135Bg+/OnbOh3t08WB231lF5dBoWs7XQck3bMUZTrhASU7PKQAgggKP
         jSpsuc5XfKDqSPJHqPONlBMeCiCuAYxyq9G13gocGHbCjwrVKS8GQeoPc2GKmmE8Tx1C
         NRfTkZIEXeREFqZkO4pPRJOEYBVsDEHzQ7odWrerf1XOVIWDvBKpEIqp8oa3ghLjEz7r
         AXgpmpnzyuu/aPMZidML9SMkQTKmt7mO0sJFG22Q3FSry6nzENTgDrmFt7B97wbsyw70
         6sXgYPTuRLxVZlDUpldlsI8ciPex4R9nYB55AxN8N0WAGBn+9wScSF40AGy1FM5W+EXe
         FCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737843; x=1687329843;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FXlJjlrAGttKZp5HRCBcxE0XLHUZdESbTdmHXPLxLA=;
        b=Wl8Drtu3vEdvkoBzn6QAY/Lw13ISLYrmFR3VQiFkyskc3OG7qkWQIP8vYGlGM+8x9u
         NMvddM/BlA4CtUvyCx0JNbK65Aqv7ve86BpTDShqvNQVeXHcsJtq7wuroPl2xQgn4ong
         wv29VEjrTrqKy6zf8OWo2hpfsCQ7zLET1wfxly+DjbBajicgNgnm/HdL9oOnOYRm4RiG
         +8vlDJzyR6foJeyeDqfz53hEId+LC9dY80Qvj4UeC09/L/+sm9U5k35a8r0pNve7X7Qy
         0F40dxwzWBKPo9fEo/NuRLUikzl2QH35+WlDhKCWW9zjs4HfsNEoYigkREyJBgBsStu8
         hG0Q==
X-Gm-Message-State: AC+VfDyNLTQE1UXGbmmArwX9HnfDvXnjsQTa9fmhlvId375nPhnhaVB9
        J+dHbeh4wfr6ay7s3riOAUPkU0mQZlNL
X-Google-Smtp-Source: ACHHUZ55HBbHoyydmqJrkbpfG3EYrND8RbS1855ZiyjfgI4tGdjEHQmraCmjxhBrJZkKd5Ar5y0srVkir//K
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a17:902:f152:b0:1a6:c58e:9b9e with SMTP id
 d18-20020a170902f15200b001a6c58e9b9emr2177250plb.7.1684737843278; Sun, 21 May
 2023 23:44:03 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:19 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-13-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 12/23] perf header: Avoid hybrid PMU list in write_pmu_caps
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

