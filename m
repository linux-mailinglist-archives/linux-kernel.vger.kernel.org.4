Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4248E6E75B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjDSIyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDSIye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:54:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEBC4220
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:54:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u188-20020a2560c5000000b00b8f15f2111dso22886095ybb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681894472; x=1684486472;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EuxYuWlS9hmgllFa5Y4ge5RSLAeCGI0qG9xInGWh4Ro=;
        b=cE9nE1n72Kn5bHCXKXQlgGmbw3IOWLOSk6RamJ6u9TWsrspBENjtZ2S9Ieqe8Q4ywJ
         uWaDkNlrOmkvlOYLGvbbVD/XHQs/lU0IRkpm3hzdAzl6T7bJKezOXuGB7tjFKUaChprT
         i7uIiIaqkmcLmp8h0R4WgMRbsmkep7UwYv2JUMJP9UtaAjxSr9wFWI43ZNj0QFPBm/88
         JptOcu+v+1GQzNmtHy+bzmoGJ4kQYrREcCAPChlII3ffhAPezmLWo3eT8zLmUwPPRG9S
         3vYADKiWYdBcR4+mgpT+kZzoH5kBOKcxtjHnMjFjMLZVi9TOKZOOunG7xO1n+X2Hn143
         /RWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681894472; x=1684486472;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EuxYuWlS9hmgllFa5Y4ge5RSLAeCGI0qG9xInGWh4Ro=;
        b=d1Ncvm8ZkRzLgZm+PFjeMqCxjt237ckg1dJ08ET4QDTzA/6bJTlFVlp7FWFRtsS0rD
         5iB+8khHCdn0wutA4rD3DbX1bolfmPhRTsHXyntXKp+nxwoSdn3vMtGtCVV3N2+QdL1s
         XGFJ9/+MLRN4H6Fdq+FxBK+8wl+HJPRmBG+OzEQp3+CQgjPXlfRRmmocn1RXgxfIeKN0
         9dEXPDmXF6J49ZdbSYqMzY9VKQ7+ESzACLyKX42QOyb5tiZt4nOfGCGs6JxoM1vE/9YT
         dl05D4/z3trlDVyseopF98x59qFXfYPLJVoXpCziV2/+9IQ3XvkYotBlvwOAQMlc/SrO
         4Lgg==
X-Gm-Message-State: AAQBX9dT6OJHblbXf74ASk14UK0dTmBuT3UX29Vweai/4z3ZxRaA8mOq
        6IY2QH7dgDZwRNNRHIIcXaCFVoWK4apapQ==
X-Google-Smtp-Source: AKy350YMVnCHPNkwtrZScJ/kXXz27Dk8pqoxWRoqrVGbkL/ZYtUR4Kdy+awK3eYEJ45ir+lIISXz2u9ULmrHqA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d617:0:b0:b96:3344:c211 with SMTP id
 n23-20020a25d617000000b00b963344c211mr1700228ybg.10.1681894472175; Wed, 19
 Apr 2023 01:54:32 -0700 (PDT)
Date:   Wed, 19 Apr 2023 16:54:24 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230419085426.1671703-1-davidgow@google.com>
Subject: [PATCH v2 1/3] kunit: Always run cleanup from a test kthread
From:   David Gow <davidgow@google.com>
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
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

KUnit tests run in a kthread, with the current->kunit_test pointer set
to the test's context. This allows the kunit_get_current_test() and
kunit_fail_current_test() macros to work. Normally, this pointer is
still valid during test shutdown (i.e., the suite->exit function, and
any resource cleanup). However, if the test has exited early (e.g., due
to a failed assertion), the cleanup is done in the parent KUnit thread,
which does not have an active context.

Instead, in the event test terminates early, run the test exit and
cleanup from a new 'cleanup' kthread, which sets current->kunit_test,
and better isolates the rest of KUnit from issues which arise in test
cleanup.

If a test cleanup function itself aborts (e.g., due to an assertion
failing), there will be no further attempts to clean up: an error will
be logged and the test failed.

This should also make it easier to get access to the KUnit context,
particularly from within resource cleanup functions, which may, for
example, need access to data in test->priv.

Signed-off-by: David Gow <davidgow@google.com>
---
This is an updated version of / replacement of "kunit: Set the current
KUnit context when cleaning up", which instead creates a new kthread
for cleanup tasks if the original test kthread is aborted. This protects
us from failed assertions during cleanup, if the test exited early.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20230415091401.681395-1-davidgow@google.com/
- Move cleanup execution to another kthread
  - (Thanks, Benjamin, for pointing out the assertion issues)

---
 lib/kunit/test.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e2910b261112..caeae0dfd82b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -423,8 +423,51 @@ static void kunit_try_run_case(void *data)
 	kunit_run_case_cleanup(test, suite);
 }
 
+static void kunit_try_run_case_cleanup(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	struct kunit_suite *suite = ctx->suite;
+
+	current->kunit_test = test;
+
+	kunit_run_case_cleanup(test, suite);
+}
+
+static void kunit_catch_run_case_cleanup(void *data)
+{
+	struct kunit_try_catch_context *ctx = data;
+	struct kunit *test = ctx->test;
+	int try_exit_code = kunit_try_catch_get_result(&test->try_catch);
+
+	/* It is always a failure if cleanup aborts. */
+	kunit_set_failure(test);
+
+	if (try_exit_code) {
+		/*
+		 * Test case could not finish, we have no idea what state it is
+		 * in, so don't do clean up.
+		 */
+		if (try_exit_code == -ETIMEDOUT) {
+			kunit_err(test, "test case cleanup timed out\n");
+		/*
+		 * Unknown internal error occurred preventing test case from
+		 * running, so there is nothing to clean up.
+		 */
+		} else {
+			kunit_err(test, "internal error occurred during test case cleanup: %d\n",
+				  try_exit_code);
+		}
+		return;
+	}
+
+	kunit_err(test, "test aborted during cleanup. continuing without cleaning up\n");
+}
+
+
 static void kunit_catch_run_case(void *data)
 {
+	struct kunit_try_catch cleanup;
 	struct kunit_try_catch_context *ctx = data;
 	struct kunit *test = ctx->test;
 	struct kunit_suite *suite = ctx->suite;
@@ -451,9 +494,16 @@ static void kunit_catch_run_case(void *data)
 
 	/*
 	 * Test case was run, but aborted. It is the test case's business as to
-	 * whether it failed or not, we just need to clean up.
+	 * whether it failed or not, we just need to clean up. Do this in a new
+	 * try / catch context, in case it asserts, too.
 	 */
-	kunit_run_case_cleanup(test, suite);
+	kunit_try_catch_init(&cleanup,
+			     test,
+			     kunit_try_run_case_cleanup,
+			     kunit_catch_run_case_cleanup);
+	ctx->test = test;
+	ctx->suite = suite;
+	kunit_try_catch_run(&cleanup, ctx);
 }
 
 /*
-- 
2.40.0.634.g4ca3ef3211-goog

