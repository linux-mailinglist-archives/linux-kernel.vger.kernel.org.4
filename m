Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF785E8F9E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 22:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiIXUX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 16:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIXUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 16:23:27 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175E140BDB
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 13:23:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664051004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nC3nuVqN+jtEUN74Nl68oDoRxZZaXpDu+Kubg+3Y4uE=;
        b=K5b/cTkQVPZHrmVwC5a5EZ6fbHafwPdgOTRisgbxnFrlDyFsNV8EppN8s8pwk3WvoYaKMh
        2jMjRVOcQmLC7gpvopmtr3Sjin8ubOEGUnRny9AGIWZGq0fj7LCCb784kCWrUGCCFlpiDQ
        mFqrQzCTdUdXXfuIweR95PiUh6ngdA4=
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
Subject: [PATCH mm v2] kasan: fix array-bounds warnings in tests
Date:   Sat, 24 Sep 2022 22:23:21 +0200
Message-Id: <9c0210393a8da6fb6887a111a986eb50dfc1b895.1664050880.git.andreyknvl@google.com>
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

Changes v1->v2:
- Hide ptr2 instead of size1 and size2 to be consistent with other
  uses of OPTIMIZER_HIDE_VAR in KASAN tests.
---
 mm/kasan/kasan_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 71cb402c404f..dbb0a672380f 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -333,6 +333,8 @@ static void krealloc_more_oob_helper(struct kunit *test,
 	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
+	OPTIMIZER_HIDE_VAR(ptr2);
+
 	/* All offsets up to size2 must be accessible. */
 	ptr2[size1 - 1] = 'x';
 	ptr2[size1] = 'x';
@@ -365,6 +367,8 @@ static void krealloc_less_oob_helper(struct kunit *test,
 	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
+	OPTIMIZER_HIDE_VAR(ptr2);
+
 	/* Must be accessible for all modes. */
 	ptr2[size2 - 1] = 'x';
 
@@ -578,13 +582,14 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
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

