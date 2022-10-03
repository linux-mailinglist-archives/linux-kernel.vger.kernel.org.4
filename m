Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5175F374D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJCUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJCUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:46:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879D4BD20;
        Mon,  3 Oct 2022 13:46:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 70so10883382pjo.4;
        Mon, 03 Oct 2022 13:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=t5TCNRTrQpQtzWyPUY1rC308ScWd7VMmiHrE+xshmOU=;
        b=hm11mYXWYrw8hQ5+3xTcXU91kMRFRKZygYbSOTM0hp/sUDxkpJ9U7PTIldjrDhxOp/
         TRa1CyVVJqwg0wX2vXhrRgNEbT+dizU1dJhngFTD/l3NOc7qJaiulyuyT9UJ0rCfx1Il
         flQ93T9V3uRZthl03vfT377SYqoR5HwIqblO4A4GPjQV8eEpOID5HBNRjmlM/AjFsquY
         aMns+KDZxBdkEbKgGMLJBX/YtaD1ploho2nbhMymobjEslclm7XXWgDBk+l0XiU3r5h2
         jNHeolSX6uvXuNmdJBHjCgrUR0HJwOzi/O5XosC9uTqTBkHUwHEjRN1Gd3r+ikmrd+cW
         0Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=t5TCNRTrQpQtzWyPUY1rC308ScWd7VMmiHrE+xshmOU=;
        b=nz1vicgvQ6ocLBXUSZySQrCk8nEHPEQl9Qgg0rkUlAag7L7UVCRQ/yKV30AOMnuwNv
         4vMP1dAgaD4OSDicmqjhQqO4dkvZx7RNHJ6Lh2PJzotm4TFyDm16stbPdnfv79r+B8hX
         GulwsbMVgtIGemLYWYKOU0X/fZ1GRfGFvyQzW+KyKfWK69VHEM6Ckvf/4OQQY6Z46iag
         wVDvUL3ZJ/6YzoNJQEF4XPuDctaNhioB5WtslQsf1cC/g7M+JoX715tl/jcxYEjJcLdn
         0QVN5PcM8ZpHMtSBlPv6lceIvnHQLZpWOGZPvGCclmKvQm4a6KoIAc8GMyavdY/ui48I
         Xffw==
X-Gm-Message-State: ACrzQf21gRTYjpe2RxTxsuL0iShbMCpfV0VhmtmADLvES6z9wv2xw4h9
        vI8izDjF8PM8d6vgG1r003c=
X-Google-Smtp-Source: AMsMyM4/TBPi7lU28oN9Ft6kmfeGJGr6TFwBOBlOX0En95hoV3pNUejn79qH542vmdPj6otcYaGUfw==
X-Received: by 2002:a17:902:8c92:b0:178:29d4:600f with SMTP id t18-20020a1709028c9200b0017829d4600fmr24250689plo.40.1664830013372;
        Mon, 03 Oct 2022 13:46:53 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:63c9:72b6:3eb9:490a])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ac68c00b0020a821e97fbsm3522931pjt.13.2022.10.03.13.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:46:53 -0700 (PDT)
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
Subject: [PATCH 3/5] perf tools: Get rid of evlist__add_on_all_cpus()
Date:   Mon,  3 Oct 2022 13:46:45 -0700
Message-Id: <20221003204647.1481128-4-namhyung@kernel.org>
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

The cpu and thread maps are properly handled in libperf now.  No need to
do it in the perf tools anymore.  Let's remove the logic.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evlist.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index fcfe5bcc0bcf..dcf57b271ff1 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -268,28 +268,6 @@ int evlist__add_dummy(struct evlist *evlist)
 	return 0;
 }
 
-static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
-{
-	evsel->core.system_wide = true;
-
-	/*
-	 * All CPUs.
-	 *
-	 * Note perf_event_open() does not accept CPUs that are not online, so
-	 * in fact this CPU list will include only all online CPUs.
-	 */
-	perf_cpu_map__put(evsel->core.own_cpus);
-	evsel->core.own_cpus = perf_cpu_map__new(NULL);
-	perf_cpu_map__put(evsel->core.cpus);
-	evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
-
-	/* No threads */
-	perf_thread_map__put(evsel->core.threads);
-	evsel->core.threads = perf_thread_map__new_dummy();
-
-	evlist__add(evlist, evsel);
-}
-
 struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 {
 	struct evsel *evsel = evlist__dummy_event(evlist);
@@ -302,14 +280,11 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 	evsel->core.attr.exclude_hv = 1;
 	evsel->core.attr.freq = 0;
 	evsel->core.attr.sample_period = 1;
+	evsel->core.system_wide = system_wide;
 	evsel->no_aux_samples = true;
 	evsel->name = strdup("dummy:u");
 
-	if (system_wide)
-		evlist__add_on_all_cpus(evlist, evsel);
-	else
-		evlist__add(evlist, evsel);
-
+	evlist__add(evlist, evsel);
 	return evsel;
 }
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

