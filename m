Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17B960B907
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiJXUAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiJXT6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB8A27E079
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3691846091fso97002017b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N6W+CXwQP9ZcH6ztCYE0MpcmSu0rfOg+3GfDaO039jk=;
        b=MyyCJTcbNDcWyLPc/QWROdPmUsiRtgLtA0uZwhDYIaxhjKZzDxzsl0LiHcpqoHsJtK
         1uA9haRF3y8/UUCcPDlSPw8+dqL3V6VLOOb6vGOCckQozVmUJ12d87C6a10LYnyDMeGe
         IOjzMYM+Qk/DMWgi1nw/qHPpKQ7Sjio4Z2pee+crAwV8uPUxdioh1H32O9lF+3yXMrsu
         p+uwpa6xXEwn9uUvYsT2zOZBhvGXMdYYIM+P+3FTnb4A/4gA6e0Ms4EsPIQgfnvBOp8I
         dX2qW7UCwOEVF89oEkT0K59f5ns6ha35MwcUu7PlLh6ia4fRViZXBJqniEWLj+wtEmsH
         1YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6W+CXwQP9ZcH6ztCYE0MpcmSu0rfOg+3GfDaO039jk=;
        b=nvd58Vf1la2NtCnI5/m6+s0ybEPdTzBqa/p2kq3sh6HSLG1fdMF7vCj8zzC+6RJM5V
         00zQLRWYayy+rTpEyk1MgGtpf6iezfGYJiV7pxw9DI2OcYxIRdzYAdMXdDdaQSuIWyhk
         1zyfsM7PDQCkst71SbPfo3pMxMW7qv6Nk4V2cNTWzjf26t9XaDt56XixDQmFApCA0tgd
         6s7IiM/mVuMMCX6iof4xVmwohM+O/oZrg11VXLYmgVd6M4T0r1rmNYaSvySWglWCEvWt
         tQ4rRPtYgiMZ02ulxsYy9cr6xMYn/64Tdi9bcSRd024oF+9+Fg5MR4oCqBpZBw0L/0jL
         trWw==
X-Gm-Message-State: ACrzQf09u40jWT90EZ+rJuuBdsIpwv/+R82F/rxFAj2K66lJFjtsAc+7
        Kl3/IJ7ffSc+16J2VL7LNdsMT8xZ/O1M
X-Google-Smtp-Source: AMsMyM452qYtauCW4EO7scWSZkNj9sZ2nSnvYtqYPGuBG/6+zXZy0eh9dOLzUYkV9HTbdEPxf+TKeyEWlaGY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a0d:d954:0:b0:368:d5ea:fc6a with SMTP id
 b81-20020a0dd954000000b00368d5eafc6amr20555995ywe.50.1666635616419; Mon, 24
 Oct 2022 11:20:16 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:10 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-6-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 5/8] perf session: Change type to avoid UB
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index 1a4f10de29ff..0e1a3d6bacb9 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <signal.h>
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

