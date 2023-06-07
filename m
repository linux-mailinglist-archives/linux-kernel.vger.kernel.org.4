Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F357251B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbjFGBpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbjFGBoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F11BD6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so11054091276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102262; x=1688694262;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpNQ67AkI8m/ByBrUic9YBgEX48o49zrQAIWWFxGupA=;
        b=2mmI3Ier9E+7LtMTwnruU860E1kJzf1lfRFohykJ+BOjsrKNB0hofvnkgYm1m7i1Pu
         JLG6dcHjxY2MQgAt+pqDPCUjnl8vOLJETwdMC3sQg34GQINAz8ell0umBpIhdZLa8tEM
         dgFZI4m21daW4yklmje2J+OsVgnx4AV00fpIk+v30G4zZWA6W9bK+ShiY6kNLpX0JhaJ
         +k2M7XaJONn9WbCXlTiOrPRSTkGB5fYk9/+iUN9IEz39pCDYpiiMRyfwYFzX9/fT2VA4
         KX9o/lppgNA08C4xD2UkPAvhWFrX4tAM5OYI+tXS4t1J6G8+OzkQI3ZWR8k36DMgX7OI
         nlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102262; x=1688694262;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpNQ67AkI8m/ByBrUic9YBgEX48o49zrQAIWWFxGupA=;
        b=FPUu3GjE7SMeG3be5kTS+bghm0D0RjZClrJWgZEsKIHBl+D8pmbWQyC/DRxMSnb/aE
         mheHe3ChX/7OZVUwlNUsX/EmXU3SJAUDR8NjGyntbxakMP/j+wiWa7ZIQH9AVRAVGKDa
         s0J2J0A5JhLUohAwDJnrWIJPozIOqwPYReJ4W+nw/1iXtXMW9Lld9wViCMcj5N1M344F
         0RBF9d35pzUL21Rf1h1CSAms4phd3mH8czWGTrGjqIV7+JP5X5mn9OsnLhXK7MaNKA6m
         9L+79YoVPKFsuXzRyfYQ4s9YgrdYOkAL3fK6gF0Qvza5Y8Mr9R8iEjkO9dljWFWEuA3W
         wsPw==
X-Gm-Message-State: AC+VfDyNOVAw44e8TbEhLoooAHaJOehPJBCk/0eaWoZRwc7ZrnQQNMkR
        wblHmntea2WBoycKeJrdvblwBzKZ26Nl
X-Google-Smtp-Source: ACHHUZ6LAU2dTT4Ttzj1f/FjaoZOHz/na1c4Dql6XIrzPosdgoKCX3GHWT5IOREC5ztEaj2mTsLB2X6qVNba
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1896:b0:ba8:929a:2073 with SMTP
 id cj22-20020a056902189600b00ba8929a2073mr2320976ybb.1.1686102262039; Tue, 06
 Jun 2023 18:44:22 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:38 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-6-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 05/20] perf addr_location: Move to its own header
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
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.41.0.rc0.172.g3f132b7071-goog

