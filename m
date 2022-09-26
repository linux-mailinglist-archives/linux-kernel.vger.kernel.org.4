Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141B75E9DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiIZJhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiIZJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:36:42 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C223149;
        Mon, 26 Sep 2022 02:36:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VQkJzD3_1664184990;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQkJzD3_1664184990)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 17:36:31 +0800
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
Subject: [PATCH 03/16] crypto: arm64/sm4 - refactor and simplify NEON implementation
Date:   Mon, 26 Sep 2022 17:36:07 +0800
Message-Id: <20220926093620.99898-4-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
References: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
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

This patch does not add new features. The main work is to refactor and
simplify the implementation of SM4 NEON, which is reflected in the
following aspects:

The accelerated implementation supports the arbitrary number of blocks,
not just multiples of 8, which simplifies the implementation and brings
some optimization acceleration for data that is not aligned by 8 blocks.

When loading the input data, use the ld4 instruction to replace the
original ld1 instruction as much as possible, which will save the cost
of matrix transposition of the input data.

Use 8-block parallelism whenever possible to speed up matrix transpose
and rotation operations, instead of up to 4-block parallelism.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/sm4-neon-core.S | 630 +++++++++++++++++++-----------
 arch/arm64/crypto/sm4-neon-glue.c | 172 +++-----
 2 files changed, 456 insertions(+), 346 deletions(-)

diff --git a/arch/arm64/crypto/sm4-neon-core.S b/arch/arm64/crypto/sm4-neon-core.S
index 3d5256b354d2..f295b4b7d70a 100644
--- a/arch/arm64/crypto/sm4-neon-core.S
+++ b/arch/arm64/crypto/sm4-neon-core.S
@@ -18,6 +18,11 @@
 #define RTMP2	v10
 #define RTMP3	v11
 
+#define RTMP4	v12
+#define RTMP5	v13
+#define RTMP6	v14
+#define RTMP7	v15
+
 #define RX0	v12
 #define RX1	v13
 #define RKEY	v14
@@ -25,7 +30,7 @@
 
 /* Helper macros. */
 
-#define PREPARE                                                 \
+#define SM4_PREPARE()                                           \
 	adr_l		x5, crypto_sm4_sbox;                    \
 	ld1		{v16.16b-v19.16b}, [x5], #64;           \
 	ld1		{v20.16b-v23.16b}, [x5], #64;           \
@@ -42,7 +47,25 @@
 	zip1		s2.2d, RTMP2.2d, RTMP3.2d;              \
 	zip2		s3.2d, RTMP2.2d, RTMP3.2d;
 
-#define rotate_clockwise_90(s0, s1, s2, s3)                     \
+#define transpose_4x4_2x(s0, s1, s2, s3, s4, s5, s6, s7)        \
+	zip1		RTMP0.4s, s0.4s, s1.4s;                 \
+	zip1		RTMP1.4s, s2.4s, s3.4s;                 \
+	zip2		RTMP2.4s, s0.4s, s1.4s;                 \
+	zip2		RTMP3.4s, s2.4s, s3.4s;                 \
+	zip1		RTMP4.4s, s4.4s, s5.4s;                 \
+	zip1		RTMP5.4s, s6.4s, s7.4s;                 \
+	zip2		RTMP6.4s, s4.4s, s5.4s;                 \
+	zip2		RTMP7.4s, s6.4s, s7.4s;                 \
+	zip1		s0.2d, RTMP0.2d, RTMP1.2d;              \
+	zip2		s1.2d, RTMP0.2d, RTMP1.2d;              \
+	zip1		s2.2d, RTMP2.2d, RTMP3.2d;              \
+	zip2		s3.2d, RTMP2.2d, RTMP3.2d;              \
+	zip1		s4.2d, RTMP4.2d, RTMP5.2d;              \
+	zip2		s5.2d, RTMP4.2d, RTMP5.2d;              \
+	zip1		s6.2d, RTMP6.2d, RTMP7.2d;              \
+	zip2		s7.2d, RTMP6.2d, RTMP7.2d;
+
+#define rotate_clockwise_4x4(s0, s1, s2, s3)                    \
 	zip1		RTMP0.4s, s1.4s, s0.4s;                 \
 	zip2		RTMP1.4s, s1.4s, s0.4s;                 \
 	zip1		RTMP2.4s, s3.4s, s2.4s;                 \
@@ -52,6 +75,24 @@
 	zip1		s2.2d, RTMP3.2d, RTMP1.2d;              \
 	zip2		s3.2d, RTMP3.2d, RTMP1.2d;
 
+#define rotate_clockwise_4x4_2x(s0, s1, s2, s3, s4, s5, s6, s7) \
+	zip1		RTMP0.4s, s1.4s, s0.4s;                 \
+	zip1		RTMP2.4s, s3.4s, s2.4s;                 \
+	zip2		RTMP1.4s, s1.4s, s0.4s;                 \
+	zip2		RTMP3.4s, s3.4s, s2.4s;                 \
+	zip1		RTMP4.4s, s5.4s, s4.4s;                 \
+	zip1		RTMP6.4s, s7.4s, s6.4s;                 \
+	zip2		RTMP5.4s, s5.4s, s4.4s;                 \
+	zip2		RTMP7.4s, s7.4s, s6.4s;                 \
+	zip1		s0.2d, RTMP2.2d, RTMP0.2d;              \
+	zip2		s1.2d, RTMP2.2d, RTMP0.2d;              \
+	zip1		s2.2d, RTMP3.2d, RTMP1.2d;              \
+	zip2		s3.2d, RTMP3.2d, RTMP1.2d;              \
+	zip1		s4.2d, RTMP6.2d, RTMP4.2d;              \
+	zip2		s5.2d, RTMP6.2d, RTMP4.2d;              \
+	zip1		s6.2d, RTMP7.2d, RTMP5.2d;              \
+	zip2		s7.2d, RTMP7.2d, RTMP5.2d;
+
 #define ROUND4(round, s0, s1, s2, s3)                           \
 	dup		RX0.4s, RKEY.s[round];                  \
 	/* rk ^ s1 ^ s2 ^ s3 */                                 \
