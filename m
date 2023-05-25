Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CEF710605
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbjEYHMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbjEYHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:12:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02198E4D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83fed50e1so591511276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998721; x=1687590721;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNJ0JSFhRR08dujS92J3UXg3QUJTwNG/xlkH48LcHmA=;
        b=eJ/aqIq03f8tnjeZ1MgXCFXYAruTatREHTYsJ/irY7WETisT03N8hO8dtHNib2rzYc
         7xMAw130VdlBKAgXT8sSPRy2MydV77sY5FKwBUGG1EX3+KqBG2u0aROkvlHXmfo9cSo3
         FgzowShBJhYjRp7w1E06t52OpnHrOPXV4Royrom02WoyMpxBLxFsq/gFqYs1i97f2Pgs
         uwBe3KSWh/a8VUAj7K7jgbbkwmKMPAtBEEeAcHJx3FXsYl0H3UWwL4p60QmGnGiTgvKt
         wM39zlSA8ArutNp1bRi6+ObrcQ4yo0YqBdWFTjISsybgBsNXX00xlpHU6Bs2fltA2CbX
         oKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998721; x=1687590721;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNJ0JSFhRR08dujS92J3UXg3QUJTwNG/xlkH48LcHmA=;
        b=hJ0jQZmbpmrKZh2RcSeoM6PPly8c2SP3ybuT8NsRR7bBSLqmyZ858hxClcqxQjrTKV
         CUzkKInIE1Kv2gjGCFRR6sbUdzTSO1q16fAjVfOvNkSUQbpQurGAqWFTNV93ZTzuTpcb
         HcbShFJUDxahIviEt6H1zaEH17+nCp5xVC2dfXpBUUZ7JCAMZ4XmLtuDmHhCKavmrJBk
         mk+akfTA4ofhO6KytXW7ye0BrpgrdDyNWFFRB0z1+NcC8R292q9rhRKb+kBnUY42NWKI
         /qPjDzU6dNfvG3iK6gSfk89MtB+5l/JF7m+lOjZEtgPtbUf7KkdfFhkysdEjThvVv3nW
         R6XQ==
X-Gm-Message-State: AC+VfDy/u3zgeG7SLrKQyZIbz9lPgCvfMhmivuynwGMxwKb9yvaC7tFk
        XNnJ5S6ATLDAYZ0fxlQVfqGKvGHSyKsE
X-Google-Smtp-Source: ACHHUZ6BmyCoXHTHVixcW18Nnib7Ltq6q9GOYchu1cJtE81jB75NnGPdMAhphoAQEyMa1J6SmiKEB9AxzIzS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:6584:0:b0:ba8:381b:f764 with SMTP id
 z126-20020a256584000000b00ba8381bf764mr1454787ybb.3.1684998721126; Thu, 25
 May 2023 00:12:01 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:18 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-2-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 01/16] perf header: Make nodes dynamic in write_mem_topology
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a large static array, dynamically allocate the nodes avoiding a
hard coded limited as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2dde3ca20de5..80593ed8c79b 100644
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
@@ -1426,16 +1428,24 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
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
+				free(nodes);
+				closedir(dir);
+				return -ENOMEM;
+			}
+			nodes = new_nodes;
+			size += 4;
+		}
 		ret = memory_node__read(&nodes[cnt++], idx);
 	}
 
 	*cntp = cnt;
+	*nodesp = nodes;
 	closedir(dir);
 
 	if (!ret)
@@ -1444,8 +1454,6 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
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
2.40.1.698.g37aff9b760-goog

