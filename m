Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27B8739699
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjFVFDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFVFDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:03:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601F19AD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:03:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573a92296c7so19319007b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687410223; x=1690002223;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=spv5JzGX0x2pdpbwI62L09F+Wjxn2xvZVuWvy7YCIkU=;
        b=LISeiRIj6P7nrA+78HIRlISXa4ibsF+GotQXpGl79GZoIyPJp8hbftO/ygQ0BppZyB
         QbsSQ4KI4LKxcZldYEW9izqASAter51qBd+n2g1YKoIh+JC1MPdZkUAg2eSyPPKhazpl
         lVtZtIpsupaJhHg6H7z1FHtpXJkFRAT7ZzkUJMIV8v7wPhOTMSrpdqNrtT0jeZ+1PlmB
         TOCCZJD2fdB1ESonsOFtZL+Q92+OxU8i8zsQ4dPBNYZdq05I3CK4sOOaOJc7lfou+S7n
         6LDoJJoUJL8vas8K54og9aS/pB3zAGzRQFFOaaRgk2Gjp1hJEPhH1+RWH9nZ0ygzhqXP
         SHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410223; x=1690002223;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spv5JzGX0x2pdpbwI62L09F+Wjxn2xvZVuWvy7YCIkU=;
        b=DwchCAI6o8RkaY3ZyIkpbqspfgmf5QnSWTF+aCHt45vgETCCtBxFq6hhth4xmUE33Z
         Q9R7pnzZ7Udt18PiSGEw+qjd9BrWCRfPBNwy7y+nuXoZUUMq299yBSBYcweZTt7LG0g0
         L9hm2U/zXWv+TluWgbooxrKlFaoJtQSdDBwk2cfff1fokPoRoFtXssWNoLsbrIh9WyJ8
         z65N94jLZEEDjoeuMmOs9RWOxXB4Q1BuohHuRKVczNxazn2kFIK+vFNZG0NE15n2euWF
         pRXFP3pWtcyqZRFXwnuEapC4uBnBkqBpWRmJKAbhkXsuzi2N5lsZEwqCjNVOvgmlQ8B/
         dl3A==
X-Gm-Message-State: AC+VfDxchtaFMphS6WMdNJQ776a+vQD28WGVxtniUhDZhAC76+McY66w
        2ssxQwIz9xwnnfE/79T7oEPDoZ0YRZC9
X-Google-Smtp-Source: ACHHUZ4LtLU6w6fQcZZvEtx63x7//kzm0nGZLwidksdLSY3S3wgCZJp+gvwjnIKdbH1kB87WlleFlPtTNFKE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91f3:1da5:6427:50d6])
 (user=irogers job=sendgmr) by 2002:a81:ad17:0:b0:555:cd45:bc3a with SMTP id
 l23-20020a81ad17000000b00555cd45bc3amr7364418ywh.9.1687410223077; Wed, 21 Jun
 2023 22:03:43 -0700 (PDT)
Date:   Wed, 21 Jun 2023 22:03:28 -0700
Message-Id: <20230622050330.3733114-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 1/2] perf pmus: Add notion of default PMU for JSON events
From:   Ian Rogers <irogers@google.com>
To:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

JSON events created in pmu-events.c by jevents.py may not specify a
PMU they are associated with, in which case it is implied that it is
the first core PMU. Care is needed to select this for regular 'cpu',
s390 'cpum_cf' and ARMs many names as at the point the name is first
needed the core PMUs list hasn't been initialized. Add a helper in
perf_pmus to create this value, in the worst case by scanning sysfs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 35 ++++++++++++++++-------------------
 tools/perf/util/pmus.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/pmus.h |  1 +
 3 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6142e4710a2f..963c12f910c5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -741,9 +741,11 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 }
 
 struct pmu_add_cpu_aliases_map_data {
+	/* List being added to. */
 	struct list_head *head;
-	const char *name;
-	const char *cpu_name;
+	/* If a pmu_event lacks a given PMU the default used. */
+	char *default_pmu_name;
+	/* The PMU that we're searching for events for. */
 	struct perf_pmu *pmu;
 };
 
@@ -752,37 +754,32 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 					void *vdata)
 {
 	struct pmu_add_cpu_aliases_map_data *data = vdata;
-	const char *pname = pe->pmu ? pe->pmu : data->cpu_name;
+	const char *pname = pe->pmu ?: data->default_pmu_name;
 
-	if (data->pmu->is_uncore && pmu_uncore_alias_match(pname, data->name))
-		goto new_alias;
-
-	if (strcmp(pname, data->name))
-		return 0;
-
-new_alias:
-	/* need type casts to override 'const' */
-	__perf_pmu__new_alias(data->head, -1, (char *)pe->name, (char *)pe->desc,
-			      (char *)pe->event, pe);
+	if (!strcmp(pname, data->pmu->name) ||
+	    (data->pmu->is_uncore && pmu_uncore_alias_match(pname, data->pmu->name))) {
+		/* need type casts to override 'const' */
+		__perf_pmu__new_alias(data->head, -1, (char *)pe->name, (char *)pe->desc,
+				      (char *)pe->event, pe);
+	}
 	return 0;
 }
 
 /*
- * From the pmu_events_map, find the table of PMU events that corresponds
- * to the current running CPU. Then, add all PMU events from that table
- * as aliases.
+ * From the pmu_events_table, find the events that correspond to the given
+ * PMU and add them to the list 'head'.
  */
 void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
-			       const struct pmu_events_table *table)
+			const struct pmu_events_table *table)
 {
 	struct pmu_add_cpu_aliases_map_data data = {
 		.head = head,
-		.name = pmu->name,
-		.cpu_name = is_sysfs_pmu_core(pmu->name) ? pmu->name : "cpu",
+		.default_pmu_name = perf_pmus__default_pmu_name(),
 		.pmu = pmu,
 	};
 
 	pmu_events_table_for_each_event(table, pmu_add_cpu_aliases_map_callback, &data);
+	free(data.default_pmu_name);
 }
 
 static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index d891d72c824e..80797e1b862f 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -524,6 +524,37 @@ bool perf_pmus__supports_extended_type(void)
 	return perf_pmus__do_support_extended_type;
 }
 
+char *perf_pmus__default_pmu_name(void)
+{
+	int fd;
+	DIR *dir;
+	struct dirent *dent;
+	char *result = NULL;
+
+	if (!list_empty(&core_pmus))
+		return strdup(list_first_entry(&core_pmus, struct perf_pmu, list)->name);
+
+	fd = perf_pmu__event_source_devices_fd();
+	if (fd < 0)
+		return strdup("cpu");
+
+	dir = fdopendir(fd);
+	if (!dir)
+		return strdup("cpu");
+
+	while ((dent = readdir(dir))) {
+		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
+			continue;
+		if (is_pmu_core(dent->d_name)) {
+			result = strdup(dent->d_name);
+			break;
+		}
+	}
+
+	closedir(dir);
+	return result ?: strdup("cpu");
+}
+
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index d02ffea5d3a4..a21464432d0f 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -20,5 +20,6 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 bool perf_pmus__have_event(const char *pname, const char *name);
 int perf_pmus__num_core_pmus(void);
 bool perf_pmus__supports_extended_type(void);
+char *perf_pmus__default_pmu_name(void);
 
 #endif /* __PMUS_H */
-- 
2.41.0.162.gfafddb0af9-goog

