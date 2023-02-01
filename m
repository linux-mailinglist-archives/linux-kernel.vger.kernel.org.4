Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4A36865F3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjBAMcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBAMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:32:15 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD423662;
        Wed,  1 Feb 2023 04:32:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vagxb9L_1675254728;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Vagxb9L_1675254728)
          by smtp.aliyun-inc.com;
          Wed, 01 Feb 2023 20:32:08 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] crypto: arm64/sm4-ccm - Rewrite skcipher walker loop
Date:   Wed,  1 Feb 2023 20:32:07 +0800
Message-Id: <20230201123207.99858-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fact that an error in the skcipher walker API are indicated
not only by a non-zero return value, but also by the fact that
walk->nbytes is zero, causes the layout of the skcipher walker
loop to be sufficiently different from the usual layout, which
is not a problem in itself, but it is likely to cause reading
confusion and difficulty in code maintenance.

This patch rewrites skcipher walker loop, and separates the
last chunk cryption from the loop to avoid wrong calls to the
skcipher walker API. In addition to following the usual convention
of checking walk->nbytes, it also makes the loop execute logic
clearer and easier to understand.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/sm4-ce-ccm-glue.c | 44 ++++++++++++++++-------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/crypto/sm4-ce-ccm-glue.c b/arch/arm64/crypto/sm4-ce-ccm-glue.c
index f2cec7b52efc..5e7e17bbec81 100644
--- a/arch/arm64/crypto/sm4-ce-ccm-glue.c
+++ b/arch/arm64/crypto/sm4-ce-ccm-glue.c
@@ -166,7 +166,7 @@ static int ccm_crypt(struct aead_request *req, struct skcipher_walk *walk,
 					unsigned int nbytes, u8 *mac))
 {
 	u8 __aligned(8) ctr0[SM4_BLOCK_SIZE];
-	int err;
+	int err = 0;
 
 	/* preserve the initial ctr0 for the TAG */
 	memcpy(ctr0, walk->iv, SM4_BLOCK_SIZE);
@@ -177,33 +177,37 @@ static int ccm_crypt(struct aead_request *req, struct skcipher_walk *walk,
 	if (req->assoclen)
 		ccm_calculate_auth_mac(req, mac);
 
-	do {
+	while (walk->nbytes && walk->nbytes != walk->total) {
 		unsigned int tail = walk->nbytes % SM4_BLOCK_SIZE;
-		const u8 *src = walk->src.virt.addr;
-		u8 *dst = walk->dst.virt.addr;
 
-		if (walk->nbytes == walk->total)
-			tail = 0;
+		sm4_ce_ccm_crypt(rkey_enc, walk->dst.virt.addr,
+				 walk->src.virt.addr, walk->iv,
+				 walk->nbytes - tail, mac);
+
+		kernel_neon_end();
+
+		err = skcipher_walk_done(walk, tail);
+
+		kernel_neon_begin();
+	}
 
-		if (walk->nbytes - tail)
-			sm4_ce_ccm_crypt(rkey_enc, dst, src, walk->iv,
-					 walk->nbytes - tail, mac);
+	if (walk->nbytes) {
+		sm4_ce_ccm_crypt(rkey_enc, walk->dst.virt.addr,
+				 walk->src.virt.addr, walk->iv,
+				 walk->nbytes, mac);
 
-		if (walk->nbytes == walk->total)
-			sm4_ce_ccm_final(rkey_enc, ctr0, mac);
+		sm4_ce_ccm_final(rkey_enc, ctr0, mac);
 
 		kernel_neon_end();
 
-		if (walk->nbytes) {
-			err = skcipher_walk_done(walk, tail);
-			if (err)
-				return err;
-			if (walk->nbytes)
-				kernel_neon_begin();
-		}
-	} while (walk->nbytes > 0);
+		err = skcipher_walk_done(walk, 0);
+	} else {
+		sm4_ce_ccm_final(rkey_enc, ctr0, mac);
 
-	return 0;
+		kernel_neon_end();
+	}
+
+	return err;
 }
 
 static int ccm_encrypt(struct aead_request *req)
-- 
2.24.3 (Apple Git-128)

