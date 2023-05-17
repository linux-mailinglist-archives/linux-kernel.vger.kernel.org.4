Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59169706BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjEQPBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjEQPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:00:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4519032
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba83fed51b0so893928276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335569; x=1686927569;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+zByxDvprri5VQ4rcxngDxyCTv45SqKQxUVZ6WFAl8=;
        b=X27m8yXNS7YV6hq/JvFNnMmsSFMgnEtC0lHw1MpIym8Oz6c4Uh3/VSQ674EJwhKX7y
         g+ShkfWDEvRemUvxzBBmHg3vE/oiulZ1PfCfm0aNIA1PzEJ16JjSsnB6OknUaX7SB6jO
         kl2dZgmmym+4sLYku6InDRWz/dDVbcjO3tCyB4wdjMLhTRT/jytO8BxlSVIt0dV5LqVT
         NDx2fLsz+IW0JLs18pk67UwQGZ/P02WShE/iW/ACZ/PzGR/Io89p2vdQKS2FDV4ya1p0
         6w0mL+5iwwsh9PrtZf49Kaf3pCE/s6M95xtyuKHcXiVB8LQ9HqEntp8wL/I4uTp66pc1
         m/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335569; x=1686927569;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+zByxDvprri5VQ4rcxngDxyCTv45SqKQxUVZ6WFAl8=;
        b=dPhbhH81v2hXV7OvUPR8rr15UYkArijRdJFBcfXjZicUK98lf82IBA6wHVgvtnUYAh
         625QN7Q8lFZAYGCW4qTneEhwX0kMUScEeL9r5yYDKkHNLK2oMu6T3ShVjdud3J1XV02u
         ZcDVSIUQ4/K+fgpodbzVUPhb9KQ3iGb6kXzE/KRsZcNEp/CvexGxyLC0kAIi7B3ds4KB
         XZ8ISspe3lLSSVQikDkdp+cSwePguNS7ThZ8yuep+1FYZDpOFv/Qf1uOO89uErhU/cd5
         V9K2r8X40MIT0PnpYCKCSOK4JlbMt2lO/K9NZs3OLRxm+ZzI27wzte/VezuyWsRxSvGf
         AB7A==
X-Gm-Message-State: AC+VfDxYNiI22ATucqwAnJx9ycP2M6qy06RAFULaza7NChdbN5+nhTO2
        6KB3Jf19SSeaV8k/0/3Ha3ShWN01j8Qi
X-Google-Smtp-Source: ACHHUZ7UAVxBOYG/LDa6oMf6ainre+wvdt+4UDdQcxKK96Oxl+o3GriG5mOavr8wBDR/SEMUEAtw4PpK7pvH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1890:b0:b96:7676:db4a with SMTP
 id cj16-20020a056902189000b00b967676db4amr26507169ybb.0.1684335569499; Wed,
 17 May 2023 07:59:29 -0700 (PDT)
Date:   Wed, 17 May 2023 07:58:03 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-24-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 23/23] perf pmus: Ensure all PMUs are read for find_by_type
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
        Raul Silvera <rsilvera@google.com>,
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

perf_pmus__find_by_type may be called for something like a raw event,
in which case the PMU isn't guaranteed to have been looked up. Add a
second check to make sure all PMUs are loaded.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 331c6ad40504..bfb659fa7274 100644
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
 	list_for_each_entry(pmu, &uncore_pmus, list) {
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
2.40.1.606.ga4b1b128d6-goog

