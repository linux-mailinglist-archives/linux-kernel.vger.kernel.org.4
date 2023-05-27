Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF6F7132E5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjE0HWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjE0HWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:22:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0802912A
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561f201a646so36502407b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172154; x=1687764154;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NKwlyXDvi4TAib/MQHOSHwUj1vOGQp2Gy0+IiR3d+yk=;
        b=3wumILkNEhrY/9Q+oY5UUhrbJtDs5zxOJ1sDZiXZbiYFgYU356YvQ+XjLxrQeqX7Uh
         f3/GBV0a+AXlicQodNnx9QJA+kIsthYO/x7ZJlT+A0X4ly49zE6CvjxL4rb/B4vaL9G7
         LuZhZmgIKNzJ+cTooHtX7Emqz9cXm6x/tmQc6uM++7t9TRTwnehAYSjMhz0XPQ32+YJc
         4zG++FGJzmcx0FQ7Aq1HaKdrs+l6Ff/5qyMUo5oAcXtcQL4LmT5qbHMhZ3E2qy6Hj9Ar
         nUWEillBQssWjibj4y2LWlpPMHVGkyJiaH/9vRnk6sTlQW6XOvzx5K2zzGjRISHVGWMx
         cjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172154; x=1687764154;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKwlyXDvi4TAib/MQHOSHwUj1vOGQp2Gy0+IiR3d+yk=;
        b=PUU7clEEHkJapNreCJH8YiVx63eSlc6U99t43+f5hGP/darOcAvkV4cO1gIpWZk73y
         7M94F8/HWWR2kMBbBpcJM1GBsoAr9NnTU9dHKUnQwHMHeNicHAoE/sreApooEFDKxT81
         h1BMR7rQydj+rt5LdjgCcVjgyCqilyKd0YUXqMym97o+DH4ZXNu/9CnqG61IFZAu9a0X
         zM98D4AfI4flmJyf9KkHdP7nOo8IVNiLvLEKKXHwyjekYLXdAIMauELp935cVWxH03cW
         ByFcxVDjWoLUvk2Plr2CpOrlp7UoskQ2eTCFaYrF+FgiAM1l6YR2k1uYQIlF1YeYqjCN
         P6WA==
X-Gm-Message-State: AC+VfDxIK4NN8w/svNw0an+OOCSVCfyqm6MEOFzM0qnHb1ir0nTyJTU9
        PFIBOtbJa+fqh7vAa2+WgqYHxo21AeCc
X-Google-Smtp-Source: ACHHUZ5nn19zZfoX2OmJ785N7mYI0VfRvjROK/lia39ta2xMAHyKZpNv5WUFuWlL0Uc0XhHztbUVznHkidoO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:ef02:0:b0:565:bb48:2b57 with SMTP id
 o2-20020a81ef02000000b00565bb482b57mr2044422ywm.0.1685172154287; Sat, 27 May
 2023 00:22:34 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:37 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-2-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 01/34] perf cpumap: Add internal nr and cpu accessors
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
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>
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

These accessors assume the map is non-null. Rewrite functions to use
rather than direct accesses. This also fixes a build regression for
REFCNT_CHECKING in the intersect function.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 74 +++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 29 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index d4f3a1a12522..ec3f4ac8b1e2 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -99,6 +99,11 @@ static int cmp_cpu(const void *a, const void *b)
 	return cpu_a->cpu - cpu_b->cpu;
 }
 
