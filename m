Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519EF5E9E00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiIZJjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiIZJhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:37:23 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF6824BEE;
        Mon, 26 Sep 2022 02:36:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VQkQPCm_1664185008;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQkQPCm_1664185008)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 17:36:49 +0800
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
Subject: [PATCH 13/16] crypto: arm64/sm4 - add CE implementation for cmac/xcbc/cbcmac
Date:   Mon, 26 Sep 2022 17:36:17 +0800
Message-Id: <20220926093620.99898-14-tianjia.zhang@linux.alibaba.com>
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

This patch is a CE-optimized assembly implementation for cmac/xcbc/cbcmac.

Benchmark on T-Head Yitian-710 2.75 GHz, the data comes from the 300 mode of
tcrypt, and compared the performance before and after this patch (the driver
used before this patch is XXXmac(sm4-ce)). The abscissas are blocks of
different lengths. The data is tabulated and the unit is Mb/s:

Before:

update-size    |      16      64     256    1024    2048    4096    8192
---------------+--------------------------------------------------------
cmac(sm4-ce)   |  293.33  403.69  503.76  527.78  531.10  535.46  535.81
xcbc(sm4-ce)   |  292.83  402.50  504.02  529.08  529.87  536.55  538.24
cbcmac(sm4-ce) |  318.42  415.79  497.12  515.05  523.15  521.19  523.01

After:

update-size    |      16      64     256    1024    2048    4096    8192
---------------+--------------------------------------------------------
cmac-sm4-ce    |  371.99  675.28  903.56  971.65  980.57  990.40  991.04
xcbc-sm4-ce    |  372.11  674.55  903.47  971.61  980.96  990.42  991.10
cbcmac-sm4-ce  |  371.63  675.33  903.23  972.07  981.42  990.93  991.45

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/sm4-ce-core.S |  70 +++++++++
 arch/arm64/crypto/sm4-ce-glue.c | 267 +++++++++++++++++++++++++++++++-
 2 files changed, 336 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/sm4-ce-core.S b/arch/arm64/crypto/sm4-ce-core.S
index 6b923c3209a0..69fe3b90b7ad 100644
--- a/arch/arm64/crypto/sm4-ce-core.S
+++ b/arch/arm64/crypto/sm4-ce-core.S
@@ -35,6 +35,7 @@
 #define RTMP3	v19
 
 #define RIV	v20
+#define RMAC	v20
 #define RMASK	v21
 
 
@@ -1049,6 +1050,75 @@ SYM_FUNC_START(sm4_ce_xts_dec)
 	ret
 SYM_FUNC_END(sm4_ce_xts_dec)
 
+.align 3
+SYM_FUNC_START(sm4_ce_mac_update)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: digest
+	 *   x2: src
+	 *   w3: nblocks
+	 *   w4: enc_before
+	 *   w5: enc_after
+	 */
+	SM4_PREPARE(x0)
+
+	ld1		{RMAC.16b}, [x1]
+
+	cbz		w4, .Lmac_update
+
+	SM4_CRYPT_BLK(RMAC)
+
+.Lmac_update:
+	cbz		w3, .Lmac_ret
+
+	sub		w6, w3, #1
+	cmp		w5, wzr
+	csel		w3, w3, w6, ne
+
+	cbz		w3, .Lmac_end
+
+.Lmac_loop_4x:
+	cmp		w3, #4
+	blt		.Lmac_loop_1x
+
+	sub		w3, w3, #4
+
+	ld1		{v0.16b-v3.16b}, [x2], #64
+
+	eor		RMAC.16b, RMAC.16b, v0.16b
+	SM4_CRYPT_BLK(RMAC)
+	eor		RMAC.16b, RMAC.16b, v1.16b
+	SM4_CRYPT_BLK(RMAC)
+	eor		RMAC.16b, RMAC.16b, v2.16b
+	SM4_CRYPT_BLK(RMAC)
+	eor		RMAC.16b, RMAC.16b, v3.16b
+	SM4_CRYPT_BLK(RMAC)
+
+	cbz		w3, .Lmac_end
+	b		.Lmac_loop_4x
+
+.Lmac_loop_1x:
+	sub		w3, w3, #1
+
+	ld1		{v0.16b}, [x2], #16
+
+	eor		RMAC.16b, RMAC.16b, v0.16b
+	SM4_CRYPT_BLK(RMAC)
+
+	cbnz		w3, .Lmac_loop_1x
+
+
+.Lmac_end:
+	cbnz		w5, .Lmac_ret
+
+	ld1		{v0.16b}, [x2], #16
+	eor		RMAC.16b, RMAC.16b, v0.16b
+
+.Lmac_ret:
+	st1		{RMAC.16b}, [x1]
+	ret
+SYM_FUNC_END(sm4_ce_mac_update)
+
 
 	.section	".rodata", "a"
 	.align 4
