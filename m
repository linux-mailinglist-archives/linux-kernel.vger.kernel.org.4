Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BDC6097B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJXBKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJXBKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:10:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF1E5FC2C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 18:10:49 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s2-20020aa78282000000b00561ba8f77b4so3881764pfm.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 18:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bPFUPgqfkuveFVX9ctMwkjUhtRM4a3rz3/7u8h2+JCY=;
        b=tS9ysiGKKfafl7Yy2AmyJBOWCbaWVea5uX+3ZhaWOph14OQ4/vNuCdX8cDRQ2xJdDX
         4JUyqkUXGJOPDSCPP2OncfSFAcW5zfU1m8bj8zM1SJvDl/BUFh3czJtJivaZmlJb/gro
         6GcyTBWU5FQfH9lWsieRrt1rKdTzJpIjaJwOGxqPgYddAQi1CYcP5AMsHmcxk/fMq6FK
         UB3vVYxn3ERUz/PWtOODhhjMFlXLAjW/FRsfmZ2mZn+BxTYk6cByHEXFe+zbBUNVkphi
         aMsQHBuQbYEbxKWCSDW5uyTWCB4RnTXDg6YLF+9IQCB/RNFxaujVeGMcRyJGh8JMc7vL
         pnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPFUPgqfkuveFVX9ctMwkjUhtRM4a3rz3/7u8h2+JCY=;
        b=etdPaIKGm29jvZ+5iQT6jsY4MPePVK3AnauwmxPZs2joHS2sT0GAoH0UQ4Pas9xTk5
         MMSBC+kfmYHf1X9PcbvkgVUwT/tx/KQAwhAphBSY601sQwsdUQolmf4sgLtHxfQQMz9u
         I621aIcXC5DAT+Pr6zrzcnpnN+USFBZmm/AeIoOtUif+esWnBkeR/WTeNdqObjZBpand
         HhlaZ7tP+3fade3R/jg0wzacQXXZcuG2uXi94DuMztRIwu80//RGYvSxHD5BVAjGySIZ
         yBZMuQpxp2VYOCBl3mH3LPTqG7jDIov4KoX2stuv6oYdaQKahEAtm/jV1OMlgBtL+ovo
         ATJg==
X-Gm-Message-State: ACrzQf38xa9r99mlHDRU2ErVhJqaP0AderEqlSYPX/+R5nNixUDMClJP
        akkA1FGxO6/kCxAJNPb7GNkC9wjVnf44
X-Google-Smtp-Source: AMsMyM6YyfQ2C/XewMSO/l0VcFR0qtxjlNlk/yqa2un/Snk0pDZ9L9fT0kv67mi6rO9guRp1S8xsVBLyDTbE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:26d5:b9c8:e16c:3a45])
 (user=irogers job=sendgmr) by 2002:a05:6a00:10c8:b0:563:1bd1:2ce4 with SMTP
 id d8-20020a056a0010c800b005631bd12ce4mr31080819pfu.6.1666573849036; Sun, 23
 Oct 2022 18:10:49 -0700 (PDT)
Date:   Sun, 23 Oct 2022 18:10:24 -0700
Message-Id: <20221024011024.462518-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1] perf record: Fix event fd races
From:   Ian Rogers <irogers@google.com>
To:     Greg Thelen <gthelen@google.com>,
        Anand K Mistry <amistry@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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

The write call may set errno which is problematic if occurring in a
function also setting errno. Save and restore errno around the write
call.

done_fd may be used after close, clear it as part of the close and
check its validity in the signal handler.

Suggested-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 41 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 52d254b1530c..e128b855ddde 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -649,7 +649,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 static volatile int signr = -1;
 static volatile int child_finished;
 #ifdef HAVE_EVENTFD_SUPPORT
-static int done_fd = -1;
+static volatile int done_fd = -1;
 #endif
 
 static void sig_handler(int sig)
@@ -661,19 +661,24 @@ static void sig_handler(int sig)
 
 	done = 1;
 #ifdef HAVE_EVENTFD_SUPPORT
-{
-	u64 tmp = 1;
-	/*
-	 * It is possible for this signal handler to run after done is checked
-	 * in the main loop, but before the perf counter fds are polled. If this
-	 * happens, the poll() will continue to wait even though done is set,
-	 * and will only break out if either another signal is received, or the
-	 * counters are ready for read. To ensure the poll() doesn't sleep when
-	 * done is set, use an eventfd (done_fd) to wake up the poll().
-	 */
-	if (write(done_fd, &tmp, sizeof(tmp)) < 0)
-		pr_err("failed to signal wakeup fd, error: %m\n");
-}
+	if (done_fd >= 0) {
+		u64 tmp = 1;
+		int orig_errno = errno;
+
+		/*
+		 * It is possible for this signal handler to run after done is
+		 * checked in the main loop, but before the perf counter fds are
+		 * polled. If this happens, the poll() will continue to wait
+		 * even though done is set, and will only break out if either
+		 * another signal is received, or the counters are ready for
+		 * read. To ensure the poll() doesn't sleep when done is set,
+		 * use an eventfd (done_fd) to wake up the poll().
+		 */
+		if (write(done_fd, &tmp, sizeof(tmp)) < 0)
+			pr_err("failed to signal wakeup fd, error: %m\n");
+
+		errno = orig_errno;
+	}
 #endif // HAVE_EVENTFD_SUPPORT
 }
 
@@ -2834,8 +2839,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 out_delete_session:
 #ifdef HAVE_EVENTFD_SUPPORT
-	if (done_fd >= 0)
-		close(done_fd);
+	if (done_fd >= 0) {
+		fd = done_fd;
+		done_fd = -1;
+
+		close(fd);
+	}
 #endif
 	zstd_fini(&session->zstd_data);
 	perf_session__delete(session);
-- 
2.38.0.135.g90850a2211-goog

