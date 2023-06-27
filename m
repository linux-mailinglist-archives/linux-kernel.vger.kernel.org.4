Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FEB7402EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjF0SL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjF0SK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F11FE0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-570553a18deso67315697b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889458; x=1690481458;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhrU9btQvSNouRLprL5042Ez2uv0eRQsGm9r0lF36Cc=;
        b=zKLf44jyj+39w0a+bqNc2dgv2dREdGSzeZe+HP7YGWzKAptuBUBeZ3HLubfQN8ktPU
         J/hVxrzpmJEmMjxDDA9hWXUMzGcGE88LvOStfYcQ73rvV3KcYSj4TpSDt+CfNC3o/MDo
         K2iNVrUgK79UQZCfMhBpEczFI7xMJ2cAOvmILBvuaZruCBVWk5uTuRzPtbVK5ofATVTi
         q0Sr4j/plwsl+/pQMnChcyl8ujz1LD6ZCyUY6kBfmtDsM3zvtQaL7hGNpdcCriEo8EY5
         Gd0m4In8QsXo2VAV5mtg9f1sdi/vJeRaLPGQ2ndAFHfF5X0FFUit8aymAZ29aNcjUIjA
         asDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889458; x=1690481458;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhrU9btQvSNouRLprL5042Ez2uv0eRQsGm9r0lF36Cc=;
        b=VDTSzMoMlE5bsOI8/8CX4g/vGr1WcCESiRJRTvoA36NZFjiogWMX4w807o4woM0nxG
         9zXqbRIGmPA//4kbJSLKibuv9d/Jrqp/xiPQNTMupzVa6Sju62PNNkDCcslVDFyLFN1d
         gUYnjj/znmLDKVF5F70CGfZkSpBDnHKqwLctOcDGXB21eIDi++yv8axle+G3QoBxRCLp
         6jsGiioZKxT3x3nF0CAJ4dP3Y81jrG4CwBXCXS4yRoPu+mJftc57qUf1LxZG4wE+IFSf
         nX7xfbZ1airCQ62mVI17HmFACfFllxUB2ex+DKg81kf5DxeJXlwzC0190pj+51XwmIQz
         K0qg==
X-Gm-Message-State: AC+VfDxs2WuPYZBl7p0Dx4tlsmTn64YHeKwHomMpb+rNYmE3PUfdcFfG
        DjiatNQHGATECEhKYfP2ZCTCh0COIv9q
X-Google-Smtp-Source: ACHHUZ4uaQfEAiZp9PqQDuN7pzOeygiYoEJNc87GGRVD0DwY9bbSmv0eS8WjGE+vlBe01swDXklrQzCsdz5u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a81:b710:0:b0:565:9f59:664f with SMTP id
 v16-20020a81b710000000b005659f59664fmr14322906ywh.6.1687889457830; Tue, 27
 Jun 2023 11:10:57 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:24 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-8-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 07/13] perf parse-events: Separate YYABORT and YYNOMEM cases
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

Split cases in event_pmu for greater accuracy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 45 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 3ee351768433..d22866b97b76 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -283,37 +283,42 @@ event_pmu:
 PE_NAME opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
 	struct list_head *list = NULL, *orig_terms = NULL, *terms= NULL;
+	struct parse_events_error *error = parse_state->error;
 	char *pattern = NULL;
 
-#define CLEANUP_YYABORT					\
+#define CLEANUP						\
 	do {						\
 		parse_events_terms__delete($2);		\
 		parse_events_terms__delete(orig_terms);	\
 		free(list);				\
 		free($1);				\
 		free(pattern);				\
-		YYABORT;				\
 	} while(0)
 
-	if (parse_events_copy_term_list($2, &orig_terms))
-		CLEANUP_YYABORT;
-
 	if (error)
 		error->idx = @1.first_column;
 
+	if (parse_events_copy_term_list($2, &orig_terms)) {
+		CLEANUP;
+		YYNOMEM;
+	}
+
 	list = alloc_list();
-	if (!list)
-		CLEANUP_YYABORT;
+	if (!list) {
+		CLEANUP;
+		YYNOMEM;
+	}
 	/* Attempt to add to list assuming $1 is a PMU name. */
 	if (parse_events_add_pmu(parse_state, list, $1, $2, /*auto_merge_stats=*/false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 
 		/* Failure to add, try wildcard expansion of $1 as a PMU name. */
-		if (asprintf(&pattern, "%s*", $1) < 0)
-			CLEANUP_YYABORT;
+		if (asprintf(&pattern, "%s*", $1) < 0) {
+			CLEANUP;
+			YYNOMEM;
+		}
 
 		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 			char *name = pmu->name;
@@ -328,8 +333,10 @@ PE_NAME opt_pmu_config
 			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
 				bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 
-				if (parse_events_copy_term_list(orig_terms, &terms))
-					CLEANUP_YYABORT;
+				if (parse_events_copy_term_list(orig_terms, &terms)) {
+					CLEANUP;
+					YYNOMEM;
+				}
 				if (!parse_events_add_pmu(parse_state, list, pmu->name, terms,
 							  auto_merge_stats)) {
 					ok++;
@@ -345,15 +352,15 @@ PE_NAME opt_pmu_config
 			ok = !parse_events_multi_pmu_add(parse_state, $1, $2, &list);
 			$2 = NULL;
 		}
-		if (!ok)
-			CLEANUP_YYABORT;
+		if (!ok) {
+			CLEANUP;
+			YYABORT;
+		}
 	}
-	parse_events_terms__delete($2);
-	parse_events_terms__delete(orig_terms);
-	free(pattern);
-	free($1);
 	$$ = list;
-#undef CLEANUP_YYABORT
+	list = NULL;
+	CLEANUP;
+#undef CLEANUP
 }
 |
 PE_NAME sep_dc
-- 
2.41.0.162.gfafddb0af9-goog

