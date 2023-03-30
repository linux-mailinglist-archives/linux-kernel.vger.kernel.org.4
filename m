Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72A36D11F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjC3WHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjC3WGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:06:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E1A10AA7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:05:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-545dd1a1e31so149684227b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680213909;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oTWHvZULnypCroDQByK+LhCtI2149pw2flJTMWCZ+Ug=;
        b=Xp2IdHLXHEWGS1lrBMpykudfcKCMvNqxtkJkrCjzBr205WfBba/8d0ab7sAaRGkMX8
         OAaP08G/kgiUxMWSMhCmXAUISTC8qGmWEvBz8NsppE6PQ719BtHZYV7jb/gN0pJ+ZM3U
         siRv50S1kazPuk1E8GmYPBIXZ0nBRilF4QFv4zU2JN0C3A8b4ro1HkWi6xA4hcFGwJ7p
         myuLFi6aVb59Jk7WE53jbeEvkQy+13wjCknwWCdLgmUCPnegwnoz0+SuYwp+GRQ/NpNu
         rpzri8pI7IyZVvzfaIdh4Raf4pSceP476I8Dq1wiJPhzb60LiDy27VmjU+gcviD7cWBC
         uwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680213909;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTWHvZULnypCroDQByK+LhCtI2149pw2flJTMWCZ+Ug=;
        b=eHXV5DMuceoSxi6Z9ve02XEXwkgkKfa/IzyPGrSQAj02DOV8AYCjQxIjJoJiYCTUwu
         GX9os2KjqbTcNqR+11QsODAx/RZPSqCA2cqlgeZWUg8m2HKFjE4sOwsMd/PbxXvRqPgu
         rkPc8QxbgRRHS68DmPIpNjr2Oh2hetbPdjsoVyX2Ji3s7HI719ghMEJebe89wKHPaea9
         zxJXmkX5V1+j643CW8EwgVMwx7byyGi7Si6DHOJ/AiXOCbqE7veKJC+VgCwhtMXfHO/F
         PpcEiyQ5YTJ+KQzuOyALBsFKD5AY8PuJIePOML8s0ZdfEidkUq7eF2EzrA7h+aQd3qVL
         eVJQ==
X-Gm-Message-State: AAQBX9cuCLiLd1urm+d184DAzh6Ka6CPbnQD3hNkEuxKUFmuwzAGgUvl
        Dz/LE2QYTenmQwuxeWXHRBfH8VeylQ==
X-Google-Smtp-Source: AKy350au/djIlRiGi302BEafs1kQMqYxTCqpyXSep7Q3ySuG+I/7N9vN6J+FykVXAm3kVUYbWbSuXs2bVw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:e68e:0:b0:b6b:6a39:949c with SMTP id
 d136-20020a25e68e000000b00b6b6a39949cmr12186172ybh.6.1680213908990; Thu, 30
 Mar 2023 15:05:08 -0700 (PDT)
Date:   Thu, 30 Mar 2023 22:05:06 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330220506.1399796-1-rmoar@google.com>
Subject: [PATCH v1] kunit: add tests for using current KUnit test field
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create test suite called "kunit_current" to add test coverage for the use
of current->kunit_test, which returns the current KUnit test.

Add three test cases:
- kunit_current_kunit_test_field to test the use of current->kunit_test.

- kunit_current_get_current_test to test the method
  kunit_get_current_test(), which utilizes current->kunit_test.

- kunit_current_fail_current_test to test the method
  kunit_fail_current_test(), which utilizes current->kunit_test.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/kunit/kunit-test.c | 61 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index b63595d3e241..91984b92c916 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -6,6 +6,7 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 
 #include "try-catch-impl.h"
 
@@ -532,7 +533,65 @@ static struct kunit_suite kunit_status_test_suite = {
 	.test_cases = kunit_status_test_cases,
 };
 
+static void kunit_current_kunit_test_field(struct kunit *test)
+{
+	struct kunit *current_test;
+
+	/* Check to ensure the result of current->kunit_test
+	 * is equivalent to current test.
+	 */
+	current_test = current->kunit_test;
+	KUNIT_EXPECT_PTR_EQ(test, test, current_test);
+}
+
+static void kunit_current_get_current_test(struct kunit *test)
+{
+	struct kunit *current_test1, *current_test2;
+
+	/* Check to ensure the result of kunit_get_current_test()
+	 * is equivalent to current test.
+	 */
+	current_test1 = kunit_get_current_test();
+	KUNIT_EXPECT_PTR_EQ(test, test, current_test1);
+
+	/* Check to ensure the result of kunit_get_current_test()
+	 * is equivalent to current->kunit_test.
+	 */
+	current_test2 = current->kunit_test;
+	KUNIT_EXPECT_PTR_EQ(test, current_test1, current_test2);
+}
+
+static void kunit_current_fail_current_test(struct kunit *test)
+{
+	struct kunit fake;
+
+	/* Initialize fake test and set as current->kunit_test. */
+	kunit_init_test(&fake, "fake test", NULL);
+	KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
+	current->kunit_test = &fake;
+
+	/* Fail current test and expect status of fake test to be failed. */
+	kunit_fail_current_test("This test is supposed to fail.");
+	KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAILURE);
+
+	/* Reset current->kunit_test to current test. */
+	current->kunit_test = test;
+}
+
+static struct kunit_case kunit_current_test_cases[] = {
+	KUNIT_CASE(kunit_current_kunit_test_field),
+	KUNIT_CASE(kunit_current_get_current_test),
+	KUNIT_CASE(kunit_current_fail_current_test),
+	{}
+};
+
+static struct kunit_suite kunit_current_test_suite = {
+	.name = "kunit_current",
+	.test_cases = kunit_current_test_cases,
+};
+
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
-		  &kunit_log_test_suite, &kunit_status_test_suite);
+		  &kunit_log_test_suite, &kunit_status_test_suite,
+		  &kunit_current_test_suite);
 
 MODULE_LICENSE("GPL v2");

base-commit: 7232282dd47cce6a780c9414bd9baccf232c7686
-- 
2.40.0.348.gf938b09366-goog

