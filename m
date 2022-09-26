Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208075E9DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiIZJiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiIZJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:37:02 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD2E2251E;
        Mon, 26 Sep 2022 02:36:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VQkJzGX_1664185001;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQkJzGX_1664185001)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 17:36:42 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 09/16] crypto: arm64/sm4 - add CE implementation for CTS-CBC mode
Date:   Mon, 26 Sep 2022 17:36:13 +0800
Message-Id: <20220926093620.99898-10-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
References: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a CE-optimized assembly implementation for CTS-CBC mode.

Benchmark on T-Head Yitian-710 2.75 GHz, the data comes from the 218 mode of
tcrypt, and compared the performance before and after this patch (the driver
used before this patch is cts(cbc-sm4-ce)). The abscissas are blocks of
different lengths. The data is tabulated and the unit is Mb/s:

Before:

cts(cbc-sm4-ce) |      16       64      128      256     1024     1420     4096
----------------+--------------------------------------------------------------
    CTS-CBC enc |  286.09   297.17   457.97   627.75   868.58   900.80   957.69
    CTS-CBC dec |  286.67   285.63   538.35   947.08  2241.03  2577.32  3391.14

After:

cts-cbc-sm4-ce  |      16       64      128      256     1024     1420     4096
----------------+--------------------------------------------------------------
    CTS-CBC enc |  288.19   428.80   593.57   741.04   911.73   931.80   950.00
    CTS-CBC dec |  292.22   468.99   838.23  1380.76  2741.17  3036.42  3409.62

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/sm4-ce-core.S | 102 ++++++++++++++++++++++++++++++++
 arch/arm64/crypto/sm4-ce-glue.c |  94 +++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+)

diff --git a/arch/arm64/crypto/sm4-ce-core.S b/arch/arm64/crypto/sm4-ce-core.S
index 9e4b4f01cdf3..414d29f8110b 100644
--- a/arch/arm64/crypto/sm4-ce-core.S
+++ b/arch/arm64/crypto/sm4-ce-core.S
@@ -306,6 +306,100 @@ SYM_FUNC_START(sm4_ce_cbc_dec)
 	ret
 SYM_FUNC_END(sm4_ce_cbc_dec)
 
