Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0432F728BCD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbjFHX3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbjFHX3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8E630ED
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb39aebdd87so2572227276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266964; x=1688858964;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGWgSynrOj/PLbqXNX2x48CdvWEXkGjqwrkmdfXHnVY=;
        b=PrpWinbTvoRzHNWvPNJNF33aAhfQd7XYp6Mxz2JjnjGgD8hI7sAxAVnVZFZDbqx9k7
         kBAnswjlFIBVG/RzWzMZIKXQfjzOrDd1B3UW7qog5wXqFHCXPG6Mmah1WywxM6x/M/4M
         gul2G31zudV0rOyTH/RXGBdTG2oKj2vY491Nxf3Q9wIhew3j5F8lhsWhEkvPkb0V3L5K
         W0fkpz8PSLCd/K7qSh58D8nJ4WQoeqAEX79ukhshv7jrub3IYKPcPc8zlkyZzfpJUqNr
         6wwNxnm+d0ExADXV7eCLubh9bpPLQmLVfYKVHroa9zm9SARHlihF7QiGILGCPxB/Yweb
         E5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266964; x=1688858964;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGWgSynrOj/PLbqXNX2x48CdvWEXkGjqwrkmdfXHnVY=;
        b=PLQvi+5iCJ4dGiOCoq5BD6ukzqVLCXtnwkvzHeUeE1Ttcu4Hw+yH5ROrv+QFASkupZ
         JWVG7o+Dd12A8XmkUnYEO6eGVjmqCpcfN1UFKm/ZmJV/HuvtGNyTmylcYuAUQ+mhAqfV
         TJSk4bYYHfwMmkqtr9RK5lLl9rscD3PaUjSQ/YrCNoKvPr4UvdtIrmjx/CNgyTYWKVu/
         CESR0k2dS5cxPS3HqdbPGxFG0uzinUODlkRrDemwsiSjI25N1R4AXNG9tyKGGwt1VNwD
         GEbCpmif3jIz9VJIND1Fwr3wj/pBA6Mw5VlPh3g3DLLaokRC9duktLTfSEVeQVV3qKvu
         jVtA==
X-Gm-Message-State: AC+VfDy93I19rj8qNJ5SzV5f100t26YpfULk3m0F8IlvW+h+DzAO+py9
        201NRaTL+hb8rW05wCYC49dzRTY0lDv1
X-Google-Smtp-Source: ACHHUZ73d7KA7YvKZlm+FTDRrvHKTW9MdriwohP40DR/Hzk2z5mXwezVFmP5a91auPb6VSCYNi8uC90GmFzP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a05:6902:38a:b0:ba8:381b:f764 with SMTP id
 f10-20020a056902038a00b00ba8381bf764mr51238ybs.3.1686266963896; Thu, 08 Jun
 2023 16:29:23 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:02 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-6-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 05/26] perf addr_location: Move to its own header
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
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

addr_location is a common abstraction, move it into its own header and
source file in preparation for wider clean up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build           |  1 +
 tools/perf/util/addr_location.c | 16 ++++++++++++++++
 tools/perf/util/addr_location.h | 28 ++++++++++++++++++++++++++++
 tools/perf/util/event.c         | 12 ------------
 tools/perf/util/symbol.h        | 17 +----------------
 5 files changed, 46 insertions(+), 28 deletions(-)
 create mode 100644 tools/perf/util/addr_location.c
 create mode 100644 tools/perf/util/addr_location.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c449741adf30..ff2fd1a36bb8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,4 +1,5 @@
 perf-y += arm64-frame-pointer-unwind-support.o
+perf-y += addr_location.o
 perf-y += annotate.o
 perf-y += block-info.o
 perf-y += block-range.o
diff --git a/tools/perf/util/addr_location.c b/tools/perf/util/addr_location.c
new file mode 100644
index 000000000000..c73fc2aa236c
--- /dev/null
+++ b/tools/perf/util/addr_location.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "addr_location.h"
+#include "map.h"
+#include "thread.h"
+
+/*
+ * The preprocess_sample method will return with reference counts for the
+ * in it, when done using (and perhaps getting ref counts if needing to
+ * keep a pointer to one of those entries) it must be paired with
+ * addr_location__put(), so that the refcounts can be decremented.
+ */
+void addr_location__put(struct addr_location *al)
+{
+	map__zput(al->map);
+	thread__zput(al->thread);
+}
diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
new file mode 100644
index 000000000000..7dfa7417c0fe
--- /dev/null
+++ b/tools/perf/util/addr_location.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_ADDR_LOCATION
+#define __PERF_ADDR_LOCATION 1
+
+#include <linux/types.h>
+
+struct thread;
+struct maps;
+struct map;
+struct symbol;
+
+struct addr_location {
+	struct thread *thread;
+	struct maps   *maps;
+	struct map    *map;
+	struct symbol *sym;
+	const char    *srcline;
+	u64	      addr;
+	char	      level;
+	u8	      filtered;
+	u8	      cpumode;
+	s32	      cpu;
+	s32	      socket;
+};
+
+void addr_location__put(struct addr_location *al);
+
+#endif /* __PERF_ADDR_LOCATION */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e1ce7cb5e421..6ee23145ee7e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -767,18 +767,6 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	return 0;
 }
 
-/*
- * The preprocess_sample method will return with reference counts for the
- * in it, when done using (and perhaps getting ref counts if needing to
- * keep a pointer to one of those entries) it must be paired with
- * addr_location__put(), so that the refcounts can be decremented.
- */
-void addr_location__put(struct addr_location *al)
-{
-	map__zput(al->map);
-	thread__zput(al->thread);
-}
-
 bool is_bts_event(struct perf_event_attr *attr)
 {
 	return attr->type == PERF_TYPE_HARDWARE &&
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 7558735543c2..5ca8665dd2c1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdio.h>
+#include "addr_location.h"
 #include "path.h"
 #include "symbol_conf.h"
 #include "spark.h"
@@ -120,22 +121,6 @@ struct ref_reloc_sym {
 	u64		unrelocated_addr;
 };
 
-struct addr_location {
-	struct thread *thread;
-	struct maps   *maps;
-	struct map    *map;
-	struct symbol *sym;
-	const char    *srcline;
-	u64	      addr;
-	char	      level;
-	u8	      filtered;
-	u8	      cpumode;
-	s32	      cpu;
-	s32	      socket;
-};
-
-void addr_location__put(struct addr_location *al);
-
 int dso__load(struct dso *dso, struct map *map);
 int dso__load_vmlinux(struct dso *dso, struct map *map,
 		      const char *vmlinux, bool vmlinux_allocated);
-- 
2.41.0.162.gfafddb0af9-goog

