Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEF772B4D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 01:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjFKXgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 19:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjFKXgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 19:36:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64824191
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 16:36:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc5e2021f00so2260808276.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686526601; x=1689118601;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Z9C7A2uDishKMMw/sFhTPP02NzD8EdhABrfP9S4G3I=;
        b=GXi7A6zSEEdDfCKvq5m+yuiPbPulTKYUzA3hwPCaqqPx+/lA504jRE7sbArf+B7QKJ
         qCz6Q8csVHxveqzm2L8lIxTkBCv6n6hHWiFLHBCINq1R0uRjR5gzUnxG/zSxIO0dWiW4
         0rrA5OSgg0x5aVvXZEmCgS8/7w/nMMx4TqkYj8OxxQ63Zxv4AgrDAmx83Xk/nSywB5qd
         9Q52H67hwVhXcAO6lUa2TLOV/P3933EwdDcnx6STtCyTrFhhwcn+MccxLo3TpSGY5+iu
         gIdM9aqwsTY0M8JmjqnBsdk8jv6wN4iYcDX28e9U6KW3wlTQSUse018ya+91Pz1kOFus
         /acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686526601; x=1689118601;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z9C7A2uDishKMMw/sFhTPP02NzD8EdhABrfP9S4G3I=;
        b=IR+y+KApfm/HFlTbmvgMjhNAKN2/a2Z2yFMiuJwy/6FDdl/MqO1tV8ncXycWXZaG74
         Cb5a0e0LLTnRucG63tczrGVjTiIRfnyLgy1/cQ9hOMo9QoZYCMnM0LcdTgKvQDKVtII4
         6RWcl/QEr7RQL9n6CPjs3UIPR5ZuKSMUL6YFZEwBL+K2MyXC7wlTok8ear0tP+nsIxnE
         mjS3BUZVHZzF0cpV2dewVpIJbBdF5ezu4tn/NMqdaVYYUxsh7s/EI7fR2tv0en5nZ/Iy
         xxyMaRP/lB/P7vYMUcGXrmVn2sYCJ1uIB8A1zwnIAN+coh7k4T7pqQooDHOrJPxHPfMf
         F57A==
X-Gm-Message-State: AC+VfDzXt2FAKisH6UxZFi31PDyuLr2M1xftKzUL9x6mfhAN7IC4SbH0
        xKc4Iq3w856LOh6fTeDiV7Cb1eMiG4So
X-Google-Smtp-Source: ACHHUZ5a3X8la+HIw3wdrIZywEOnTnM7oPRPJgQKVER5jcwNbGQ878wTnSSgPBk0gdTY1WlJsmVg1LrIxYct
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:aca9:d7c7:ed17:e760])
 (user=irogers job=sendgmr) by 2002:a25:d215:0:b0:bc7:f6af:8cff with SMTP id
 j21-20020a25d215000000b00bc7f6af8cffmr1783363ybg.2.1686526601566; Sun, 11 Jun
 2023 16:36:41 -0700 (PDT)
Date:   Sun, 11 Jun 2023 16:36:10 -0700
In-Reply-To: <20230611233610.953456-1-irogers@google.com>
Message-Id: <20230611233610.953456-5-irogers@google.com>
Mime-Version: 1.0
References: <20230611233610.953456-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 5/5] perf bench sched messaging: Free contexts on exit
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
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
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

Place sender and receiver contexts onto lists so that they may be
freed on exit. Add missing pthread_attr_destroy. Fixes memory leaks
reported by leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/sched-messaging.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 488f6e6ba1a5..fa1f8f998814 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -27,6 +27,7 @@
 #include <poll.h>
 #include <limits.h>
 #include <err.h>
+#include <linux/list.h>
 #include <linux/time64.h>
 
 #define DATASIZE 100
@@ -35,8 +36,11 @@ static bool use_pipes = false;
 static unsigned int nr_loops = 100;
 static bool thread_mode = false;
 static unsigned int num_groups = 10;
+static struct list_head sender_contexts = LIST_HEAD_INIT(sender_contexts);
+static struct list_head receiver_contexts = LIST_HEAD_INIT(receiver_contexts);
 
 struct sender_context {
+	struct list_head list;
 	unsigned int num_fds;
 	int ready_out;
 	int wakefd;
@@ -44,6 +48,7 @@ struct sender_context {
 };
 
 struct receiver_context {
+	struct list_head list;
 	unsigned int num_packets;
 	int in_fds[2];
 	int ready_out;
@@ -170,6 +175,7 @@ static pthread_t create_worker(void *ctx, void *(*func)(void *))
 	if (ret != 0)
 		err(EXIT_FAILURE, "pthread_create failed");
 
+	pthread_attr_destroy(&attr);
 	return childid;
 }
 
@@ -201,6 +207,7 @@ static unsigned int group(pthread_t *pth,
 	if (!snd_ctx)
 		err(EXIT_FAILURE, "malloc()");
 
+	list_add(&snd_ctx->list, &sender_contexts);
 	for (i = 0; i < num_fds; i++) {
 		int fds[2];
 		struct receiver_context *ctx = malloc(sizeof(*ctx));
@@ -208,6 +215,7 @@ static unsigned int group(pthread_t *pth,
 		if (!ctx)
 			err(EXIT_FAILURE, "malloc()");
 
+		list_add(&ctx->list, &receiver_contexts);
 
 		/* Create the pipe between client and server */
 		fdpair(fds);
@@ -266,6 +274,7 @@ int bench_sched_messaging(int argc, const char **argv)
 	int readyfds[2], wakefds[2];
 	char dummy;
 	pthread_t *pth_tab;
+	struct sender_context *pos, *n;
 
 	argc = parse_options(argc, argv, options,
 			     bench_sched_message_usage, 0);
@@ -324,6 +333,13 @@ int bench_sched_messaging(int argc, const char **argv)
 	}
 
 	free(pth_tab);
-
+	list_for_each_entry_safe(pos, n, &sender_contexts, list) {
+		list_del_init(&pos->list);
+		free(pos);
+	}
+	list_for_each_entry_safe(pos, n, &receiver_contexts, list) {
+		list_del_init(&pos->list);
+		free(pos);
+	}
 	return 0;
 }
-- 
2.41.0.162.gfafddb0af9-goog

