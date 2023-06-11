Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4072B09E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjFKH16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 03:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjFKH14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 03:27:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19242115
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 00:27:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565de4b5be5so41976727b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686468475; x=1689060475;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CcnqOcwlbCd3VSuyawS2iKwyT4GXvUs21UDt2IwfKTU=;
        b=SjT0ogFV0xJer5DxxuCqj1lhCwSJMpAXb89+ZkHDfx7TdLEJwwHE7XvV5a8bddetrh
         7dS/uqNfYgkrWF4J7bZAEJlq6mjuTyHzct6FGT3czGw5nHmhmTLdb1j0x/NAyW8dsKLN
         KEu0/Ycfjrfodopu2Os9VSTHQAVaXD3S3/cz3XX8TaH7ZN3CpgSmyNIqRdHUxDCHyn6e
         xF7u6Eo82VUdtWGH7aU5zTNyFT57Mrde7K9rREX4IS2DgSvskwE/Y7MdcIJpZxQ1C0Ga
         I0BK6zyGaYz6Iq7SQGq/qvFnTGyGbkggIfLIDfF3Sfc0xqB+j7Ps5OPbHuKoHqk+iSeq
         +zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686468475; x=1689060475;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcnqOcwlbCd3VSuyawS2iKwyT4GXvUs21UDt2IwfKTU=;
        b=c3CE6dH2l9Z9VEjIIsaxWpenr72IagFkUA5xOP+l6vBnK5gHJD6rXVoAhxnocxVTNR
         66JPEG6NLJeOY+oi6KhebSmLdcscmPjKd1qhDMMILGLUIVdqtKtf7h20lqnm9IreQKSL
         WUpu6ivwFhlOghO2x7OlB5jufS8bUycnJTjo3wHAxvdiDxHdsCrIK17Lv9uS737xpcUf
         K/7zFyYZaXP79kZ2Nea1tQwVPw7bq3BUMfQZJPitvYTgKX1vIyoj8Gwad8KrpFZqM+kE
         MAV97h9/Y4nDypGR+Ba6wsTxrv2HGE24jlO3MowBXjLh+Cy3HOIit9cOGCVh2RWdXnme
         uGkw==
X-Gm-Message-State: AC+VfDyH4SNToi4KRsGAjrILwh5eEHRwklLNGVeCxxuUjivgg5WkvI+2
        fsyvVn6TYs6narRyrHWyWr94aClMAZiO
X-Google-Smtp-Source: ACHHUZ5dbmK/FNcmgwKfRb0U6C0PsaQgjxZJ8pys71wNJnJ/MgsNO63CHthWraiCupFWZ+g4e385zLjFejpn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:737b:2b94:75b5:9fb7])
 (user=irogers job=sendgmr) by 2002:a25:f30a:0:b0:ba8:5bc9:80fe with SMTP id
 c10-20020a25f30a000000b00ba85bc980femr3295857ybs.1.1686468475072; Sun, 11 Jun
 2023 00:27:55 -0700 (PDT)
Date:   Sun, 11 Jun 2023 00:27:49 -0700
Message-Id: <20230611072751.637227-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 1/2] perf sharded_mutex: Introduce sharded_mutex
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
---
 tools/perf/util/Build           |  1 +
 tools/perf/util/sharded_mutex.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/sharded_mutex.h | 27 +++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)
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
index 000000000000..2c6a1d0ac4f7
--- /dev/null
+++ b/tools/perf/util/sharded_mutex.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "sharded_mutex.h"
+
+#include <stdlib.h>
+
+struct sharded_mutex *sharded_mutex__new(size_t num_shards)
+{
+	struct sharded_mutex *result;
+	size_t size = sizeof(*result) + sizeof(struct mutex) * num_shards;
+
+	result = malloc(size);
+	if (!result)
+		return NULL;
+
+	result->num_shards = num_shards;
+	for (size_t i = 0; i < num_shards; i++)
+		mutex_init(&result->mutexes[i]);
+
+	return result;
+}
+
+void sharded_mutex__delete(struct sharded_mutex *sm)
+{
+	for (size_t i = 0; i < sm->num_shards; i++)
+		mutex_destroy(&sm->mutexes[i]);
+
+	free(sm);
+}
diff --git a/tools/perf/util/sharded_mutex.h b/tools/perf/util/sharded_mutex.h
new file mode 100644
index 000000000000..aa649a63a54f
--- /dev/null
+++ b/tools/perf/util/sharded_mutex.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef PERF_SHARDED_MUTEX_H
+#define PERF_SHARDED_MUTEX_H
+
+#include "mutex.h"
+
+/*
+ * In a situation where a lock is needed per object, having a mutex can be
+ * relatively memory expensive (40 bytes on x86-64). If the object can be
+ * constantly hashed, a sharded mutex is an alternative global pool of mutexes
+ * where the mutex is looked up from a hash value. This can lead to collisions
+ * if the number of shards isn't large enough.
+ */
+struct sharded_mutex {
+	size_t num_shards;
+	struct mutex mutexes[];
+};
+
+struct sharded_mutex *sharded_mutex__new(size_t num_shards);
+void sharded_mutex__delete(struct sharded_mutex *sm);
+
+static inline struct mutex *sharded_mutex__get_mutex(struct sharded_mutex *sm, size_t hash)
+{
+	return &sm->mutexes[hash % sm->num_shards];
+}
+
+#endif  /* PERF_SHARDED_MUTEX_H */
-- 
2.41.0.162.gfafddb0af9-goog

