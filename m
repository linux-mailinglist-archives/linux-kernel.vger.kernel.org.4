Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10274F3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjGKPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjGKPjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:39:18 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5D51BCF;
        Tue, 11 Jul 2023 08:38:22 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJFR0-0000g0-8J; Tue, 11 Jul 2023 17:37:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, heiko@sntech.de,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, ebiggers@kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 06/12] RISC-V: crypto: add Zvbb+Zvbc accelerated GCM GHASH implementation
Date:   Tue, 11 Jul 2023 17:37:37 +0200
Message-Id: <20230711153743.1970625-7-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711153743.1970625-1-heiko@sntech.de>
References: <20230711153743.1970625-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Add a gcm hash implementation using the Zvbb+Zvbc crypto extensions.
It gets possibly registered alongside the Zbc-based variant, with a higher
priority so that the crypto subsystem will be able to select the most
performant variant, but the algorithm itself will still be part of the
crypto selftests that run during registration.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/Kconfig                    |   3 +-
 arch/riscv/crypto/Makefile                   |   8 +-
 arch/riscv/crypto/ghash-riscv64-glue.c       | 150 ++++++++
 arch/riscv/crypto/ghash-riscv64-zvbb-zvbc.pl | 380 +++++++++++++++++++
 4 files changed, 539 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvbb-zvbc.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index cd2237923e68..41b8fdfe1d92 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -4,7 +4,7 @@ menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
 
 config CRYPTO_GHASH_RISCV64
 	tristate "Hash functions: GHASH"
-	depends on 64BIT && RISCV_ISA_ZBC
+	depends on 64BIT && (RISCV_ISA_ZBC || RISCV_ISA_V)
 	select CRYPTO_HASH
 	select CRYPTO_LIB_GF128MUL
 	help
@@ -14,5 +14,6 @@ config CRYPTO_GHASH_RISCV64
 	  - Zbc extension
 	  - Zbc + Zbb extensions
 	  - Zbc + Zbkb extensions
+	  - Zvbb vector crypto extension
 
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 0a158919e9da..81190941ba78 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -8,6 +8,9 @@ ghash-riscv64-y := ghash-riscv64-glue.o
 ifdef CONFIG_RISCV_ISA_ZBC
 ghash-riscv64-y += ghash-riscv64-zbc.o
 endif
+ifdef CONFIG_RISCV_ISA_V
+ghash-riscv64-y += ghash-riscv64-zvbb-zvbc.o
+endif
 
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
@@ -15,4 +18,7 @@ quiet_cmd_perlasm = PERLASM $@
 $(obj)/ghash-riscv64-zbc.S: $(src)/ghash-riscv64-zbc.pl
 	$(call cmd,perlasm)
 
-clean-files += ghash-riscv64-zbc.S
+$(obj)/ghash-riscv64-zvbb-zvbc.S: $(src)/ghash-riscv64-zvbb-zvbc.pl
+	$(call cmd,perlasm)
+
+clean-files += ghash-riscv64-zbc.S ghash-riscv64-zvkb.S
diff --git a/arch/riscv/crypto/ghash-riscv64-glue.c b/arch/riscv/crypto/ghash-riscv64-glue.c
index 695bed6c54cb..2bfd1934d55b 100644
--- a/arch/riscv/crypto/ghash-riscv64-glue.c
+++ b/arch/riscv/crypto/ghash-riscv64-glue.c
@@ -11,6 +11,7 @@
 #include <linux/crypto.h>
 #include <linux/module.h>
 #include <asm/simd.h>
+#include <asm/vector.h>
 #include <crypto/ghash.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/simd.h>
@@ -21,6 +22,9 @@ struct riscv64_ghash_ctx {
 
 	/* key used by vector asm */
 	u128 htable[16];
+
+	/* key used by software fallback */
+	be128 key;
 };
 
 struct riscv64_ghash_desc_ctx {
@@ -38,6 +42,142 @@ static int riscv64_ghash_init(struct shash_desc *desc)
 	return 0;
 }
 
