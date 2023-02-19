Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EAB69BF6B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBSJ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjBSJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:29:39 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D3E10258
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:29:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53687f6de13so18387797b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+nYipBPRK9ot6wFg6zmAiDtcnqlM5sx03XMKeU13O4=;
        b=mDOqVGr0N132A/Ll3pITLGW4r43KgUDNLPKUyUvW8eIG8vXmMxFkVQb5dbaC0M2IOs
         2GoGfqJQUeUuATD9qo9D7VoT+Pze6N0XYIPKKvB4wW3libDyZhB2y4XFUwSAiPjb+fxF
         d62ecsMidsbi/mZCuKzEfF4tYuUcoP4N6Y0ppQAp/tynm+DGQKu5p21gv51vkhSBFals
         0qcg9jft/tM3YZvvPuyYuJbIeHf7ShfSEZr76R9jwVkBrc4zZSl09n8ttK31h8tYFqSp
         2UTe/9SYmbm7tRvmPVqXfdfIS1+MPbuPJIL6t6mQjY3yomupc8sIMDOl76CGNIiTqd4V
         JB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+nYipBPRK9ot6wFg6zmAiDtcnqlM5sx03XMKeU13O4=;
        b=aqts44gduNFwFQuGB2fA6qA0TA5ahSrl5lUcX5TcmYu7R809s/eXdnX9QfwsvwFKFO
         iCYkNEmE++cFHSf6hpPTgvI7vxjjsM/cYcXJ6ihHYg1S3BSRBg1zygj2//wQ9eYFj3Ml
         N0LAibQLf7+UZKp14BK3m4lW5I/qFjmAvYqFSqsA2XPgMjV4C+MiAX8BHiGac+xkGCj6
         yO7aumre2/nxRmTuQQR6esexS1jzJ0Ftx05XGr0N68NF4XfR8YY+z93I+mtr3wTDhu4W
         4bllmWlRGE5kpZAj6fyYVIkANb9TK9TAB1qA1kUkHPsH3ofZ2wWGPqLC7f5fSANYYmuH
         wlzg==
X-Gm-Message-State: AO0yUKX3gRcVwZIoMEjTLCpJgTXM2Y3koOC//h2zQ639Yem7tCF/v+MY
        7bRAkeYUwidMO5wla/ONepBoR0IXdx4M
X-Google-Smtp-Source: AK7set8yVsRmd0VayN/HE8SDd6Hfpo5Ij5C4iaDNowj64SqM6hff3g49zWFvMKU7qPrafEJ5QA2DzAuLK0c/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:144b:b0:88a:f2f:d004 with SMTP id
 a11-20020a056902144b00b0088a0f2fd004mr190523ybv.5.1676798966583; Sun, 19 Feb
 2023 01:29:26 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:00 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-4-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 03/51] perf pmu-events: Remove aggr_mode from pmu_event
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
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

aggr_mode is used on Power to set a flag for metrics. For pmu_event it
is unused.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py   | 2 +-
 tools/perf/pmu-events/pmu-events.h | 1 -
 tools/perf/tests/pmu-events.c      | 6 ------
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2bcd07ce609f..db8b92de113e 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -44,7 +44,7 @@ _json_event_attributes = [
     # Seems useful, put it early.
     'event',
     # Short things in alphabetical order.
-    'aggr_mode', 'compat', 'deprecated', 'perpkg', 'unit',
+    'compat', 'deprecated', 'perpkg', 'unit',
     # Longer things (the last won't be iterated over during decompress).
     'long_desc'
 ]
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index b7d4a66b8ad2..cee8b83792f8 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -22,7 +22,6 @@ struct pmu_event {
 	const char *pmu;
 	const char *unit;
 	const char *perpkg;
-	const char *aggr_mode;
 	const char *deprecated;
 };
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index accf44b3d968..9b4c94ba5460 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -331,12 +331,6 @@ static int compare_pmu_events(const struct pmu_event *e1, const struct pmu_event
 		return -1;
 	}
 
-	if (!is_same(e1->aggr_mode, e2->aggr_mode)) {
-		pr_debug2("testing event e1 %s: mismatched aggr_mode, %s vs %s\n",
-			  e1->name, e1->aggr_mode, e2->aggr_mode);
-		return -1;
-	}
-
 	if (!is_same(e1->deprecated, e2->deprecated)) {
 		pr_debug2("testing event e1 %s: mismatched deprecated, %s vs %s\n",
 			  e1->name, e1->deprecated, e2->deprecated);
-- 
2.39.2.637.g21b0678d19-goog

