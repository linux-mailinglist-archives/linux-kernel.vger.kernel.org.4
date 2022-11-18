Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3654662EC12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiKRCrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbiKRCqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:46:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598DB8DA72
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:46:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t9-20020a5b03c9000000b006cff5077dc9so3338351ybp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hOpTUbs2zG24A5NwTkIwR6RR83pmtdjF2ORpXNIgag=;
        b=Prnps4xSX700O4nMvLwAx+a7/6g1NA6UwOTKEhxVkrbmoKfNKy9OXZKzPicjgMCJtz
         bkmnJspOwITUBwCmzQ5KSvWPq+t1S3OCkdWD19T1dvQx5RlCp37BsyefB7RR4iHO2H8T
         TN0tspRdk4c0QKO3XMWnyaDQDfgWz1RY2gc1O+gL4TRck9heV+2sMVuP9VRAP9NwsZay
         /gK+SLkPd3xV7+yeATZqem/MwaBmz1Cd5mjhyrSys+Elpb8xAloFozaveldGNFuwr4dZ
         B4mQhPZwwdIFcnIiAnm2+hIVaKQgpyyBbrOoSkUjBe0Wfqx8Kmty/EE74eNtJNwU+CmN
         AUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hOpTUbs2zG24A5NwTkIwR6RR83pmtdjF2ORpXNIgag=;
        b=IEifmzMKP6qXS2BeVzFa3DlqCrF9+GOqGg2h54N0DTn8JPtVHdbCKH64huO3ImGw8n
         EFgQO1e22gVpemW/EKE1g3PoAN96XhvQXJw6S/N5gxiNgWBrkn5KgJjbIMPp2cEYSsjz
         b4OxcB/p4y+qOFoE1VjxTi0kFzO3xF+ETH2Uo6VW7VDyWi4t9dz2thJZW+9ua2K/Dy1y
         NxGU1koeEZ0dLb0a4gMZ0A/UiXk4lEFe+7LoyE5mmKEmTB4g4t4ZQ8bI6eMDRpFKB12W
         2REJUE6xzy72cCRU/9z3GBTFSo0P/bYwLxV0ArOnjpmY4MUKJu80m4ym16JGZ0KliO6q
         sLgQ==
X-Gm-Message-State: ANoB5pltNJ/bJs905aYFV+QK7UXAKVkl1HQ0862RyIZH0YdOlRwII+zm
        vWQ6Y2Ga3nYMsiIDcJP3ny5703vcfDqc
X-Google-Smtp-Source: AA0mqf7Ia54VFTbni0bqvZ5Py+RNqv/HEWXCzLYJmfMm8vNijJYj7sjKrpocx/mZCoM7pzxzw6mVDoGoXOsZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3f1e:c462:d6b8:fba8])
 (user=irogers job=sendgmr) by 2002:a05:6902:690:b0:6df:1528:d64c with SMTP id
 i16-20020a056902069000b006df1528d64cmr4710069ybt.143.1668739608659; Thu, 17
 Nov 2022 18:46:48 -0800 (PST)
Date:   Thu, 17 Nov 2022 18:46:07 -0800
In-Reply-To: <20221118024607.409083-1-irogers@google.com>
Message-Id: <20221118024607.409083-4-irogers@google.com>
Mime-Version: 1.0
References: <20221118024607.409083-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 3/3] perf list: List callback support for libpfm
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed previously, add libpfm support for 'perf list' callbacks and
thereby json support.

