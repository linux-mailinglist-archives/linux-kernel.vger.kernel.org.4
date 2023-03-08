Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FDE6B15B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCHW7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCHW7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:59:32 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58DCD13DF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:59:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n203-20020a25dad4000000b0091231592671so266386ybf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316371;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=szI/v2kSJ1UzVtvNqdIiPV2xdcpUV7T27NeWsV2CESv02Nv1QVxVRzRb1BiSs1xFxz
         KRteNhiXld4XZkmdW+A0ojwllhTIWO8yc4PUenXBk+QEkqbDUMchTAb51E6ZATiuekAW
         iW8wSIMLkJG+K2ZAhk2ap8XAg50gkJ22oLDrW3EpWwdf4HCvQdaOgF8bE3ScP7Cxar8J
         CjZyAKRXQa65gEb9FYBc8PJX1NbQGDNVLYcjwtaOibGEr84RLAUO+ESsEMKxF1s1f1IV
         p9/oujXwZOtsZLhdakEZ+QUcZ4K3xeza1sWd1j+Jfc7ruxLu13N+ZfamtXvQMCBreKpx
         1pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316371;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=XQCNEBBS6XL09QRvVMeMBcON/PiwyvE7Ix2CGEz3/c0VqvFeWvgkb7zCOrNHGBZ5k5
         s0bHcw1APePUJoDupm0lTYW18LuEKdru2uZcY1GO7bLK5VvyUceGYDJKXbKJ2o36BDb0
         y0f7Q1XXgspb85nVcfjCJPVNa9EVIe218MpbWSjZWoAibbVkVHL6NE3RNVxKQwyXb1vf
         KJZQVRE/VoqHM6cpWzWyIP9wMoF+4V2zvpx9nCQ4IWMvYGo8MolbAe4Mv5r+KyUKWTb+
         sJHr9E/ssGWOrJuF2HGUGLCCsZasuuv7oXAw7r+kMdah+5jUV3QRzpn14GfNQf7+txsW
         Lg7w==
X-Gm-Message-State: AO0yUKWbT3IzugH2wRgxELlYraWjoDI/bSbxWx39X+zn+ruCTVXG7G8S
        8SJmwyS03dIZofPOalpWw4AehETfIcTo
X-Google-Smtp-Source: AK7set/oaA1PDJqRwnr+9ddJ9Fn3gvAQRJiV5UvQklYIxlrEO+ozSV0fVXlHnRhiSKPq6ZJbqww4VbtQuk6g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a05:6902:185:b0:acd:7374:f15b with SMTP id
 t5-20020a056902018500b00acd7374f15bmr12051059ybh.13.1678316371198; Wed, 08
 Mar 2023 14:59:31 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:02 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-2-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 01/11] libperf evlist: Avoid a use of evsel idx
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
2.40.0.rc0.216.gc4246ad0f0-goog

