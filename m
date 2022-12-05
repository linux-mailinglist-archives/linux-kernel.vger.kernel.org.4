Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E86642950
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiLEN0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLEN0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:26:05 -0500
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E4C1AF22
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:26:04 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id sa20-20020a1709076d1400b007bbe8699c2eso7352517ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Q1FOgaXJCU20iA2bNkMa3PVXV/y1f/l7XBgDZn5WKg=;
        b=Yhzw2muFhkrSpctjHMrj8SsAHFmyGJCXw6GpFFpUvURi+fmuds1oRDxQ8dgOH2DD4Q
         ap73GlrkaWuJQxDSzFxkDTSFaj5dZj3G1U3sQBuQkjC9Guoa8p8bjlHn7RcveQWdIC2o
         VFNSlvksKYP+RcyshKu3SzHfNTYlt+HarAf6plGqFrftjo8al/e47fDFjewh1ch5k280
         q+NSy4Gc/MFAVWRmK3XBzk1yObLS9EUexj6mLwQF9/38lU/H2eN1ngHaNI7Qm4qTmCji
         f84MRIQIsobvFVOtgzMkgRh4dzqQPYxncRp+ZeC03VP3KPo5x+Ki+XmF+xzWCd6uMGAe
         HjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Q1FOgaXJCU20iA2bNkMa3PVXV/y1f/l7XBgDZn5WKg=;
        b=qs6RzxzH28Bo14C/qGUII9trAjP0XTXoyNEM/66ssSYbX0mwS+gtDo4NnnYB2DGHR+
         0sonnWWAmN9yT+eO+tEQ7gm/ohsxiiv+DazCr5jLTBDQ1M1w69njS8rx5rSNXDjjEtFd
         FfN//YAAl1T6L1D5md8bN77sOpbJEO+ZaEAgmJysSIUv1uaD1RM/jybeoBXAsH733g2Q
         pHFRK7tu8TxbcicSIPzanc3364DQrOztoHnkuV4gX2uzHAv0gpSM3VkUFpENbvOLKcLt
         WxgP/I2Jhz9Hw8OscOiTSETeEPK8CH9h0EdP9ZEeeWYI5e0J4hbgi0pKs8SrR4frqQLA
         mH7w==
X-Gm-Message-State: ANoB5pkQrcvqO7zXekqPlaD8rvbYcDnRxLeGb9nvQ37sO+xYE3Ei4GHb
        04fJIKfHb1TNl9qcerGn1R4/UPyKYRM=
X-Google-Smtp-Source: AA0mqf7+LL7XxZUEb5XnNNcoladIKFWRiEDvClcGAXQbEL4/Xv1kfM4x36B5EWFDxzURqPf8uaOc0T3i24A=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:961a:360d:6816:d7ba])
 (user=glider job=sendgmr) by 2002:a05:6402:790:b0:46c:cd6e:811a with SMTP id
 d16-20020a056402079000b0046ccd6e811amr2821841edy.352.1670246762530; Mon, 05
 Dec 2022 05:26:02 -0800 (PST)
Date:   Mon,  5 Dec 2022 14:25:58 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205132558.63484-1-glider@google.com>
Subject: [PATCH] kmsan: fix memcpy tests
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        elver@google.com, dvyukov@google.com, linux-mm@kvack.org
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

Recent Clang changes may cause it to delete calls of memcpy(), if the
source is an uninitialized volatile local.
This happens because passing a pointer to a volatile local into memcpy()
discards the volatile qualifier, giving the compiler a free hand to
optimize the memcpy() call away.

To outsmart the compiler, we call __msan_memcpy() instead of memcpy()
in test_memcpy_aligned_to_aligned(), test_memcpy_aligned_to_unaligned()
and test_memcpy_aligned_to_unaligned2(), because it's the behavior of
__msan_memcpy() we are testing here anyway.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/kmsan_test.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 9a29ea2dbfb9b..8e4f206a900ae 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -406,6 +406,16 @@ static void test_printk(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/*
+ * The test_memcpy_xxx tests below should be calling memcpy() to copy an
+ * uninitialized value from a volatile int. But such calls discard the volatile
+ * qualifier, so Clang may optimize them away, breaking the tests.
+ * Because KMSAN instrumentation pass would just replace memcpy() with
+ * __msan_memcpy(), do that explicitly to trick the optimizer into preserving
+ * the calls.
+ */
+void *__msan_memcpy(void *, const void *, size_t);
+
 /*
  * Test case: ensure that memcpy() correctly copies uninitialized values between
  * aligned `src` and `dst`.
@@ -419,7 +429,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
-	memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
+	__msan_memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)&dst, sizeof(dst));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
@@ -441,7 +451,7 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
-	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
+	__msan_memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)dst, 4);
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
@@ -464,7 +474,7 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
-	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
+	__msan_memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

