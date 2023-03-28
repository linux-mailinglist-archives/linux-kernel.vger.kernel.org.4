Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC256CB33E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjC1BlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjC1BlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:41:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE826B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:41:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5425c04765dso104517127b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679967679;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqR7zTtQQ91G+i7rdFae6kUQGU5KFoZk0zOPgnQCq6I=;
        b=B0Dfmb6o01HAanc4lrfMoiaVNxqL0S2uylr1cXL/LiDQbcynQSWWeWuK52OcNkqXai
         QT7QsiO9SEPdgRXDloU0JIN+nKU+2TmkBNosJoA5xIs1JCiGejNGO/tZOP9bZCWmIWNG
         7gXaShd/TOmMs1NSBtum/P6ZzOTj7f2GCWL52s8tOnJyLnukOtdxC+Z3GPCnDLzopeBq
         tCPdVCa/jwQ+mkEQrsnsJf/Iboxf4nZL6EmAphMO/Mf0oWUsk6QuG+c3S2MiieBUuWuE
         25edoBOZkfXGG7hBrQ7aq+V2VnCtWtCCETyg39xV6ZD3BGmJa48J1hYow60AXVKBAQ+m
         LHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679967679;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqR7zTtQQ91G+i7rdFae6kUQGU5KFoZk0zOPgnQCq6I=;
        b=SvKxSp+o6h+7z1p2zM0BBSxQKaixDdZ6oK/q7tgtOx1aiob3SMGFMmjd8v85mqAffS
         p2izXH7NFrp+nikiA1d2vkYqQ0jBPA7/E81rNqLyf8efX1DneznyLjE0xWzDPTxp5Ph0
         TryAPbAXtfENNn6iZ8ZVFFogRebW9D37gTVDBNl/3uwTaC14QGn3NeSYK4Bm5K9LGPWX
         xQtrwgHAzhstR9UgdRZs5iNf0DR0SRddR6vo1mdKLGXfeUUbdIUNf0z5MFmInraK5eWZ
         3aSI9Ki+32aDL5VbeWA82rDwP4r197sdBooBwxhYis4OCwUsNVGhsM9JxnPrMicfU0j6
         24tw==
X-Gm-Message-State: AAQBX9d1rjripsXj6FgFwwha/GXPWlwzx2hua5p7dc6soAwRxcN+JSRS
        +B0cq//mxZ11Ej9V8RXE1SZ26ep/mwZ1
X-Google-Smtp-Source: AKy350ZQ0hlk2F8Saos9KfdCnbLkngJsg5ccYINLqQhqBFeKNhcn7HtzaZFNMEEOmc7mdPvGEpI8gXZ6j9EV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a544:20a5:5228:d98f])
 (user=irogers job=sendgmr) by 2002:a05:6902:110b:b0:b71:addc:e19c with SMTP
 id o11-20020a056902110b00b00b71addce19cmr6723016ybu.8.1679967678878; Mon, 27
 Mar 2023 18:41:18 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:40:53 -0700
In-Reply-To: <20230328014058.870413-1-irogers@google.com>
Message-Id: <20230328014058.870413-2-irogers@google.com>
Mime-Version: 1.0
References: <20230328014058.870413-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 1/6] perf ui: Move window resize signal functions
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

Move under tools/perf/ui rather than in perf.c. This simplifies
linking a main function when perf.c isn't present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/perf.c         | 18 ------------------
 tools/perf/perf.h         |  2 --
 tools/perf/ui/setup.c     | 19 +++++++++++++++++++
 tools/perf/ui/tui/setup.c |  1 -
 tools/perf/ui/ui.h        |  3 +++
 5 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 82bbe0ca858b..4b1b31e78332 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -432,24 +432,6 @@ static int run_argv(int *argcp, const char ***argv)
 	return 0;
 }
 
-static void pthread__block_sigwinch(void)
-{
-	sigset_t set;
-
-	sigemptyset(&set);
-	sigaddset(&set, SIGWINCH);
-	pthread_sigmask(SIG_BLOCK, &set, NULL);
-}
-
-void pthread__unblock_sigwinch(void)
-{
-	sigset_t set;
-
-	sigemptyset(&set);
-	sigaddset(&set, SIGWINCH);
-	pthread_sigmask(SIG_UNBLOCK, &set, NULL);
-}
-
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 74014033df60..e21a7e15a34c 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -12,8 +12,6 @@ extern const char *input_name;
 extern bool perf_host, perf_guest;
 extern const char perf_version_string[];
 
-void pthread__unblock_sigwinch(void);
-
 enum perf_affinity {
 	PERF_AFFINITY_SYS = 0,
 	PERF_AFFINITY_NODE,
diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index 25ded88801a3..ff800047e697 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dlfcn.h>
+#include <signal.h>
 #include <unistd.h>
 
 #include <subcmd/pager.h>
@@ -120,3 +121,21 @@ void exit_browser(bool wait_for_ok)
 	}
 	mutex_destroy(&ui__lock);
 }
+
+void pthread__block_sigwinch(void)
+{
+	sigset_t set;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGWINCH);
+	pthread_sigmask(SIG_BLOCK, &set, NULL);
+}
+
+void pthread__unblock_sigwinch(void)
+{
+	sigset_t set;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGWINCH);
+	pthread_sigmask(SIG_UNBLOCK, &set, NULL);
+}
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index a3b8c397c24d..c1886aa184b3 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -9,7 +9,6 @@
 #endif
 
 #include "../../util/debug.h"
-#include "../../perf.h"
 #include "../browser.h"
 #include "../helpline.h"
 #include "../ui.h"
diff --git a/tools/perf/ui/ui.h b/tools/perf/ui/ui.h
index 99f8d2fe9bc5..d8e911205582 100644
--- a/tools/perf/ui/ui.h
+++ b/tools/perf/ui/ui.h
@@ -31,4 +31,7 @@ struct option;
 
 int stdio__config_color(const struct option *opt, const char *mode, int unset);
 
+void pthread__block_sigwinch(void);
+void pthread__unblock_sigwinch(void);
+
 #endif /* _PERF_UI_H_ */
-- 
2.40.0.348.gf938b09366-goog

