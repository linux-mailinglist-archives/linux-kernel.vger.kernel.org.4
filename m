Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE15D5E8EAE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiIXQ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiIXQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:57:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC57857E6;
        Sat, 24 Sep 2022 09:57:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l10so2737493plb.10;
        Sat, 24 Sep 2022 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=MCPAXhDCQc742dpZ+x6jNLqv2PyH1MjeNNepu11/jbY=;
        b=NwJ4cizpRMzHOznKzS3FE/SMKkxdMFrkvvIyEfcdzdTWpU3aAogaAYRoetonnMJ+OT
         BSrMt0UnTU9ScsMhYjc8CQBDm2RMvr1xhLvjBqsNDN9TmHBUMS0Z3J3hfat0+m+PTyOb
         bMHb/IgoyLnztzS/5nsQBWbYwyB3ua36LirW0LkL1Ee9cELyCBYvw/dUvGCsKTSYFHpm
         zjZFDYfovVlCDfSHBveeeMmTESDumbhaUZGcIEYJ0EkAIiwtDp925DercUvIqmuKi71U
         fVFIGvYk68K3jjwWK7WykZR7cnjS3Em4xFGAZngdYzo5JFNTjjAQne0t/z1O65mRVn93
         /yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=MCPAXhDCQc742dpZ+x6jNLqv2PyH1MjeNNepu11/jbY=;
        b=PESyPBl5rCjZ33N6qWpsv5mpApxE/ou5zWot84UDcTmpH7RrtNqY30PK9MG7qZY4DM
         fhDB+JxwRNau1NjQUgAp9mMfWFbTzBwjVBEFXt8sbRNeiFEmkJ7ZPLqVXa8dhTkhYkH3
         rkc8avA8jLMaMfA/tLpStc6uYwRKnA2xfNaNuiDA/9yuvHjEB6m1wB2bwqmYzE1zziEe
         pp3JUd6K2Msyntj/hqvDp+hWzumiyyIRjd+nSr6xOSM2DfMLWXywEKL1kS5TGq/nqoxT
         O5fiOgCcEnREXaGxmF1WhXj6tsyqLVFg5bd7mV9p0iK3DUY0ooWwH2fsCF0a5KC+7ckp
         XJnA==
X-Gm-Message-State: ACrzQf1Vd4kSMN6xAj1xbTZJwEISE3E9beFBf4SClyUKX4hghCZJ090b
        T6wcZdu1pDlamZJFEZaWZ9c=
X-Google-Smtp-Source: AMsMyM6UQ05a2tPF8vUMZ9lpxHlKt2jcdrs+U21k72SAK5yyrcIcygqryAgVol3RQvFWaz11uDtVDw==
X-Received: by 2002:a17:902:e5c9:b0:178:5a6f:6eb8 with SMTP id u9-20020a170902e5c900b001785a6f6eb8mr14435456plf.42.1664038662284;
        Sat, 24 Sep 2022 09:57:42 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:20c0:42d3:7ef1:1f3])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902f20c00b00176675adbe1sm7960082plc.208.2022.09.24.09.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:57:41 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/5] libperf: Propagate maps only if necessary
Date:   Sat, 24 Sep 2022 09:57:34 -0700
Message-Id: <20220924165737.956428-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220924165737.956428-1-namhyung@kernel.org>
References: <20220924165737.956428-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code propagate evsel's cpu map settings to evlist when it's
added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
be updated in perf_evlist__set_maps() later.  No need to do it before
evlist's cpus are set actually.

Actually we discarded this intermediate all_cpus maps at the beginning
of perf_evlist__set_maps().  Let's not do this.  It's only needed when
an evsel is added after the evlist cpu maps are set.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/evlist.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 187129652ab6..cc070c3a134d 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -67,10 +67,6 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
-	/* Recomputing all_cpus, so start with a blank slate. */
-	perf_cpu_map__put(evlist->all_cpus);
-	evlist->all_cpus = NULL;
-
 	perf_evlist__for_each_evsel(evlist, evsel)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
@@ -81,7 +77,9 @@ void perf_evlist__add(struct perf_evlist *evlist,
 	evsel->idx = evlist->nr_entries;
 	list_add_tail(&evsel->node, &evlist->entries);
 	evlist->nr_entries += 1;
-	__perf_evlist__propagate_maps(evlist, evsel);
+
+	if (evlist->all_cpus)
+		__perf_evlist__propagate_maps(evlist, evsel);
 }
 
 void perf_evlist__remove(struct perf_evlist *evlist,
-- 
2.37.3.998.g577e59143f-goog

