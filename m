Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F76E721073
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFCOZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFCOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:25:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69380CA;
        Sat,  3 Jun 2023 07:25:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5147f5efeb5so4655884a12.0;
        Sat, 03 Jun 2023 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685802303; x=1688394303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D6iHadZ6aDN6ik1d8aZpgtZeGgl/psuIib2XCjLYgR0=;
        b=XhbIu/9dKocvcdYmQ5d2v+BNPlphuPAGp8b1hakt15x8t1Sep/kIwXkf/lyjrKmxAd
         WP4KXzDNGk8Hq/I6QBUi3PX4hXTN3kFNGTeFUKXh1dRfyyOc1JdU4Ukn6MBR2YVJiqhy
         jSPr9f0nRmfWd+WxyGr7hyc6Lq5oj94zb0GEBliBK9SD2hptTyK82lia6uNcc5/3ZWna
         K2EIweqILB/VMhbt2G4hoBiJlyVAMpvawTyWUX/ps8SDJurtMp00ilYn3RktmwFRUYlT
         XHbFi83eLqz1TdkwaMqkN/+a9l4/f18LB8GIhshNTX6/wY23pi1n4ixXeTt/Cz6T7Gv8
         AJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685802303; x=1688394303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6iHadZ6aDN6ik1d8aZpgtZeGgl/psuIib2XCjLYgR0=;
        b=IPUmh1dJ70/FGyQYfHPTOwEEc+bTmrTIZf+4kj1c2SodABiSYc7iKyNGT5gGr67gYu
         2WJ7VJTCnl4uFjNd6gTHterx0d3i5CqccayCDzLAXTIoP5EPX49sPkEX5dbWjvZSPNAd
         Vy5PVky3fXbhDN1VYD/Au+G1MH7/iNMEA9RQED2ff2eI4+7Ae9zHwumJIgr3PBBRqTBI
         EcIwuTQJqevk+5A0jBEEbu3r+1YRzo07zEzmc8XO0YlJzuigKOW4kK27WtHNw1qPqKIT
         DH+NhfOlQHthFcbzcASem/8G27g3j7MzSMW4vJ12QQxhLO+D8+5oC4nVEdCsWzhWhhwE
         GYUw==
X-Gm-Message-State: AC+VfDwb3TsbRozxGF6RtwKwn5ys6rBCIeZ3NM1lxj9qZr3h9NOt2Or0
        JRz7fDuQz13j3e2w5BwM6T3i0A+mJybhFA==
X-Google-Smtp-Source: ACHHUZ7B0aJtR9dcOy6MYa7n52ctqMKE8n2OoW94DiylzyVy3J/5wZzHtAwZn380eiOFqZvy+vkUXA==
X-Received: by 2002:aa7:c997:0:b0:50b:c630:a956 with SMTP id c23-20020aa7c997000000b0050bc630a956mr3986245edt.17.1685802303509;
        Sat, 03 Jun 2023 07:25:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:7ce9:cf23:e2e1:1e2e])
        by smtp.gmail.com with ESMTPSA id k6-20020a05640212c600b005149c7b1f49sm1779540edx.64.2023.06.03.07.25.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Jun 2023 07:25:03 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] crypto: Fix checkpatch issues
Date:   Sat,  3 Jun 2023 16:24:53 +0200
Message-Id: <20230603142453.92582-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto/crct10dif_common.c
- WARNING: Missing or malformed SPDX-License-Identifier tag

crypto/fcrypt.c
- WARNING: Missing or malformed SPDX-License-Identifier tag
- WARNING: Block comments use a trailing */ on a separate line

crypto/hmac.c
- WARNING: Missing a blank line after declarations

crypto/md4.c
- WARNING: Missing or malformed SPDX-License-Identifier tag
- ERROR: space required after that ',' (ctx:VxV)
- ERROR: space prohibited after that open square bracket '['
- WARNING: space prohibited between function name and open parenthesis '('
- ERROR: code indent should use tabs where possible

