Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5086AF904
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjCGWkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjCGWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:40:15 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE37A2192
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:39:41 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536a5a0b6e3so152190577b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678228780;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d5sV/9QBhMVgVGTAWq7/DnOA4YA0+xQYxnQrYod4TUo=;
        b=hhrXN3bOat3CTLco/yNvAbB70x8BJlerST3ZLVjOJzB7utq6BOLTd7rIV7HndRvIFK
         GIGvF1jH9qZWEqLuYbNVOERQUuL0SbhQOLbQA2TgYZnzzt5ttwCFjX9yZXyXAcJMb3ob
         WM/E3UgrXVANjxIgyI19FkuQeGNLwU4c0ESoHihWk2Cbu6ylYm0PAPEEUfrYGdY4MhHc
         cvdzR1Y2pucigncVY2XBxKvNVgwtcAruaoPTul2p7zy95FH44VOKVfffeK5Z4g/0f4Dj
         tyW0dLqKDFb/KzndpXfbmAdfnfjWzd6MPGcG+rvPk87FQGOX2XDKhLUiLdwfd4dpQbbc
         wO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228780;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5sV/9QBhMVgVGTAWq7/DnOA4YA0+xQYxnQrYod4TUo=;
        b=mvAZGqdCMidoUAHh2fxdvv+O09ym61XO/yAias2Thazr3fpPoK1QDRBi4yzx/a5x9m
         +P4hkj9V1srdw9VncjZqXRiBT1BHvJekjtcxXa7JvlIKickC4qlWtCAhOcyVbtQflY4K
         D3KPrMj7w36FwRN30yyNgftS+HOOQKTjEjdjz9iAJ8SvB0wmeTXuDydv/KzN6jZ/ntGm
         l7hnPXVp/ATVKCG2UBTTPWujlqYE8vKy1iSYVkCnGcI/ts1nfN9s44A4nG7NZHXNc3os
         /wpplvffSXgsEbpAkTDHGrdrKVd1ha64WtPSbsWYRf9GRSAOpVsz/nqBjrW/ywImBvKC
         y+hQ==
X-Gm-Message-State: AO0yUKUzQxixImcTuWs+GbYzkN9mKHP7vt9HhPBn/NsfBmgEXH2DYIm7
        C0utjyFpTro+PmEzzqMbJt3TM7HHcA==
X-Google-Smtp-Source: AK7set8pGkC2UiAO2v5rfMCf88X6exkHaZm9sKuSofYPS3FONpBilcB29gYsZHLSAgiF/8ooPtlfqeaXGA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:bc6:0:b0:a0d:8150:be04 with SMTP id
 c6-20020a5b0bc6000000b00a0d8150be04mr7829283ybr.13.1678228780098; Tue, 07 Mar
 2023 14:39:40 -0800 (PST)
Date:   Tue,  7 Mar 2023 22:39:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230307223937.2892762-1-rmoar@google.com>
Subject: [PATCH v3 1/3] kunit: fix bug in debugfs logs of parameterized tests
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

Fix bug in debugfs logs that causes individual parameterized results to not
appear because the log is reinitialized (cleared) when each parameter is
run.

Ensure these results appear in the debugfs logs, increase log size to
allow for the size of parameterized results. As a result, append lines to
the log directly rather than using an intermediate variable that can cause
stack size warnings due to the increased log size.

Here is the debugfs log of ext4_inode_test which uses parameterized tests
before the fix:

     KTAP version 1

     # Subtest: ext4_inode_test
     1..1
 # Totals: pass:16 fail:0 skip:0 total:16
 ok 1 ext4_inode_test

As you can see, this log does not include any of the individual
parametrized results.

After (in combination with the next two fixes to remove extra empty line
and ensure KTAP valid format):

 KTAP version 1
 1..1
     KTAP version 1
     # Subtest: ext4_inode_test
     1..1
        KTAP version 1
         # Subtest: inode_test_xtimestamp_decoding
         ok 1 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
         ... (the rest of the individual parameterized tests)
         ok 16 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra
     # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
     ok 1 inode_test_xtimestamp_decoding
 # Totals: pass:16 fail:0 skip:0 total:16
 ok 1 ext4_inode_test

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---

Changes from v2 -> v3:
- Fix a off-by-one bug in the kunit_log_append method.

Changes from v1 -> v2:
- Remove the use of the line variable in kunit_log_append that was causing
  stack size warnings.
- Add before and after to the commit message.

 include/kunit/test.h |  2 +-
 lib/kunit/test.c     | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 08d3559dd703..0668d29f3453 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
 struct kunit;
 
 /* Size of log associated with test. */
-#define KUNIT_LOG_SIZE	512
+#define KUNIT_LOG_SIZE 1500
 
 /* Maximum size of parameter description string. */
 #define KUNIT_PARAM_DESC_SIZE 128
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c9e15bb60058..c4d6304edd61 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -114,22 +114,27 @@ static void kunit_print_test_stats(struct kunit *test,
  */
 void kunit_log_append(char *log, const char *fmt, ...)
 {
-	char line[KUNIT_LOG_SIZE];
 	va_list args;
-	int len_left;
+	int len, log_len, len_left;
 
 	if (!log)
 		return;
 
-	len_left = KUNIT_LOG_SIZE - strlen(log) - 1;
+	log_len = strlen(log);
+	len_left = KUNIT_LOG_SIZE - log_len - 1;
 	if (len_left <= 0)
 		return;
 
+	/* Evaluate length of line to add to log */
 	va_start(args, fmt);
-	vsnprintf(line, sizeof(line), fmt, args);
+	len = vsnprintf(NULL, 0, fmt, args) + 1;
+	va_end(args);
+
+	/* Print formatted line to the log */
+	va_start(args, fmt);
+	vsnprintf(log + log_len, min(len, len_left), fmt, args);
 	va_end(args);
 
-	strncat(log, line, len_left);
 }
 EXPORT_SYMBOL_GPL(kunit_log_append);
 
@@ -437,7 +442,6 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	struct kunit_try_catch_context context;
 	struct kunit_try_catch *try_catch;
 
-	kunit_init_test(test, test_case->name, test_case->log);
 	try_catch = &test->try_catch;
 
 	kunit_try_catch_init(try_catch,
@@ -533,6 +537,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 		struct kunit_result_stats param_stats = { 0 };
 		test_case->status = KUNIT_SKIPPED;
 
+		kunit_init_test(&test, test_case->name, test_case->log);
+
 		if (!test_case->generate_params) {
 			/* Non-parameterised test. */
 			kunit_run_case_catch_errors(suite, test_case, &test);

base-commit: 60684c2bd35064043360e6f716d1b7c20e967b7d
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

