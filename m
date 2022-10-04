Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A655F5F3B35
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJDCQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJDCQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:16:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29943DF28
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:16:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a2-20020a5b0002000000b006b48689da76so11885250ybp.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=HP8sEZI7Emeer8Gpo0u0RqVNXzqW3axisWvdt479D+w=;
        b=Ml6u7c4iPGaHKe5dlAcqKCA1eGbQy9o/sYmC4JFc5Qg02T7C56XjCqtT4kZE3VTWp5
         mjVE+m0SOuw7GPHkIkOpMjVLaa1J0VjO3a+9yBLLtwhPF5v00PN8CgDb3sWVxJEUPvy9
         twFjchFCGM2unnAQAQYilIWWnlUbZpYJpUz/F71smURaekVWp1bjmuzl5IrE3UDeSgkH
         7vKHoS0g8ukgq47WHm+V/K8/QmMvIUgMAEymY0zEYLp6vtrktY0mamX9aqZAOTYvSEVn
         KfonLjaFN07joo0ITcCVOpndM26ZU8CheihPcYhUGSL5bn00aN/GNyxKWV2j7/dgZAC8
         W9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=HP8sEZI7Emeer8Gpo0u0RqVNXzqW3axisWvdt479D+w=;
        b=oSZdwpKXj/94bgDxNEaL68/i4Dlz7x/cKrzO2YeZ473uP7kTNJ7+jIYo4bHcfNK+Gy
         nFpnsG3UpN7I5RxgLrEzjjlOGs/olcZfd1pmSdBCagay1V0XRKBkvaJQaIcKxGCSAcUH
         b5R5+1NQNDI2FoSJ2AOW+IvRYrrEsMKJ/dx1I4h8Leys2HCwRjId5b+ngU4h0kB1sW7v
         G2jkpWWD6Tqz3tTOC5uvwWcaAgNhZbVtXyovrBKShn7ODiCgPCUnCngEUXrAIXkim4Tb
         z3HrGI4bguGPgcaiA3Ffa5Dwfd1ya5UL8/7fWC4QzuEI/Vh9bZgtkwMJOCKySqaCwj0Q
         51kA==
X-Gm-Message-State: ACrzQf1DKsTvrkabouOX/Elb0PDWwhV72qLkYgCdYHXq99heaIhbIPAB
        8J9acqDRfbNJIYT2TC98yubcGct1juMm
X-Google-Smtp-Source: AMsMyM7D+Nxaya/Kh39uYN9rJ3+UvaGMx8vYBJ4Z6REA17LIajsE5bi0vIHv1AnyP7Ng0TD5d8fuD9D0+xIT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a25:8a10:0:b0:6ae:af0d:65e5 with SMTP id
 g16-20020a258a10000000b006aeaf0d65e5mr23142640ybl.610.1664849787739; Mon, 03
 Oct 2022 19:16:27 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:53 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-5-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 04/23] perf metrics: Don't scale counts going into metrics
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

