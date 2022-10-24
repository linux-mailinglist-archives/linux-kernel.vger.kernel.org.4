Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EE660B69F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJXTGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiJXTFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:05:07 -0400
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BCF915ED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:44:53 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id j8-20020a056808118800b00354b7e75b46so2220887oil.16
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg26NKxObx9cPNlbM/mhAsHD/ehUnl2CM6D2kDhH0JM=;
        b=Hqqahl8ovXopQPb7uIKtwoTdJrjEL1o1/d7xnlSnlFSlQ1QzOGUv4npflfCXUCsfYQ
         AAjlIIk0BZnDAG+ImVC4wa94gcewBYm+zGwO/MaRol3lrxLdrXCJdrVn5H0hyx4Q2OW3
         2JqxUZ/TMKXdPIg1AmeE43USOIBlNhP3WN+Je7SXGkLeufqUIh3jdpK19uC+rt/5kA4A
         hIwKoPwBFPXH3YqBsWW95a4TmH9uh03H8Awp8NyeLq+03n3zMHlDMT1hW7XUXyFENy+M
         R2ONicYhaHRBoRnx0dbyeFMTdvleVg+NHwPWqZqDGBc/zpZtgZlB1gtjY1pwc3D55Bwo
         ypDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg26NKxObx9cPNlbM/mhAsHD/ehUnl2CM6D2kDhH0JM=;
        b=cYcrBHqY2pJmEbekFT0GEhQC41RdoI1KFpDmO0m9stiaFJoJcHskf+5Psu6RhaEoa/
         L/Mj0W+6e3lvr36wQ3ltZWVlD0L1uJtbrMQVk7/yUa4Kis8UBCR+Tk3cYxDuzLipbWQr
         +WCd41zKUrAKa98vKtzDU6zr9VztacTmFgtWXG/Q9BNd+xx56v8Ad3tN2PyD51Qp/p3L
         rzW1ulyGVhlj7QTrgv4+r6Eh8wvypuJZxvRRmUH5BZ5Ys5aeXcXxftr82jLimH1b3SrC
         OXqX2E0btrdXX+C+i8NcX00Ji7Q1BEsqA76maxNHZnHxEmvD+cOP4VxvlrUPrNNohRt3
         rFYA==
X-Gm-Message-State: ACrzQf0/TwOHkeHd2lgJX6U06gpiA6XQp3atcaSCBoJHD8B4a8u1jLoN
        blbDun9uClf/4UQ8WRXdutSGgRbuMpsJ
X-Google-Smtp-Source: AMsMyM6Nj7ukGiPLGTSOHW/hTa1+LUVELv3+6oYpxx0HkdyzccLPOpfM7Y4+sdeI/VI94qUoc+GTLg8UjAf3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90a:cf82:b0:20b:3525:81ec with SMTP id
 i2-20020a17090acf8200b0020b352581ecmr39048692pju.42.1666632958899; Mon, 24
 Oct 2022 10:35:58 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:17 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-3-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 2/8] perf record: Use sig_atomic_t for signal handlers
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

This removes undefined behavior as described in:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Suggested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e128b855ddde..5332b9c05f28 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -61,6 +61,7 @@
 #include <locale.h>
 #include <poll.h>
 #include <pthread.h>
+#include <stdatomic.h>
 #include <unistd.h>
 #ifndef HAVE_GETTID
 #include <syscall.h>
@@ -646,10 +647,10 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	return record__write(rec, map, bf, size);
 }
 
-static volatile int signr = -1;
-static volatile int child_finished;
+static volatile sig_atomic_t signr = -1;
+static volatile sig_atomic_t child_finished;
 #ifdef HAVE_EVENTFD_SUPPORT
-static volatile int done_fd = -1;
+static volatile sig_atomic_t done_fd = -1;
 #endif
 
 static void sig_handler(int sig)
@@ -1926,7 +1927,7 @@ static void record__read_lost_samples(struct record *rec)
 
 }
 
-static volatile int workload_exec_errno;
+static volatile sig_atomic_t workload_exec_errno;
 
 /*
  * evlist__prepare_workload will send a SIGUSR1
-- 
2.38.0.135.g90850a2211-goog

