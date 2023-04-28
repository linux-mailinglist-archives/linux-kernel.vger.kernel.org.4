Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCD26F1486
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345691AbjD1JwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjD1Jvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:51:53 -0400
Received: from out0-195.mail.aliyun.com (out0-195.mail.aliyun.com [140.205.0.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D72726;
        Fri, 28 Apr 2023 02:51:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.STCEPFd_1682675501;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STCEPFd_1682675501)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:51:42 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-crypto@vger.kernel.org>
Subject: [PATCH RFC 01/43] x86/crypto: Adapt assembly for PIE support
Date:   Fri, 28 Apr 2023 17:50:41 +0800
Message-Id: <ffe2eae6445ea61512789b24d45b4158cf648d2e.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Garnier <thgarnie@chromium.org>

From: Thomas Garnier <thgarnie@chromium.org>

Change the assembly code to use only relative references of symbols for
the kernel to be PIE compatible.

[Hou Wenlong: Adapt new assembly code in x86/crypto]

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Co-developed-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/aegis128-aesni-asm.S         |  6 +-
 arch/x86/crypto/aesni-intel_asm.S            |  2 +-
 arch/x86/crypto/aesni-intel_avx-x86_64.S     |  3 +-
 arch/x86/crypto/aria-aesni-avx-asm_64.S      | 30 +++---
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 30 +++---
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 30 +++---
 arch/x86/crypto/camellia-x86_64-asm_64.S     |  8 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S    | 50 +++++-----
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S    | 44 +++++----
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |  3 +-
 arch/x86/crypto/des3_ede-asm_64.S            | 96 +++++++++++++-------
 arch/x86/crypto/ghash-clmulni-intel_asm.S    |  4 +-
 arch/x86/crypto/sha256-avx2-asm.S            | 18 ++--
 13 files changed, 187 insertions(+), 137 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index cdf3215ec272..ad7f4c891625 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -201,8 +201,8 @@ SYM_FUNC_START(crypto_aegis128_aesni_init)
 	movdqa KEY, STATE4
 
 	/* load the constants: */
-	movdqa .Laegis128_const_0, STATE2
-	movdqa .Laegis128_const_1, STATE1
+	movdqa .Laegis128_const_0(%rip), STATE2
+	movdqa .Laegis128_const_1(%rip), STATE1
 	pxor STATE2, STATE3
 	pxor STATE1, STATE4
 
@@ -682,7 +682,7 @@ SYM_TYPED_FUNC_START(crypto_aegis128_aesni_dec_tail)
 	punpcklbw T0, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
-	movdqa .Laegis128_counter, T1
+	movdqa .Laegis128_counter(%rip), T1
 	pcmpgtb T1, T0
 	pand T0, MSG
 
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 837c1e0aa021..ca99a2274d55 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -2717,7 +2717,7 @@ SYM_FUNC_END(aesni_cts_cbc_dec)
  *	BSWAP_MASK == endian swapping mask
  */
 SYM_FUNC_START_LOCAL(_aesni_inc_init)
-	movaps .Lbswap_mask, BSWAP_MASK
+	movaps .Lbswap_mask(%rip), BSWAP_MASK
 	movaps IV, CTR
 	pshufb BSWAP_MASK, CTR
 	mov $1, TCTR_LOW
diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 0852ab573fd3..9f3a2fc56c24 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -649,7 +649,8 @@ _get_AAD_rest0\@:
 	vpshufb and an array of shuffle masks */
 	movq    %r12, %r11
 	salq    $4, %r11
-	vmovdqu  aad_shift_arr(%r11), \T1
+	leaq    aad_shift_arr(%rip), %rax
+	vmovdqu  (%rax,%r11,), \T1
 	vpshufb \T1, \T7, \T7
 _get_AAD_rest_final\@:
 	vpshufb SHUF_MASK(%rip), \T7, \T7
diff --git a/arch/x86/crypto/aria-aesni-avx-asm_64.S b/arch/x86/crypto/aria-aesni-avx-asm_64.S
index 9243f6289d34..e4f9b624d98c 100644
--- a/arch/x86/crypto/aria-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/aria-aesni-avx-asm_64.S
@@ -80,7 +80,7 @@
 	transpose_4x4(c0, c1, c2, c3, a0, a1);		\
 	transpose_4x4(d0, d1, d2, d3, a0, a1);		\
 							\
-	vmovdqu .Lshufb_16x16b, a0;			\
+	vmovdqu .Lshufb_16x16b(%rip), a0;		\
 	vmovdqu st1, a1;				\
 	vpshufb a0, a2, a2;				\
 	vpshufb a0, a3, a3;				\
@@ -132,7 +132,7 @@
 	transpose_4x4(c0, c1, c2, c3, a0, a1);		\
 	transpose_4x4(d0, d1, d2, d3, a0, a1);		\
 							\
-	vmovdqu .Lshufb_16x16b, a0;			\
+	vmovdqu .Lshufb_16x16b(%rip), a0;		\
 	vmovdqu st1, a1;				\
 	vpshufb a0, a2, a2;				\
 	vpshufb a0, a3, a3;				\
@@ -300,11 +300,11 @@
 			    x4, x5, x6, x7,		\
 			    t0, t1, t2, t3,		\
 			    t4, t5, t6, t7)		\
