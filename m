Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F136B9214
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjCNLu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCNLur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:50:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C84E29E00
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:50:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A0CD1063;
        Tue, 14 Mar 2023 04:51:29 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E009F3F67D;
        Tue, 14 Mar 2023 04:50:44 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, robin.murphy@arm.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Subject: [PATCH 2/4] lib: test clear_user()
Date:   Tue, 14 Mar 2023 11:50:28 +0000
Message-Id: <20230314115030.347976-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230314115030.347976-1-mark.rutland@arm.com>
References: <20230314115030.347976-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clear_user() function follows the same conventions as
copy_{to,from}_user(), and presumably has identical requirements on the
return value. Test it in the same way.

I've given this a spin on a few architectures using the KUnit QEMU
harness, and it looks like most get *something* wrong, or I've
misunderstood and clear_user() doesn't have the same requirements as
copy_{to,from}_user()). From those initial runs:

* arm, arm64, i386, riscv, x86_64  don't ensure that at least 1 byte is
  zeroed when a partial zeroing is possible, e.g.

  | too few bytes consumed (offset=4095, size=2, ret=2)
  | too few bytes consumed (offset=4093, size=4, ret=4)
  | too few bytes consumed (offset=4089, size=8, ret=8)

* s390 reports that some bytes have been zeroed even when they haven't,
  e.g.

  | zeroed bytes incorrect (dst_page[4031+64]=0xca, offset=4031, size=66, ret=1

* sparc passses all tests

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 lib/usercopy_kunit.c | 89 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 7 deletions(-)

diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
index 0c73177b6ce5..8e037e3a46e3 100644
--- a/lib/usercopy_kunit.c
+++ b/lib/usercopy_kunit.c
@@ -152,6 +152,11 @@ void usercopy_test_exit(struct kunit *test)
 	usercopy_env_free(env);
 }
 
