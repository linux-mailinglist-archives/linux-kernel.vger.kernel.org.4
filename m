Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6447132E8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjE0HWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjE0HWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:22:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6719A
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56536dd5f79so37771147b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172162; x=1687764162;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zl5H/LAaMs6H1Jjaws3sJN4knTClvax7RvoNDB4HmA4=;
        b=izxX1osE27tCWV0OzJi+hTySjyCv62aYDAMrZ/xEIVznRxWgrSVPb/40HLjHaotabb
         Y1WjfQ7m5cMnGVw7wfQMFD6XKxOaVEsO0jaFcpdgK3I0s5s1oi9nXiY0xuFW2jouex1B
         zaG96feJeImRD/nTuaKK4IhLCRAE+xhc09+5DaikPJeJ/ihMTbPvES4HrtmLFbAqkerf
         wJM8gmOzsOp7QKKfQW0BSdUH64EaoUNK24pUUQPfdZ4NweR8BBmZ5XWYdxSHCTAUPd/x
         OoDofjKzLiLtwlxatWHQzSM9OK3TARBzT3U7bNEYiLLAqqdifF+OUQK+B6POjIcMlLIm
         pBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172162; x=1687764162;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zl5H/LAaMs6H1Jjaws3sJN4knTClvax7RvoNDB4HmA4=;
        b=FTVZlKkh4+x9N45zvS2zrMzhT8wOQroOQgv2tg/UabizbJDxo5tFpxGIEN1YXuUE5r
         TdGfo67Y2VWF7so7AZsCZJpg6hPXAmJzG1ThnIdo9ySqZAeeM4DpYdJhfm1+APWeJuID
         L7XkYysc8u/FkuF2QyFwoZZ2iSG2FMjacce2QYzlylJvQFCgng8uydRM3w7LSqiusTmD
         q1+0eh+BfKyQEgtKmA1NJzuhVIHcOSOGv0r94HLFDz/ereoEoyKCLe3SkOFspXeJzPi4
         pFXC114rsCKf/Y0p+om2qb/MAH2osg7q+7jusXMzMffsiIIf2ZBdLYIWJj7fppzaO8le
         evgA==
X-Gm-Message-State: AC+VfDwd+We899S7tDD9Z5JX/GOKhkTevAXBeaboI9GI1zH9yB6DRKVh
        CJFp8w6LpOfaOJJYlqJ+qPr8Y38pfLV5
X-Google-Smtp-Source: ACHHUZ5G9WGtp0OnJwUzf+KtanBkWlscLf5i0qI04IEzVz12+3i0Lf2rmeQtbSTG9y2ZWnRCWuyDq8prE3K4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:8211:0:b0:ba6:e7ee:bb99 with SMTP id
 q17-20020a258211000000b00ba6e7eebb99mr2344524ybk.12.1685172161878; Sat, 27
 May 2023 00:22:41 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:40 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-5-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 04/34] perf pmu: Detect ARM and hybrid PMUs with sysfs
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

is_arm_pmu_core detects a core PMU via the presence of a "cpus" file
rather than a "cpumask" file. This pattern holds for hybrid PMUs so
rename the function and remove redundant perf_pmu__is_hybrid
tests.

Add a new helper is_pmu_hybrid similar to is_pmu_core.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 29 ++++++++++++++++++-----------
 tools/perf/util/pmu.h |  1 +
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f4f0afbc391c..7392cec725bf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -643,12 +643,14 @@ static char *pmu_id(const char *name)
 	return str;
 }
 
-/*
- *  PMU CORE devices have different name other than cpu in sysfs on some
- *  platforms.
- *  Looking for possible sysfs files to identify the arm core device.
+/**
+ * is_sysfs_pmu_core() - PMU CORE devices have different name other than cpu in
+ *         sysfs on some platforms like ARM or Intel hybrid. Looking for
+ *         possible the cpus file in sysfs files to identify whether this is a
+ *         core device.
+ * @name: The PMU name such as "cpu_atom".
  */
-static int is_arm_pmu_core(const char *name)
+static int is_sysfs_pmu_core(const char *name)
 {
 	char path[PATH_MAX];
 
@@ -814,7 +816,7 @@ void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
 	struct pmu_add_cpu_aliases_map_data data = {
 		.head = head,
 		.name = pmu->name,
-		.cpu_name = is_arm_pmu_core(pmu->name) ? pmu->name : "cpu",
+		.cpu_name = is_sysfs_pmu_core(pmu->name) ? pmu->name : "cpu",
 		.pmu = pmu,
 	};
 
@@ -1647,22 +1649,27 @@ static int cmp_sevent(const void *a, const void *b)
 
 bool is_pmu_core(const char *name)
 {
-	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
+	return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
+}
+
+bool is_pmu_hybrid(const char *name)
+{
+	return !strcmp(name, "cpu_atom") || !strcmp(name, "cpu_core");
 }
 
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+	return is_pmu_core(pmu->name);
 }
 
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+	return is_pmu_core(pmu->name);
 }
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 {
-	return !perf_pmu__is_hybrid(pmu->name);
+	return !is_pmu_hybrid(pmu->name);
 }
 
 static bool pmu_alias_is_duplicate(struct sevent *alias_a,
@@ -1716,7 +1723,7 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		bool is_cpu = is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+		bool is_cpu = is_pmu_core(pmu->name);
 
 		list_for_each_entry(event, &pmu->aliases, list) {
 			aliases[j].event = event;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 0e0cb6283594..f50919f1b34c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -220,6 +220,7 @@ void perf_pmu__del_formats(struct list_head *formats);
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
 bool is_pmu_core(const char *name);
+bool is_pmu_hybrid(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
-- 
2.41.0.rc0.172.g3f132b7071-goog

