Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0056276C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiKNHw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiKNHwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:52:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEF91902C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:52:35 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3697bd55974so98780377b3.15
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=05I6atWVl+qVT8yMUMb7x3GwtdO61HeIYnH9Cn+25jQ=;
        b=T0jkusDStyZ5/LfkNXjH/BXHbYl87NUVAuai8Eb9QK+OjW9SzYud+mHfaAgyfrg49J
         ae8S2lWcCKQFdHcgjmOUDbBG/MIQrsnTZTfKKBMAUn639i9VKnbjpDoprEhOnH5hg41K
         pYshKmLqGxMEwyoCjjq0Koph/XSqa2aMS6vA/fY5ZLH2v23JH7hItMbqKk/EfCH7n9tg
         8PcP2aL0Za63hIZ8UZFMqmlgd6p1UBpfg5r/dZNN7inw1DThRx4uIGo6hjPUx0PN/yIY
         u2uwbeI9IPmakOKA41aErduofz3wpJY7gSwcr4C5NaibG3IEppDWDkmgoDErpwc2eJKG
         E3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05I6atWVl+qVT8yMUMb7x3GwtdO61HeIYnH9Cn+25jQ=;
        b=S/Q9apHTFJ4R1e+/zRoVNw/6Fc+ba3zk7oRdJbQZNJiXl+Q++RCcRofoORRzbm2E2g
         nA+bwYbqL1+rjj7/b7RgkW7G+KMK+vmG8bxmLQK4/HmsLc5dr0mEbgUwRn6UxcLDoPma
         Xw6CECi/PvdNeCyDIhqrjLC2I9nWzow8UW25E9kg1roSJW/VbPf4lAVrdak2/68IiW4G
         CEwxzRvTN3LtXxOUhXvl84SvGDax02+Woy0Yzy5IMNnQQ1rnm1uSg4h9dK3NWZbbvsge
         fcmUw18aEtROocc1OOCZvTE1bo9GkzAwI/dAPLEH9JnYLL1WCz0mfBKUlCbZrzffCwz7
         p4Dw==
X-Gm-Message-State: ANoB5plLWwYyAaUGOSG1gn2EcjrDi/hqLaXjhgKP9IOqTLkYMwRQT9kJ
        e1Af5FEk0ci4IiZnvMjhcJnwTHEI7nIe
X-Google-Smtp-Source: AA0mqf7QLzKGbOAI8epex2XRhwy0tz6GIzt4i1Wu+eMqIfn0DEkrm5R2V0TyMrzQyKUWiUfPsBgt1T+rEfqN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a0d:c485:0:b0:36e:92cf:58a2 with SMTP id
 g127-20020a0dc485000000b0036e92cf58a2mr12033456ywd.504.1668412354663; Sun, 13
 Nov 2022 23:52:34 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:23 -0800
