Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1028B69008F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBIGpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBIGpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:45:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8148BFF1E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:45:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i17-20020a25bc11000000b007b59a5b74aaso1078190ybh.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aYA62UM7iNvAalHymUv4OGhwL/goVRk/xLdwvIuRrY8=;
        b=MMP6r2RdnTh69WtQF55ZH+zjroKR30J8jZ5jVsIaMXCX4TG2ndbpu4toNWm+rH2Inu
         H3mZtvfKGcZi+1JGFSWKamBVthAdjtyzSdscxxzUni0071VP9Dw96QV8Up8jRPxkBTGQ
         f3kWHgkdVMWOmzbZNLWmiy3ThzdasvoZ53qRcF3S7FGq1RUjJmIkdMCWKnGygZjcfNXL
         ZCoBxKNsIvQR/JKFP08PfSb2ldoZyv/ALjGWkkMWNUdVdbnGFgL7rTP7dTzXYFNQMWiq
         wY2/ze/L4lq6MYAN0rcLVR7tYQbn/7R8dEM5hnPa8WGki3tQZSQpd2aQ5CP6OlPZdHmj
         PsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYA62UM7iNvAalHymUv4OGhwL/goVRk/xLdwvIuRrY8=;
        b=SDHCvNmrRV6Wfi9eVrr8Bi8Btmff7iHPtgxQyAwNhXZJsiHNoIEvdTqwqaomPmRqXT
         1xeay5OPN345inD3eGWgr+vFNdYD5jOvyQ+vqqaw8K0o6HVOXqOAHeEG4ZHokM83aiKy
         xwm9mzm4YUeX3/nmlsfkBesSgvpeboFzifQljEw8wc8EZV2vjikmTRJAFuwc5AO/zKt6
         gA/xu/Y08EUh9KAXTFzxU5s4Yk6i8xrGCMEK3gnqz965opaWLymxMCUZ/ufmQrPqbcd0
         sK1I77FQHHeiboZdkwHN50AzQGoAyVtrNbWhY6AgeP8XUrAqGDKNkYFh+97q8IDEc1O5
         orZA==
X-Gm-Message-State: AO0yUKV/6qfJNamJjfPM6nj0De/ujdnhyR8z9DF2tzmsKpj0vc1hkWpS
        JYVM3SkFYdSSRSfvUxalQ9L2viAY+Jh6
X-Google-Smtp-Source: AK7set+bdzgZW3i0eyMzB8UjNs16FKUeVxGDvyk0dGd+ARkOzBPZZasiKBTZiO1/t6ZzZbNQOMhtazbI6C6L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d338:d214:571:e56b])
 (user=irogers job=sendgmr) by 2002:a05:6902:54a:b0:8bb:dfe8:a33b with SMTP id
 z10-20020a056902054a00b008bbdfe8a33bmr22ybs.9.1675925099446; Wed, 08 Feb 2023
 22:44:59 -0800 (PST)
Date:   Wed,  8 Feb 2023 22:44:47 -0800
Message-Id: <20230209064447.83733-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v1] perf stat: Avoid merging/aggregating metric counts twice
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>
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

The added perf_stat_merge_counters combines uncore counters. When
metrics are enabled, the counts are merged into a metric_leader
via the stat-shadow saved_value logic. As the leader now is
passed an aggregated count, it leads to all counters being added
together twice and counts appearing approximately doubled in
metrics.

This change disables the saved_value merging of counts for evsels
that are merged. It is recommended that later changes remove the
saved_value entirely as the two layers of aggregation in the code
is confusing.

Fixes: 942c5593393d ("perf stat: Add perf_stat_merge_counters()")
Reported-by: Perry Taylor <perry.taylor@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index cadb2df23c87..4cd05d9205e3 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -311,7 +311,7 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 		update_stats(&v->stats, count);
 		if (counter->metric_leader)
 			v->metric_total += count;
-	} else if (counter->metric_leader) {
+	} else if (counter->metric_leader && !counter->merged_stat) {
 		v = saved_value_lookup(counter->metric_leader,
 				       map_idx, true, STAT_NONE, 0, st, rsd.cgrp);
 		v->metric_total += count;
-- 
2.39.1.519.gcb327c4b5f-goog

