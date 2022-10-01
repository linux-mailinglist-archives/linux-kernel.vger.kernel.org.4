Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E985F1A25
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJAGHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJAGG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:06:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADB5130F22
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:06:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3576c47f204so14020277b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=HP8sEZI7Emeer8Gpo0u0RqVNXzqW3axisWvdt479D+w=;
        b=Zo86w1JcZP0SwLmLGNZbnAfu15T7mKvR8zvQGA12p2mpV8zMZlYOthL30w2p7LZ1Ln
         8fxbzYboFouTztwetukz42wpV7hzW0Jg6p/QexYaRBvg95zi1oST81k30zEX7YuSqTyc
         eSilxCudAE8hDEk8MTVLrxT9KKD8x/v8Q+sQH/Yxe3APtq1Nq15RC9cDAgVAbCY7HP2E
         Acj+ZfWTB1EUhhLm497H4xp/53VA/L+jHNCzCzxn/j2ZJj5aIX1IWB6KJvSZXP3KWHci
         YJNuvXrl9vPYaakLHNPYNSkUN+5anpC5qirEs9fLLSaHTyBTFd4T6/2FxhVylR+ZKJuz
         qakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=HP8sEZI7Emeer8Gpo0u0RqVNXzqW3axisWvdt479D+w=;
        b=kn3DlFArcQSu3nznQ4EZz/pRnB5ztQaG0lrXsynr67HPB5HjSAQCWL9Uu6AMZsnYgi
         J4lVgbtnE7W2wdTR4TTFmPuWZ3XTic2r/eKoZ8GcSDzAOLGzQ8cmum2QIj+AK6ZJTsT3
         WrYNgmcn6k6wMH3m2/e6aUdP2rbvx3K9zTa8ZONQ+r/vLWWOTqQoc5G5e8VQQwt+aolw
         kmfTkYANpdbpCFd1jyebYEeTBcvNEiK0n3U8IUZIhgsicTfSp4ZKMWwUVG0kkZkeGCSG
         S5mzKsBUamV8p5GyL4jgXGniT064d0QA9ZI1751REgGHXgRYfEuxfBPQf+LaKa6MoAPP
         jvJw==
X-Gm-Message-State: ACrzQf3sP487Lw7yJyxYqmEetvsTksyOM+Mw0MImk0BKDW1AdnUFxlQC
        OBFXpcxa4mocTMUxo+PWKt0J/eNwQOa4
X-Google-Smtp-Source: AMsMyM4GM2AzwBt4Mm2uplMShAXDEOgSI9+FipCwaQwrAVwq/yKgi0tGjWFWWd9Q2eklTv7s5Wd8EtSwp+7E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:de60:c6ac:8491:ce1e])
 (user=irogers job=sendgmr) by 2002:a81:498f:0:b0:355:bb57:f988 with SMTP id
 w137-20020a81498f000000b00355bb57f988mr8437612ywa.298.1664604410478; Fri, 30
 Sep 2022 23:06:50 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:06:17 -0700
In-Reply-To: <20221001060636.2661983-1-irogers@google.com>
Message-Id: <20221001060636.2661983-4-irogers@google.com>
Mime-Version: 1.0
References: <20221001060636.2661983-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v2 03/22] perf metrics: Don't scale counts going into metrics
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counts are scaled prior to going into saved_value, reverse the scaling
so that metrics don't double scale values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 9e1eddeff21b..b5cedd37588f 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -865,11 +865,16 @@ static int prepare_metric(struct evsel **metric_events,
 			if (!v)
 				break;
 			stats = &v->stats;
-			scale = 1.0;
+			/*
+			 * If an event was scaled during stat gathering, reverse
+			 * the scale before computing the metric.
+			 */
+			scale = 1.0 / metric_events[i]->scale;
+
 			source_count = evsel__source_count(metric_events[i]);
 
 			if (v->metric_other)
-				metric_total = v->metric_total;
+				metric_total = v->metric_total * scale;
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
 		if (!n)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