Fixes: e42b0ee61282 ("perf list: Add JSON output option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pfm.c | 154 ++++++++++++++++++------------------------
 tools/perf/util/pfm.h |   6 +-
 2 files changed, 70 insertions(+), 90 deletions(-)

diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index f0bcfcab1a93..ac3227ba769c 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -12,6 +12,7 @@
 #include "util/parse-events.h"
 #include "util/pmu.h"
 #include "util/pfm.h"
+#include "util/strbuf.h"
 
 #include <string.h>
 #include <linux/kernel.h>
@@ -130,53 +131,36 @@ static const char *srcs[PFM_ATTR_CTRL_MAX] = {
 };
 
 static void
-print_attr_flags(pfm_event_attr_info_t *info)
+print_attr_flags(struct strbuf *buf, const pfm_event_attr_info_t *info)
 {
-	int n = 0;
+	if (info->is_dfl)
+		strbuf_addf(buf, "[default] ");
 
-	if (info->is_dfl) {
-		printf("[default] ");
-		n++;
-	}
-
-	if (info->is_precise) {
-		printf("[precise] ");
-		n++;
-	}
-
-	if (!n)
-		printf("- ");
+	if (info->is_precise)
+		strbuf_addf(buf, "[precise] ");
 }
 
 static void
-print_libpfm_events_detailed(pfm_event_info_t *info, bool long_desc)
+print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
+		const pfm_pmu_info_t *pinfo, const pfm_event_info_t *info,
+		struct strbuf *buf)
 {
-	pfm_event_attr_info_t ainfo;
-	const char *src;
 	int j, ret;
+	char topic[80], name[80];
 
-	ainfo.size = sizeof(ainfo);
+	strbuf_setlen(buf, 0);
+	snprintf(topic, sizeof(topic), "pfm %s", pinfo->name);
 
-	printf("  %s\n", info->name);
-	printf("    [%s]\n", info->desc);
-	if (long_desc) {
-		if (info->equiv)
-			printf("      Equiv: %s\n", info->equiv);
+	snprintf(name, sizeof(name), "%s::%s", pinfo->name, info->name);
+	strbuf_addf(buf, "Code: 0x%"PRIx64"\n", info->code);
 
-		printf("      Code  : 0x%"PRIx64"\n", info->code);
-	}
 	pfm_for_each_event_attr(j, info) {
-		ret = pfm_get_event_attr_info(info->idx, j,
-					      PFM_OS_PERF_EVENT_EXT, &ainfo);
-		if (ret != PFM_SUCCESS)
-			continue;
-
-		if (ainfo.type == PFM_ATTR_UMASK) {
-			printf("      %s:%s\n", info->name, ainfo.name);
-			printf("        [%s]\n", ainfo.desc);
-		}
+		pfm_event_attr_info_t ainfo;
+		const char *src;
 
-		if (!long_desc)
+		ainfo.size = sizeof(ainfo);
+		ret = pfm_get_event_attr_info(info->idx, j, PFM_OS_PERF_EVENT_EXT, &ainfo);
+		if (ret != PFM_SUCCESS)
 			continue;
 
 		if (ainfo.ctrl >= PFM_ATTR_CTRL_MAX)
@@ -184,64 +168,74 @@ print_libpfm_events_detailed(pfm_event_info_t *info, bool long_desc)
 
 		src = srcs[ainfo.ctrl];
 		switch (ainfo.type) {
-		case PFM_ATTR_UMASK:
-			printf("        Umask : 0x%02"PRIx64" : %s: ",
-				ainfo.code, src);
-			print_attr_flags(&ainfo);
-			putchar('\n');
+		case PFM_ATTR_UMASK: /* Ignore for now */
 			break;
 		case PFM_ATTR_MOD_BOOL:
-			printf("      Modif : %s: [%s] : %s (boolean)\n", src,
-				ainfo.name, ainfo.desc);
+			strbuf_addf(buf, " Modif: %s: [%s] : %s (boolean)\n", src,
+				    ainfo.name, ainfo.desc);
 			break;
 		case PFM_ATTR_MOD_INTEGER:
-			printf("      Modif : %s: [%s] : %s (integer)\n", src,
-				ainfo.name, ainfo.desc);
+			strbuf_addf(buf, " Modif: %s: [%s] : %s (integer)\n", src,
+				    ainfo.name, ainfo.desc);
 			break;
 		case PFM_ATTR_NONE:
 		case PFM_ATTR_RAW_UMASK:
 		case PFM_ATTR_MAX:
 		default:
-			printf("      Attr  : %s: [%s] : %s\n", src,
-				ainfo.name, ainfo.desc);
+			strbuf_addf(buf, " Attr: %s: [%s] : %s\n", src,
+				    ainfo.name, ainfo.desc);
 		}
 	}
-}
+	print_cb->print_event(print_state,
+			pinfo->name,
+			topic,
+			name, info->equiv,
+			/*scale_unit=*/NULL,
+			/*deprecated=*/NULL, "PFM event",
+			info->desc, /*long_desc=*/NULL,
+			/*encoding_desc=*/buf->buf,
+			/*metric_name=*/NULL, /*metric_expr=*/NULL);
 
