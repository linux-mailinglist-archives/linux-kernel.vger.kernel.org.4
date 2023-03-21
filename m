Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6532C6C2728
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCUBP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjCUBPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D991168B0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D24E61909
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91244C433A7;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=MvoE3j0/B5YfmH7lXwF096efn6M6Cl/YT8i4+BMOerc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1sENs/XU5K5PoInjpwUdvGnbccJP1SJxh2ljIvc9WaIzL/TwtycyCHM+u0Sz3Ta2
         v8ob9PeBMXAkzafmCPp/GomAdjTS6tN3XIyIvvIGakuLrIN3pLSI1rTJy1hO0WBe4k
         Krj4ukpu3WfPj1UhhiXnaswLWxQyj2OyVjtVYNClDEGGkUPBJibL+MJ8NA3iK0WqbG
         rT2M0YhuD0lzyLSCEh536QVKueHPr2tE7QRSj7NDvfKmKPNiH5z8SJv7OHtEivveRy
         f+A2U4hVvvoWEDLx4FC/7spQz03Ih6oTv/R4U0K2nhFLXl08ik3lopmB0gvjS/AUMz
         2UBu2ejAQFtUA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E5F56154039E; Mon, 20 Mar 2023 18:11:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Vincent Dagonneau <v@vda.io>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 06/14] tools/nolibc: add tests for the integer limits in stdint.h
Date:   Mon, 20 Mar 2023 18:11:29 -0700
Message-Id: <20230321011137.51837-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Dagonneau <v@vda.io>

This commit adds tests for the limits added in a previous commit. The
limits are defined in decimal in stdint.h and as hexadecimal in the
tests (e.g. 0x7f = 127 or 0x80 = -128). Hopefully it catches some of the
most egregious mistakes.

As we rely on the compiler to provide __SIZEOF_LONG__, we also test
whether it is defined.

Signed-off-by: Vincent Dagonneau <v@vda.io>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 882140508d56..772f88bda0f1 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -602,6 +602,59 @@ int run_stdlib(int min, int max)
 		CASE_TEST(memcmp_e0_20);       EXPECT_GT(1, memcmp("aaa\xe0", "aaa\x20", 4), 0); break;
 		CASE_TEST(memcmp_80_e0);       EXPECT_LT(1, memcmp("aaa\x80", "aaa\xe0", 4), 0); break;
 		CASE_TEST(memcmp_e0_80);       EXPECT_GT(1, memcmp("aaa\xe0", "aaa\x80", 4), 0); break;
