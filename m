Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1071330B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjE0H07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbjE0HZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:25:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64A110C0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:24:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso3872191276.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172214; x=1687764214;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6J3cKUGVc8jbchvN9nhXCNUg1ciZv4CLd2svHk2zTKw=;
        b=cs4DSiwZy/SZo4mMMbq+8YPP1FKdRxt/AiQK6TllEQyD41E4AigkyJW3zpeue2jYoW
         D8klOO9wXwv8e1n4/FKxVKWe9ss7Rk/uOFNg4sGTmPDi8NpzFjra96jnwJwQtQFv2hyU
         xmynjwRchyU/LrRLpcPd8zyg6ACdoLbcRETznlJtgsScWGrnbytpbBfgd7xtWZ9duZUb
         dean2XSF990Ppz4B06o+QSxzRUnvYRIPhYReOrB+O2fgEygZ1EDLjzmsQBW4oJy2ZWt6
         lNkQQVWRey76CZw8s8x8zoxm1f+/7v8W2LB2AC05uNSxSuYnGZaREwzux0t8dD/F0Wp7
         GNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172214; x=1687764214;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6J3cKUGVc8jbchvN9nhXCNUg1ciZv4CLd2svHk2zTKw=;
        b=RkttGcbLE6PmaaSiogDXf2Fl0iKRYCNu1i/1P9vqnK1ZEE7+qHlQHz/03uNWgaU6oa
         o2LmFTK0Rm75ZhngzAOP/lMjRYN7myJSoqUixWYOzX9TSy6Fpz031kBQ32RZVNVUTBAt
         tzld8A/AFePXE0TVdeCooci0HCvnwRNJWnZ6Fi9I6oGYrS3skUtAHLynUBo//xVE13uQ
         s/cfGZPMZXyvq851DTt+AHsI5uCGjG9t4I9MI97gSYWYmagzH22QGz5X2QCSb2Vv2hxl
         AiOYktGpIPoL6Qx0LAPhAmSOXHrwUxYyZaHBElP+XIRm9ktP+1rM2gjmPkf8R6HVeyKm
         ZjaQ==
X-Gm-Message-State: AC+VfDwvooPeTiG0dO7PohEz6DpPOvaiXDpc8K3MwVgbU4iandPaBo1H
        7h8d7cDzfeac6EJfxTiQbofJEtRghI68
X-Google-Smtp-Source: ACHHUZ6tm975fx26tmdU5t4NLuKHgLuu93YXgPPk2egS/sqJ5ulj++qnrblI9Sfo7fDeNySUb6Ebv8C7zu3W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:874a:0:b0:bac:5d2c:844b with SMTP id
 e10-20020a25874a000000b00bac5d2c844bmr1525420ybn.8.1685172214406; Sat, 27 May
 2023 00:23:34 -0700 (PDT)
Date:   Sat, 27 May 2023 00:22:02 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-27-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 26/34] perf x86 mem: minor refactor to is_mem_loads_aux_event
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

