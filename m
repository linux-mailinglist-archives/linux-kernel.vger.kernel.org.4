Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5B56D5233
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjDCUUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjDCUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:20:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BA149E9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:19:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5446a91c40cso303355297b3.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 13:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680553174;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rGqh23Uho9as75Hu8J99LRSqbd0ZR41vrBHLl9H6fHQ=;
        b=khkXUNMAfSlZq41nqUyefbu+R10boC1ReNh6N+z0+vMXfFPuyw3nUSlPus1j+7qsL4
         d9MXbXjh74GH+fY+wME0qYIBTILSWRnN2LIvTyS18LlZ6LDhX8bSvqY9AZWQtCzy3mMy
         6a0MDKkSVkvWVK0p9zNkxgcL55KZTRpuR3KZt0/mDGR6xA5VfrZjpM4HxkPcUZ1lmctn
         C6AuTZXCHrq7B4K8XJH8Q9d+z8QTMsbB/9Q7hD9hl8Zx1Zx31x3CB/0v5HfNIln/J9qw
         w696+QnKuCQ2opbeqVjtFUuy+4a4doKDOS28UKq6NWLbJ17rnAMBto/SJpHPyIuIXA4E
         RHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680553174;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGqh23Uho9as75Hu8J99LRSqbd0ZR41vrBHLl9H6fHQ=;
        b=a3vorJHfsfVMf2wCsKRwq5vy7gJXzoMdFrrCCEierZm/G6nKeM0nFtdCAK7OS5NLfG
         2s3seBMLEgQdntQKcQjD/09isaMIjynB/qAtVTFLryXrG0Grl6Bz2ERiWcb0RFWg6Z1u
         xk/zCbZ+c9wXv36FndMGeDvHMeDDudntC/PqG2Clhx5N8YAJnAaMcpNPwh/9hHJTHAWM
         F0W6cBNLP86Zo+O9HgK5m5qZuhJHcWh0l2JZRrlf4OoyxdbWayeFpRolfEibN2z7EHDw
         q0rajEhdBN6uIlNNDj8JuMyWqB7KIpY712N2f7PZO9klmXw4aqF5F3eCKmeZPOSrzeKx
         dqUw==
X-Gm-Message-State: AAQBX9eKVKw4coReCsbkDQcSGFs/c/bD0hnISvWqIbF5Zx0xMruOWuBK
        raKeA18+e7LKNaP+7z0nA2PSGs6F6Q==
X-Google-Smtp-Source: AKy350ZZP+l24APDLQ0PRDNMPAAj0096jqtn5eMmpF9PgOXcwHjxzRWAoeI0SY3rlBf35fZKL2v+Otk6mA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:8b52:0:b0:544:b9b2:5c32 with SMTP id
 e18-20020a818b52000000b00544b9b25c32mr105433ywk.7.1680553174571; Mon, 03 Apr
 2023 13:19:34 -0700 (PDT)
Date:   Mon,  3 Apr 2023 20:19:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403201930.2019419-1-rmoar@google.com>
Subject: [PATCH v2] kunit: add tests for using current KUnit test field
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

Add two test cases:
- kunit_current_test to test current->kunit_test and the method
  kunit_get_current_test(), which utilizes current->kunit_test.

- kunit_current_fail_test to test the method
  kunit_fail_current_test(), which utilizes current->kunit_test.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes from v1->v2:
- Combine two test cases to test both ways of getting current test in
  kunit_current_test.
- Changes to comments.
- Add kunit_cleanup to kunit_current_fail_test.

 lib/kunit/kunit-test.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index b63595d3e241..42e44caa1bdd 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -6,6 +6,7 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 
 #include "try-catch-impl.h"
 
@@ -532,7 +533,46 @@ static struct kunit_suite kunit_status_test_suite = {
 	.test_cases = kunit_status_test_cases,
 };
 
+static void kunit_current_test(struct kunit *test)
+{
+	/* Check results of both current->kunit_test and
+	 * kunit_get_current_test() are equivalent to current test.
+	 */
+	KUNIT_EXPECT_PTR_EQ(test, test, current->kunit_test);
+	KUNIT_EXPECT_PTR_EQ(test, test, kunit_get_current_test());
+}
+
+static void kunit_current_fail_test(struct kunit *test)
+{
+	struct kunit fake;
+
+	kunit_init_test(&fake, "fake test", NULL);
+	KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
+
+	/* Set current->kunit_test to fake test. */
+	current->kunit_test = &fake;
+
+	kunit_fail_current_test("This should make `fake` test fail.");
+	KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAILURE);
+	kunit_cleanup(&fake);
+
+	/* Reset current->kunit_test to current test. */
+	current->kunit_test = test;
+}
+
+static struct kunit_case kunit_current_test_cases[] = {
+	KUNIT_CASE(kunit_current_test),
+	KUNIT_CASE(kunit_current_fail_test),
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