not fixed:
crypto/md4.c
- ERROR: space required after that ',' (ctx:VxV)
   Lines 64, 65, 66 have not been fixed due to readability

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 crypto/crct10dif_common.c |  1 +
 crypto/fcrypt.c           |  4 +++-
 crypto/hmac.c             |  1 +
 crypto/md4.c              | 11 ++++++-----
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/crypto/crct10dif_common.c b/crypto/crct10dif_common.c
index b2fab366f518..134553bf0d60 100644
--- a/crypto/crct10dif_common.c
+++ b/crypto/crct10dif_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Cryptographic API.
  *
diff --git a/crypto/fcrypt.c b/crypto/fcrypt.c
index 95a16e88899b..d81d65489c41 100644
--- a/crypto/fcrypt.c
+++ b/crypto/fcrypt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* FCrypt encryption algorithm
  *
  * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
@@ -303,7 +304,8 @@ static int fcrypt_setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int key

 #if BITS_PER_LONG == 64  /* the 64-bit version can also be used for 32-bit
 			  * kernels - it seems to be faster but the code is
-			  * larger */
+			  * larger
+			  */

 	u64 k;	/* k holds all 56 non-parity bits */

diff --git a/crypto/hmac.c b/crypto/hmac.c
index 09a7872b4060..ea93f4c55f25 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -177,6 +177,7 @@ static int hmac_clone_tfm(struct crypto_shash *dst, struct crypto_shash *src)
 static void hmac_exit_tfm(struct crypto_shash *parent)
 {
 	struct hmac_ctx *ctx = hmac_ctx(parent);
+
 	crypto_free_shash(ctx->hash);
 }

diff --git a/crypto/md4.c b/crypto/md4.c
index 2e7f2f319f95..4083698c242c 100644
--- a/crypto/md4.c
+++ b/crypto/md4.c
@@ -1,4 +1,5 @@
-/* 
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
  * Cryptographic API.
  *
  * MD4 Message Digest Algorithm (RFC1320).
@@ -90,7 +91,7 @@ static void md4_transform(u32 *hash, u32 const *in)
 	ROUND1(c, d, a, b, in[14], 11);
 	ROUND1(b, c, d, a, in[15], 19);

-	ROUND2(a, b, c, d,in[ 0], 3);
+	ROUND2(a, b, c, d, in[0], 3);
 	ROUND2(d, a, b, c, in[4], 5);
 	ROUND2(c, d, a, b, in[8], 9);
 	ROUND2(b, c, d, a, in[12], 13);
@@ -107,7 +108,7 @@ static void md4_transform(u32 *hash, u32 const *in)
 	ROUND2(c, d, a, b, in[11], 9);
 	ROUND2(b, c, d, a, in[15], 13);

-	ROUND3(a, b, c, d,in[ 0], 3);
+	ROUND3(a, b, c, d, in[0], 3);
 	ROUND3(d, a, b, c, in[8], 9);
 	ROUND3(c, d, a, b, in[4], 11);
 	ROUND3(b, c, d, a, in[12], 15);
@@ -190,7 +191,7 @@ static int md4_final(struct shash_desc *desc, u8 *out)

 	*p++ = 0x80;
 	if (padding < 0) {
-		memset(p, 0x00, padding + sizeof (u64));
+		memset(p, 0x00, padding + sizeof(u64));
 		md4_transform_helper(mctx);
 		p = (char *)mctx->block;
 		padding = 56;
@@ -200,7 +201,7 @@ static int md4_final(struct shash_desc *desc, u8 *out)
 	mctx->block[14] = mctx->byte_count << 3;
 	mctx->block[15] = mctx->byte_count >> 29;
 	le32_to_cpu_array(mctx->block, (sizeof(mctx->block) -
-	                  sizeof(u64)) / sizeof(u32));
+			  sizeof(u64)) / sizeof(u32));
 	md4_transform(mctx->hash, mctx->block);
 	cpu_to_le32_array(mctx->hash, ARRAY_SIZE(mctx->hash));
 	memcpy(out, mctx->hash, sizeof(mctx->hash));

base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
--
2.39.2 (Apple Git-143)