In-Reply-To: <20221114075127.2650315-1-irogers@google.com>
Message-Id: <20221114075127.2650315-6-irogers@google.com>
Mime-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 5/9] perf list: Simplify cache event printing
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code computes an array of cache names then sorts and
prints them. Use a strlist to create a list of names that is
sorted. Keep the hybrid names, it is unclear how to generalize it, but
drop the computation of evt_pmus that is never used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 132 +++++++--------------------------
 1 file changed, 27 insertions(+), 105 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index fefc025bc259..ff7793944246 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -206,137 +206,59 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 
 int print_hwcache_events(const char *event_glob, bool name_only)
 {
-	unsigned int type, op, i, evt_i = 0, evt_num = 0, npmus = 0;
-	char name[64], new_name[128];
-	char **evt_list = NULL, **evt_pmus = NULL;
-	bool evt_num_known = false;
-	struct perf_pmu *pmu = NULL;
-
-	if (perf_pmu__has_hybrid()) {
-		npmus = perf_pmu__hybrid_pmu_num();
-		evt_pmus = zalloc(sizeof(char *) * npmus);
-		if (!evt_pmus)
-			goto out_enomem;
-	}
+	struct strlist *evt_name_list = strlist__new(NULL, NULL);
+	struct str_node *nd;
 
-restart:
-	if (evt_num_known) {
-		evt_list = zalloc(sizeof(char *) * evt_num);
-		if (!evt_list)
-			goto out_enomem;
+	if (!evt_name_list) {
+		pr_debug("Failed to allocate new strlist for hwcache events\n");
+		return -ENOMEM;
 	}
-
-	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
-		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
+	for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
+		for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
 			/* skip invalid cache type */
 			if (!evsel__is_cache_op_valid(type, op))
 				continue;
 
-			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
-				unsigned int hybrid_supported = 0, j;
-				bool supported;
+			for (int i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
+				struct perf_pmu *pmu = NULL;
+				char name[64];
 
 				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
 				if (event_glob != NULL && !strglobmatch(name, event_glob))
 					continue;
 
 				if (!perf_pmu__has_hybrid()) {
-					if (!is_event_supported(PERF_TYPE_HW_CACHE,
-								type | (op << 8) | (i << 16))) {
-						continue;
-					}
-				} else {
-					perf_pmu__for_each_hybrid_pmu(pmu) {
-						if (!evt_num_known) {
-							evt_num++;
-							continue;
-						}
-
-						supported = is_event_supported(
-							PERF_TYPE_HW_CACHE,
-							type | (op << 8) | (i << 16) |
-							((__u64)pmu->type << PERF_PMU_TYPE_SHIFT));
-						if (supported) {
-							snprintf(new_name, sizeof(new_name),
-								 "%s/%s/", pmu->name, name);
-							evt_pmus[hybrid_supported] =
-								strdup(new_name);
-							hybrid_supported++;
-						}
-					}
-
-					if (hybrid_supported == 0)
-						continue;
-				}
-
-				if (!evt_num_known) {
-					evt_num++;
+					if (is_event_supported(PERF_TYPE_HW_CACHE,
+							       type | (op << 8) | (i << 16)))
+						strlist__add(evt_name_list, name);
 					continue;
 				}
-
-				if ((hybrid_supported == 0) ||
-				    (hybrid_supported == npmus)) {
-					evt_list[evt_i] = strdup(name);
-					if (npmus > 0) {
-						for (j = 0; j < npmus; j++)
-							zfree(&evt_pmus[j]);
-					}
-				} else {
-					for (j = 0; j < hybrid_supported; j++) {
-						evt_list[evt_i++] = evt_pmus[j];
-						evt_pmus[j] = NULL;
+				perf_pmu__for_each_hybrid_pmu(pmu) {
+					if (is_event_supported(PERF_TYPE_HW_CACHE,
+					    type | (op << 8) | (i << 16) |
+					    ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT))) {
+						char new_name[128];
+							snprintf(new_name, sizeof(new_name),
+								 "%s/%s/", pmu->name, name);
+							strlist__add(evt_name_list, new_name);
 					}
-					continue;
 				}
-
-				if (evt_list[evt_i] == NULL)
-					goto out_enomem;
-				evt_i++;
 			}
 		}
 	}
 
-	if (!evt_num_known) {
-		evt_num_known = true;
-		goto restart;
-	}
-
-	for (evt_i = 0; evt_i < evt_num; evt_i++) {
-		if (!evt_list[evt_i])
-			break;
-	}
-
-	evt_num = evt_i;
-	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
-	evt_i = 0;
-	while (evt_i < evt_num) {
+	strlist__for_each_entry(nd, evt_name_list) {
 		if (name_only) {
-			printf("%s ", evt_list[evt_i++]);
+			printf("%s ", nd->s);
 			continue;
 		}
-		printf("  %-50s [%s]\n", evt_list[evt_i++],
-				event_type_descriptors[PERF_TYPE_HW_CACHE]);
+		printf("  %-50s [%s]\n", nd->s, event_type_descriptors[PERF_TYPE_HW_CACHE]);
 	}
-	if (evt_num && pager_in_use())
+	if (!strlist__empty(evt_name_list) && pager_in_use())
 		printf("\n");
 
-out_free:
-	evt_num = evt_i;
-	for (evt_i = 0; evt_i < evt_num; evt_i++)
-		zfree(&evt_list[evt_i]);
-	zfree(&evt_list);
-
-	for (evt_i = 0; evt_i < npmus; evt_i++)
-		zfree(&evt_pmus[evt_i]);
-	zfree(&evt_pmus);
-	return evt_num;
-
-out_enomem:
-	printf("FATAL: not enough memory to print %s\n",
-		event_type_descriptors[PERF_TYPE_HW_CACHE]);
-	if (evt_list)
-		goto out_free;
-	return evt_num;
+	strlist__delete(evt_name_list);
+	return 0;
 }
 
 static void print_tool_event(const struct event_symbol *syms, const char *event_glob,
-- 
2.38.1.431.g37b22c650d-goog

