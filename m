Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9888A6CB342
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjC1BmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjC1BmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:42:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ABF2D59
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:41:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x15-20020a25accf000000b00b3b4535c48dso10501212ybd.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679967714;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5FeDRrAUdLrz0fSr31NMx6IbzsJJfSEME3Dln4iyN34=;
        b=p8mJ7EguZONVEmzn34c2f3NtGdtWriBX6d8Nfw1EXDkkRN+tfWGKOmTfRhXpq/OHOo
         lEst+nHYzm0DT1YKFL5gGLoPF3SztIRLhfNe0QosfbPN6Cg9ejo8HxNAYw1rcUYGlUjx
         3C9pJnkJzcwonsu0EmVSYf9nl7MWCcg9B8zN8BjiF7fc2E4hrfXs/2dzKMNqaU2dP1jd
         w1ODUvIzXjTXo2z+lq3fqiOvloGiUqMAonVF0TgixAX+sYOSen1tG5hVaJNfT8idQuw0
         i06TmJhd/pbp06DbWjXmf+Aa69MlGYXtmRSw2N5GdDZlUY+aoIYa7BeKjUHz4nMyh3rb
         bw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679967714;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FeDRrAUdLrz0fSr31NMx6IbzsJJfSEME3Dln4iyN34=;
        b=cLNcAHY5CygkwL4+jnHmkYNSDKGP9dn2vCb+g84Lw/iIb7LHLe42/sK0rcdnTvgP9d
         RwsEpSA2iuw/Ouwe7nlnv4UFPoYdTSyXLsQApEgLeP9avsbBMzesxDp7hlzGavklbySo
         Ntg8ce9zPKVDeMIQij7FQFO5An4Ysvh7uf/kICbIZp6KXLwO8VfLWkBnsnu74/uEOdrj
         ps+Pjo728IUcXj/8cmrXSZdCccq6JHnAzS29nPZyMtTfGWJ5brw6+eG1erSQM5pk3jXu
         NsvgBTthijgGEv3CiJg+lp04mrpd2VvNDhktOzBZFeDF3I0ngsvV5g8Afp5wZcyiXyn1
         EB+A==
X-Gm-Message-State: AAQBX9fRY/sHJevHvXo1uAU/QUIw0RQbhzxV6KuznXDNI7rEkEIf91O9
        TBfhdlKpNwJe2L3gOuT5kVb9wg2cBVgi
X-Google-Smtp-Source: AKy350bUBWSfZSFpny7sKnrBavGEInYMGwjW5CLYuolH1Zq/vpnU4LRHniBKlCuAZjAd3AFLXmJA2WiJCx1a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a544:20a5:5228:d98f])
 (user=irogers job=sendgmr) by 2002:a81:b647:0:b0:534:d71f:14e6 with SMTP id
 h7-20020a81b647000000b00534d71f14e6mr6018156ywk.9.1679967714150; Mon, 27 Mar
 2023 18:41:54 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:40:57 -0700
In-Reply-To: <20230328014058.870413-1-irogers@google.com>
Message-Id: <20230328014058.870413-6-irogers@google.com>
Mime-Version: 1.0
References: <20230328014058.870413-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 5/6] perf util: Move input_name to util
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

input_name is the name of the input perf.data file, but having it in
perf.c makes it difficult to link without perf.c. Move it to util.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c     | 2 +-
 tools/perf/builtin-buildid-list.c | 2 +-
 tools/perf/builtin-c2c.c          | 2 +-
 tools/perf/builtin-data.c         | 2 +-
 tools/perf/builtin-evlist.c       | 2 +-
 tools/perf/builtin-kmem.c         | 2 +-
 tools/perf/builtin-kwork.c        | 2 +-
 tools/perf/builtin-mem.c          | 2 +-
 tools/perf/builtin-sched.c        | 2 +-
 tools/perf/builtin-stat.c         | 2 +-
 tools/perf/builtin-timechart.c    | 2 +-
 tools/perf/perf.c                 | 1 -
 tools/perf/perf.h                 | 1 -
 tools/perf/ui/browsers/hists.c    | 2 +-
 tools/perf/util/util.c            | 2 ++
 tools/perf/util/util.h            | 2 ++
 16 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 4750fac7bf93..5a93a37318cc 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -15,7 +15,6 @@
 #include <linux/zalloc.h>
 #include "util/symbol.h"
 
-#include "perf.h"
 #include "util/debug.h"
 
 #include "util/evlist.h"
@@ -36,6 +35,7 @@
 #include "util/block-range.h"
 #include "util/map_symbol.h"
 #include "util/branch.h"
+#include "util/util.h"
 
 #include <dlfcn.h>
 #include <errno.h>
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 00bfe89f0b5d..b6816c4dd889 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2009, Arnaldo Carvalho de Melo <acme@redhat.com>
  */
 #include "builtin.h"
-#include "perf.h"
 #include "util/build-id.h"
 #include "util/debug.h"
 #include "util/dso.h"
@@ -18,6 +17,7 @@
 #include "util/session.h"
 #include "util/symbol.h"
 #include "util/data.h"