@@ -87,14 +128,7 @@
 	/* s0 ^= RTMP3 */                                       \
 	eor		s0.16b, s0.16b, RTMP3.16b;
 
-#define SM4_CRYPT_BLK4(b0, b1, b2, b3)                          \
-	rev32		b0.16b, b0.16b;                         \
-	rev32		b1.16b, b1.16b;                         \
-	rev32		b2.16b, b2.16b;                         \
-	rev32		b3.16b, b3.16b;                         \
-                                                                \
-	transpose_4x4(b0, b1, b2, b3);                          \
-                                                                \
+#define SM4_CRYPT_BLK4_BE(b0, b1, b2, b3)                       \
 	mov		x6, 8;                                  \
 4:                                                              \
 	ld1		{RKEY.4s}, [x0], #16;                   \
@@ -107,15 +141,23 @@
                                                                 \
 	bne		4b;                                     \
                                                                 \
-	rotate_clockwise_90(b0, b1, b2, b3);                    \
 	rev32		b0.16b, b0.16b;                         \
 	rev32		b1.16b, b1.16b;                         \
 	rev32		b2.16b, b2.16b;                         \
 	rev32		b3.16b, b3.16b;                         \
                                                                 \
+	rotate_clockwise_4x4(b0, b1, b2, b3);                   \
+                                                                \
 	/* repoint to rkey */                                   \
 	sub		x0, x0, #128;
 
+#define SM4_CRYPT_BLK4(b0, b1, b2, b3)                          \
+	rev32		b0.16b, b0.16b;                         \
+	rev32		b1.16b, b1.16b;                         \
+	rev32		b2.16b, b2.16b;                         \
+	rev32		b3.16b, b3.16b;                         \
+	SM4_CRYPT_BLK4_BE(b0, b1, b2, b3);
+
 #define ROUND8(round, s0, s1, s2, s3, t0, t1, t2, t3)           \
 	/* rk ^ s1 ^ s2 ^ s3 */                                 \
 	dup		RX0.4s, RKEY.s[round];                  \
@@ -175,7 +217,7 @@
 	eor		s0.16b, s0.16b, RTMP0.16b;              \
 	eor		t0.16b, t0.16b, RTMP1.16b;
 
-#define SM4_CRYPT_BLK8(b0, b1, b2, b3, b4, b5, b6, b7)          \
+#define SM4_CRYPT_BLK8_norotate(b0, b1, b2, b3, b4, b5, b6, b7) \
 	rev32		b0.16b, b0.16b;                         \
 	rev32		b1.16b, b1.16b;                         \
 	rev32		b2.16b, b2.16b;                         \
@@ -185,9 +227,6 @@
 	rev32		b6.16b, b6.16b;                         \
 	rev32		b7.16b, b7.16b;                         \
                                                                 \
-	transpose_4x4(b0, b1, b2, b3);                          \
-	transpose_4x4(b4, b5, b6, b7);                          \
-                                                                \
 	mov		x6, 8;                                  \
 8:                                                              \
 	ld1		{RKEY.4s}, [x0], #16;                   \
@@ -200,8 +239,6 @@
                                                                 \
 	bne		8b;                                     \
                                                                 \
-	rotate_clockwise_90(b0, b1, b2, b3);                    \
-	rotate_clockwise_90(b4, b5, b6, b7);                    \
 	rev32		b0.16b, b0.16b;                         \
 	rev32		b1.16b, b1.16b;                         \
 	rev32		b2.16b, b2.16b;                         \
@@ -214,274 +251,429 @@
 	/* repoint to rkey */                                   \
 	sub		x0, x0, #128;
 
+#define SM4_CRYPT_BLK8(b0, b1, b2, b3, b4, b5, b6, b7)			\
+	SM4_CRYPT_BLK8_norotate(b0, b1, b2, b3, b4, b5, b6, b7);	\
+	rotate_clockwise_4x4_2x(b0, b1, b2, b3, b4, b5, b6, b7);	\
 
-.align 3
-SYM_FUNC_START_LOCAL(__sm4_neon_crypt_blk1_4)
-	/* input:
-	 *   x0: round key array, CTX
-	 *   x1: dst
-	 *   x2: src
-	 *   w3: num blocks (1..4)
-	 */
-	PREPARE;
-
-	ld1		{v0.16b}, [x2], #16;
-	mov		v1.16b, v0.16b;
-	mov		v2.16b, v0.16b;
-	mov		v3.16b, v0.16b;
-	cmp		w3, #2;
-	blt		.Lblk4_load_input_done;
-	ld1		{v1.16b}, [x2], #16;
-	beq		.Lblk4_load_input_done;
-	ld1		{v2.16b}, [x2], #16;
-	cmp		w3, #3;
-	beq		.Lblk4_load_input_done;
-	ld1		{v3.16b}, [x2];
-
-.Lblk4_load_input_done:
-	SM4_CRYPT_BLK4(v0, v1, v2, v3);
-
-	st1		{v0.16b}, [x1], #16;
-	cmp		w3, #2;
-	blt		.Lblk4_store_output_done;
-	st1		{v1.16b}, [x1], #16;
-	beq		.Lblk4_store_output_done;
-	st1		{v2.16b}, [x1], #16;
-	cmp		w3, #3;
-	beq		.Lblk4_store_output_done;
-	st1		{v3.16b}, [x1];
-
-.Lblk4_store_output_done:
-	ret;
-SYM_FUNC_END(__sm4_neon_crypt_blk1_4)
 
 .align 3
