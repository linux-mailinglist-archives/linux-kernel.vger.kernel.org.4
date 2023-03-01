Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662DA6A64BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCABWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCABWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:22:38 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E7434013;
        Tue, 28 Feb 2023 17:22:08 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id m25-20020a05683026d900b006941a2838caso1914219otu.7;
        Tue, 28 Feb 2023 17:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677633727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFOKSBWc8WowlLvLou8USMbRJNKtCWHr5Pw01m+DTEY=;
        b=deZtwNPkm9J/d68tkiSxoBYuNpQ5yM10CjBBg/Ofw6YTRI1hFQLUVLUIjvElPP/CC4
         po8yjDlBX2nHOfaN4/Kk6pimszP/wBloqR8bY1374tWuZFVoNSWiWLzXnUqMedSk3wrg
         rmlnqbRDBGrF8wgmUCzDYnam2k4a7ttQahN1hVOo7lVFbmTdBHOMCr25ThMzMiEQvI3j
         saTsq2maUW7ov5GxnbxKtUahcJx+QCT5C9G/Okdahj/MMGh63mumhTvS7jG7gfrkYhDa
         taFUXJ+wiX4TwOc7gPUB+v47cGZz/yIed0EV65q5Qz3xmLapzcF9KDHJaz5Hwl6uNcdT
         XTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677633727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFOKSBWc8WowlLvLou8USMbRJNKtCWHr5Pw01m+DTEY=;
        b=u35JHgnK6FVneXt1uqpg+BIJF+wkw9f+j5BY4R6/5pw/GPhM12GvUeMrQq/a76voZQ
         RrdY9x1q2QrChKD/QZuuvW0+lQADY7aK5eAmIw8tLkYqEZYVUCFxemjSlJgZyeuoNhDI
         KWFm+Nv2ISohsKeFjQnKAlv2DojkaTqPFpKlbkz9lUCuub9HEJpsngJlHhKJJ0Whg7ZJ
         7ZhI8Wh+hb+SBx3D5LWKiSb5awAWJF1f4qtYRLHW/kMHLghduKqphgj4XVf3B1giAX4s
         Foi8UFZLh5s0W1E3c/o8uoP2SHQNVzsMeJ5l7pqEmJHhn68vaLEyPmUMwjNu2+QV+WBs
         VMHQ==
X-Gm-Message-State: AO0yUKWdMHh5Ig8CCneONAapJQ1KN14wBr0KTEe4TgS8tZz/ICcIaXby
        k4NoC9ysqMSeUFZvdt9FZbw=
X-Google-Smtp-Source: AK7set95J8Etj2zVh+StRrCMklVMVXTI2yjVRBh+WttI6NlLlDAPLjyJIXl+A/ZAqJwRRvAn5WeIpA==
X-Received: by 2002:a05:6830:31bc:b0:68b:c04d:79ca with SMTP id q28-20020a05683031bc00b0068bc04d79camr2536315ots.33.1677633726875;
        Tue, 28 Feb 2023 17:22:06 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:20c1:2bed:d8f3:84d8])
        by smtp.gmail.com with ESMTPSA id v2-20020a056830140200b006864b5f4650sm4436362otp.46.2023.02.28.17.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 17:22:06 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/2] of: unittest: option to allow tests that trigger kernel stack dump
Date:   Tue, 28 Feb 2023 19:21:15 -0600
Message-Id: <20230301012116.1488132-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301012116.1488132-1-frowand.list@gmail.com>
References: <20230301012116.1488132-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 74df14cd301a ("of: unittest: add node lifecycle tests") added
some tests that trigger a kernel stack dump.  Filtering the boot
messages with scripts/dtc/of_unittest_expect detects that the stack
dump is expected instead of being a test error.

Test beds might interpret the stack dumps as errors, resulting in
needless debugging and error reports.  These test beds are likely
to remove unittests due to these stack dumps. To avoid these problems,
have unittest default to skip the tests that trigger a stack dump.

