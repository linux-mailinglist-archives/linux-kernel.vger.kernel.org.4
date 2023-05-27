Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDC37132EA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjE0HWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjE0HWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:22:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A73713A
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5653a78102eso38245867b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172164; x=1687764164;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JqGxN6yla1ONavwrAlpvOZ5bTLHXY2jrhduxUQXwek=;
        b=s/qCJoYFmMD1q/Q/HnpP2+mVHztV8rIdHJlEfQG23+bSKKxmAJr8TWYT7RWK6LZQ7N
         fUs9fVGRajBzk9hxiKddk3DERSx8HfkpKvbvQStOZbWhQvVT8L1iRhOBYbBYh/cYNFvd
         XCabo4Cl9jznBKvV8bLtoJzutyboRQxTsbJpu5VRk8dOoT9DHwfoQ/IKk+5g2dHkEd/n
         z1ygWVL+tyLM+8/3V2gDo+/dLIVTZJ1pJHp7UixecmaIoX/LHlaZcXWmSOd1hXPVIcdC
         hekdyKAVNBbqDhrvYSu2rxmBveJ9hJ7dcShdjuoOmC5knTuhC4OBxt+wnf9Xt2GW/7tu
         t19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172164; x=1687764164;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JqGxN6yla1ONavwrAlpvOZ5bTLHXY2jrhduxUQXwek=;
        b=a228JnP8pAZFnaM8NnJwITn3z+IJkVjIkGyLzO3lLfeisrjLe1X3f/E59+MXF7969b
         ZskWS3jUvukxGGZqx3lWpop1t9NLV3XMKkPVHoNKFXTLE+Pdax8OLL6N3xhkz05YDkfi
         PhKDdgeyGWawpblNJNCD7P995Uy5s6NYMUic1/BTvCiMgi2WmoTfkvSDKGqUGAvJf1+J
         JFirSj+82rGeY7LofP6V37lRUnbEdiqYpwlY1ZDL/fY93lZ0mXSdu0jQvyS/WoMFurws
         af3AcixyxsO6ykWEkH6514Y29zcB0GAFzSaS8C/EfkP4Brx5PDfjIMKoCXbbFvS3kOP7
         ep1A==
X-Gm-Message-State: AC+VfDwy6iHasmcXLDNdeUwxXmO2nKCpSkQzUMLkiSq3l1hX8UxI5JvA
        Z30T+mQkNPEmGmxABaPiCYa7EIoNd5ll
X-Google-Smtp-Source: ACHHUZ4mJjHPIFq49krZo/Mrp2SDJhyklikURm+dq2RRzW5z+jhGsfakK3EgvJ8o5xTz3OB9g2HT4s6NZD7z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:b71e:0:b0:565:d1af:2131 with SMTP id
 v30-20020a81b71e000000b00565d1af2131mr520683ywh.5.1685172164434; Sat, 27 May
 2023 00:22:44 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:41 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-6-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 05/34] perf pmu: Add is_core to pmu
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

Cache is_pmu_core in the pmu to avoid recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 7 ++++---
 tools/perf/util/pmu.h | 7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7392cec725bf..e8c0762c311a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -952,6 +952,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	}
 
 	pmu->type = type;
+	pmu->is_core = is_pmu_core(name);
 	pmu->is_uncore = pmu_is_uncore(dirfd, name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
@@ -1659,12 +1660,12 @@ bool is_pmu_hybrid(const char *name)
 
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name);
+	return pmu->is_core;
 }
 
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name);
+	return pmu->is_core;
 }
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
@@ -1723,7 +1724,7 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		bool is_cpu = is_pmu_core(pmu->name);
+		bool is_cpu = pmu->is_core;
 
 		list_for_each_entry(event, &pmu->aliases, list) {
 			aliases[j].event = event;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index f50919f1b34c..96236a79c6fd 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -59,6 +59,13 @@ struct perf_pmu {
 	 * @selectable: Can the PMU name be selected as if it were an event?
 	 */
 	bool selectable;
+	/**
+	 * @is_core: Is the PMU the core CPU PMU? Determined by the name being
+	 * "cpu" or by the presence of
+	 * <sysfs>/bus/event_source/devices/<name>/cpus. There may be >1 core
+	 * PMU on systems like Intel hybrid.
+	 */
+	bool is_core;
 	/**
 	 * @is_uncore: Is the PMU not within the CPU core? Determined by the
 	 * presence of <sysfs>/bus/event_source/devices/<name>/cpumask.
-- 
2.41.0.rc0.172.g3f132b7071-goog