+static struct perf_cpu __perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
+{
+	return RC_CHK_ACCESS(cpus)->map[idx];
+}
+
 static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, const struct perf_cpu *tmp_cpus)
 {
 	size_t payload_size = nr_cpus * sizeof(struct perf_cpu);
@@ -111,8 +116,12 @@ static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, const struct perf_cpu
 		/* Remove dups */
 		j = 0;
 		for (i = 0; i < nr_cpus; i++) {
-			if (i == 0 || RC_CHK_ACCESS(cpus)->map[i].cpu != RC_CHK_ACCESS(cpus)->map[i - 1].cpu)
-				RC_CHK_ACCESS(cpus)->map[j++].cpu = RC_CHK_ACCESS(cpus)->map[i].cpu;
+			if (i == 0 ||
+			    __perf_cpu_map__cpu(cpus, i).cpu !=
+			    __perf_cpu_map__cpu(cpus, i - 1).cpu) {
+				RC_CHK_ACCESS(cpus)->map[j++].cpu =
+					__perf_cpu_map__cpu(cpus, i).cpu;
+			}
 		}
 		perf_cpu_map__set_nr(cpus, j);
 		assert(j <= nr_cpus);
@@ -269,26 +278,31 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 	return cpus;
 }
 
+static int __perf_cpu_map__nr(const struct perf_cpu_map *cpus)
+{
+	return RC_CHK_ACCESS(cpus)->nr;
+}
+
 struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 {
 	struct perf_cpu result = {
 		.cpu = -1
 	};
 
-	if (cpus && idx < RC_CHK_ACCESS(cpus)->nr)
-		return RC_CHK_ACCESS(cpus)->map[idx];
+	if (cpus && idx < __perf_cpu_map__nr(cpus))
+		return __perf_cpu_map__cpu(cpus, idx);
 
 	return result;
 }
 
 int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 {
-	return cpus ? RC_CHK_ACCESS(cpus)->nr : 1;
+	return cpus ? __perf_cpu_map__nr(cpus) : 1;
 }
 
 bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 {
-	return map ? RC_CHK_ACCESS(map)->map[0].cpu == -1 : true;
+	return map ? __perf_cpu_map__cpu(map, 0).cpu == -1 : true;
 }
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
@@ -299,10 +313,10 @@ int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 		return -1;
 
 	low = 0;
-	high = RC_CHK_ACCESS(cpus)->nr;
+	high = __perf_cpu_map__nr(cpus);
 	while (low < high) {
 		int idx = (low + high) / 2;
-		struct perf_cpu cpu_at_idx = RC_CHK_ACCESS(cpus)->map[idx];
+		struct perf_cpu cpu_at_idx = __perf_cpu_map__cpu(cpus, idx);
 
 		if (cpu_at_idx.cpu == cpu.cpu)
 			return idx;
@@ -328,7 +342,9 @@ struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 	};
 
 	// cpu_map__trim_new() qsort()s it, cpu_map__default_new() sorts it as well.
-	return RC_CHK_ACCESS(map)->nr > 0 ? RC_CHK_ACCESS(map)->map[RC_CHK_ACCESS(map)->nr - 1] : result;
+	return __perf_cpu_map__nr(map) > 0
+		? __perf_cpu_map__cpu(map, __perf_cpu_map__nr(map) - 1)
+		: result;
 }
 
 /** Is 'b' a subset of 'a'. */