-	vmovdqa .Ltf_s2_bitmatrix, t0;			\
-	vmovdqa .Ltf_inv_bitmatrix, t1;			\
-	vmovdqa .Ltf_id_bitmatrix, t2;			\
-	vmovdqa .Ltf_aff_bitmatrix, t3;			\
-	vmovdqa .Ltf_x2_bitmatrix, t4;			\
+	vmovdqa .Ltf_s2_bitmatrix(%rip), t0;		\
+	vmovdqa .Ltf_inv_bitmatrix(%rip), t1;		\
+	vmovdqa .Ltf_id_bitmatrix(%rip), t2;		\
+	vmovdqa .Ltf_aff_bitmatrix(%rip), t3;		\
+	vmovdqa .Ltf_x2_bitmatrix(%rip), t4;		\
 	vgf2p8affineinvqb $(tf_s2_const), t0, x1, x1;	\
 	vgf2p8affineinvqb $(tf_s2_const), t0, x5, x5;	\
 	vgf2p8affineqb $(tf_inv_const), t1, x2, x2;	\
@@ -324,13 +324,13 @@
 		       x4, x5, x6, x7,			\
 		       t0, t1, t2, t3,			\
 		       t4, t5, t6, t7)			\
-	vmovdqa .Linv_shift_row, t0;			\
-	vmovdqa .Lshift_row, t1;			\
-	vbroadcastss .L0f0f0f0f, t6;			\
-	vmovdqa .Ltf_lo__inv_aff__and__s2, t2;		\
-	vmovdqa .Ltf_hi__inv_aff__and__s2, t3;		\
-	vmovdqa .Ltf_lo__x2__and__fwd_aff, t4;		\
-	vmovdqa .Ltf_hi__x2__and__fwd_aff, t5;		\
+	vmovdqa .Linv_shift_row(%rip), t0;		\
+	vmovdqa .Lshift_row(%rip), t1;			\
+	vpbroadcastd .L0f0f0f0f(%rip), t6;		\
+	vmovdqa .Ltf_lo__inv_aff__and__s2(%rip), t2;	\
+	vmovdqa .Ltf_hi__inv_aff__and__s2(%rip), t3;	\
+	vmovdqa .Ltf_lo__x2__and__fwd_aff(%rip), t4;	\
+	vmovdqa .Ltf_hi__x2__and__fwd_aff(%rip), t5;	\
 							\
 	vaesenclast t7, x0, x0;				\
 	vaesenclast t7, x4, x4;				\
@@ -1035,7 +1035,7 @@ SYM_FUNC_START_LOCAL(__aria_aesni_avx_ctr_gen_keystream_16way)
 	/* load IV and byteswap */
 	vmovdqu (%r8), %xmm8;
 
-	vmovdqa .Lbswap128_mask (%rip), %xmm1;
+	vmovdqa .Lbswap128_mask(%rip), %xmm1;
 	vpshufb %xmm1, %xmm8, %xmm3; /* be => le */
 
 	vpcmpeqd %xmm0, %xmm0, %xmm0;
diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
index 4a30618281ec..646477a13e11 100644
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -52,10 +52,10 @@
 	/* \
 	 * S-function with AES subbytes \
 	 */ \
-	vmovdqa .Linv_shift_row, t4; \
-	vbroadcastss .L0f0f0f0f, t7; \
-	vmovdqa .Lpre_tf_lo_s1, t0; \
-	vmovdqa .Lpre_tf_hi_s1, t1; \
+	vmovdqa .Linv_shift_row(%rip), t4; \
+	vbroadcastss .L0f0f0f0f(%rip), t7; \
+	vmovdqa .Lpre_tf_lo_s1(%rip), t0; \
+	vmovdqa .Lpre_tf_hi_s1(%rip), t1; \
 	\
 	/* AES inverse shift rows */ \
 	vpshufb t4, x0, x0; \
