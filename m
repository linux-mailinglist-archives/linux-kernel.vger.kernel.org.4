Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CAB5E9DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiIZJiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiIZJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:37:03 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4010264A0;
        Mon, 26 Sep 2022 02:36:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VQjskbL_1664185003;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQjskbL_1664185003)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 17:36:44 +0800
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
Subject: [PATCH 10/16] crypto: arm64/sm4 - add CE implementation for XTS mode
Date:   Mon, 26 Sep 2022 17:36:14 +0800
Message-Id: <20220926093620.99898-11-tianjia.zhang@linux.alibaba.com>
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

This patch is a CE-optimized assembly implementation for XTS mode.

Benchmark on T-Head Yitian-710 2.75 GHz, the data comes from the 218 mode of
tcrypt, and compared the performance before and after this patch (the driver
used before this patch is xts(ecb-sm4-ce)). The abscissas are blocks of
different lengths. The data is tabulated and the unit is Mb/s:

Before:

xts(ecb-sm4-ce) |      16       64      128      256     1024     1420     4096
----------------+--------------------------------------------------------------
        XTS enc |  117.17   430.56   732.92  1134.98  2007.03  2136.23  2347.20
        XTS dec |  116.89   429.02   733.40  1132.96  2006.13  2130.50  2347.92

After:

xts-sm4-ce      |      16       64      128      256     1024     1420     4096
----------------+--------------------------------------------------------------
        XTS enc |  224.68   798.91  1248.08  1714.60  2413.73  2467.84  2612.62
        XTS dec |  229.85   791.34  1237.79  1720.00  2413.30  2473.84  2611.95

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/Kconfig       |   4 +-
 arch/arm64/crypto/sm4-ce-core.S | 343 ++++++++++++++++++++++++++++++++
 arch/arm64/crypto/sm4-ce-glue.c | 159 ++++++++++++++-
 3 files changed, 504 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 4b121dc0cfba..8939f5ae9214 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -231,7 +231,7 @@ config CRYPTO_SM4_ARM64_CE
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SM4_ARM64_CE_BLK
-	tristate "Ciphers: SM4, modes: ECB/CBC/CFB/CTR (ARMv8 Crypto Extensions)"
+	tristate "Ciphers: SM4, modes: ECB/CBC/CFB/CTR/XTS (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SM4
@@ -242,6 +242,8 @@ config CRYPTO_SM4_ARM64_CE_BLK
 	  - CBC (Cipher Block Chaining) mode (NIST SP800-38A)
 	  - CFB (Cipher Feedback) mode (NIST SP800-38A)
 	  - CTR (Counter) mode (NIST SP800-38A)
+	  - XTS (XOR Encrypt XOR with ciphertext stealing) mode (NIST SP800-38E
+	    and IEEE 1619)
 
 	  Architecture: arm64 using:
 	  - ARMv8 Crypto Extensions
diff --git a/arch/arm64/crypto/sm4-ce-core.S b/arch/arm64/crypto/sm4-ce-core.S
index 414d29f8110b..ddd15ec09d38 100644
--- a/arch/arm64/crypto/sm4-ce-core.S
+++ b/arch/arm64/crypto/sm4-ce-core.S
@@ -35,6 +35,7 @@
 #define RTMP3	v19
 
 #define RIV	v20
+#define RMASK	v21
 
 
 .align 3
@@ -665,6 +666,348 @@ SYM_FUNC_START(sm4_ce_ctr_enc)
 SYM_FUNC_END(sm4_ce_ctr_enc)
 
 
