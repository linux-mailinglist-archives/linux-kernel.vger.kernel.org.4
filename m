Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E346818A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbjA3SUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbjA3STs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:48 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7E83A850
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:46 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id h18so2709465ilj.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgFT+IL5bcCj7J23e5lu6CYNi7LTiunoNwjje3GvFYg=;
        b=Mq8KtW55EljioiViKDgF8PzaF6ZoQGnyoe2RRses0f4mgf5MIpiCriGT+IifaZfwon
         X9gCElvVuCs7mc8cR3RJwpKr2/rhpjPfH3EMST7OBev+p4E1ZR9kPbKZSLFahZXq2u5O
         J2miOwkGMz+dINzvWVyw1PJ51UBnR2WUJXLvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgFT+IL5bcCj7J23e5lu6CYNi7LTiunoNwjje3GvFYg=;
        b=qqk6J3BaVDNZ7uvUosOloNovYCCyHtunhFJ0DIoYTuyGSbTHbfxt54h6FqJuH7qaeS
         LL7oV5pdh1x7mhzo1exgCBhSMRsZ7kqTBcX3XTYsOKNg2b2JpWmcED5DJVh2D36/+MK5
         iHSpsVL40TKeIL5QcTDCigEMwi5H3YXZxH73fCkv0w/jWbiqB/9YiWiPSLclrMVan1Xi
         J7gd1KOLVcW2010vVF8Zl5eJ3rocIT2i3VaSZyOMRMUOJdsFJ+JSalh5FeN3yx0vlqRS
         w5F0mT2qUb76zxXmLXU9or3c8f7JxpZn+AJe5QTsgxHdTFEr7td/PtCy5/j6MHqLuEDc
         tMOQ==
X-Gm-Message-State: AO0yUKXVIjqNubE8sZXh9vs9PaCqXuZgDsu6K23SjtL65doW4cw0fI7T
        qsFEGNjV/ZpQntJ6Wxl8Jk5q52mlkNBKYixP
X-Google-Smtp-Source: AK7set8Yf1vmtP2krbFokO0Bn2Jo9liICFpI/GrHXPPM8ng0Ggp+ndGSIwsJUjW/xnrBNESNxA7g7w==
X-Received: by 2002:a05:6e02:1886:b0:310:a0a3:f614 with SMTP id o6-20020a056e02188600b00310a0a3f614mr19626648ilu.13.1675102785344;
        Mon, 30 Jan 2023 10:19:45 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:45 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 6/9] selftests: use canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:12 -0700
Message-Id: <20230130181915.1113313-7-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

A few spots in tools/testing/selftests still refer to this older debugfs
path, so let's update them to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/testing/selftests/user_events/dyn_test.c    |  2 +-
 tools/testing/selftests/user_events/ftrace_test.c | 10 +++++-----
 tools/testing/selftests/user_events/perf_test.c   |  8 ++++----
 tools/testing/selftests/vm/protection_keys.c      |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index d6265d14cd51..8879a7b04c6a 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -16,7 +16,7 @@
 
 #include "../kselftest_harness.h"
 
-const char *dyn_file = "/sys/kernel/debug/tracing/dynamic_events";
+const char *dyn_file = "/sys/kernel/tracing/dynamic_events";
 const char *clear = "!u:__test_event";
 
 static int Append(const char *value)
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 404a2713dcae..a0b2c96eb252 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -16,11 +16,11 @@
 
 #include "../kselftest_harness.h"
 
-const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
-const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
-const char *enable_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/enable";
-const char *trace_file = "/sys/kernel/debug/tracing/trace";
-const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
+const char *data_file = "/sys/kernel/tracing/user_events_data";
+const char *status_file = "/sys/kernel/tracing/user_events_status";
+const char *enable_file = "/sys/kernel/tracing/events/user_events/__test_event/enable";
+const char *trace_file = "/sys/kernel/tracing/trace";
+const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
 
 static inline int status_check(char *status_page, int status_bit)
 {
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 8b4c7879d5a7..31505642aa9b 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -18,10 +18,10 @@
 
 #include "../kselftest_harness.h"
 
-const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
-const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
-const char *id_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/id";
-const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
+const char *data_file = "/sys/kernel/tracing/user_events_data";
+const char *status_file = "/sys/kernel/tracing/user_events_status";
+const char *id_file = "/sys/kernel/tracing/events/user_events/__test_event/id";
+const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
 
 struct event {
 	__u32 index;
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 291bc1e07842..0d421015fbc1 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -97,7 +97,7 @@ int tracing_root_ok(void)
 void tracing_on(void)
 {
 #if CONTROL_TRACING > 0
-#define TRACEDIR "/sys/kernel/debug/tracing"
+#define TRACEDIR "/sys/kernel/tracing"
 	char pidstr[32];
 
 	if (!tracing_root_ok())
@@ -123,7 +123,7 @@ void tracing_off(void)
 #if CONTROL_TRACING > 0
 	if (!tracing_root_ok())
 		return;
-	cat_into_file("0", "/sys/kernel/debug/tracing/tracing_on");
+	cat_into_file("0", "/sys/kernel/tracing/tracing_on");
 #endif
 }
 
-- 
2.39.1.456.gfc5497dd1b-goog