@@ -68,8 +68,8 @@
 	vpshufb t4, x6, x6; \
 	\
 	/* prefilter sboxes 1, 2 and 3 */ \
-	vmovdqa .Lpre_tf_lo_s4, t2; \
-	vmovdqa .Lpre_tf_hi_s4, t3; \
+	vmovdqa .Lpre_tf_lo_s4(%rip), t2; \
+	vmovdqa .Lpre_tf_hi_s4(%rip), t3; \
 	filter_8bit(x0, t0, t1, t7, t6); \
 	filter_8bit(x7, t0, t1, t7, t6); \
 	filter_8bit(x1, t0, t1, t7, t6); \
@@ -83,8 +83,8 @@
 	filter_8bit(x6, t2, t3, t7, t6); \
 	\
 	/* AES subbytes + AES shift rows */ \
-	vmovdqa .Lpost_tf_lo_s1, t0; \
-	vmovdqa .Lpost_tf_hi_s1, t1; \
+	vmovdqa .Lpost_tf_lo_s1(%rip), t0; \
+	vmovdqa .Lpost_tf_hi_s1(%rip), t1; \
 	vaesenclast t4, x0, x0; \
 	vaesenclast t4, x7, x7; \
 	vaesenclast t4, x1, x1; \
@@ -95,16 +95,16 @@
 	vaesenclast t4, x6, x6; \
 	\
 	/* postfilter sboxes 1 and 4 */ \
-	vmovdqa .Lpost_tf_lo_s3, t2; \
-	vmovdqa .Lpost_tf_hi_s3, t3; \
+	vmovdqa .Lpost_tf_lo_s3(%rip), t2; \
+	vmovdqa .Lpost_tf_hi_s3(%rip), t3; \
 	filter_8bit(x0, t0, t1, t7, t6); \
 	filter_8bit(x7, t0, t1, t7, t6); \
 	filter_8bit(x3, t0, t1, t7, t6); \
 	filter_8bit(x6, t0, t1, t7, t6); \
 	\
 	/* postfilter sbox 3 */ \
-	vmovdqa .Lpost_tf_lo_s2, t4; \
-	vmovdqa .Lpost_tf_hi_s2, t5; \
+	vmovdqa .Lpost_tf_lo_s2(%rip), t4; \
+	vmovdqa .Lpost_tf_hi_s2(%rip), t5; \
 	filter_8bit(x2, t2, t3, t7, t6); \
 	filter_8bit(x5, t2, t3, t7, t6); \
 	\
@@ -443,7 +443,7 @@ SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	transpose_4x4(c0, c1, c2, c3, a0, a1); \
 	transpose_4x4(d0, d1, d2, d3, a0, a1); \
 	\
-	vmovdqu .Lshufb_16x16b, a0; \
+	vmovdqu .Lshufb_16x16b(%rip), a0; \
 	vmovdqu st1, a1; \
 	vpshufb a0, a2, a2; \
 	vpshufb a0, a3, a3; \
@@ -482,7 +482,7 @@ SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 #define inpack16_pre(x0, x1, x2, x3, x4, x5, x6, x7, y0, y1, y2, y3, y4, y5, \
 		     y6, y7, rio, key) \
 	vmovq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor 0 * 16(rio), x0, y7; \
 	vpxor 1 * 16(rio), x0, y6; \
@@ -533,7 +533,7 @@ SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	vmovdqu x0, stack_tmp0; \
 	\
 	vmovq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor x0, y7, y7; \
 	vpxor x0, y6, y6; \
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index deaf62aa73a6..a0eb94e53b1b 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -64,12 +64,12 @@
 	/* \
 	 * S-function with AES subbytes \
 	 */ \
