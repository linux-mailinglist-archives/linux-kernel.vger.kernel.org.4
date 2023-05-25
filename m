Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB5471060F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbjEYHNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbjEYHMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:12:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E3CE47
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8c3186735so529537276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998734; x=1687590734;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uig2l1ENW/mdXFGb6s2gWNQOI7wDuYaOhOqcyff66lU=;
        b=WFkyDn+GM9s1OIHNVKuObZVdfyEZgexFdMsTstTrvYmg9t0RLdNZwjobMYNXSiayqX
         khdAEV+aAP+kS+KCdxiXzwt7cFGQekt2njUxpoLxg5X5nXeYUFBVxaCHh8k7FsxIAa19
         eJMSph0uDPi+oHI37ag0tTtjJHP6wcgWD1YGT8mxGrbueNL9TqBDYv6xD9nXfZcVOG3D
         M1JYUzFkmRoKy89SbJud+5Aiy165HXKl1JUVzhZEgqAbX+N6Y5Cm4DsH2R75XtuDNPbj
         4Px/9KkCG1kgjvpLPmH7/005l1lS0MEqo7SWmP+4ScZUAFd8tXIU7GgquBDoQ6Ax2Xhz
         UzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998734; x=1687590734;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uig2l1ENW/mdXFGb6s2gWNQOI7wDuYaOhOqcyff66lU=;
        b=cFZus7+QttGAxekP1BAQbTJDpR9WloNb3A32gRa9RSr9tRjPcKtc/uGKetXYuqQw/G
         sU/l5V+N4utMiQznwip4XSNk4hldX3KJOgf96eevIOF5QUzT4uXSv44WFszGAUzr+CaX
         hdxHKNsPPnnI82+998NNin5ZKjUj45mr4gMif40qt7wTSvzCYecdKHm9GCQGc3m9L75k
         mn09IOi4sYZUsLgdawMvwAlbJSwXJYkq7av7GNFYYVMu/8xBQV3iuhcENnYapinPo/pe
         /Pori0g0hepy+I4UEBdwV6cYljMmYFR4p2EiR4POT/FR1PQRmYnDfEySRWHydHgtSPqi
         hBNw==
X-Gm-Message-State: AC+VfDyC7wYCw5TmcRMV2bLkkU+Zyd9dX7mvSwMLH27yLBjZKcD1NMGr
        2PjsfVl+EOVPEfXMcvZyBiU9NnZbZpNW
X-Google-Smtp-Source: ACHHUZ5yqtiQnY7SZWdEmci8o4nFxrT52OQmcvPZ769+IpbJUqBpS9Sahk1sEapJJzGEI75KmWqAlmB6gHKV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a05:6902:1813:b0:ba8:4000:d7e1 with SMTP
 id cf19-20020a056902181300b00ba84000d7e1mr1224821ybb.2.1684998734413; Thu, 25
 May 2023 00:12:14 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:24 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-8-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 07/16] tools lib api fs tracing_path: Remove two unused
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
2.40.1.698.g37aff9b760-goog

