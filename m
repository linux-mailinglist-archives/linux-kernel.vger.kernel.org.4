Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43B6D6E90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjDDVBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjDDVBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:01:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1CD524B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:01:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54574d6204aso335133227b3.15
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680642061;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1c3l5WcHyBwFdVydt7Y8S6cpo64GHAMEcTV54xz6om8=;
        b=rLnTcOkdWMbNqcWYqHLw/DvOWhFFp9oUaU3KqHTuQv1jGec4+kwNH10xJt32XTLpDn
         JQCl2LGCm2xs6Gvjv+RhmHkVQiDzC4RUsKVHc0z+POv9K6noDzosaKT11VTmHMp0Foi6
         BU61Ur+4pBUYDufGOF47YJhcM46YSNNEyub6tlpsWhe2p/CBD3vHYC4QhDsYUnHAr7Rj
         K0zGWV//IJlVfe7Qk3EyrWC3UFQztXIkGARCXc0a/GPNPQH7Gzi6RmxDhSCpIutiFdTq
         G6v45goC/UBtwRvNEAGBZTZBJB4TdHh+JDDx0c7dnQmw7rp962ql9wuWakgzSG15aI27
         5tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642061;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1c3l5WcHyBwFdVydt7Y8S6cpo64GHAMEcTV54xz6om8=;
        b=q8lNvD33droJWhHOeR8B7LI7Vk7BtYppq/ta0X3K6IE0O1Ux7OjdghwhyGIPVSVmvh
         fXw9YCmY0e9kOhRlbs6AmNI59a611fFhsfEMALFVu4O4kO+uGe8e0AIK0Idh3v4q1pFl
         PIm/kmzGt7mh5dof92sgjdzy4QaZYMtdOG+vT8y7rb8lBNN7DlYg8tk5DaUi+loZAQYw
         2Jdw3YLgWJrLXuYg7OIw5jZO5iBMw7B4iiwbDR7Cpwl4ls8XCxIRZwB2HfepZPR8znPH
         296UF/O0empGk7h+kGWhMa7jNn0OMvRO91ryvVozOl+xPdxjqu99h0KEQlr7uW7gbMHb
         pzTA==
X-Gm-Message-State: AAQBX9cIWDxCEPFQnNi8nggDX6fL2iZM4XasQpUGlHe8ebNCW5y8f3ym
        bukUERY35GvxrP017Ghblo+2robjOXH2
X-Google-Smtp-Source: AKy350YgiPvYJgox6ETVp46YUTQcYLa80zfYiTpxh4w3p0nAszCU5XolwTiMh5JypXuimqmnUQfv+xCow0RY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a25:d0cf:0:b0:b77:be38:6406 with SMTP id
 h198-20020a25d0cf000000b00b77be386406mr2295850ybg.9.1680642061207; Tue, 04
 Apr 2023 14:01:01 -0700 (PDT)
Date:   Tue,  4 Apr 2023 13:59:47 -0700
In-Reply-To: <20230404205954.2245628-1-irogers@google.com>
Message-Id: <20230404205954.2245628-6-irogers@google.com>
Mime-Version: 1.0
References: <20230404205954.2245628-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v6 05/12] perf test: Add extra diagnostics to maps test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dump the resultant and comparison maps on failure.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/maps.c | 51 +++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index fd0c464fcf95..1c7293476aca 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include "tests.h"
@@ -17,22 +18,42 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 {
 	struct map_rb_node *rb_node;
 	unsigned int i = 0;
-
-	maps__for_each_entry(maps, rb_node) {
-		struct map *map = rb_node->map;
-
-		if (i > 0)
-			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
-
-		TEST_ASSERT_VAL("wrong map start",  map__start(map) == merged[i].start);
-		TEST_ASSERT_VAL("wrong map end",    map__end(map) == merged[i].end);
-		TEST_ASSERT_VAL("wrong map name",  !strcmp(map__dso(map)->name, merged[i].name));
-		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 1);
-
-		i++;
+	bool failed = false;
+
+	if (maps__nr_maps(maps) != size) {
+		pr_debug("Expected %d maps, got %d", size, maps__nr_maps(maps));
+		failed = true;
+	} else {
+		maps__for_each_entry(maps, rb_node) {
+			struct map *map = rb_node->map;
+
+			if (map__start(map) != merged[i].start ||
+			    map__end(map) != merged[i].end ||
+			    strcmp(map__dso(map)->name, merged[i].name) ||
+			    refcount_read(&map->refcnt) != 1) {
+				failed = true;
+			}
+			i++;
+		}
 	}
-
-	return TEST_OK;
+	if (failed) {
+		pr_debug("Expected:\n");
+		for (i = 0; i < size; i++) {
+			pr_debug("\tstart: %" PRIu64 " end: %" PRIu64 " name: '%s' refcnt: 1\n",
+				merged[i].start, merged[i].end, merged[i].name);
+		}
+		pr_debug("Got:\n");
+		maps__for_each_entry(maps, rb_node) {
+			struct map *map = rb_node->map;
+
+			pr_debug("\tstart: %" PRIu64 " end: %" PRIu64 " name: '%s' refcnt: %d\n",
+				map__start(map),
+				map__end(map),
+				map__dso(map)->name,
+				refcount_read(&map->refcnt));
+		}
+	}
+	return failed ? TEST_FAIL : TEST_OK;
 }
 
 static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
-- 
2.40.0.348.gf938b09366-goog

