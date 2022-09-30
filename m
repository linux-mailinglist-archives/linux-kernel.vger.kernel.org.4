Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123865F10C7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiI3R1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiI3R1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:27:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919881D848A;
        Fri, 30 Sep 2022 10:27:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d10so4813042pfh.6;
        Fri, 30 Sep 2022 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=mcdTg7QGTQqXsDIVRoGrzxy9JDO0zJAoCC38Nz4SgJw=;
        b=NDow9pY49V2nnJdhg9VfTSlgt2CoEbvxDL2bBjXqXk1n5UaunlhdOtNChnMVplVvL5
         J6JH04rmKR6llzHl7ENoG76+qyJHe92XNM0BqZe23IWD3/rYTvgDgGOUqDF+J539yxEi
         KxVlOwz9ZBLTZMXlPIRREAix93Dh0KMbQ3TciotY96GQy6fDN2t0qAFFA+Yr6vbzNV7V
         guqA0/NBw/ogBcDNcr/7C0SQ+aeFMN3duhuXfycjmvveZyHLp3mEgzKesLBpipEgi9Nr
         qFxBN+yBlnV/jSQ2IGMti8mAdiubGwuqxkiFHnVzKye+L7TnTRXSLgQNSg1/L5lxrEAA
         m0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=mcdTg7QGTQqXsDIVRoGrzxy9JDO0zJAoCC38Nz4SgJw=;
        b=hTzH+tTL25pwApPEbjCdPT7Sc4MWsgLgEgfg+FH8hBMCS5t+kJ458iPH2BqNhhueki
         kOrEcXZzR+TxjaJUkE+CyldeD/rerRUcHHTJcJT/fuDNMtWu2rds0m9P319Zt697UB6c
         tY/shqa6qaCm6GJpfD1gD4GYJbfS3jhaEgLlvUYniNnHzu0pipurGv70OOV4e48RE9Je
         ABq+W58NJTE5ArJ1279Hc+76c1NUTJnZ8e11zx97FRMDgJxBQe0d3mIWnyD0oJ8sVW8+
         FTsxwkDzbcsZkLxAYTjHZnxozKTMxSRvuzphuKYIpn3cFYoDLxK90tK1Tpeqj0jQdweW
         CuWg==
X-Gm-Message-State: ACrzQf2xjzoCqqGY95PRr1LIGvNtyu8SOcI54y1bwkdtW9LoyBpg4y14
        QLT0zP1ajc3+elA9jn2Oiua5SSZeZm8=
X-Google-Smtp-Source: AMsMyM4jorXdi+tWGkFGxEfc+0YcCK8xa6KmpZp0EnTTcOWyTe/FwCR9NkSPKZtUn0KaiO1RXXgf0w==
X-Received: by 2002:a05:6a00:4c91:b0:543:646e:9 with SMTP id eb17-20020a056a004c9100b00543646e0009mr10370713pfb.40.1664558850728;
        Fri, 30 Sep 2022 10:27:30 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b00168dadc7354sm2154762pls.78.2022.09.30.10.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:27:30 -0700 (PDT)
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
Date:   Fri, 30 Sep 2022 10:27:10 -0700
Message-Id: <20220930172714.711616-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930172714.711616-1-namhyung@kernel.org>
References: <20220930172714.711616-1-namhyung@kernel.org>
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

