Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D980D618691
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiKCRst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiKCRsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:48:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF581DDFB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:47:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b142-20020a253494000000b006ca86d5f40fso2710037yba.19
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4ZrAJks1xCoReobX1BLqMTv0anHxr6wjkZyjGEJdoM=;
        b=D/rXDwXMVuPgZlmiV3KxtME9c8EgCpstnqaN5WvmpVop8rbBVufyXInZIdkI3owvem
         ElnOm+L7ja7qvqZEduaW4vqnDk4ZEkSxjEFnWjKlMkFJItbrbqxJYItOkOEfEqVxeJtF
         +xG9zEI8S1nVdSf7DpZEpNrkai9XyZXiWgicBTcKLU46k4GemjWjCHS+2soidZWc4W4T
         EAaAfg96I3mwS2I4854xJaQM1VWLSn3O7ZvtwXpfV39hcwS22D+B9vXez43FvyN//7dX
         wM1ECFNx82uoS4NUEJKAKvv5gSp0hwvJO5AlmM39LMoW4JKS27iIicdqZ14bZPqQXz0f
         XBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4ZrAJks1xCoReobX1BLqMTv0anHxr6wjkZyjGEJdoM=;
        b=cgHkWRmeGRhSTWrzPj4Fvu6IhWIVJvk4Zo3f8LODMm9D4ICc3MxoIlyZSP3hL6ciAd
         jTQTp3hqqXrHbqV+Wa1F4Z2w+883UClm2N6VfqrWWD/+CkTU69ELQKkQIe1McF1/Dj9n
         e7JigC//x7htEr+ecVAJmQdH0sWKt6TrYl0oTINCsuOiFA/xJ3oci1s5x8sEhz9mxtbg
         ruYHTFTbxPv5aTILNRQfwT9py/Tu/jYufQLTtxxEZOTO0LNbtL9klJYlCOtFIAdaaNaB
         D4l+r3FlTv86suQ8joCuEBhzuCr74z1UTnF9HNNU7Jf2kDu30BobUDOcQDmIV/MX4flt
         a4lA==
X-Gm-Message-State: ACrzQf0WKstwIp2tiw2eDN5wGhV+QWjHWDKa4DamCiPc87wYxQvlubh5
        0i2lICr08YYtf9A6gahXB7w1p2X3OZpjrA==
X-Google-Smtp-Source: AMsMyM5eYGwBb2lOBv3WauL41kMicLHsighp2bPkzDEF5Qw73X74uIZgo2pbNUn6cByzLUOJKG31slBGCK+GKw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a5b:c42:0:b0:6d0:efa4:d136 with SMTP id
 d2-20020a5b0c42000000b006d0efa4d136mr1ybr.463.1667497669503; Thu, 03 Nov 2022
 10:47:49 -0700 (PDT)
Date:   Thu,  3 Nov 2022 10:47:39 -0700
In-Reply-To: <20221103174740.3492603-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221103174740.3492603-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221103174740.3492603-2-dlatypov@google.com>
Subject: [PATCH v2 2/3] kunit: tool: unit tests all check parser errors,
 standardize formatting a bit
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
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

Let's verify that the parser isn't reporting any errors for valid
inputs.

This change also
* does result.status checking on one line
* makes sure we consistently do it outside of the `with` block

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: just rebased onto linux-kselftest/kunit
---
 tools/testing/kunit/kunit_tool_test.py | 93 +++++++++++---------------
 1 file changed, 38 insertions(+), 55 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 440a273f1d21..5e3429a1202b 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -136,33 +136,29 @@ class KUnitParserTest(unittest.TestCase):
 		all_passed_log = test_data_path('test_is_test_passed-all_passed.log')
 		with open(all_passed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual(
-			kunit_parser.TestStatus.SUCCESS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_parse_successful_nested_tests_log(self):
 		all_passed_log = test_data_path('test_is_test_passed-all_passed_nested.log')
 		with open(all_passed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual(
-			kunit_parser.TestStatus.SUCCESS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_kselftest_nested(self):
 		kselftest_log = test_data_path('test_is_test_passed-kselftest.log')
 		with open(kselftest_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_parse_failed_test_log(self):
 		failed_log = test_data_path('test_is_test_passed-failure.log')
 		with open(failed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual(
-			kunit_parser.TestStatus.FAILURE,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_no_header(self):
 		empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
@@ -170,9 +166,8 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
 		self.assertEqual(0, len(result.subtests))
-		self.assertEqual(
-			kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS, result.status)
+		self.assertEqual(result.counts.errors, 1)
 
 	def test_missing_test_plan(self):
 		missing_plan_log = test_data_path('test_is_test_passed-'
@@ -183,9 +178,7 @@ class KUnitParserTest(unittest.TestCase):
 				file.readlines()))
 		# A missing test plan is not an error.
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=0))
-		self.assertEqual(
-			kunit_parser.TestStatus.SUCCESS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 
 	def test_no_tests(self):
 		header_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
@@ -193,9 +186,8 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
 		self.assertEqual(0, len(result.subtests))
-		self.assertEqual(
-			kunit_parser.TestStatus.NO_TESTS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.NO_TESTS, result.status)
+		self.assertEqual(result.counts.errors, 1)
 
 	def test_no_tests_no_plan(self):
 		no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
@@ -206,7 +198,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.subtests[0].subtests[0].status)
-		self.assertEqual(1, result.counts.errors)
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=1))
 
 
 	def test_no_kunit_output(self):
@@ -218,6 +210,7 @@ class KUnitParserTest(unittest.TestCase):
 		print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
 		print_mock.stop()
 		self.assertEqual(0, len(result.subtests))
+		self.assertEqual(result.counts.errors, 1)
 
 	def test_skipped_test(self):
 		skipped_log = test_data_path('test_skip_tests.log')
@@ -225,18 +218,16 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(file.readlines())
 
 		# A skipped test does not fail the whole suite.
-		self.assertEqual(
-			kunit_parser.TestStatus.SUCCESS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=4, skipped=1))
 
 	def test_skipped_all_tests(self):
 		skipped_log = test_data_path('test_skip_all_tests.log')
 		with open(skipped_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 
-		self.assertEqual(
-			kunit_parser.TestStatus.SKIPPED,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SKIPPED, result.status)
+		self.assertEqual(result.counts, kunit_parser.TestCounts(skipped=5))
 
 	def test_ignores_hyphen(self):
 		hyphen_log = test_data_path('test_strip_hyphen.log')
@@ -244,9 +235,7 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(file.readlines())
 
 		# A skipped test does not fail the whole suite.
-		self.assertEqual(
-			kunit_parser.TestStatus.SUCCESS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(
 			"sysctl_test",
 			result.subtests[0].name)
@@ -260,55 +249,49 @@ class KUnitParserTest(unittest.TestCase):
 		prefix_log = test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = test_data_path('test_multiple_prefixes.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_prefix_poundsign(self):
 		pound_log = test_data_path('test_pound_sign.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_kernel_panic_end(self):
 		panic_log = test_data_path('test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.TEST_CRASHED,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertGreaterEqual(result.counts.errors, 1)
 
 	def test_pound_no_prefix(self):
 		pound_log = test_data_path('test_pound_no_prefix.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_summarize_failures(self):
 		output = """
-- 
2.38.1.431.g37b22c650d-goog