Add a kernel cmdline option to not skip those tests.  This option can
be used by testers who are able to interpret the stack dumps as not
an error.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---
 drivers/of/unittest.c | 54 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index b5a7a31d8bd2..3a9bc2bc4ba1 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -70,6 +70,36 @@ static struct unittest_results {
 #define EXPECT_NOT_END(level, fmt, ...) \
 	printk(level pr_fmt("EXPECT_NOT / : ") fmt, ##__VA_ARGS__)
 
+/*
+ * Some tests will cause the kernel to emit a stack dump, aka back trace,
+ * when the test is successful.  The tests should make it possible for
+ * test beds to detect that the trace is not an error via EXPECT_BEGIN().
+ *
+ * Most test beds do not process the EXPECT_BEGIN() information and may
+ * flag the stack dump as an error, thus reporting a false failure.  It
+ * is hoped that the KTAP version 4 specification will add the EXPECT_BEGIN()
+ * processing to test beds.
+ *
+ * By default, skip tests that cause a stack dump.  Test beds that process
+ * EXPECT_BEGIN() information should enable these tests via a kernel boot
+ * command line option.
+ */
+static int stackdump_tests_enabled;
+
+static int __init enable_unittest_stackdump(char *str)
+{
+	stackdump_tests_enabled = 1;
+	return 0;
+}
+
+static int __init disable_unittest_stackdump(char *str)
+{
+	stackdump_tests_enabled = 0;
+	return 0;
+}
+early_param("of_unittest_stackdump", enable_unittest_stackdump);
+early_param("no_of_unittest_stackdump", disable_unittest_stackdump);
+
 static void __init of_unittest_find_node_by_name(void)
 {
 	struct device_node *np;
@@ -3047,19 +3077,26 @@ static void __init of_unittest_lifecycle(void)
 			of_node_put(np);
 	}
 
+	if (!stackdump_tests_enabled)
+		goto out_skip_stackdump_tests;
+
 	EXPECT_BEGIN(KERN_INFO, "OF: ERROR: of_node_release() detected bad of_node_put() on /testcase-data/refcount-node");
 
 	/*
 	 * refcount is now one, decrementing to zero will result in a call to
 	 * of_node_release() to free the node's memory, which should result
-	 * in an error
+	 * in an error.
+	 *
+	 * A refcount of zero will also trigger errors in
+	 * of_unittest_check_node_linkage(), so after this block of test,
+	 * will directly manipulate the devicetree to remove this node.
+	 * (See the code marked as "WARNING:  EVIL, EVIL, EVIL:".)
 	 */
 	unittest(1, "/testcase-data/refcount-node is one");
 	of_node_put(np);
 
 	EXPECT_END(KERN_INFO, "OF: ERROR: of_node_release() detected bad of_node_put() on /testcase-data/refcount-node");
 
-
 	/*
 	 * expect stack trace for subsequent of_node_put():
 	 *   __refcount_sub_and_test() calls:
@@ -3138,9 +3175,20 @@ static void __init of_unittest_lifecycle(void)
 
 	return;
 
+out_skip_stackdump_tests:
+	/*
+	 * Pass test since we don't yet have a way to annotate reason for an
+	 * intentional skip until implementing the KTAP format.
+	 */
+	unittest(1, "Lifecycle stackdump tests skipped\n");
+	return;
+
 out_skip_tests:
+	/* skip is due to an earlier failure */
+	unittest(0, "One or more lifecycle tests skipped due to previous fails\n");
+#else
+	unittest(1, "Lifecycle tests skipped because CONFIG_DYNAMIC=n\n");
 #endif
-	unittest(0, "One or more lifecycle tests skipped\n");
 }
 
 #ifdef CONFIG_OF_OVERLAY
-- 
Frank Rowand <frowand.list@gmail.com>

