Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508D1616989
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiKBQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiKBQoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:44:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3332C1091
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:40:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3735edd4083so13057957b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZjB45a45rutWjA+XLmdtGaPTf89LQ7I82Y87jESqw/E=;
        b=TThmGMaKDwr5Yq89Ge7CBv9F3nGKgkxzMezafPFOSGrcBJ62ynXFUl1+A7oOaMXc4B
         +jQuiVsVT+anfNPfGaAWXZiDOowjg4GflM2pwF894XsOX2UIzrb+DjfCamaRVRUaDI9H
         rBT/Z63Icyqp6BwC6Y4tkHQ3wGyVnD6/+ayrJE2lY2PEprcJq584Euoi+IrU32cHas2E
         q6wROmt+Y/acS2U1YWQn2duBlVITJeapYk444PYALlP32+zSB6gogeNgzdyXS4AVdIqn
         rgt42cIbAAvZMMmxlVRLWqroBNwo52oaFhMHClNLuEVERyAlaOvplSgq6mp2AcNjPJ2+
         fYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjB45a45rutWjA+XLmdtGaPTf89LQ7I82Y87jESqw/E=;
        b=szYEeMQ/X57xkXTy5d2/zSXtzcgwtEbi9m+RnvPdhXtOh8MqinNAK/6DxbOK0DcN9i
         dGa0I+BCl3ehT9+xCr3z70uPH0LpllobMgELr+8gqTeY4w+9c+4OK7W1CIsWwb9lCFl4
         zoI6h6MSOw9V6WfoJ7zpW+cs0UypDq3W8D1kexSvnA5vkNj1TM6WeCEdAxsVTDuDKVjm
         g2oxPmvc9BgGHtMMgknXYD5RvJr8HnD32Xw45RyCZb7py7s1th1U5WQ7jU3CEPeQY8sY
         IhUObzftrx+2t7EcA5igmjaakrm0/92ymBRstvJtp/DuICik95rFtbleiEBRtNxqWwLO
         Hw/A==
X-Gm-Message-State: ACrzQf25jEujw1lxBqlblyEnYDQ0wqAX/xWbP30HNVIPHPs2GpBb6NMw
        0QM34jNLh+kumjZmL1Kb7oFx8w7ORvFaMQ==
X-Google-Smtp-Source: AMsMyM4MBv11jPTPF5iyCDgee/aPPQtWa7OASVawg4C96AS2PJqsB8Ywx1GyPp25Bz02AOYjXU49BvAWvnlqfw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a25:744d:0:b0:6cb:9331:244b with SMTP id
 p74-20020a25744d000000b006cb9331244bmr24381988ybc.140.1667407241468; Wed, 02
 Nov 2022 09:40:41 -0700 (PDT)
Date:   Wed,  2 Nov 2022 09:40:03 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102164005.2516646-1-dlatypov@google.com>
Subject: [PATCH 1/3] kunit: tool: make TestCounts a dataclass
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

Since we're using Python 3.7+, we can use dataclasses to tersen the
code.

It also lets us create pre-populated TestCounts() objects and compare
them in our unit test. (Before, you could only create empty ones).

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py    | 25 ++++++++-----------------
 tools/testing/kunit/kunit_tool_test.py |  4 +---
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 1ae873e3e341..f022966858f2 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -10,6 +10,7 @@
 # Author: Rae Moar <rmoar@google.com>
 
 from __future__ import annotations
+from dataclasses import dataclass
 import re
 import sys
 
@@ -67,27 +68,17 @@ class TestStatus(Enum):
 	NO_TESTS = auto()
 	FAILURE_TO_PARSE_TESTS = auto()
 
+@dataclass
 class TestCounts:
 	"""
 	Tracks the counts of statuses of all test cases and any errors within
 	a Test.
-
-	Attributes:
-	passed : int - the number of tests that have passed
-	failed : int - the number of tests that have failed
-	crashed : int - the number of tests that have crashed
-	skipped : int - the number of tests that have skipped
-	errors : int - the number of errors in the test and subtests
-	"""
-	def __init__(self):
-		"""Creates TestCounts object with counts of all test
-		statuses and test errors set to 0.
-		"""
-		self.passed = 0
-		self.failed = 0
-		self.crashed = 0
-		self.skipped = 0
-		self.errors = 0
+	"""
+	passed: int = 0
+	failed: int = 0
+	crashed: int = 0
+	skipped: int = 0
+	errors: int = 0
 
 	def __str__(self) -> str:
 		"""Returns the string representation of a TestCounts object."""
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index e2cd2cc2e98f..9fa4babb2506 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -179,9 +179,7 @@ class KUnitParserTest(unittest.TestCase):
 				kunit_parser.extract_tap_lines(
 				file.readlines()))
 		# A missing test plan is not an error.
-		self.assertEqual(0, result.counts.errors)
-		# All tests should be accounted for.
-		self.assertEqual(10, result.counts.total())
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=0))
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)

base-commit: 5aaef24b5c6d4246b2cac1be949869fa36577737
-- 
2.38.1.273.g43a17bfeac-goog

