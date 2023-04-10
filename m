Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF76DC942
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDJQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjDJQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:26:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25EA1727
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:25:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54efad677cbso49167277b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681143946;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltJwrJcS5zG2bCT4+GplpXfeO819XnkFUs/Trn7Oeps=;
        b=JOp/+aX/o5synz6pDxP1umm3bEXkb7P1Ea8j436nJfKATGjPyb6qB2aOkLPNVNcvj8
         2maWSZuv2uiKpFb44vh5H7Qa3XdxdXS6evU1KNkO8gHiiN/fE09plTF+YNcDOuI+rke9
         EUy9Q09MqBdqt4sduXNh44rI9+/qLZvJvFNsWaoSlV7MMcn1FkfZzB8NZcmYA5CpJVCH
         31nfPzq/cONcl4BeaPjxpoNAr+9KUK6doWTQa2HktlaYXIfxXQ72Y4JmmEPBbfJafHFx
         j5xD9AG7NErwtUBDfVxXQv3oWjThGlizVMKIiAxKKD9AaCAVmicJjq4hNOebUyNKYmtg
         dbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681143946;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltJwrJcS5zG2bCT4+GplpXfeO819XnkFUs/Trn7Oeps=;
        b=Yh7wXMZkW+I4SbQrpLKxISuTBPci+BozHbz0NeJJxPtBzBMd+K2OHJm5UbUpO2niyT
         eYrWTu4B3gmuWpqDMif7UGFbfEtd/cz+jpQRoi6K9iMT/XIYpCWDKWNtEKzowVfaASbC
         +Opswi7WVdHae7AHZNmDPujG7IEc82dmGE1L9pXFENfGMJU6uyYRS/7bAHLHv1yZvdry
         TswRz6GXIjEdbDUhxpzQ+rc1epSCOUPEpbm5PmBpu2XJkq7zTDaDkKoRRAXgAuUKaGZu
         iQWeXdicCrMpQLuRyiMMoqrLjo8MsmathvKJxP+IiGWc16bHXh9YTZTgosKEFDT9nwoh
         ydBQ==
X-Gm-Message-State: AAQBX9dCxaTSRDP+LHmSfeHZVY5wg254a4ckvHwvV8xxtPulQ2kZXRLJ
        qYP5HBWQ3hKTQm51557jBVrf9dHf1QVT
X-Google-Smtp-Source: AKy350brhH8r3zG3fNPseFmqcLKPZ39CearAHRvBHkmjMWzSvwbZzj45ONsmp2U3Z0wDblFv+5IYvENPp9aw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc51:6a03:541d:a18d])
 (user=irogers job=sendgmr) by 2002:a05:6902:909:b0:a27:3ecc:ffe7 with SMTP id
 bu9-20020a056902090900b00a273eccffe7mr9982639ybb.3.1681143945997; Mon, 10 Apr
 2023 09:25:45 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:25:07 -0700
In-Reply-To: <20230410162511.3055900-1-irogers@google.com>
Message-Id: <20230410162511.3055900-3-irogers@google.com>
Mime-Version: 1.0
References: <20230410162511.3055900-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 2/6] perf usage: Move usage strings
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

The usage function is part of util.h, move the usage strings there
too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-help.c | 1 +
 tools/perf/builtin.h      | 3 ---
 tools/perf/perf.c         | 6 ------
 tools/perf/util/usage.c   | 6 ++++++
 tools/perf/util/util.h    | 3 +++
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 3976aebe3677..3e7f52054fac 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -14,6 +14,7 @@
 #include <subcmd/run-command.h>
 #include <subcmd/help.h>
 #include "util/debug.h"
+#include "util/util.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index d03afea86217..f2ab5bae2150 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -2,9 +2,6 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
-extern const char perf_usage_string[];
-extern const char perf_more_info_string[];
-
 void list_common_cmds_help(void);
 const char *help_unknown_cmd(const char *cmd);
 
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 4b1b31e78332..997bb9ea5ebc 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -39,12 +39,6 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
-const char perf_usage_string[] =
-	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
-
-const char perf_more_info_string[] =
-	"See 'perf help COMMAND' for more information on a specific command.";
-
 static int use_pager = -1;
 const char *input_name;
 
diff --git a/tools/perf/util/usage.c b/tools/perf/util/usage.c
index 196438ee4c9d..4c8ffbad2323 100644
--- a/tools/perf/util/usage.c
+++ b/tools/perf/util/usage.c
@@ -12,6 +12,12 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 
+const char perf_usage_string[] =
+	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
+
+const char perf_more_info_string[] =
+	"See 'perf help COMMAND' for more information on a specific command.";
+
 static __noreturn void usage_builtin(const char *err)
 {
 	fprintf(stderr, "\n Usage: %s\n", err);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 1d3b300af5a1..5010abf9e01e 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -15,6 +15,9 @@
 #include <internal/cpumap.h>
 #endif
 
+extern const char perf_usage_string[];
+extern const char perf_more_info_string[];
+
 /* General helper functions */
 void usage(const char *err) __noreturn;
 void die(const char *err, ...) __noreturn __printf(1, 2);
-- 
2.40.0.577.gac1e443424-goog

