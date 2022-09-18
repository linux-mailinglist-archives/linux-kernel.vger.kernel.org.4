Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6195BBB34
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIRDHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIRDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:07:24 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD5029826
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id m9so19568822qvv.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gCTBhSJCs9AiuXZ3/z9oldmsugRUUzLPVuV6iPHNgs8=;
        b=XhDaXNRo59ti0TtQTlfbrxgmn5EDvUx7/ssBEaoqZlIAA5rJDS6OODpSgxS5wjc5Ge
         jj20aIk3+lD2ohD/oaYsEYmKvPYeO2L2PXq41SOvawjTeydWfIiYgFkr2/oTXJ+7/k47
         GzxsMkRdSOWDPVgUnKMbyxsQltwMB1oIJ9nCMqiRCmbXxGxhrtVJsTKNvvk4U8mjI4G/
         uDOiAAF/TlCZIVFFwtV2OdHFZS444JWj1HPMZQGLk8nC26pCEaJ7EG1/DfnrePjJnkTJ
         c3ZBRytrIUzAw2BmNjOl4DmCNLtFKH5+9RX1cyX4K7RBXj/eAUizAb3rssdNRyldYHME
         +YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gCTBhSJCs9AiuXZ3/z9oldmsugRUUzLPVuV6iPHNgs8=;
        b=LLyg7Ds6oHYgSQbM/JyZD4XHY2iGHGdY0hj39ngTkskwYJl46m1TuFbQJ/kgGBd3Oa
         rxFkZDdhGGQ0ud1ZFN9TIetZt8PJrQFcq6+8egWso/hqqa3zMClxnIeByWOs0wsXNPfx
         y4jqFnJ5k1TBTRwbK2V7cRDfMTyYGznQt4xcdj8BvX+5K/mHBv9gb2xlmrhLdOudsFNP
         BlGkDNL5U+0yXjUrBMN4lp+4XNIZ5xvLqgVBFSQkjV+U9NeVVpptB43q60yB2vEhU8aM
         u1aPbVMKGGNGiQB5cNnXfoUT/lnLPtDNhDlTxz8YdDqttqryZ6NhMUCfpu8l07l4CZpc
         XAng==
X-Gm-Message-State: ACrzQf2tg76NnaFO7iUfvOi5knM2u9nsocv3jRmpxzm/0bCcwNKpCY7o
        p/J0S1R88r5qsfJuROzfvBr/drF7xtA=
X-Google-Smtp-Source: AMsMyM50AOyZ+GPk3Qx9/K6T4BSXcIR/p2CP++G9GaLBUwI+y3oftEIbytQf02XXtQPgSvP3FLCZCw==
X-Received: by 2002:a05:6214:2022:b0:4ac:b001:2c75 with SMTP id 2-20020a056214202200b004acb0012c75mr9653900qvf.83.1663470442731;
        Sat, 17 Sep 2022 20:07:22 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:a495:2224:867e:566a])
        by smtp.gmail.com with ESMTPSA id p13-20020ac8740d000000b0034454067d24sm7737188qtq.64.2022.09.17.20.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:07:22 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 4/6] lib/bitmap: add tests for find_nth_bit()
Date:   Sat, 17 Sep 2022 20:07:14 -0700
Message-Id: <20220918030716.1252285-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220918030716.1252285-1-yury.norov@gmail.com>
References: <20220918030716.1252285-1-yury.norov@gmail.com>
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

Add functional and performance tests for find_nth_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/find_bit_benchmark.c | 18 +++++++++++++++
 lib/test_bitmap.c        | 47 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index db904b57d4b8..10754586403b 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -115,6 +115,22 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
 	return 0;
 }
 
