Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BCB6B62D8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 03:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCLCQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 21:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCLCQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 21:16:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844563C7BB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:16:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t25-20020a252d19000000b00b341ad1b626so4128614ybt.19
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 18:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587362;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkP3cjlyFBuY4lwBhuPasBEAZ8EXgvKaf+XTugs0ORk=;
        b=dl6rB5hFHv9SCNUubl2rtwaN/dDMjOatwZ3MmZLo5IRBFOs7mnSBoXwIjFci/ORyq7
         5RQDqJSUEQtUyt43HW3aGm/afwWgmb9tIv1ebmxPD92DsCu+t1Lru/Mc9sQ7wVk6Mulk
         wW/FmCvesK1PQRyVj6vqPrK3lUB3IvkDYwYN9iZthvBapK8LsBFRQ3YM/UJflOZGpTZj
         8kT0qzU063vz5qPgqwQvW25/25DUN6fImshKtoY1/uXNE9slZ/+IOO42iNSaBzxzcyYL
         xV46aDRjr2Hi4tp6bOxFo7QUpVxrATRB32IpvrhXbR+Ic+JzsSKRtbIVp+Kk3DCYptdN
         wwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587362;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkP3cjlyFBuY4lwBhuPasBEAZ8EXgvKaf+XTugs0ORk=;
        b=Aueqzb0y/MzBnUuOXgmgEaEqfiCRtbrgvbsj21DMprQqbyach0UNcrvyAZg4f5D/8f
         OFkT63S5yGOX6yAByWoPmRVEiQs0Opdzc+gkGH2UomE4tioZeIeJhb/7eZY+DpSeNKyh
         woOPC9emR6SUPBdrQ4k/VaXMJ7QHnFW7UpbRSD8d82Nm+Lr3TMQShOa0Ur/woKKHm48g
         a+kFQv6tmcEKqvFjkHPVEnn0r+WYvLjPmeOplbiDzTyKCBP81QW4fUdo1FPjrBXLjHOj
         uumeNrAO5s2anBJJbS8ta1O27bTEYjy3IsD7qdng/QmAJM/7MXhE4kIN1nugHD+nnak0
         k/zg==
X-Gm-Message-State: AO0yUKXFabGhNVMmTsiqopPtvgC9cisI1C837sprDG3y/40acjDY2asb
        m58kpvLmkVP5ZzQGVFeNyyN5Qte7J+z5
X-Google-Smtp-Source: AK7set/kJBuEV+mbqnhAi0kuxu/g23f1XpN6oLJWkygemzlOuHhNBjhSuYPUA/SjPgoLxUZazwSQajtgf15R
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a81:b286:0:b0:533:9185:fc2c with SMTP id
 q128-20020a81b286000000b005339185fc2cmr20162639ywh.7.1678587362660; Sat, 11
 Mar 2023 18:16:02 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:33 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-2-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 01/11] libperf evlist: Avoid a use of evsel idx
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
2.40.0.rc1.284.g88254d51c5-goog

