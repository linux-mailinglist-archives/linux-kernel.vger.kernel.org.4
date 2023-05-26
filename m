Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DBD712C85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbjEZSer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242970AbjEZSee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07557E50
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565b499da27so17873937b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126067; x=1687718067;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mg4J8yOoFJqVXDcfLSzXxOpYuu0uUpLyOopzOmgG+GA=;
        b=n1dWVzJumYPqquf3AtFTkMqsKMhFYFXmNs0t2HnKL88hQA4v6Ibxm+TCiKhbYWdRwh
         VmG103abbF9HUrkRFP/vKK/kbdOSodBmqlC/EuFl/HzlUDqUHhun2s/+HWSoreWy7ggn
         QhKdbgzhVOIHp2eOdtgkqOQSqb4wC+nJU4hQsiA1K6N3e3Ik1DcYfRLSvPlLjEPSHtG0
         um0IAylAqVQph3/kzRTsShYuehHswG19T8zyZEHPcaoqF69EGMf018r1xF6TFq/J2zrZ
         Huac43w3F1sFy+rW6DGUO3KmPbJ9cIsZ6rQRiSY9g+MwUGepIfCWIrNP04jXMJ8alMpA
         iuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126067; x=1687718067;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mg4J8yOoFJqVXDcfLSzXxOpYuu0uUpLyOopzOmgG+GA=;
        b=C5mk8FOE82TyNojJalQtXtv2owNrubbCNz9CdfAXTwVea3PPUGTzjJYBJQhjqyvYW2
         9Z3fyStspA1jRCAAZSac4A/jAo6O7m0cyx4KLn7VqEfT5sKhLhwOrcm9aFO6jEezBis6
         2Bsf0/WXNaSjHyCbEn2AWSuGiO4LlMo0jsvJ29cLllaYaJDPoXPxfpyR/Bu3R2KH23wU
         aOQBOhtryS5VyEgUWeWgmGMlLOk+tMv4cWXudaP747E6ABv1NRa8vLzWqJfmYDTQKnxG
         bDspFhvo7lc2gTXhyB7lilsDM3E3CPgL7I2x8KPzmObi2OaECCqttLifCpfqtpxAlAIL
         aApA==
X-Gm-Message-State: AC+VfDxaJJ/s6Mo1pFPo582R9YQTCZ2Js1NvK/vGZRURO1UFQIX5nyLR
        wcXz0Vjckwaev3RzcmiBh/EdOl6bi5q0
X-Google-Smtp-Source: ACHHUZ5IYodYw9VMjSfCF3zdkFtLGuakHr3lV7rTHVBH3QX87hgO8plHJE1SMhq5VhGDP18hgd7Rw1q/vZcu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a05:690c:82c:b0:561:4723:2088 with SMTP id
 by12-20020a05690c082c00b0056147232088mr2535720ywb.4.1685126067272; Fri, 26
 May 2023 11:34:27 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:52 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-8-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 07/16] tools lib api fs tracing_path: Remove two unused
 MAX_PATH paths
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

tracing_mnt was set but never written. tracing_events_path was set and
read on errors paths, but its value is exactly tracing_path with a
"/events" appended, so we can derive the value in the error
paths. There appears to have been a missing "/" when
tracing_events_path was initialized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/tracing_path.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 7ba3e81274e8..30745f35d0d2 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -13,17 +13,12 @@
 
 #include "tracing_path.h"
 
-static char tracing_mnt[PATH_MAX]  = "/sys/kernel/debug";
 static char tracing_path[PATH_MAX]        = "/sys/kernel/tracing";
-static char tracing_events_path[PATH_MAX] = "/sys/kernel/tracing/events";
 
 static void __tracing_path_set(const char *tracing, const char *mountpoint)
 {
-	snprintf(tracing_mnt, sizeof(tracing_mnt), "%s", mountpoint);
 	snprintf(tracing_path, sizeof(tracing_path), "%s/%s",
 		 mountpoint, tracing);
-	snprintf(tracing_events_path, sizeof(tracing_events_path), "%s/%s%s",
-		 mountpoint, tracing, "events");
 }
 
 static const char *tracing_path_tracefs_mount(void)
@@ -149,15 +144,15 @@ int tracing_path__strerror_open_tp(int err, char *buf, size_t size,
 			/* sdt markers */
 			if (!strncmp(filename, "sdt_", 4)) {
 				snprintf(buf, size,
-					"Error:\tFile %s/%s not found.\n"
+					"Error:\tFile %s/events/%s not found.\n"
 					"Hint:\tSDT event cannot be directly recorded on.\n"
 					"\tPlease first use 'perf probe %s:%s' before recording it.\n",
-					tracing_events_path, filename, sys, name);
+					tracing_path, filename, sys, name);
 			} else {
 				snprintf(buf, size,
-					 "Error:\tFile %s/%s not found.\n"
+					 "Error:\tFile %s/events/%s not found.\n"
 					 "Hint:\tPerhaps this kernel misses some CONFIG_ setting to enable this feature?.\n",
-					 tracing_events_path, filename);
+					 tracing_path, filename);
 			}
 			break;
 		}
@@ -169,9 +164,9 @@ int tracing_path__strerror_open_tp(int err, char *buf, size_t size,
 		break;
 	case EACCES: {
 		snprintf(buf, size,
-			 "Error:\tNo permissions to read %s/%s\n"
+			 "Error:\tNo permissions to read %s/events/%s\n"
 			 "Hint:\tTry 'sudo mount -o remount,mode=755 %s'\n",
-			 tracing_events_path, filename, tracing_path_mount());
+			 tracing_path, filename, tracing_path_mount());
 	}
 		break;
 	default:
-- 
2.41.0.rc0.172.g3f132b7071-goog

