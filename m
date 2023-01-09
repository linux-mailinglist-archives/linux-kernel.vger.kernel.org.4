Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009276633FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbjAIWcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbjAIWbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:31:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1281869D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:31:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r8-20020a252b08000000b007b989d5e105so7200534ybr.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFrSxVrfdRZYprem1a+EonI6bqjM3AdjO9gRlJ+kQ1E=;
        b=ppMi4dw2Slp1jnmhvss74/eHVmvHieaVlcIWBKpzDDUUoVO74G5rN55j9D0jvTQSNw
         8/qn1YeUHnKjir3CaOQO/bm8jZ0gQ/eVsS7i4AFdaFhZWDksJE3owdE/2ZgGM50Cwx2c
         YTh/RZRsx/5+gvRsul6MEjRu5RY+Ij/6sH0fDJbvl9X26T4sXTRDGbyBYuX9WE4Aihd3
         eC7M0Ll+S88ye6K27g4T7F9ZmEqqjlfH3hSoZl2eQ1OsyhSKU1zb3u+NYEyVPZlZcdG0
         i+oV3AWmI5H5sKOdPAJxFjaFLhPOrmJl5dVOhA/5T7skkgRBuZTUfmAK+pP0tXGLq6G7
         g1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFrSxVrfdRZYprem1a+EonI6bqjM3AdjO9gRlJ+kQ1E=;
        b=7zXzv4TxtHnz1Bpao6Xx/jl6DBjbdf79Ncj/acvBVefHimGXpn38C4GOh1xUU7tVQs
         IwUdEUHAGwEvkBOEaax/NLW13okuQv2cmO71Q8Oq7bnmLTSmO7J17ej3EvSWazenSYjw
         aqpm33SaEnjPSMycLpPx529RwozfxLrQJrVH7Ik6zqpKJPFZM60pQnOEBgN2A83Q08/s
         3gIn6GQxS/YKStRSt+aNg3jh6kWkdyXJDlEd1Uo3RUPY4AcgIK9J5icZJbkklceVzGil
         JJGkiLcjfx+brP36aum37MohpMV1tFMG5zkCtLaraqWnefwZCTapMHFSEy6VNo1A8hsE
         Wo0w==
X-Gm-Message-State: AFqh2ko/ZWmtplAQ6UAHdBKJ685zDRpEL1cRH/8rrt7GFt788XLtw3Mn
        oxjio5XVz4x3N+A+ih3gQFhUbdRGoaef
X-Google-Smtp-Source: AMrXdXtsHKKuj+Y4f/kjNrdLpjadnRfENPPqNrntzWMQs26Z8MyYXCB8So5l4hb0ssfgF10qhZIsYbnMLASD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:59e7:81ad:bc43:d9dc])
 (user=irogers job=sendgmr) by 2002:a25:3055:0:b0:6fb:b4af:e56e with SMTP id
 w82-20020a253055000000b006fbb4afe56emr5643173ybw.60.1673303506855; Mon, 09
 Jan 2023 14:31:46 -0800 (PST)
Date:   Mon,  9 Jan 2023 14:31:10 -0800
In-Reply-To: <20230109223110.1201541-1-irogers@google.com>
Message-Id: <20230109223110.1201541-2-irogers@google.com>
Mime-Version: 1.0
References: <20230109223110.1201541-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 2/2] perf debug: Increase libtraceevent logging when verbose
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libtraceevent has added more levels of debug printout and with changes
like:
https://lore.kernel.org/linux-trace-devel/20210507095022.1079364-3-tz.stoyanov@gmail.com
previously generated output like "registering plugin" is no longer
displayed. This change makes it so that if perf's verbose debug output
is enabled then the debug and info libtraceevent messages can be
displayed.

This change was previously posted:
https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@google.com/
and reverted:
https://lore.kernel.org/linux-perf-users/20220109153446.160593-1-acme@kernel.org/
The previous failure was due to -Itools/lib being on the include path
and libtraceevent in tools/lib being version 1.1.0. This meant that
when LIBTRACEEVENT_VERSION was 1.3.0 the #if succeeded, but the header
file for libtraceevent (taken from tools/lib rather than the intended
/usr/include) was for version 1.1.0 and function definitions were
missing.

Since the previous issue the -Itools/lib include path has been
removed:
https://lore.kernel.org/lkml/20221109184914.1357295-1-irogers@google.com/
As well as libtraceevent 1.1.0 has been removed from tools/lib:
https://lore.kernel.org/lkml/20221130062935.2219247-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 190e818a0717..88378c4c5dd9 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -19,12 +19,19 @@
 #include "debug.h"
 #include "print_binary.h"
 #include "target.h"
+#include "trace-event.h"
 #include "ui/helpline.h"
 #include "ui/ui.h"
 #include "util/parse-sublevel-options.h"
 
 #include <linux/ctype.h>
 
+#ifdef HAVE_LIBTRACEEVENT
+#include <traceevent/event-parse.h>
+#else
+#define LIBTRACEEVENT_VERSION 0
+#endif
+
 int verbose;
 int debug_peo_args;
 bool dump_trace = false, quiet = false;
@@ -228,6 +235,14 @@ int perf_debug_option(const char *str)
 	/* Allow only verbose value in range (0, 10), otherwise set 0. */
 	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
 
+#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 3, 0)
+	if (verbose == 1)
+		tep_set_loglevel(TEP_LOG_INFO);
+	else if (verbose == 2)
+		tep_set_loglevel(TEP_LOG_DEBUG);
+	else if (verbose >= 3)
+		tep_set_loglevel(TEP_LOG_ALL);
+#endif
 	return 0;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

