Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F6D5E8EAF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiIXQ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiIXQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:57:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51290883F0;
        Sat, 24 Sep 2022 09:57:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d24so2762034pls.4;
        Sat, 24 Sep 2022 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=uEB7eOXWTpeJuzDn8ZjWWedlCXtJw6M1+lr3Jy5UZrA=;
        b=XJmkoQDLfZvXbETKGEySQdmjNidTmwB3cjF5/g7eRWSYmKCo6wzXI17hyGRTzXN/2j
         TAeJQD8VoEtDn/1XlT6iyRw/YQESrnj6ZpFqkGY0vHj5ri7vyJsVPZUupyg8TlHAAayo
         1tUpD2/uwG38Xhv4jEwzkai4mZTMOK0z3VyXdH1gL3iZvybS7Nvu46dpn/klMk6pVrJu
         vgV3Qntn07ELErBO/pqW0jaV80Ch98i+911Qo+SPok/zWgbiQxYljdPjfW7VkLyXPZLb
         sB5CtpU1beRSLRJAl+nUsXfp5mDwAltEnGO/ygrncEc6oHHxI4P7y0vhyGyVPG/MrP11
         WpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=uEB7eOXWTpeJuzDn8ZjWWedlCXtJw6M1+lr3Jy5UZrA=;
        b=Rlo4kPOZA6FYRsPD+WAk70Gc+Tn6CNviRbCRx/2xjKWi/AGVFWeC6O5TkfpULnmlbu
         aJC6iwWc0M/5/2LVyXqyOs3NZIlkab/JfPaBsNsntJfhfIgcmWsjbWP4e8YE36CEJQK5
         /gVWTkNp3VFxEq1wTwNFEEFqBSZYhH/piP/D98yqOIzBvAOxqpzbK9O/2Tutosi8b+iF
         PHQJN0PDpl9lnVI5Nd/jH5QmzGHr/KuC/NMMCIsULybMTPQO3//+9OVnsVjZtSj0U8si
         iw1qhF2k3JKG6sud7zN95+DBUsJxuO4MK4DifcS0yUi2vWa4Rm8JMF9LOvGO/qnUrPIN
         IOVA==
X-Gm-Message-State: ACrzQf1Y6vYn43Iqg71erzmnOLPZ2TnxQeHtl2LnXYFV0SMLBHLh3Kud
        nkGPms8HQzJzKTsfe3sPrh0=
X-Google-Smtp-Source: AMsMyM54wbIiHOBUMK7x36JF9iw9rmAgY6qObJNUvPA8zNX+ljP/plQUsMDJHq9H/+jvxpoNcogNtQ==
X-Received: by 2002:a17:90b:1c07:b0:202:8ad0:3210 with SMTP id oc7-20020a17090b1c0700b002028ad03210mr28369036pjb.193.1664038663587;
        Sat, 24 Sep 2022 09:57:43 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:20c0:42d3:7ef1:1f3])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902f20c00b00176675adbe1sm7960082plc.208.2022.09.24.09.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:57:43 -0700 (PDT)
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
Date:   Sat, 24 Sep 2022 09:57:35 -0700
Message-Id: <20220924165737.956428-4-namhyung@kernel.org>
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

The cpu and thread maps are properly handled in libperf now.  No need to
do it in the perf tools anymore.  Let's remove the logic.

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
2.37.3.998.g577e59143f-goog

