Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA173F37B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjF0EgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjF0Efl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:35:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E420173A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57003dac4a8so106053387b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840531; x=1690432531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfYhuJ0XDyvK4n4WNbDnoJ3i1epMtBqut75yAMaV+gY=;
        b=R/IL8Qtvta8I6gMtIPvKZfXLn9VTYmA587Tv+dTHUirDNSkyXVLPZDiit2FitWHr99
         lSTKLBRUrUspIpM71s788To4ybkNzZcGq9YzFT9kE1p7MbjjgHr9LJ82k7aqtE3GoLIq
         R46s5zrBO6zVKG+m1aJEdeDABQ9+C+Be9j3PAJCNfLhzZ70P9nZBBgtZCzLSOcQ9ELEU
         cTvehHTyprk4jPGIO/4xLBH86Fo7sqz64NRvm76MTdKX9y3ASFdsxxmyae+SpEg8JnrB
         VN4wAEtCrlRcMTDG/CNpA+q5UBt3cNAMBDDt/fbhIXmuBgKyeblyG5LJw+IlY8hPzjrR
         iFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840531; x=1690432531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfYhuJ0XDyvK4n4WNbDnoJ3i1epMtBqut75yAMaV+gY=;
        b=EZoWFBXtMOLoSo0QFIcuEn6BeX0a7L4GVr6qOJ4EMJjX+Pj2QoAObx8887IXVblz91
         hhFnyamrV6NThftj6x8dM413mQ05swt74BOrSkzqhbvhJNN3kb0XsUrCy98Lvr4eSRpP
         TkNLbQYsRcnIU2cZhn1i/x8VlZ10setaA8ujMRHBbOzW9YGIVFrSzoPNT0kKUU3HugSo
         /do4vGnMNGeMVTgikpUbhowIivFmWLt3VR1vxPQUcgZmDSflTWPnfM+XxaLn148eFJXm
         dpcUzPbab/5wKKETo4Ec3uLrU2ab1cl+4TNRFC3tNaivs0DWz03VIC0en3twCNqpL9JF
         ViyA==
X-Gm-Message-State: AC+VfDxATta9gEsDXr30GO46u44G9e96YMuPzSN3rWPraS38jTVM7YBu
        ooLq9Ffv8dBdIkP+Z0AM7bxW2b72b2IQ
X-Google-Smtp-Source: ACHHUZ6Hjnmam6yC5miKWuIWrL/VYqDWBxDrW14sUhpNBhQvwwGI3NXEDUbrFE3QZqDy02Mt5nZYzLYamadv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:a988:0:b0:568:ed75:8b2f with SMTP id
 g130-20020a81a988000000b00568ed758b2fmr14576278ywh.0.1687840531455; Mon, 26
 Jun 2023 21:35:31 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:51 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-7-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 06/13] perf parse-event: Add memory allocation test for
 name terms
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the name memory allocation fails then propagate to the parser.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 5 ++++-
 tools/perf/util/parse-events.y | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0aa4308edb6c..f31f233e395f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1965,8 +1965,11 @@ int parse_events_name(struct list_head *list, const char *name)
 	struct evsel *evsel;
 
 	__evlist__for_each_entry(list, evsel) {
-		if (!evsel->name)
+		if (!evsel->name) {
 			evsel->name = strdup(name);
+			if (!evsel->name)
+				return -ENOMEM;
+		}
 	}
 
 	return 0;
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index b09a5fa92144..3ee351768433 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -263,7 +263,7 @@ PE_EVENT_NAME event_def
 	free($1);
 	if (err) {
 		free_list_evsel($2);
-		YYABORT;
+		YYNOMEM;
 	}
 	$$ = $2;
 }
-- 
2.41.0.162.gfafddb0af9-goog