-SYM_FUNC_START(sm4_neon_crypt_blk1_8)
+SYM_FUNC_START(sm4_neon_crypt)
 	/* input:
 	 *   x0: round key array, CTX
 	 *   x1: dst
 	 *   x2: src
-	 *   w3: num blocks (1..8)
+	 *   w3: nblocks
 	 */
-	cmp		w3, #5;
-	blt		__sm4_neon_crypt_blk1_4;
-
-	PREPARE;
-
-	ld1		{v0.16b-v3.16b}, [x2], #64;
-	ld1		{v4.16b}, [x2], #16;
-	mov		v5.16b, v4.16b;
-	mov		v6.16b, v4.16b;
-	mov		v7.16b, v4.16b;
-	beq		.Lblk8_load_input_done;
-	ld1		{v5.16b}, [x2], #16;
-	cmp		w3, #7;
-	blt		.Lblk8_load_input_done;
-	ld1		{v6.16b}, [x2], #16;
-	beq		.Lblk8_load_input_done;
-	ld1		{v7.16b}, [x2];
-
-.Lblk8_load_input_done:
-	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
-
-	cmp		w3, #6;
-	st1		{v0.16b-v3.16b}, [x1], #64;
-	st1		{v4.16b}, [x1], #16;
-	blt		.Lblk8_store_output_done;
-	st1		{v5.16b}, [x1], #16;
-	beq		.Lblk8_store_output_done;
-	st1		{v6.16b}, [x1], #16;
-	cmp		w3, #7;
-	beq		.Lblk8_store_output_done;
-	st1		{v7.16b}, [x1];
-
-.Lblk8_store_output_done:
-	ret;
-SYM_FUNC_END(sm4_neon_crypt_blk1_8)
+	SM4_PREPARE()
 
-.align 3
-SYM_FUNC_START(sm4_neon_crypt_blk8)
-	/* input:
-	 *   x0: round key array, CTX
-	 *   x1: dst
-	 *   x2: src
-	 *   w3: nblocks (multiples of 8)
-	 */
-	PREPARE;
+.Lcrypt_loop_8x:
+	sub		w3, w3, #8
+	tbnz		w3, #31, .Lcrypt_4x
+
+	ld4		{v0.4s-v3.4s}, [x2], #64
+	ld4		{v4.4s-v7.4s}, [x2], #64
 
-.Lcrypt_loop_blk:
-	subs		w3, w3, #8;
-	bmi		.Lcrypt_end;
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7)
 
-	ld1		{v0.16b-v3.16b}, [x2], #64;
-	ld1		{v4.16b-v7.16b}, [x2], #64;
+	st1		{v0.16b-v3.16b}, [x1], #64
+	st1		{v4.16b-v7.16b}, [x1], #64
 
-	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+	cbz		w3, .Lcrypt_end
+	b		.Lcrypt_loop_8x
 
-	st1		{v0.16b-v3.16b}, [x1], #64;
-	st1		{v4.16b-v7.16b}, [x1], #64;
+.Lcrypt_4x:
+	add		w3, w3, #8
+	cmp		w3, #4
+	blt		.Lcrypt_tail
 
-	b		.Lcrypt_loop_blk;
+	sub		w3, w3, #4
+
+	ld4		{v0.4s-v3.4s}, [x2], #64
+
+	SM4_CRYPT_BLK4(v0, v1, v2, v3)
+
+	st1		{v0.16b-v3.16b}, [x1], #64
+
+	cbz		w3, .Lcrypt_end
+
+.Lcrypt_tail:
+	cmp		w3, #2
+	ld1		{v0.16b}, [x2], #16
+	blt		.Lcrypt_tail_load_done
+	ld1		{v1.16b}, [x2], #16
+	beq		.Lcrypt_tail_load_done
+	ld1		{v2.16b}, [x2], #16
+
+.Lcrypt_tail_load_done:
+	transpose_4x4(v0, v1, v2, v3)
+
+	SM4_CRYPT_BLK4(v0, v1, v2, v3)
+
+	cmp		w3, #2
+	st1		{v0.16b}, [x1], #16
+	blt		.Lcrypt_end
+	st1		{v1.16b}, [x1], #16
+	beq		.Lcrypt_end
+	st1		{v2.16b}, [x1], #16
 
 .Lcrypt_end:
-	ret;
-SYM_FUNC_END(sm4_neon_crypt_blk8)
+	ret
+SYM_FUNC_END(sm4_neon_crypt)
 
 .align 3
-SYM_FUNC_START(sm4_neon_cbc_dec_blk8)
+SYM_FUNC_START(sm4_neon_cbc_dec)
 	/* input:
 	 *   x0: round key array, CTX
 	 *   x1: dst
 	 *   x2: src
 	 *   x3: iv (big endian, 128 bit)
-	 *   w4: nblocks (multiples of 8)
+	 *   w4: nblocks
 	 */
-	PREPARE;
+	SM4_PREPARE()
+
+	ld1		{RIV.16b}, [x3]
+
+.Lcbc_dec_loop_8x:
+	sub		w4, w4, #8
+	tbnz		w4, #31, .Lcbc_dec_4x
+
+	ld4		{v0.4s-v3.4s}, [x2], #64
+	ld4		{v4.4s-v7.4s}, [x2]
+
+	SM4_CRYPT_BLK8_norotate(v0, v1, v2, v3, v4, v5, v6, v7)
+
+	/* Avoid overwriting the RIV register */
+	rotate_clockwise_4x4(v0, v1, v2, v3)
+	rotate_clockwise_4x4(v4, v5, v6, v7)
+
+	sub		x2, x2, #64
+
+	eor		v0.16b, v0.16b, RIV.16b
 
