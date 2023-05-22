Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D263B70B54E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjEVGrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjEVGp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:45:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33892E59
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:48 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5308f5d8ac9so3103256a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737863; x=1687329863;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72TLmH2W4t53itRP03fYxeW8kLc6/TPjYOWxUzORf6s=;
        b=PkcphY2m0bQMP0ZyOPR2RVtJqOGpihkKEzqjJx2gsfkBHgH0/jhHTds2NEz+jcqEaQ
         GEZp8iaHj5YbTLwfpGDM1VWbzKUQb3ZwD5qVrIScXOptbBakU1B9WWl6OMzvvDXD/qjr
         9NjnR1NwhWK93augXd2wfjyijzsVpZY5zogVBdbivezR++w7GWS2bmikbkuKyJT1fhk9
         mvt627X1v5l8MOerB3HVmQIs6QqpC9Lh17LK6CA51uEMojlHr/rXQ01IkLE1linnl4be
         h5MyEujS5CEJoUhlUJL+G+nb53xhyD5JClPjM/E/b7YApOJagzbyhKTXcDIamxfb15x4
         Tznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737863; x=1687329863;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72TLmH2W4t53itRP03fYxeW8kLc6/TPjYOWxUzORf6s=;
        b=KZfVNvxy942ziEIJmjP1Nm8R8yNcRTV2/RuhPiZvw74t8/e2rjRcs1dEfnNGXSRQad
         aPaWZ4LD8j+0iy39Ui0FjSSpm/bUQRlx3GR2NW+di4765Yqb4Lg8uRJ7j79R36F5mhX3
         FfZFv+cAuXKBvk0b6RdZxd81dURSdjms8dkkzn0ndwfoKQuiH2aAzIn6Qe0ZNqQFdGi5
         K8j6jS4GbBU7mX/iFB6zMCyZ6uBtWYGrFXrMT4jVs6FMlJTi9KLsPTSAHSvgGk3YkNTT
         /a7QXl5RYQTzrrAfit28XAfscpAbln4wW2HsIzZf20PRg6ETqdqZ5HHk3wiYmdCSA8be
         t86g==
X-Gm-Message-State: AC+VfDzSEss+EQpH8hEom53aPNrewJI8fEIqT/cRxw7X/21tnHlHgGD2
        kSP/3VH9rAAJ0wmmxbGfhIsqXFPubqL/
X-Google-Smtp-Source: ACHHUZ7jra7VZJT4OEslfuoWrE8z9a03q8ZBonIBgERnfxnhpKhmMegq1vNMXydobj60GaqrAsHWT9h/tiWA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a63:da02:0:b0:520:4dfb:530a with SMTP id
 c2-20020a63da02000000b005204dfb530amr2200802pgh.8.1684737863132; Sun, 21 May
 2023 23:44:23 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:27 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-21-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 20/23] perf pmus: Split pmus list into core and other
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

Split the pmus list into core and other. This will later allow for
the core and other pmus to be populated separately.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 2fb28e583366..10f5648073bb 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -12,13 +12,19 @@
 #include "pmu.h"
 #include "print-events.h"
 
-static LIST_HEAD(pmus);
+static LIST_HEAD(core_pmus);
+static LIST_HEAD(other_pmus);
 
 void perf_pmus__destroy(void)
 {
 	struct perf_pmu *pmu, *tmp;
 
-	list_for_each_entry_safe(pmu, tmp, &pmus, list) {
+	list_for_each_entry_safe(pmu, tmp, &core_pmus, list) {
+		list_del(&pmu->list);
+
+		perf_pmu__delete(pmu);
+	}
+	list_for_each_entry_safe(pmu, tmp, &other_pmus, list) {
 		list_del(&pmu->list);
 
 		perf_pmu__delete(pmu);
@@ -29,7 +35,12 @@ static struct perf_pmu *pmu_find(const char *name)
 {
 	struct perf_pmu *pmu;
 
-	list_for_each_entry(pmu, &pmus, list) {
+	list_for_each_entry(pmu, &core_pmus, list) {
+		if (!strcmp(pmu->name, name) ||
+		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
+			return pmu;
+	}
+	list_for_each_entry(pmu, &other_pmus, list) {
 		if (!strcmp(pmu->name, name) ||
 		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
 			return pmu;
@@ -53,7 +64,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
 		return pmu;
 
 	dirfd = perf_pmu__event_source_devices_fd();
-	pmu = perf_pmu__lookup(&pmus, dirfd, name);
+	pmu = perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &other_pmus, dirfd, name);
 	close(dirfd);
 
 	return pmu;
@@ -72,7 +83,7 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	if (pmu)
 		return pmu;
 
-	return perf_pmu__lookup(&pmus, dirfd, name);
+	return perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &other_pmus, dirfd, name);
 }
 
 /* Add all pmus in sysfs to pmu list: */
@@ -93,7 +104,7 @@ static void pmu_read_sysfs(void)
 	while ((dent = readdir(dir))) {
 		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
 			continue;
-		/* add to static LIST_HEAD(pmus): */
+		/* add to static LIST_HEAD(core_pmus) or LIST_HEAD(other_pmus): */
 		perf_pmu__find2(fd, dent->d_name);
 	}
 
@@ -104,24 +115,37 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 {
 	struct perf_pmu *pmu;
 
-	list_for_each_entry(pmu, &pmus, list)
+	list_for_each_entry(pmu, &core_pmus, list) {
 		if (pmu->type == type)
 			return pmu;
-
+	}
+	list_for_each_entry(pmu, &other_pmus, list) {
+		if (pmu->type == type)
+			return pmu;
+	}
 	return NULL;
 }
 
+/*
+ * pmu iterator: If pmu is NULL, we start at the begin, otherwise return the
+ * next pmu. Returns NULL on end.
+ */
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
 {
-	/*
-	 * pmu iterator: If pmu is NULL, we start at the begin,
-	 * otherwise return the next pmu. Returns NULL on end.
-	 */
+	bool use_core_pmus = !pmu || pmu->is_core;
+
 	if (!pmu) {
 		pmu_read_sysfs();
-		pmu = list_prepare_entry(pmu, &pmus, list);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	}
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list)
+			return pmu;
+
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
 	}
-	list_for_each_entry_continue(pmu, &pmus, list)
+	list_for_each_entry_continue(pmu, &other_pmus, list)
 		return pmu;
 	return NULL;
 }
-- 
2.40.1.698.g37aff9b760-goog

