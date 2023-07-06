Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3DF74A3D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjGFShO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjGFShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:37:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141031B6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:37:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5618857518dso11086547b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688668630; x=1691260630;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUs+YsIcHTrdEoY9pdDqoB0Eju/96GmQD5n4ikf5+Bs=;
        b=EZL2TqHu86+WyFUQAgF9/WWdmE7XUF8cYRSnAVU4tOGSEzRGltWbjf15Xg427IvkE2
         jAC9mqxGSChxSr5dQCdlD/93JvSt8C4sbwM1fQdoHWVmz6VzfQDEYTU5aSwo65LZ/xlY
         exnagXm+4y+Q1o1MWArpLpB+aMAHnoh68SZgkuK2FK9DF0v0RlOdOzE/V/DfIsJjlLks
         T9dmHf2MisuHtjHTW0/vjOh9vcT6qS0ZcMnYBg2B5LGAlmhWZbDOLker3cQJF37o+f/W
         Knuzx8StcX+QmOrbkJ+t1J9eF9v9WT0i6SGcZ+xbf/Duja1j90m1hoVlXuxVXknCM7YN
         uCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688668630; x=1691260630;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUs+YsIcHTrdEoY9pdDqoB0Eju/96GmQD5n4ikf5+Bs=;
        b=EEWIx/UKlS7tkLfW73r7GJgHNn18h+0n9No8UXqGOsvRTxXUeFMac/68oNRxKUbh2G
         3JpQW3GZ8WN/HqSCgxTSki4BYYe4/hfxTrEo1mzptEcuZD1pL1Rn1JVNWd/fw9Geg6Ro
         UCoqx+1+VC3BFiEE7WA/RZ1V1KTuj7E9psFmYv+gWjO+mDfjNAU0z0BwYfYVnU++S9EM
         /kUso127f+s+oMZJ4lfsUlVCdn/zsfSoHfg7P/JpQ4cGbH9+OlNA7Y8kqceBI9oPDC03
         rWRxt+6l8NRbLR9x/yJwxXXsGJyybLMQl0dG5ZAe6En2wyctCnVpQQDoUnhg2stDXG+v
         38xQ==
X-Gm-Message-State: ABy/qLaWkqtm1owQr0yTvwk4avE7ME9PylxUTeyDkZZi5iaLudK/bCTl
        MfCipizoh2T1EN2hXzFq7ADq9MqmCIBO
X-Google-Smtp-Source: APBJJlHv+Kvjg3nzOYF1oXAM8IzdP+YirUtiQnKVI2XCbAunSdtcNkZp0NgbfZhzzXqR9C8AY9XfY57yimg7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a5e8:77df:2300:8f74])
 (user=irogers job=sendgmr) by 2002:a25:6009:0:b0:c4d:1bc3:62c3 with SMTP id
 u9-20020a256009000000b00c4d1bc362c3mr15128ybb.4.1688668630212; Thu, 06 Jul
 2023 11:37:10 -0700 (PDT)
Date:   Thu,  6 Jul 2023 11:37:04 -0700
Message-Id: <20230706183705.601412-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Subject: [PATCH v1 1/2] perf pmus: Create placholder regardless of scanning core_only
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
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

If scanning all PMUs the placeholder is still necessary if no core PMU
is found. This situation occurs in perf test's parse-events test,
when uncore events appear before core.

Fixes: 628eaa4e877a ("perf pmus: Add placeholder core PMU")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3cd9de42139e..c58ba9fb6a36 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -152,16 +152,14 @@ static void pmu_read_sysfs(bool core_only)
 	}
 
 	closedir(dir);
-	if (core_only) {
-		if (!list_empty(&core_pmus))
-			read_sysfs_core_pmus = true;
-		else {
-			if (perf_pmu__create_placeholder_core_pmu(&core_pmus))
-				read_sysfs_core_pmus = true;
-		}
-	} else {
+	if (list_empty(&core_pmus)) {
+		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
+			pr_err("Failure to set up any core PMUs\n");
+	}
+	if (!list_empty(&core_pmus)) {
 		read_sysfs_core_pmus = true;
-		read_sysfs_all_pmus = true;
+		if (!core_only)
+			read_sysfs_all_pmus = true;
 	}
 }
 
-- 
2.41.0.390.g38632f3daf-goog

