Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FFB6B133F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCHUkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCHUkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:40:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ACFBBB01
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:40:00 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c02ed619so181422107b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678308000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHMaaQziz2QfMgPi4gvnI0eOazLpKsiF3QitYkad+kQ=;
        b=fixDoqmcQCD/PBowzjqprv0GU2CpNcYHV3jm73Qd/NNMchq0yphn41wD49+Y+4CdOP
         eKuO+He/XD6rfjpQ64xHCzI7R7CCEX5wdCvLqrdQGs2sg1nWbpCLQ/8z3j7f5spKFim/
         Yr7kpq2ToMcZmrgVtksg0DxAmm6HCfm49fZKfxSlD0D9X1PE7xEX53rEOzE+9s69l8gc
         xW4tsKkBymbI/Lyt1ChuNx5GsnRXru8Ezd/h/m0CU2qWFQitujWcfUJ0jopJhOUjrlup
         bs1zlP0lrshDI/GrRPmmdl/SHsj9R2uL8yfNsq8xTKg+JF8MRCICoxuZyO4pXWU/bfJ0
         VTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678308000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHMaaQziz2QfMgPi4gvnI0eOazLpKsiF3QitYkad+kQ=;
        b=IaQ9Lgaieypy/1Z/MKOikG7JjGd8FesvFJXMckU66Al7wlCzerUAf6Otdt6SaOekNv
         fKP3nsZu8TnvjjYZH7izJDgUOZzMWDzo6uRk/NOsBbNEOC1R3pGJpln9kaveenKYZV7Z
         lTX0mZSucfhpFYeF3Iox/xtceodIS8SqhKrXerQLsf3abfJ3L3gwhijRXDsUMddZXl1H
         khBRsFwDPH4I0sD4wMgXF38KnfjgIo0AacTmnM8wyaGawU7YiCb1ylrW+2XAxnDYjCqy
         Kz3OWZ7JQmN23h4oEkN/sTXGNmkfUbzJDJl13DMHCLaSv34GZ8RYLTcXX9C9XVQhmpqE
         m5QQ==
X-Gm-Message-State: AO0yUKW8JuVoF5HL+WU0SHXc2xXHTxn4nxzJwXm5dBB1jfa0vJtJxpKh
        cSZmxIcRRhiWOP5pEyAwyRh8AOaRRQ==
X-Google-Smtp-Source: AK7set94UvujMpNNzHqe5EjaUlutCYrYwKji4Z1jCaRhw5X0rqSIi3r+2DE7/duXcz1DaB1JNC1+P1H+9A==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:145:b0:ac2:a7a7:23c3 with SMTP id
 p5-20020a056902014500b00ac2a7a723c3mr7613716ybh.12.1678307999988; Wed, 08 Mar
 2023 12:39:59 -0800 (PST)
Date:   Wed,  8 Mar 2023 20:39:52 +0000
In-Reply-To: <20230308203952.3060546-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230308203952.3060546-1-rmoar@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308203952.3060546-3-rmoar@google.com>
Subject: [PATCH v4 3/3] kunit: fix bug of extra newline characters in debugfs logs
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
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

Fix bug of the extra newline characters in debugfs logs. When a
line is added to debugfs with a newline character at the end,
an extra line appears in the debugfs log.

This is due to a discrepancy between how the lines are printed and how they
are added to the logs. Remove this discrepancy by checking if a newline
character is present before adding a newline character. This should closely
match the printk behavior.

Add kunit_log_newline_test to provide test coverage for this issue.  (Also,
move kunit_log_test above suite definition to remove the unnecessary
declaration prior to the suite definition)

As an example, say we add these two lines to the log:

kunit_log(..., "KTAP version 1\n");
kunit_log(..., "1..1");

The debugfs log before this fix:

 KTAP version 1

 1..1

The debugfs log after this fix:

 KTAP version 1
 1..1

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---

Changes from v3 -> v4:
- Slight formatting change in test.h regarding "\" placement.

Changes from v2 -> v3:
- Changes to commit message.

Changes from v1 -> v2:
- Changed the way extra newlines are removed. Instead of removing extra
  newline characters, add a newline if one is not present. This is a bit
  cleaner.
- Note: I looked into using KERN_CONT to match the printk behavior to
  vsnprintf but this could cause issues with KTAP printing on the same line
  as interrupting kernel messages. I also looked at just adding KERN_CONT
  functionality to kunit_log and I did get this to work but it was a bit
  messy because it required a few calls to kunit_log_newline in
  kunit_run_tests. If this is very desired functionality, happy to add this
  to version 3.

 include/kunit/test.h   |  2 +-
 lib/kunit/kunit-test.c | 35 +++++++++++++++++++++++------------
 lib/kunit/test.c       | 18 ++++++++++++++++++
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 0668d29f3453..9721584027d8 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -420,7 +420,7 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
 #define kunit_log(lvl, test_or_suite, fmt, ...)				\
 	do {								\
 		printk(lvl fmt, ##__VA_ARGS__);				\
-		kunit_log_append((test_or_suite)->log,	fmt "\n",	\
+		kunit_log_append((test_or_suite)->log,	fmt,		\
 				 ##__VA_ARGS__);			\
 	} while (0)
 
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 4df0335d0d06..b63595d3e241 100644
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
@@ -481,6 +469,29 @@ static void kunit_log_test(struct kunit *test)
 #endif
 }
 
+static void kunit_log_newline_test(struct kunit *test)
+{
+	kunit_info(test, "Add newline\n");
+	if (test->log) {
+		KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add newline\n"),
+			"Missing log line, full log:\n%s", test->log);
+		KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\n"));
+	} else {
+		kunit_skip(test, "only useful when debugfs is enabled");
+	}
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
index 811fcc376d2f..e2910b261112 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -108,6 +108,22 @@ static void kunit_print_test_stats(struct kunit *test,
 		  stats.total);
 }
 
+/**
+ * kunit_log_newline() - Add newline to the end of log if one is not
+ * already present.
+ * @log: The log to add the newline to.
+ */
+static void kunit_log_newline(char *log)
+{
+	int log_len, len_left;
+
+	log_len = strlen(log);
+	len_left = KUNIT_LOG_SIZE - log_len - 1;
+
+	if (log_len > 0 && log[log_len - 1] != '\n')
+		strncat(log, "\n", len_left);
+}
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -135,6 +151,8 @@ void kunit_log_append(char *log, const char *fmt, ...)
 	vsnprintf(log + log_len, min(len, len_left), fmt, args);
 	va_end(args);
 
+	/* Add newline to end of log if not already present. */
+	kunit_log_newline(log);
 }
 EXPORT_SYMBOL_GPL(kunit_log_append);
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

