Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C373683905
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjAaWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjAaWER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:04:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF865AA5D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:04:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v37-20020a25aba8000000b0080f1143ef6bso10663226ybi.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHgl236BVfwTQ35JpXHYmzAIuFKEayd+GMozQ/eghgw=;
        b=WHNYPmOZxbemeT8b9FCEYZ1Qk92ha/CQ3JaHq+PEp8YFNo+q0ryoC3x6C3RO2obfFf
         arga+6jOQiWZe2eq5q7W0JqwBa/tXV8gzF+FqHfNkRPUWgKyC3kbmOTMb70iCmplrKrd
         4p3xWmmED654qRwqbZZLuaiuQ5ddiNTUmNdkg/qK+fvks3FjpbxhXv1FLl0L3iiaAgAr
         IViSsOU9UjT/igSxTXCqD6EPaneT/+6K8wZLopolBvt4t2XFK6VcvbTX+QAF2p9463Sj
         AbVwCtT2FdBDj8tsEWzyayJRYiqNOoyptBF90EM5g0DHPZ0Y1C5OUOqO9UdZsVxuNLNO
         XZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHgl236BVfwTQ35JpXHYmzAIuFKEayd+GMozQ/eghgw=;
        b=4RPlS6WALLsy97BJ1iFeyVdDUHDP44EmJmQ9tUNZ4BgiXAzbdZ3mjgxkYnh2dh1ZA/
         A1vvPzbfwBPXpQ+UNPEFgUTRiVfCZqXcRPzFgyQjrXUOotr/N/wdCvohD4s/VPX1gr6K
         wXZlJlq37ZIm2EI9Io0fQFKU3iBMgt1Qsfw2NWC/uLbx+ZznRnKofDGEtfNBcKOa6Ibg
         3Og5Rb5utqJTJrpxB31PBmj0VhstpHoshO1uBrWG5bvpahqSGLrZi06WuQAPKd6yEFHu
         sDn0p79qWnsn28PXxRsdGyPDevJy1dEpx6Z30kGzFN0xEwWgMkWAI4JvlZjCltQ/3ZYV
         zXYQ==
X-Gm-Message-State: AO0yUKUe7k7Mz6I/swJz8rtnFlTgZHcLUAzR/tub7aR+33YI4D2cXR6Q
        oR/QWNvys+B/OsfiBx5CanjPeG4xDg==
X-Google-Smtp-Source: AK7set/PIoxhNAc5wXsGxC3/QETHrKPQYKB+AF7xsrfyy+VIa80p5cv9hVnpjZcts7iJsrytDX9J/wkayA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:6946:0:b0:506:527a:5146 with SMTP id
 e67-20020a816946000000b00506527a5146mr2725476ywc.178.1675202652837; Tue, 31
 Jan 2023 14:04:12 -0800 (PST)
Date:   Tue, 31 Jan 2023 22:03:55 +0000
In-Reply-To: <20230131220355.1603527-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230131220355.1603527-1-rmoar@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131220355.1603527-4-rmoar@google.com>
Subject: [PATCH v1 3/3] kunit: fix bug of extra newline characters in debugfs logs
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
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

Fix bug of the extra newline characters in debugfs logs. When a
line is added to debugfs with a newline character at the end,
an extra line appears in the debugfs log. Remove these extra lines.

Add kunit_log_newline_test to provide test coverage for this issue.
(Also, move kunit_log_test above suite definition to remove the
unnecessary declaration prior to the suite definition)

Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/kunit/kunit-test.c | 36 ++++++++++++++++++++++++------------
 lib/kunit/test.c       |  9 ++++++++-
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 4df0335d0d06..e9114a466f1e 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -443,18 +443,6 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.test_cases = kunit_resource_test_cases,
 };
 
-static void kunit_log_test(struct kunit *test);
-
-static struct kunit_case kunit_log_test_cases[] = {
-	KUNIT_CASE(kunit_log_test),
-	{}
-};
-
-static struct kunit_suite kunit_log_test_suite = {
-	.name = "kunit-log-test",
-	.test_cases = kunit_log_test_cases,
-};
-
 static void kunit_log_test(struct kunit *test)
 {
 	struct kunit_suite suite;
@@ -481,6 +469,30 @@ static void kunit_log_test(struct kunit *test)
 #endif
 }
 
+static void kunit_log_newline_test(struct kunit *test)
+{
+#ifdef CONFIG_KUNIT_DEBUGFS
+	kunit_info(test, "extra newline\n");
+
+	KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "extra newline\n"),
+		"Missing log line, full log:\n%s", test->log);
+	KUNIT_EXPECT_NULL(test, strstr(test->log, "extra newline\n\n"));
+#else
+	kunit_skip(test, "only useful when debugfs is enabled");
+#endif
+}
+
+static struct kunit_case kunit_log_test_cases[] = {
+	KUNIT_CASE(kunit_log_test),
+	KUNIT_CASE(kunit_log_newline_test),
+	{}
+};
+
+static struct kunit_suite kunit_log_test_suite = {
+	.name = "kunit-log-test",
+	.test_cases = kunit_log_test_cases,
+};
+
 static void kunit_status_set_failure_test(struct kunit *test)
 {
 	struct kunit fake;
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 27763f0b420c..76d9c31943bf 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -117,6 +117,7 @@ void kunit_log_append(char *log, const char *fmt, ...)
 	char line[KUNIT_LOG_SIZE];
 	va_list args;
 	int len_left;
+	int line_len;
 
 	if (!log)
 		return;
@@ -125,10 +126,16 @@ void kunit_log_append(char *log, const char *fmt, ...)
 	if (len_left <= 0)
 		return;
 
+	// Evaluate the length of the line with arguments
 	va_start(args, fmt);
-	vsnprintf(line, sizeof(line), fmt, args);
+	line_len = vsnprintf(line, sizeof(line), fmt, args);
 	va_end(args);
 
+	// If line has two newline characters, do not print
+	// second newline character
+	if (fmt[strlen(fmt) - 2] == '\n')
+		line[line_len - 1] = '\0';
+
 	strncat(log, line, len_left);
 }
 EXPORT_SYMBOL_GPL(kunit_log_append);
-- 
2.39.1.456.gfc5497dd1b-goog

