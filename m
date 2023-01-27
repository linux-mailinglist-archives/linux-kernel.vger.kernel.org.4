Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEC067EFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjA0UkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjA0UkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:40:02 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC8525E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:40:00 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-50e79ffba49so15043487b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u+ZZ9p781yCGWGhKmADH/0418YnSRPB2SqiYOsVCxzU=;
        b=A6JlZFb7CVuOavpAylaTk5HwDcm0WGYTmzkpPK8mmDQnIxyEsYX9oYPORN/hfeHDj5
         oQuzJQENfM10DmxxtmDOnkEmahRDrp29hpuYIOmurWH5HzP0PJ2v2K7YXil7/OW/bwTC
         dqTeWLdU1TzBokqJk2IFJ7tGopvdqZ2468U+Tqx5jjS4SBIMuTZGR9QuFHfZ03fLcrJT
         LBy1d7/Y05xUBmwcnME+oelGxry3N2l2s1eSGBCkgR2Ggfc4B4wDoJ9KRW0uQFGcyhtK
         LRXV1pZ86mYKDGLvWii1rVdaMBvJVED7OJYqMU/oJMVClSLZ0eleOaZij6Bg+c68EqqN
         gO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+ZZ9p781yCGWGhKmADH/0418YnSRPB2SqiYOsVCxzU=;
        b=7JUTNCQHMjSqztx9mplaY8NWKHKEKIv49VpCafX8FkjYphyBkH+0q5BKIUYhxAISAh
         AIyjubVGFkbSZzRgrLJctcew1whcFWbQbjFr86awIp0Dzpw0sCLSZCp2LLIU2fV4D0h1
         2T+AbNdtzW0YWwCxMIgFsGvmtHzF+PndAYRm4JB142Hxm9hKVqexLs32NvJiEIEuEV9H
         I+p/DdjeCz+9Fu0jUBmuWEdOt3cz5AJa2ZbovRohqusInuTCRNQaOv9P2oHE/ub4QWX9
         rwPvHrOCErq/Bbr55IaaMIKfa7ETbkl3E7gQP30PLY0ah89itel7crRSMvp/Vai4iNUu
         IvtA==
X-Gm-Message-State: AFqh2kq2MzE9RqwoHRmspxu7POeLCCcSJgVdB1srmnCzefN2/iiss7jP
        67xtRdXd24ZhdD9n23mEqdaizjSipQ==
X-Google-Smtp-Source: AMrXdXuPcu/1HyWMZxkQNYdH1uCMQtAIbIWjIobrk+RBOnzPJ3u60idt2oucdbsREx8EPdkPFjkwIVXpGg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:442:0:b0:7b9:dd43:3d10 with SMTP id
 s2-20020a5b0442000000b007b9dd433d10mr4253867ybp.170.1674851999871; Fri, 27
 Jan 2023 12:39:59 -0800 (PST)
Date:   Fri, 27 Jan 2023 20:39:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127203950.781709-1-rmoar@google.com>
Subject: [PATCH v2] kunit: fix bug in KUNIT_EXPECT_MEMEQ
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>, kernel test robot <lkp@intel.com>
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

In KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ, add check if one of the
inputs is NULL and fail if this is the case.

Currently, the kernel crashes if one of the inputs is NULL. Instead,
fail the test and add an appropriate error message.

Fixes: b8a926bea8b1 ("kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros")

This was found by the kernel test robot:
https://lore.kernel.org/all/202212191448.D6EDPdOh-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---

Changes since v1:
- Fix formatting of backslashes
- Add Fixes: ... statement to commit message

 include/kunit/test.h |  5 +++--
 lib/kunit/assert.c   | 40 +++++++++++++++++++++++++---------------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 87ea90576b50..a20bff149bdf 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -683,8 +683,9 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
-	if (likely(memcmp(__left, __right, __size) op 0))		       \
-		break;							       \
+	if (likely(__left && __right))					       \
+		if (likely(memcmp(__left, __right, __size) op 0))	       \
+			break;						       \
 									       \
 	_KUNIT_FAILED(test,						       \
 		      assert_type,					       \
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index f5b50babe38d..05a09652f5a1 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -241,24 +241,34 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
 	mem_assert = container_of(assert, struct kunit_mem_assert,
 				  assert);
 
-	string_stream_add(stream,
-			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
-			  mem_assert->text->left_text,
-			  mem_assert->text->operation,
-			  mem_assert->text->right_text);
+	if (!mem_assert->left_value) {
+		string_stream_add(stream,
+				  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
+				  mem_assert->text->left_text);
+	} else if (!mem_assert->right_value) {
+		string_stream_add(stream,
+				  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
+				  mem_assert->text->right_text);
+	} else {
+		string_stream_add(stream,
+				KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
+				mem_assert->text->left_text,
+				mem_assert->text->operation,
+				mem_assert->text->right_text);
 
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
-			  mem_assert->text->left_text);
-	kunit_assert_hexdump(stream, mem_assert->left_value,
-			     mem_assert->right_value, mem_assert->size);
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
+				mem_assert->text->left_text);
+		kunit_assert_hexdump(stream, mem_assert->left_value,
+					mem_assert->right_value, mem_assert->size);
 
-	string_stream_add(stream, "\n");
+		string_stream_add(stream, "\n");
 
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
-			  mem_assert->text->right_text);
-	kunit_assert_hexdump(stream, mem_assert->right_value,
-			     mem_assert->left_value, mem_assert->size);
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
+				mem_assert->text->right_text);
+		kunit_assert_hexdump(stream, mem_assert->right_value,
+					mem_assert->left_value, mem_assert->size);
 
-	kunit_assert_print_msg(message, stream);
+		kunit_assert_print_msg(message, stream);
+	}
 }
 EXPORT_SYMBOL_GPL(kunit_mem_assert_format);

base-commit: 5835ffc27381c2d32c3f0d7b575cb3397555ab47
-- 
2.39.1.456.gfc5497dd1b-goog

