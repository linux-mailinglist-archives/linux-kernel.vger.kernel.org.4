Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7069BF70
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBSJaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBSJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:30:04 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D182612583
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:29:43 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5369a87b661so2648387b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpSaNFvC8VmLiMMzNqVi6YMEMj22ak1daXzeVt5eMAk=;
        b=HcBv1rkbvDldKyrDrO0aggLoq3rOU9HtvU+pzmjwa8Ux0B1KVOh4j8kILHgYFzodGs
         q7FHA8VF7wHWGnSmn6YVglkgBiheCph85mVXO2727cgB4U/R416NU+pIV9PVC1yP1IKT
         nsJ+wXh647jNXsjYXnz/rmI6T3y4ixe98L+h/LwtJ6uZDKOkqF145rV3liTbQfcNuvXw
         +wvjCDO3XWGrwUhOU6wNzR+0DSatllL4NCLdst2qS9VItUg1x4bigbuFwqNwRCqqlJaH
         SA2vUGQpGnDR+Dm03t5wFIxSQN7+d3nR0wTN/jsAXGHCxURshr7AqnpGX5wjEOu5SCEw
         Pa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpSaNFvC8VmLiMMzNqVi6YMEMj22ak1daXzeVt5eMAk=;
        b=awqkL4Ev57is+Js7I0RlYrMMP40YnZU8jjjZkbULq4V1Q8IxQxGUCbHVeIzHkd/Sjs
         T41h2e1wIm2mryKL0bhwu5UoQtjry0vwF26La8vXhnWWyhbOcFdzLCuOC3r9kWdyaSzG
         EdK+rGzAhdblsljgdptRws8MK1SiUXEugXIoLcU7cdiEnm94WZfmmILMnOl95/in/5KR
         aPC9S7He4bs4WNTSJT7+h4OhcnDIm7+IldTNaqZeOTU26inemxW2jx7KCNPnOyJYWQtG
         NyeJPkSPgWqyPqRBCbBqLUezaxQbkpdgHViN8peXFBsgnZGGswC86zjynRkGktIa2TEl
         AimQ==
X-Gm-Message-State: AO0yUKWH75TzBAJ+/Cxny8tS9Wl0c96cSN4gAa/jxOPGJTGzRV5UHoaW
        i72mX1TyWfs4KkEZPXMTxf/3qBRSxM+f
X-Google-Smtp-Source: AK7set+/IPJPR2TJCsCRPOBld36mgcNb8QWHQJkTJaS1X/3VSb0/0V2mUrZzloFp8neALyJ35/txBaNTQ9s3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c6:b0:97a:ebd:a594 with SMTP id
 w6-20020a05690210c600b0097a0ebda594mr389689ybu.3.1676798982991; Sun, 19 Feb
 2023 01:29:42 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:02 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-6-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 05/51] perf pmu-events: Change deprecated to be a bool
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

Switch to a more natural bool rather than string encoding, where NULL
implicitly meant false.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py   |  2 +-
 tools/perf/pmu-events/pmu-events.h |  4 +++-
 tools/perf/tests/pmu-events.c      |  4 ++--
 tools/perf/util/pmu.c              | 10 ++++------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2b08d7c18f4b..35ca34eca74a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -678,7 +678,7 @@ static void decompress_event(int offset, struct pmu_event *pe)
 {
 \tconst char *p = &big_c_string[offset];
 """)
-  enum_attributes = ['aggr_mode']
+  enum_attributes = ['aggr_mode', 'deprecated']
   for attr in _json_event_attributes:
     _args.output_file.write(f'\n\tpe->{attr} = ')
     if attr in enum_attributes:
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 7225efc4e4df..2434bc7cf92d 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -2,6 +2,8 @@
 #ifndef PMU_EVENTS_H
 #define PMU_EVENTS_H
 
+#include <stdbool.h>
+
 struct perf_pmu;
 
 enum aggr_mode_class {
@@ -22,7 +24,7 @@ struct pmu_event {
 	const char *pmu;
 	const char *unit;
 	const char *perpkg;
-	const char *deprecated;
+	bool deprecated;
 };
 
 struct pmu_metric {
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 9b4c94ba5460..937804c84e29 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -331,8 +331,8 @@ static int compare_pmu_events(const struct pmu_event *e1, const struct pmu_event
 		return -1;
 	}
 
-	if (!is_same(e1->deprecated, e2->deprecated)) {
-		pr_debug2("testing event e1 %s: mismatched deprecated, %s vs %s\n",
+	if (e1->deprecated != e2->deprecated) {
+		pr_debug2("testing event e1 %s: mismatched deprecated, %d vs %d\n",
 			  e1->name, e1->deprecated, e2->deprecated);
 		return -1;
 	}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c256b29defad..80644e25a568 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -331,14 +331,15 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	int num;
 	char newval[256];
 	char *long_desc = NULL, *topic = NULL, *unit = NULL, *perpkg = NULL,
-	     *deprecated = NULL, *pmu_name = NULL;
+	     *pmu_name = NULL;
+	bool deprecated = false;
 
 	if (pe) {
 		long_desc = (char *)pe->long_desc;
 		topic = (char *)pe->topic;
 		unit = (char *)pe->unit;
 		perpkg = (char *)pe->perpkg;
-		deprecated = (char *)pe->deprecated;
+		deprecated = pe->deprecated;
 		pmu_name = (char *)pe->pmu;
 	}
 
@@ -351,7 +352,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	alias->unit[0] = '\0';
 	alias->per_pkg = false;
 	alias->snapshot = false;
-	alias->deprecated = false;
+	alias->deprecated = deprecated;
 
 	ret = parse_events_terms(&alias->terms, val);
 	if (ret) {
@@ -405,9 +406,6 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	alias->str = strdup(newval);
 	alias->pmu_name = pmu_name ? strdup(pmu_name) : NULL;
 
-	if (deprecated)
-		alias->deprecated = true;
-
 	if (!perf_pmu_merge_alias(alias, list))
 		list_add_tail(&alias->list, list);
 
-- 
2.39.2.637.g21b0678d19-goog

