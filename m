Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1637473F375
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjF0Efj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjF0EfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:35:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4EB1720
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-564fb1018bcso58077447b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840523; x=1690432523;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWCGE0gvk+pE+CmFQOT3NcABG9fSPb9UJ3AYuKosiSs=;
        b=2Jn/3eS5PxyyQnamzxRI6RjMyYVpdcyI00HwvxuiINbYigj65DQNk54DcCPLXQ1CkL
         aV5hbe0G9kzAJK7q/rrehTSfNKBA9solwsuMX0Yc8FbWiUsTMYFtYSedqBBbkIZCvfEk
         /qb3ehecptdg8oawr/mUOjF20uwONq3gmzUUUKhoOVlWpw8qa0sHY1gBylF9cAG+zUrF
         PPszeHwdWspAQfcuki0tedenET8k/rV4nu42V/Nd26FThAHozlDydfIZ0UEEu035u/Eg
         +DMxVeSRShN3AUXP88ruhaabmjc7GSiyeEtIzE1sMAO4CO0ClLIy254CrCo5bdoim9yc
         gaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840523; x=1690432523;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWCGE0gvk+pE+CmFQOT3NcABG9fSPb9UJ3AYuKosiSs=;
        b=N0IYFSYWSfQZmKscNZA9Glv5cBF3skXrnh+IQQkTIYQMjPuQ19FYMhCkwGj1PE1NX3
         U4dX1daDR+mPcwwdcyhA+x1MFBGzWJsITu1v8RO4iBkYq2pMeHKIEMjheQw7HYaFcpdv
         0GMTeV8IU8j36L9VDHIIK3hFlgBKd3H4Vb9ZHjWJ4l4ffBXeA1ls30moW2gvQaAdRihE
         WXmuWQBNG4of+PWqKwDQSVUBC26hl2rJWTvf3GbWd8AeT+IEgRhAkx8BbNR1wgx1u4dC
         nKbrti6ckXYxRiIouvL+rRbymMHql4kXo6LLXJMmnPtYi4/NqpXSMXYQy0/w8pZIWjy/
         rCFQ==
X-Gm-Message-State: AC+VfDyHfy9IQqHZg1QFPBrTcaUkKkJomQFZ5lIDvny2UidKkBJcHFdO
        VmqCfA6geSe5zYdc2h183FxQ1dejr9ZA
X-Google-Smtp-Source: ACHHUZ5L4BiUBOJjf+avwMOmOIAytu8fXGtgMaH/uVfAhmb9Gx/TXTrJF2s+gprOCKEnxgaJ5h3D6CV9M6vT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:ae22:0:b0:bc0:bfa7:7647 with SMTP id
 a34-20020a25ae22000000b00bc0bfa77647mr13096016ybj.0.1687840522861; Mon, 26
 Jun 2023 21:35:22 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:47 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-3-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 02/13] perf parse-events: Remove unused PE_KERNEL_PMU_EVENT token
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

Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
PMUs before parsing").

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 64755f9cd600..4ee6c6865655 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -63,7 +63,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %token PE_LEGACY_CACHE
 %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
 %token PE_ERROR
-%token PE_KERNEL_PMU_EVENT
 %token PE_ARRAY_ALL PE_ARRAY_RANGE
 %token PE_DRV_CFG_TERM
 %token PE_TERM_HW
@@ -81,7 +80,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
-%type <str> PE_KERNEL_PMU_EVENT
 %type <str> PE_DRV_CFG_TERM
 %type <str> name_or_raw name_or_legacy
 %destructor { free ($$); } <str>
@@ -358,18 +356,6 @@ PE_NAME opt_pmu_config
 #undef CLEANUP_YYABORT
 }
 |
-PE_KERNEL_PMU_EVENT sep_dc
-{
-	struct list_head *list;
-	int err;
-
-	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
-	free($1);
-	if (err < 0)
-		YYABORT;
-	$$ = list;
-}
-|
 PE_NAME sep_dc
 {
 	struct list_head *list;
@@ -381,19 +367,6 @@ PE_NAME sep_dc
 		YYABORT;
 	$$ = list;
 }
-|
-PE_KERNEL_PMU_EVENT opt_pmu_config
-{
-	struct list_head *list;
-	int err;
-
-	/* frees $2 */
-	err = parse_events_multi_pmu_add(_parse_state, $1, $2, &list);
-	free($1);
-	if (err < 0)
-		YYABORT;
-	$$ = list;
-}
 
 value_sym:
 PE_VALUE_SYM_HW
-- 
2.41.0.162.gfafddb0af9-goog

