Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C8F5E8F99
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 22:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiIXUNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 16:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiIXUNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 16:13:33 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D25467B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 13:13:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664050408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EcbtpHcwl1Nm1cXUQncscydMAW3SGpJ+fUyDvKUD0nQ=;
        b=CcFOjNnKphgG+wY7I/0DvqEcGZ5n7WzssWBxwk/AvymIZh5IV2os3XuTWymxLHwrVXKk4M
        V6UC2WdeIHc53aLIVcygXEoXq/zKzE9dIU7sW0+RmU85ZR+0UrSI0NaEuFbZt4fLsi2GZB
        nKTzhjVfnhH3j/5Cb/JapNV49ktpch8=
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
Subject: [PATCH mm] kasan: fix array-bounds warnings in tests
Date:   Sat, 24 Sep 2022 22:13:27 +0200
Message-Id: <288e31a608ba707ea6de47fc6b43d8d79bb2d252.1664050397.git.andreyknvl@google.com>
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
 mm/kasan/kasan_test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 71cb402c404f..1d51efe131db 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -324,6 +324,9 @@ static void krealloc_more_oob_helper(struct kunit *test,
 	char *ptr1, *ptr2;
 	size_t middle;
 
+	OPTIMIZER_HIDE_VAR(size1);
+	OPTIMIZER_HIDE_VAR(size2);
+
 	KUNIT_ASSERT_LT(test, size1, size2);
 	middle = size1 + (size2 - size1) / 2;
 
@@ -356,6 +359,9 @@ static void krealloc_less_oob_helper(struct kunit *test,
 	char *ptr1, *ptr2;
 	size_t middle;
 
+	OPTIMIZER_HIDE_VAR(size1);
+	OPTIMIZER_HIDE_VAR(size2);
+
 	KUNIT_ASSERT_LT(test, size2, size1);
 	middle = size2 + (size1 - size2) / 2;
 
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