-	ld1		{RIV.16b}, [x3];
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64
+	ld1		{RTMP4.16b-RTMP7.16b}, [x2], #64
 
-.Lcbc_loop_blk:
-	subs		w4, w4, #8;
-	bmi		.Lcbc_end;
+	eor		v1.16b, v1.16b, RTMP0.16b
+	eor		v2.16b, v2.16b, RTMP1.16b
+	eor		v3.16b, v3.16b, RTMP2.16b
+	eor		v4.16b, v4.16b, RTMP3.16b
+	eor		v5.16b, v5.16b, RTMP4.16b
+	eor		v6.16b, v6.16b, RTMP5.16b
+	eor		v7.16b, v7.16b, RTMP6.16b
 
-	ld1		{v0.16b-v3.16b}, [x2], #64;
-	ld1		{v4.16b-v7.16b}, [x2];
+	mov		RIV.16b, RTMP7.16b
 
-	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+	st1		{v0.16b-v3.16b}, [x1], #64
+	st1		{v4.16b-v7.16b}, [x1], #64
 
-	sub		x2, x2, #64;
-	eor		v0.16b, v0.16b, RIV.16b;
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v1.16b, v1.16b, RTMP0.16b;
-	eor		v2.16b, v2.16b, RTMP1.16b;
-	eor		v3.16b, v3.16b, RTMP2.16b;
-	st1		{v0.16b-v3.16b}, [x1], #64;
+	cbz		w4, .Lcbc_dec_end
+	b		.Lcbc_dec_loop_8x
 
-	eor		v4.16b, v4.16b, RTMP3.16b;
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v5.16b, v5.16b, RTMP0.16b;
-	eor		v6.16b, v6.16b, RTMP1.16b;
-	eor		v7.16b, v7.16b, RTMP2.16b;
+.Lcbc_dec_4x:
+	add		w4, w4, #8
+	cmp		w4, #4
+	blt		.Lcbc_dec_tail
 
-	mov		RIV.16b, RTMP3.16b;
-	st1		{v4.16b-v7.16b}, [x1], #64;
+	sub		w4, w4, #4
 
-	b		.Lcbc_loop_blk;
+	ld1		{v0.16b-v3.16b}, [x2], #64
 
-.Lcbc_end:
+	rev32		v4.16b, v0.16b
+	rev32		v5.16b, v1.16b
+	rev32		v6.16b, v2.16b
+	rev32		v7.16b, v3.16b
+
+	transpose_4x4(v4, v5, v6, v7)
+
+	SM4_CRYPT_BLK4_BE(v4, v5, v6, v7)
+
+	eor		v4.16b, v4.16b, RIV.16b
+	eor		v5.16b, v5.16b, v0.16b
+	eor		v6.16b, v6.16b, v1.16b
+	eor		v7.16b, v7.16b, v2.16b
+
+	mov		RIV.16b, v3.16b
+
+	st1		{v4.16b-v7.16b}, [x1], #64
+
+	cbz		w4, .Lcbc_dec_end
+
+.Lcbc_dec_tail:
+	cmp		w4, #2
+	ld1		{v0.16b}, [x2], #16
+	blt		.Lcbc_dec_tail_load_done
+	ld1		{v1.16b}, [x2], #16
+	beq		.Lcbc_dec_tail_load_done
+	ld1		{v2.16b}, [x2], #16
+
+.Lcbc_dec_tail_load_done:
+	rev32		v4.16b, v0.16b
+	rev32		v5.16b, v1.16b
+	rev32		v6.16b, v2.16b
+
+	transpose_4x4(v4, v5, v6, v7)
+
+	SM4_CRYPT_BLK4_BE(v4, v5, v6, v7)
+
+	cmp		w4, #2
+	eor		v4.16b, v4.16b, RIV.16b
+	mov		RIV.16b, v0.16b
+	st1		{v4.16b}, [x1], #16
+	blt		.Lcbc_dec_end
+
+	eor		v5.16b, v5.16b, v0.16b
+	mov		RIV.16b, v1.16b
+	st1		{v5.16b}, [x1], #16
+	beq		.Lcbc_dec_end
+
+	eor		v6.16b, v6.16b, v1.16b
+	mov		RIV.16b, v2.16b
+	st1		{v6.16b}, [x1], #16
+
+.Lcbc_dec_end:
 	/* store new IV */
-	st1		{RIV.16b}, [x3];
+	st1		{RIV.16b}, [x3]
 
-	ret;
-SYM_FUNC_END(sm4_neon_cbc_dec_blk8)
+	ret
+SYM_FUNC_END(sm4_neon_cbc_dec)
 
 .align 3
-SYM_FUNC_START(sm4_neon_cfb_dec_blk8)
+SYM_FUNC_START(sm4_neon_cfb_dec)
 	/* input:
 	 *   x0: round key array, CTX
 	 *   x1: dst
 	 *   x2: src
 	 *   x3: iv (big endian, 128 bit)
-	 *   w4: nblocks (multiples of 8)
+	 *   w4: nblocks
 	 */
