Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D3C6F76C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjEDUPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjEDUPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:15:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C4D13C08
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 12:59:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f6bef3d4aso1896142276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683230297; x=1685822297;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uf90B0DNuv78Zar9yEbDcO4xMMRYhft3uy0mg3u42Sk=;
        b=ioOb9f8iEjks0QT02JpIuAoIxmM8aIVDMbInwUbFuMQodvXsBYfLNMT8TQgMJs/N2D
         eBeH9IGagWlYB7p1fSoh3he0JyQ+fuJb/BCG05vMf3cRsNlbLx3oV255q8aK4sKeXnd1
         8xFoGpAmL+TllBa13NtQLaiY4bHDUmClvLjURDHLl92MUSdXTHYPT0kAw3j5Qiseod9g
         xleV5V1nBGfmb6MNdXc8TAWD2q/bC4wcn5Pd5225Yvh0+FFmJpUUPBtdOcpZankkGcGC
         uWtSR+lMuPyptKPskJ0qyadc923IqU0FAGIkiwMBcboDMRWBudtw9BhhEInjVBYn46q0
         NNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683230297; x=1685822297;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf90B0DNuv78Zar9yEbDcO4xMMRYhft3uy0mg3u42Sk=;
        b=VnDaDTWtisXqzuw80dJwFSOkuvmFuqRomkyVwUsp22WiT5wICceFFl3xoIhFayz61d
         XUey7c1+lUccwrmKrmAw8VTo/jArXv+gnCQDMVkCbJdLwSfOa7hYHN1FrVQcfh4GgfHG
         yolyZR+Jpa1Nmm/vM6qElSRNFT3FiFQCbp6m67lAKz+XyV43L2hl3BKBC0o9hymlYGKD
         66TZ/V5PUHuYYvdhM+/wrdrINJFHK02e8z9MesjxORknz2M9U5uO4I7iuNLr1sD51drQ
         TxiK3MDqVHLGXMPMljmbBsdjr6XBtznvoP3Il3TxgVJSP+C8TIZR5oypkolHuqBENMCv
         jMoA==
X-Gm-Message-State: AC+VfDx3bVNmPYysXRjgQapEa8Mr+D3zE2C3EV5D4Sg+dlF+TjDGQTM/
        BzUKX8vPijC4i6/g4exddFcZ44tkfKiN
X-Google-Smtp-Source: ACHHUZ5D6oBfEWsjyxziFTJx5Gel0+EXHSwY0SgDL1ePNM78CRemBZVMsSyesUUrhKYz5oE4MEut4UEFSWec
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3367:2fed:395f:6f64])
 (user=irogers job=sendgmr) by 2002:a25:52d5:0:b0:b9a:7088:d95 with SMTP id
 g204-20020a2552d5000000b00b9a70880d95mr666862ybb.0.1683230297329; Thu, 04 May
 2023 12:58:17 -0700 (PDT)
Date:   Thu,  4 May 2023 12:58:03 -0700
In-Reply-To: <20230504195803.3331775-1-irogers@google.com>
Message-Id: <20230504195803.3331775-2-irogers@google.com>
Mime-Version: 1.0
References: <20230504195803.3331775-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Subject: [PATCH v1 2/2] perf stat: Document --metric-no-threshold and
 threshold colors
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the threshold behavior for -M/--metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 29bdcfa93f04..ff71399db738 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -353,6 +353,15 @@ small group that need not have multiplexing is lowered. This option
 forbids the event merging logic from sharing events between groups and
 may be used to increase accuracy in this case.
 
+--metric-no-threshold::
+Metric thresholds may increase the number of events necessary to
+compute whether a metric has exceeded its threshold expression. This
+may not be desirable, for example, as the events can introduce
+multiplexing. This option disables the adding of threshold expression
+events for a metric. However, if there are sufficient events to
+compute the threshold then the threshold is still computed and used to
+color the metric's computed value.
+
 --quiet::
 Don't print output, warnings or messages. This is useful with perf stat
 record below to only write data to the perf.data file.
@@ -389,6 +398,12 @@ For a group all metrics from the group are added.
 The events from the metrics are automatically measured.
 See perf list output for the possible metrics and metricgroups.
 
+	When threshold information is available for a metric, the
+	color red is used to signify a metric has exceeded a threshold
+	while green shows it is hasn't. The default color means that
+	no threshold information was available or the threshold
+	couldn't be computed.
+
 -A::
 --no-aggr::
 Do not aggregate counts across all monitored CPUs.
-- 
2.40.1.521.gf1e218fcd8-goog