+.align 3
+SYM_FUNC_START(sm4_ce_cbc_cts_enc)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: iv (big endian, 128 bit)
+	 *   w4: nbytes
+	 */
+	SM4_PREPARE(x0)
+
+	sub		w5, w4, #16
+	uxtw		x5, w5
+
+	ld1		{RIV.16b}, [x3]
+
+	ld1		{v0.16b}, [x2]
+	eor		RIV.16b, RIV.16b, v0.16b
+	SM4_CRYPT_BLK(RIV)
+
+	/* load permute table */
+	adr_l		x6, .Lcts_permute_table
+	add		x7, x6, #32
+	add		x6, x6, x5
+	sub		x7, x7, x5
+	ld1		{v3.16b}, [x6]
+	ld1		{v4.16b}, [x7]
+
+	/* overlapping loads */
+	add		x2, x2, x5
+	ld1		{v1.16b}, [x2]
+
+	/* create Cn from En-1 */
+	tbl		v0.16b, {RIV.16b}, v3.16b
+	/* padding Pn with zeros */
+	tbl		v1.16b, {v1.16b}, v4.16b
+
+	eor		v1.16b, v1.16b, RIV.16b
+	SM4_CRYPT_BLK(v1)
+
+	/* overlapping stores */
+	add		x5, x1, x5
+	st1		{v0.16b}, [x5]
+	st1		{v1.16b}, [x1]
+
+	ret
+SYM_FUNC_END(sm4_ce_cbc_cts_enc)
+
+.align 3
+SYM_FUNC_START(sm4_ce_cbc_cts_dec)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: iv (big endian, 128 bit)
+	 *   w4: nbytes
+	 */
+	SM4_PREPARE(x0)
+
+	sub		w5, w4, #16
+	uxtw		x5, w5
+
+	ld1		{RIV.16b}, [x3]
+
+	/* load permute table */
+	adr_l		x6, .Lcts_permute_table
+	add		x7, x6, #32
+	add		x6, x6, x5
+	sub		x7, x7, x5
+	ld1		{v3.16b}, [x6]
+	ld1		{v4.16b}, [x7]
+
+	/* overlapping loads */
+	ld1		{v0.16b}, [x2], x5
+	ld1		{v1.16b}, [x2]
+
+	SM4_CRYPT_BLK(v0)
+	/* select the first Ln bytes of Xn to create Pn */
+	tbl		v2.16b, {v0.16b}, v3.16b
+	eor		v2.16b, v2.16b, v1.16b
+
+	/* overwrite the first Ln bytes with Cn to create En-1 */
+	tbx		v0.16b, {v1.16b}, v4.16b
+	SM4_CRYPT_BLK(v0)
+	eor		v0.16b, v0.16b, RIV.16b
+
+	/* overlapping stores */
+	add		x5, x1, x5
+	st1		{v2.16b}, [x5]
+	st1		{v0.16b}, [x1]
+
+	ret
+SYM_FUNC_END(sm4_ce_cbc_cts_dec)
+
 .align 3
 SYM_FUNC_START(sm4_ce_cfb_enc)
 	/* input:
@@ -576,3 +670,11 @@ SYM_FUNC_END(sm4_ce_ctr_enc)
 .Lbswap128_mask:
 	.byte		0x0c, 0x0d, 0x0e, 0x0f, 0x08, 0x09, 0x0a, 0x0b
 	.byte		0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03
+
+.Lcts_permute_table:
+	.byte		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	.byte		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	.byte		 0x0,  0x1,  0x2,  0x3,  0x4,  0x5,  0x6,  0x7
+	.byte		 0x8,  0x9,  0xa,  0xb,  0xc,  0xd,  0xe,  0xf
+	.byte		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	.byte		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
diff --git a/arch/arm64/crypto/sm4-ce-glue.c b/arch/arm64/crypto/sm4-ce-glue.c
index 63abcadc684b..4d4072c7bfa2 100644
--- a/arch/arm64/crypto/sm4-ce-glue.c
+++ b/arch/arm64/crypto/sm4-ce-glue.c
@@ -16,6 +16,7 @@
 #include <asm/simd.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
 #include <crypto/sm4.h>
 
 #define BYTES2BLKS(nbytes)	((nbytes) >> 4)
@@ -29,6 +30,10 @@ asmlinkage void sm4_ce_cbc_enc(const u32 *rkey, u8 *dst, const u8 *src,
 			       u8 *iv, unsigned int nblocks);
 asmlinkage void sm4_ce_cbc_dec(const u32 *rkey, u8 *dst, const u8 *src,
 			       u8 *iv, unsigned int nblocks);
+asmlinkage void sm4_ce_cbc_cts_enc(const u32 *rkey, u8 *dst, const u8 *src,
+				   u8 *iv, unsigned int nbytes);
+asmlinkage void sm4_ce_cbc_cts_dec(const u32 *rkey, u8 *dst, const u8 *src,
+				   u8 *iv, unsigned int nbytes);
 asmlinkage void sm4_ce_cfb_enc(const u32 *rkey, u8 *dst, const u8 *src,
 			       u8 *iv, unsigned int nblks);
 asmlinkage void sm4_ce_cfb_dec(const u32 *rkey, u8 *dst, const u8 *src,
@@ -153,6 +158,78 @@ static int sm4_cbc_decrypt(struct skcipher_request *req)
 	return sm4_cbc_crypt(req, ctx, false);
 }
 
+static int sm4_cbc_cts_crypt(struct skcipher_request *req, bool encrypt)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct scatterlist *src = req->src;
+	struct scatterlist *dst = req->dst;
+	struct scatterlist sg_src[2], sg_dst[2];
+	struct skcipher_request subreq;
+	struct skcipher_walk walk;
+	int cbc_blocks;
+	int err;
+
+	if (req->cryptlen < SM4_BLOCK_SIZE)
+		return -EINVAL;
+
+	if (req->cryptlen == SM4_BLOCK_SIZE)
+		return sm4_cbc_crypt(req, ctx, encrypt);
+
+	skcipher_request_set_tfm(&subreq, tfm);
+	skcipher_request_set_callback(&subreq, skcipher_request_flags(req),
+				      NULL, NULL);
+
+	/* handle the CBC cryption part */
+	cbc_blocks = DIV_ROUND_UP(req->cryptlen, SM4_BLOCK_SIZE) - 2;
+	if (cbc_blocks) {
+		skcipher_request_set_crypt(&subreq, src, dst,
+					   cbc_blocks * SM4_BLOCK_SIZE,
+					   req->iv);
+
+		err = sm4_cbc_crypt(&subreq, ctx, encrypt);
+		if (err)
+			return err;
+
+		dst = src = scatterwalk_ffwd(sg_src, src, subreq.cryptlen);
+		if (req->dst != req->src)
+			dst = scatterwalk_ffwd(sg_dst, req->dst,
+					       subreq.cryptlen);
+	}
+
+	/* handle ciphertext stealing */
+	skcipher_request_set_crypt(&subreq, src, dst,
+				   req->cryptlen - cbc_blocks * SM4_BLOCK_SIZE,
+				   req->iv);
+
+	err = skcipher_walk_virt(&walk, &subreq, false);
+	if (err)
+		return err;
+
+	kernel_neon_begin();
+
+	if (encrypt)
+		sm4_ce_cbc_cts_enc(ctx->rkey_enc, walk.dst.virt.addr,
+				   walk.src.virt.addr, walk.iv, walk.nbytes);
+	else
+		sm4_ce_cbc_cts_dec(ctx->rkey_dec, walk.dst.virt.addr,
+				   walk.src.virt.addr, walk.iv, walk.nbytes);
+
+	kernel_neon_end();
+
+	return skcipher_walk_done(&walk, 0);
+}
+
+static int sm4_cbc_cts_encrypt(struct skcipher_request *req)
+{
+	return sm4_cbc_cts_crypt(req, true);
+}
+
+static int sm4_cbc_cts_decrypt(struct skcipher_request *req)
+{
+	return sm4_cbc_cts_crypt(req, false);
+}
+
 static int sm4_cfb_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
@@ -342,6 +419,22 @@ static struct skcipher_alg sm4_algs[] = {
 		.setkey		= sm4_setkey,
 		.encrypt	= sm4_ctr_crypt,
 		.decrypt	= sm4_ctr_crypt,
+	}, {
+		.base = {
+			.cra_name		= "cts(cbc(sm4))",
+			.cra_driver_name	= "cts-cbc-sm4-ce",
+			.cra_priority		= 400,
+			.cra_blocksize		= SM4_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.walksize	= SM4_BLOCK_SIZE * 2,
+		.setkey		= sm4_setkey,
+		.encrypt	= sm4_cbc_cts_encrypt,
+		.decrypt	= sm4_cbc_cts_decrypt,
 	}
 };
 
@@ -365,5 +458,6 @@ MODULE_ALIAS_CRYPTO("ecb(sm4)");
 MODULE_ALIAS_CRYPTO("cbc(sm4)");
 MODULE_ALIAS_CRYPTO("cfb(sm4)");
 MODULE_ALIAS_CRYPTO("ctr(sm4)");
+MODULE_ALIAS_CRYPTO("cts(cbc(sm4))");
 MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.3 (Apple Git-128)