+#ifdef CONFIG_RISCV_ISA_V
+
+void gcm_init_rv64i_zvbb_zvbc(u128 Htable[16], const u64 Xi[2]);
+
+void gcm_ghash_rv64i_zvbb_zvbc(u64 Xi[2], const u128 Htable[16],
+			       const u8 *inp, size_t len);
+
+static int riscv64_zvk_ghash_setkey_zvbb_zvbc(struct crypto_shash *tfm,
+					      const u8 *key,
+					      unsigned int keylen)
+{
+	struct riscv64_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(tfm));
+	const u64 k[2] = { cpu_to_be64(((const u64 *)key)[0]),
+			   cpu_to_be64(((const u64 *)key)[1]) };
+
+	if (keylen != GHASH_BLOCK_SIZE)
+		return -EINVAL;
+
+	memcpy(&ctx->key, key, GHASH_BLOCK_SIZE);
+	kernel_rvv_begin();
+	gcm_init_rv64i_zvbb_zvbc(ctx->htable, k);
+	kernel_rvv_end();
+
+	ctx->ghash_func = gcm_ghash_rv64i_zvbb_zvbc;
+
+	return 0;
+}
+
+static inline void __ghash_block(struct riscv64_ghash_ctx *ctx,
+				 struct riscv64_ghash_desc_ctx *dctx)
+{
+	if (crypto_simd_usable()) {
+		kernel_rvv_begin();
+		ctx->ghash_func(dctx->shash, ctx->htable,
+				dctx->buffer, GHASH_DIGEST_SIZE);
+		kernel_rvv_end();
+	} else {
+		crypto_xor((u8 *)dctx->shash, dctx->buffer, GHASH_BLOCK_SIZE);
+		gf128mul_lle((be128 *)dctx->shash, &ctx->key);
+	}
+}
+
+static inline void __ghash_blocks(struct riscv64_ghash_ctx *ctx,
+				  struct riscv64_ghash_desc_ctx *dctx,
+				  const u8 *src, unsigned int srclen)
+{
+	if (crypto_simd_usable()) {
+		kernel_rvv_begin();
+		ctx->ghash_func(dctx->shash, ctx->htable,
+				src, srclen);
+		kernel_rvv_end();
+	} else {
+		while (srclen >= GHASH_BLOCK_SIZE) {
+			crypto_xor((u8 *)dctx->shash, src, GHASH_BLOCK_SIZE);
+			gf128mul_lle((be128 *)dctx->shash, &ctx->key);
+			srclen -= GHASH_BLOCK_SIZE;
+			src += GHASH_BLOCK_SIZE;
+		}
+	}
+}
+
+static int riscv64_zvk_ghash_update(struct shash_desc *desc,
+			   const u8 *src, unsigned int srclen)
+{
+	unsigned int len;
+	struct riscv64_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	if (dctx->bytes) {
+		if (dctx->bytes + srclen < GHASH_DIGEST_SIZE) {
+			memcpy(dctx->buffer + dctx->bytes, src,
+				srclen);
+			dctx->bytes += srclen;
+			return 0;
+		}
+		memcpy(dctx->buffer + dctx->bytes, src,
+			GHASH_DIGEST_SIZE - dctx->bytes);
+
+		__ghash_block(ctx, dctx);
+
+		src += GHASH_DIGEST_SIZE - dctx->bytes;
+		srclen -= GHASH_DIGEST_SIZE - dctx->bytes;
+		dctx->bytes = 0;
+	}
+	len = srclen & ~(GHASH_DIGEST_SIZE - 1);
+
+	if (len) {
+		__ghash_blocks(ctx, dctx, src, len);
+		src += len;
+		srclen -= len;
+	}
+
+	if (srclen) {
+		memcpy(dctx->buffer, src, srclen);
+		dctx->bytes = srclen;
+	}
+	return 0;
+}
+
+static int riscv64_zvk_ghash_final(struct shash_desc *desc, u8 *out)
+{
+	struct riscv64_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+	int i;
+
+	if (dctx->bytes) {
+		for (i = dctx->bytes; i < GHASH_DIGEST_SIZE; i++)
+			dctx->buffer[i] = 0;
+		__ghash_block(ctx, dctx);
+		dctx->bytes = 0;
+	}
+
+	memcpy(out, dctx->shash, GHASH_DIGEST_SIZE);
+	return 0;
+}
+
+struct shash_alg riscv64_zvbb_zvbc_ghash_alg = {
+	.digestsize = GHASH_DIGEST_SIZE,
+	.init = riscv64_ghash_init,
+	.update = riscv64_zvk_ghash_update,
+	.final = riscv64_zvk_ghash_final,
+	.setkey = riscv64_zvk_ghash_setkey_zvbb_zvbc,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx)
+		    + sizeof(struct ghash_desc_ctx),
+	.base = {
+		 .cra_name = "ghash",
+		 .cra_driver_name = "riscv64_zvbb_zvbc_ghash",
+		 .cra_priority = 300,
+		 .cra_blocksize = GHASH_BLOCK_SIZE,
+		 .cra_ctxsize = sizeof(struct riscv64_ghash_ctx),
+		 .cra_module = THIS_MODULE,
+	},
+};
+
+#endif /* CONFIG_RISCV_ISA_V */
+
 #ifdef CONFIG_RISCV_ISA_ZBC
 
 void gcm_init_rv64i_zbc(u128 Htable[16], const u64 Xi[2]);
