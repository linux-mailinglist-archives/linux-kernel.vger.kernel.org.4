Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FBE74E6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGKF7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGKF7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:59:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C23E64
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:59:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57325434999so63683927b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689055159; x=1691647159;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCvcip3cNS9Uck7qRANxqTRMPqOA6kzu5yAG3bPx7q8=;
        b=kgGfCtGt6f/VllzJStsFabPTDGU2UGd7nA4n71pjFUbrOxW1q26EhZnnPIVbKPK2G2
         oURkOkoNRUJocZ0NDLQBhPW1Y1bT34IzxH75QLtgPu/0vrzeHfWp7ZSeF+zHrCQ6Ts5Y
         bInSKahA5vx9v48KISRfLD+qdLuFlKTA02Ikcmm1S7D6ee1Hx+/IVIKfiKn5rWCZ+t/n
         vnb8Yma6UYMKvcVAxdZGBWyzevBFz2NGj+j88BRipaykA/sZEWk1xvW1Qyt6Cy84iTSO
         vOAq7c9xk9qn2/M+cTILPEIcLghk4oS0tFdZGjE0dT2d+RYib/4VwcIW61pd564PxKZc
         IEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689055159; x=1691647159;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCvcip3cNS9Uck7qRANxqTRMPqOA6kzu5yAG3bPx7q8=;
        b=IuFkIsw1AuLFzUNUDub93NMrLxJkrk+Rf+VVrVQYkdQ5MeOFLevyS7mFUlMZfcy1Bl
         ZPVgaL1MNv3cRqpzK6cJ+fpvjRGjaVfBRcx339auJ8Ky7rlouWolHxptxs83gXo8MGP9
         XxR302F8Rkr8xnvpAU1jA8hWuDuaeeLfqgjXGftoIxLa2VPrQ4BvR9dR3EQGtA9efStY
         WRbwy+BaI9rgYmSOQ/DbzEoOf04QJhnhleXzxrHSLsHjcNTEF7l4JGbgv5kQWcpHO8b3
         5DfJp1dJrtopgkFBXsG+ooBiEkG8v6bfxoO9U/9t3dFtXIi/GWOI9jesKvYohiMzrmi/
         mRNA==
X-Gm-Message-State: ABy/qLZrHujZZdLspFpClGMco3Rmotuud7RkLYWcJjS40lkaRxAWM8TO
        CYiB/YmeEx/8XnBYHKAfuMIn8VOUqXxJ
X-Google-Smtp-Source: APBJJlF/hQwvZLvooEgTBAGj8HUCE7NLrFqxQRoLCBxX/VAawfd2grekYqVfsjiVzIubUZjSq3dVhrixaEkk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2efd:fc0f:9eaa:3bd5])
 (user=irogers job=sendgmr) by 2002:a25:8882:0:b0:c4d:4b23:337 with SMTP id
 d2-20020a258882000000b00c4d4b230337mr86042ybl.11.1689055159701; Mon, 10 Jul
 2023 22:59:19 -0700 (PDT)
Date:   Mon, 10 Jul 2023 22:58:57 -0700
In-Reply-To: <20230711055859.1242497-1-irogers@google.com>
Message-Id: <20230711055859.1242497-2-irogers@google.com>
Mime-Version: 1.0
References: <20230711055859.1242497-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Subject: [PATCH v1 1/3] perf pmus: Sort pmus by name then suffix
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort PMUs by name. If two PMUs have the same name but differ by
suffix, sort the suffixes numerically. For example, "breakpoint" comes
before "cpu", "uncore_imc_free_running_0" comes before
"uncore_imc_free_running_1".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index c58ba9fb6a36..3581710667b0 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/list.h>
+#include <linux/list_sort.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
 #include <sys/types.h>
+#include <ctype.h>
 #include <dirent.h>
 #include <pthread.h>
 #include <string.h>
@@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
 static bool read_sysfs_core_pmus;
 static bool read_sysfs_all_pmus;
 
+static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
+{
+	int orig_len, len;
+
+	orig_len = len = strlen(str);
+
+	/* Non-uncore PMUs have their full length, for example, i915. */
+	if (strncmp(str, "uncore_", 7))
+		return len;
+
+	/*
+	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
+	 * the full length.
+	 */
+	while (len > 0 && isdigit(str[len - 1]))
+		len--;
+
+	if (len > 0 && len != orig_len && str[len - 1] == '_') {
+		if (num)
+			*num = strtoul(&str[len], NULL, 10);
+		return len - 1;
+	}
+	return orig_len;
+}
+
 void perf_pmus__destroy(void)
 {
 	struct perf_pmu *pmu, *tmp;
@@ -122,6 +149,25 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
 }
 
+static int pmus_cmp(void *priv __maybe_unused,
+		    const struct list_head *lhs, const struct list_head *rhs)
+{
+	unsigned long lhs_num, rhs_num;
+	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
+	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
+	const char *lhs_pmu_name = lhs_pmu->name ?: "";
+	const char *rhs_pmu_name = rhs_pmu->name ?: "";
+	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
+	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);
+	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
+			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
+
+	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
+		return ret;
+
+	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+}
+
 /* Add all pmus in sysfs to pmu list: */
 static void pmu_read_sysfs(bool core_only)
 {
@@ -156,6 +202,8 @@ static void pmu_read_sysfs(bool core_only)
 		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
 			pr_err("Failure to set up any core PMUs\n");
 	}
+	list_sort(NULL, &core_pmus, pmus_cmp);
+	list_sort(NULL, &other_pmus, pmus_cmp);
 	if (!list_empty(&core_pmus)) {
 		read_sysfs_core_pmus = true;
 		if (!core_only)
-- 
2.41.0.390.g38632f3daf-goog