-	PREPARE;
+	SM4_PREPARE()
+
+	ld1		{v0.16b}, [x3]
+
+.Lcfb_dec_loop_8x:
+	sub		w4, w4, #8
+	tbnz		w4, #31, .Lcfb_dec_4x
+
+	ld1		{v1.16b-v3.16b}, [x2], #48
+	ld4		{v4.4s-v7.4s}, [x2]
+
+	transpose_4x4(v0, v1, v2, v3)
+
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7)
+
+	sub		x2, x2, #48
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64
+	ld1		{RTMP4.16b-RTMP7.16b}, [x2], #64
+
+	eor		v0.16b, v0.16b, RTMP0.16b
+	eor		v1.16b, v1.16b, RTMP1.16b
+	eor		v2.16b, v2.16b, RTMP2.16b
+	eor		v3.16b, v3.16b, RTMP3.16b
+	eor		v4.16b, v4.16b, RTMP4.16b
+	eor		v5.16b, v5.16b, RTMP5.16b
+	eor		v6.16b, v6.16b, RTMP6.16b
+	eor		v7.16b, v7.16b, RTMP7.16b
+
+	st1		{v0.16b-v3.16b}, [x1], #64
+	st1		{v4.16b-v7.16b}, [x1], #64
+
+	mov		v0.16b, RTMP7.16b
+
+	cbz		w4, .Lcfb_dec_end
+	b		.Lcfb_dec_loop_8x
+
+.Lcfb_dec_4x:
+	add		w4, w4, #8
+	cmp		w4, #4
+	blt		.Lcfb_dec_tail
+
+	sub		w4, w4, #4
+
+	ld1		{v4.16b-v7.16b}, [x2], #64
+
+	rev32		v0.16b, v0.16b		/* v0 is IV register */
+	rev32		v1.16b, v4.16b
+	rev32		v2.16b, v5.16b
+	rev32		v3.16b, v6.16b
+
+	transpose_4x4(v0, v1, v2, v3)
+
+	SM4_CRYPT_BLK4_BE(v0, v1, v2, v3)
 
-	ld1		{v0.16b}, [x3];
+	eor		v0.16b, v0.16b, v4.16b
+	eor		v1.16b, v1.16b, v5.16b
+	eor		v2.16b, v2.16b, v6.16b
+	eor		v3.16b, v3.16b, v7.16b
 
-.Lcfb_loop_blk:
-	subs		w4, w4, #8;
-	bmi		.Lcfb_end;
+	st1		{v0.16b-v3.16b}, [x1], #64
 
-	ld1		{v1.16b, v2.16b, v3.16b}, [x2], #48;
-	ld1		{v4.16b-v7.16b}, [x2];
+	mov		v0.16b, v7.16b
 
-	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
+	cbz		w4, .Lcfb_dec_end
 
-	sub		x2, x2, #48;
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v0.16b, v0.16b, RTMP0.16b;
-	eor		v1.16b, v1.16b, RTMP1.16b;
-	eor		v2.16b, v2.16b, RTMP2.16b;
-	eor		v3.16b, v3.16b, RTMP3.16b;
-	st1		{v0.16b-v3.16b}, [x1], #64;
+.Lcfb_dec_tail:
+	cmp		w4, #2
+	ld1		{v4.16b}, [x2], #16
+	blt		.Lcfb_dec_tail_load_done
+	ld1		{v5.16b}, [x2], #16
+	beq		.Lcfb_dec_tail_load_done
+	ld1		{v6.16b}, [x2], #16
 
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v4.16b, v4.16b, RTMP0.16b;
-	eor		v5.16b, v5.16b, RTMP1.16b;
-	eor		v6.16b, v6.16b, RTMP2.16b;
-	eor		v7.16b, v7.16b, RTMP3.16b;
-	st1		{v4.16b-v7.16b}, [x1], #64;
+.Lcfb_dec_tail_load_done:
+	rev32		v0.16b, v0.16b		/* v0 is IV register */
+	rev32		v1.16b, v4.16b
+	rev32		v2.16b, v5.16b
 
-	mov		v0.16b, RTMP3.16b;
+	transpose_4x4(v0, v1, v2, v3)
 
-	b		.Lcfb_loop_blk;
+	SM4_CRYPT_BLK4_BE(v0, v1, v2, v3)
 
-.Lcfb_end:
+	cmp		w4, #2
+	eor		v0.16b, v0.16b, v4.16b
+	st1		{v0.16b}, [x1], #16
+	mov		v0.16b, v4.16b
+	blt		.Lcfb_dec_end
+
+	eor		v1.16b, v1.16b, v5.16b
+	st1		{v1.16b}, [x1], #16
+	mov		v0.16b, v5.16b
+	beq		.Lcfb_dec_end
+
+	eor		v2.16b, v2.16b, v6.16b
+	st1		{v2.16b}, [x1], #16
+	mov		v0.16b, v6.16b
+
+.Lcfb_dec_end:
 	/* store new IV */
-	st1		{v0.16b}, [x3];
+	st1		{v0.16b}, [x3]
 
-	ret;
-SYM_FUNC_END(sm4_neon_cfb_dec_blk8)
+	ret
+SYM_FUNC_END(sm4_neon_cfb_dec)
 
 .align 3
-SYM_FUNC_START(sm4_neon_ctr_enc_blk8)
+SYM_FUNC_START(sm4_neon_ctr_crypt)
 	/* input:
 	 *   x0: round key array, CTX
 	 *   x1: dst
 	 *   x2: src
 	 *   x3: ctr (big endian, 128 bit)
-	 *   w4: nblocks (multiples of 8)
+	 *   w4: nblocks
 	 */
-	PREPARE;
+	SM4_PREPARE()
 
-	ldp		x7, x8, [x3];
-	rev		x7, x7;
-	rev		x8, x8;
+	ldp		x7, x8, [x3]
+	rev		x7, x7
+	rev		x8, x8
 