-	vbroadcasti128 .Linv_shift_row, t4; \
-	vpbroadcastd .L0f0f0f0f, t7; \
-	vbroadcasti128 .Lpre_tf_lo_s1, t5; \
-	vbroadcasti128 .Lpre_tf_hi_s1, t6; \
-	vbroadcasti128 .Lpre_tf_lo_s4, t2; \
-	vbroadcasti128 .Lpre_tf_hi_s4, t3; \
+	vbroadcasti128 .Linv_shift_row(%rip), t4; \
+	vpbroadcastd .L0f0f0f0f(%rip), t7; \
+	vbroadcasti128 .Lpre_tf_lo_s1(%rip), t5; \
+	vbroadcasti128 .Lpre_tf_hi_s1(%rip), t6; \
+	vbroadcasti128 .Lpre_tf_lo_s4(%rip), t2; \
+	vbroadcasti128 .Lpre_tf_hi_s4(%rip), t3; \
 	\
 	/* AES inverse shift rows */ \
 	vpshufb t4, x0, x0; \
@@ -115,8 +115,8 @@
 	vinserti128 $1, t2##_x, x6, x6; \
 	vextracti128 $1, x1, t3##_x; \
 	vextracti128 $1, x4, t2##_x; \
-	vbroadcasti128 .Lpost_tf_lo_s1, t0; \
-	vbroadcasti128 .Lpost_tf_hi_s1, t1; \
+	vbroadcasti128 .Lpost_tf_lo_s1(%rip), t0; \
+	vbroadcasti128 .Lpost_tf_hi_s1(%rip), t1; \
 	vaesenclast t4##_x, x2##_x, x2##_x; \
 	vaesenclast t4##_x, t6##_x, t6##_x; \
 	vinserti128 $1, t6##_x, x2, x2; \
@@ -131,16 +131,16 @@
 	vinserti128 $1, t2##_x, x4, x4; \
 	\
 	/* postfilter sboxes 1 and 4 */ \
-	vbroadcasti128 .Lpost_tf_lo_s3, t2; \
-	vbroadcasti128 .Lpost_tf_hi_s3, t3; \
+	vbroadcasti128 .Lpost_tf_lo_s3(%rip), t2; \
+	vbroadcasti128 .Lpost_tf_hi_s3(%rip), t3; \
 	filter_8bit(x0, t0, t1, t7, t6); \
 	filter_8bit(x7, t0, t1, t7, t6); \
 	filter_8bit(x3, t0, t1, t7, t6); \
 	filter_8bit(x6, t0, t1, t7, t6); \
 	\
 	/* postfilter sbox 3 */ \
-	vbroadcasti128 .Lpost_tf_lo_s2, t4; \
-	vbroadcasti128 .Lpost_tf_hi_s2, t5; \
+	vbroadcasti128 .Lpost_tf_lo_s2(%rip), t4; \
+	vbroadcasti128 .Lpost_tf_hi_s2(%rip), t5; \
 	filter_8bit(x2, t2, t3, t7, t6); \
 	filter_8bit(x5, t2, t3, t7, t6); \
 	\
@@ -475,7 +475,7 @@ SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	transpose_4x4(c0, c1, c2, c3, a0, a1); \
 	transpose_4x4(d0, d1, d2, d3, a0, a1); \
 	\
-	vbroadcasti128 .Lshufb_16x16b, a0; \
+	vbroadcasti128 .Lshufb_16x16b(%rip), a0; \
 	vmovdqu st1, a1; \
 	vpshufb a0, a2, a2; \
 	vpshufb a0, a3, a3; \
@@ -514,7 +514,7 @@ SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 #define inpack32_pre(x0, x1, x2, x3, x4, x5, x6, x7, y0, y1, y2, y3, y4, y5, \
 		     y6, y7, rio, key) \
 	vpbroadcastq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor 0 * 32(rio), x0, y7; \
 	vpxor 1 * 32(rio), x0, y6; \
@@ -565,7 +565,7 @@ SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	vmovdqu x0, stack_tmp0; \
 	\
 	vpbroadcastq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor x0, y7, y7; \
 	vpxor x0, y6, y6; \
diff --git a/arch/x86/crypto/camellia-x86_64-asm_64.S b/arch/x86/crypto/camellia-x86_64-asm_64.S
index 347c059f5940..b7c822d813a8 100644
--- a/arch/x86/crypto/camellia-x86_64-asm_64.S
+++ b/arch/x86/crypto/camellia-x86_64-asm_64.S
@@ -77,11 +77,13 @@
 #define RXORbl %r9b
 
 #define xor2ror16(T0, T1, tmp1, tmp2, ab, dst) \
+	leaq T0(%rip), 			tmp1; \
 	movzbl ab ## bl,		tmp2 ## d; \
+	xorq (tmp1, tmp2, 8),		dst; \
+	leaq T1(%rip), 			tmp2; \
 	movzbl ab ## bh,		tmp1 ## d; \
