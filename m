Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9138A6C096F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCTDnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCTDmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:42:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2729D227B9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:40:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5419fb7d6c7so108802217b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283656;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx+Czfooqx4+y3PtKz3VngTOr7flvK3/ZnOwhjyajRw=;
        b=MnCFeZ3XYBxTeakZd+zOXa4Ab3HZffcdRzC8KKmGbbG9Fn9k1DFYzjlrNzkXYGXnxd
         923XA9T3DkAR0cJ6qMDKJ9rhD3B6K8UXQ7POn0CCRqQcNXXrQxg5X0BE0b1a18KdG70D
         ul5rcjH1TSDixbX/5aMLw+P/mJ2v2v6aS45fo+mDzXKNT1tqCuO1ISTU5MXWf6YAVpTO
         3nCtelHziS8hnvRvMZXud4/jWzVF9s8FLsd96uVwPGuS6/rBup1H+o/TDMxalS7iDz0Y
         SAUjZQ9vSBzD6XhPKS4ZAWFEt4Dxe2TohNmrm2CaXeTkKRG2T+JO6e8WEntCXe14Ejyh
         X20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283656;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx+Czfooqx4+y3PtKz3VngTOr7flvK3/ZnOwhjyajRw=;
        b=MiwLZBegECDVVZ18ng2pLMjnVky6QF4D6kneE3qNBHQaaW+F9hh6mg68I42LnUubWt
         XboYcUsu/W27SBF8eHQXLGtjkb/5MJi3DE2+menO2s2r/2o6N2WEyEf9k9/U12+E4xey
         AkLoHQj0HebW0nspawKa88+Zr512ZyduFQHSvM0VRaK9GcsNOMJna0/hR3gTOijiWcgD
         RN4n7HY4gK3cVMyaCzNH8UoKMtkvywbrxac3nAGGPd+pKYVm5mcXWaGqkjPEGQxyJbJ1
         bogjMxjkAOE/QWtPZnn1CaGu7UUKS3nDtHtofxWFNSbBYcIkyUwBVi13V6IStmN39leX
         YpPg==
X-Gm-Message-State: AO0yUKUiaexyPYFzEX3qW5lhDYcI/qTp828gbeVDWTgAFYPCQ7Kc+krm
        npTzaMrwy8p159qFJ3MfEL23w0gAHZ/a
X-Google-Smtp-Source: AK7set8Tdbub04SSF+TbbYlkVgHxpVLE5t37DZ88uqqR1sEcI7ns7735e5AVy4IaYP0kJ8d3N8QRGJexgh2j
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a05:6902:72b:b0:b6b:e967:920d with SMTP id
 l11-20020a056902072b00b00b6be967920dmr1240639ybt.13.1679283656703; Sun, 19
 Mar 2023 20:40:56 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:38:06 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-19-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 18/22] libperf: Add reference count checking macros.
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