-/*
- * list all pmu::event:umask, pmu::event
- * printed events may not be all valid combinations of umask for an event
- */
-static void
-print_libpfm_events_raw(pfm_pmu_info_t *pinfo, pfm_event_info_t *info)
-{
-	pfm_event_attr_info_t ainfo;
-	int j, ret;
-	bool has_umask = false;
+	pfm_for_each_event_attr(j, info) {
+		pfm_event_attr_info_t ainfo;
+		const char *src;
 
-	ainfo.size = sizeof(ainfo);
+		strbuf_setlen(buf, 0);
 
-	pfm_for_each_event_attr(j, info) {
-		ret = pfm_get_event_attr_info(info->idx, j,
-					      PFM_OS_PERF_EVENT_EXT, &ainfo);
+		ainfo.size = sizeof(ainfo);
+		ret = pfm_get_event_attr_info(info->idx, j, PFM_OS_PERF_EVENT_EXT, &ainfo);
 		if (ret != PFM_SUCCESS)
 			continue;
 
-		if (ainfo.type != PFM_ATTR_UMASK)
-			continue;
+		if (ainfo.ctrl >= PFM_ATTR_CTRL_MAX)
+			ainfo.ctrl = PFM_ATTR_CTRL_UNKNOWN;
 
-		printf("%s::%s:%s\n", pinfo->name, info->name, ainfo.name);
-		has_umask = true;
+		src = srcs[ainfo.ctrl];
+		if (ainfo.type == PFM_ATTR_UMASK) {
+			strbuf_addf(buf, "Umask: 0x%02"PRIx64" : %s: ",
+				ainfo.code, src);
+			print_attr_flags(buf, &ainfo);
+			snprintf(name, sizeof(name), "%s::%s:%s",
+				 pinfo->name, info->name, ainfo.name);
+			print_cb->print_event(print_state,
+					pinfo->name,
+					topic,
+					name, /*alias=*/NULL,
+					/*scale_unit=*/NULL,
+					/*deprecated=*/NULL, "PFM event",
+					ainfo.desc, /*long_desc=*/NULL,
+					/*encoding_desc=*/buf->buf,
+					/*metric_name=*/NULL, /*metric_expr=*/NULL);
+		}
 	}
-	if (!has_umask)
-		printf("%s::%s\n", pinfo->name, info->name);
 }
 
-void print_libpfm_events(bool name_only, bool long_desc)
+void print_libpfm_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	pfm_event_info_t info;
 	pfm_pmu_info_t pinfo;
-	int i, p, ret;
+	int p, ret;
+	struct strbuf storage;
 
 	libpfm_initialize();
 
@@ -249,12 +243,9 @@ void print_libpfm_events(bool name_only, bool long_desc)
 	info.size  = sizeof(info);
 	pinfo.size = sizeof(pinfo);
 
-	if (!name_only)
-		puts("\nList of pre-defined events (to be used in --pfm-events):\n");
+	strbuf_init(&storage, 2048);
 
 	pfm_for_all_pmus(p) {
-		bool printed_pmu = false;
-
 		ret = pfm_get_pmu_info(p, &pinfo);
 		if (ret != PFM_SUCCESS)
 			continue;
@@ -267,25 +258,14 @@ void print_libpfm_events(bool name_only, bool long_desc)
 		if (pinfo.pmu == PFM_PMU_PERF_EVENT)
 			continue;
 
-		for (i = pinfo.first_event; i != -1;
-		     i = pfm_get_event_next(i)) {
-
+		for (int i = pinfo.first_event; i != -1; i = pfm_get_event_next(i)) {
 			ret = pfm_get_event_info(i, PFM_OS_PERF_EVENT_EXT,
 						&info);
 			if (ret != PFM_SUCCESS)
 				continue;
 
-			if (!name_only && !printed_pmu) {
-				printf("%s:\n", pinfo.name);
-				printed_pmu = true;
-			}
-
-			if (!name_only)
-				print_libpfm_events_detailed(&info, long_desc);
-			else
-				print_libpfm_events_raw(&pinfo, &info);
+			print_libpfm_event(print_cb, print_state, &pinfo, &info, &storage);
 		}
-		if (!name_only && printed_pmu)
-			putchar('\n');
 	}
+	strbuf_release(&storage);
 }
diff --git a/tools/perf/util/pfm.h b/tools/perf/util/pfm.h
index 7d70dda87012..9cc9bb1e0949 100644
--- a/tools/perf/util/pfm.h
+++ b/tools/perf/util/pfm.h
@@ -7,13 +7,14 @@
 #ifndef __PERF_PFM_H
 #define __PERF_PFM_H
 
+#include "print-events.h"
 #include <subcmd/parse-options.h>
 
 #ifdef HAVE_LIBPFM
 int parse_libpfm_events_option(const struct option *opt, const char *str,
 			int unset);
 
-void print_libpfm_events(bool name_only, bool long_desc);
+void print_libpfm_events(const struct print_callbacks *print_cb, void *print_state);
 
 #else
 #include <linux/compiler.h>
@@ -26,8 +27,7 @@ static inline int parse_libpfm_events_option(
 	return 0;
 }
 
-static inline void print_libpfm_events(bool name_only __maybe_unused,
-				       bool long_desc __maybe_unused)
+static inline void print_libpfm_events(const struct print_callbacks *print_cb, void *print_state)
 {
 }
 
-- 
2.38.1.584.g0f3c55d4c2-goog

