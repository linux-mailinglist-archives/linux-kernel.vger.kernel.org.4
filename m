Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418A4712C80
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbjEZSeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242496AbjEZSeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:20 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E851CE62
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:12 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-255dfed764dso1394438a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126052; x=1687718052;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebDmAKcMgjMG509wnFyrTUPwJyUM0h3NbQ8A7cysfQ0=;
        b=OV1TvpXGpGm5MLs6Mh/URj5q11pFxOE0Pq/aTWDMR9PFQN1iMItLpAMs3hSe5FPK6B
         TCrvq4wBk0Bt6Ro0RPhK4ENdsqMhutdlHfG4j2n6GJQnkvpVr6IBB0qujDx+I6VJ1wU3
         R5i+XfuZp7r05tkVfaMfD1mU1PEdnBXufxosZghTLlAnmbnHSm3UrrCC/ji6wFQ+LrjP
         1xz+2nv0nqllptmrqwhYDEAekiiNNuB6OE8UQWvtRkzb486aVxo3isWty86FkFB0zUVY
         iGLWO5vHReTy+cvNcwofn4j4NaUofXC1GTs8lUQvcBYqWp7ZmUPbe78t34xNThF9ExWv
         S/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126052; x=1687718052;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebDmAKcMgjMG509wnFyrTUPwJyUM0h3NbQ8A7cysfQ0=;
        b=JTmfBlozl0Z74VQZBGzo84QKPvGiwAnI/JCAioQnhmuKCcI383EmSaO+BjXItpRkjn
         GvrB3gTJJ10v5Jb0H6co9St1CCbU8V7Rc0T8jLINKpWynh1kf5BB1dC3joLD0p9P4hQ6
         gxHQSaVq3iVEflJ8285erO7YG8M6OE/VxEK9bZzg6UMxnqM38Ot4Xg2zuw7UXikBqnnO
         RXRiirJ+Txiv9ayuGj/ujojdgI6CXMXfNoZN54WvjdvlUFgObptqvDWdfBY3P4XLeenS
         Xu6JeOwoZthz4iDeKk3FzX4IQL97s77UkSfPqiLQcMqcOzKU1lV61jg/qfEZsnQfYdn/
         tfiA==
X-Gm-Message-State: AC+VfDznoegQR6P3FnBaIkrDA+jzjvKzlo7tiqWM5isxPELOaMyQI0Zp
        jUpBqmYxZPPPN65Yk+ft0++1MJ8kpU8H
X-Google-Smtp-Source: ACHHUZ7/hC7A5d3iCEZFXKr8J780KUcDmxhUabVPrKmWkXgja76tEtD0TOBYgcVxSXpNsAWc4fIgyEln64Zh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:902:c948:b0:1a9:baa8:359f with SMTP id
 i8-20020a170902c94800b001a9baa8359fmr890440pla.6.1685126052431; Fri, 26 May
 2023 11:34:12 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:46 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-2-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 01/16] perf header: Make nodes dynamic in write_mem_topology
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a large static array, dynamically allocate the nodes avoiding a
hard coded limited as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 41 ++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2dde3ca20de5..f3c0cd8f6244 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -24,6 +24,7 @@
 #include <bpf/libbpf.h>
 #endif
 #include <perf/cpumap.h>
+#include <tools/libc_compat.h> // reallocarray
 
 #include "dso.h"
 #include "evlist.h"
@@ -1396,13 +1397,14 @@ static int memory_node__sort(const void *a, const void *b)
 	return na->node - nb->node;
 }
 
-static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
+static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 {
 	char path[PATH_MAX];
 	struct dirent *ent;
 	DIR *dir;
-	u64 cnt = 0;
 	int ret = 0;
+	size_t cnt = 0, size = 0;
+	struct memory_node *nodes = NULL;
 
 	scnprintf(path, PATH_MAX, "%s/devices/system/node/",
 		  sysfs__mountpoint());
@@ -1426,26 +1428,32 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 		if (r != 1)
 			continue;
 
-		if (WARN_ONCE(cnt >= size,
-			"failed to write MEM_TOPOLOGY, way too many nodes\n")) {
-			closedir(dir);
-			return -1;
-		}
+		if (cnt >= size) {
+			struct memory_node *new_nodes =
+				reallocarray(nodes, cnt + 4, sizeof(*nodes));
 
+			if (!new_nodes) {
+				pr_err("Failed to write MEM_TOPOLOGY, size %zd nodes\n", size);
+				ret = -ENOMEM;
+				goto out;
+			}
+			nodes = new_nodes;
+			size += 4;
+		}
 		ret = memory_node__read(&nodes[cnt++], idx);
 	}
-
-	*cntp = cnt;
+out:
 	closedir(dir);
-
-	if (!ret)
+	if (!ret) {
+		*cntp = cnt;
+		*nodesp = nodes;
 		qsort(nodes, cnt, sizeof(nodes[0]), memory_node__sort);
+	} else
+		free(nodes);
 
 	return ret;
 }
 
-#define MAX_MEMORY_NODES 2000
-
 /*
  * The MEM_TOPOLOGY holds physical memory map for every
  * node in system. The format of data is as follows:
@@ -1464,8 +1472,8 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 			      struct evlist *evlist __maybe_unused)
 {
-	static struct memory_node nodes[MAX_MEMORY_NODES];
-	u64 bsize, version = 1, i, nr;
+	struct memory_node *nodes = NULL;
+	u64 bsize, version = 1, i, nr = 0;
 	int ret;
 
 	ret = sysfs__read_xll("devices/system/memory/block_size_bytes",
@@ -1473,7 +1481,7 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 	if (ret)
 		return ret;
 
-	ret = build_mem_topology(&nodes[0], MAX_MEMORY_NODES, &nr);
+	ret = build_mem_topology(&nodes, &nr);
 	if (ret)
 		return ret;
 
@@ -1508,6 +1516,7 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 	}
 
 out:
+	free(nodes);
 	return ret;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

