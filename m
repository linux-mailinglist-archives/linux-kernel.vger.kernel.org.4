Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F546AAA65
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCDO0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCDO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:26:36 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 967551D90B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:26:33 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 324EQHRI006044;
        Sat, 4 Mar 2023 15:26:17 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     paulmck@kernel.org
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Vincent Dagonneau <v@vda.io>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3/4] tools/nolibc: enlarge column width of tests
Date:   Sat,  4 Mar 2023 15:26:05 +0100
Message-Id: <20230304142606.5995-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230304142606.5995-1-w@1wt.eu>
References: <20230304142606.5995-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Dagonneau <v@vda.io>

This commit enlarges the column width from 40 to 64 characters to make
room for longer tests

Signed-off-by: Vincent Dagonneau <v@vda.io>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 96 ++++++++++----------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index c4a0c915139c..882140508d56 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -130,111 +130,111 @@ static int pad_spc(int llen, int cnt, const char *fmt, ...)
  */
 
 #define EXPECT_ZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_zr(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_zr(expr, llen); } while (0)
 
 static int expect_zr(int expr, int llen)
 {
 	int ret = !(expr == 0);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_NZ(cond, expr, val)			\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_nz(expr, llen; } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_nz(expr, llen; } while (0)
 
 static int expect_nz(int expr, int llen)
 {
 	int ret = !(expr != 0);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_EQ(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_eq(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_eq(expr, llen, val); } while (0)
 
-static int expect_eq(int expr, int llen, int val)
+static int expect_eq(uint64_t expr, int llen, uint64_t val)
 {
 	int ret = !(expr == val);
 
-	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	llen += printf(" = %lld ", expr);
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_NE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ne(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ne(expr, llen, val); } while (0)
 
 static int expect_ne(int expr, int llen, int val)
 {
 	int ret = !(expr != val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_GE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ge(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ge(expr, llen, val); } while (0)
 
 static int expect_ge(int expr, int llen, int val)
 {
 	int ret = !(expr >= val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_GT(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_gt(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_gt(expr, llen, val); } while (0)
 
 static int expect_gt(int expr, int llen, int val)
 {
 	int ret = !(expr > val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_LE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_le(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_le(expr, llen, val); } while (0)
 
 static int expect_le(int expr, int llen, int val)
 {
 	int ret = !(expr <= val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_LT(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_lt(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_lt(expr, llen, val); } while (0)
 
 static int expect_lt(int expr, int llen, int val)
 {
 	int ret = !(expr < val);
 
 	llen += printf(" = %d ", expr);
-	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
 
 
 #define EXPECT_SYSZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syszr(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syszr(expr, llen); } while (0)
 
 static int expect_syszr(int expr, int llen)
 {
@@ -243,17 +243,17 @@ static int expect_syszr(int expr, int llen)
 	if (expr) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
 		llen += printf(" = %d ", expr);
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_SYSEQ(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syseq(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syseq(expr, llen, val); } while (0)
 
 static int expect_syseq(int expr, int llen, int val)
 {
@@ -262,17 +262,17 @@ static int expect_syseq(int expr, int llen, int val)
 	if (expr != val) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
 		llen += printf(" = %d ", expr);
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_SYSNE(cond, expr, val)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_sysne(expr, llen, val); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_sysne(expr, llen, val); } while (0)
 
 static int expect_sysne(int expr, int llen, int val)
 {
@@ -281,17 +281,17 @@ static int expect_sysne(int expr, int llen, int val)
 	if (expr == val) {
 		ret = 1;
 		llen += printf(" = %d %s ", expr, errorname(errno));
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
 		llen += printf(" = %d ", expr);
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_SYSER(cond, expr, expret, experr)			\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syserr(expr, expret, experr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr(expr, expret, experr, llen); } while (0)
 
 static int expect_syserr(int expr, int expret, int experr, int llen)
 {
@@ -302,16 +302,16 @@ static int expect_syserr(int expr, int expret, int experr, int llen)
 	if (expr != expret || _errno != experr) {
 		ret = 1;
 		llen += printf(" != (%d %s) ", expret, errorname(experr));
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_PTRZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ptrzr(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrzr(expr, llen); } while (0)
 
 static int expect_ptrzr(const void *expr, int llen)
 {
@@ -320,16 +320,16 @@ static int expect_ptrzr(const void *expr, int llen)
 	llen += printf(" = <%p> ", expr);
 	if (expr) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_PTRNZ(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ptrnz(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrnz(expr, llen); } while (0)
 
 static int expect_ptrnz(const void *expr, int llen)
 {
@@ -338,16 +338,16 @@ static int expect_ptrnz(const void *expr, int llen)
 	llen += printf(" = <%p> ", expr);
 	if (!expr) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_STRZR(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strzr(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strzr(expr, llen); } while (0)
 
 static int expect_strzr(const char *expr, int llen)
 {
@@ -356,16 +356,16 @@ static int expect_strzr(const char *expr, int llen)
 	llen += printf(" = <%s> ", expr);
 	if (expr) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_STRNZ(cond, expr)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strnz(expr, llen); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strnz(expr, llen); } while (0)
 
 static int expect_strnz(const char *expr, int llen)
 {
@@ -374,16 +374,16 @@ static int expect_strnz(const char *expr, int llen)
 	llen += printf(" = <%s> ", expr);
 	if (!expr) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_STREQ(cond, expr, cmp)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_streq(expr, llen, cmp); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_streq(expr, llen, cmp); } while (0)
 
 static int expect_streq(const char *expr, int llen, const char *cmp)
 {
@@ -392,16 +392,16 @@ static int expect_streq(const char *expr, int llen, const char *cmp)
 	llen += printf(" = <%s> ", expr);
 	if (strcmp(expr, cmp) != 0) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
 
 
 #define EXPECT_STRNE(cond, expr, cmp)				\
-	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strne(expr, llen, cmp); } while (0)
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strne(expr, llen, cmp); } while (0)
 
 static int expect_strne(const char *expr, int llen, const char *cmp)
 {
@@ -410,9 +410,9 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 	llen += printf(" = <%s> ", expr);
 	if (strcmp(expr, cmp) == 0) {
 		ret = 1;
-		llen += pad_spc(llen, 40, "[FAIL]\n");
+		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
-		llen += pad_spc(llen, 40, " [OK]\n");
+		llen += pad_spc(llen, 64, " [OK]\n");
 	}
 	return ret;
 }
-- 
2.17.5