+static char buf_zero(int offset)
+{
+	return 0;
+}
+
 static char buf_pattern(int offset)
 {
 	return offset & 0xff;
@@ -227,6 +232,7 @@ static void assert_size_valid(struct kunit *test,
 
 static void assert_src_valid(struct kunit *test,
 			     const struct usercopy_params *params,
+			     char (*buf_expected)(int),
 			     const char *src, long src_offset,
 			     unsigned long ret)
 {
@@ -237,9 +243,10 @@ static void assert_src_valid(struct kunit *test,
 	 * A usercopy MUST NOT modify the source buffer.
 	 */
 	for (int i = 0; i < PAGE_SIZE; i++) {
+		char expected = buf_expected(i);
 		char val = src[i];
 
-		if (val == buf_pattern(i))
+		if (val == expected)
 			continue;
 
 		KUNIT_ASSERT_FAILURE(test,
@@ -250,6 +257,7 @@ static void assert_src_valid(struct kunit *test,
 
 static void assert_dst_valid(struct kunit *test,
 			     const struct usercopy_params *params,
+			     char (*buf_expected)(int),
 			     const char *dst, long dst_offset,
 			     unsigned long ret)
 {
@@ -260,9 +268,10 @@ static void assert_dst_valid(struct kunit *test,
 	 * A usercopy MUST NOT modify any bytes before the destination buffer.
 	 */
 	for (int i = 0; i < dst_offset; i++) {
+		char expected = buf_expected(i);
 		char val = dst[i];
 
-		if (val == 0)
+		if (val == expected)
 			continue;
 
 		KUNIT_ASSERT_FAILURE(test,
@@ -275,9 +284,10 @@ static void assert_dst_valid(struct kunit *test,
 	 * buffer.
 	 */
 	for (int i = dst_offset + size - ret; i < PAGE_SIZE; i++) {
+		char expected = buf_expected(i);
 		char val = dst[i];
 
-		if (val == 0)
+		if (val == expected)
 			continue;
 
 		KUNIT_ASSERT_FAILURE(test,
@@ -313,6 +323,29 @@ static void assert_copy_valid(struct kunit *test,
 	}
 }
 
+static void assert_clear_valid(struct kunit *test,
+			       const struct usercopy_params *params,
+			       const char *dst, long dst_offset,
+			       unsigned long ret)
+{
+	const unsigned long size = params->size;
+	const unsigned long offset = params->offset;
+
+	/*
+	 * Have we actually zeroed the bytes we expected to?
+	 */
+	for (int i = 0; i < params->size - ret; i++) {
+		char dst_val = dst[dst_offset + i];
+
+		if (dst_val == 0)
+			continue;
+
+		KUNIT_ASSERT_FAILURE(test,
+			"zeroed bytes incorrect (dst_page[%ld+%d]=0x%x, offset=%ld, size=%lu, ret=%lu",
+			dst_offset, i, dst_val,
+			offset, size, ret);
+	}
+}
 static unsigned long do_copy_to_user(const struct usercopy_env *env,
 				     const struct usercopy_params *params)
 {
@@ -341,6 +374,19 @@ static unsigned long do_copy_from_user(const struct usercopy_env *env,
 	return ret;
 }
 
+static unsigned long do_clear_user(const struct usercopy_env *env,
+				   const struct usercopy_params *params)
+{
+	void __user *uptr = (void __user *)UBUF_ADDR_BASE + params->offset;
+	unsigned long ret;
+
+	kthread_use_mm(env->mm);
+	ret = clear_user(uptr, params->size);
+	kthread_unuse_mm(env->mm);
+
+	return ret;
+}
+
 /*
  * Test offsets in the ranges [-size, 0] and [PAGE_SIZE - size, PAGE_SIZE] so
  * that we check all possible fault boundaries.
@@ -368,8 +414,10 @@ static void test_copy_to_user(struct kunit *test)
 		ret = do_copy_to_user(env, &params);
 
 		assert_size_valid(test, &params, ret);
-		assert_src_valid(test, &params, env->kbuf, 0, ret);
-		assert_dst_valid(test, &params, env->ubuf, params.offset, ret);
+		assert_src_valid(test, &params, buf_pattern,
+				 env->kbuf, 0, ret);
+		assert_dst_valid(test, &params, buf_zero,
+				 env->ubuf, params.offset, ret);
 		assert_copy_valid(test, &params,
 				  env->ubuf, params.offset,
 				  env->kbuf, 0,
@@ -395,8 +443,10 @@ static void test_copy_from_user(struct kunit *test)
 		ret = do_copy_from_user(env, &params);
 
 		assert_size_valid(test, &params, ret);
-		assert_src_valid(test, &params, env->ubuf, params.offset, ret);
-		assert_dst_valid(test, &params, env->kbuf, 0, ret);
+		assert_src_valid(test, &params, buf_pattern,
+				 env->ubuf, params.offset, ret);
+		assert_dst_valid(test, &params, buf_zero,
+				 env->kbuf, 0, ret);
 		assert_copy_valid(test, &params,
 				  env->kbuf, 0,
 				  env->ubuf, params.offset,
@@ -404,6 +454,30 @@ static void test_copy_from_user(struct kunit *test)
 	}
 }
 
+static void test_clear_user(struct kunit *test)
+{
+	const struct usercopy_env *env = test->priv;
+	const unsigned long size = *(unsigned long *)test->param_value;
+
+	for_each_offset(size, offset) {
+		const struct usercopy_params params = {
+			.size = size,
+			.offset = offset,
+		};
+		unsigned long ret;
+
+		buf_init_pattern(env->ubuf);
+
+		ret = do_clear_user(env, &params);
+
+		assert_size_valid(test, &params, ret);
+		assert_dst_valid(test, &params, buf_pattern,
+				 env->ubuf, params.offset, ret);
+		assert_clear_valid(test, &params,
+				   env->ubuf, params.offset,
+				   ret);
+	}
+}
 static const void *gen_size(const void *prev, char *desc)
 {
 	/*
@@ -430,6 +504,7 @@ static const void *gen_size(const void *prev, char *desc)
 static struct kunit_case usercopy_cases[] = {
 	KUNIT_CASE_PARAM(test_copy_to_user,	gen_size),
 	KUNIT_CASE_PARAM(test_copy_from_user,	gen_size),
+	KUNIT_CASE_PARAM(test_clear_user,	gen_size),
 	{ /* sentinel */ }
 };
 
-- 
2.30.2

