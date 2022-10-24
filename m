Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91BC60B673
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiJXS6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiJXS5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:57:44 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B6105350
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:44 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pf1-20020a17090b1d8100b002132a9a6a44so574117pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFzbgI1FGJfzvaw1p5CnFtlagUkgu7Ee7Fasb8Aycow=;
        b=g6qsNykjBvc8d3AMtRafZDv5pP5cGaxqxFeoYFGwLROZDHq+3WE2OKYgVBPVOjacpP
         Su1/KJ1NSg8qrV0haZyA6FY4ifaAtIIXYNxNPiIkdwfQ2D90z+QD1IlGh/RuxOWh7i2c
         VME/ZGXfkVOKwf52i6LRPxNoVKvaIcqHKhHTOIYGpRhjbjHoJkdkOpvZ88pUkrDAWJbd
         H9U69WkQT55DQxWyH4w6TKsAKG1luUqFVxlofXfJSOSNZe2uB2cFmt4300lCYBm2gv4L
         ovqlDuERntsgpv0Q3tM6N97YOvFooB+FhMo3fM41rUO1tHvbFUysFQORJzWsXB8HzkkY
         q4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFzbgI1FGJfzvaw1p5CnFtlagUkgu7Ee7Fasb8Aycow=;
        b=qLgndwvs8Zi4xzQsM1KrXlfc7pjMdK7fR1iU9tBkKHgH706/cEo9KCQKQvjjlWSKAX
         t0RhzA7+0sdMajz0wTyiFgRaj72vSoDZhqQihOoT8davOAcdcat14G4SnESEGSRJjiAH
         VVbqGAraSVGNXYLfz2q7PHxwagdHuxkTgpBumgLaxENCWysjKyMf476GkPd6AATP0eXO
         jsc2S71gvdj5gwOEXK3D0XT723HxEQY0T8fpGkNs6uYpKpcPjdBKJVYOvPPNt76vdr2F
         n/m4o7AkvW33dz6oqKDgtrSNjon+VNidv6dTIfH9xkaisnmyWjnZ3RbbY4hg5RXqDlSc
         uqAw==
X-Gm-Message-State: ACrzQf3AF3HttNy1c+FfqKmoU+eaD5DQv865CjdzSe/w3RJpacSETH9J
        Zx5JZCnTNCFWy+G3S7dog1kRJTiubjHG
X-Google-Smtp-Source: AMsMyM7mUsQM8EUDobG3QZ+jix6KAWAWUli4bv59QJYVuz1qp9NbUEOuW5M6v/oq3vRq+CSLYwvCIcA9tzN7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90b:1b03:b0:20d:ac3b:f1dd with SMTP id
 nu3-20020a17090b1b0300b0020dac3bf1ddmr65650424pjb.121.1666632982742; Mon, 24
 Oct 2022 10:36:22 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:20 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-6-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 5/8] perf session: Change type to avoid UB
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

session_done is written to inside the signal handler of perf report
and script. Switch its type to avoid undefined behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1a4f10de29ff..ba52cc4092dc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <stdatomic.h>
 #include <inttypes.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -2022,7 +2023,7 @@ static int perf_session__flush_thread_stacks(struct perf_session *session)
 					 NULL);
 }
 
-volatile int session_done;
+volatile sig_atomic_t session_done;
 
 static int __perf_session__process_decomp_events(struct perf_session *session);
 
-- 
2.38.0.135.g90850a2211-goog

