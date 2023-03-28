Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6856CB345
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjC1BmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjC1BmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:42:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E162705
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:42:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e186-20020a2537c3000000b00b72501acf50so10599481yba.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679967721;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kss2E4XS78XZ4HkoeCxVNy5Rmlet/VUGVuBxJiT5YC8=;
        b=pD6mVdxesXc+HXDIUTPZGyFURAs6uW+MP0HH6PYTja3+3mdcEkW0G53DkU9li31/LI
         GDtj2BPV7N5kjtpgNbd6hGFyMAhPLc9aTHHAFJDxiDdNtSj44rPLKLTraL1Ts+qNFY/b
         pk8tmLzBtFgoMzv/JZLqcP0N6Px1OMgWDWrDZFgSLdLWybsRBd7ZrnzVMWQadhcNAhdy
         oN4NxUegez6+IG3HcN87pgad0pYZN+NkjEW92nWc+lKELiIumfUkoXfJAZcXXTCJ85Gj
         siSVikcNgHgCx0Xc7ZRCWvFIqssSxKFyEK/iVT8gPrUZtiXIsdjjwNwaNyBp6CWvEFQO
         8Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679967721;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kss2E4XS78XZ4HkoeCxVNy5Rmlet/VUGVuBxJiT5YC8=;
        b=3AN6bVB0ZFGszBsjNGn51Kpfyvx4tNDzLx0j5sDoUoPN7cWi0drz+2Sv5YmcGRQ6Xi
         kFrvACWp3GO7MXZv3G0nQkMK/GO2Cw78Dx3a5S5KKdhFDG+82pcBdhCCK2Ff4MG+URkv
         8Pd/qZKnDx5NlsqfQs1bDTSLZyEKu8HbLBr3AVGQIQjovO+tNbz5sMBIuiU8D1EiisST
         Y5OCLMByQSxNcAkGhg+0Ab11q0FqHieFyNeFKBiSHH6bB/OcQq30J3XsDrF9N6zf8HJ0
         RgBKTJq5MHMRopyG993OsIf2802yP6zEv7WqOoHhaXP8HExgsf887Ae8DDJ1w22uW2mb
         dwEA==
X-Gm-Message-State: AAQBX9e7gPYzq0QXk2s+V7zk/glYoSG2w9xieTaNvQ9iO1Q4mb39II6X
        Ic8A+V5JbMPj8c4NLF6a6WoEhC8RIiHt
X-Google-Smtp-Source: AKy350bYGPJNYyhxhXCLA1UFocDvhQpUP+0IpvNzAWrJdc6/PQyp9eEy8L5USH/xhnVuQ6HL+6pnf491/Uu9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a544:20a5:5228:d98f])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c6:b0:b78:4788:525b with SMTP
 id ck6-20020a05690218c600b00b784788525bmr7956584ybb.0.1679967721048; Mon, 27
 Mar 2023 18:42:01 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:40:58 -0700
In-Reply-To: <20230328014058.870413-1-irogers@google.com>
Message-Id: <20230328014058.870413-7-irogers@google.com>
Mime-Version: 1.0
References: <20230328014058.870413-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 6/6] perf util: Move perf_guest/host declarations
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
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Raul Silvera <rsilvera@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definitions are in util.c so move the declarations to match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-diff.c      | 2 +-
 tools/perf/builtin-kvm.c       | 1 +
 tools/perf/perf.h              | 4 ----
 tools/perf/ui/hist.c           | 2 +-
 tools/perf/util/cs-etm.c       | 1 +
 tools/perf/util/event.c        | 2 +-
 tools/perf/util/evlist.c       | 1 +
 tools/perf/util/parse-events.c | 2 +-
 tools/perf/util/session.c      | 2 +-
 tools/perf/util/top.c          | 2 +-
 tools/perf/util/util.h         | 3 +++
 11 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 22b526766e14..dbb0562d6a4f 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -6,7 +6,6 @@
  * DSOs and symbol information, sort them and produce a diff.
  */
 #include "builtin.h"
-#include "perf.h"
 
 #include "util/debug.h"
 #include "util/event.h"
@@ -26,6 +25,7 @@
 #include "util/spark.h"
 #include "util/block-info.h"
 #include "util/stream.h"
+#include "util/util.h"
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index fb9dc0dc46f9..747d19336340 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -23,6 +23,7 @@
 #include "util/data.h"
 #include "util/ordered-events.h"
 #include "util/kvm-stat.h"
+#include "util/util.h"
 #include "ui/browsers/hists.h"
 #include "ui/progress.h"
 #include "ui/ui.h"
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 49e15e2be49e..c004dd4e65a3 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -2,14 +2,10 @@
 #ifndef _PERF_PERF_H
 #define _PERF_PERF_H
 
-#include <stdbool.h>
-
 #ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS			2048
 #endif
 
-extern bool perf_host, perf_guest;
-
 enum perf_affinity {
 	PERF_AFFINITY_SYS = 0,
 	PERF_AFFINITY_NODE,
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 5075ecead5f3..f164bd26fc41 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -11,7 +11,7 @@
 #include "../util/sort.h"
 #include "../util/evsel.h"
 #include "../util/evlist.h"
-#include "../perf.h"
+#include "../util/util.h"
 
 /* hist period print (hpp) functions */
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f65bac5ddbdb..9e9c85533f05 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -38,6 +38,7 @@
 #include "tsc.h"
 #include <tools/libc_compat.h>
 #include "util/synthetic-events.h"
+#include "util/util.h"
 
 struct cs_etm_auxtrace {
 	struct auxtrace auxtrace;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 1fa14598b916..31474b31899a 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -33,7 +33,7 @@
 #include "bpf-event.h"
 #include "print_binary.h"
 #include "tool.h"
-#include "../perf.h"
+#include "util.h"
 
 static const char *perf_event__names[] = {
 	[0]					= "TOTAL",
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index cc491a037836..df6af38ca22e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -32,6 +32,7 @@
 #include "util/pmu.h"
 #include "util/sample.h"
 #include "util/bpf-filter.h"
+#include "util/util.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc8e8766ca30..5ecde113e642 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -25,10 +25,10 @@
 #include "util/parse-branch-options.h"
 #include "util/evsel_config.h"
 #include "util/event.h"
-#include "perf.h"
 #include "util/parse-events-hybrid.h"
 #include "util/pmu-hybrid.h"
 #include "util/bpf-filter.h"
+#include "util/util.h"
 #include "tracepoint.h"
 #include "thread_map.h"
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7d8d057d1772..e2806791c76a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -33,7 +33,7 @@
 #include "stat.h"
 #include "tsc.h"
 #include "ui/progress.h"
-#include "../perf.h"
+#include "util.h"
 #include "arch/common.h"
 #include "units.h"
 #include <internal/lib.h>
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index b8b32431d2f7..be7157de0451 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -11,7 +11,7 @@
 #include "parse-events.h"
 #include "symbol.h"
 #include "top.h"
-#include "../perf.h"
+#include "util.h"
 #include <inttypes.h>
 
 #define SNPRINTF(buf, size, fmt, args...) \
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 8bd515b67739..7c8915d92dca 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -20,6 +20,9 @@ extern const char perf_more_info_string[];
 
 extern const char *input_name;
 
+extern bool perf_host;
+extern bool perf_guest;
+
 /* General helper functions */
 void usage(const char *err) __noreturn;
 void die(const char *err, ...) __noreturn __printf(1, 2);
-- 
2.40.0.348.gf938b09366-goog

