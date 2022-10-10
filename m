Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A556B5F97D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiJJFgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiJJFgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D15165C8;
        Sun,  9 Oct 2022 22:36:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y1so2733002pfr.3;
        Sun, 09 Oct 2022 22:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqmTs8/sjxR4VW7dikRv4ZzGywAqvgIN6RnXpX4I2Jo=;
        b=kQWkjIoRNTUVJrr5XxB2gmdd4cybLHh7z3juvacMMlcsuyald5iLs0qAh1oMKWF1ap
         7At+CSNrHBVNVFGd6jGfiw6HdLHHRflhJMuUCf7ML6oDo+bo80be3IrlTEH5caHnNaJ6
         e/kbG2CyRclKPQXRkcY7WJ5D+KLR16NIJ25O0w6LfEj49HXsZ+DMBNt0BUshf08GAIsA
         rmmqr+QjEDMp4qFZs2XRIuabq07AzoK9FlgFJ6Vb54xKidzlKnDNUPz8CVMGuPz7sISQ
         I1iOZPyglnSaRbRrSgIDspLdlP8xioyiRbNytT/XY6visyVByDD+BqpuZ7lCiU6rfC76
         s2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IqmTs8/sjxR4VW7dikRv4ZzGywAqvgIN6RnXpX4I2Jo=;
        b=EadQnzDpuV/C6tN2hIZ7FsyxNI7atXWr10QqTqXf9V0UQQiKHsABjXE3fy1jYFfhNY
         xFNwugl3QB2o8nR6RnjNZxJ8zpkHIY+NmA1YEZ7/jb9cU574u5QglVPM9ayPmeWjp6vj
         C7soSLcylBB1Do7sff5j2srUwbrSHVomrT8tWUm2MQGGWEJSN9mNGrFkaO/w0CNH9Das
         CzTwQYlfeLX/hYnKLwNeNGub9LiTsZ8N0+2oShmU44dAm0xj0C2W6Nx+0pW9hDme7YE8
         A+dp3djr+m1q7upkGg7Nf271jWd8XYvB7ckKKA2oPV9Z2CFIayYW+4aG63i3A6mu3aht
         Dz+w==
X-Gm-Message-State: ACrzQf3+2fzLhWRDR+8iR0khMUztyKyrJQY6vP+73rHGgnlLEr5cfQq3
        p+ixSJ11dxNPQzT8MzJb2R0=
X-Google-Smtp-Source: AMsMyM5/cp0ZNFNqhjmDC3p1nAUrOCIVEUWfJoepRmT8AXe0HNFOL+b/NsGdB5vby8+KD/WEp/TsNA==
X-Received: by 2002:a05:6a00:1a55:b0:557:b7a3:6738 with SMTP id h21-20020a056a001a5500b00557b7a36738mr17926206pfv.61.1665380164590;
        Sun, 09 Oct 2022 22:36:04 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:04 -0700 (PDT)
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
Subject: [PATCH 01/19] perf tools: Save evsel->pmu in parse_events()
Date:   Sun,  9 Oct 2022 22:35:42 -0700
Message-Id: <20221010053600.272854-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221010053600.272854-1-namhyung@kernel.org>
References: <20221010053600.272854-1-namhyung@kernel.org>
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

Now evsel has a pmu pointer, let's save the info and use it like in
evsel__find_pmu().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c        | 1 +
 tools/perf/util/parse-events.c | 1 +
 tools/perf/util/pmu.c          | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 76605fde3507..196f8e4859d7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -467,6 +467,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->collect_stat = orig->collect_stat;
 	evsel->weak_group = orig->weak_group;
 	evsel->use_config_name = orig->use_config_name;
+	evsel->pmu = orig->pmu;
 
 	if (evsel__copy_config_terms(evsel, orig) < 0)
 		goto out_err;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 437389dacf48..9e704841273d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -263,6 +263,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
+	evsel->pmu = pmu;
 
 	if (name)
 		evsel->name = strdup(name);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 74a2cafb4e8d..15bf5943083a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1048,11 +1048,15 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = NULL;
 
+	if (evsel->pmu)
+		return evsel->pmu;
+
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		if (pmu->type == evsel->core.attr.type)
 			break;
 	}
 
+	evsel->pmu = pmu;
 	return pmu;
 }
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

