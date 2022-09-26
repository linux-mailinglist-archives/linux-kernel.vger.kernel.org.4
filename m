Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83D5EAF77
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIZSS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiIZSRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:17:55 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7F36307
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:08:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664215732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OEmgNjB4wCnJJ/8lBPr8SNJcQWguKZ9xXHXJI9R5iDU=;
        b=BRXYv2H584+i+PNOK70i9qNvTUWg/p+2sFGdXri1p9nBLJi3RZSOtMmUlDiFOKaO22xIGa
        JLzhq+Hhl4BGW8Yct87UHnN4sLdRqozlm9FYN160o6gDw7B2NOBfZ9d3OQO6xkAwjmGyqb
        3VcGdLmgtTGBoN82/zZAh66KS3AAR4g=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH mm v3] kasan: fix array-bounds warnings in tests
Date:   Mon, 26 Sep 2022 20:08:47 +0200
Message-Id: <e94399242d32e00bba6fd0d9ec4c897f188128e8.1664215688.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

GCC's -Warray-bounds option detects out-of-bounds accesses to
statically-sized allocations in krealloc out-of-bounds tests.

Use OPTIMIZER_HIDE_VAR to suppress the warning.

Also change kmalloc_memmove_invalid_size to use OPTIMIZER_HIDE_VAR
instead of a volatile variable.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Add comment for added -Warray-bounds-related OPTIMIZER_HIDE_VAR.

Changes v1->v2:
- Hide ptr2 instead of size1 and size2 to be consistent with other
  uses of OPTIMIZER_HIDE_VAR in KASAN tests.
---
 mm/kasan/kasan_test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 71cb402c404f..f50b11d84f41 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -333,6 +333,9 @@ static void krealloc_more_oob_helper(struct kunit *test,
 	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
+	/* Suppress -Warray-bounds warnings. */
+	OPTIMIZER_HIDE_VAR(ptr2);
+
 	/* All offsets up to size2 must be accessible. */
 	ptr2[size1 - 1] = 'x';
 	ptr2[size1] = 'x';
@@ -365,6 +368,9 @@ static void krealloc_less_oob_helper(struct kunit *test,
 	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
+	/* Suppress -Warray-bounds warnings. */
+	OPTIMIZER_HIDE_VAR(ptr2);
+
 	/* Must be accessible for all modes. */
 	ptr2[size2 - 1] = 'x';
 
@@ -578,13 +584,14 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 64;
-	volatile size_t invalid_size = size;
+	size_t invalid_size = size;
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	memset((char *)ptr, 0, 64);
 	OPTIMIZER_HIDE_VAR(ptr);
+	OPTIMIZER_HIDE_VAR(invalid_size);
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
 	kfree(ptr);
-- 
2.25.1

