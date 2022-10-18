Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2246020C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJRCCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJRCCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:02:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E40F844CE;
        Mon, 17 Oct 2022 19:02:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 67so12738212pfz.12;
        Mon, 17 Oct 2022 19:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BRWQ1hkRGo/t2t1Y4zQ7FNnMWXMwqdSp5KgGUNdwvk=;
        b=lqIrEEJFH+6fv8601BrcwUP0h3xLWOxO77cvpPmE0CacznT2LcC8Ugxa+hS+t7k8XA
         WpcgdxhteQ6s7zSA8s7i4q0dPnmx8bTiqjSAYcs0Temm/WL53P1LHWuA4eLKGFbV+Qk1
         1qrxTy7o+EtDsEsODFrwMHZxG0IjeeuJbgcEDC5bOaDH6xodcH8PTf48Dq2yatHHWQq9
         PoSC56BKMPb78adL9cBmBugUTQ25LA0iGyABa7/mKxmdAXv+SLpv4MbI/DDCOs7+5uf/
         qdXUyju1IHB81wWVniRANDFaD0tmT/aR/gAAnTwkyaUxUwhTHdcwSsM24zWQG3rgK53c
         BbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BRWQ1hkRGo/t2t1Y4zQ7FNnMWXMwqdSp5KgGUNdwvk=;
        b=CjFiBc16WI3jYqAYKDwpLvBQRek1e4lqRZ+xIDdMO7kzObz72UxZyvVJtiu4BVNN27
         zxjU7dxlAAymUqKcCAmvkwCWpuLHozsmWnLS08V2NZFgxDGdNK5BV6VC5fITZHJpbMe/
         YdiR2pa3DW5GaumBJWvOFseK6SoWh6t4QQK9WMfKYiGS8way48/WUJ9U01W+yy677oMA
         r7bLMx6BypfInG3iHjc1EyyGENGbei5MTxFwjldkkHLN+16jYz3rULWBmxBHgO6PCpo7
         vv2b1SiBspgFh9Hk6Ux2r7fB7hd11KekkBjVyaPLdVBzDxBB6JdA296BHavCgDVrr9mO
         DnSw==
X-Gm-Message-State: ACrzQf1kueDQbgk/FSJeeGQ+DoDncTz+NSDV2gpw7ck40aEyHAIjt29W
        gMizBjbFkilt1HvBPyQ28kg=
X-Google-Smtp-Source: AMsMyM5aZHSjDphxm5GQ2gZer9/dlT4/yFsR9S4JV1I22kVYpxIzNoFjBOmjtEwi4Me1WubE/s9JCw==
X-Received: by 2002:a63:5a50:0:b0:429:8580:fc61 with SMTP id k16-20020a635a50000000b004298580fc61mr647238pgm.215.1666058552099;
        Mon, 17 Oct 2022 19:02:32 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:31 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 01/20] perf tools: Save evsel->pmu in parse_events()
Date:   Mon, 17 Oct 2022 19:02:08 -0700
Message-Id: <20221018020227.85905-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018020227.85905-1-namhyung@kernel.org>
References: <20221018020227.85905-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now evsel has a pmu pointer, let's save the info and use it like in
evsel__find_pmu().  The missing feature check needs to be changed as
the pmu pointer can be set from the beginning.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c        | 20 ++++++++++----------
 tools/perf/util/parse-events.c |  1 +
 tools/perf/util/pmu.c          |  4 ++++
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 76605fde3507..b7140beca970 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -467,6 +467,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->collect_stat = orig->collect_stat;
 	evsel->weak_group = orig->weak_group;
 	evsel->use_config_name = orig->use_config_name;
+	evsel->pmu = orig->pmu;
 
 	if (evsel__copy_config_terms(evsel, orig) < 0)
 		goto out_err;
@@ -1966,17 +1967,16 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 		perf_missing_features.mmap2 = true;
 		pr_debug2_peo("switching off mmap2\n");
 		return true;
-	} else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
-		   (evsel->pmu == NULL || evsel->pmu->missing_features.exclude_guest)) {
-		if (evsel->pmu == NULL) {
+	} else if (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) {
+		if (evsel->pmu == NULL)
 			evsel->pmu = evsel__find_pmu(evsel);
-			if (evsel->pmu)
-				evsel->pmu->missing_features.exclude_guest = true;
-			else {
-				/* we cannot find PMU, disable attrs now */
-				evsel->core.attr.exclude_host = false;
-				evsel->core.attr.exclude_guest = false;
-			}
+
+		if (evsel->pmu)
+			evsel->pmu->missing_features.exclude_guest = true;
+		else {
+			/* we cannot find PMU, disable attrs now */
+			evsel->core.attr.exclude_host = false;
+			evsel->core.attr.exclude_guest = false;
 		}
 
 		if (evsel->exclude_GH) {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5973f46c2375..6502cd679f57 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -266,6 +266,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
+	evsel->pmu = pmu;
 
 	if (name)
 		evsel->name = strdup(name);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 03284059175f..6a86e6af0903 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1065,11 +1065,15 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = NULL;
 
+	if (evsel->pmu)
+		return evsel->pmu;
+
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		if (pmu->type == evsel->core.attr.type)
 			break;
 	}
 
+	evsel->pmu = pmu;
 	return pmu;
 }
 
-- 
2.38.0.413.g74048e4d9e-goog

