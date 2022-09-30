Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E335F10C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiI3R1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiI3R1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:27:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA3D1D8F05;
        Fri, 30 Sep 2022 10:27:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e129so4696215pgc.9;
        Fri, 30 Sep 2022 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Dc/jbP+J01QaQor+cUjUGSbMxL2tJwx81JkUMwy36Mw=;
        b=k0RdZn1YaRjj8kIpVG7xyr/uMLTesVGw+P1Gsk97+gIKX8PML3gUKxkiQeTnR//vse
         IjQ3jtXJ8rJkPKUSKrcp86xa39bVmCEWY2Aeh5KoPYothect4D/ZOzoROKEFiCyuHQPx
         jZLpb3LnY4+DvDjoDg/MX16mXEWfLRgN78LzjaUWhoNViLcoCTtyVKx8Y79rEIBUqloL
         QSyoywHBd6TkdjMChg7YmPK7fS6l3ea5ee0YMIHCZpaPQ8mNlaJlcnsDvElIM8YbXpic
         th4uqrKhYiL7YDjEFPmRUGHUT0CtoUYhczAlE/WMrke320xCcP/dfRAdQbA8ZZHlrIUf
         wH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=Dc/jbP+J01QaQor+cUjUGSbMxL2tJwx81JkUMwy36Mw=;
        b=E8XZPL/MiaG4kC3tplGjBwNLjlenXDYNGcoRCfOrIRszQmuOZ923RRg0f9M30SO9WJ
         Dch3q+B/v4hqCex+D6wfihIbfn5sqOSRQUVZ5K4V5BJcXlqb4lmPTYkDs1RYC+PXvl8c
         EsTCQmTzfXTDWLgRfisRFF5br998wN759epmCYWIFYHIkhCXxTsWDGFUQ0KHzppuNAaE
         UfBJcPRcfGa8PzDbw7UeVwq11VSrHDIQ+0nnfKNeKcoapsE7OlMF/LtIgQLv8Q5s4Lo4
         lHTRxgt6+hWJe94WyPGZegUnJpHK1ziYDVGpDS8A5v0tevr2w7OmQBtImvrvDIb6pDWe
         mgDA==
X-Gm-Message-State: ACrzQf03nDw0VC+mkcEv3QTI61zBHnaXq4W9HVHkeb6wLZEiDcrUvIhA
        65G/eYk9QP8B7mYUaYXPU6GOfgKvEck=
X-Google-Smtp-Source: AMsMyM5IUZo/b73E4aEZJ1Dsr9rNdUolvG8XjHO+WYGafrLziT2XBraTbbYifqNXllLiyPO2V4kBpw==
X-Received: by 2002:a05:6a00:194f:b0:54d:d12e:93aa with SMTP id s15-20020a056a00194f00b0054dd12e93aamr9750102pfk.34.1664558851825;
        Fri, 30 Sep 2022 10:27:31 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b00168dadc7354sm2154762pls.78.2022.09.30.10.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:27:31 -0700 (PDT)
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
Date:   Fri, 30 Sep 2022 10:27:11 -0700
Message-Id: <20220930172714.711616-3-namhyung@kernel.org>
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

The current code propagate evsel's cpu map settings to evlist when it's
added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
be updated in perf_evlist__set_maps() later.  No need to do it before
evlist's cpus are set actually.

In fact it discards this intermediate all_cpus maps at the beginning
of perf_evlist__set_maps().  Let's not do this.  It's only needed when
an evsel is added after the evlist cpu/thread maps are set.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/evlist.c                  | 8 ++++----
 tools/lib/perf/include/internal/evlist.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 187129652ab6..c5f65b89d77a 100644
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

