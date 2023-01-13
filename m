Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8855A66A5B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjAMWHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjAMWHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:07:36 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A242676AF5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:07:32 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s14-20020a17090302ce00b00192d831a155so15588954plk.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tvJbCtGPjaySsYlcQ9SGihqPWmk76m7GVR1zZaETHos=;
        b=VGW1X3J7LEjFFCzmLMbT7R3kSUQNmgHK3Vr7yRvDuNGKnUl8xPF2xLfnOhVLgJ547m
         UUur7tbTSeBSgbQmOWgks+tJOH+BFqZtRp68C3wazyRRWmeNy2rvTigm2j3CG++QQ7P0
         09OBHs6IcAWO/B3kzf8czBdZz2UBeL25LTe5hMbJnyymh8PpxrpA+HdAWV1qrOEZXR1/
         fRwY38oJDw1KDmYTMsMmuS43h1diht1VEkmetY6hlyv/CjcAOQ2VDpF/bqiszn/YZVJ7
         S38x6EJ6n5UBgUZ2PjXT1H8Z/smbNH44RMmLwwnBYNLuSl1zkkgBx1F1lYzeZP7tsLFR
         039A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvJbCtGPjaySsYlcQ9SGihqPWmk76m7GVR1zZaETHos=;
        b=YjcOvbTHKlf5w/rRWUTE3LF9DyuQrI8LXP41ciddF7pC61o+oDjiA6DU3u7IkC8D+w
         3UA6Oz93awBRjNddVZBcD0pOn6nLUHIuHuGtpodiX1dXQ7gUm41t4R/gConuSCTSjoD4
         lS2sUncbZNJpyzn7Z4N3toMKPuUlNT4WW0PYgewjAMjxPR54Yooxs0AYNFege4myCVZD
         mDNI9o1TIjINQbYB8r/HJSFLf9PHdBAJ/TQInx7VjExciIzdnoQ3vMRzV0SxENo5h8lE
         5MbdFCXgW8dAVIJqI9o8454rB0WSvTkfOjuBgiJq2WHAR2H+f1pWYBX7XCUAIk3AFrMN
         UEYw==
X-Gm-Message-State: AFqh2kog7zGJjGZqZoPaaY0wWY9l4lHTiZpKiSFrUP0gqyjOxC9WI3jM
        PLDP97DtDxtu0oaKqhYNFhXAZxQ8zU+9zg==
X-Google-Smtp-Source: AMrXdXuBdEDkPZxfm94Sp7M0g9rZG7yTh1LuBgqLeG8O8vo4RQ4HalG7AGLAlyouR8VVbrGYzEU8dRu/geFUAQ==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:1109:b0:226:f85c:e099 with SMTP
 id gi9-20020a17090b110900b00226f85ce099mr2664860pjb.198.1673647651998; Fri,
 13 Jan 2023 14:07:31 -0800 (PST)
Date:   Fri, 13 Jan 2023 14:07:18 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230113220718.2901010-1-dlatypov@google.com>
Subject: [PATCH] kunit: kunit_skip() should not overwrite KUNIT_FAIL()
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
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

Currently, kunit_skip() and kunit_mark_skipped() will overwrite the
current test's status even if it was already marked FAILED.

E.g. a test that just contains this
 KUNIT_FAIL(test, "FAIL REASON");
 kunit_skip(test, "SKIP REASON");
will be marked "SKIPPED" in the end.

Now, tests like the above don't and shouldn't exist.
But what happens if non-test code (e.g. KASAN) calls kunit_fail_current_test()?

E.g. if we have
  if (do_some_invalid_memory_accesses())
    kunit_skip(");
then the KASAN failures will get masked!

This patch: make it so kunit_mark_skipped() does not modify the status
if it's already set to something (either already to SKIPPED or FAILURE).

Before this change, the KTAP output would look like
    # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:23
FAIL REASON
    ok 1 example_simple_test # SKIP SKIP REASON

After this change:
    # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:23
FAIL REASON
    # example_simple_test: status already changed, not marking skipped: SKIP REASON
    not ok 1 example_simple_test

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 87ea90576b50..39936463dde5 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -386,11 +386,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
  *
  * Marks the test as skipped. @fmt is given output as the test status
  * comment, typically the reason the test was skipped.
+ * This has no effect if the test has already been marked skipped or failed.
  *
  * Test execution continues after kunit_mark_skipped() is called.
  */
 #define kunit_mark_skipped(test_or_suite, fmt, ...)			\
 	do {								\
+		if (READ_ONCE((test_or_suite)->status) != KUNIT_SUCCESS) {\
+			kunit_warn(test_or_suite, "status already "	\
+				   "changed, not marking skipped: " fmt,\
+				   ##__VA_ARGS__);			\
+			break;						\
+		}							\
 		WRITE_ONCE((test_or_suite)->status, KUNIT_SKIPPED);	\
 		scnprintf((test_or_suite)->status_comment,		\
 			  KUNIT_STATUS_COMMENT_SIZE,			\

base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
-- 
2.39.0.314.g84b9a713c41-goog

