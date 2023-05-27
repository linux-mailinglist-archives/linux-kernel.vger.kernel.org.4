Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BAF7132E9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjE0HWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjE0HWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:22:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5177213A
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bad475920a8so1165528276.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172159; x=1687764159;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/IfzR0PqTlQjshfXa1Gk+Wb9K4Bgq3zLGbFa1hs2Y0=;
        b=uv/J/j690VyP3Vt8AeocE8BDGK93yzo4ik+vLkbLL6lR94OjspqqjeFZ5S+D5Jxr9A
         DNQYqLa+7rTD3UJxJFn/LfenDBwFoHgd91XRaJXPShrvCgEWCoxD/V+KBS5+a8rdK5pY
         yi55i5UjKsWgbkbfV4Ru6wvUjiQC3wOy/vHfONVDQajAJW4Rj1JgPK2lCp0H8k9SatAY
         AXBaMn2h+tqFDCzM4Xn5wsDqYTLCkGr8UstLqHZZI+4UKhmUo3DR2DQQ34PVba5ZTi7q
         vVvCk1gzwNcJRRTS8aPGVQqksnFjP9/Byl4R0ppWxr+VG/vDm/jF52VrtIf1JNiCSszG
         P4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172159; x=1687764159;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/IfzR0PqTlQjshfXa1Gk+Wb9K4Bgq3zLGbFa1hs2Y0=;
        b=J8YXs1Zqzl0uvxxdv3RoUytzeq6VBrPbq0/NZZc6o0fbENmaCKcUPQm+Wz1ZsAk/bR
         jf4XHWYSYyjDv6b7Bah6HqS8LkVhF/98Sihmh/BjqZAuiDuhL4quEwJuYt57+uIi0f78
         hX3YhoR2a9S7UZPuThXTKlADyzR9AMkxZBEhthXXh45Fribh4oL3SyFTc1TKnfwmVj1V
         vRjpK3F4uWnibR5qcJgJGWgKpv3FLlZjkAmQW9vUnxgiNXnkOdV4rzzA/lgPeBNocKLs
         6Fm0jLPv86jKNXB0IgdvOqRsQvmLZ1+JKXTrd5NNuHXOmUAq/7HMWaScC1EQPlU/FWmd
         7TRA==
X-Gm-Message-State: AC+VfDztkP8DYz7I46kfKHcr5TjhYIkrCoyPWWYqrqte4eVrTgbVlZ4i
        5nAzwSy+91KsIfXlI+CQHPnsWJ6OepiI
X-Google-Smtp-Source: ACHHUZ5r1DxtGLNUWNB+GABolc7sWBN1A8ru+XnUY/niymG3liCjstTV/fgQ0owgDcu6AkMXuBVlb33Sl8Lq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:b31c:0:b0:b94:6989:7fa6 with SMTP id
 l28-20020a25b31c000000b00b9469897fa6mr841825ybj.4.1685172159462; Sat, 27 May
 2023 00:22:39 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:39 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-4-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 03/34] libperf cpumap: Add "any CPU"/dummy test function
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
index 98d7cb24a158..2a5a29217374 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -356,6 +356,11 @@ bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struct perf_cpu_m
 	return true;
 }
 
+bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map)
+{
+	return map && __perf_cpu_map__cpu(map, 0).cpu == -1;
+}
+
 struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index cedfc26d944e..e38d859a384d 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -18,6 +18,9 @@ struct perf_cache {
 
 struct perf_cpu_map;
 
+/**
+ * perf_cpu_map__dummy_new - a map with a singular "any CPU"/dummy -1 value.
+ */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
@@ -30,11 +33,18 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *or
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

