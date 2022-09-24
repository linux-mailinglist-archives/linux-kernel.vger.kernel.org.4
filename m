Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7264C5E8EAD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIXQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiIXQ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:57:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960DA3FA27;
        Sat, 24 Sep 2022 09:57:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jm5so2724276plb.13;
        Sat, 24 Sep 2022 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=KLe1rhG2jyFxMjNRfJfVKi4UTDqQ8WJWgu9o/n99gQM=;
        b=Y7CXU6iNdPkcsRL/SPx0ZSGbxyT3GSS9kG6O5u+YuInrdNhYoQDFDryLtXGRWEVe46
         4+4Vs7AP80fdJGizBhlx0BVcHZnj08eJrk6dvzErxNJf0qPJPBgPXhqIl1CrjblJ/ugM
         B/hnERzz20ZimSeFghjKqEt+gZsyj2JC94hxU7bUz2JiAuwVEXXROc1I7gDxELOmcGfD
         Abe2zrkrQNfx+Dlqio1k30aSVJoQyhpzsCUFKw+gLptPyX0WpnHsKCzHDoZR5UgRjx/E
         +Njdg8pafrw9sW+pZ9DcrJoltqFetw6Oy0UQ8Y5FYWtFjIZh9XFIemCuImoKHsK0QxCB
         OGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=KLe1rhG2jyFxMjNRfJfVKi4UTDqQ8WJWgu9o/n99gQM=;
        b=v4FAvI4GousDAMhbILAxWL+pmFC2D4c78RVD6dg83S6bdrIOXU8rzqktvmTP7rOStE
         I2OQyE5s5vfa6qr6rue2wnCXvqVPiwAaA/9k03wudX50Op+InuwHSquvREMt9wQkjDHn
         lFs2O+QumfXJo9dQRSFaRaFmhriEwdjwOGODpdbqHhSMfFcxm5/aSU8Nyu4iB8YeC0OV
         0nxHMWeGOYUvIj66ONqZQ1QGq1YwislGqAonEr5IGSUfFf7aLqOJQYX4qA6WW3IIo5Ae
         +a2RmIe77qhpKeZ5QXWEZNQSF3GvdwTY0+QTWYfH/64DMHpUV1virwB+IARLiHPCXk3e
         jkPA==
X-Gm-Message-State: ACrzQf3EpShsYRYuuUWyK8BLPBMoWk7kTHWdPnVFMMF4mZ3LyIS7B6dG
        E6z+0Xr5CUfBFLC5nYnMIPY=
X-Google-Smtp-Source: AMsMyM709bRyaS417ZlIXlxiOSAsiF+vTQwqdwvpXBfHOzblFPLXa2JKj3Vb0zj2Y84svDFMpJT33Q==
X-Received: by 2002:a17:90b:110a:b0:203:6f0c:9b66 with SMTP id gi10-20020a17090b110a00b002036f0c9b66mr16220873pjb.104.1664038660991;
        Sat, 24 Sep 2022 09:57:40 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:20c0:42d3:7ef1:1f3])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902f20c00b00176675adbe1sm7960082plc.208.2022.09.24.09.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:57:40 -0700 (PDT)
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
Date:   Sat, 24 Sep 2022 09:57:33 -0700
Message-Id: <20220924165737.956428-2-namhyung@kernel.org>
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

Setting proper cpu and thread maps for system wide evsels regardless of
user requested cpu in __perf_evlist__propagate_maps().  Those evsels
need to be active on all cpus always.  Do it in the libperf so that we
can guarantee it has proper maps.

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
2.37.3.998.g577e59143f-goog