+#include "util/util.h"
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/err.h>
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d3181fee4d3d..6c12f0865860 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -41,10 +41,10 @@
 #include "symbol.h"
 #include "ui/ui.h"
 #include "ui/progress.h"
-#include "../perf.h"
 #include "pmu.h"
 #include "pmu-hybrid.h"
 #include "string2.h"
+#include "util/util.h"
 
 struct c2c_hists {
 	struct hists		hists;
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index b2a9a3b7f68d..ce51cbf6dc97 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -3,10 +3,10 @@
 #include <stdio.h>
 #include <string.h>
 #include "builtin.h"
-#include "perf.h"
 #include "debug.h"
 #include <subcmd/parse-options.h>
 #include "data-convert.h"
+#include "util/util.h"
 
 typedef int (*data_cmd_fn_t)(int argc, const char **argv);
 
diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index b1076177c37f..7117656939e7 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -7,7 +7,6 @@
 
 #include <linux/list.h>
 
-#include "perf.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evsel_fprintf.h"
@@ -18,6 +17,7 @@
 #include "util/debug.h"
 #include <linux/err.h>
 #include "util/tool.h"
+#include "util/util.h"
 
 static int process_header_feature(struct perf_session *session __maybe_unused,
 				  union perf_event *event __maybe_unused)
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index f3029742b800..8bc2d1775ed8 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
-#include "perf.h"
 
 #include "util/dso.h"
 #include "util/evlist.h"
@@ -24,6 +23,7 @@
 
 #include "util/debug.h"
 #include "util/string2.h"
+#include "util/util.h"
 
 #include <linux/kernel.h>
 #include <linux/numa.h>
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index dc59d75180d1..a9395c52b23b 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -6,7 +6,6 @@
  */
 
 #include "builtin.h"
-#include "perf.h"
 
 #include "util/data.h"
 #include "util/evlist.h"
@@ -20,6 +19,7 @@
 #include "util/string2.h"
 #include "util/callchain.h"
 #include "util/evsel_fprintf.h"
+#include "util/util.h"
 
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index dedd612eae5e..93caf50df895 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -4,7 +4,6 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include "builtin.h"
-#include "perf.h"
 
 #include <subcmd/parse-options.h>
 #include "util/auxtrace.h"
@@ -22,6 +21,7 @@
 #include "util/pmu-hybrid.h"
 #include "util/sample.h"
 #include "util/string2.h"
+#include "util/util.h"
 #include <linux/err.h>
 
 #define MEM_OPERATION_LOAD	0x1
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 86e18575c9be..96a0dceadeff 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
-#include "perf.h"
 #include "perf-sys.h"
 
 #include "util/cpumap.h"
@@ -27,6 +26,7 @@
 
 #include "util/debug.h"
 #include "util/event.h"
+#include "util/util.h"
 
 #include <linux/kernel.h>
 #include <linux/log2.h>
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7ef565ae7265..31ac7a68a36c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -41,7 +41,6 @@
  */
 
 #include "builtin.h"
-#include "perf.h"
 #include "util/cgroup.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
@@ -71,6 +70,7 @@
 #include "util/bpf_counter.h"
 #include "util/iostat.h"
 #include "util/pmu-hybrid.h"
+#include "util/util.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 6c629e7d370a..bce1cf896f9c 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -24,7 +24,6 @@
 #include "util/thread.h"
 #include "util/callchain.h"
 
-#include "perf.h"
 #include "util/header.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
@@ -37,6 +36,7 @@
 #include "util/debug.h"
 #include "util/string2.h"
 #include "util/tracepoint.h"
+#include "util/util.h"
 #include <linux/err.h>
 #include <traceevent/event-parse.h>
 
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 441c354b8304..38cae4721583 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -40,7 +40,6 @@
 #include <linux/zalloc.h>
 
 static int use_pager = -1;
-const char *input_name;
 
 struct cmd_struct {
 	const char *cmd;
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 989eb17ec474..49e15e2be49e 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -8,7 +8,6 @@
 #define MAX_NR_CPUS			2048
 #endif
 
-extern const char *input_name;
 extern bool perf_host, perf_guest;
 
 enum perf_affinity {
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b72ee6822222..23d1b592ebc0 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -29,8 +29,8 @@
 #include "../../util/top.h"
 #include "../../util/thread.h"
 #include "../../util/block-info.h"
+#include "../../util/util.h"
 #include "../../arch/common.h"
-#include "../../perf.h"
 
 #include "../browsers/hists.h"
 #include "../helpline.h"
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index b356c9f7f0c3..0cdd459a319d 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -28,6 +28,8 @@
  * XXX We need to find a better place for these things...
  */
 
+const char *input_name;
+
 bool perf_singlethreaded = true;
 
 void perf_set_singlethreaded(void)
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 5010abf9e01e..8bd515b67739 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -18,6 +18,8 @@
 extern const char perf_usage_string[];
 extern const char perf_more_info_string[];
 
+extern const char *input_name;
+
 /* General helper functions */
 void usage(const char *err) __noreturn;
 void die(const char *err, ...) __noreturn __printf(1, 2);
-- 
2.40.0.348.gf938b09366-goog

