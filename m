Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849196DC940
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjDJQZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjDJQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:25:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F819A8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:25:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c17fb245dso112596767b3.21
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681143937;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4x5msFieB8TY6JG6tSeqo1a6qx829CImWZ+KZOZZfE=;
        b=e53R/pdxxmjNLL/YdPjB7kGGvR9zVdxHM44CxcOKHkGiOemqQwrY/UqI000B2tfd+M
         1m2C3T+iKURD70k3cvjezTvZ/prcAhpHU6yhdD2aXN/7vaX6fPzRznIIgg4n2d00zhuv
         k4v8xTJG58hSOzGkzxx2ZkxqFsPGMdcHqs9JY6oFgcwG5tW0oPbSo9csGJaA0MkfH6px
         5JyrL1lUN9zaJjZupkDcLYPZc3MVAbB1ejP5vIdqUDgBYM7aehy4ZKhZF/tTsTtplv6C
         fjpwi2GebeO5zMY4Ge65sGf0yn8GfGKhHrdUjM26M86LassaGijU8bOhGCkMZCLI9Jz7
         nS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681143937;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4x5msFieB8TY6JG6tSeqo1a6qx829CImWZ+KZOZZfE=;
        b=SUJ9G3wmuPCMAhvNPJref26gxeDlH863HBaiZBsFwuUEoOGuSFPOSAJcNEVE6OB1ky
         pM1rcOcPnfcvwkHFVeaLYK7XBLdByLb2tmgVoqEoobWXMeWu07JcnnesltGk93B6NPy1
         Q/n78fTxiGaEkr9PoDVYkyGQ7A22uc8t9SqzyP6i3eTut8DFDP7oyfL9fSiU0/yZWuCx
         FZihA4H1vl8dD9s/mi9n8H8F8L/QJ+T5rpbP66lMm2RGJl2ohdj7DSsR7F+bnC59jNhX
         mVStc6pY0P0DlGeGWc/nB2WPvLQPv6glAgo/R7EnO5lPWzPn2cLGdoOotY1fBO78wVXW
         4p+w==
X-Gm-Message-State: AAQBX9dxYEdrruV9QGFH8PTgDgo7OcB7s0SnRoaMgVm/c9izVu0lSGDd
        5zCdDzIh/6qi+d1f0DQr7sZoFiSUjagt
X-Google-Smtp-Source: AKy350YrukwsAdTNyI0Wf/shTLngC5JsNxShCv0sFeg6K/Q0S0/5mPyD26PL9G5B9RdD/SJchYtYowRZMe00
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc51:6a03:541d:a18d])
 (user=irogers job=sendgmr) by 2002:a25:7612:0:b0:b8e:ec30:853e with SMTP id
 r18-20020a257612000000b00b8eec30853emr2112770ybc.4.1681143937400; Mon, 10 Apr
 2023 09:25:37 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:25:06 -0700
In-Reply-To: <20230410162511.3055900-1-irogers@google.com>
Message-Id: <20230410162511.3055900-2-irogers@google.com>
Mime-Version: 1.0
References: <20230410162511.3055900-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 1/6] perf ui: Move window resize signal functions
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

Move under tools/perf/ui rather than in perf.c.

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
2.40.0.577.gac1e443424-goog