-	rorq $16,			ab; \
-	xorq T0(, tmp2, 8),		dst; \
-	xorq T1(, tmp1, 8),		dst;
+	xorq (tmp2, tmp1, 8),		dst; \
+	rorq $16,			ab;
 
 /**********************************************************************
   1-way camellia
diff --git a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
index 0326a01503c3..438c404a03bc 100644
--- a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
@@ -83,16 +83,20 @@
 
 
 #define lookup_32bit(src, dst, op1, op2, op3, interleave_op, il_reg) \
-	movzbl		src ## bh,     RID1d;    \
-	movzbl		src ## bl,     RID2d;    \
-	shrq $16,	src;                     \
-	movl		s1(, RID1, 4), dst ## d; \
-	op1		s2(, RID2, 4), dst ## d; \
-	movzbl		src ## bh,     RID1d;    \
-	movzbl		src ## bl,     RID2d;    \
-	interleave_op(il_reg);			 \
-	op2		s3(, RID1, 4), dst ## d; \
-	op3		s4(, RID2, 4), dst ## d;
+	movzbl		src ## bh,       RID1d;    \
+	leaq		s1(%rip),        RID2;     \
+	movl		(RID2, RID1, 4), dst ## d; \
+	movzbl		src ## bl,       RID2d;    \
+	leaq		s2(%rip),        RID1;     \
+	op1		(RID1, RID2, 4), dst ## d; \
+	shrq $16,	src;                       \
+	movzbl		src ## bh,     RID1d;      \
+	leaq		s3(%rip),        RID2;     \
+	op2		(RID2, RID1, 4), dst ## d; \
+	movzbl		src ## bl,     RID2d;      \
+	leaq		s4(%rip),        RID1;     \
+	op3		(RID1, RID2, 4), dst ## d; \
+	interleave_op(il_reg);
 
 #define dummy(d) /* do nothing */
 
