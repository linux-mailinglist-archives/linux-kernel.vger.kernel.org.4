Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A8B7132EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjE0HXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjE0HXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:23:02 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FDDE4D
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:49 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-64fa2fce033so812698b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172169; x=1687764169;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxikTjPqwp1WCLl5Lix2f7vwNBIatwttVwavnzKDn3Q=;
        b=Z5gCQoruwtpdCQsaTzQ3WD4Mvi2Gw1Bt/69x/wxLJTaW7XdYnS/Sske2iBMlP9DeUB
         IU4BztMbOhozcxLGWVdpDw0GM6Y5BsgPVGPtbc/KHG6UOLoN7fEW16+ycIeFl0TNTzpk
         KruPR2EUIj7te5O1qXWQcCKDz1xGMBuSSHJpJXc2c2yqwvIvkXeIHsZ8mpP6AAfGDqbm
         JfBwGXTkHzo+saKXMdUp+MEgLgPqRN3fW7XhTA1tuSVdN5686JhcaDbv1P2Gto7enf2z
         RABnx7b69LMdSssgaGhRG/J69RFvgiODo+Uny+XSX7t7Zlni58bmrT53aVnR43JXh9PZ
         FofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172169; x=1687764169;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxikTjPqwp1WCLl5Lix2f7vwNBIatwttVwavnzKDn3Q=;
        b=eYtWM9f95ol0I9Biy9mMuFSnQ4aox+3lYEKZJdNy437daySUdiQrKUlM3L63s3Y8Ii
         MY3MKw8Bx8rR4VdFb8FazTp1rLXKR1uOR6SwKxBho34eIbhBqrJ86fclEQNucuhfHdKK
         Li60xrcKb4U+sadKobvtCInqvHK5X/SKPZ28HjjZwJq/W1HJPRPIP+seYmyImnBWEYBU
         n+DqvTFwcXv4Zo0WO1P7rhXg4wRVb8EktRE5wR0fw2VMilO9kjmaLmLhWiPWXPjBV7RE
         dc94tW3+ZSctQqtJJSBkIY5O7t2cwqhOEENHH8ggHuufP4elp/b5zI7JfCrL1L3iBj7d
         mVwA==
X-Gm-Message-State: AC+VfDzxInuNGCIbbPgQAaylsVIrZMC2TkqV+ctqZjStH2+voOeRHumY
        oCokiVF5vY9qEBVtUgLzZvH5TxpjB87h
X-Google-Smtp-Source: ACHHUZ7kmmbSeza1SxV7kJuzWWYgfXfPbTAO2mtWKREuOedoy9aIvJKN0gH/jGiAISIosaGBX8GVX7d+B/CW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a05:6a00:b95:b0:63b:526c:ab09 with SMTP id
 g21-20020a056a000b9500b0063b526cab09mr1737145pfj.0.1685172169277; Sat, 27 May
 2023 00:22:49 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:43 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-8-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 07/34] perf pmu: Add CPU map for "cpu" PMUs
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

A typical "cpu" PMU has no "cpus" or "cpumask" file meaning the CPU
map is set to NULL, which also encodes an empty CPU map. Update
pmu_cpumask so that if the "cpu" PMU fails to load a CPU map, use a
default of all online PMUs.

Remove const from cpu_map__online for the sake of reference counting.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/cpumap.c | 4 ++--
 tools/perf/util/cpumap.h | 4 ++--
 tools/perf/util/pmu.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index a0719816a218..0e090e8bc334 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -667,9 +667,9 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	return ptr - buf;
 }
 
-const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
+struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 {
-	static const struct perf_cpu_map *online = NULL;
+	static struct perf_cpu_map *online;
 
 	if (!online)
 		online = perf_cpu_map__new(NULL); /* from /sys/devices/system/cpu/online */
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index f394ccc0ccfb..9df2aeb34d3d 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -55,7 +55,7 @@ struct perf_cpu_map *cpu_map__new_data(const struct perf_record_cpu_map_data *da
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
-const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
+struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
 int cpu__setup_cpunode_map(void);
 
@@ -66,7 +66,7 @@ struct perf_cpu cpu__max_present_cpu(void);
 /**
  * cpu_map__is_dummy - Events associated with a pid, rather than a CPU, use a single dummy map with an entry of -1.
  */
-static inline bool cpu_map__is_dummy(struct perf_cpu_map *cpus)
+static inline bool cpu_map__is_dummy(const struct perf_cpu_map *cpus)
 {
 	return perf_cpu_map__nr(cpus) == 1 && perf_cpu_map__cpu(cpus, 0).cpu == -1;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e8c0762c311a..d992f5242d99 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -610,7 +610,7 @@ static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name)
 			return cpus;
 	}
 
-	return NULL;
+	return !strcmp(name, "cpu") ? perf_cpu_map__get(cpu_map__online()) : NULL;
 }
 
 static bool pmu_is_uncore(int dirfd, const char *name)
-- 
2.41.0.rc0.172.g3f132b7071-goog

