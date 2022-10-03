Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6F5F374B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJCUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJCUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:46:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25DB4B48E;
        Mon,  3 Oct 2022 13:46:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso149129pjq.1;
        Mon, 03 Oct 2022 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=mcdTg7QGTQqXsDIVRoGrzxy9JDO0zJAoCC38Nz4SgJw=;
        b=avSzrQjbuG/malOzaBF/pa3e6NyMKknYntyWKuRrYrmNHmXMvV+PdrxaDcTJFDGWtI
         lRK2/rJwpQNjnAQRm49dlrnn8qWbwZCkYPX689BgMDQ9+WBHxYdpUs9yy48e0yvDrlVL
         XEwWgKL8SfiK7YpIhvjXhpAMQG58AclFpbkJ2kPPG59UEqhU0zsIN50kuTYPKmvBE6on
         7T25+RJu69yXhknH2tAKeBvxzLOcpm1P4tDgVMb4IPj16BzKsx6iyAhowG6ZGyandi96
         zyLchT/UOilqAxX+Po0ZDdtHyaMCCRp8MlmjLFxXBv72AsKcz6HDM9jqJioUSUrjYL8w
         8wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=mcdTg7QGTQqXsDIVRoGrzxy9JDO0zJAoCC38Nz4SgJw=;
        b=UZ7JZT86bOqGgR8qItD1WBVhZryav1yyBOaJ/YmDjldVdRLNsxRvcNtxW0A5EjphaZ
         tUNS+/pEQPE/OHI1AVPbZ00U9Vw+7ZK2KZKMTSxN6CF0MbghssFu8S00CITtIF1YY3Kb
         KxWf/ciL7bG4vXYSmk5wKzPhjr+xOrW6X3uwWanLZLl37oOMQ/gjJgJvbz8HkWYRZnmZ
         3ymiern0k0KcY/B7znSPdinfkIGcHhTPfQ56I8ShsJASi/1ksAct7gKo7nQTFNutpdR/
         8v6ucO8qVBfHsDGrGs/J+cFhiU7DFgDJHDL67ywlu2i1rg/78bZ75McevOWCMtCMs8rT
         i3Ng==
X-Gm-Message-State: ACrzQf0z69uJaT4RBtebeRhvx6OsrwqS2jD7oi/YyIaY8kNm+YKG3U+2
        g2nK7Wxmcc6A4nfVsCKzL/2CKoHTrYg=
X-Google-Smtp-Source: AMsMyM5uuq4q5TdOZ7pU/KUXDAK96fADOcn+y3kHsrRzIHg+FPt+WVgY6QaXWV113YHKpD1yMr/4yg==
X-Received: by 2002:a17:90b:1d01:b0:203:2bda:abb1 with SMTP id on1-20020a17090b1d0100b002032bdaabb1mr13573360pjb.204.1664830011146;
        Mon, 03 Oct 2022 13:46:51 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:63c9:72b6:3eb9:490a])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ac68c00b0020a821e97fbsm3522931pjt.13.2022.10.03.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:46:50 -0700 (PDT)
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
Subject: [PATCH 1/5] libperf: Populate system-wide evsel maps
Date:   Mon,  3 Oct 2022 13:46:43 -0700
Message-Id: <20221003204647.1481128-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221003204647.1481128-1-namhyung@kernel.org>
References: <20221003204647.1481128-1-namhyung@kernel.org>
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

Setting proper cpu and thread maps for system wide evsels regardless of
user requested cpu in __perf_evlist__propagate_maps().  Those evsels
need to be active on all cpus always.  Do it in the libperf so that we
can guarantee it has proper maps.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/evlist.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 6b1bafe267a4..187129652ab6 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -40,11 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 	 * We already have cpus for evsel (via PMU sysfs) so
 	 * keep it, if there's no target cpu list defined.
 	 */
-	if (!evsel->own_cpus ||
-	    (!evsel->system_wide && evlist->has_user_cpus) ||
-	    (!evsel->system_wide &&
-	     !evsel->requires_cpu &&
-	     perf_cpu_map__empty(evlist->user_requested_cpus))) {
+	if (evsel->system_wide) {
+		perf_cpu_map__put(evsel->cpus);
+		evsel->cpus = perf_cpu_map__new(NULL);
+	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
+		   (!evsel->requires_cpu && perf_cpu_map__empty(evlist->user_requested_cpus))) {
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
 	} else if (evsel->cpus != evsel->own_cpus) {
@@ -52,7 +52,10 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
 	}
 
-	if (!evsel->system_wide) {
+	if (evsel->system_wide) {
+		perf_thread_map__put(evsel->threads);
+		evsel->threads = perf_thread_map__new_dummy();
+	} else {
 		perf_thread_map__put(evsel->threads);
 		evsel->threads = perf_thread_map__get(evlist->threads);
 	}
-- 
2.38.0.rc1.362.ged0d419d3c-goog