-.Lctr_loop_blk:
-	subs		w4, w4, #8;
-	bmi		.Lctr_end;
+.Lctr_crypt_loop_8x:
+	sub		w4, w4, #8
+	tbnz		w4, #31, .Lctr_crypt_4x
 
-#define inc_le128(vctr)                     \
-	mov		vctr.d[1], x8;      \
-	mov		vctr.d[0], x7;      \
-	adds		x8, x8, #1;         \
-	adc		x7, x7, xzr;        \
-	rev64		vctr.16b, vctr.16b;
+#define inc_le128(vctr)                             \
+		mov		vctr.d[1], x8;      \
+		mov		vctr.d[0], x7;      \
+		adds		x8, x8, #1;         \
+		rev64		vctr.16b, vctr.16b; \
+		adc		x7, x7, xzr;
 
 	/* construct CTRs */
-	inc_le128(v0);			/* +0 */
-	inc_le128(v1);			/* +1 */
-	inc_le128(v2);			/* +2 */
-	inc_le128(v3);			/* +3 */
-	inc_le128(v4);			/* +4 */
-	inc_le128(v5);			/* +5 */
-	inc_le128(v6);			/* +6 */
-	inc_le128(v7);			/* +7 */
-
-	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7);
-
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v0.16b, v0.16b, RTMP0.16b;
-	eor		v1.16b, v1.16b, RTMP1.16b;
-	eor		v2.16b, v2.16b, RTMP2.16b;
-	eor		v3.16b, v3.16b, RTMP3.16b;
-	st1		{v0.16b-v3.16b}, [x1], #64;
-
-	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64;
-	eor		v4.16b, v4.16b, RTMP0.16b;
-	eor		v5.16b, v5.16b, RTMP1.16b;
-	eor		v6.16b, v6.16b, RTMP2.16b;
-	eor		v7.16b, v7.16b, RTMP3.16b;
-	st1		{v4.16b-v7.16b}, [x1], #64;
-
-	b		.Lctr_loop_blk;
-
-.Lctr_end:
+	inc_le128(v0)			/* +0 */
+	inc_le128(v1)			/* +1 */
+	inc_le128(v2)			/* +2 */
+	inc_le128(v3)			/* +3 */
+	inc_le128(v4)			/* +4 */
+	inc_le128(v5)			/* +5 */
+	inc_le128(v6)			/* +6 */
+	inc_le128(v7)			/* +7 */
+
+	transpose_4x4_2x(v0, v1, v2, v3, v4, v5, v6, v7)
+
+	SM4_CRYPT_BLK8(v0, v1, v2, v3, v4, v5, v6, v7)
+
+	ld1		{RTMP0.16b-RTMP3.16b}, [x2], #64
+	ld1		{RTMP4.16b-RTMP7.16b}, [x2], #64
+
+	eor		v0.16b, v0.16b, RTMP0.16b
+	eor		v1.16b, v1.16b, RTMP1.16b
+	eor		v2.16b, v2.16b, RTMP2.16b
+	eor		v3.16b, v3.16b, RTMP3.16b
+	eor		v4.16b, v4.16b, RTMP4.16b
+	eor		v5.16b, v5.16b, RTMP5.16b
+	eor		v6.16b, v6.16b, RTMP6.16b
+	eor		v7.16b, v7.16b, RTMP7.16b
+
+	st1		{v0.16b-v3.16b}, [x1], #64
+	st1		{v4.16b-v7.16b}, [x1], #64
+
+	cbz		w4, .Lctr_crypt_end
+	b		.Lctr_crypt_loop_8x
+
+.Lctr_crypt_4x:
+	add		w4, w4, #8
+	cmp		w4, #4
+	blt		.Lctr_crypt_tail
+
+	sub		w4, w4, #4
+
+	/* construct CTRs */
+	inc_le128(v0)			/* +0 */
+	inc_le128(v1)			/* +1 */
+	inc_le128(v2)			/* +2 */
+	inc_le128(v3)			/* +3 */
+
+	ld1		{v4.16b-v7.16b}, [x2], #64
+
+	transpose_4x4(v0, v1, v2, v3)
+
+	SM4_CRYPT_BLK4(v0, v1, v2, v3)
+
+	eor		v0.16b, v0.16b, v4.16b
+	eor		v1.16b, v1.16b, v5.16b
+	eor		v2.16b, v2.16b, v6.16b
+	eor		v3.16b, v3.16b, v7.16b
+
+	st1		{v0.16b-v3.16b}, [x1], #64
+
+	cbz		w4, .Lctr_crypt_end
+
+.Lctr_crypt_tail:
+	/* inc_le128 will change the sign bit */
+	ld1		{v4.16b}, [x2], #16
+	inc_le128(v0)
+	cmp		w4, #2
+	blt		.Lctr_crypt_tail_load_done
+
+	ld1		{v5.16b}, [x2], #16
+	inc_le128(v1)
+	cmp		w4, #2
+	beq		.Lctr_crypt_tail_load_done
+
+	ld1		{v6.16b}, [x2], #16
+	inc_le128(v2)
+
+.Lctr_crypt_tail_load_done:
+	transpose_4x4(v0, v1, v2, v3)
+
+	SM4_CRYPT_BLK4(v0, v1, v2, v3)
+
+	cmp		w4, #2
+
+	eor		v0.16b, v0.16b, v4.16b
+	st1		{v0.16b}, [x1], #16
+	blt		.Lctr_crypt_end
+
+	eor		v1.16b, v1.16b, v5.16b
+	st1		{v1.16b}, [x1], #16
+	beq		.Lctr_crypt_end
+
+	eor		v2.16b, v2.16b, v6.16b
+	st1		{v2.16b}, [x1], #16
+
+.Lctr_crypt_end:
 	/* store new CTR */
