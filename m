Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24BA6DA657
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjDFXyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjDFXyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:54:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1FA86B8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:54:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w5-20020a253005000000b00aedd4305ff2so40822217ybw.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680825245;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bp+0kGauH45PVjc3VWjYwognO78vVj4/OGXOJwspQyQ=;
        b=EXZwhgR8QJTtloCPXmEWwfF2YR2plX1tCGVRZjbxKtoPc1N7YxvigbNm1/ztyg1pR7
         yLY3xOCjXLHdBvmNL2le10w2MgaZbhj/AawS0IHpBuuSsyxCEmVOPWnQ0oUgyzwN6XoZ
         FVcPp1cuDmJtY1RT9+DmvX3D642B5o9+MrZ8hbh32mzaO8nYuPmMTlisdmaZKeiBbuC1
         2sAy2KY6cusSlF970zbjH00sLdOSbNSzpn3BfzSf40EXoSgqcuz75grRQcXnHFFoP6zl
         WA86whl3V9yC0BOWnVO+Rghue3JIPkWRY8M/SMgz6YAKAAdvxaZeawpQqPWWIEcwiQUf
         LsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680825245;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bp+0kGauH45PVjc3VWjYwognO78vVj4/OGXOJwspQyQ=;
        b=tJQ8w96rehoZ42eqh+H6QQppYbWSydsEywCJOmetXuPKLhg4orLC199tDNLmkRrx61
         arUfJK2CnnQi6eKEyMFJpsMS5FKiQMTjcgV8ESxTeNLhEsoVjxqSX0+HV0qy+BmLwojT
         6DIlNI7HEbS1uqgxTxHy4zr3izn8rKMiBWuh7Qz0XdoqQtkVNiFe/BMTrn5qka4ESCnh
         5c3TRyDaA472Hj2wFNKqPMxD+2ISIQD6jp7/n8DZKDvD5KBirZ5uW0hLMrll4RDfXCMj
         RVVEadxYzw0pLRVZlft89t9oHaFR2mXLOva+Lpo+VblzLyFAuezjQBAV61cqBUcKgkrM
         ksOg==
X-Gm-Message-State: AAQBX9eGE8wPXbhYH9licxtFQRg1WKCdCo9pYlUEjWFpBAiHpL8vD95Y
        Rzq7w0xCa6zbAvMWh5HDz04pSaAFla2Y
X-Google-Smtp-Source: AKy350b6vHq4dUDdPUjZUgHkkRFRk7OPUnT/d4/J984Mvjfmb35G8z1x/gogfKZwxJBhW5vd0YviFa53/fB3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:939d:185a:97bb:59ee])
 (user=irogers job=sendgmr) by 2002:a25:d6d6:0:b0:ad2:3839:f49 with SMTP id
 n205-20020a25d6d6000000b00ad238390f49mr149081ybg.5.1680825244833; Thu, 06 Apr
 2023 16:54:04 -0700 (PDT)
Date:   Thu,  6 Apr 2023 16:52:55 -0700
In-Reply-To: <20230406235256.2768773-1-irogers@google.com>
Message-Id: <20230406235256.2768773-2-irogers@google.com>
Mime-Version: 1.0
References: <20230406235256.2768773-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1 2/3] perf pmu: Improve name/comments, avoid a memory allocation
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
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve documentation around perf_pmu_alias pmu_name and on
functions. Reduce the scope of pmu_uncore_alias_match to just
file. Rename perf_pmu__valid_suffix to the more revealing
perf_pmu__match_ignoring_suffix. Add a short-cut to
perf_pmu__match_ignoring_suffix for PMU names that don't also have a
socket value, and can therefore avoid a memory allocation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 27 ++++++++++++++++++++-------
 tools/perf/util/pmu.h |  8 +++++---
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 63a33fcfd42d..00714f560643 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -668,11 +668,14 @@ __weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
 	return perf_pmu__find_metrics_table(NULL);
 }
 
-/*
- * Suffix must be in form tok_{digits}, or tok{digits}, or same as pmu_name
- * to be valid.
+/**
+ * perf_pmu__match_ignoring_suffix - Does the pmu_name match tok ignoring any
+ *                                   trailing suffix? The Suffix must be in form
+ *                                   tok_{digits}, or tok{digits}.
+ * @pmu_name: The pmu_name with possible suffix.
+ * @tok: The possible match to pmu_name without suffix.
  */
-static bool perf_pmu__valid_suffix(const char *pmu_name, char *tok)
+static bool perf_pmu__match_ignoring_suffix(const char *pmu_name, const char *tok)
 {
 	const char *p;
 
@@ -697,11 +700,21 @@ static bool perf_pmu__valid_suffix(const char *pmu_name, char *tok)
 	return true;
 }
 
-bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
+/**
+ * pmu_uncore_alias_match - does name match the PMU name?
+ * @pmu_name: the json struct pmu_event name. This may lack a suffix (which
+ *            matches) or be of the form "socket,pmuname" which will match
+ *            "socketX_pmunameY".
+ * @name: a real full PMU name as from sysfs.
+ */
+static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 {
 	char *tmp = NULL, *tok, *str;
 	bool res;
 
+	if (strchr(pmu_name, ',') == NULL)
+		return perf_pmu__match_ignoring_suffix(name, pmu_name);
+
 	str = strdup(pmu_name);
 	if (!str)
 		return false;
@@ -728,7 +741,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 
 		name = strstr(name, tok);
 		if (!name ||
-		    (!next_tok && !perf_pmu__valid_suffix(name, tok))) {
+		    (!next_tok && !perf_pmu__match_ignoring_suffix(name, tok))) {
 			res = false;
 			goto out;
 		}
@@ -1939,7 +1952,7 @@ int perf_pmu__match(char *pattern, char *name, char *tok)
 	if (fnmatch(pattern, name, 0))
 		return -1;
 
-	if (tok && !perf_pmu__valid_suffix(name, tok))
+	if (tok && !perf_pmu__match_ignoring_suffix(name, tok))
 		return -1;
 
 	return 0;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 32c3a75bca0e..6be75594d11e 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -35,7 +35,7 @@ struct perf_pmu_caps {
 };
 
 /**
- * struct perf_pmu - hi
+ * struct perf_pmu
  */
 struct perf_pmu {
 	/** @name: The name of the PMU such as "cpu". */
@@ -186,7 +186,10 @@ struct perf_pmu_alias {
 	 * default.
 	 */
 	bool deprecated;
-	/** @pmu_name: The name copied from struct perf_pmu. */
+	/**
+	 * @pmu_name: The name copied from the json struct pmu_event. This can
+	 * differ from the PMU name as it won't have suffixes.
+	 */
 	char *pmu_name;
 };
 
@@ -238,7 +241,6 @@ void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
 char *perf_pmu__getcpuid(struct perf_pmu *pmu);
 const struct pmu_events_table *pmu_events_table__find(void);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
-bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
-- 
2.40.0.577.gac1e443424-goog

