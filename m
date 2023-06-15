Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFF7730DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbjFOEHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjFOEHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:07:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC41BF8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:07:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56938733c13so17471867b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686802050; x=1689394050;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EGSFse5BO9SaZtO47qLHwozj1QdxYYuFsGDqkkwyYl4=;
        b=eAW7X9o+ZbRUc1+mOuwXgN8xMLhafZ22t4yvIswPDNtFn8tNXX/x6GBqfO71ZdsffB
         IGbhYiz8Eph5SDgAY/HqTDBTTTwwVl/zV0GojBrRf1NnCStxSXVnxQLnCO2aUPOrn8cM
         8SMc3klIdLg0lE3LTql/4Yx7NgcsJfMHA1erciyv26keJXlKt9C45wVlShaAbzQtBjvK
         rROE2cQM87K2oiSooHVwHRK6XWvHoJKS/OYQpEFRI8+YtdpEs7rBo+Wfv+Jlxh2bo1RS
         WlFLtqlNGEoD2uud10r/bxUAz6rou5r98QQttMm4YKhta4cbMSTgZZH6z6ALpUp10pLu
         JX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686802050; x=1689394050;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGSFse5BO9SaZtO47qLHwozj1QdxYYuFsGDqkkwyYl4=;
        b=TR1LJGHlBPJwGMYVNISFAesiqWBS5JiRvL+WdgDnvqeZYKZsIuLZs34uH+G1sAqa+G
         YZjuDdCILFCK83gOWEXkCp2E+OgiIN3/mS3FEJRwH+Rwv4Vs1EcaDXSKqgU0yh7qpwWf
         Hkhf7/s3vZ/wLXFJccnW3HsSc/BAALPzPWA00n5+cwjIOagk90R/cISsh6miRjYdAPDj
         4vFqbopombSElSzdYE802wM7h87d4qjZe/zi5U65T5taFuDhcvJH9P70xpSpG8QUoo+4
         4nfub/pbg1zwHGpUAg1P2BY/auxu8SsWgPa7qEXS5pxil4kL+W+rvNQ00geMOnu0SUsV
         77og==
X-Gm-Message-State: AC+VfDwS2WhHRBQO0NdjexurjKaep3TPmPPSsURDD54r3G80dRPi7VNN
        ysYT7fALpZSfjF/5mM8ajAmtjf26XEup
X-Google-Smtp-Source: ACHHUZ7+1/TxR7ABD0ZSiwDyEteGbtmLwjQlil4zAgWEyl03F9qS5R79VKY/or1QGHnyh0XDPTiBwsgyZ4WT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:768d:713f:8ce8:1d35])
 (user=irogers job=sendgmr) by 2002:a81:b644:0:b0:569:e04a:239d with SMTP id
 h4-20020a81b644000000b00569e04a239dmr1668459ywk.0.1686802049975; Wed, 14 Jun
 2023 21:07:29 -0700 (PDT)
Date:   Wed, 14 Jun 2023 21:07:14 -0700
Message-Id: <20230615040715.2064350-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 1/2] perf sharded_mutex: Introduce sharded_mutex
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
        Yuan Can <yuancan@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andres Freund <andres@anarazel.de>,
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

Per object mutexes may come with significant memory cost while a
global mutex can suffer from unnecessary contention. A sharded mutex
is a compromise where objects are hashed and then a particular mutex
for the hash of the object used. Contention can be controlled by the
number of shards.

Signed-off-by: Ian Rogers <irogers@google.com>

v2. Use hashmap.h's hash_bits in case of contention from alignment of
    objects.
---
 tools/perf/util/Build           |  1 +
 tools/perf/util/sharded_mutex.c | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/sharded_mutex.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 tools/perf/util/sharded_mutex.c
 create mode 100644 tools/perf/util/sharded_mutex.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ff2fd1a36bb8..96f4ea1d45c5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -145,6 +145,7 @@ perf-y += mem2node.o
 perf-y += clockid.o
 perf-y += list_sort.o
 perf-y += mutex.o
+perf-y += sharded_mutex.o
 
 perf-$(CONFIG_LIBBPF) += bpf-loader.o
 perf-$(CONFIG_LIBBPF) += bpf_map.o
diff --git a/tools/perf/util/sharded_mutex.c b/tools/perf/util/sharded_mutex.c
new file mode 100644
index 000000000000..e11e8d0945a7
--- /dev/null
+++ b/tools/perf/util/sharded_mutex.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "sharded_mutex.h"
+
+#include <stdlib.h>
+
+struct sharded_mutex *sharded_mutex__new(size_t num_shards)
+{
+	struct sharded_mutex *result;
+	size_t size;
+	unsigned int bits;
+
+	for (bits = 0; ((size_t)1 << bits) < num_shards; bits++)
+		;
+
+	size = sizeof(*result) + sizeof(struct mutex) * (1 << bits);
+	result = malloc(size);
+	if (!result)
+		return NULL;
+
+	result->cap_bits = bits;
+	for (size_t i = 0; i < ((size_t)1 << bits); i++)
+		mutex_init(&result->mutexes[i]);
+
+	return result;
+}
+
+void sharded_mutex__delete(struct sharded_mutex *sm)
+{
+	for (size_t i = 0; i < ((size_t)1 << sm->cap_bits); i++)
+		mutex_destroy(&sm->mutexes[i]);
+
+	free(sm);
+}
diff --git a/tools/perf/util/sharded_mutex.h b/tools/perf/util/sharded_mutex.h
new file mode 100644
index 000000000000..7325e969eee3
--- /dev/null
+++ b/tools/perf/util/sharded_mutex.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef PERF_SHARDED_MUTEX_H
+#define PERF_SHARDED_MUTEX_H
+
+#include "mutex.h"
+#include "hashmap.h"
+
+/*
+ * In a situation where a lock is needed per object, having a mutex can be
+ * relatively memory expensive (40 bytes on x86-64). If the object can be
+ * constantly hashed, a sharded mutex is an alternative global pool of mutexes
+ * where the mutex is looked up from a hash value. This can lead to collisions
+ * if the number of shards isn't large enough.
+ */
+struct sharded_mutex {
+	/* mutexes array is 1<<cap_bits in size. */
+	unsigned int cap_bits;
+	struct mutex mutexes[];
+};
+
+struct sharded_mutex *sharded_mutex__new(size_t num_shards);
+void sharded_mutex__delete(struct sharded_mutex *sm);
+
+static inline struct mutex *sharded_mutex__get_mutex(struct sharded_mutex *sm, size_t hash)
+{
+	return &sm->mutexes[hash_bits(hash, sm->cap_bits)];
+}
+
+#endif  /* PERF_SHARDED_MUTEX_H */
-- 
2.41.0.162.gfafddb0af9-goog