+#define tweak_next(vt, vin, RTMP)					\
+		sshr		RTMP.2d, vin.2d, #63;			\
+		and		RTMP.16b, RTMP.16b, RMASK.16b;		\
+		add		vt.2d, vin.2d, vin.2d;			\
+		ext		RTMP.16b, RTMP.16b, RTMP.16b, #8;	\
+		eor		vt.16b, vt.16b, RTMP.16b;
+
+.align 3
+SYM_FUNC_START(sm4_ce_xts_enc)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: tweak (big endian, 128 bit)
+	 *   w4: nbytes
+	 *   x5: round key array for IV
+	 */
+	ld1		{v8.16b}, [x3]
+
+	cbz		x5, .Lxts_enc_nofirst
+
+	SM4_PREPARE(x5)
+
+	/* Generate first tweak */
+	SM4_CRYPT_BLK(v8)
+
+.Lxts_enc_nofirst:
+	SM4_PREPARE(x0)
+
+	ands		w5, w4, #15
+	lsr		w4, w4, #4
+	sub		w6, w4, #1
+	csel		w4, w4, w6, eq
+	uxtw		x5, w5
+
+	movi		RMASK.2s, #0x1
+	movi		RTMP0.2s, #0x87
+	uzp1		RMASK.4s, RMASK.4s, RTMP0.4s
+
+	cbz		w4, .Lxts_enc_cts
+
+.Lxts_enc_loop_8x:
+	sub		w4, w4, #8
+	tbnz		w4, #31, .Lxts_enc_4x
+
+	tweak_next( v9,  v8, RTMP0)
+	tweak_next(v10,  v9, RTMP1)
+	tweak_next(v11, v10, RTMP2)
+	tweak_next(v12, v11, RTMP3)
+	tweak_next(v13, v12, RTMP0)
+	tweak_next(v14, v13, RTMP1)
+	tweak_next(v15, v14, RTMP2)
+
+	ld1		{v0.16b-v3.16b}, [x2], #64
+	ld1		{v4.16b-v7.16b}, [x2], #64
+	eor		v0.16b, v0.16b,  v8.16b
+	eor		v1.16b, v1.16b,  v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
+	eor		v4.16b, v4.16b, v12.16b
+	eor		v5.16b, v5.16b, v13.16b
+	eor		v6.16b, v6.16b, v14.16b
+	eor		v7.16b, v7.16b, v15.16b
+
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7)
+
+	eor		v0.16b, v0.16b,  v8.16b
+	eor		v1.16b, v1.16b,  v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
+	eor		v4.16b, v4.16b, v12.16b
+	eor		v5.16b, v5.16b, v13.16b
+	eor		v6.16b, v6.16b, v14.16b
+	eor		v7.16b, v7.16b, v15.16b
+	st1		{v0.16b-v3.16b}, [x1], #64
+	st1		{v4.16b-v7.16b}, [x1], #64
+
+	tweak_next(v8, v15, RTMP3)
+
+	cbz		w4, .Lxts_enc_cts
+	b		.Lxts_enc_loop_8x
+
+.Lxts_enc_4x:
+	add		w4, w4, #8
+	cmp		w4, #4
+	blt		.Lxts_enc_loop_1x
+
+	sub		w4, w4, #4
+
+	tweak_next( v9,  v8, RTMP0)
+	tweak_next(v10,  v9, RTMP1)
+	tweak_next(v11, v10, RTMP2)
+
+	ld1		{v0.16b-v3.16b}, [x2], #64
+	eor		v0.16b, v0.16b,  v8.16b
+	eor		v1.16b, v1.16b,  v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
+
+	SM4_CRYPT_BLK4(v0, v1, v2, v3)
+
+	eor		v0.16b, v0.16b,  v8.16b
+	eor		v1.16b, v1.16b,  v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
+	st1		{v0.16b-v3.16b}, [x1], #64
+
+	tweak_next(v8, v11, RTMP3)
+
+	cbz		w4, .Lxts_enc_cts
+
+.Lxts_enc_loop_1x:
+	sub		w4, w4, #1
+
+	ld1		{v0.16b}, [x2], #16
+	eor		v0.16b, v0.16b, v8.16b
+
+	SM4_CRYPT_BLK(v0)
+
+	eor		v0.16b, v0.16b, v8.16b
+	st1		{v0.16b}, [x1], #16
+
+	tweak_next(v8, v8, RTMP0)
+
+	cbnz		w4, .Lxts_enc_loop_1x
+
+.Lxts_enc_cts:
+	cbz		x5, .Lxts_enc_end
+
+	/* cipher text stealing */
+
+	tweak_next(v9, v8, RTMP0)
+	ld1		{v0.16b}, [x2]
+	eor		v0.16b, v0.16b, v8.16b
+	SM4_CRYPT_BLK(v0)
+	eor		v0.16b, v0.16b, v8.16b
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
+	tbl		v2.16b, {v0.16b}, v3.16b
+	/* padding Pn with En-1 at the end */
+	tbx		v0.16b, {v1.16b}, v4.16b
+
+	eor		v0.16b, v0.16b, v9.16b
+	SM4_CRYPT_BLK(v0)
+	eor		v0.16b, v0.16b, v9.16b
+
+
+	/* overlapping stores */
+	add		x5, x1, x5
+	st1		{v2.16b}, [x5]
+	st1		{v0.16b}, [x1]
+
+	b		.Lxts_enc_ret
+
+.Lxts_enc_end:
+	/* store new tweak */
+	st1		{v8.16b}, [x3]
+
+.Lxts_enc_ret:
+	ret
+SYM_FUNC_END(sm4_ce_xts_enc)
+
+.align 3
+SYM_FUNC_START(sm4_ce_xts_dec)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: tweak (big endian, 128 bit)
+	 *   w4: nbytes
+	 *   x5: round key array for IV
+	 */
+	ld1		{v8.16b}, [x3]
+
+	cbz		x5, .Lxts_dec_nofirst
+
+	SM4_PREPARE(x5)
+
+	/* Generate first tweak */
+	SM4_CRYPT_BLK(v8)
+
+.Lxts_dec_nofirst:
+	SM4_PREPARE(x0)
+
+	ands		w5, w4, #15
+	lsr		w4, w4, #4
+	sub		w6, w4, #1
+	csel		w4, w4, w6, eq
+	uxtw		x5, w5
+
+	movi		RMASK.2s, #0x1
+	movi		RTMP0.2s, #0x87
+	uzp1		RMASK.4s, RMASK.4s, RTMP0.4s
+
+	cbz		w4, .Lxts_dec_cts
+
+.Lxts_dec_loop_8x:
+	sub		w4, w4, #8
+	tbnz		w4, #31, .Lxts_dec_4x
+
+	tweak_next( v9,  v8, RTMP0)
+	tweak_next(v10,  v9, RTMP1)
+	tweak_next(v11, v10, RTMP2)
+	tweak_next(v12, v11, RTMP3)
+	tweak_next(v13, v12, RTMP0)
+	tweak_next(v14, v13, RTMP1)
+	tweak_next(v15, v14, RTMP2)
+
+	ld1		{v0.16b-v3.16b}, [x2], #64
+	ld1		{v4.16b-v7.16b}, [x2], #64
+	eor		v0.16b, v0.16b,  v8.16b
+	eor		v1.16b, v1.16b,  v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
+	eor		v4.16b, v4.16b, v12.16b
+	eor		v5.16b, v5.16b, v13.16b
+	eor		v6.16b, v6.16b, v14.16b
+	eor		v7.16b, v7.16b, v15.16b
+
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7)
+
+	eor		v0.16b, v0.16b,  v8.16b
+	eor		v1.16b, v1.16b,  v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
+	eor		v4.16b, v4.16b, v12.16b
+	eor		v5.16b, v5.16b, v13.16b
+	eor		v6.16b, v6.16b, v14.16b
+	eor		v7.16b, v7.16b, v15.16b
+	st1		{v0.16b-v3.16b}, [x1], #64
+	st1		{v4.16b-v7.16b}, [x1], #64
+
+	tweak_next(v8, v15, RTMP3)
+
+	cbz		w4, .Lxts_dec_cts
+	b		.Lxts_dec_loop_8x
+
+.Lxts_dec_4x:
+	add		w4, w4, #8
+	cmp		w4, #4
+	blt		.Lxts_dec_loop_1x
+
+	sub		w4, w4, #4
+
+	tweak_next( v9,  v8, RTMP0)
+	tweak_next(v10,  v9, RTMP1)
+	tweak_next(v11, v10, RTMP2)
+
+	ld1		{v0.16b-v3.16b}, [x2], #64
+	eor		v0.16b, v0.16b,  v8.16b
+	eor		v1.16b, v1.16b,  v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
+
+	SM4_CRYPT_BLK4(v0, v1, v2, v3)
+
+	eor		v0.16b, v0.16b,  v8.16b
+	eor		v1.16b, v1.16b,  v9.16b
+	eor		v2.16b, v2.16b, v10.16b
+	eor		v3.16b, v3.16b, v11.16b
+	st1		{v0.16b-v3.16b}, [x1], #64
+
+	tweak_next(v8, v11, RTMP3)
+
+	cbz		w4, .Lxts_dec_cts
+
+.Lxts_dec_loop_1x:
+	sub		w4, w4, #1
+
+	ld1		{v0.16b}, [x2], #16
+	eor		v0.16b, v0.16b, v8.16b
+
+	SM4_CRYPT_BLK(v0)
+
+	eor		v0.16b, v0.16b, v8.16b
+	st1		{v0.16b}, [x1], #16
+
+	tweak_next(v8, v8, RTMP0)
+
+	cbnz		w4, .Lxts_dec_loop_1x
+
+.Lxts_dec_cts:
+	cbz		x5, .Lxts_dec_end
+
+	/* cipher text stealing */
+
+	tweak_next(v9, v8, RTMP0)
+	ld1		{v0.16b}, [x2]
+	eor		v0.16b, v0.16b, v9.16b
+	SM4_CRYPT_BLK(v0)
+	eor		v0.16b, v0.16b, v9.16b
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
+	tbl		v2.16b, {v0.16b}, v3.16b
+	/* padding Pn with En-1 at the end */
+	tbx		v0.16b, {v1.16b}, v4.16b
+
+	eor		v0.16b, v0.16b, v8.16b
+	SM4_CRYPT_BLK(v0)
+	eor		v0.16b, v0.16b, v8.16b
+
+
+	/* overlapping stores */
+	add		x5, x1, x5
+	st1		{v2.16b}, [x5]
+	st1		{v0.16b}, [x1]
+
+	b		.Lxts_dec_ret
+
+.Lxts_dec_end:
+	/* store new tweak */
+	st1		{v8.16b}, [x3]
+
+.Lxts_dec_ret:
+	ret
+SYM_FUNC_END(sm4_ce_xts_dec)
+
+
 	.section	".rodata", "a"
 	.align 4
 .Lbswap128_mask:
