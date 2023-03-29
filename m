Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E186CD0DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjC2DwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjC2DwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:52:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E61D2D4D;
        Tue, 28 Mar 2023 20:52:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id iw3so13701995plb.6;
        Tue, 28 Mar 2023 20:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680061933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pay3hwuHUUvDk/k43PBkEAY7fdDECNHycaAxPTjELlc=;
        b=MGWLkajRda3Cqk6mMMIOaQhYUEgKSMhRTVjJwqqcMRnvH48zClJm0NYufJpOHXdHZA
         V6bf4XQ/BwPJ9q7So/W4CxdNVI4oMc2zCZnUuPJjHADIwl2Cfrt4ZHJifOF0ePWoZaag
         QAqUEQPfMR/bV5j9160nNzX96cCucs9U91fj3DtGSK9kNIiG2bDO9jtCjg+toWrBT3Z7
         qqc5l5E9jY3f3JZQ6TaIY+syRAbnTxuDm8W6Lu8F+Soq0xJ9r/5+WxQRLUpyhqN2iyT0
         OKmB9/+I92cIfdHluvqCPrcFiKz7DE7fqQWDEt+KsXwio5Y/yZEGNN4yJ4qJ4vMoOXn8
         vvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680061933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pay3hwuHUUvDk/k43PBkEAY7fdDECNHycaAxPTjELlc=;
        b=7ttNFH+DOR14fn9n72pORb2FxHYTJnisTHViNSTZ/+e/gCiLtlS94ymqAt92kKZyY0
         0QmCw07D1Sf4aOh/SLjhGRj+/FxYhJSI11zDxFfra5KrMYQFgpu27Q8VlFCEnKweG6Cd
         VnYpG1dPP+viQn+m6zHoV9AZHgYNQMYIxWlaGlUdK8/qw1MUcTj4c8MdaIatN0fAtIRZ
         q1zN6LFVLjcUiopd7zwMKrdQudCcURoLZHiVi21KGrCI0PEIXibz0jlqaWLnKdYUXG/x
         6+a0bJSHxGostvgJxqV5sFqrxRGIR+1WxEsdiRqNre5rApLfco2cskhOSzqfnFqjI3As
         HgUw==
X-Gm-Message-State: AO0yUKWw8YxV3T+xXv/H8ORFi2tdMxvSQY7hPdCQRNPYx5AUF/ZXkwpv
        iH4lK5ahWHyTlP+YEocTKuQ=
X-Google-Smtp-Source: AKy350YXRZNFBA+X1w+E9+u2tOYjZnmh6LcHSZEZ51RxTTTubmDsoEwK1JYdci0WNGdUOeAa0eQBHA==
X-Received: by 2002:a17:90a:351:b0:23b:355f:b26c with SMTP id 17-20020a17090a035100b0023b355fb26cmr19825370pjf.23.1680061932648;
        Tue, 28 Mar 2023 20:52:12 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.10])
        by smtp.googlemail.com with ESMTPSA id e91-20020a17090a6fe400b0023f786a64ebsm311300pjk.57.2023.03.28.20.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 20:52:12 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ze Gao <zegao2021@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf sched: sync task state macros with kernel
Date:   Wed, 29 Mar 2023 11:52:02 +0800
Message-Id: <20230329035203.6194-1-zegao2021@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8ef9925b02c2 ("sched/debug: Add explicit TASK_PARKED printing")
changes some task state macros, this patch makes perf-sched in sync

Fixes: 8ef9925b02c2 ("sched/debug: Add explicit TASK_PARKED printing")
Signed-off-by: Ze Gao <zegao2021@gmail.com>
---
 tools/perf/builtin-sched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 86e18575c9be..c715593d88c4 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -105,10 +105,10 @@ struct sched_atom {
 #define EXIT_ZOMBIE		32
 #define EXIT_TRACE		(EXIT_ZOMBIE | EXIT_DEAD)
 /* in tsk->state again */
-#define TASK_DEAD		64
-#define TASK_WAKEKILL		128
-#define TASK_WAKING		256
-#define TASK_PARKED		512
+#define TASK_PARKED		64
+#define TASK_DEAD		128
+#define TASK_WAKEKILL		256
+#define TASK_WAKING		512
 
 enum thread_state {
 	THREAD_SLEEPING = 0,
-- 
2.39.2

