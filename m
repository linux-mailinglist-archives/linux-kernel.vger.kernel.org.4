Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528306613C6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 07:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjAHGYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 01:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHGYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 01:24:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32B1EADD
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 22:24:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so9551489pjj.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 22:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2N5suS0GnTvzlWBM80TjepEKKn3USjGIlHtbbXe7Gk=;
        b=X2VGEwKYZShP9O19V2XqqSk4PNLIVEeSnmbh/ACR/NlfWmKsp3G38aCMqSap1nVK2a
         FQo1XeubWVQ6TNNHe3InEh2m6rL9B+FeyrtmlSI3jsgHZ/0DFTPFvnYDd9ghed+9jvG/
         jbQwcHrz26v91CmbFVV3UHpdfHMh7GNTJUKLpNQ55Yvemk6cVGG6AWriz1wgNvgQPHs3
         N5PQS+VCO8/fXwp3Ybf17MBdxtQANLpQrc0j5UEWg2loYiZgZrpyqr9XlYDFzSIJZ4ri
         gczowKNlErg+tmy5A05BWY9dXmvpa64N/+Tqb6aoWjzTKPdTITvi6Q68KZ7kyvG/QJAT
         oniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2N5suS0GnTvzlWBM80TjepEKKn3USjGIlHtbbXe7Gk=;
        b=khgRjNyQT19d6as74gghIOcKNgLBJf6nKJZCuHz6wTak3B08yh9GBJ+LmCMGBUdyZM
         JV59kO5WeiND6m+0Hvs1oVJTyCr0Jt6M5isQjCB8EUDqKB7gd2Ck5FervNuC/3HZ69gN
         d+ps8io1ZO+tzD5TivpRDQsEgvGaJ48NAEKpFt0fLr7PvN7yxttP9dgU6Wm1D9+XmezR
         sfElrGs0caO66ewn1Yjzukf/V4WjmmQkqErCXmqo9ToHZKIOc5Utksvyr96MuTG9OfyI
         4YzxvG9nP9kADCpPRu1ncZRLKWaWhhf/jzdDMUYk2HI1xOhdUZScX3lqfKOaW0TbtI6F
         hcBw==
X-Gm-Message-State: AFqh2kqFZZEMKcuyLUrOGVW0EVU4ZslTiZwVN9e1yrRSved+EtPWBnMD
        IeSB31c83wJ/pGreD/XcW3kHow==
X-Google-Smtp-Source: AMrXdXsrOBXEVSBC2PklQZBZlxeGCPQ0AMTx1UQywgIJ0EfG3WNgvCI32iKiRlULuaomDqfjPuvdCQ==
X-Received: by 2002:a17:90a:d345:b0:223:f60e:87b5 with SMTP id i5-20020a17090ad34500b00223f60e87b5mr67536167pjx.20.1673159059912;
        Sat, 07 Jan 2023 22:24:19 -0800 (PST)
Received: from leoy-huanghe.lan (211-23-48-221.hinet-ip.hinet.net. [211.23.48.221])
        by smtp.gmail.com with ESMTPSA id s1-20020a63f041000000b004784cdc196dsm3146510pgj.24.2023.01.07.22.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 22:24:19 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] perf kmem: Support field "node" in evsel__process_alloc_event()
Date:   Sun,  8 Jan 2023 14:24:00 +0800
Message-Id: <20230108062400.250690-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108062400.250690-1-leo.yan@linaro.org>
References: <20230108062400.250690-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of
tracepoints") adds the field "node" into the tracepoints 'kmalloc' and
'kmem_cache_alloc', so this patch modifies the event process function to
support the field "node".

If field "node" is existed by checking function evsel__field(), it stats
the cross allocation.

When the "node" value is NUMA_NO_NODE (-1), it means the memory can be
allocated from any memory node, in this case, we don't account it as a
cross allocation.

After support the field "node" in evsel__process_alloc_event(),
evsel__process_alloc_node_event() is duplicate with the previous one,
so removes evsel__process_alloc_node_event().

Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kmem.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 50a3df5dc18a..8ae0a1535293 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -26,6 +26,7 @@
 #include "util/string2.h"
 
 #include <linux/kernel.h>
+#include <linux/numa.h>
 #include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -185,22 +186,33 @@ static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *s
 	total_allocated += bytes_alloc;
 
 	nr_allocs++;
-	return 0;
-}
 
-static int evsel__process_alloc_node_event(struct evsel *evsel, struct perf_sample *sample)
-{
-	int ret = evsel__process_alloc_event(evsel, sample);
+	/*
+	 * Commit 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA
+	 * version of tracepoints") adds the field "node" into the
+	 * tracepoints 'kmalloc' and 'kmem_cache_alloc'.
+	 *
+	 * The legacy tracepoints 'kmalloc_node' and 'kmem_cache_alloc_node'
+	 * also contain the field "node".
+	 *
+	 * If the tracepoint contains the field "node" the tool stats the
+	 * cross allocation.
+	 */
+	if (evsel__field(evsel, "node")) {
+		int node1, node2;
 
-	if (!ret) {
-		int node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu}),
-		    node2 = evsel__intval(evsel, sample, "node");
+		node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu});
+		node2 = evsel__intval(evsel, sample, "node");
 
-		if (node1 != node2)
+		/*
+		 * If the field "node" is NUMA_NO_NODE (-1), we don't take it
+		 * as a cross allocation.
+		 */
+		if ((node2 != NUMA_NO_NODE) && (node1 != node2))
 			nr_cross_allocs++;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int ptr_cmp(void *, void *);
@@ -1369,8 +1381,8 @@ static int __cmd_kmem(struct perf_session *session)
 		/* slab allocator */
 		{ "kmem:kmalloc",		evsel__process_alloc_event, },
 		{ "kmem:kmem_cache_alloc",	evsel__process_alloc_event, },
-		{ "kmem:kmalloc_node",		evsel__process_alloc_node_event, },
-		{ "kmem:kmem_cache_alloc_node", evsel__process_alloc_node_event, },
+		{ "kmem:kmalloc_node",		evsel__process_alloc_event, },
+		{ "kmem:kmem_cache_alloc_node", evsel__process_alloc_event, },
 		{ "kmem:kfree",			evsel__process_free_event, },
 		{ "kmem:kmem_cache_free",	evsel__process_free_event, },
 		/* page allocator */
-- 
2.34.1