diff --git a/arch/arm64/crypto/sm4-ce-glue.c b/arch/arm64/crypto/sm4-ce-glue.c
index 6267ec1cfac0..c2d10b8e92b2 100644
--- a/arch/arm64/crypto/sm4-ce-glue.c
+++ b/arch/arm64/crypto/sm4-ce-glue.c
@@ -14,8 +14,10 @@
 #include <linux/cpufeature.h>
 #include <asm/neon.h>
 #include <asm/simd.h>
+#include <crypto/b128ops.h>
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
+#include <crypto/internal/hash.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/xts.h>
 #include <crypto/sm4.h>
@@ -55,6 +57,9 @@ asmlinkage void sm4_ce_xts_enc(const u32 *rkey1, u8 *dst, const u8 *src,
 asmlinkage void sm4_ce_xts_dec(const u32 *rkey1, u8 *dst, const u8 *src,
 			       u8 *tweak, unsigned int nbytes,
 			       const u32 *rkey2_enc);
+asmlinkage void sm4_ce_mac_update(const u32 *rkey_enc, u8 *digest,
+				  const u8 *src, unsigned int nblocks,
+				  bool enc_before, bool enc_after);
 
 EXPORT_SYMBOL(sm4_ce_expand_key);
 EXPORT_SYMBOL(sm4_ce_crypt_block);
@@ -72,6 +77,16 @@ struct sm4_essiv_cbc_ctx {
 	struct crypto_shash *hash;
 };
 
+struct sm4_mac_tfm_ctx {
+	struct sm4_ctx key;
+	u8 __aligned(8) consts[];
+};
+
+struct sm4_mac_desc_ctx {
+	unsigned int len;
+	u8 digest[SM4_BLOCK_SIZE];
+};
+
 static int sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
 		      unsigned int key_len)
 {
@@ -721,13 +736,260 @@ static struct skcipher_alg sm4_algs[] = {
 	}
 };
 