diff --git a/arch/arm64/crypto/sm4-ce-glue.c b/arch/arm64/crypto/sm4-ce-glue.c
index 4d4072c7bfa2..8222766f712a 100644
--- a/arch/arm64/crypto/sm4-ce-glue.c
+++ b/arch/arm64/crypto/sm4-ce-glue.c
@@ -17,6 +17,7 @@
 #include <crypto/internal/simd.h>
 #include <crypto/internal/skcipher.h>
 #include <crypto/scatterwalk.h>
+#include <crypto/xts.h>
 #include <crypto/sm4.h>
 
 #define BYTES2BLKS(nbytes)	((nbytes) >> 4)
@@ -40,12 +41,23 @@ asmlinkage void sm4_ce_cfb_dec(const u32 *rkey, u8 *dst, const u8 *src,
 			       u8 *iv, unsigned int nblks);
 asmlinkage void sm4_ce_ctr_enc(const u32 *rkey, u8 *dst, const u8 *src,
 			       u8 *iv, unsigned int nblks);
+asmlinkage void sm4_ce_xts_enc(const u32 *rkey1, u8 *dst, const u8 *src,
+			       u8 *tweak, unsigned int nbytes,
+			       const u32 *rkey2_enc);
+asmlinkage void sm4_ce_xts_dec(const u32 *rkey1, u8 *dst, const u8 *src,
+			       u8 *tweak, unsigned int nbytes,
+			       const u32 *rkey2_enc);
 
 EXPORT_SYMBOL(sm4_ce_expand_key);
 EXPORT_SYMBOL(sm4_ce_crypt_block);
 EXPORT_SYMBOL(sm4_ce_cbc_enc);
 EXPORT_SYMBOL(sm4_ce_cfb_enc);
 
