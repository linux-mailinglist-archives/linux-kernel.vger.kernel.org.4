Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53E7240CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjFFL0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjFFL0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:26:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7801DB1;
        Tue,  6 Jun 2023 04:26:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149e65c244so7971387a12.3;
        Tue, 06 Jun 2023 04:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686050774; x=1688642774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N57YwN7rPTXM6PkBvvoB5W0i3HaQ6VMgYMDO8t6NAOY=;
        b=lII/s1i25JN8NNO5JOsyfinUZKlHjPRj3AKlgVmWIfuRFHq4t+n6WdgGymTqtG9n85
         q7rFA9KBdVau3yV6fRkN2mHznLIkI894/5J/rOovV9QOypwcwKImiD44EES/1YJTdyNw
         S3kbxD9hHrHPUHuP+Y+Dvyf8bzEJcxXBaSkWw33AAN9kH+3vH0QG4VoYTxKfZqi+xE1s
         +a4hzbMee8zBbDft5xl0RfZuw838RZm/pnnnByBeV7sC7cjxsB6t0zFDFnAggY/s+Kz5
         SlHQJcR7cOjKwoIBePRWbOGqGMS+TK5XfYO8aCewcGtHLh8o/6HmR/fpE2gPzOaInYqn
         EmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686050774; x=1688642774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N57YwN7rPTXM6PkBvvoB5W0i3HaQ6VMgYMDO8t6NAOY=;
        b=TFPT9WTB8yHkd26uN5WotJkCweulu0A/afmxP9rnfEw0whokIHFAdcYKQ63M7xeO4E
         Tr0xkCSYuUicrKhkFuJ/V4TxcPYANdWioV5wivmG4l0+JFTzuheBVW2mQuILe1nQcs9G
         bMxChP5Aam1w9TSNamQ/s8Y3HnWdqeTOWH0KsdALFQbm2yW/HlzY4C4nUUabsHd1K5a+
         NdIhsspYj23YX3XMP1ZxYm1HQMBe/nMZz8yI6yS87fvHO5d/Nxx9lx0SE2lJxwP85hG4
         0fwTrpiuKMHMwhBxLYPkc75dADPLJ+5OZKQkAvbgm+9JMkqe5n4NIQWepaO5/yxbBi0z
         pkWA==
X-Gm-Message-State: AC+VfDzhGGOS8ghQUPeFSLGxyMYQryF0QUzXn0DpPEJ7lAXk6dnxLWbS
        r0RtQTkCLhyYH/ZvgNmVHM1pf6NPvcg6fA==
X-Google-Smtp-Source: ACHHUZ5v4K/Rcm9Y1TzUQlbuN0RZNq07TQ/V5uUdr9bTrpOcUKSIOQnzOZh5APa/Cc/tVuRP+XQi2w==
X-Received: by 2002:a17:907:9814:b0:974:6335:4239 with SMTP id ji20-20020a170907981400b0097463354239mr2178575ejc.34.1686050774633;
        Tue, 06 Jun 2023 04:26:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:7ce9:cf23:e2e1:1e2e])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090636cd00b00977eec5bb2csm1562676ejc.156.2023.06.06.04.26.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Jun 2023 04:26:14 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] crypto: md4: Fix checkpatch issues
Date:   Tue,  6 Jun 2023 13:26:10 +0200
Message-Id: <20230606112610.98149-1-franziska.naepelt@gmail.com>
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

The following checkpatch issues have been fixed:
- WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
- ERROR: space required after that ',' (ctx:VxV)
- ERROR: space prohibited after that open square bracket '['
- WARNING: space prohibited between function name and open parenthesis '('
- ERROR: code indent should use tabs where possible

not fixed:
- ERROR: space required after that ',' (ctx:VxV)
in lines: 64, 65, 66 have not ben fixed due to readability

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 crypto/md4.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

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

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
--
2.39.2 (Apple Git-143)

