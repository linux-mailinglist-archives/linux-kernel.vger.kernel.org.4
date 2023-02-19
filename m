Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A6669C1FE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 19:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjBSSv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 13:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjBSSvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 13:51:52 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9510E1449A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 10:51:49 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 31JIpijQ014625;
        Sun, 19 Feb 2023 19:51:44 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] tools/nolibc: add tests for the integer limits in stdint.h
Date:   Sun, 19 Feb 2023 19:51:33 +0100
Message-Id: <20230219185133.14576-5-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230219185133.14576-1-w@1wt.eu>
References: <20230219185133.14576-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Dagonneau <v@vda.io>

This commit adds tests for the limits added in a previous commit. The
limits are defined in decimal in stdint.h and as hexadecimal in the
tests (e.g. 0x7f = 127 or 0x80 = -128). Hopefully it catches some o the
most egregious mistakes.

Signed-off-by: Vincent Dagonneau <v@vda.io>
[wt: rely on the compiler-provided __SIZEOF_LONG__ to decide what values
 to expect, and detect its miss to avoid reporting false errors]
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 45 +++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 882140508d56..290249d6da30 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -561,7 +561,50 @@ int run_syscall(int min, int max)
 		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
-		case __LINE__:
+		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,   (int8_t)   0x7f); break;
+		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,   (int8_t)   0x80); break;
+		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,  (uint8_t)  0xff); break;
+		CASE_TEST(limit_int16_max);         EXPECT_EQ(1, INT16_MAX,  (int16_t)  0x7fff); break;
+		CASE_TEST(limit_int16_min);         EXPECT_EQ(1, INT16_MIN,  (int16_t)  0x8000); break;
+		CASE_TEST(limit_uint16_max);        EXPECT_EQ(1, UINT16_MAX, (uint16_t) 0xffff); break;
+		CASE_TEST(limit_int32_max);         EXPECT_EQ(1, INT32_MAX,  (int32_t)  0x7fffffff); break;
+		CASE_TEST(limit_int32_min);         EXPECT_EQ(1, INT32_MIN,  (int32_t)  0x80000000); break;
+		CASE_TEST(limit_uint32_max);        EXPECT_EQ(1, UINT32_MAX, (uint32_t) 0xffffffff); break;
+		CASE_TEST(limit_int64_max);         EXPECT_EQ(1, INT64_MAX,  (int64_t)  0x7fffffffffffffff); break;
+		CASE_TEST(limit_int64_min);         EXPECT_EQ(1, INT64_MIN,  (int64_t)  0x8000000000000000); break;
+		CASE_TEST(limit_uint64_max);        EXPECT_EQ(1, UINT64_MAX, (uint64_t) 0xffffffffffffffff); break;
+		CASE_TEST(limit_int_least8_max);    EXPECT_EQ(1, INT_LEAST8_MAX,   (int_least8_t)    0x7f); break;
+		CASE_TEST(limit_int_least8_min);    EXPECT_EQ(1, INT_LEAST8_MIN,   (int_least8_t)    0x80); break;
+		CASE_TEST(limit_uint_least8_max);   EXPECT_EQ(1, UINT_LEAST8_MAX,  (uint_least8_t)   0xff); break;
+		CASE_TEST(limit_int_least16_max);   EXPECT_EQ(1, INT_LEAST16_MAX,  (int_least16_t)   0x7fff); break;
+		CASE_TEST(limit_int_least16_min);   EXPECT_EQ(1, INT_LEAST16_MIN,  (int_least16_t)   0x8000); break;
+		CASE_TEST(limit_uint_least16_max);  EXPECT_EQ(1, UINT_LEAST16_MAX, (uint_least16_t)  0xffff); break;
+		CASE_TEST(limit_int_least32_max);   EXPECT_EQ(1, INT_LEAST32_MAX,  (int_least32_t)   0x7fffffff); break;
+		CASE_TEST(limit_int_least32_min);   EXPECT_EQ(1, INT_LEAST32_MIN,  (int_least32_t)   0x80000000); break;
+		CASE_TEST(limit_uint_least32_max);  EXPECT_EQ(1, UINT_LEAST32_MAX, (uint_least32_t)  0xffffffffU); break;
+#if __SIZEOF_LONG__ == 8
+		CASE_TEST(limit_int_least64_max);   EXPECT_EQ(1, INT_LEAST64_MAX,  (int_least64_t)   0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_int_least64_min);   EXPECT_EQ(1, INT_LEAST64_MIN,  (int_least64_t)   0x8000000000000000LL); break;
+		CASE_TEST(limit_uint_least64_max);  EXPECT_EQ(1, UINT_LEAST64_MAX, (uint_least64_t)  0xffffffffffffffffULL); break;
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x8000000000000000LL); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffffffffffULL); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x8000000000000000LL); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffffffffffffLL); break;
+		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffffffffffULL); break;
+#elif __SIZEOF_LONG__ == 4
+		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,  (intptr_t)  0x80000000); break;
+		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,  (intptr_t)  0x7fffffff); break;
+		CASE_TEST(limit_uintptr_max);       EXPECT_EQ(1, UINTPTR_MAX, (uintptr_t) 0xffffffffU); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
+		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, (ptrdiff_t) 0x80000000); break;
+		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, (ptrdiff_t) 0x7fffffff); break;
+		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    (size_t)    0xffffffffU); break;
+#else
+# warning "__SIZEOF_LONG__ is undefined"
+#endif /* __WORDSIZE == 64 */
+			case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
 		}
-- 
2.35.3

