Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA155E9DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiIZJjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiIZJhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:37:21 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B597357CC;
        Mon, 26 Sep 2022 02:36:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VQkJzJF_1664185010;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQkJzJF_1664185010)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 17:36:52 +0800
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
Subject: [PATCH 14/16] crypto: arm64/sm4 - add CE implementation for CCM mode
Date:   Mon, 26 Sep 2022 17:36:18 +0800
Message-Id: <20220926093620.99898-15-tianjia.zhang@linux.alibaba.com>
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

This patch is a CE-optimized assembly implementation for CCM mode.

Benchmark on T-Head Yitian-710 2.75 GHz, the data comes from the 223 and 225
modes of tcrypt, and compared the performance before and after this patch (the
driver used before this patch is ccm_base(ctr-sm4-ce,cbcmac-sm4-ce)).
The abscissas are blocks of different lengths. The data is tabulated and the
unit is Mb/s:

Before (rfc4309(ccm_base(ctr-sm4-ce,cbcmac-sm4-ce))):

ccm(sm4)     |     16      64     256     512    1024    1420    4096    8192
-------------+---------------------------------------------------------------
  CCM enc    |  35.07  125.40  336.47  468.17  581.97  619.18  712.56  736.01
  CCM dec    |  34.87  124.40  335.08  466.75  581.04  618.81  712.25  735.89
  CCM mb enc |  34.71  123.96  333.92  465.39  579.91  617.49  711.45  734.92
  CCM mb dec |  34.42  122.80  331.02  462.81  578.28  616.42  709.88  734.19

After (rfc4309(ccm-sm4-ce)):

ccm-sm4-ce   |     16      64     256     512    1024    1420    4096    8192
-------------+---------------------------------------------------------------
  CCM enc    |  77.12  249.82  569.94  725.17  839.27  867.71  952.87  969.89
  CCM dec    |  75.90  247.26  566.29  722.12  836.90  865.95  951.74  968.57
  CCM mb enc |  75.98  245.25  562.91  718.99  834.76  864.70  950.17  967.90
  CCM mb dec |  75.06  243.78  560.58  717.13  833.68  862.70  949.35  967.11

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/Kconfig           |  16 ++
 arch/arm64/crypto/Makefile          |   3 +
 arch/arm64/crypto/sm4-ce-ccm-core.S | 328 ++++++++++++++++++++++++++++
 arch/arm64/crypto/sm4-ce-ccm-glue.c | 303 +++++++++++++++++++++++++
 4 files changed, 650 insertions(+)
 create mode 100644 arch/arm64/crypto/sm4-ce-ccm-core.S
 create mode 100644 arch/arm64/crypto/sm4-ce-ccm-glue.c

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 8939f5ae9214..2611036a3e3f 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -281,6 +281,22 @@ config CRYPTO_AES_ARM64_CE_CCM
 	  - ARMv8 Crypto Extensions
 	  - NEON (Advanced SIMD) extensions
 
+config CRYPTO_SM4_ARM64_CE_CCM
+	tristate "AEAD cipher: SM4 in CCM mode (ARMv8 Crypto Extensions)"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_ALGAPI
+	select CRYPTO_AEAD
+	select CRYPTO_SM4
+	select CRYPTO_SM4_ARM64_CE_BLK
+	help
+	  AEAD cipher: SM4 cipher algorithms (OSCCA GB/T 32907-2016) with
+	  CCM (Counter with Cipher Block Chaining-Message Authentication Code)
+	  authenticated encryption mode (NIST SP800-38C)
+
+	  Architecture: arm64 using:
+	  - ARMv8 Crypto Extensions
+	  - NEON (Advanced SIMD) extensions
+
 config CRYPTO_CRCT10DIF_ARM64_CE
 	tristate "CRCT10DIF (PMULL)"
 	depends on KERNEL_MODE_NEON && CRC_T10DIF
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 087f1625e775..843ea5266965 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -29,6 +29,9 @@ sm4-ce-cipher-y := sm4-ce-cipher-glue.o sm4-ce-cipher-core.o
 obj-$(CONFIG_CRYPTO_SM4_ARM64_CE_BLK) += sm4-ce.o
 sm4-ce-y := sm4-ce-glue.o sm4-ce-core.o
 