+static int sm4_cbcmac_setkey(struct crypto_shash *tfm, const u8 *key,
+			     unsigned int key_len)
+{
+	struct sm4_mac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
+
+	if (key_len != SM4_KEY_SIZE)
+		return -EINVAL;
+
+	kernel_neon_begin();
+	sm4_ce_expand_key(key, ctx->key.rkey_enc, ctx->key.rkey_dec,
+			  crypto_sm4_fk, crypto_sm4_ck);
+	kernel_neon_end();
+
+	return 0;
+}
+
+static int sm4_cmac_setkey(struct crypto_shash *tfm, const u8 *key,
+			   unsigned int key_len)
+{
+	struct sm4_mac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
+	be128 *consts = (be128 *)ctx->consts;
+	u64 a, b;
+
+	if (key_len != SM4_KEY_SIZE)
+		return -EINVAL;
+
+	memset(consts, 0, SM4_BLOCK_SIZE);
+
+	kernel_neon_begin();
+
+	sm4_ce_expand_key(key, ctx->key.rkey_enc, ctx->key.rkey_dec,
+			  crypto_sm4_fk, crypto_sm4_ck);
+
+	/* encrypt the zero block */
+	sm4_ce_crypt_block(ctx->key.rkey_enc, (u8 *)consts, (const u8 *)consts);
+
+	kernel_neon_end();
+
+	/* gf(2^128) multiply zero-ciphertext with u and u^2 */
+	a = be64_to_cpu(consts[0].a);
+	b = be64_to_cpu(consts[0].b);
+	consts[0].a = cpu_to_be64((a << 1) | (b >> 63));
+	consts[0].b = cpu_to_be64((b << 1) ^ ((a >> 63) ? 0x87 : 0));
+
+	a = be64_to_cpu(consts[0].a);
+	b = be64_to_cpu(consts[0].b);
+	consts[1].a = cpu_to_be64((a << 1) | (b >> 63));
+	consts[1].b = cpu_to_be64((b << 1) ^ ((a >> 63) ? 0x87 : 0));
+
+	return 0;
+}
+
+static int sm4_xcbc_setkey(struct crypto_shash *tfm, const u8 *key,
+			   unsigned int key_len)
+{
+	struct sm4_mac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
+	u8 __aligned(8) key2[SM4_BLOCK_SIZE];
+	static u8 const ks[3][SM4_BLOCK_SIZE] = {
+		{ [0 ... SM4_BLOCK_SIZE - 1] = 0x1},
+		{ [0 ... SM4_BLOCK_SIZE - 1] = 0x2},
+		{ [0 ... SM4_BLOCK_SIZE - 1] = 0x3},
+	};
+
+	if (key_len != SM4_KEY_SIZE)
+		return -EINVAL;
+
+	kernel_neon_begin();
+
+	sm4_ce_expand_key(key, ctx->key.rkey_enc, ctx->key.rkey_dec,
+			  crypto_sm4_fk, crypto_sm4_ck);
+
+	sm4_ce_crypt_block(ctx->key.rkey_enc, key2, ks[0]);
+	sm4_ce_crypt(ctx->key.rkey_enc, ctx->consts, ks[1], 2);
+
+	sm4_ce_expand_key(key2, ctx->key.rkey_enc, ctx->key.rkey_dec,
+			  crypto_sm4_fk, crypto_sm4_ck);
+
+	kernel_neon_end();
+
+	return 0;
+}
+
+static int sm4_mac_init(struct shash_desc *desc)
+{
+	struct sm4_mac_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	memset(ctx->digest, 0, SM4_BLOCK_SIZE);
+	ctx->len = 0;
+
+	return 0;
+}
+
+static int sm4_mac_update(struct shash_desc *desc, const u8 *p,
+			  unsigned int len)
+{
+	struct sm4_mac_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct sm4_mac_desc_ctx *ctx = shash_desc_ctx(desc);
+	unsigned int l, nblocks;
+
+	if (len == 0)
+		return 0;
+
+	if (ctx->len || ctx->len + len < SM4_BLOCK_SIZE) {
+		l = min(len, SM4_BLOCK_SIZE - ctx->len);
+
+		crypto_xor(ctx->digest + ctx->len, p, l);
+		ctx->len += l;
+		len -= l;
+		p += l;
+	}
+
+	if (len && (ctx->len % SM4_BLOCK_SIZE) == 0) {
+		kernel_neon_begin();
+
+		if (len < SM4_BLOCK_SIZE && ctx->len == SM4_BLOCK_SIZE) {
+			sm4_ce_crypt_block(tctx->key.rkey_enc,
+					   ctx->digest, ctx->digest);
+			ctx->len = 0;
+		} else {
+			nblocks = len / SM4_BLOCK_SIZE;
+			len %= SM4_BLOCK_SIZE;
+
+			sm4_ce_mac_update(tctx->key.rkey_enc, ctx->digest, p,
+					  nblocks, (ctx->len == SM4_BLOCK_SIZE),
+					  (len != 0));
+
+			p += nblocks * SM4_BLOCK_SIZE;
+
+			if (len == 0)
+				ctx->len = SM4_BLOCK_SIZE;
+		}
+
+		kernel_neon_end();
+
+		if (len) {
+			crypto_xor(ctx->digest, p, len);
+			ctx->len = len;
+		}
+	}
+
+	return 0;
+}
+
+static int sm4_cmac_final(struct shash_desc *desc, u8 *out)
+{
+	struct sm4_mac_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct sm4_mac_desc_ctx *ctx = shash_desc_ctx(desc);
+	const u8 *consts = tctx->consts;
+
+	if (ctx->len != SM4_BLOCK_SIZE) {
+		ctx->digest[ctx->len] ^= 0x80;
+		consts += SM4_BLOCK_SIZE;
+	}
+
+	kernel_neon_begin();
+	sm4_ce_mac_update(tctx->key.rkey_enc, ctx->digest, consts, 1,
+			  false, true);
+	kernel_neon_end();
+
+	memcpy(out, ctx->digest, SM4_BLOCK_SIZE);
+
+	return 0;
+}
+
+static int sm4_cbcmac_final(struct shash_desc *desc, u8 *out)
+{
+	struct sm4_mac_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct sm4_mac_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	if (ctx->len) {
+		kernel_neon_begin();
+		sm4_ce_crypt_block(tctx->key.rkey_enc, ctx->digest,
+				   ctx->digest);
+		kernel_neon_end();
+	}
+
+	memcpy(out, ctx->digest, SM4_BLOCK_SIZE);
+
+	return 0;
+}
+
+static struct shash_alg sm4_mac_algs[] = {
+	{
+		.base = {
+			.cra_name		= "cmac(sm4)",
+			.cra_driver_name	= "cmac-sm4-ce",
+			.cra_priority		= 400,
+			.cra_blocksize		= SM4_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct sm4_mac_tfm_ctx)
+							+ SM4_BLOCK_SIZE * 2,
+			.cra_module		= THIS_MODULE,
+		},
+		.digestsize	= SM4_BLOCK_SIZE,
+		.init		= sm4_mac_init,
+		.update		= sm4_mac_update,
+		.final		= sm4_cmac_final,
+		.setkey		= sm4_cmac_setkey,
+		.descsize	= sizeof(struct sm4_mac_desc_ctx),
+	}, {
+		.base = {
+			.cra_name		= "xcbc(sm4)",
+			.cra_driver_name	= "xcbc-sm4-ce",
+			.cra_priority		= 400,
+			.cra_blocksize		= SM4_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct sm4_mac_tfm_ctx)
+							+ SM4_BLOCK_SIZE * 2,
+			.cra_module		= THIS_MODULE,
+		},
+		.digestsize	= SM4_BLOCK_SIZE,
+		.init		= sm4_mac_init,
+		.update		= sm4_mac_update,
+		.final		= sm4_cmac_final,
+		.setkey		= sm4_xcbc_setkey,
+		.descsize	= sizeof(struct sm4_mac_desc_ctx),
+	}, {
+		.base = {
+			.cra_name		= "cbcmac(sm4)",
+			.cra_driver_name	= "cbcmac-sm4-ce",
+			.cra_priority		= 400,
+			.cra_blocksize		= 1,
+			.cra_ctxsize		= sizeof(struct sm4_mac_tfm_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.digestsize	= SM4_BLOCK_SIZE,
+		.init		= sm4_mac_init,
+		.update		= sm4_mac_update,
+		.final		= sm4_cbcmac_final,
+		.setkey		= sm4_cbcmac_setkey,
+		.descsize	= sizeof(struct sm4_mac_desc_ctx),
+	}
+};
+
 static int __init sm4_init(void)
 {
-	return crypto_register_skciphers(sm4_algs, ARRAY_SIZE(sm4_algs));
+	int err;
+
+	err = crypto_register_skciphers(sm4_algs, ARRAY_SIZE(sm4_algs));
+	if (err)
+		return err;
+
+	err = crypto_register_shashes(sm4_mac_algs, ARRAY_SIZE(sm4_mac_algs));
+	if (err)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	crypto_unregister_skciphers(sm4_algs, ARRAY_SIZE(sm4_algs));
+	return err;
 }
 
 static void __exit sm4_exit(void)
 {
+	crypto_unregister_shashes(sm4_mac_algs, ARRAY_SIZE(sm4_mac_algs));
 	crypto_unregister_skciphers(sm4_algs, ARRAY_SIZE(sm4_algs));
 }
 
@@ -744,5 +1006,8 @@ MODULE_ALIAS_CRYPTO("ctr(sm4)");
 MODULE_ALIAS_CRYPTO("cts(cbc(sm4))");
 MODULE_ALIAS_CRYPTO("xts(sm4)");
 MODULE_ALIAS_CRYPTO("essiv(cbc(sm4),sm3)");
+MODULE_ALIAS_CRYPTO("cmac(sm4)");
+MODULE_ALIAS_CRYPTO("xcbc(sm4)");
+MODULE_ALIAS_CRYPTO("cbcmac(sm4)");
 MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.3 (Apple Git-128)