@@ -336,15 +352,15 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
 {
 	if (a == b || !b)
 		return true;
-	if (!a || RC_CHK_ACCESS(b)->nr > RC_CHK_ACCESS(a)->nr)
+	if (!a || __perf_cpu_map__nr(b) > __perf_cpu_map__nr(a))
 		return false;
 
-	for (int i = 0, j = 0; i < RC_CHK_ACCESS(a)->nr; i++) {
-		if (RC_CHK_ACCESS(a)->map[i].cpu > RC_CHK_ACCESS(b)->map[j].cpu)
+	for (int i = 0, j = 0; i < __perf_cpu_map__nr(a); i++) {
+		if (__perf_cpu_map__cpu(a, i).cpu > __perf_cpu_map__cpu(b, j).cpu)
 			return false;
-		if (RC_CHK_ACCESS(a)->map[i].cpu == RC_CHK_ACCESS(b)->map[j].cpu) {
+		if (__perf_cpu_map__cpu(a, i).cpu == __perf_cpu_map__cpu(b, j).cpu) {
 			j++;
-			if (j == RC_CHK_ACCESS(b)->nr)
+			if (j == __perf_cpu_map__nr(b))
 				return true;
 		}
 	}
@@ -374,27 +390,27 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 		return perf_cpu_map__get(other);
 	}
 
-	tmp_len = RC_CHK_ACCESS(orig)->nr + RC_CHK_ACCESS(other)->nr;
+	tmp_len = __perf_cpu_map__nr(orig) + __perf_cpu_map__nr(other);
 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
 	if (!tmp_cpus)
 		return NULL;
 
 	/* Standard merge algorithm from wikipedia */
 	i = j = k = 0;
-	while (i < RC_CHK_ACCESS(orig)->nr && j < RC_CHK_ACCESS(other)->nr) {
-		if (RC_CHK_ACCESS(orig)->map[i].cpu <= RC_CHK_ACCESS(other)->map[j].cpu) {
-			if (RC_CHK_ACCESS(orig)->map[i].cpu == RC_CHK_ACCESS(other)->map[j].cpu)
+	while (i < __perf_cpu_map__nr(orig) && j < __perf_cpu_map__nr(other)) {
+		if (__perf_cpu_map__cpu(orig, i).cpu <= __perf_cpu_map__cpu(other, j).cpu) {
+			if (__perf_cpu_map__cpu(orig, i).cpu == __perf_cpu_map__cpu(other, j).cpu)
 				j++;
-			tmp_cpus[k++] = RC_CHK_ACCESS(orig)->map[i++];
+			tmp_cpus[k++] = __perf_cpu_map__cpu(orig, i++);
 		} else
-			tmp_cpus[k++] = RC_CHK_ACCESS(other)->map[j++];
+			tmp_cpus[k++] = __perf_cpu_map__cpu(other, j++);
 	}
 
-	while (i < RC_CHK_ACCESS(orig)->nr)
-		tmp_cpus[k++] = RC_CHK_ACCESS(orig)->map[i++];
+	while (i < __perf_cpu_map__nr(orig))
+		tmp_cpus[k++] = __perf_cpu_map__cpu(orig, i++);
 
-	while (j < RC_CHK_ACCESS(other)->nr)
-		tmp_cpus[k++] = RC_CHK_ACCESS(other)->map[j++];
+	while (j < __perf_cpu_map__nr(other))
+		tmp_cpus[k++] = __perf_cpu_map__cpu(other, j++);
 	assert(k <= tmp_len);
 
 	merged = cpu_map__trim_new(k, tmp_cpus);
@@ -416,20 +432,20 @@ struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
 	if (perf_cpu_map__is_subset(orig, other))
 		return perf_cpu_map__get(other);
 
-	tmp_len = max(orig->nr, other->nr);
+	tmp_len = max(__perf_cpu_map__nr(orig), __perf_cpu_map__nr(other));
 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
 	if (!tmp_cpus)
 		return NULL;
 
 	i = j = k = 0;
-	while (i < orig->nr && j < other->nr) {
-		if (orig->map[i].cpu < other->map[j].cpu)
+	while (i < __perf_cpu_map__nr(orig) && j < __perf_cpu_map__nr(other)) {
+		if (__perf_cpu_map__cpu(orig, i).cpu < __perf_cpu_map__cpu(other, j).cpu)
 			i++;
-		else if (orig->map[i].cpu > other->map[j].cpu)
+		else if (__perf_cpu_map__cpu(orig, i).cpu > __perf_cpu_map__cpu(other, j).cpu)
 			j++;
 		else {
 			j++;
-			tmp_cpus[k++] = orig->map[i++];
+			tmp_cpus[k++] = __perf_cpu_map__cpu(orig, i++);
 		}
 	}
 	if (k)
-- 
2.41.0.rc0.172.g3f132b7071-goog

