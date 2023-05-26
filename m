Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FA3712F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbjEZVyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbjEZVy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:54:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBCE1B0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bac6a453dd5so1641482276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138063; x=1687730063;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Jn8ptCZCPVVUXP02YSlLmlmO+syhCCeFR6clIYIMOY=;
        b=Qwu/cGmcgGyAZcdMWJypusk9brpC8zbYxPdkwt9cWJxryrN+wWqFuUogdM/q+inaa3
         X5CMwBG9pJsw8mJbgbYfB1YQAMRQXotN9Takvp+xsVfHlPCHVViaSXv2SoyszMDBacrk
         dnJQHYm60Hu7PUfcLwgd5sYlI3Awm7IuD6VS3ZNkzQyiH5jPefFnAHa5Rqpm2jbo+dMy
         Y8Df0g22q7KcE5U7lt3p7eQInc+bGhBFC3kSKBmlqnb7WKQnshPIw3QMtpZsklI8r4Da
         1JZR8hAERpXiq/1x0G4WEi0rbKcb+3Y+1YDBdnSB4OtOFQi8OXVVITYzrnr2JS9jc6FW
         EtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138063; x=1687730063;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jn8ptCZCPVVUXP02YSlLmlmO+syhCCeFR6clIYIMOY=;
        b=CWL8ZNlk9+CcPIscUX+XHKPd7Yl8gr4UgLwoH5pmQVxWulzNMzImlWYr7R1xOtBrbf
         BAHgefp/RLQQirKszVqUcjJouhMY9KuQ9UVNfNvhqG/Ek4DdF/cxzndlnI4n/aCDyZQZ
         zotvZbD7F39fIrpsm3NjWXEaRxu6oypBWwXbRxoBWeHEN0RGMkjS7AM7hh4xAKVlCB1G
         wC0c0d3PW7Re11AFHYyMoYLbjTOiqBK0/9EM5GRgej1TUfo11f1Xd6vprE0OrsDApNsj
         mKhFXwByAIHdAsurX7pBOUOpTYGs22MkS8B3klkai7BGhqivUKSIptCcY0D5tFumvMxC
         +eDQ==
X-Gm-Message-State: AC+VfDyY3s4bHmHD/sGKnsys4isrEnJVBkaNuWBtcC5T7xISj41wFyFE
        aPI4hb2jDeJbYtgUZUbduSKl3eGzBllw
X-Google-Smtp-Source: ACHHUZ7CPihlLsasw3b/sk86pIxYuwPTU/q0jnG123S0JRRNIklKIp43J/hfdTdzCRVbqzvIRy7dBEtJSqtd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:4582:0:b0:ba8:4b22:4e8a with SMTP id
 s124-20020a254582000000b00ba84b224e8amr1753266yba.0.1685138063197; Fri, 26
 May 2023 14:54:23 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:39 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-5-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 04/35] libperf cpumap: Add "any CPU"/dummy test function
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

It is common in the code currently to test a map for "empty" when in
fact the "any CPU"/dummy value of -1 is being sought. Add a new
function to enable this and document the behavior of two other
functions. The term "any CPU" comes from perf_event_open, where the
value is consumed, but it is more typical in the code to see this
value/map referred to as the dummy value. This could be misleading due
to the dummy event and also dummy not being intention revealing, so it
is hoped to migrate the code to referring to this as "any CPU".

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/lib/perf/cpumap.c              |  5 +++++
 tools/lib/perf/include/perf/cpumap.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 48595a3ad69c..7c8237a9e902 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -342,6 +342,11 @@ bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struct perf_cpu_m
 	return true;
 }
 
+bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map)
+{
+	return map && perf_cpu_map__cpu(map, 0).cpu == -1;
+}
+
 struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index d0ae9552f8e2..3b7c965a17f2 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -13,6 +13,9 @@ struct perf_cpu {
 
 struct perf_cpu_map;
 
+/**
+ * perf_cpu_map__dummy_new - a map with a singular "any CPU"/dummy -1 value.
+ */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
@@ -25,11 +28,18 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *or
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
+/**
+ * perf_cpu_map__empty - is map either empty or the "any CPU"/dummy value.
+ */
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
 LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
 LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
 				     const struct perf_cpu_map *rhs);
+/**
+ * perf_cpu_map__any_cpu - Does the map contain the "any CPU"/dummy -1 value?
+ */
+LIBPERF_API bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
-- 
2.41.0.rc0.172.g3f132b7071-goog

