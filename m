Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38896CB341
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjC1BmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjC1Bl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:41:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F310E26AC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:41:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e186-20020a2537c3000000b00b72501acf50so10598960yba.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679967707;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2whu1qno1W8kHsCGkEHqnVJzukiPVbxiNAF9c06UxCw=;
        b=dzIAs3yWxD9SpgkK4CCF49PQD8Zw4LTXKF4G+QesWtXDq5wdN44G9UzTYlL7lEjRUt
         FcZaUmeLeh7UdjPykT4b0MCcZWMp+4dWk8y6AS0Gn61MYeW8uTdDc+9HNNM9YhCrG5k6
         z6lEGiunAyGIVoM36gsdf2Yfsbz1wfwp6gQ+CxC6UQkSN/Wuo2SmJTmURn2Vq0DrDzLi
         Xe5yXFnEpGBnoW0+NU+2i+qZHCVlfrGiWuZwvSzM/qd8fBjvIuNs2qMLEBelBE1DxeVr
         Y8DyyJ5QWcOWHpDdVAlL7zpzsoX/2tPUoVDox+4rTAZBisx51TTtDUPATsagqJY4zrea
         w/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679967707;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2whu1qno1W8kHsCGkEHqnVJzukiPVbxiNAF9c06UxCw=;
        b=xOKdqLY3Rcr7y+bza2m5BXiaa4wlUJWudyIPzbf7JxNUeRPJL/waryjwdCMVECZSBj
         KI3Ku8NBUPZBUZNHGih/cKh1KopJfTvYg4Rl+jfiYqzZzv3Z8EyNP5u7wRc8pRUCz/Xw
         ttgLb2G5dPTsdATgrGz0dJbLhP/PrYZTJC+5FsAUJ8HbZ5JxfNrLPRzACA6aggOt2GJa
         MfcGUpu1XkPPxa8jwRS8GOCFAaKZqNv41bqUKsu+P+BRNU3eRuC87+h2FZ0Wc7Q338mt
         SJ/2lprMW958zbmiQplO32yuvrxjE/vfuZGjhnToJXyosN/KXi0FwVnKcQYmXN56IFPk
         rtgw==
X-Gm-Message-State: AAQBX9ctWQio4ic2jBnyzz5obugldF5wL4j1IEZVleJRB2EUcTCzb5ok
        ypypIu31TQ1r9Zzdnrd5DJ0su+TsQhfo
X-Google-Smtp-Source: AKy350b1a/nh466GprtSUGyffhrOZ45C91uTo++lFce4psNXjIgoG3WvpR2OPr4gdCSrV/EcpF7e2bsmn/jG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a544:20a5:5228:d98f])
 (user=irogers job=sendgmr) by 2002:a05:6902:1245:b0:b77:d2db:5fa4 with SMTP
 id t5-20020a056902124500b00b77d2db5fa4mr8546242ybu.8.1679967707068; Mon, 27
 Mar 2023 18:41:47 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:40:56 -0700
In-Reply-To: <20230328014058.870413-1-irogers@google.com>
Message-Id: <20230328014058.870413-5-irogers@google.com>
Mime-Version: 1.0
References: <20230328014058.870413-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 4/6] perf version: Use regular verbose flag
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

Remove additional version_verbose flag by using the existing verbose
variable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-version.c | 5 ++---
 tools/perf/perf.c            | 2 +-
 tools/perf/perf.h            | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 4a43043ca8ef..1872c90a6667 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 #include "color.h"
+#include "util/debug.h"
 #include "util/header.h"
 #include <tools/config.h>
 #include <stdbool.h>
@@ -8,8 +9,6 @@
 #include <string.h>
 #include <subcmd/parse-options.h>
 
-int version_verbose;
-
 struct version {
 	bool	build_options;
 };
@@ -92,7 +91,7 @@ int cmd_version(int argc, const char **argv)
 
 	printf("perf version %s\n", perf_version_string);
 
-	if (version.build_options || version_verbose == 1)
+	if (version.build_options || verbose > 0)
 		library_status();
 
 	return 0;
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 997bb9ea5ebc..441c354b8304 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -212,7 +212,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 
 		if (!strcmp(cmd, "-vv")) {
 			(*argv)[0] = "version";
-			version_verbose = 1;
+			verbose = 1;
 			break;
 		}
 
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 20e9b93f8a39..989eb17ec474 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -18,5 +18,4 @@ enum perf_affinity {
 	PERF_AFFINITY_MAX
 };
 
-extern int version_verbose;
 #endif
-- 
2.40.0.348.gf938b09366-goog