@@ -151,15 +155,15 @@
 	subround(l ## 3, r ## 3, l ## 4, r ## 4, f);
 
 #define enc_preload_rkr() \
-	vbroadcastss	.L16_mask,                RKR;      \
+	vbroadcastss	.L16_mask(%rip),          RKR;      \
 	/* add 16-bit rotation to key rotations (mod 32) */ \
 	vpxor		kr(CTX),                  RKR, RKR;
 
 #define dec_preload_rkr() \
-	vbroadcastss	.L16_mask,                RKR;      \
+	vbroadcastss	.L16_mask(%rip),          RKR;      \
 	/* add 16-bit rotation to key rotations (mod 32) */ \
 	vpxor		kr(CTX),                  RKR, RKR; \
-	vpshufb		.Lbswap128_mask,          RKR, RKR;
+	vpshufb		.Lbswap128_mask(%rip),    RKR, RKR;
 
 #define transpose_2x4(x0, x1, t0, t1) \
 	vpunpckldq		x1, x0, t0; \
@@ -235,9 +239,9 @@ SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 	enc_preload_rkr();
 
 	inpack_blocks(RL1, RR1, RTMP, RX, RKM);
@@ -271,7 +275,7 @@ SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 
 	outunpack_blocks(RR1, RL1, RTMP, RX, RKM);
 	outunpack_blocks(RR2, RL2, RTMP, RX, RKM);
@@ -308,9 +312,9 @@ SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 	dec_preload_rkr();
 
 	inpack_blocks(RL1, RR1, RTMP, RX, RKM);
@@ -341,7 +345,7 @@ SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 	round(RL, RR, 1, 2);
 	round(RR, RL, 0, 1);
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 	popq %rbx;
 	popq %r15;
 
@@ -504,8 +508,8 @@ SYM_FUNC_START(cast5_ctr_16way)
 
 	vpcmpeqd RKR, RKR, RKR;
 	vpaddq RKR, RKR, RKR; /* low: -2, high: -2 */
-	vmovdqa .Lbswap_iv_mask, R1ST;
-	vmovdqa .Lbswap128_mask, RKM;
+	vmovdqa .Lbswap_iv_mask(%rip), R1ST;
+	vmovdqa .Lbswap128_mask(%rip), RKM;
 
 	/* load IV and byteswap */
 	vmovq (%rcx), RX;
diff --git a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
index 82b716fd5dba..180fb9c78de2 100644
--- a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
@@ -83,16 +83,20 @@
 
 
 #define lookup_32bit(src, dst, op1, op2, op3, interleave_op, il_reg) \
-	movzbl		src ## bh,     RID1d;    \
-	movzbl		src ## bl,     RID2d;    \
-	shrq $16,	src;                     \
-	movl		s1(, RID1, 4), dst ## d; \
-	op1		s2(, RID2, 4), dst ## d; \
-	movzbl		src ## bh,     RID1d;    \
-	movzbl		src ## bl,     RID2d;    \
-	interleave_op(il_reg);			 \
-	op2		s3(, RID1, 4), dst ## d; \
-	op3		s4(, RID2, 4), dst ## d;
+	movzbl		src ## bh,       RID1d;    \
+	leaq		s1(%rip),        RID2;     \
+	movl		(RID2, RID1, 4), dst ## d; \
+	movzbl		src ## bl,       RID2d;    \
+	leaq		s2(%rip),        RID1;     \
+	op1		(RID1, RID2, 4), dst ## d; \
+	shrq $16,	src;                       \
+	movzbl		src ## bh,     RID1d;      \
+	leaq		s3(%rip),        RID2;     \
+	op2		(RID2, RID1, 4), dst ## d; \
+	movzbl		src ## bl,     RID2d;      \
+	leaq		s4(%rip),        RID1;     \
+	op3		(RID1, RID2, 4), dst ## d; \
+	interleave_op(il_reg);
 
 #define dummy(d) /* do nothing */
 
@@ -175,10 +179,10 @@
 	qop(RD, RC, 1);
 
 #define shuffle(mask) \
-	vpshufb		mask,            RKR, RKR;
+	vpshufb		mask(%rip),            RKR, RKR;
 
 #define preload_rkr(n, do_mask, mask) \
-	vbroadcastss	.L16_mask,                RKR;      \
+	vbroadcastss	.L16_mask(%rip),          RKR;      \
 	/* add 16-bit rotation to key rotations (mod 32) */ \
 	vpxor		(kr+n*16)(CTX),           RKR, RKR; \
 	do_mask(mask);
@@ -258,9 +262,9 @@ SYM_FUNC_START_LOCAL(__cast6_enc_blk8)
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 
 	inpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	inpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -284,7 +288,7 @@ SYM_FUNC_START_LOCAL(__cast6_enc_blk8)
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 
 	outunpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -306,9 +310,9 @@ SYM_FUNC_START_LOCAL(__cast6_dec_blk8)
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 
 	inpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	inpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -332,7 +336,7 @@ SYM_FUNC_START_LOCAL(__cast6_dec_blk8)
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 	outunpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
 
diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index ec35915f0901..5f843dce77f1 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -168,7 +168,8 @@ continue_block:
 	xor     crc2, crc2
 
 	## branch into array
-	mov	jump_table(,%rax,8), %bufp
+	leaq	jump_table(%rip), %bufp
+	mov	(%bufp,%rax,8), %bufp
 	JMP_NOSPEC bufp
 
 	################################################################
diff --git a/arch/x86/crypto/des3_ede-asm_64.S b/arch/x86/crypto/des3_ede-asm_64.S
index f4c760f4cade..cf21b998e77c 100644
--- a/arch/x86/crypto/des3_ede-asm_64.S
+++ b/arch/x86/crypto/des3_ede-asm_64.S
@@ -129,21 +129,29 @@
 	movzbl RW0bl, RT2d; \
 	movzbl RW0bh, RT3d; \
 	shrq $16, RW0; \
-	movq s8(, RT0, 8), RT0; \
-	xorq s6(, RT1, 8), to; \
+	leaq s8(%rip), RW1; \
+	movq (RW1, RT0, 8), RT0; \
+	leaq s6(%rip), RW1; \
+	xorq (RW1, RT1, 8), to; \
 	movzbl RW0bl, RL1d; \
 	movzbl RW0bh, RT1d; \
 	shrl $16, RW0d; \
-	xorq s4(, RT2, 8), RT0; \
-	xorq s2(, RT3, 8), to; \
+	leaq s4(%rip), RW1; \
+	xorq (RW1, RT2, 8), RT0; \
+	leaq s2(%rip), RW1; \
+	xorq (RW1, RT3, 8), to; \
 	movzbl RW0bl, RT2d; \
 	movzbl RW0bh, RT3d; \
-	xorq s7(, RL1, 8), RT0; \
-	xorq s5(, RT1, 8), to; \
-	xorq s3(, RT2, 8), RT0; \
+	leaq s7(%rip), RW1; \
+	xorq (RW1, RL1, 8), RT0; \
+	leaq s5(%rip), RW1; \
+	xorq (RW1, RT1, 8), to; \
+	leaq s3(%rip), RW1; \
+	xorq (RW1, RT2, 8), RT0; \
 	load_next_key(n, RW0); \
 	xorq RT0, to; \
-	xorq s1(, RT3, 8), to; \
+	leaq s1(%rip), RW1; \
+	xorq (RW1, RT3, 8), to; \
 
 #define load_next_key(n, RWx) \
 	movq (((n) + 1) * 8)(CTX), RWx;
@@ -355,65 +363,89 @@ SYM_FUNC_END(des3_ede_x86_64_crypt_blk)
 	movzbl RW0bl, RT3d; \
 	movzbl RW0bh, RT1d; \
 	shrq $16, RW0; \
-	xorq s8(, RT3, 8), to##0; \
-	xorq s6(, RT1, 8), to##0; \
+	leaq s8(%rip), RT2; \
+	xorq (RT2, RT3, 8), to##0; \
+	leaq s6(%rip), RT2; \
+	xorq (RT2, RT1, 8), to##0; \
 	movzbl RW0bl, RT3d; \
 	movzbl RW0bh, RT1d; \
 	shrq $16, RW0; \
-	xorq s4(, RT3, 8), to##0; \
-	xorq s2(, RT1, 8), to##0; \
+	leaq s4(%rip), RT2; \
+	xorq (RT2, RT3, 8), to##0; \
+	leaq s2(%rip), RT2; \
+	xorq (RT2, RT1, 8), to##0; \
 	movzbl RW0bl, RT3d; \
 	movzbl RW0bh, RT1d; \
 	shrl $16, RW0d; \
-	xorq s7(, RT3, 8), to##0; \
-	xorq s5(, RT1, 8), to##0; \
+	leaq s7(%rip), RT2; \
+	xorq (RT2, RT3, 8), to##0; \
+	leaq s5(%rip), RT2; \
+	xorq (RT2, RT1, 8), to##0; \
 	movzbl RW0bl, RT3d; \
 	movzbl RW0bh, RT1d; \
 	load_next_key(n, RW0); \
-	xorq s3(, RT3, 8), to##0; \
-	xorq s1(, RT1, 8), to##0; \
+	leaq s3(%rip), RT2; \
+	xorq (RT2, RT3, 8), to##0; \
+	leaq s1(%rip), RT2; \
+	xorq (RT2, RT1, 8), to##0; \
 		xorq from##1, RW1; \
 		movzbl RW1bl, RT3d; \
 		movzbl RW1bh, RT1d; \
 		shrq $16, RW1; \
-		xorq s8(, RT3, 8), to##1; \
-		xorq s6(, RT1, 8), to##1; \
+		leaq s8(%rip), RT2; \
+		xorq (RT2, RT3, 8), to##1; \
+		leaq s6(%rip), RT2; \
+		xorq (RT2, RT1, 8), to##1; \
 		movzbl RW1bl, RT3d; \
 		movzbl RW1bh, RT1d; \
 		shrq $16, RW1; \
-		xorq s4(, RT3, 8), to##1; \
-		xorq s2(, RT1, 8), to##1; \
+		leaq s4(%rip), RT2; \
+		xorq (RT2, RT3, 8), to##1; \
+		leaq s2(%rip), RT2; \
+		xorq (RT2, RT1, 8), to##1; \
 		movzbl RW1bl, RT3d; \
 		movzbl RW1bh, RT1d; \
 		shrl $16, RW1d; \
-		xorq s7(, RT3, 8), to##1; \
-		xorq s5(, RT1, 8), to##1; \
+		leaq s7(%rip), RT2; \
+		xorq (RT2, RT3, 8), to##1; \
+		leaq s5(%rip), RT2; \
+		xorq (RT2, RT1, 8), to##1; \
 		movzbl RW1bl, RT3d; \
 		movzbl RW1bh, RT1d; \
 		do_movq(RW0, RW1); \
-		xorq s3(, RT3, 8), to##1; \
-		xorq s1(, RT1, 8), to##1; \
+		leaq s3(%rip), RT2; \
+		xorq (RT2, RT3, 8), to##1; \
+		leaq s1(%rip), RT2; \
+		xorq (RT2, RT1, 8), to##1; \
 			xorq from##2, RW2; \
 			movzbl RW2bl, RT3d; \
 			movzbl RW2bh, RT1d; \
 			shrq $16, RW2; \
-			xorq s8(, RT3, 8), to##2; \
-			xorq s6(, RT1, 8), to##2; \
+			leaq s8(%rip), RT2; \
+			xorq (RT2, RT3, 8), to##2; \
+			leaq s6(%rip), RT2; \
+			xorq (RT2, RT1, 8), to##2; \
 			movzbl RW2bl, RT3d; \
 			movzbl RW2bh, RT1d; \
 			shrq $16, RW2; \
-			xorq s4(, RT3, 8), to##2; \
-			xorq s2(, RT1, 8), to##2; \
+			leaq s4(%rip), RT2; \
+			xorq (RT2, RT3, 8), to##2; \
+			leaq s2(%rip), RT2; \
+			xorq (RT2, RT1, 8), to##2; \
 			movzbl RW2bl, RT3d; \
 			movzbl RW2bh, RT1d; \
 			shrl $16, RW2d; \
-			xorq s7(, RT3, 8), to##2; \
-			xorq s5(, RT1, 8), to##2; \
+			leaq s7(%rip), RT2; \
+			xorq (RT2, RT3, 8), to##2; \
+			leaq s5(%rip), RT2; \
+			xorq (RT2, RT1, 8), to##2; \
 			movzbl RW2bl, RT3d; \
 			movzbl RW2bh, RT1d; \
 			do_movq(RW0, RW2); \
-			xorq s3(, RT3, 8), to##2; \
-			xorq s1(, RT1, 8), to##2;
+			leaq s3(%rip), RT2; \
+			xorq (RT2, RT3, 8), to##2; \
+			leaq s1(%rip), RT2; \
+			xorq (RT2, RT1, 8), to##2;
 
 #define __movq(src, dst) \
 	movq src, dst;
diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index 257ed9446f3e..99cb983ded9e 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -93,7 +93,7 @@ SYM_FUNC_START(clmul_ghash_mul)
 	FRAME_BEGIN
 	movups (%rdi), DATA
 	movups (%rsi), SHASH
-	movaps .Lbswap_mask, BSWAP
+	movaps .Lbswap_mask(%rip), BSWAP
 	pshufb BSWAP, DATA
 	call __clmul_gf128mul_ble
 	pshufb BSWAP, DATA
@@ -110,7 +110,7 @@ SYM_FUNC_START(clmul_ghash_update)
 	FRAME_BEGIN
 	cmp $16, %rdx
 	jb .Lupdate_just_ret	# check length
-	movaps .Lbswap_mask, BSWAP
+	movaps .Lbswap_mask(%rip), BSWAP
 	movups (%rdi), DATA
 	movups (%rcx), SHASH
 	pshufb BSWAP, DATA
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 3eada9416852..10a3396bad35 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -589,19 +589,23 @@ last_block_enter:
 
 .align 16
 loop1:
-	vpaddd	K256+0*32(SRND), X0, XFER
+	leaq	K256(%rip), INP
+	vpaddd	0*32(INP, SRND), X0, XFER
 	vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 0*32
 
-	vpaddd	K256+1*32(SRND), X0, XFER
+	leaq	K256(%rip), INP
+	vpaddd	1*32(INP, SRND), X0, XFER
 	vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 1*32
 
-	vpaddd	K256+2*32(SRND), X0, XFER
+	leaq	K256(%rip), INP
+	vpaddd	2*32(INP, SRND), X0, XFER
 	vmovdqa XFER, 2*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 2*32
 
-	vpaddd	K256+3*32(SRND), X0, XFER
+	leaq	K256(%rip), INP
+	vpaddd	3*32(INP, SRND), X0, XFER
 	vmovdqa XFER, 3*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 3*32
 
@@ -611,11 +615,13 @@ loop1:
 
 loop2:
 	## Do last 16 rounds with no scheduling
-	vpaddd	K256+0*32(SRND), X0, XFER
+	leaq	K256(%rip), INP
+	vpaddd	0*32(INP, SRND), X0, XFER
 	vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
 	DO_4ROUNDS	_XFER + 0*32
 
-	vpaddd	K256+1*32(SRND), X1, XFER
+	leaq	K256(%rip), INP
+	vpaddd	1*32(INP, SRND), X1, XFER
 	vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
 	DO_4ROUNDS	_XFER + 1*32
 	add	$2*32, SRND
-- 
2.31.1