+struct sm4_xts_ctx {
+	struct sm4_ctx key1;
+	struct sm4_ctx key2;
+};
+
 static int sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
 		      unsigned int key_len)
 {
@@ -61,6 +73,29 @@ static int sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	return 0;
 }
 
+static int sm4_xts_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			  unsigned int key_len)
+{
+	struct sm4_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int ret;
+
+	if (key_len != SM4_KEY_SIZE * 2)
+		return -EINVAL;
+
+	ret = xts_verify_key(tfm, key, key_len);
+	if (ret)
+		return ret;
+
+	kernel_neon_begin();
+	sm4_ce_expand_key(key, ctx->key1.rkey_enc,
+			  ctx->key1.rkey_dec, crypto_sm4_fk, crypto_sm4_ck);
+	sm4_ce_expand_key(&key[SM4_KEY_SIZE], ctx->key2.rkey_enc,
+			  ctx->key2.rkey_dec, crypto_sm4_fk, crypto_sm4_ck);
+	kernel_neon_end();
+
+	return 0;
+}
+
 static int sm4_ecb_do_crypt(struct skcipher_request *req, const u32 *rkey)
 {
 	struct skcipher_walk walk;
@@ -357,6 +392,111 @@ static int sm4_ctr_crypt(struct skcipher_request *req)
 	return err;
 }
 
