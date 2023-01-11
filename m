Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C8A665501
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjAKHHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbjAKHHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:07:10 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F410B1FA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:07:09 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-46658ec0cfcso153727927b3.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFrSxVrfdRZYprem1a+EonI6bqjM3AdjO9gRlJ+kQ1E=;
        b=MO/3evZ7yJJjjP0LMQV02qoI0xTtd6ha4a5z3beUr4g0O6L8XONbEla8E2UdAZJIbf
         84d93jxMcIe/UtdsXQcdt7czglCY/neqTcmt6w5Io248fs3NJqvNmufUyQJujptJGxZy
         3WmXrND91U9ecYTl4mOmCiwhRPOXiAh6TpgPmLbKp1sNihUYYzMD+O/diiFqdg56XIKm
         Ln/GcLW6voOZp4w/UOreYmTpKzpxGVVN9OIN2cv4npA3nLuNohm5USCvFybojI+eWR3X
         OunlVvkVtHpoEL4jFNB411m19HuOMIiY+maxmTRvTDXnwgqZbFtk5TsPxrk0ZiEt5cl6
         1uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFrSxVrfdRZYprem1a+EonI6bqjM3AdjO9gRlJ+kQ1E=;
        b=19QFTjvBR+sCUjEyz0/l+/TFYQwI8JZk4A+K20GL67S8OpLQqj9jc29nbDSAvso+X2
         LbwcZatgksbFVaPCe7MaLFUf6oCPSLRVQx6u+bddxA7X/ZF+/bvIHt+RSt3+unufL832
         r9kI2lYgNwvXh3u6TQqodbPyiM8ZkmgyGf4T8Xvr8FZAtLfCFKbnj6mhBwahhmSc3lPc
         RcFKb4TtFtiQ1k/0BBLCLQawEBAxwuuKdYq8773hL2ZsVvy1XBz8enGNXZR6QGnvSF8r
         qLRsc4025p+xxaba1tON7lPHyPB6DVQP/BvpZ0gNIGbGvYZuyk3T0n5dPewlO/1fNqbS
         UdQg==
X-Gm-Message-State: AFqh2krr+mN6SsTE8+RwYNVA26sT9eYKO2y1uzt1NYpzcnftTSpMXhmU
        rBYDN+XJ+VwsJgb+CJW3nj53OFBfuDa7
X-Google-Smtp-Source: AMrXdXvQpil6jNPjSq/pZkWtOVRcWOV7+fsElOsbRFULBMoe4nkR1bf1Twel/XVb4Qj+4pg7OVSInxkCfaDU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a25:3758:0:b0:7b5:f176:e485 with SMTP id
 e85-20020a253758000000b007b5f176e485mr2208774yba.556.1673420828555; Tue, 10
 Jan 2023 23:07:08 -0800 (PST)
Date:   Tue, 10 Jan 2023 23:06:41 -0800
In-Reply-To: <20230111070641.1728726-1-irogers@google.com>
Message-Id: <20230111070641.1728726-3-irogers@google.com>
Mime-Version: 1.0
References: <20230111070641.1728726-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 3/3] perf debug: Increase libtraceevent logging when verbose
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