@@ -269,6 +409,16 @@ static int __init riscv64_ghash_mod_init(void)
 	}
 #endif
 
+#ifdef CONFIG_RISCV_ISA_V
+	if (riscv_isa_extension_available(NULL, ZVBB) && 
+	    riscv_isa_extension_available(NULL, ZVBC) &&
+	    riscv_vector_vlen() >= 128) {
+		ret = riscv64_ghash_register(&riscv64_zvbb_zvbc_ghash_alg);
+		if (ret < 0)
+			return ret;
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/arch/riscv/crypto/ghash-riscv64-zvbb-zvbc.pl b/arch/riscv/crypto/ghash-riscv64-zvbb-zvbc.pl
new file mode 100644
index 000000000000..2b7475324c83
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-zvbb-zvbc.pl
@@ -0,0 +1,380 @@
+#! /usr/bin/env perl
+# SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause
+#
+# This file is dual-licensed, meaning that you can use it under your
+# choice of either of the following two licenses:
+#
+# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License"). You can obtain
+# a copy in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+#
+# or
+#
+# Copyright (c) 2023, Christoph Müllner <christoph.muellner@vrull.eu>
+# All rights reserved.
+#
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions
+# are met:
+# 1. Redistributions of source code must retain the above copyright
+#    notice, this list of conditions and the following disclaimer.
+# 2. Redistributions in binary form must reproduce the above copyright
+#    notice, this list of conditions and the following disclaimer in the
+#    documentation and/or other materials provided with the distribution.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+# - RV64I
+# - RISC-V vector ('V') with VLEN >= 128
+# - Vector Bit-manipulation used in Cryptography ('Zvbb')
+# - Vector Carryless Multiplication ('Zvbc')
+
+use strict;
+use warnings;
+
+use FindBin qw($Bin);
+use lib "$Bin";
+use lib "$Bin/../../perlasm";
+use riscv;
+
+# $output is the last argument if it looks like a file (it has an extension)
+# $flavour is the first argument if it doesn't look like a file
+my $output = $#ARGV >= 0 && $ARGV[$#ARGV] =~ m|\.\w+$| ? pop : undef;
+my $flavour = $#ARGV >= 0 && $ARGV[0] !~ m|\.| ? shift : undef;
+
+$output and open STDOUT,">$output";
+
+my $code=<<___;
+.text
+___
+
+################################################################################
+# void gcm_init_rv64i_zvbb_zvbc(u128 Htable[16], const u64 H[2]);
+#
+# input:	H: 128-bit H - secret parameter E(K, 0^128)
+# output:	Htable: Preprocessed key data for gcm_gmult_rv64i_zvbb_zvbc and
+#                       gcm_ghash_rv64i_zvbb_zvbc
+{
+my ($Htable,$H,$TMP0,$TMP1,$TMP2) = ("a0","a1","t0","t1","t2");
+my ($V0,$V1,$V2,$V3,$V4,$V5,$V6) = ("v0","v1","v2","v3","v4","v5","v6");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_init_rv64i_zvbb_zvbc
+.type gcm_init_rv64i_zvbb_zvbc,\@function
+gcm_init_rv64i_zvbb_zvbc:
+    # Load/store data in reverse order.
+    # This is needed as a part of endianness swap.
+    add $H, $H, 8
+    li $TMP0, -8
+    li $TMP1, 63
+    la $TMP2, Lpolymod
+
+    @{[vsetivli__x0_2_e64_m1_ta_ma]} # vsetivli x0, 2, e64, m1, ta, ma
+
+    @{[vlse64_v  $V1, $H, $TMP0]}    # vlse64.v v1, (a1), t0
+    @{[vle64_v $V2, $TMP2]}          # vle64.v v2, (t2)
+
+    # Shift one left and get the carry bits.
+    @{[vsrl_vx $V3, $V1, $TMP1]}     # vsrl.vx v3, v1, t1
+    @{[vsll_vi $V1, $V1, 1]}         # vsll.vi v1, v1, 1
+
+    # Use the fact that the polynomial degree is no more than 128,
+    # i.e. only the LSB of the upper half could be set.
+    # Thanks to this we don't need to do the full reduction here.
+    # Instead simply subtract the reduction polynomial.
+    # This idea was taken from x86 ghash implementation in OpenSSL.
+    @{[vslideup_vi $V4, $V3, 1]}     # vslideup.vi v4, v3, 1
+    @{[vslidedown_vi $V3, $V3, 1]}   # vslidedown.vi v3, v3, 1
+
+    @{[vmv_v_i $V0, 2]}              # vmv.v.i v0, 2
+    @{[vor_vv_v0t $V1, $V1, $V4]}    # vor.vv v1, v1, v4, v0.t
+
+    # Need to set the mask to 3, if the carry bit is set.
+    @{[vmv_v_v $V0, $V3]}            # vmv.v.v v0, v3
+    @{[vmv_v_i $V3, 0]}              # vmv.v.i v3, 0
+    @{[vmerge_vim $V3, $V3, 3]}      # vmerge.vim v3, v3, 3, v0
+    @{[vmv_v_v $V0, $V3]}            # vmv.v.v v0, v3
+
+    @{[vxor_vv_v0t $V1, $V1, $V2]}   # vxor.vv v1, v1, v2, v0.t
+
+    @{[vse64_v $V1, $Htable]}        # vse64.v v1, (a0)
+    ret
+.size gcm_init_rv64i_zvbb_zvbc,.-gcm_init_rv64i_zvbb_zvbc
+___
+}
+
+################################################################################
+# void gcm_gmult_rv64i_zvbb_zvbc(u64 Xi[2], const u128 Htable[16]);
+#
+# input:	Xi: current hash value
+#		Htable: preprocessed H
+# output:	Xi: next hash value Xi = (Xi * H mod f)
+{
+my ($Xi,$Htable,$TMP0,$TMP1,$TMP2,$TMP3,$TMP4) = ("a0","a1","t0","t1","t2","t3","t4");
+my ($V0,$V1,$V2,$V3,$V4,$V5,$V6) = ("v0","v1","v2","v3","v4","v5","v6");
+
+$code .= <<___;
+.text
+.p2align 3
+.globl gcm_gmult_rv64i_zvbb_zvbc
+.type gcm_gmult_rv64i_zvbb_zvbc,\@function
+gcm_gmult_rv64i_zvbb_zvbc:
+    ld $TMP0, ($Htable)
+    ld $TMP1, 8($Htable)
+    li $TMP2, 63
+    la $TMP3, Lpolymod
+    ld $TMP3, 8($TMP3)
+
+    # Load/store data in reverse order.
+    # This is needed as a part of endianness swap.
+    add $Xi, $Xi, 8
+    li $TMP4, -8
+
+    @{[vsetivli__x0_2_e64_m1_ta_ma]} # vsetivli x0, 2, e64, m1, ta, ma
+
+    @{[vlse64_v $V5, $Xi, $TMP4]}    # vlse64.v v5, (a0), t4
+    @{[vrev8_v $V5, $V5]}            # vrev8.v v5, v5
+
+    # Multiplication
+
+    # Do two 64x64 multiplications in one go to save some time
+    # and simplify things.
+
+    # A = a1a0 (t1, t0)
+    # B = b1b0 (v5)
+    # C = c1c0 (256 bit)
+    # c1 = a1b1 + (a0b1)h + (a1b0)h
+    # c0 = a0b0 + (a0b1)l + (a1b0)h
+
+    # v1 = (a0b1)l,(a0b0)l
+    @{[vclmul_vx $V1, $V5, $TMP0]}   # vclmul.vx v1, v5, t0
+    # v3 = (a0b1)h,(a0b0)h
+    @{[vclmulh_vx $V3, $V5, $TMP0]}  # vclmulh.vx v3, v5, t0
+
+    # v4 = (a1b1)l,(a1b0)l
+    @{[vclmul_vx $V4, $V5, $TMP1]}   # vclmul.vx v4, v5, t1
+    # v2 = (a1b1)h,(a1b0)h
+    @{[vclmulh_vx $V2, $V5, $TMP1]}   # vclmulh.vx v2, v5, t1
+
+    # Is there a better way to do this?
+    # Would need to swap the order of elements within a vector register.
+    @{[vslideup_vi $V5, $V3, 1]}     # vslideup.vi v5, v3, 1
+    @{[vslideup_vi $V6, $V4, 1]}     # vslideup.vi v6, v4, 1
+    @{[vslidedown_vi $V3, $V3, 1]}   # vslidedown.vi v3, v3, 1
+    @{[vslidedown_vi $V4, $V4, 1]}   # vslidedown.vi v4, v4, 1
+
+    @{[vmv_v_i $V0, 1]}              # vmv.v.i v0, 1
+    # v2 += (a0b1)h
+    @{[vxor_vv_v0t $V2, $V2, $V3]}   # vxor.vv v2, v2, v3, v0.t
+    # v2 += (a1b1)l
+    @{[vxor_vv_v0t $V2, $V2, $V4]}   # vxor.vv v2, v2, v4, v0.t
+
+    @{[vmv_v_i $V0, 2]}              # vmv.v.i v0, 2
+    # v1 += (a0b0)h,0
+    @{[vxor_vv_v0t $V1, $V1, $V5]}   # vxor.vv v1, v1, v5, v0.t
+    # v1 += (a1b0)l,0
+    @{[vxor_vv_v0t $V1, $V1, $V6]}   # vxor.vv v1, v1, v6, v0.t
+
+    # Now the 256bit product should be stored in (v2,v1)
+    # v1 = (a0b1)l + (a0b0)h + (a1b0)l, (a0b0)l
+    # v2 = (a1b1)h, (a1b0)h + (a0b1)h + (a1b1)l
+
+    # Reduction
+    # Let C := A*B = c3,c2,c1,c0 = v2[1],v2[0],v1[1],v1[0]
+    # This is a slight variation of the Gueron's Montgomery reduction.
+    # The difference being the order of some operations has been changed,
+    # to make a better use of vclmul(h) instructions.
+
+    # First step:
+    # c1 += (c0 * P)l
+    # vmv.v.i v0, 2
+    @{[vslideup_vi_v0t $V3, $V1, 1]} # vslideup.vi v3, v1, 1, v0.t
+    @{[vclmul_vx_v0t $V3, $V3, $TMP3]} # vclmul.vx v3, v3, t3, v0.t
+    @{[vxor_vv_v0t $V1, $V1, $V3]}   # vxor.vv v1, v1, v3, v0.t
+
+    # Second step:
+    # D = d1,d0 is final result
+    # We want:
+    # m1 = c1 + (c1 * P)h
+    # m0 = (c1 * P)l + (c0 * P)h + c0
+    # d1 = c3 + m1
+    # d0 = c2 + m0
+
+    #v3 = (c1 * P)l, 0
+    @{[vclmul_vx_v0t $V3, $V1, $TMP3]} # vclmul.vx v3, v1, t3, v0.t
+    #v4 = (c1 * P)h, (c0 * P)h
+    @{[vclmulh_vx $V4, $V1, $TMP3]}   # vclmulh.vx v4, v1, t3
+
+    @{[vmv_v_i $V0, 1]}              # vmv.v.i v0, 1
+    @{[vslidedown_vi $V3, $V3, 1]}   # vslidedown.vi v3, v3, 1
+
+    @{[vxor_vv $V1, $V1, $V4]}       # vxor.vv v1, v1, v4
+    @{[vxor_vv_v0t $V1, $V1, $V3]}   # vxor.vv v1, v1, v3, v0.t
+
+    # XOR in the upper upper part of the product
+    @{[vxor_vv $V2, $V2, $V1]}       # vxor.vv v2, v2, v1
+
+    @{[vrev8_v $V2, $V2]}            # vrev8.v v2, v2
+    @{[vsse64_v $V2, $Xi, $TMP4]}    # vsse64.v v2, (a0), t4
+    ret
+.size gcm_gmult_rv64i_zvbb_zvbc,.-gcm_gmult_rv64i_zvbb_zvbc
+___
+}
+
+################################################################################
+# void gcm_ghash_rv64i_zvbb_zvbc(u64 Xi[2], const u128 Htable[16],
+#                                const u8 *inp, size_t len);
+#
+# input:	Xi: current hash value
+#		Htable: preprocessed H
+#		inp: pointer to input data
+#		len: length of input data in bytes (mutiple of block size)
+# output:	Xi: Xi+1 (next hash value Xi)
+{
+my ($Xi,$Htable,$inp,$len,$TMP0,$TMP1,$TMP2,$TMP3,$M8,$TMP5,$TMP6) = ("a0","a1","a2","a3","t0","t1","t2","t3","t4","t5","t6");
+my ($V0,$V1,$V2,$V3,$V4,$V5,$V6,$Vinp) = ("v0","v1","v2","v3","v4","v5","v6","v7");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_ghash_rv64i_zvbb_zvbc
+.type gcm_ghash_rv64i_zvbb_zvbc,\@function
+gcm_ghash_rv64i_zvbb_zvbc:
+    ld $TMP0, ($Htable)
+    ld $TMP1, 8($Htable)
+    li $TMP2, 63
+    la $TMP3, Lpolymod
+    ld $TMP3, 8($TMP3)
+
+    # Load/store data in reverse order.
+    # This is needed as a part of endianness swap.
+    add $Xi, $Xi, 8
+    add $inp, $inp, 8
+    li $M8, -8
+
+    @{[vsetivli__x0_2_e64_m1_ta_ma]} # vsetivli x0, 2, e64, m1, ta, ma
+
+    @{[vlse64_v $V5, $Xi, $M8]}      # vlse64.v v5, (a0), t4
+
+Lstep:
+    # Read input data
+    @{[vlse64_v $Vinp, $inp, $M8]}   # vle64.v v0, (a2)
+    add $inp, $inp, 16
+    add $len, $len, -16
+    # XOR them into Xi
+    @{[vxor_vv $V5, $V5, $Vinp]}       # vxor.vv v0, v0, v1
+
+    @{[vrev8_v $V5, $V5]}            # vrev8.v v5, v5
+
+    # Multiplication
+
+    # Do two 64x64 multiplications in one go to save some time
+    # and simplify things.
+
+    # A = a1a0 (t1, t0)
+    # B = b1b0 (v5)
+    # C = c1c0 (256 bit)
+    # c1 = a1b1 + (a0b1)h + (a1b0)h
+    # c0 = a0b0 + (a0b1)l + (a1b0)h
+
+    # v1 = (a0b1)l,(a0b0)l
+    @{[vclmul_vx $V1, $V5, $TMP0]}   # vclmul.vx v1, v5, t0
+    # v3 = (a0b1)h,(a0b0)h
+    @{[vclmulh_vx $V3, $V5, $TMP0]}  # vclmulh.vx v3, v5, t0
+
+    # v4 = (a1b1)l,(a1b0)l
+    @{[vclmul_vx $V4, $V5, $TMP1]}   # vclmul.vx v4, v5, t1
+    # v2 = (a1b1)h,(a1b0)h
+    @{[vclmulh_vx $V2, $V5, $TMP1]}   # vclmulh.vx v2, v5, t1
+
+    # Is there a better way to do this?
+    # Would need to swap the order of elements within a vector register.
+    @{[vslideup_vi $V5, $V3, 1]}     # vslideup.vi v5, v3, 1
+    @{[vslideup_vi $V6, $V4, 1]}     # vslideup.vi v6, v4, 1
+    @{[vslidedown_vi $V3, $V3, 1]}   # vslidedown.vi v3, v3, 1
+    @{[vslidedown_vi $V4, $V4, 1]}   # vslidedown.vi v4, v4, 1
+
+    @{[vmv_v_i $V0, 1]}              # vmv.v.i v0, 1
+    # v2 += (a0b1)h
+    @{[vxor_vv_v0t $V2, $V2, $V3]}   # vxor.vv v2, v2, v3, v0.t
+    # v2 += (a1b1)l
+    @{[vxor_vv_v0t $V2, $V2, $V4]}   # vxor.vv v2, v2, v4, v0.t
+
+    @{[vmv_v_i $V0, 2]}              # vmv.v.i v0, 2
+    # v1 += (a0b0)h,0
+    @{[vxor_vv_v0t $V1, $V1, $V5]}   # vxor.vv v1, v1, v5, v0.t
+    # v1 += (a1b0)l,0
+    @{[vxor_vv_v0t $V1, $V1, $V6]}   # vxor.vv v1, v1, v6, v0.t
+
+    # Now the 256bit product should be stored in (v2,v1)
+    # v1 = (a0b1)l + (a0b0)h + (a1b0)l, (a0b0)l
+    # v2 = (a1b1)h, (a1b0)h + (a0b1)h + (a1b1)l
+
+    # Reduction
+    # Let C := A*B = c3,c2,c1,c0 = v2[1],v2[0],v1[1],v1[0]
+    # This is a slight variation of the Gueron's Montgomery reduction.
+    # The difference being the order of some operations has been changed,
+    # to make a better use of vclmul(h) instructions.
+
+    # First step:
+    # c1 += (c0 * P)l
+    # vmv.v.i v0, 2
+    @{[vslideup_vi_v0t $V3, $V1, 1]} # vslideup.vi v3, v1, 1, v0.t
+    @{[vclmul_vx_v0t $V3, $V3, $TMP3]} # vclmul.vx v3, v3, t3, v0.t
+    @{[vxor_vv_v0t $V1, $V1, $V3]}   # vxor.vv v1, v1, v3, v0.t
+
+    # Second step:
+    # D = d1,d0 is final result
+    # We want:
+    # m1 = c1 + (c1 * P)h
+    # m0 = (c1 * P)l + (c0 * P)h + c0
+    # d1 = c3 + m1
+    # d0 = c2 + m0
+
+    #v3 = (c1 * P)l, 0
+    @{[vclmul_vx_v0t $V3, $V1, $TMP3]} # vclmul.vx v3, v1, t3, v0.t
+    #v4 = (c1 * P)h, (c0 * P)h
+    @{[vclmulh_vx $V4, $V1, $TMP3]}   # vclmulh.vx v4, v1, t3
+
+    @{[vmv_v_i $V0, 1]}              # vmv.v.i v0, 1
+    @{[vslidedown_vi $V3, $V3, 1]}   # vslidedown.vi v3, v3, 1
+
+    @{[vxor_vv $V1, $V1, $V4]}       # vxor.vv v1, v1, v4
+    @{[vxor_vv_v0t $V1, $V1, $V3]}   # vxor.vv v1, v1, v3, v0.t
+
+    # XOR in the upper upper part of the product
+    @{[vxor_vv $V2, $V2, $V1]}       # vxor.vv v2, v2, v1
+
+    @{[vrev8_v $V5, $V2]}            # vrev8.v v2, v2
+
+    bnez $len, Lstep
+
+    @{[vsse64_v $V5, $Xi, $M8]}    # vsse64.v v2, (a0), t4
+    ret
+.size gcm_ghash_rv64i_zvbb_zvbc,.-gcm_ghash_rv64i_zvbb_zvbc
+___
+}
+
+$code .= <<___;
+.p2align 4
+Lpolymod:
+        .dword 0x0000000000000001
+        .dword 0xc200000000000000
+.size Lpolymod,.-Lpolymod
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.39.2

