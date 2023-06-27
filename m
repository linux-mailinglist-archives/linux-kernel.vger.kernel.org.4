Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7A7402EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjF0SLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjF0SK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8332733
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c118efd0c3cso3972057276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889455; x=1690481455;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfYhuJ0XDyvK4n4WNbDnoJ3i1epMtBqut75yAMaV+gY=;
        b=fJ/k7mucYzBMSvs1vvV15ie93EM0pdSvxSUdAibrdcK8Xlo3QJke/WMQV3YHip6PPd
         L8Cd8nJEThKRdGQ2VTW41re3ZnkIycotbObtvgaoqLFhCNpiEFkiQeN6l4fYZ7prWdt8
         uV5Shhvouyj7E1gCloG+G40JhxYFGkEvI2ecrkyEtmkLXzoh1msQmywG5djMLzyl75C7
         /Ru0IM92CtF1HiniTaMAMp+6bztbSXOudj3AHphKfyuYYcYl2qIEmt4G88gKrzzlHNTS
         6DbTTYUpAslWcs3bdKbSUEId2GOodNlFw954jDc501bIdNf44FhQG39rCNeLO/V14Gd3
         NeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889455; x=1690481455;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfYhuJ0XDyvK4n4WNbDnoJ3i1epMtBqut75yAMaV+gY=;
        b=VMpt2c36G6AwwDmJUugQ+hTkoKI0ECo40V8pelgYEHEJzbDgnHd7cSQpwix7i474Ev
         DvTFSr9AwTYWdRAyUimWiAmdIORtU2LhgfHaOQiXDHNcBBoKApps1FSuo+3Vci0AHhXS
         e3ctVOcHcp2PHXpng3rqppJ3RrHrq06FPSYzg/gkQa6E1Bynvfuc0MD/twh0t8cBxCNJ
         HqYAdDE+kvamjygOgwwUl3C9fmYm4WAuCGVQoCeQPcksmydYQqs9gDQdIhbHtZclbgCA
         r8S/mxHQjpdMZbyp4BLg2LzxWv5xOxyHcL7jrQ90yXlLPeu9W0XTnvq65qIcuOO2fBHb
         /K+Q==
X-Gm-Message-State: AC+VfDw2sGlASEzq7vWPXLV8X3XMcFVxDpeHRPJW6oa7kBD0mmxo0qYs
        YZHBxS/3TtUAj00Pu1olOIzKJr9Hc3GK
X-Google-Smtp-Source: ACHHUZ7hCPGedLA3hDk85YPuzkka3hqhshJtOMTfnuxOsm7D9+OdRd8J3ECgi1iIpw1Da0GndXH8fW2VN2e5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a25:d658:0:b0:bbb:8c13:ce26 with SMTP id
 n85-20020a25d658000000b00bbb8c13ce26mr15119569ybg.11.1687889455645; Tue, 27
 Jun 2023 11:10:55 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:23 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-7-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 06/13] perf parse-event: Add memory allocation test for
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

