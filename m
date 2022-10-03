Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E435F374C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJCUrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJCUqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:46:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DBD11A34;
        Mon,  3 Oct 2022 13:46:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c24so643848pls.9;
        Mon, 03 Oct 2022 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=EVO3gcFayQHfKalkHiH/wvzLxJyC1zqJNgPyrmTFh/g=;
        b=S0Za9o4EVoneLQts48cvamKwJ/CzLozB7+h8PtblnD5cbZEHbV/3SpVPmhz+2bFWFa
         aS9iRXnGQwbp2FTvsr0bj/NdHQtA8nrbB76wDSQgn35CdRbX6nm8qNdebKk2x0VzjNBx
         NUwviijPOKZ9mR3j1btBrrTcCVwG6ECYhNGSiiCuGRY/ATFRxkcj1DP87DbtIWaa29xe
         XtsvFLrAtZdceL0Rgnz0Hhu3ZgWctg2k4D6LH8Yb4lWpjXx/1WSSdhtb7OdeSc4azx0S
         ZGJma+Gtf7IBNh+yjM74nEFgEZhmzmaqQ8bSYSVjjoKGYcddU8PW9zaZIGt2nqWw+NB0
         1v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=EVO3gcFayQHfKalkHiH/wvzLxJyC1zqJNgPyrmTFh/g=;
        b=yobEo4ADzerHY0f0WrFtNP0hd+KgcgErXLjt04a+TglGRyEok26jzdCo/SJpFEtCdM
         wk9wpVqziig+GqN+gvSfo6cOMdKtrvqoUGCxEZ73sfeMSDiFN2ILOODToBnKeadvCqfJ
         iKmVpg4ojkfC264P+r2dPOfRgKn9oe0UsyeQNn9NZ2eutvgUCmu8PChnKw00T+4it7Be
         jGgg1ebOuIWCivQQujhNkUw/ONsIgwps+EVlSySoUX2NvDrIl0RKLR/0YjxpKW+HiY5z
         V3HS9WsgALxDb+/VaS2LTRg3aUf4BUbw3IZ0RhBl13tDD6+Hv9Chmv/vmegtVq0Ev4cB
         RKng==
X-Gm-Message-State: ACrzQf3ZXbnTtZzN7RVyvK46qOIhi7bZn1/Z1uU6YAH4S3tTtn8ir3GW
        7kzK+mjoVvvza7ae+FLA7knVkVlFj88=
X-Google-Smtp-Source: AMsMyM4tmdMPLmoJ8/om1JhBHjdLCxGBfC8MPQDs3CdtSQ+H7ksMwICxvhz8eZfRjq7W8OfEujoW3A==
X-Received: by 2002:a17:902:e952:b0:17c:7aaa:c679 with SMTP id b18-20020a170902e95200b0017c7aaac679mr17867318pll.74.1664830012189;
        Mon, 03 Oct 2022 13:46:52 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:63c9:72b6:3eb9:490a])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ac68c00b0020a821e97fbsm3522931pjt.13.2022.10.03.13.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:46:51 -0700 (PDT)
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
Date:   Mon,  3 Oct 2022 13:46:44 -0700
Message-Id: <20221003204647.1481128-3-namhyung@kernel.org>
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

The current code propagate evsel's cpu map settings to evlist when it's
added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
be updated in perf_evlist__set_maps() later.  No need to do it before
evlist's cpus are set actually.

In fact it discards this intermediate all_cpus maps at the beginning
of perf_evlist__set_maps().  Let's not do this.  It's only needed when
an evsel is added after the evlist cpu/thread maps are set.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/evlist.c                  | 11 ++++-------
 tools/lib/perf/include/internal/evlist.h |  1 +
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 187129652ab6..8ce92070086c 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -67,9 +67,7 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
-	/* Recomputing all_cpus, so start with a blank slate. */
-	perf_cpu_map__put(evlist->all_cpus);
-	evlist->all_cpus = NULL;
+	evlist->needs_map_propagation = true;
 
 	perf_evlist__for_each_evsel(evlist, evsel)
 		__perf_evlist__propagate_maps(evlist, evsel);
@@ -81,7 +79,9 @@ void perf_evlist__add(struct perf_evlist *evlist,
 	evsel->idx = evlist->nr_entries;
 	list_add_tail(&evsel->node, &evlist->entries);
 	evlist->nr_entries += 1;
-	__perf_evlist__propagate_maps(evlist, evsel);
+
+	if (evlist->needs_map_propagation)
+		__perf_evlist__propagate_maps(evlist, evsel);
 }
 
 void perf_evlist__remove(struct perf_evlist *evlist,
@@ -177,9 +177,6 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 		evlist->threads = perf_thread_map__get(threads);
 	}
 
-	if (!evlist->all_cpus && cpus)
-		evlist->all_cpus = perf_cpu_map__get(cpus);
-
 	perf_evlist__propagate_maps(evlist);
 }
 
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 6f89aec3e608..850f07070036 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -19,6 +19,7 @@ struct perf_evlist {
 	int			 nr_entries;
 	int			 nr_groups;
 	bool			 has_user_cpus;
+	bool			 needs_map_propagation;
 	/**
 	 * The cpus passed from the command line or all online CPUs by
 	 * default.
-- 
2.38.0.rc1.362.ged0d419d3c-goog

