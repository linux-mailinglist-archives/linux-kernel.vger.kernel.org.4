Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C044574E6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGKF7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGKF70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:59:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04101AC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:59:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57704aace46so57157127b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689055162; x=1691647162;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aeSO6Ab0Eyw2ukZaayVI7Jjvjc4sNwkQ48k5lNueGS0=;
        b=gjXOdgljao5xPM58mg4voHt4zoSAKDxixNMnOBYiCtKDpPGbNg4IIwH76dxS0S2r7D
         44z51bcKPkY5eFU3d87bjW2/w5Kn/9Uy5mALMzCewror48jlSfTu2lgtXEU3KncIey7x
         FFm6VaizZ7DsoOvhmUY6Slv2uH53++P5Kkg/ddNLwDD58JvQ6b+TXKRlcjbDAdZWWvMc
         yvh3fpIbD28HH5qwyJjdQ/FsFIiu90RCGYy9Q5vxhqkquGTRyM4MXsQY8JOBNg/ReKIW
         JpfQPubeGBQPPv8kUskm2kncwX60Kidh0bIDO4q3+ep6u0N05EIpq6d70PoRe8QdvGG0
         R/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689055162; x=1691647162;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeSO6Ab0Eyw2ukZaayVI7Jjvjc4sNwkQ48k5lNueGS0=;
        b=Q2tBxk3BPldRyfv/x/9N6ey8eDMMFeND7KQW7ttvqtxuhbI/Z1gX8hKq/jnKjvm9V6
         bWsBnMVHyksOpYB47IdDu+mbm7iUT9sH2pZfTC8PXUyei9I6MKsqMQ5o3t31fdO5uHQm
         YK4JXTcwHx1ID87k0C2D+Vr3wFUevaS2US0A712zk1QtP+cM3JSZzXv+IaoqMjwbMB0b
         wFO7JQVNnkpCBFf9k/D5dVrPlsy9ZmbfrT6D5xulwBHlyj+xx8IPAqFGzEF+YUpbfstr
         n8mb1ODVHHwyMqrheQdHgArugeIRmhFxqcNy4SYizg2Ajr0YY5kuQvhCYHprVlfc6naR
         9atg==
X-Gm-Message-State: ABy/qLbYCKLYxG05b74LVSJtcnmV5HZJFhVISh/WQQbR3/3dwhRYMn7a
        ZcXpSCReRD0oj+EvZ07wKtlbwQgHUs+/
X-Google-Smtp-Source: APBJJlGQJZh+yd9CTr3OHMJ/77Fhyx9lb5YbPdo/rb/ivgX6ul3fPMNM2KB6+aemsZegJ3B80xOOqwmEx+le
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2efd:fc0f:9eaa:3bd5])
 (user=irogers job=sendgmr) by 2002:a81:ac47:0:b0:576:92da:cd3d with SMTP id
 z7-20020a81ac47000000b0057692dacd3dmr107380ywj.8.1689055162240; Mon, 10 Jul
 2023 22:59:22 -0700 (PDT)
Date:   Mon, 10 Jul 2023 22:58:58 -0700
In-Reply-To: <20230711055859.1242497-1-irogers@google.com>
Message-Id: <20230711055859.1242497-3-irogers@google.com>
Mime-Version: 1.0
References: <20230711055859.1242497-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Subject: [PATCH v1 2/3] perf pmus: Add scan that ignores duplicates, use for
 perf list
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are multiple PMUs that differ only by suffix, just list the
first one and skip all others. As the PMUs are sorted, the scan
routine checks that the PMU names match and the numbers are
consecutive.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3581710667b0..87e5fb74e121 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -275,6 +275,50 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
 	return NULL;
 }
 
+static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
+{
+	bool use_core_pmus = !pmu || pmu->is_core;
+	int last_pmu_name_len = 0;
+	unsigned long last_pmu_num = 0;
+	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
+
+	if (!pmu) {
+		pmu_read_sysfs(/*core_only=*/false);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	} else
+		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &last_pmu_num);
+
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list) {
+			unsigned long pmu_num = 0;
+			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
+
+			if (last_pmu_name_len == pmu_name_len &&
+			    (last_pmu_num + 1 == pmu_num) &&
+			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
+				last_pmu_num++;
+				continue;
+			}
+			return pmu;
+		}
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list) {
+		unsigned long pmu_num = 0;
+		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
+
+		if (last_pmu_name_len == pmu_name_len &&
+		    (last_pmu_num + 1 == pmu_num) &&
+		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
+			last_pmu_num++;
+			continue;
+		}
+		return pmu;
+	}
+	return NULL;
+}
+
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 {
 	struct perf_pmu *pmu = NULL;
@@ -432,7 +476,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 
 	pmu = NULL;
 	len = 0;
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_skip_duplicates(pmu)) != NULL) {
 		list_for_each_entry(event, &pmu->aliases, list)
 			len++;
 		if (pmu->selectable)
@@ -445,7 +489,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	}
 	pmu = NULL;
 	j = 0;
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_skip_duplicates(pmu)) != NULL) {
 		bool is_cpu = pmu->is_core;
 
 		list_for_each_entry(event, &pmu->aliases, list) {
-- 
2.41.0.390.g38632f3daf-goog

