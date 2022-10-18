Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F760253B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJRHLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJRHK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:10:56 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6B3120B;
        Tue, 18 Oct 2022 00:10:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VSTWsk._1666077024;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VSTWsk._1666077024)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 15:10:25 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v2 07/15] crypto: arm64/sm4 - simplify sm4_ce_expand_key() of CE implementation
Date:   Tue, 18 Oct 2022 15:09:58 +0800
Message-Id: <20221018071006.5717-8-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221018071006.5717-1-tianjia.zhang@linux.alibaba.com>
References: <20221018071006.5717-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a 128-bit swap mask and tbl instruction to simplify the implementation
for generating SM4 rkey_dec.

Also fixed the issue of not being wrapped by kernel_neon_begin/end() when
using the sm4_ce_expand_key() function.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/sm4-ce-core.S | 46 ++++++++++++++++-----------------
 arch/arm64/crypto/sm4-ce-glue.c |  2 ++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/crypto/sm4-ce-core.S b/arch/arm64/crypto/sm4-ce-core.S
index 41fc745a8528..9e4b4f01cdf3 100644
--- a/arch/arm64/crypto/sm4-ce-core.S
+++ b/arch/arm64/crypto/sm4-ce-core.S
@@ -65,32 +65,23 @@ SYM_FUNC_START(sm4_ce_expand_key)
 	sm4ekey		v6.4s, v5.4s, v30.4s;
 	sm4ekey		v7.4s, v6.4s, v31.4s;
 
+	adr_l		x5, .Lbswap128_mask
+	ld1		{v24.16b}, [x5]
+
 	st1		{v0.16b-v3.16b}, [x1], #64;
 	st1		{v4.16b-v7.16b}, [x1];
-	rev64		v7.4s, v7.4s;
-	rev64		v6.4s, v6.4s;
-	rev64		v5.4s, v5.4s;
-	rev64		v4.4s, v4.4s;
-	rev64		v3.4s, v3.4s;
-	rev64		v2.4s, v2.4s;
-	rev64		v1.4s, v1.4s;
-	rev64		v0.4s, v0.4s;
-	ext		v7.16b, v7.16b, v7.16b, #8;
-	ext		v6.16b, v6.16b, v6.16b, #8;
-	ext		v5.16b, v5.16b, v5.16b, #8;
-	ext		v4.16b, v4.16b, v4.16b, #8;
-	ext		v3.16b, v3.16b, v3.16b, #8;
-	ext		v2.16b, v2.16b, v2.16b, #8;
-	ext		v1.16b, v1.16b, v1.16b, #8;
-	ext		v0.16b, v0.16b, v0.16b, #8;
-	st1		{v7.16b}, [x2], #16;
-	st1		{v6.16b}, [x2], #16;
-	st1		{v5.16b}, [x2], #16;
-	st1		{v4.16b}, [x2], #16;
-	st1		{v3.16b}, [x2], #16;
-	st1		{v2.16b}, [x2], #16;
-	st1		{v1.16b}, [x2], #16;
-	st1		{v0.16b}, [x2];
+
+	tbl		v16.16b, {v7.16b}, v24.16b
+	tbl		v17.16b, {v6.16b}, v24.16b
+	tbl		v18.16b, {v5.16b}, v24.16b
+	tbl		v19.16b, {v4.16b}, v24.16b
+	tbl		v20.16b, {v3.16b}, v24.16b
+	tbl		v21.16b, {v2.16b}, v24.16b
+	tbl		v22.16b, {v1.16b}, v24.16b
+	tbl		v23.16b, {v0.16b}, v24.16b
+
+	st1		{v16.16b-v19.16b}, [x2], #64
+	st1		{v20.16b-v23.16b}, [x2]
 
 	ret;
 SYM_FUNC_END(sm4_ce_expand_key)
@@ -578,3 +569,10 @@ SYM_FUNC_START(sm4_ce_ctr_enc)
 
 	ret
 SYM_FUNC_END(sm4_ce_ctr_enc)
+
+
+	.section	".rodata", "a"
+	.align 4
+.Lbswap128_mask:
+	.byte		0x0c, 0x0d, 0x0e, 0x0f, 0x08, 0x09, 0x0a, 0x0b
+	.byte		0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03
diff --git a/arch/arm64/crypto/sm4-ce-glue.c b/arch/arm64/crypto/sm4-ce-glue.c
index e56e81b1f35f..ff2d8442d473 100644
--- a/arch/arm64/crypto/sm4-ce-glue.c
+++ b/arch/arm64/crypto/sm4-ce-glue.c
@@ -44,8 +44,10 @@ static int sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	if (key_len != SM4_KEY_SIZE)
 		return -EINVAL;
 
+	kernel_neon_begin();
 	sm4_ce_expand_key(key, ctx->rkey_enc, ctx->rkey_dec,
 			  crypto_sm4_fk, crypto_sm4_ck);
+	kernel_neon_end();
 	return 0;
 }
 
-- 
2.24.3 (Apple Git-128)

