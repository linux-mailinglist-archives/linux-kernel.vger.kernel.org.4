Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775EF5F10C9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiI3R2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiI3R1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:27:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBFD1D8F30;
        Fri, 30 Sep 2022 10:27:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v186so4816166pfv.11;
        Fri, 30 Sep 2022 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=t5TCNRTrQpQtzWyPUY1rC308ScWd7VMmiHrE+xshmOU=;
        b=oJfVWGxV0kuZ1YrxHJGxcX3bLRFdhuP43KryRxKuT67hW5iM3LTVn5fXmJUo3G2Bup
         KS+F7pwREa8G01bOZhKquE9ETT/oDIuCUmofjYmZ2BvEWHKNvk1TH0Iui1zxSljjwKgV
         Jl3D4MRuPuUlwb8EtlTJXgHkhOMx50dyyAFySAh7nYA60ay5fwvlQbbAyr9QHqUvDXtS
         sN0BrqBygo3Rr/6n0avNzyC3MhGNeSdEFdAqUF32vJlXSYj/cCjFd92U/2UNhpVF4bUE
         nGhKB7Smxh7oTCU/ab1RHJx6LFqCSDWhs+tS+XFay02xfBnwuY552Ig2N1qokJuHP4n6
         F2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=t5TCNRTrQpQtzWyPUY1rC308ScWd7VMmiHrE+xshmOU=;
        b=sM5ubwjbKgheMQY3bMre4YxXw1QWfN+gUuuerfnHfX+nVaK74SC8rdiYDhhsEZeK8l
         Ss4kJ/KQFpP4qHe6BlgvCIb4SOJLWfhcJJ9HNzo95l9Mzjj0Y/rYI+Gcao6Ypkx+UqWi
         XJE6gYJFMXr5FDHI2ibKV3PSADQEt37gz570/3sXayJp5QU/59137cX+ms9NtH3UBq8S
         TQIWb88KyZsephfiQ6gtuXy67KkfPMdps06jg27fnsRt9neGDQTQwwWDpq9xwVTxAEeG
         xDHpw7tkA/NeowycKHgY3qBLb1wHfNkHqV3qLIiXcL+SPAlnihVWvCMPMFcdwt4ScAXz
         tpog==
X-Gm-Message-State: ACrzQf1o6Gw2ambC15lo/tDyS3cKfSct2Sc3N+TYRfxIdEziZETCMxzL
        /vldSh8wHroKle1H+emHN88=
X-Google-Smtp-Source: AMsMyM5IQ02O46kO2hLNR+U3mgBxTK5DR4VA8sQ5TxSwHE5AhtWlrnnV0520TJJDRjX/3xsg7Y+HUg==
X-Received: by 2002:a63:3c3:0:b0:441:833b:10c4 with SMTP id 186-20020a6303c3000000b00441833b10c4mr3920574pgd.573.1664558853118;
        Fri, 30 Sep 2022 10:27:33 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b00168dadc7354sm2154762pls.78.2022.09.30.10.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:27:32 -0700 (PDT)
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
Date:   Fri, 30 Sep 2022 10:27:12 -0700
Message-Id: <20220930172714.711616-4-namhyung@kernel.org>
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