+static int sm4_xts_crypt(struct skcipher_request *req, bool encrypt)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int tail = req->cryptlen % SM4_BLOCK_SIZE;
+	const u32 *rkey2_enc = ctx->key2.rkey_enc;
+	struct scatterlist sg_src[2], sg_dst[2];
+	struct skcipher_request subreq;
+	struct scatterlist *src, *dst;
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	if (req->cryptlen < SM4_BLOCK_SIZE)
+		return -EINVAL;
+
+	err = skcipher_walk_virt(&walk, req, false);
+	if (err)
+		return err;
+
+	if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
+		int nblocks = DIV_ROUND_UP(req->cryptlen, SM4_BLOCK_SIZE) - 2;
+
+		skcipher_walk_abort(&walk);
+
+		skcipher_request_set_tfm(&subreq, tfm);
+		skcipher_request_set_callback(&subreq,
+					      skcipher_request_flags(req),
+					      NULL, NULL);
+		skcipher_request_set_crypt(&subreq, req->src, req->dst,
+					   nblocks * SM4_BLOCK_SIZE, req->iv);
+
+		err = skcipher_walk_virt(&walk, &subreq, false);
+		if (err)
+			return err;
+	} else {
+		tail = 0;
+	}
+
+	while ((nbytes = walk.nbytes) >= SM4_BLOCK_SIZE) {
+		if (nbytes < walk.total)
+			nbytes &= ~(SM4_BLOCK_SIZE - 1);
+
+		kernel_neon_begin();
+
+		if (encrypt)
+			sm4_ce_xts_enc(ctx->key1.rkey_enc, walk.dst.virt.addr,
+				       walk.src.virt.addr, walk.iv, nbytes,
+				       rkey2_enc);
+		else
+			sm4_ce_xts_dec(ctx->key1.rkey_dec, walk.dst.virt.addr,
+				       walk.src.virt.addr, walk.iv, nbytes,
+				       rkey2_enc);
+
+		kernel_neon_end();
+
+		rkey2_enc = NULL;
+
+		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+		if (err)
+			return err;
+	}
+
+	if (likely(tail == 0))
+		return 0;
+
+	/* handle ciphertext stealing */
+
+	dst = src = scatterwalk_ffwd(sg_src, req->src, subreq.cryptlen);
+	if (req->dst != req->src)
+		dst = scatterwalk_ffwd(sg_dst, req->dst, subreq.cryptlen);
+
+	skcipher_request_set_crypt(&subreq, src, dst, SM4_BLOCK_SIZE + tail,
+				   req->iv);
+
+	err = skcipher_walk_virt(&walk, &subreq, false);
+	if (err)
+		return err;
+
+	kernel_neon_begin();
+
+	if (encrypt)
+		sm4_ce_xts_enc(ctx->key1.rkey_enc, walk.dst.virt.addr,
+			       walk.src.virt.addr, walk.iv, walk.nbytes,
+			       rkey2_enc);
+	else
+		sm4_ce_xts_dec(ctx->key1.rkey_dec, walk.dst.virt.addr,
+			       walk.src.virt.addr, walk.iv, walk.nbytes,
+			       rkey2_enc);
+
+	kernel_neon_end();
+
+	return skcipher_walk_done(&walk, 0);
+}
+
+static int sm4_xts_encrypt(struct skcipher_request *req)
+{
+	return sm4_xts_crypt(req, true);
+}
+
+static int sm4_xts_decrypt(struct skcipher_request *req)
+{
+	return sm4_xts_crypt(req, false);
+}
+
 static struct skcipher_alg sm4_algs[] = {
 	{
 		.base = {
@@ -435,6 +575,22 @@ static struct skcipher_alg sm4_algs[] = {
 		.setkey		= sm4_setkey,
 		.encrypt	= sm4_cbc_cts_encrypt,
 		.decrypt	= sm4_cbc_cts_decrypt,
+	}, {
+		.base = {
+			.cra_name		= "xts(sm4)",
+			.cra_driver_name	= "xts-sm4-ce",
+			.cra_priority		= 400,
+			.cra_blocksize		= SM4_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct sm4_xts_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE * 2,
+		.max_keysize	= SM4_KEY_SIZE * 2,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.walksize	= SM4_BLOCK_SIZE * 2,
+		.setkey		= sm4_xts_setkey,
+		.encrypt	= sm4_xts_encrypt,
+		.decrypt	= sm4_xts_decrypt,
 	}
 };
 
@@ -451,7 +607,7 @@ static void __exit sm4_exit(void)
 module_cpu_feature_match(SM4, sm4_init);
 module_exit(sm4_exit);
 
-MODULE_DESCRIPTION("SM4 ECB/CBC/CFB/CTR using ARMv8 Crypto Extensions");
+MODULE_DESCRIPTION("SM4 ECB/CBC/CFB/CTR/XTS using ARMv8 Crypto Extensions");
 MODULE_ALIAS_CRYPTO("sm4-ce");
 MODULE_ALIAS_CRYPTO("sm4");
 MODULE_ALIAS_CRYPTO("ecb(sm4)");
@@ -459,5 +615,6 @@ MODULE_ALIAS_CRYPTO("cbc(sm4)");
 MODULE_ALIAS_CRYPTO("cfb(sm4)");
 MODULE_ALIAS_CRYPTO("ctr(sm4)");
 MODULE_ALIAS_CRYPTO("cts(cbc(sm4))");
+MODULE_ALIAS_CRYPTO("xts(sm4)");
 MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.3 (Apple Git-128)