+static int __init test_find_nth_bit(const unsigned long *bitmap, unsigned long len)
+{
+	unsigned long l, n, w = bitmap_weight(bitmap, len);
+	ktime_t time;
+
+	time = ktime_get();
+	for (n = 0; n < w; n++) {
+		l = find_nth_bit(bitmap, len, n);
+		WARN_ON(l >= len);
+	}
+	time = ktime_get() - time;
+	pr_err("find_nth_bit:       %18llu ns, %6ld iterations\n", time, w);
+
+	return 0;
+}
+
 static int __init test_find_next_and_bit(const void *bitmap,
 		const void *bitmap2, unsigned long len)
 {
@@ -142,6 +158,7 @@ static int __init find_bit_test(void)
 	test_find_next_bit(bitmap, BITMAP_LEN);
 	test_find_next_zero_bit(bitmap, BITMAP_LEN);
 	test_find_last_bit(bitmap, BITMAP_LEN);
+	test_find_nth_bit(bitmap, BITMAP_LEN / 10);
 
 	/*
 	 * test_find_first_bit() may take some time, so
@@ -164,6 +181,7 @@ static int __init find_bit_test(void)
 	test_find_next_bit(bitmap, BITMAP_LEN);
 	test_find_next_zero_bit(bitmap, BITMAP_LEN);
 	test_find_last_bit(bitmap, BITMAP_LEN);
+	test_find_nth_bit(bitmap, BITMAP_LEN);
 	test_find_first_bit(bitmap, BITMAP_LEN);
 	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 98754ff9fe68..da52dc759c95 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -16,6 +16,8 @@
 
 #include "../tools/testing/selftests/kselftest_module.h"
 
+#define EXP1_IN_BITS	(sizeof(exp1) * 8)
+
 KSTM_MODULE_GLOBALS();
 
 static char pbl_buffer[PAGE_SIZE] __initdata;
@@ -219,6 +221,47 @@ static void __init test_zero_clear(void)
 	expect_eq_pbl("", bmap, 1024);
 }
 
+static void __init test_find_nth_bit(void)
+{
+	unsigned long b, bit, cnt = 0;
+	DECLARE_BITMAP(bmap, 64 * 3);
+
+	bitmap_zero(bmap, 64 * 3);
+	__set_bit(10, bmap);
+	__set_bit(20, bmap);
+	__set_bit(30, bmap);
+	__set_bit(40, bmap);
+	__set_bit(50, bmap);
+	__set_bit(60, bmap);
+	__set_bit(80, bmap);
+	__set_bit(123, bmap);
+
+	expect_eq_uint(10,  find_nth_bit(bmap, 64 * 3, 0));
+	expect_eq_uint(20,  find_nth_bit(bmap, 64 * 3, 1));
+	expect_eq_uint(30,  find_nth_bit(bmap, 64 * 3, 2));
+	expect_eq_uint(40,  find_nth_bit(bmap, 64 * 3, 3));
+	expect_eq_uint(50,  find_nth_bit(bmap, 64 * 3, 4));
+	expect_eq_uint(60,  find_nth_bit(bmap, 64 * 3, 5));
+	expect_eq_uint(80,  find_nth_bit(bmap, 64 * 3, 6));
+	expect_eq_uint(123, find_nth_bit(bmap, 64 * 3, 7));
+	expect_eq_uint(64 * 3, find_nth_bit(bmap, 64 * 3, 8));
+
+	expect_eq_uint(10,  find_nth_bit(bmap, 64 * 3 - 1, 0));
+	expect_eq_uint(20,  find_nth_bit(bmap, 64 * 3 - 1, 1));
+	expect_eq_uint(30,  find_nth_bit(bmap, 64 * 3 - 1, 2));
+	expect_eq_uint(40,  find_nth_bit(bmap, 64 * 3 - 1, 3));
+	expect_eq_uint(50,  find_nth_bit(bmap, 64 * 3 - 1, 4));
+	expect_eq_uint(60,  find_nth_bit(bmap, 64 * 3 - 1, 5));
+	expect_eq_uint(80,  find_nth_bit(bmap, 64 * 3 - 1, 6));
+	expect_eq_uint(123, find_nth_bit(bmap, 64 * 3 - 1, 7));
+	expect_eq_uint(64 * 3 - 1, find_nth_bit(bmap, 64 * 3 - 1, 8));
+
+	for_each_set_bit(bit, exp1, EXP1_IN_BITS) {
+		b = find_nth_bit(exp1, EXP1_IN_BITS, cnt++);
+		expect_eq_uint(b, bit);
+	}
+}
+
 static void __init test_fill_set(void)
 {
 	DECLARE_BITMAP(bmap, 1024);
@@ -557,8 +600,6 @@ static void __init test_bitmap_parse(void)
 	}
 }
 
-#define EXP1_IN_BITS	(sizeof(exp1) * 8)
-
 static void __init test_bitmap_arr32(void)
 {
 	unsigned int nbits, next_bit;
@@ -952,6 +993,8 @@ static void __init selftest(void)
 	test_bitmap_cut();
 	test_bitmap_print_buf();
 	test_bitmap_const_eval();
+
+	test_find_nth_bit();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.34.1

