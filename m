Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CEE72D114
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbjFLUul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbjFLUrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7261E173F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB39362F1A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E32C4332C;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=cIY3z+FHEm5CXeXJFEW47PhAl46oQsi60a/jd0EmyWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdDvE1MHbzjwsOvF9ffDd4djh30bJj4Nt1XVHwaApJzI3jj+u1EVHFDuxPTG5uDgz
         42XXJFBqWA54x7GAP8pY31gUSUqGC2ZQLz46cJDfj5RlcJQomu8jYwnBaDBkq/LIlz
         uvQH3GUYCNVZ3EVJyioBColBqkRw0xA6UVE5VvZbZ6NWfoFpTuogithxrcS7LfCM3K
         OL9zZ95/NdEyLwZ8M0X9yweu5IE8uP0WzsECGjgljxnkWOXLVKrMIllOYS5Rdt01ZY
         3EAuI1Zk2numgEWMiZBqwLq/4MHgA0+4IFcV1NEyaN3gBjSM0bnhQkeGLnTztSLyVz
         5pkzeqdqYAOOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 12608CE3A86; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 41/53] tools/nolibc: ensure fast64 integer types have 64 bits
Date:   Mon, 12 Jun 2023 13:45:02 -0700
Message-Id: <20230612204514.292087-41-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

On 32bit platforms size_t is not enough to represent [u]int_fast64_t.

Fixes: 3e9fd4e9a1d5 ("tools/nolibc: add integer types and integer limit macros")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdint.h                | 10 +++++-----
 tools/testing/selftests/nolibc/nolibc-test.c |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index c1ce4f5e0603..661d942862c0 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -36,8 +36,8 @@ typedef  ssize_t       int_fast16_t;
 typedef   size_t      uint_fast16_t;
 typedef  ssize_t       int_fast32_t;
 typedef   size_t      uint_fast32_t;
-typedef  ssize_t       int_fast64_t;
-typedef   size_t      uint_fast64_t;
+typedef  int64_t       int_fast64_t;
+typedef uint64_t      uint_fast64_t;
 
 typedef  int64_t           intmax_t;
 typedef uint64_t          uintmax_t;
@@ -84,16 +84,16 @@ typedef uint64_t          uintmax_t;
 #define  INT_FAST8_MIN   INT8_MIN
 #define INT_FAST16_MIN   INTPTR_MIN
 #define INT_FAST32_MIN   INTPTR_MIN
-#define INT_FAST64_MIN   INTPTR_MIN
+#define INT_FAST64_MIN   INT64_MIN
 
 #define  INT_FAST8_MAX   INT8_MAX
 #define INT_FAST16_MAX   INTPTR_MAX
 #define INT_FAST32_MAX   INTPTR_MAX
-#define INT_FAST64_MAX   INTPTR_MAX
+#define INT_FAST64_MAX   INT64_MAX
 
 #define  UINT_FAST8_MAX  UINT8_MAX
 #define UINT_FAST16_MAX  SIZE_MAX
 #define UINT_FAST32_MAX  SIZE_MAX
-#define UINT_FAST64_MAX  SIZE_MAX
+#define UINT_FAST64_MAX  UINT64_MAX
 
 #endif /* _NOLIBC_STDINT_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index fa18e7dc35c8..bfcbc05e6b5b 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -702,9 +702,9 @@ int run_stdlib(int min, int max)
 		CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,   (int_fast32_t)    INTPTR_MIN); break;
 		CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,   (int_fast32_t)    INTPTR_MAX); break;
 		CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX,  (uint_fast32_t)   UINTPTR_MAX); break;
-		CASE_TEST(limit_int_fast64_min);    EXPECT_EQ(1, INT_FAST64_MIN,   (int_fast64_t)    INTPTR_MIN); break;
-		CASE_TEST(limit_int_fast64_max);    EXPECT_EQ(1, INT_FAST64_MAX,   (int_fast64_t)    INTPTR_MAX); break;
-		CASE_TEST(limit_uint_fast64_max);   EXPECT_EQ(1, UINT_FAST64_MAX,  (uint_fast64_t)   UINTPTR_MAX); break;
+		CASE_TEST(limit_int_fast64_min);    EXPECT_EQ(1, INT_FAST64_MIN,   (int_fast64_t)    INT64_MIN); break;
+		CASE_TEST(limit_int_fast64_max);    EXPECT_EQ(1, INT_FAST64_MAX,   (int_fast64_t)    INT64_MAX); break;
+		CASE_TEST(limit_uint_fast64_max);   EXPECT_EQ(1, UINT_FAST64_MAX,  (uint_fast64_t)   UINT64_MAX); break;
 #if __SIZEOF_LONG__ == 8
 		CASE_TEST(limit_intptr_min);        EXPECT_EQ(1, INTPTR_MIN,       (intptr_t)        0x8000000000000000LL); break;
 		CASE_TEST(limit_intptr_max);        EXPECT_EQ(1, INTPTR_MAX,       (intptr_t)        0x7fffffffffffffffLL); break;
-- 
2.40.1

