Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96B96865F1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjBAMbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBAMbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:31:40 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5C485A8;
        Wed,  1 Feb 2023 04:31:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VagnY4o_1675254694;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VagnY4o_1675254694)
          by smtp.aliyun-inc.com;
          Wed, 01 Feb 2023 20:31:35 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v3] crypto: arm64/sm4-gcm - Fix possible crash in GCM cryption
Date:   Wed,  1 Feb 2023 20:31:33 +0800
Message-Id: <20230201123133.99768-1-tianjia.zhang@linux.alibaba.com>
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

When the cryption total length is zero, GCM cryption call
skcipher_walk_done() will cause an unexpected crash, so skip calling
this function to avoid possible crash when the GCM cryption length
is equal to zero.

This patch also rewrite the skcipher walker loop, and separates the
cryption of the last chunk from the walker loop. In addition to
following the usual convention of checking walk->nbytes, it also makes
the execution logic of the loop clearer and easier to understand.

Fixes: ae1b83c7d572 ("crypto: arm64/sm4 - add CE implementation for GCM mode")
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/sm4-ce-gcm-glue.c | 43 ++++++++++++++---------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/crypto/sm4-ce-gcm-glue.c b/arch/arm64/crypto/sm4-ce-gcm-glue.c
index c450a2025ca9..80ac4e94a90d 100644
--- a/arch/arm64/crypto/sm4-ce-gcm-glue.c
+++ b/arch/arm64/crypto/sm4-ce-gcm-glue.c
@@ -143,7 +143,7 @@ static int gcm_crypt(struct aead_request *req, struct skcipher_walk *walk,
 {
 	u8 __aligned(8) iv[SM4_BLOCK_SIZE];
 	be128 __aligned(8) lengths;
-	int err;
+	int err = 0;
 
 	memset(ghash, 0, SM4_BLOCK_SIZE);
 
@@ -158,34 +158,31 @@ static int gcm_crypt(struct aead_request *req, struct skcipher_walk *walk,
 	if (req->assoclen)
 		gcm_calculate_auth_mac(req, ghash);
 
-	do {
+	while (walk->nbytes && walk->nbytes != walk->total) {
 		unsigned int tail = walk->nbytes % SM4_BLOCK_SIZE;
-		const u8 *src = walk->src.virt.addr;
-		u8 *dst = walk->dst.virt.addr;
-
-		if (walk->nbytes == walk->total) {
-			tail = 0;
-
-			sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
-					       walk->nbytes, ghash,
-					       ctx->ghash_table,
-					       (const u8 *)&lengths);
-		} else if (walk->nbytes - tail) {
-			sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
-					       walk->nbytes - tail, ghash,
-					       ctx->ghash_table, NULL);
-		}
+
+		sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, walk->dst.virt.addr,
+				       walk->src.virt.addr, iv,
+				       walk->nbytes - tail, ghash,
+				       ctx->ghash_table, NULL);
 
 		kernel_neon_end();
 
 		err = skcipher_walk_done(walk, tail);
-		if (err)
-			return err;
-		if (walk->nbytes)
-			kernel_neon_begin();
-	} while (walk->nbytes > 0);
 
-	return 0;
+		kernel_neon_begin();
+	}
+
+	sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, walk->dst.virt.addr,
+			       walk->src.virt.addr, iv, walk->nbytes, ghash,
+			       ctx->ghash_table, (const u8 *)&lengths);
+
+	kernel_neon_end();
+
+	if (walk->nbytes)
+		err = skcipher_walk_done(walk, 0);
+
+	return err;
 }
 
 static int gcm_encrypt(struct aead_request *req)
-- 
2.24.3 (Apple Git-128)