+obj-$(CONFIG_CRYPTO_SM4_ARM64_CE_CCM) += sm4-ce-ccm.o
+sm4-ce-ccm-y := sm4-ce-ccm-glue.o sm4-ce-ccm-core.o
+
 obj-$(CONFIG_CRYPTO_SM4_ARM64_NEON_BLK) += sm4-neon.o
 sm4-neon-y := sm4-neon-glue.o sm4-neon-core.o
 
diff --git a/arch/arm64/crypto/sm4-ce-ccm-core.S b/arch/arm64/crypto/sm4-ce-ccm-core.S
new file mode 100644
index 000000000000..028207c4afd0
--- /dev/null
+++ b/arch/arm64/crypto/sm4-ce-ccm-core.S
@@ -0,0 +1,328 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4-CCM AEAD Algorithm using ARMv8 Crypto Extensions
+ * as specified in rfc8998
+ * https://datatracker.ietf.org/doc/html/rfc8998
+ *
+ * Copyright (C) 2022 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include "sm4-ce-asm.h"
+
+.arch	armv8-a+crypto
+
+.irp b, 0, 1, 8, 9, 10, 11, 12, 13, 14, 15, 16, 24, 25, 26, 27, 28, 29, 30, 31
+	.set .Lv\b\().4s, \b
+.endr
+
+.macro sm4e, vd, vn
+	.inst 0xcec08400 | (.L\vn << 5) | .L\vd
+.endm
+
+/* Register macros */
+
+#define RMAC	v16
+
+/* Helper macros. */
+
+#define inc_le128(vctr)					\
+		mov		vctr.d[1], x8;		\
+		mov		vctr.d[0], x7;		\
+		adds		x8, x8, #1;		\
+		rev64		vctr.16b, vctr.16b;	\
+		adc		x7, x7, xzr;
+
+
+.align 3
+SYM_FUNC_START(sm4_ce_cbcmac_update)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: mac
+	 *   x2: src
+	 *   w3: nblocks
+	 */
+	SM4_PREPARE(x0)
+
+	ld1		{RMAC.16b}, [x1]
+
+.Lcbcmac_loop_4x:
+	cmp		w3, #4
+	blt		.Lcbcmac_loop_1x
+
+	sub		w3, w3, #4
+
+	ld1		{v0.16b-v3.16b}, [x2], #64
+
+	SM4_CRYPT_BLK(RMAC)
+	eor		RMAC.16b, RMAC.16b, v0.16b
+	SM4_CRYPT_BLK(RMAC)
+	eor		RMAC.16b, RMAC.16b, v1.16b
+	SM4_CRYPT_BLK(RMAC)
+	eor		RMAC.16b, RMAC.16b, v2.16b
+	SM4_CRYPT_BLK(RMAC)
+	eor		RMAC.16b, RMAC.16b, v3.16b
+
+	cbz		w3, .Lcbcmac_end
+	b		.Lcbcmac_loop_4x
+
+.Lcbcmac_loop_1x:
+	sub		w3, w3, #1
+
+	ld1		{v0.16b}, [x2], #16
+
+	SM4_CRYPT_BLK(RMAC)
+	eor		RMAC.16b, RMAC.16b, v0.16b
+
+	cbnz		w3, .Lcbcmac_loop_1x
+
+.Lcbcmac_end:
+	st1		{RMAC.16b}, [x1]
+	ret
+SYM_FUNC_END(sm4_ce_cbcmac_update)
+
+.align 3
+SYM_FUNC_START(sm4_ce_ccm_final)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: ctr0 (big endian, 128 bit)
+	 *   x2: mac
+	 */
+	SM4_PREPARE(x0)
+
+	ld1		{RMAC.16b}, [x2]
+	ld1		{v0.16b}, [x1]
+
+	SM4_CRYPT_BLK2(RMAC, v0)
+
+	/* en-/decrypt the mac with ctr0 */
+	eor		RMAC.16b, RMAC.16b, v0.16b
+	st1		{RMAC.16b}, [x2]
+
+	ret
+SYM_FUNC_END(sm4_ce_ccm_final)
+
+.align 3
+SYM_FUNC_START(sm4_ce_ccm_enc)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: ctr (big endian, 128 bit)
+	 *   w4: nbytes
+	 *   x5: mac
+	 */
+	SM4_PREPARE(x0)
+
+	ldp		x7, x8, [x3]
+	rev		x7, x7
+	rev		x8, x8
+
+	ld1		{RMAC.16b}, [x5]
+
+.Lccm_enc_loop_4x:
+	cmp		w4, #(4 * 16)
+	blt		.Lccm_enc_loop_1x
+
+	sub		w4, w4, #(4 * 16)
+
+	/* construct CTRs */
+	inc_le128(v8)			/* +0 */
+	inc_le128(v9)			/* +1 */
+	inc_le128(v10)			/* +2 */
+	inc_le128(v11)			/* +3 */
+
+	ld1		{v0.16b-v3.16b}, [x2], #64
+
+	SM4_CRYPT_BLK2(v8, RMAC)
+	eor		v8.16b, v8.16b, v0.16b
+	eor		RMAC.16b, RMAC.16b, v0.16b
+	SM4_CRYPT_BLK2(v9, RMAC)
+	eor		v9.16b, v9.16b, v1.16b
+	eor		RMAC.16b, RMAC.16b, v1.16b
+	SM4_CRYPT_BLK2(v10, RMAC)
+	eor		v10.16b, v10.16b, v2.16b
+	eor		RMAC.16b, RMAC.16b, v2.16b
+	SM4_CRYPT_BLK2(v11, RMAC)
+	eor		v11.16b, v11.16b, v3.16b
+	eor		RMAC.16b, RMAC.16b, v3.16b
+
+	st1		{v8.16b-v11.16b}, [x1], #64
+
+	cbz		w4, .Lccm_enc_end
+	b		.Lccm_enc_loop_4x
+
+.Lccm_enc_loop_1x:
+	cmp		w4, #16
+	blt		.Lccm_enc_tail
+
+	sub		w4, w4, #16
+
+	/* construct CTRs */
+	inc_le128(v8)
+
+	ld1		{v0.16b}, [x2], #16
+
+	SM4_CRYPT_BLK2(v8, RMAC)
+	eor		v8.16b, v8.16b, v0.16b
+	eor		RMAC.16b, RMAC.16b, v0.16b
+
+	st1		{v8.16b}, [x1], #16
+
+	cbz		w4, .Lccm_enc_end
+	b		.Lccm_enc_loop_1x
+
+.Lccm_enc_tail:
+	/* construct CTRs */
+	inc_le128(v8)
+
+	SM4_CRYPT_BLK2(RMAC, v8)
+
+	/* store new MAC */
+	st1		{RMAC.16b}, [x5]
+
+.Lccm_enc_tail_loop:
+	ldrb		w0, [x2], #1		/* get 1 byte from input */
+	umov		w9, v8.b[0]		/* get top crypted CTR byte */
+	umov		w6, RMAC.b[0]		/* get top MAC byte */
+
+	eor		w9, w9, w0		/* w9 = CTR ^ input */
+	eor		w6, w6, w0		/* w6 = MAC ^ input */
+
+	strb		w9, [x1], #1		/* store out byte */
+	strb		w6, [x5], #1		/* store MAC byte */
+
+	subs		w4, w4, #1
+	beq		.Lccm_enc_ret
+
+	/* shift out one byte */
+	ext		RMAC.16b, RMAC.16b, RMAC.16b, #1
+	ext		v8.16b, v8.16b, v8.16b, #1
+
+	b		.Lccm_enc_tail_loop
+
+.Lccm_enc_end:
+	/* store new MAC */
+	st1		{RMAC.16b}, [x5]
+
+	/* store new CTR */
+	rev		x7, x7
+	rev		x8, x8
+	stp		x7, x8, [x3]
+
+.Lccm_enc_ret:
+	ret
+SYM_FUNC_END(sm4_ce_ccm_enc)
+
+.align 3
+SYM_FUNC_START(sm4_ce_ccm_dec)
+	/* input:
+	 *   x0: round key array, CTX
+	 *   x1: dst
+	 *   x2: src
+	 *   x3: ctr (big endian, 128 bit)
+	 *   w4: nbytes
+	 *   x5: mac
+	 */
+	SM4_PREPARE(x0)
+
+	ldp		x7, x8, [x3]
+	rev		x7, x7
+	rev		x8, x8
+
+	ld1		{RMAC.16b}, [x5]
+
+.Lccm_dec_loop_4x:
+	cmp		w4, #(4 * 16)
+	blt		.Lccm_dec_loop_1x
+
+	sub		w4, w4, #(4 * 16)
+
+	/* construct CTRs */
+	inc_le128(v8)			/* +0 */
+	inc_le128(v9)			/* +1 */
+	inc_le128(v10)			/* +2 */
+	inc_le128(v11)			/* +3 */
+
+	ld1		{v0.16b-v3.16b}, [x2], #64
+
+	SM4_CRYPT_BLK2(v8, RMAC)
+	eor		v8.16b, v8.16b, v0.16b
+	eor		RMAC.16b, RMAC.16b, v8.16b
+	SM4_CRYPT_BLK2(v9, RMAC)
+	eor		v9.16b, v9.16b, v1.16b
+	eor		RMAC.16b, RMAC.16b, v9.16b
+	SM4_CRYPT_BLK2(v10, RMAC)
+	eor		v10.16b, v10.16b, v2.16b
+	eor		RMAC.16b, RMAC.16b, v10.16b
+	SM4_CRYPT_BLK2(v11, RMAC)
+	eor		v11.16b, v11.16b, v3.16b
+	eor		RMAC.16b, RMAC.16b, v11.16b
+
+	st1		{v8.16b-v11.16b}, [x1], #64
+
+	cbz		w4, .Lccm_dec_end
+	b		.Lccm_dec_loop_4x
+
+.Lccm_dec_loop_1x:
+	cmp		w4, #16
+	blt		.Lccm_dec_tail
+
+	sub		w4, w4, #16
+
+	/* construct CTRs */
+	inc_le128(v8)
+
+	ld1		{v0.16b}, [x2], #16
+
+	SM4_CRYPT_BLK2(v8, RMAC)
+	eor		v8.16b, v8.16b, v0.16b
+	eor		RMAC.16b, RMAC.16b, v8.16b
+
+	st1		{v8.16b}, [x1], #16
+
+	cbz		w4, .Lccm_dec_end
+	b		.Lccm_dec_loop_1x
+
+.Lccm_dec_tail:
+	/* construct CTRs */
+	inc_le128(v8)
+
+	SM4_CRYPT_BLK2(RMAC, v8)
+
+	/* store new MAC */
+	st1		{RMAC.16b}, [x5]
+
+.Lccm_dec_tail_loop:
+	ldrb		w0, [x2], #1		/* get 1 byte from input */
+	umov		w9, v8.b[0]		/* get top crypted CTR byte */
+	umov		w6, RMAC.b[0]		/* get top MAC byte */
+
+	eor		w9, w9, w0		/* w9 = CTR ^ input */
+	eor		w6, w6, w9		/* w6 = MAC ^ output */
+
+	strb		w9, [x1], #1		/* store out byte */
+	strb		w6, [x5], #1		/* store MAC byte */
+
+	subs		w4, w4, #1
+	beq		.Lccm_dec_ret
+
+	/* shift out one byte */
+	ext		RMAC.16b, RMAC.16b, RMAC.16b, #1
+	ext		v8.16b, v8.16b, v8.16b, #1
+
+	b		.Lccm_dec_tail_loop
+
+.Lccm_dec_end:
+	/* store new MAC */
+	st1		{RMAC.16b}, [x5]
+
+	/* store new CTR */
+	rev		x7, x7
+	rev		x8, x8
+	stp		x7, x8, [x3]
+
+.Lccm_dec_ret:
+	ret
+SYM_FUNC_END(sm4_ce_ccm_dec)
diff --git a/arch/arm64/crypto/sm4-ce-ccm-glue.c b/arch/arm64/crypto/sm4-ce-ccm-glue.c
new file mode 100644
index 000000000000..f2cec7b52efc
--- /dev/null
+++ b/arch/arm64/crypto/sm4-ce-ccm-glue.c
@@ -0,0 +1,303 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4-CCM AEAD Algorithm using ARMv8 Crypto Extensions
+ * as specified in rfc8998
+ * https://datatracker.ietf.org/doc/html/rfc8998
+ *
+ * Copyright (C) 2022 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#include <linux/module.h>
+#include <linux/crypto.h>
+#include <linux/kernel.h>
+#include <linux/cpufeature.h>
+#include <asm/neon.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/sm4.h>
+#include "sm4-ce.h"
+
+asmlinkage void sm4_ce_cbcmac_update(const u32 *rkey_enc, u8 *mac,
+				     const u8 *src, unsigned int nblocks);
+asmlinkage void sm4_ce_ccm_enc(const u32 *rkey_enc, u8 *dst, const u8 *src,
+			       u8 *iv, unsigned int nbytes, u8 *mac);
+asmlinkage void sm4_ce_ccm_dec(const u32 *rkey_enc, u8 *dst, const u8 *src,
+			       u8 *iv, unsigned int nbytes, u8 *mac);
+asmlinkage void sm4_ce_ccm_final(const u32 *rkey_enc, u8 *iv, u8 *mac);
+
+
+static int ccm_setkey(struct crypto_aead *tfm, const u8 *key,
+		      unsigned int key_len)
+{
+	struct sm4_ctx *ctx = crypto_aead_ctx(tfm);
+
+	if (key_len != SM4_KEY_SIZE)
+		return -EINVAL;
+
+	kernel_neon_begin();
+	sm4_ce_expand_key(key, ctx->rkey_enc, ctx->rkey_dec,
+			  crypto_sm4_fk, crypto_sm4_ck);
+	kernel_neon_end();
+
+	return 0;
+}
+
+static int ccm_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
+{
+	if ((authsize & 1) || authsize < 4)
+		return -EINVAL;
+	return 0;
+}
+
+static int ccm_format_input(u8 info[], struct aead_request *req,
+			    unsigned int msglen)
+{
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	unsigned int l = req->iv[0] + 1;
+	unsigned int m;
+	__be32 len;
+
+	/* verify that CCM dimension 'L': 2 <= L <= 8 */
+	if (l < 2 || l > 8)
+		return -EINVAL;
+	if (l < 4 && msglen >> (8 * l))
+		return -EOVERFLOW;
+
+	memset(&req->iv[SM4_BLOCK_SIZE - l], 0, l);
+
+	memcpy(info, req->iv, SM4_BLOCK_SIZE);
+
+	m = crypto_aead_authsize(aead);
+
+	/* format flags field per RFC 3610/NIST 800-38C */
+	*info |= ((m - 2) / 2) << 3;
+	if (req->assoclen)
+		*info |= (1 << 6);
+
+	/*
+	 * format message length field,
+	 * Linux uses a u32 type to represent msglen
+	 */
+	if (l >= 4)
+		l = 4;
+
+	len = cpu_to_be32(msglen);
+	memcpy(&info[SM4_BLOCK_SIZE - l], (u8 *)&len + 4 - l, l);
+
+	return 0;
+}
+
+static void ccm_calculate_auth_mac(struct aead_request *req, u8 mac[])
+{
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_aead_ctx(aead);
+	struct __packed { __be16 l; __be32 h; } aadlen;
+	u32 assoclen = req->assoclen;
+	struct scatter_walk walk;
+	unsigned int len;
+
+	if (assoclen < 0xff00) {
+		aadlen.l = cpu_to_be16(assoclen);
+		len = 2;
+	} else {
+		aadlen.l = cpu_to_be16(0xfffe);
+		put_unaligned_be32(assoclen, &aadlen.h);
+		len = 6;
+	}
+
+	sm4_ce_crypt_block(ctx->rkey_enc, mac, mac);
+	crypto_xor(mac, (const u8 *)&aadlen, len);
+
+	scatterwalk_start(&walk, req->src);
+
+	do {
+		u32 n = scatterwalk_clamp(&walk, assoclen);
+		u8 *p, *ptr;
+
+		if (!n) {
+			scatterwalk_start(&walk, sg_next(walk.sg));
+			n = scatterwalk_clamp(&walk, assoclen);
+		}
+
+		p = ptr = scatterwalk_map(&walk);
+		assoclen -= n;
+		scatterwalk_advance(&walk, n);
+
+		while (n > 0) {
+			unsigned int l, nblocks;
+
+			if (len == SM4_BLOCK_SIZE) {
+				if (n < SM4_BLOCK_SIZE) {
+					sm4_ce_crypt_block(ctx->rkey_enc,
+							   mac, mac);
+
+					len = 0;
+				} else {
+					nblocks = n / SM4_BLOCK_SIZE;
+					sm4_ce_cbcmac_update(ctx->rkey_enc,
+							     mac, ptr, nblocks);
+
+					ptr += nblocks * SM4_BLOCK_SIZE;
+					n %= SM4_BLOCK_SIZE;
+
+					continue;
+				}
+			}
+
+			l = min(n, SM4_BLOCK_SIZE - len);
+			if (l) {
+				crypto_xor(mac + len, ptr, l);
+				len += l;
+				ptr += l;
+				n -= l;
+			}
+		}
+
+		scatterwalk_unmap(p);
+		scatterwalk_done(&walk, 0, assoclen);
+	} while (assoclen);
+}
+
+static int ccm_crypt(struct aead_request *req, struct skcipher_walk *walk,
+		     u32 *rkey_enc, u8 mac[],
+		     void (*sm4_ce_ccm_crypt)(const u32 *rkey_enc, u8 *dst,
+					const u8 *src, u8 *iv,
+					unsigned int nbytes, u8 *mac))
+{
+	u8 __aligned(8) ctr0[SM4_BLOCK_SIZE];
+	int err;
+
+	/* preserve the initial ctr0 for the TAG */
+	memcpy(ctr0, walk->iv, SM4_BLOCK_SIZE);
+	crypto_inc(walk->iv, SM4_BLOCK_SIZE);
+
+	kernel_neon_begin();
+
+	if (req->assoclen)
+		ccm_calculate_auth_mac(req, mac);
+
+	do {
+		unsigned int tail = walk->nbytes % SM4_BLOCK_SIZE;
+		const u8 *src = walk->src.virt.addr;
+		u8 *dst = walk->dst.virt.addr;
+
+		if (walk->nbytes == walk->total)
+			tail = 0;
+
+		if (walk->nbytes - tail)
+			sm4_ce_ccm_crypt(rkey_enc, dst, src, walk->iv,
+					 walk->nbytes - tail, mac);
+
+		if (walk->nbytes == walk->total)
+			sm4_ce_ccm_final(rkey_enc, ctr0, mac);
+
+		kernel_neon_end();
+
+		if (walk->nbytes) {
+			err = skcipher_walk_done(walk, tail);
+			if (err)
+				return err;
+			if (walk->nbytes)
+				kernel_neon_begin();
+		}
+	} while (walk->nbytes > 0);
+
+	return 0;
+}
+
+static int ccm_encrypt(struct aead_request *req)
+{
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_aead_ctx(aead);
+	u8 __aligned(8) mac[SM4_BLOCK_SIZE];
+	struct skcipher_walk walk;
+	int err;
+
+	err = ccm_format_input(mac, req, req->cryptlen);
+	if (err)
+		return err;
+
+	err = skcipher_walk_aead_encrypt(&walk, req, false);
+	if (err)
+		return err;
+
+	err = ccm_crypt(req, &walk, ctx->rkey_enc, mac, sm4_ce_ccm_enc);
+	if (err)
+		return err;
+
+	/* copy authtag to end of dst */
+	scatterwalk_map_and_copy(mac, req->dst, req->assoclen + req->cryptlen,
+				 crypto_aead_authsize(aead), 1);
+
+	return 0;
+}
+
+static int ccm_decrypt(struct aead_request *req)
+{
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	unsigned int authsize = crypto_aead_authsize(aead);
+	struct sm4_ctx *ctx = crypto_aead_ctx(aead);
+	u8 __aligned(8) mac[SM4_BLOCK_SIZE];
+	u8 authtag[SM4_BLOCK_SIZE];
+	struct skcipher_walk walk;
+	int err;
+
+	err = ccm_format_input(mac, req, req->cryptlen - authsize);
+	if (err)
+		return err;
+
+	err = skcipher_walk_aead_decrypt(&walk, req, false);
+	if (err)
+		return err;
+
+	err = ccm_crypt(req, &walk, ctx->rkey_enc, mac, sm4_ce_ccm_dec);
+	if (err)
+		return err;
+
+	/* compare calculated auth tag with the stored one */
+	scatterwalk_map_and_copy(authtag, req->src,
+				 req->assoclen + req->cryptlen - authsize,
+				 authsize, 0);
+
+	if (crypto_memneq(authtag, mac, authsize))
+		return -EBADMSG;
+
+	return 0;
+}
+
+static struct aead_alg sm4_ccm_alg = {
+	.base = {
+		.cra_name		= "ccm(sm4)",
+		.cra_driver_name	= "ccm-sm4-ce",
+		.cra_priority		= 400,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct sm4_ctx),
+		.cra_module		= THIS_MODULE,
+	},
+	.ivsize		= SM4_BLOCK_SIZE,
+	.chunksize	= SM4_BLOCK_SIZE,
+	.maxauthsize	= SM4_BLOCK_SIZE,
+	.setkey		= ccm_setkey,
+	.setauthsize	= ccm_setauthsize,
+	.encrypt	= ccm_encrypt,
+	.decrypt	= ccm_decrypt,
+};
+
+static int __init sm4_ce_ccm_init(void)
+{
+	return crypto_register_aead(&sm4_ccm_alg);
+}
+
+static void __exit sm4_ce_ccm_exit(void)
+{
+	crypto_unregister_aead(&sm4_ccm_alg);
+}
+
+module_cpu_feature_match(SM4, sm4_ce_ccm_init);
+module_exit(sm4_ce_ccm_exit);
+
+MODULE_DESCRIPTION("Synchronous SM4 in CCM mode using ARMv8 Crypto Extensions");
+MODULE_ALIAS_CRYPTO("ccm(sm4)");
+MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.3 (Apple Git-128)