-	rev		x7, x7;
-	rev		x8, x8;
-	stp		x7, x8, [x3];
+	rev		x7, x7
+	rev		x8, x8
+	stp		x7, x8, [x3]
 
-	ret;
-SYM_FUNC_END(sm4_neon_ctr_enc_blk8)
+	ret
+SYM_FUNC_END(sm4_neon_ctr_crypt)
diff --git a/arch/arm64/crypto/sm4-neon-glue.c b/arch/arm64/crypto/sm4-neon-glue.c
index 03a6a6866a31..7b19accf5c03 100644
--- a/arch/arm64/crypto/sm4-neon-glue.c
+++ b/arch/arm64/crypto/sm4-neon-glue.c
@@ -18,19 +18,14 @@
 #include <crypto/internal/skcipher.h>
 #include <crypto/sm4.h>
 
-#define BYTES2BLKS(nbytes)	((nbytes) >> 4)
-#define BYTES2BLK8(nbytes)	(((nbytes) >> 4) & ~(8 - 1))
-
-asmlinkage void sm4_neon_crypt_blk1_8(const u32 *rkey, u8 *dst, const u8 *src,
-				      unsigned int nblks);
-asmlinkage void sm4_neon_crypt_blk8(const u32 *rkey, u8 *dst, const u8 *src,
-				    unsigned int nblks);
-asmlinkage void sm4_neon_cbc_dec_blk8(const u32 *rkey, u8 *dst, const u8 *src,
-				      u8 *iv, unsigned int nblks);
-asmlinkage void sm4_neon_cfb_dec_blk8(const u32 *rkey, u8 *dst, const u8 *src,
-				      u8 *iv, unsigned int nblks);
-asmlinkage void sm4_neon_ctr_enc_blk8(const u32 *rkey, u8 *dst, const u8 *src,
-				      u8 *iv, unsigned int nblks);
+asmlinkage void sm4_neon_crypt(const u32 *rkey, u8 *dst, const u8 *src,
+			       unsigned int nblocks);
+asmlinkage void sm4_neon_cbc_dec(const u32 *rkey_dec, u8 *dst, const u8 *src,
+				 u8 *iv, unsigned int nblocks);
+asmlinkage void sm4_neon_cfb_dec(const u32 *rkey_enc, u8 *dst, const u8 *src,
+				 u8 *iv, unsigned int nblocks);
+asmlinkage void sm4_neon_ctr_crypt(const u32 *rkey_enc, u8 *dst, const u8 *src,
+				   u8 *iv, unsigned int nblocks);
 
 static int sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
 		      unsigned int key_len)
