Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811B56C096C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCTDma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCTDls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:41:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67922CBC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:40:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i11-20020a256d0b000000b0086349255277so11809269ybc.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283635;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Py8U8PqFwPIRVvHHDItGJJ+sTjfy4CxHiyg06BPRgeo=;
        b=n+gKE63K3SKDTQo/iu8pU9gFXI2PAJbYBkvXhYMxrv7G3p+hiuhE4hXChTy3JqmfXu
         pKDQKBWo91txB3O0gHkwCYsUDlg4BXrQiJXJkx7HWp/SSg1q00qidcrDQ/BbqGBhuTL1
         UvdWPY37uZ9xexSslCjA6IkxEDS45AHDt4NOfm8JZochOhauqt97OWLrYRa7gVhruy1g
         RpVUeYdk40b9OxcCBqJaYr0tcLGmaP9OGlLz8G5jH2rcOXPq0Ekj+DUBOTH523FygzT9
         4cN7qK1mnLlwld/+/3nDFJFiJxGak8rLgLaoCaz5kQxyUgZ0E2QmhR1r92tIEQXe2DNy
         rv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283635;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Py8U8PqFwPIRVvHHDItGJJ+sTjfy4CxHiyg06BPRgeo=;
        b=nwzTQsnRE/ydqZey4O9qVLl8bD6vAUKML6KKpM1uYlsE4ueoSzJdVbfdgI5oBpvqW8
         snmPgdamXxLSKXTUDenwGV6JSeKZQ43Vj/mZlOtMy2oBSfyKwnz4wR1X+2aoWzLyJBs5
         QVFnbnx0DZi3AECTtAGjIdc/D206qzIfiFB0jw02+JAeZd4LEh9maS8MSdCCZTaSAx1m
         WgbyFsIBhm+Gft7dEvbWv0yz31o3Di/btGZuyeUokpGPpmI6jTdT6tmIaVMy1atSfRXD
         nYVDQOomNzLfgO8s9X2hXXiIkJ6y5lyoCwFWa0UqDT29o9bE2an5gLU8ZAHzduZEqP5t
         AiCg==
X-Gm-Message-State: AO0yUKWAnCTGIJ3QMgvc3q2rJr6Iy6vnYZaPUkWWVAr4O9fX8Zn9IPFu
        MpOw+Ab6y1Vpn8VPyWhnoCERiHPxdsdd
X-Google-Smtp-Source: AK7set8vSqZsRSfY53oCnbMUg7lQPOwN0CXJrzMHSihbyBNkzmqp/4+dNcN0A9xOYeEdkDXhOjRr9HhciVv9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a25:8f8b:0:b0:b68:7b14:186b with SMTP id
 u11-20020a258f8b000000b00b687b14186bmr2946840ybl.1.1679283635105; Sun, 19 Mar
 2023 20:40:35 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:38:03 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-16-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 15/22] perf test: Add extra diagnostics to maps test
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
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
2.40.0.rc1.284.g88254d51c5-goog

