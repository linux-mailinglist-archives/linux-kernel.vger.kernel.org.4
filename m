Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5980F5FE8C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJNGQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJNGP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:15:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1007219377A;
        Thu, 13 Oct 2022 23:15:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so3945389pjl.0;
        Thu, 13 Oct 2022 23:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asmqIEkehVBlu4ghVcVYSD1s1d8czrslDCSII7LsD/Q=;
        b=TwXrnKSuvAijT0wGUoX6E1+3vzdEONbdORaQDNvPrVtRO7OMGvxjk82QRt4aUQ0Yfk
         rSQrUvXO2FEm7H+R5V17F2Pzv0OVUD+vpkRyO+f1ZdVdrnsnXRs8MtiBiGvj4f4xqFQx
         eyOljFtXDoFGdHkzX2sx91HayO2YJergGxBr5ZL7uxvS+g52ntXPC5tWsnessLjZkO2L
         1P57edaAWvnrypHYSJ7R8IuqKuWO5fyg1ikvjiZ6UCvIdwCB9fuYg5lcrlWKfXxR6j4X
         z3kFgkB2XWQZKtaWLDGpd/OBBbpLcH0g49/olHTdbDPzD5Fc/QL+I9vlrsBpI5sr2Lld
         SL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asmqIEkehVBlu4ghVcVYSD1s1d8czrslDCSII7LsD/Q=;
        b=h1NRRQ7dZYvq6d7caPwKmrhtcwZsvEaXfqRcxkWy+l4iF7xdD+eSLykNMehE9a4zRC
         jSvCPGkcDm4HTZZkcf+VWLL0dCDbbBb6vc7zcJEPk/Hjhn2Oy+4JgKcOnPTuk84kGE4p
         ExJC2bn4VVeCrXUklb/VYXri6fFE9DThSi+/beAxn9XLqSh0Hlp9JTA89hEbXDIGalUI
         0+YlKE3NPtofkerhfSbFFM7Cu7cRMw2LawUTmOFdQfDgblXtabSqH+XUVL2Ptmyl430c
         jDipnq0fYV44Fm4tibCrQTGcdA0KYFpw38H0OIgIWpWRpOlV2jzZdUvPA/nBlWt4/HYq
         bf/g==
X-Gm-Message-State: ACrzQf10smr3bJ4V6HrYA6t0ZIbDGokpa2fljfY2P215OLg2H2tZ9tlG
        +Zw/CJcGObI2NmYMva2sW4A=
X-Google-Smtp-Source: AMsMyM5UXePd5pJ9m2G1Dx8LAbXi+PbJt3v2MemNrbSzvdE//Crfqf61PE19gh8PBK8GRQMdLLYN6g==
X-Received: by 2002:a17:902:ce86:b0:182:498f:afdb with SMTP id f6-20020a170902ce8600b00182498fafdbmr3895149plg.12.1665728157335;
        Thu, 13 Oct 2022 23:15:57 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:15:56 -0700 (PDT)
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
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 03/19] perf stat: Use evsel__is_hybrid() more
Date:   Thu, 13 Oct 2022 23:15:34 -0700
Message-Id: <20221014061550.463644-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014061550.463644-1-namhyung@kernel.org>
References: <20221014061550.463644-1-namhyung@kernel.org>
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

In the stat-display code, it needs to check if the current evsel is
hybrid but it uses perf_pmu__has_hybrid() which can return true for
non-hybrid event too.  I think it's better to use evsel__is_hybrid().

Also remove a NULL check for the 'config' parameter in the
hybrid_merge() since it's called after config->no_merge check.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5c47ee9963a7..4113aa86772f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -704,7 +704,7 @@ static void uniquify_event_name(struct evsel *counter)
 			counter->name = new_name;
 		}
 	} else {
-		if (perf_pmu__has_hybrid()) {
+		if (evsel__is_hybrid(counter)) {
 			ret = asprintf(&new_name, "%s/%s/",
 				       counter->pmu_name, counter->name);
 		} else {
@@ -744,26 +744,14 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 	}
 }
 
-static bool is_uncore(struct evsel *evsel)
-{
-	struct perf_pmu *pmu = evsel__find_pmu(evsel);
-
-	return pmu && pmu->is_uncore;
-}
-
-static bool hybrid_uniquify(struct evsel *evsel)
-{
-	return perf_pmu__has_hybrid() && !is_uncore(evsel);
-}
-
 static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
 			 bool check)
 {
-	if (hybrid_uniquify(counter)) {
+	if (evsel__is_hybrid(counter)) {
 		if (check)
-			return config && config->hybrid_merge;
+			return config->hybrid_merge;
 		else
-			return config && !config->hybrid_merge;
+			return !config->hybrid_merge;
 	}
 
 	return false;
-- 
2.38.0.413.g74048e4d9e-goog

