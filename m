Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16F4712F50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244322AbjEZV4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244168AbjEZV4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:56:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C6C119
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56536dd5f79so30384807b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138115; x=1687730115;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6J3cKUGVc8jbchvN9nhXCNUg1ciZv4CLd2svHk2zTKw=;
        b=0X2D2xRpKNyCid4P4x9RXrBU+RCykPnm8OQdKJb/p+h88BXPtIdg0V1cIUJPoL8Bon
         XE7+Ilxkyiwu+dG6j2vD3qx7i+aF/lOf9Tm8p6zFRlQ9gA9Uoq5cklXR42MSRw42u9rg
         iuOU73vk6hnV/3n5sUxVvoJTikWYj04nNJBPjjO76WvLHolSdnlXcvRGgqfi1U6dzbb1
         3PhALv4QQYg8MimZHnZL2T1iYGv+5Wby/hbaszTs8iq6kSgFS+L4tSM/Yuis6HPYjKb4
         0eNHrVCAZghSMW4StovwWK715oWI2TXcbrF//ywS8Kr6XYtK+HuyvG622KLor4E//e/X
         k6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138115; x=1687730115;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6J3cKUGVc8jbchvN9nhXCNUg1ciZv4CLd2svHk2zTKw=;
        b=dAYy0FOpvw8IE+AbZksmOiOT0Yw9CkKNjnmcBZVzKc2RTi4w32GMLO8wOFHU2tbt/s
         /Wtyh85zB4RbKOgBGhY5QMEM+ErBsJCBMynazBJPJPz6oClR+IdPiw20c+gvVgj1Fx0M
         n2Z75A+Y0a07cheePRaUTx1NxdGAncV0emiRZ+I5ZxnYlCxEvLze68IEwxKxm5mCD+hG
         JNHaPh23ocJvrKhwTZw0XsgUkb9o7Irxm80OFjxLjvCnFOpe+psALB5FdsfT0jiFqWV0
         +C1QKJypvgwFB9wwuij50fV4zMZYZGmyQ6Mp2looQzqOx93a2YIf/HobtaVzIplB8f8a
         Os9Q==
X-Gm-Message-State: AC+VfDyXycRhYxFpgUO/q+LknQtL6wvV6DUpx1JLnb1LDCqESA7r3B6F
        QTUftBOitqKaUUPOo6+WIli7HK9IYav8
X-Google-Smtp-Source: ACHHUZ5fh+g0oWPOYU4V3fSHO16qS0KDLFwGEPTlYVs6dT6fSSrv1wCW/h7+SM/BMmcHAg03PYVCPvRnq/uv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:ed0a:0:b0:565:bf4b:de20 with SMTP id
 k10-20020a81ed0a000000b00565bf4bde20mr1243298ywm.2.1685138114815; Fri, 26 May
 2023 14:55:14 -0700 (PDT)
Date:   Fri, 26 May 2023 14:54:02 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-28-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 27/35] perf x86 mem: minor refactor to is_mem_loads_aux_event
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

Find the PMU and then the event off of it.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/mem-events.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index f683ac702247..02d65e446f46 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -55,13 +55,13 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
 
 bool is_mem_loads_aux_event(struct evsel *leader)
 {
-	if (perf_pmu__find("cpu")) {
-		if (!pmu_have_event("cpu", "mem-loads-aux"))
-			return false;
-	} else if (perf_pmu__find("cpu_core")) {
-		if (!pmu_have_event("cpu_core", "mem-loads-aux"))
-			return false;
-	}
+	struct perf_pmu *pmu = perf_pmu__find("cpu");
+
+	if (!pmu)
+		pmu = perf_pmu__find("cpu_core");
+
+	if (pmu && !pmu_have_event(pmu->name, "mem-loads-aux"))
+		return false;
 
 	return leader->core.attr.config == MEM_LOADS_AUX;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