+		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,         (int8_t)          0x7f); break;
+		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,         (int8_t)          0x80); break;
+		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,        (uint8_t)         0xff); break;
+		CASE_TEST(limit_int16_max);         EXPECT_EQ(1, INT16_MAX,        (int16_t)         0x7fff); break;
+		CASE_TEST(limit_int16_min);         EXPECT_EQ(1, INT16_MIN,        (int16_t)         0x8000); break;
+		CASE_TEST(limit_uint16_max);        EXPECT_EQ(1, UINT16_MAX,       (uint16_t)        0xffff); break;
+		CASE_TEST(limit_int32_max);         EXPECT_EQ(1, INT32_MAX,        (int32_t)         0x7fffffff); break;
+		CASE_TEST(limit_int32_min);         EXPECT_EQ(1, INT32_MIN,        (int32_t)         0x80000000); break;
+		CASE_TEST(limit_uint32_max);        EXPECT_EQ(1, UINT32_MAX,       (uint32_t)        0xffffffff); break;
+		CASE_TEST(limit_int64_max);         EXPECT_EQ(1, INT64_MAX,        (int64_t)         0x7fffffffffffffff); break;
+		CASE_TEST(limit_int64_min);         EXPECT_EQ(1, INT64_MIN,        (int64_t)         0x8000000000000000); break;
+		CASE_TEST(limit_uint64_max);        EXPECT_EQ(1, UINT64_MAX,       (uint64_t)        0xffffffffffffffff); break;
+		CASE_TEST(limit_int_least8_max);    EXPECT_EQ(1, INT_LEAST8_MAX,   (int_least8_t)    0x7f); break;
+		CASE_TEST(limit_int_least8_min);    EXPECT_EQ(1, INT_LEAST8_MIN,   (int_least8_t)    0x80); break;
+		CASE_TEST(limit_uint_least8_max);   EXPECT_EQ(1, UINT_LEAST8_MAX,  (uint_least8_t)   0xff); break;
+		CASE_TEST(limit_int_least16_max);   EXPECT_EQ(1, INT_LEAST16_MAX,  (int_least16_t)   0x7fff); break;
+		CASE_TEST(limit_int_least16_min);   EXPECT_EQ(1, INT_LEAST16_MIN,  (int_least16_t)   0x8000); break;
+		CASE_TEST(limit_uint_least16_max);  EXPECT_EQ(1, UINT_LEAST16_MAX, (uint_least16_t)  0xffff); break;
+		CASE_TEST(limit_int_least32_max);   EXPECT_EQ(1, INT_LEAST32_MAX,  (int_least32_t)   0x7fffffff); break;
+		CASE_TEST(limit_int_least32_min);   EXPECT_EQ(1, INT_LEAST32_MIN,  (int_least32_t)   0x80000000); break;
+		CASE_TEST(limit_uint_least32_max);  EXPECT_EQ(1, UINT_LEAST32_MAX, (uint_least32_t)  0xffffffffU); break;
+		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000LL); break;
+		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffffULL); break;
+		CASE_TEST(limit_int_fast8_max);     EXPECT_EQ(1, INT_FAST8_MAX,    (int_fast8_t)     0x7f); break;
+		CASE_TEST(limit_int_fast8_min);     EXPECT_EQ(1, INT_FAST8_MIN,    (int_fast8_t)     0x80); break;
+		CASE_TEST(limit_uint_fast8_max);    EXPECT_EQ(1, UINT_FAST8_MAX,   (uint_fast8_t)    0xff); break;
+		CASE_TEST(limit_int_fast16_min);    EXPECT_EQ(1, INT_FAST16_MIN,   (int_fast16_t)    INTPTR_MIN); break;
+		CASE_TEST(limit_int_fast16_max);    EXPECT_EQ(1, INT_FAST16_MAX,   (int_fast16_t)    INTPTR_MAX); break;
+		CASE_TEST(limit_uint_fast16_max);   EXPECT_EQ(1, UINT_FAST16_MAX,  (uint_fast16_t)   UINTPTR_MAX); break;
+		CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,   (int_fast32_t)    INTPTR_MIN); break;
+		CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,   (int_fast32_t)    INTPTR_MAX); break;
+		CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX,  (uint_fast32_t)   UINTPTR_MAX); break;
+		CASE_TEST(limit_int_fast64_min);    EXPECT_EQ(1, INT_FAST64_MIN,   (int_fast64_t)    INTPTR_MIN); break;
+		CASE_TEST(limit_int_fast64_max);    EXPECT_EQ(1, INT_FAST64_MAX,   (int_fast64_t)    INTPTR_MAX); break;
+		CASE_TEST(limit_uint_fast64_max);   EXPECT_EQ(1, UINT_FAST64_MAX,  (uint_fast64_t)   UINTPTR_MAX); break;
+#if __SIZEOF_LONG__ == 8
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,       (intptr_t)        0x8000000000000000LL); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,       (intptr_t)        0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX,      (uintptr_t)       0xffffffffffffffffULL); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN,      (ptrdiff_t)       0x8000000000000000LL); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX,      (ptrdiff_t)       0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,         (size_t)          0xffffffffffffffffULL); break;
+#elif __SIZEOF_LONG__ == 4
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,       (intptr_t)        0x80000000); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,       (intptr_t)        0x7fffffff); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX,      (uintptr_t)       0xffffffffU); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN,      (ptrdiff_t)       0x80000000); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX,      (ptrdiff_t)       0x7fffffff); break;
+		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,         (size_t)          0xffffffffU); break;
+#else
+# warning "__SIZEOF_LONG__ is undefined"
+#endif /* __SIZEOF_LONG__ */
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.40.0.rc2

