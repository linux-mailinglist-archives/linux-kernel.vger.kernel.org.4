Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280586C23A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCTVZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCTVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:25:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AE6302A1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:24:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a250fd5000000b00b6d6655dc35so2966939ybp.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347480;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx+Czfooqx4+y3PtKz3VngTOr7flvK3/ZnOwhjyajRw=;
        b=Q+n6EUqhYj+IdoEFDVvk6ANpjHNNdXvaBW3gCdTMQk9mwjnqHSMUCPhxWeIfxMAHrI
         NVfKSReNTU7Gbn7DBB6hBcinYmRvdy7cdvjILkdjHstnuBAr2fiTwItkAHZZVcwtRT/f
         wtniKmWKLCmnaJZBne28dG+uWL2aO9QUhggoSfnUyz1dOfIAIXC52kYAgX5mX0H2gWv+
         xI99cVholotXfrgkFhuxjtrv/O1jfHaGRPpakU4KTGVQPYjihtLkoObTJMRuWRE+ClM8
         W0enLg1WWfYqJ5JFzq8jH1SK39d2Id+IqBkK9p/FHSmIndqDl9D4P+mS8ADJMBlnCh8Z
         1L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347480;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx+Czfooqx4+y3PtKz3VngTOr7flvK3/ZnOwhjyajRw=;
        b=4tLNvKT9BPSZVfFqF0tJnNp7DXejkJ5O7epa3TaRJ0JOLkPrerDpJyj/OFGfiUPeRo
         Cg0AlPUyJm+VAOB1DxtvE3yha52H19CsgxEWsf4XodgUkOWXl/95Kq5tGJ8XDM8M03NL
         XAef2ymuMKuIOwROIVcgU/8B77+XUNb776Eijsq7L9yBIuhYpyHT7jC0PUqCIR8J7mro
         SBfKTLXnF6ArRMkE9ukniKUJJz5wFcwk4X4WSTMm5LVoFI8eDCGukDEfyrdwkmPn2XwU
         UmlKTaMnQ6ccEd8dqKMcLaJ4W43+9bC5gxPQPRt77BSXnh9bqwiD/gPOTx7Rse5dhf0G
         qt8Q==
X-Gm-Message-State: AAQBX9fjaIzF2ZShhaJ5MK76rkVlNJYt8FdWAiBivMzejOCwbDjkVfTc
        vMBKGimc4HIMiBoOkus648MfWKUlxxuT
X-Google-Smtp-Source: AKy350ZbdKh1NwspQyhPDDoyG/uJa2t17sY3CpDG/BXxxDQyfVAf2+UE9i8v/XL82NqaZ+NvaLUu30w+NNg7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a25:5b84:0:b0:b67:d295:d614 with SMTP id
 p126-20020a255b84000000b00b67d295d614mr403541ybb.12.1679347479801; Mon, 20
 Mar 2023 14:24:39 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:44 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-14-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 13/17] libperf: Add reference count checking macros.
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros serve as a way to debug use of a reference counted struct.
The macros add a memory allocated pointer that is interposed between
the reference counted original struct at a get and freed by a put.
The pointer replaces the original struct, so use of the struct name
via APIs remains unchanged.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/rc_check.h | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 tools/lib/perf/include/internal/rc_check.h

diff --git a/tools/lib/perf/include/internal/rc_check.h b/tools/lib/perf/include/internal/rc_check.h
new file mode 100644
index 000000000000..c0626d8beb59
--- /dev/null
+++ b/tools/lib/perf/include/internal/rc_check.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __LIBPERF_INTERNAL_RC_CHECK_H
+#define __LIBPERF_INTERNAL_RC_CHECK_H
+
+#include <stdlib.h>
+#include <linux/zalloc.h>
+
+/*
+ * Shared reference count checking macros.
+ *
+ * Reference count checking is an approach to sanitizing the use of reference
+ * counted structs. It leverages address and leak sanitizers to make sure gets
+ * are paired with a put. Reference count checking adds a malloc-ed layer of
+ * indirection on a get, and frees it on a put. A missed put will be reported as
+ * a memory leak. A double put will be reported as a double free. Accessing
+ * after a put will cause a use-after-free and/or a segfault.
+ */
+
+#ifndef REFCNT_CHECKING
+/* Replaces "struct foo" so that the pointer may be interposed. */
+#define DECLARE_RC_STRUCT(struct_name)		\
+	struct struct_name
+
+/* Declare a reference counted struct variable. */
+#define RC_STRUCT(struct_name) struct struct_name
+
+/*
+ * Interpose the indirection. Result will hold the indirection and object is the
+ * reference counted struct.
+ */
+#define ADD_RC_CHK(result, object) (result = object, object)
+
+/* Strip the indirection layer. */
+#define RC_CHK_ACCESS(object) object
+
+/* Frees the object and the indirection layer. */
+#define RC_CHK_FREE(object) free(object)
+
+/* A get operation adding the indirection layer. */
+#define RC_CHK_GET(result, object) ADD_RC_CHK(result, object)
+
+/* A put operation removing the indirection layer. */
+#define RC_CHK_PUT(object) {}
+
+#else
+
+/* Replaces "struct foo" so that the pointer may be interposed. */
+#define DECLARE_RC_STRUCT(struct_name)			\
+	struct original_##struct_name;			\
+	struct struct_name {				\
+		struct original_##struct_name *orig;	\
+	};						\
+	struct original_##struct_name
+
+/* Declare a reference counted struct variable. */
+#define RC_STRUCT(struct_name) struct original_##struct_name
+
+/*
+ * Interpose the indirection. Result will hold the indirection and object is the
+ * reference counted struct.
+ */
+#define ADD_RC_CHK(result, object)					\
+	(								\
+		object ? (result = malloc(sizeof(*result)),		\
+			result ? (result->orig = object, result)	\
+			: (result = NULL, NULL))			\
+		: (result = NULL, NULL)					\
+		)
+
+/* Strip the indirection layer. */
+#define RC_CHK_ACCESS(object) object->orig
+
+/* Frees the object and the indirection layer. */
+#define RC_CHK_FREE(object)			\
+	do {					\
+		zfree(&object->orig);		\
+		free(object);			\
+	} while(0)
+
+/* A get operation adding the indirection layer. */
+#define RC_CHK_GET(result, object) ADD_RC_CHK(result, (object ? object->orig : NULL))
+
+/* A put operation removing the indirection layer. */
+#define RC_CHK_PUT(object)			\
+	do {					\
+		if (object) {			\
+			object->orig = NULL;	\
+			free(object);		\
+		}				\
+	} while(0)
+
+#endif
+
+#endif /* __LIBPERF_INTERNAL_RC_CHECK_H */
-- 
2.40.0.rc1.284.g88254d51c5-goog

