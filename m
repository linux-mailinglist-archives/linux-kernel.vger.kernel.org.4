Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86106B00B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCHISG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCHIR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:17:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594EF12BC6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:17:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso16686444ybu.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263475;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=k37Zel3K78y2RXeX59p9IX3jO1BCWDMXFQICKa5aOp8uyNc9Fo6TSxvZTfud5WfZmy
         bbuEA9vKQXt/45E7yOe1rPGuM+mMZdsmRRn6Id24WjXl2K6d9t2tSkTCAdqZo8MPrtHH
         LtIotovSED/S9C5a83fKPCgCqx08g01zJw1PTmySborNq9XHGGd6XMIu6CoAvgc5cngS
         GNosj4nFEwQ5YhrGUTIMThG5lmhFeM90/L4ua5aOEMLxBkujfvKftxEGP/ZaMcaTm1GN
         NABl3um2vEo77k4AqR8GYMwWxISH9w59rrhsKaQKcGR37VGDjVOrdvYfEpXIoQ3zQCiQ
         FiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263475;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=dZBa8V2KwQohDPVlO1CD1TUmHRCDqHUTX3vEKeWfv/8Wp3lWqDmwW5lQbTHq9hykHJ
         hCb6HecuUU9iCmlxaqRavc0Tm9wIlOjp9AJhlT2J38elkl8eN41epJNLTIabVB2iKhVY
         6RjYYE1ylc8i/gnHnxs7s5T88YpNgb6on5Y0bSDR5UpyzdABz9yqWhti9QVSWIklK357
         /280rHeF4lJs8S/N0Nz+4wYcOgEWtXiu6n4G3HRwU0ZWS5swCn0l+I5yxmT+63DSqhGZ
         GfXdPUCrYCk010cyeXXOeVViuvV9PH9PUWZWDEOTq1W8hpFl023JIWchNMx3qbC24gcM
         37kQ==
X-Gm-Message-State: AO0yUKX3miIAroIK0fI0L/UzWDFi7vZh2TUhUSCM1NxD/cQpzydyinKa
        0vzo4i306+fjgnIaEiqhDH3+IoG5g+y0
X-Google-Smtp-Source: AK7set+/+vEn8fMSc0dc71hwtQ6ZSPMUQDWUafdkCj5lAKVUx8HRElKYsfX5hn/Cg6AXKK1+0RRVejmsbE/f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a5b:542:0:b0:a67:c976:c910 with SMTP id
 r2-20020a5b0542000000b00a67c976c910mr8271656ybp.7.1678263475634; Wed, 08 Mar
 2023 00:17:55 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:21 -0800
In-Reply-To: <20230308081731.1887278-1-irogers@google.com>
Message-Id: <20230308081731.1887278-2-irogers@google.com>
Mime-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 01/11] libperf evlist: Avoid a use of evsel idx
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the leader iterates the list, so rather than use idx (which
may be changed through list reordering) just count the elements and
set afterwards.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 61b637f29b82..2d6121e89ccb 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -687,15 +687,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
 
 void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
 {
-	struct perf_evsel *first, *last, *evsel;
-
-	first = list_first_entry(list, struct perf_evsel, node);
-	last = list_last_entry(list, struct perf_evsel, node);
-
-	leader->nr_members = last->idx - first->idx + 1;
+	struct perf_evsel *evsel;
+	int n = 0;
 
-	__perf_evlist__for_each_entry(list, evsel)
+	__perf_evlist__for_each_entry(list, evsel) {
 		evsel->leader = leader;
+		n++;
+	}
+	leader->nr_members = n;
 }
 
 void perf_evlist__set_leader(struct perf_evlist *evlist)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

