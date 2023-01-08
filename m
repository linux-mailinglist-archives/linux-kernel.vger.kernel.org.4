Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CAA6613C5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 07:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjAHGYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 01:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHGYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 01:24:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1181EADF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 22:24:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q64so5638522pjq.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 22:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeoGX28pohH6YTyGGTvoqbUNJvhignnE3xBPpX1iJkM=;
        b=oPpOYvzGEBhoEz7H0UVS3gcV6apwfYI5SqyEAXBIMM2i0CZVkACiJXbX4PeL0h0kw+
         7ufDhbcnKdFJL8ZA6DdJfaFkzvg8ZHoCoXKL3n0sP4UlUBkggg9o5BJkGso6Idvh1p7P
         YNmzdHPDRHEgf7Iw1aIQlPlk3vNzAGNFHhHes/m5V0Uu3VYnMDjJSAcQQLAQPqiDqL8n
         NZj3MbWLlaUSIg8NZCnHnrsUVUJ4S8GMbWhr+IT2NZmJq9UFn0cJ1EH4qZJ2gH+2TMKg
         yhESY87lPfYMASmA1h0/1Hf3xsvKxzsQSFroPnCa2ndPVgfVV1Y/2xQnBFYgEaR0pA2S
         vN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeoGX28pohH6YTyGGTvoqbUNJvhignnE3xBPpX1iJkM=;
        b=tLcrATiIg1uTxqsXzN3zcMfBFq6x8iZIHNlXwwIsnboq3dVg6Vovttm5xXSDgEMvRz
         aXySbvKt86wyNTlZWoCo3yBt1/JBEfvwvTIycuBKPdWp9x4ysWEgTb4oCCkd4ltR+YpT
         vDjxNI9xezdu5bZH6ObDXcfERtLkY4wzBKNIsMOEh9xXBpjoHzaGpFNOnaKeUhCxSpxd
         3ur4Pnk5z45cCvuXIXCsRtecuFQi3Uz9xMbecev4DG+V2kGsjrSR8h2CDZnymE/WoPlx
         dXBynH0PkltImGrWwQo2FUH7EAd/AS9gwT32z/2JhF/XuH5K4yTa3W9xg8t8sJ9r3hW+
         Cbvw==
X-Gm-Message-State: AFqh2kpkrqxhkonkG+N590/rLNOBleoHFA54IlGxUHCzpqUNNi/NdG4l
        fka5F7CQkAdH/OcFYDQk5cMn8w==
X-Google-Smtp-Source: AMrXdXuEN83eo4arhdl41y+r3Sf3C3PBc9q2D2A1PoEVnQEOKl5QVjk3oK4XpcrvDjXvpLztpbNBSQ==
X-Received: by 2002:a05:6a20:d38c:b0:af:a276:2f94 with SMTP id iq12-20020a056a20d38c00b000afa2762f94mr77308581pzb.35.1673159055712;
        Sat, 07 Jan 2023 22:24:15 -0800 (PST)
Received: from leoy-huanghe.lan (211-23-48-221.hinet-ip.hinet.net. [211.23.48.221])
        by smtp.gmail.com with ESMTPSA id s1-20020a63f041000000b004784cdc196dsm3146510pgj.24.2023.01.07.22.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 22:24:15 -0800 (PST)
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
Subject: [PATCH 1/2] perf kmem: Support legacy tracepoints
Date:   Sun,  8 Jan 2023 14:23:59 +0800
Message-Id: <20230108062400.250690-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
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
tracepoints") removed tracepoints 'kmalloc_node' and
'kmem_cache_alloc_node', these two tracepoints have disappeared in the
latest kernel, but we also need to consider the tool should be backward
compatible with old kernels.

If detects the tracepoint "kmem:kmalloc_node" is existed on a system,
this patch enables the legacy tracepoints, otherwise, it will ignore
them for the new kernels.

Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kmem.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index e20656c431a4..50a3df5dc18a 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1824,6 +1824,19 @@ static int parse_line_opt(const struct option *opt __maybe_unused,
 	return 0;
 }
 
+static bool slab_legacy_tp_is_exposed(void)
+{
+	/*
+	 * The tracepoints "kmem:kmalloc_node" and
+	 * "kmem:kmem_cache_alloc_node" have been removed on the latest
+	 * kernel, if the tracepoint "kmem:kmalloc_node" is existed it
+	 * means the tool is running on an old kernel, we need to
+	 * rollback to support these legacy tracepoints.
+	 */
+	return IS_ERR(trace_event__tp_format("kmem", "kmalloc_node")) ?
+		false : true;
+}
+
 static int __cmd_record(int argc, const char **argv)
 {
 	const char * const record_args[] = {
@@ -1831,22 +1844,28 @@ static int __cmd_record(int argc, const char **argv)
 	};
 	const char * const slab_events[] = {
 	"-e", "kmem:kmalloc",
-	"-e", "kmem:kmalloc_node",
 	"-e", "kmem:kfree",
 	"-e", "kmem:kmem_cache_alloc",
-	"-e", "kmem:kmem_cache_alloc_node",
 	"-e", "kmem:kmem_cache_free",
 	};
+	const char * const slab_legacy_events[] = {
+	"-e", "kmem:kmalloc_node",
+	"-e", "kmem:kmem_cache_alloc_node",
+	};
 	const char * const page_events[] = {
 	"-e", "kmem:mm_page_alloc",
 	"-e", "kmem:mm_page_free",
 	};
 	unsigned int rec_argc, i, j;
 	const char **rec_argv;
+	unsigned int slab_legacy_tp_exposed = slab_legacy_tp_is_exposed();
 
 	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
-	if (kmem_slab)
+	if (kmem_slab) {
 		rec_argc += ARRAY_SIZE(slab_events);
+		if (slab_legacy_tp_exposed)
+			rec_argc += ARRAY_SIZE(slab_legacy_events);
+	}
 	if (kmem_page)
 		rec_argc += ARRAY_SIZE(page_events) + 1; /* for -g */
 
@@ -1861,6 +1880,10 @@ static int __cmd_record(int argc, const char **argv)
 	if (kmem_slab) {
 		for (j = 0; j < ARRAY_SIZE(slab_events); j++, i++)
 			rec_argv[i] = strdup(slab_events[j]);
+		if (slab_legacy_tp_exposed) {
+			for (j = 0; j < ARRAY_SIZE(slab_legacy_events); j++, i++)
+				rec_argv[i] = strdup(slab_legacy_events[j]);
+		}
 	}
 	if (kmem_page) {
 		rec_argv[i++] = strdup("-g");
-- 
2.34.1

