Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7662EC0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiKRCql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbiKRCqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:46:37 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA4B8DA78
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:46:33 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36fc0644f51so38006677b3.17
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7K5GydWND88eiPprqviP7o7yiy4SWslcLb+tIIL4oQ=;
        b=Z3h2C6yyu0jeLWS9Fe5hzaPxwCOCOZ60urpXed8CIS9czECweKhJYSEVJteGNP12lu
         7EsIFt3RwMNcdx5MZdbQBNvypTSfCGJXhcvJ3jOhoZVJFOryNYaxI9F6OE2EK0FoNYKm
         RkpGTT8XodH/sKdH9V5H1skq0tUACuTCJEDJsr6RnwoAh2C0zRhFK9pRkFPRNhXNwZPb
         GCRHQAL5wsimk2s6i7kdES68wxMl8D5XztO4J2G7uqN7SKa6YgBenQ1Kasa6uFbAIRfw
         qoU0WsLGT5wkEy0NWjmEosHeQVvSTztIuJh3KYIqO85Be34IqtNyBReiB05d6NBFWXw1
         Azfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7K5GydWND88eiPprqviP7o7yiy4SWslcLb+tIIL4oQ=;
        b=xvDtZ+7nEHUJdOyJdtTszC7so5Aph5htBDzwARK0paie1szvJXpSBRc9Y5nLArPXba
         rf56kSgGU6KZwwsGTWgT8xGt6QhCNjp0NPBAnRANbhISl0GsWKZQqZw7UdGWNTxH+JsY
         a4HKpwv9UrN1Fjx3uSHeb8FXZsSyYAKJeMZTDUBfsQ6qCggnwrQ9ljrsbdXcsAxfrDkP
         AQXkBUg2MFVTox/ukO/ggBKCFeYp2CNGE/S2mxhR4P1FQFUbRsBIzi0pSqrRkfWMw9s8
         6wlO8bLxf+s486HrXA7b4vGcpm9BQfgbCkDhz4cr4FUywaGtT8gdal5Xpoo1U84ezG+6
         bvkw==
X-Gm-Message-State: ANoB5pkU4nYYgEra2J/oOeIulkW7aRWpP1K04OxRZMBnlv0ohMVwnQcf
        um2k3/W/AIhEH5ZgpbXOWskhnT135Nzv
X-Google-Smtp-Source: AA0mqf71b56eGXBGzvb6HYNNjsItjJ1b/uiojF/ERc1Vx8nzmc4Lto/0FIvKh+ueGFoCvUFZKEFe4J2AaLBo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3f1e:c462:d6b8:fba8])
 (user=irogers job=sendgmr) by 2002:a81:6c08:0:b0:369:94dc:7321 with SMTP id
 h8-20020a816c08000000b0036994dc7321mr4892474ywc.156.1668739593116; Thu, 17
 Nov 2022 18:46:33 -0800 (PST)
Date:   Thu, 17 Nov 2022 18:46:05 -0800
In-Reply-To: <20221118024607.409083-1-irogers@google.com>
Message-Id: <20221118024607.409083-2-irogers@google.com>
Mime-Version: 1.0
References: <20221118024607.409083-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 1/3] perf list: Support newlines in wordwrap
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

Rather than a newline starting from column 0, record a newline was
seen and then add the newline and space before the next word.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 84fa2d050eac..f3750331e8f6 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -74,17 +74,19 @@ static void wordwrap(const char *s, int start, int max, int corr)
 {
 	int column = start;
 	int n;
+	bool saw_newline = false;
 
 	while (*s) {
-		int wlen = strcspn(s, " \t");
+		int wlen = strcspn(s, " \t\n");
 
-		if (column + wlen >= max && column > start) {
+		if ((column + wlen >= max && column > start) || saw_newline) {
 			printf("\n%*s", start, "");
 			column = start + corr;
 		}
 		n = printf("%s%.*s", column > start ? " " : "", wlen, s);
 		if (n <= 0)
 			break;
+		saw_newline = s[wlen] == '\n';
 		s += wlen;
 		column += n;
 		s = skip_spaces(s);
@@ -146,7 +148,7 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 		wordwrap(desc, 8, pager_get_columns(), 0);
 		printf("]\n");
 	}
-
+	long_desc = long_desc ?: desc;
 	if (long_desc && print_state->long_desc) {
 		printf("%*s", 8, "[");
 		wordwrap(long_desc, 8, pager_get_columns(), 0);
@@ -154,7 +156,8 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 	}
 
 	if (print_state->detailed && encoding_desc) {
-		printf("%*s%s", 8, "", encoding_desc);
+		printf("%*s", 8, "");
+		wordwrap(encoding_desc, 8, pager_get_columns(), 0);
 		if (metric_name)
 			printf(" MetricName: %s", metric_name);
 		if (metric_expr)
-- 
2.38.1.584.g0f3c55d4c2-goog

