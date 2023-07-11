Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8B74E6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGKF7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGKF73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:59:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354EE49
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:59:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-570553a18deso63547077b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689055165; x=1691647165;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHH47SfpScUGFxKQhJm1mmTUrzJDod/Xuvw5vyIRsxc=;
        b=LpOBs94ljdTymoJcs1ClmQDribais2EEw9Mpx8cWUs53b5omHGBZyOnhd+PmexP81P
         MTR8rdrVo3R0tXs7mey0rTyT5+ey3M6Ve0BrJNJGP0a6GbKPeMkLUPhcLR42qoWzjA8s
         jZK76di5xMnvrFuEwlKsChLtWCJiIBlyHh6lo789oztEywH7fjfTI17qyulKXqoyJ+Hp
         O99ZDXhJP0p/1rRSm7rWeRT5b6c6Zs3iPzmoa9hln2yemsXeIdmdwTpWtFQ8J/iIk5Jz
         TqfsxWZeoyD7x3owN+Hc2o+VTQu1Y7JqJSPu7gbcTkWrpDCfcHsegVBd60ufNp2nI4SC
         0cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689055165; x=1691647165;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHH47SfpScUGFxKQhJm1mmTUrzJDod/Xuvw5vyIRsxc=;
        b=YD8utBe9Z7ljtcuxh/HMG4t10PP5nXkAXo3RsV84AX9dVmotX/IXXtLIbKqRp4FV4g
         9p/0fayN43fVGJWJrvTIDhx7KjgeJc42zANSDLQPUbjCffkwvJrDT5Yw1rYPPg9T5Ex8
         6MspXhMT7JMVreL2LuvN3NoZee2+XIsCw2qUW3FrimZxFYclQw7dNmZh5flt0Okf1SeV
         TYmZoqmVLuf+h9b29WgwH/ayKzkzLDEY8NHKBAEFd7PRaprbbeTL3icBDFLZhYA2ZN0z
         HHeLzo0PiPOnsY+MWFlpzRlKoKeQaThv3mf4rG1bJ/dMJ6pUDpZ/fRP6ZD1osfQAqRaR
         JYag==
X-Gm-Message-State: ABy/qLavKYTje1Hkoksl0bMA0NJJxk6+hfjum4ssppGRkeuMesgMfrBW
        Ecn0vZn2aJsIIlTMPJ4eTrutJ53L/Dpg
X-Google-Smtp-Source: APBJJlEWwPStaCrLA06Y628txzlo5JavMlFYwkiXOj/gztJc11CCwAbnT9FqlwSBkfNm4U927gRchxVv6xIS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2efd:fc0f:9eaa:3bd5])
 (user=irogers job=sendgmr) by 2002:a81:e30d:0:b0:576:a5a8:f686 with SMTP id
 q13-20020a81e30d000000b00576a5a8f686mr112446ywl.9.1689055164831; Mon, 10 Jul
 2023 22:59:24 -0700 (PDT)
Date:   Mon, 10 Jul 2023 22:58:59 -0700
In-Reply-To: <20230711055859.1242497-1-irogers@google.com>
Message-Id: <20230711055859.1242497-4-irogers@google.com>
Mime-Version: 1.0
References: <20230711055859.1242497-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Subject: [PATCH v1 3/3] perf pmus: Don't print PMU suffix in list
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

Duplicate PMUs are no longer printed but the suffix of the first is
printed. Avoid printing the suffix as multiple PMUs are matched.

Before:
```
$ perf list
...
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
```

After:
```
$ perf list
...
  uncore_imc_free_running/data_read/                 [Kernel PMU event]
  uncore_imc_free_running/data_total/                [Kernel PMU event]
  uncore_imc_free_running/data_write/                [Kernel PMU event]
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 87e5fb74e121..c25b9cb70050 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -443,7 +443,8 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 			  const struct perf_pmu_alias *alias)
 {
 	struct parse_events_term *term;
-	int used = snprintf(buf, len, "%s/%s", pmu->name, alias->name);
+	int pmu_name_len = pmu_name_len_no_suffix(pmu->name, /*num=*/NULL);
+	int used = snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->name, alias->name);
 
 	list_for_each_entry(term, &alias->terms, list) {
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
@@ -512,6 +513,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 			*desc = NULL, *long_desc = NULL,
 			*encoding_desc = NULL, *topic = NULL,
 			*pmu_name = NULL;
+		int pmu_name_len;
 		bool deprecated = false;
 		size_t buf_used;
 
@@ -522,7 +524,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		if (!aliases[j].event) {
 			/* A selectable event. */
 			pmu_name = aliases[j].pmu->name;
-			buf_used = snprintf(buf, sizeof(buf), "%s//", pmu_name) + 1;
+			pmu_name_len = pmu_name_len_no_suffix(pmu_name, /*num=*/NULL);
+			buf_used = snprintf(buf, sizeof(buf), "%.*s//", pmu_name_len, pmu_name) + 1;
 			name = buf;
 		} else {
 			if (aliases[j].event->desc) {
@@ -548,8 +551,10 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 			long_desc = aliases[j].event->long_desc;
 			topic = aliases[j].event->topic;
 			encoding_desc = buf + buf_used;
+			pmu_name_len = pmu_name_len_no_suffix(pmu_name, /*num=*/NULL);
 			buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-					"%s/%s/", pmu_name, aliases[j].event->str) + 1;
+					"%.*s/%s/", pmu_name_len, pmu_name,
+					aliases[j].event->str) + 1;
 			deprecated = aliases[j].event->deprecated;
 		}
 		print_cb->print_event(print_state,
-- 
2.41.0.390.g38632f3daf-goog