@@ -51,27 +46,18 @@ static int sm4_ecb_do_crypt(struct skcipher_request *req, const u32 *rkey)
 	while ((nbytes = walk.nbytes) > 0) {
 		const u8 *src = walk.src.virt.addr;
 		u8 *dst = walk.dst.virt.addr;
-		unsigned int nblks;
+		unsigned int nblocks;
 
-		kernel_neon_begin();
+		nblocks = nbytes / SM4_BLOCK_SIZE;
+		if (nblocks) {
+			kernel_neon_begin();
 
-		nblks = BYTES2BLK8(nbytes);
-		if (nblks) {
-			sm4_neon_crypt_blk8(rkey, dst, src, nblks);
-			dst += nblks * SM4_BLOCK_SIZE;
-			src += nblks * SM4_BLOCK_SIZE;
-			nbytes -= nblks * SM4_BLOCK_SIZE;
-		}
+			sm4_neon_crypt(rkey, dst, src, nblocks);
 
-		nblks = BYTES2BLKS(nbytes);
-		if (nblks) {
-			sm4_neon_crypt_blk1_8(rkey, dst, src, nblks);
-			nbytes -= nblks * SM4_BLOCK_SIZE;
+			kernel_neon_end();
 		}
 
-		kernel_neon_end();
-
-		err = skcipher_walk_done(&walk, nbytes);
+		err = skcipher_walk_done(&walk, nbytes % SM4_BLOCK_SIZE);
 	}
 
 	return err;
@@ -138,48 +124,19 @@ static int sm4_cbc_decrypt(struct skcipher_request *req)
 	while ((nbytes = walk.nbytes) > 0) {
 		const u8 *src = walk.src.virt.addr;
 		u8 *dst = walk.dst.virt.addr;
-		unsigned int nblks;
+		unsigned int nblocks;
 
-		kernel_neon_begin();
+		nblocks = nbytes / SM4_BLOCK_SIZE;
+		if (nblocks) {
+			kernel_neon_begin();
 
-		nblks = BYTES2BLK8(nbytes);
-		if (nblks) {
-			sm4_neon_cbc_dec_blk8(ctx->rkey_dec, dst, src,
-					walk.iv, nblks);
-			dst += nblks * SM4_BLOCK_SIZE;
-			src += nblks * SM4_BLOCK_SIZE;
-			nbytes -= nblks * SM4_BLOCK_SIZE;
-		}
+			sm4_neon_cbc_dec(ctx->rkey_dec, dst, src,
+					 walk.iv, nblocks);
 
-		nblks = BYTES2BLKS(nbytes);
-		if (nblks) {
-			u8 keystream[SM4_BLOCK_SIZE * 8];
-			u8 iv[SM4_BLOCK_SIZE];
-			int i;
-
-			sm4_neon_crypt_blk1_8(ctx->rkey_dec, keystream,
-					src, nblks);
-
-			src += ((int)nblks - 2) * SM4_BLOCK_SIZE;
-			dst += (nblks - 1) * SM4_BLOCK_SIZE;
-			memcpy(iv, src + SM4_BLOCK_SIZE, SM4_BLOCK_SIZE);
-
-			for (i = nblks - 1; i > 0; i--) {
-				crypto_xor_cpy(dst, src,
-					&keystream[i * SM4_BLOCK_SIZE],
-					SM4_BLOCK_SIZE);
-				src -= SM4_BLOCK_SIZE;
-				dst -= SM4_BLOCK_SIZE;
-			}
-			crypto_xor_cpy(dst, walk.iv,
-					keystream, SM4_BLOCK_SIZE);
-			memcpy(walk.iv, iv, SM4_BLOCK_SIZE);
-			nbytes -= nblks * SM4_BLOCK_SIZE;
+			kernel_neon_end();
 		}
 
-		kernel_neon_end();
-
-		err = skcipher_walk_done(&walk, nbytes);
+		err = skcipher_walk_done(&walk, nbytes % SM4_BLOCK_SIZE);
 	}
 
 	return err;
@@ -238,41 +195,21 @@ static int sm4_cfb_decrypt(struct skcipher_request *req)
 	while ((nbytes = walk.nbytes) > 0) {
 		const u8 *src = walk.src.virt.addr;
 		u8 *dst = walk.dst.virt.addr;
-		unsigned int nblks;
+		unsigned int nblocks;
 
-		kernel_neon_begin();
+		nblocks = nbytes / SM4_BLOCK_SIZE;
+		if (nblocks) {
+			kernel_neon_begin();
 
-		nblks = BYTES2BLK8(nbytes);
-		if (nblks) {
-			sm4_neon_cfb_dec_blk8(ctx->rkey_enc, dst, src,
-					walk.iv, nblks);
-			dst += nblks * SM4_BLOCK_SIZE;
-			src += nblks * SM4_BLOCK_SIZE;
-			nbytes -= nblks * SM4_BLOCK_SIZE;
-		}
+			sm4_neon_cfb_dec(ctx->rkey_enc, dst, src,
+					 walk.iv, nblocks);
 
-		nblks = BYTES2BLKS(nbytes);
-		if (nblks) {
-			u8 keystream[SM4_BLOCK_SIZE * 8];
-
-			memcpy(keystream, walk.iv, SM4_BLOCK_SIZE);
-			if (nblks > 1)
-				memcpy(&keystream[SM4_BLOCK_SIZE], src,
-					(nblks - 1) * SM4_BLOCK_SIZE);
-			memcpy(walk.iv, src + (nblks - 1) * SM4_BLOCK_SIZE,
-				SM4_BLOCK_SIZE);
-
-			sm4_neon_crypt_blk1_8(ctx->rkey_enc, keystream,
-					keystream, nblks);
-
-			crypto_xor_cpy(dst, src, keystream,
-					nblks * SM4_BLOCK_SIZE);
-			dst += nblks * SM4_BLOCK_SIZE;
-			src += nblks * SM4_BLOCK_SIZE;
-			nbytes -= nblks * SM4_BLOCK_SIZE;
-		}
+			kernel_neon_end();
 
-		kernel_neon_end();
+			dst += nblocks * SM4_BLOCK_SIZE;
+			src += nblocks * SM4_BLOCK_SIZE;
+			nbytes -= nblocks * SM4_BLOCK_SIZE;
+		}
 
 		/* tail */
 		if (walk.nbytes == walk.total && nbytes > 0) {
@@ -302,40 +239,21 @@ static int sm4_ctr_crypt(struct skcipher_request *req)
 	while ((nbytes = walk.nbytes) > 0) {
 		const u8 *src = walk.src.virt.addr;
 		u8 *dst = walk.dst.virt.addr;
-		unsigned int nblks;
+		unsigned int nblocks;
 
-		kernel_neon_begin();
+		nblocks = nbytes / SM4_BLOCK_SIZE;
+		if (nblocks) {
+			kernel_neon_begin();
 
-		nblks = BYTES2BLK8(nbytes);
-		if (nblks) {
-			sm4_neon_ctr_enc_blk8(ctx->rkey_enc, dst, src,
-					walk.iv, nblks);
-			dst += nblks * SM4_BLOCK_SIZE;
-			src += nblks * SM4_BLOCK_SIZE;
-			nbytes -= nblks * SM4_BLOCK_SIZE;
-		}
+			sm4_neon_ctr_crypt(ctx->rkey_enc, dst, src,
+					   walk.iv, nblocks);
 
-		nblks = BYTES2BLKS(nbytes);
-		if (nblks) {
-			u8 keystream[SM4_BLOCK_SIZE * 8];
-			int i;
-
-			for (i = 0; i < nblks; i++) {
-				memcpy(&keystream[i * SM4_BLOCK_SIZE],
-					walk.iv, SM4_BLOCK_SIZE);
-				crypto_inc(walk.iv, SM4_BLOCK_SIZE);
-			}
-			sm4_neon_crypt_blk1_8(ctx->rkey_enc, keystream,
-					keystream, nblks);
-
-			crypto_xor_cpy(dst, src, keystream,
-					nblks * SM4_BLOCK_SIZE);
-			dst += nblks * SM4_BLOCK_SIZE;
-			src += nblks * SM4_BLOCK_SIZE;
-			nbytes -= nblks * SM4_BLOCK_SIZE;
-		}
+			kernel_neon_end();
 
-		kernel_neon_end();
+			dst += nblocks * SM4_BLOCK_SIZE;
+			src += nblocks * SM4_BLOCK_SIZE;
+			nbytes -= nblocks * SM4_BLOCK_SIZE;
+		}
 
 		/* tail */
 		if (walk.nbytes == walk.total && nbytes > 0) {
-- 
2.24.3 (Apple Git-128)

