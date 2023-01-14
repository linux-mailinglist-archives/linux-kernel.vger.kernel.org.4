Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6BC66AE3B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 22:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjANVxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 16:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjANVxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 16:53:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F74C10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:53:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z17-20020a25e311000000b00719e04e59e1so26944549ybd.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7LjX5uGK3WCr57lUgDj8dp0DrlckrMoNfjwJB3vyfk=;
        b=kQY6SCnd86TNsyNs+WGDwOUPyNjEHdmF/oyqGflEr1YCVEUITODKWdmUUkAHBOwUza
         33TmnI0SN2oiIjuH1iCYPbGOhlZGBJqzxqU96kGktV0aTI04+beQV0FlyeUv5YBqjoXL
         KI8UWtDFbdLzcWdMNvqFZuViwArRdqsDsEK+Gc/iM968chXed7e44oDcuya6bdBAwkCr
         PHZwqBe5ymkO6JleO7dXaAwq+OUR/4QOf7Olgate0sinyx5L5wvsYJ5CM8j0PqWIb929
         zfnpaEb3ouKweZo7k8UT3YGdpdDI9uil3Iv+iUopgylQ9qMFOGDjlHUIfg/5tW4QlEaf
         rMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7LjX5uGK3WCr57lUgDj8dp0DrlckrMoNfjwJB3vyfk=;
        b=jdmazxFIsRD1i9pbF5EiXXcZecxXJDAI038IgmaNsb2k9wXgfS5axgZ0dB4uTkCstu
         UNXgymtIvpiXlTPzPaU7wdKdGzD7ytmiLZJt9MtT3VnWxRLws3kqvAVh6Z7THt2EP4FM
         c+YtI3fwzYvLVUVaPYiOs7WqIEC2Lgp9sw5EUEjwkijHu/7VdC0bnfB0gKP4hGa16D9i
         mYFlLZjNBg28MCIWvisSHU8ZlZCSB7mBWwALWr2s6R+7mrpXnOjwVVuKlZ9ybaKsTbJB
         ycAgnlVxHduXvQ95pm6JRtcU8XhA/Wz0udJK/P8gGHIIbVEAOW4vFpWpcLOzf27mTHFn
         jVHQ==
X-Gm-Message-State: AFqh2krqZzvn08M6Owyk6060KlDjIby9k2KZ7rRlccp7WvJZwNHVDXvn
        Sjojr0HkQsGAXcWOpaZz2x+ccQhmfHLU
X-Google-Smtp-Source: AMrXdXtv1un/Hw8VAb7/hPRFzAnhyGVA4c1ASbv+9wc6xkzoCUeqJ/hQ7n2ILI4AG2sNK0A+0HD6enSVjwSK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:4b8d:c5ae:877b:4ae6])
 (user=irogers job=sendgmr) by 2002:a0d:ea8b:0:b0:4d0:b28:e831 with SMTP id
 t133-20020a0dea8b000000b004d00b28e831mr2645369ywe.70.1673733181442; Sat, 14
 Jan 2023 13:53:01 -0800 (PST)
Date:   Sat, 14 Jan 2023 13:52:51 -0800
Message-Id: <20230114215251.271678-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1] perf test workload thloop: Make count increments atomic
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

The count variable is incremented by multiple threads, doing so
without an atomic operation causes thread sanitizer warnings. Switch
to using relaxed atomics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/workloads/thloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
index 29193b75717e..af05269c2eb8 100644
--- a/tools/perf/tests/workloads/thloop.c
+++ b/tools/perf/tests/workloads/thloop.c
@@ -20,7 +20,7 @@ static void sighandler(int sig __maybe_unused)
 noinline void test_loop(void)
 {
 	while (!done)
-		count++;
+		__atomic_fetch_add(&count, 1, __ATOMIC_RELAXED);
 }
 
 static void *thfunc(void *arg)
-- 
2.39.0.314.g84b9a713c41-goog

