Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EDA6CDB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjC2OIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC2OIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:08:23 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9489C59F7;
        Wed, 29 Mar 2023 07:07:18 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1phWSB-0004ZJ-HZ; Wed, 29 Mar 2023 16:07:07 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 4/4] RISC-V: crypto: add accelerated GCM GHASH implementation
Date:   Wed, 29 Mar 2023 16:06:42 +0200
Message-Id: <20230329140642.2186644-5-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

With different sets of available extensions a number of different
implementation variants are possible. Quite a number of them are already
implemented in openSSL or are in the process of being implemented, so pick
the relevant openSSL coden and add suitable glue code similar to arm64 and
powerpc to use it for kernel-specific cryptography.

The prioritization of the algorithms follows the ifdef chain for the
assembly callbacks done in openssl but here algorithms will get registered
separately so that all of them can be part of the crypto selftests.

The crypto subsystem will select the most performant of all registered
algorithms on the running system but will selftest all registered ones.

In a first step this adds scalar variants using the Zbc, Zbb and
possible Zbkb (bitmanip crypto extension) and the perl implementation
stems from openSSL pull request on
    https://github.com/openssl/openssl/pull/20078

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/Kconfig              |  13 +
 arch/riscv/crypto/Makefile             |  14 +
 arch/riscv/crypto/ghash-riscv64-glue.c | 258 ++++++++++++++++
 arch/riscv/crypto/ghash-riscv64-zbc.pl | 400 +++++++++++++++++++++++++
 arch/riscv/crypto/riscv.pm             | 231 ++++++++++++++
 5 files changed, 916 insertions(+)
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zbc.pl
 create mode 100644 arch/riscv/crypto/riscv.pm

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 10d60edc0110..cd2237923e68 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -2,4 +2,17 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
 
+config CRYPTO_GHASH_RISCV64
+	tristate "Hash functions: GHASH"
+	depends on 64BIT && RISCV_ISA_ZBC
+	select CRYPTO_HASH
+	select CRYPTO_LIB_GF128MUL
+	help
+	  GCM GHASH function (NIST SP800-38D)
+
+	  Architecture: riscv64 using one of:
+	  - Zbc extension
+	  - Zbc + Zbb extensions
+	  - Zbc + Zbkb extensions
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index b3b6332c9f6d..0a158919e9da 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -2,3 +2,17 @@
 #
 # linux/arch/riscv/crypto/Makefile
 #
+
+obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
+ghash-riscv64-y := ghash-riscv64-glue.o
+ifdef CONFIG_RISCV_ISA_ZBC
+ghash-riscv64-y += ghash-riscv64-zbc.o
+endif
+
+quiet_cmd_perlasm = PERLASM $@
+      cmd_perlasm = $(PERL) $(<) void $(@)
+
+$(obj)/ghash-riscv64-zbc.S: $(src)/ghash-riscv64-zbc.pl
+	$(call cmd,perlasm)
+
+clean-files += ghash-riscv64-zbc.S
diff --git a/arch/riscv/crypto/ghash-riscv64-glue.c b/arch/riscv/crypto/ghash-riscv64-glue.c
new file mode 100644
index 000000000000..5ab704c49539
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-glue.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V optimized GHASH routines
+ *
+ * Copyright (C) 2023 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ */
+
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/crypto.h>
+#include <linux/module.h>
+#include <asm/simd.h>
+#include <crypto/ghash.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+
+/* Zbc (optional with zbkb improvements) */
+void gcm_ghash_rv64i_zbc(u64 Xi[2], const u128 Htable[16],
+			 const u8 *inp, size_t len);
+void gcm_ghash_rv64i_zbc__zbkb(u64 Xi[2], const u128 Htable[16],
+			       const u8 *inp, size_t len);
+
+struct riscv64_ghash_ctx {
+	void (*ghash_func)(u64 Xi[2], const u128 Htable[16],
+			   const u8 *inp, size_t len);
+
+	/* key used by vector asm */
+	u128 htable[16];
+	/* key used by software fallback */
+	be128 key;
+};
+
+struct riscv64_ghash_desc_ctx {
+	u64 shash[2];
+	u8 buffer[GHASH_DIGEST_SIZE];
+	int bytes;
+};
+
+static int riscv64_ghash_init(struct shash_desc *desc)
+{
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	dctx->bytes = 0;
+	memset(dctx->shash, 0, GHASH_DIGEST_SIZE);
+	return 0;
+}
+
+#ifdef CONFIG_RISCV_ISA_ZBC
+
+#define RISCV64_ZBC_SETKEY(VARIANT, GHASH)				\
+void gcm_init_rv64i_ ## VARIANT(u128 Htable[16], const u64 Xi[2]);	\
+static int riscv64_zbc_ghash_setkey_ ## VARIANT(struct crypto_shash *tfm,	\
+					   const u8 *key,		\
+					   unsigned int keylen)		\
+{									\
+	struct riscv64_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(tfm)); \
+	const u64 k[2] = { cpu_to_be64(((const u64 *)key)[0]),		\
+			   cpu_to_be64(((const u64 *)key)[1]) };	\
+									\
+	if (keylen != GHASH_BLOCK_SIZE)					\
+		return -EINVAL;						\
+									\
+	memcpy(&ctx->key, key, GHASH_BLOCK_SIZE);			\
+	gcm_init_rv64i_ ## VARIANT(ctx->htable, k);			\
+									\
+	ctx->ghash_func = gcm_ghash_rv64i_ ## GHASH;			\
+									\
+	return 0;							\
+}
+
+static int riscv64_zbc_ghash_update(struct shash_desc *desc,
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
+		ctx->ghash_func(dctx->shash, ctx->htable,
+				dctx->buffer, GHASH_DIGEST_SIZE);
+
+		src += GHASH_DIGEST_SIZE - dctx->bytes;
+		srclen -= GHASH_DIGEST_SIZE - dctx->bytes;
+		dctx->bytes = 0;
+	}
+	len = srclen & ~(GHASH_DIGEST_SIZE - 1);
+
+	if (len) {
+		gcm_ghash_rv64i_zbc(dctx->shash, ctx->htable,
+				src, len);
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
+static int riscv64_zbc_ghash_final(struct shash_desc *desc, u8 *out)
+{
+	int i;
+	struct riscv64_ghash_ctx *ctx = crypto_tfm_ctx(crypto_shash_tfm(desc->tfm));
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	if (dctx->bytes) {
+		for (i = dctx->bytes; i < GHASH_DIGEST_SIZE; i++)
+			dctx->buffer[i] = 0;
+		ctx->ghash_func(dctx->shash, ctx->htable,
+				dctx->buffer, GHASH_DIGEST_SIZE);
+		dctx->bytes = 0;
+	}
+	memcpy(out, dctx->shash, GHASH_DIGEST_SIZE);
+	return 0;
+}
+
+RISCV64_ZBC_SETKEY(zbc, zbc);
+struct shash_alg riscv64_zbc_ghash_alg = {
+	.digestsize = GHASH_DIGEST_SIZE,
+	.init = riscv64_ghash_init,
+	.update = riscv64_zbc_ghash_update,
+	.final = riscv64_zbc_ghash_final,
+	.setkey = riscv64_zbc_ghash_setkey_zbc,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx)
+		    + sizeof(struct ghash_desc_ctx),
+	.base = {
+		 .cra_name = "ghash",
+		 .cra_driver_name = "riscv64_zbc_ghash",
+		 .cra_priority = 250,
+		 .cra_blocksize = GHASH_BLOCK_SIZE,
+		 .cra_ctxsize = sizeof(struct riscv64_ghash_ctx),
+		 .cra_module = THIS_MODULE,
+	},
+};
+
+RISCV64_ZBC_SETKEY(zbc__zbb, zbc);
+struct shash_alg riscv64_zbc_zbb_ghash_alg = {
+	.digestsize = GHASH_DIGEST_SIZE,
+	.init = riscv64_ghash_init,
+	.update = riscv64_zbc_ghash_update,
+	.final = riscv64_zbc_ghash_final,
+	.setkey = riscv64_zbc_ghash_setkey_zbc__zbb,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx)
+		    + sizeof(struct ghash_desc_ctx),
+	.base = {
+		 .cra_name = "ghash",
+		 .cra_driver_name = "riscv64_zbc_zbb_ghash",
+		 .cra_priority = 251,
+		 .cra_blocksize = GHASH_BLOCK_SIZE,
+		 .cra_ctxsize = sizeof(struct riscv64_ghash_ctx),
+		 .cra_module = THIS_MODULE,
+	},
+};
+
+RISCV64_ZBC_SETKEY(zbc__zbkb, zbc__zbkb);
+struct shash_alg riscv64_zbc_zbkb_ghash_alg = {
+	.digestsize = GHASH_DIGEST_SIZE,
+	.init = riscv64_ghash_init,
+	.update = riscv64_zbc_ghash_update,
+	.final = riscv64_zbc_ghash_final,
+	.setkey = riscv64_zbc_ghash_setkey_zbc__zbkb,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx)
+		    + sizeof(struct ghash_desc_ctx),
+	.base = {
+		 .cra_name = "ghash",
+		 .cra_driver_name = "riscv64_zbc_zbkb_ghash",
+		 .cra_priority = 252,
+		 .cra_blocksize = GHASH_BLOCK_SIZE,
+		 .cra_ctxsize = sizeof(struct riscv64_ghash_ctx),
+		 .cra_module = THIS_MODULE,
+	},
+};
+
+#endif /* CONFIG_RISCV_ISA_ZBC */
+
+#define RISCV64_DEFINED_GHASHES		7
+
+static struct shash_alg *riscv64_ghashes[RISCV64_DEFINED_GHASHES];
+static int num_riscv64_ghashes;
+
+static int __init riscv64_ghash_register(struct shash_alg *ghash)
+{
+	int ret;
+
+	ret = crypto_register_shash(ghash);
+	if (ret < 0) {
+		int i;
+
+		for (i = num_riscv64_ghashes - 1; i >= 0 ; i--)
+			crypto_unregister_shash(riscv64_ghashes[i]);
+
+		num_riscv64_ghashes = 0;
+
+		return ret;
+	}
+
+	pr_debug("Registered RISC-V ghash %s\n", ghash->base.cra_driver_name);
+	riscv64_ghashes[num_riscv64_ghashes] = ghash;
+	num_riscv64_ghashes++;
+	return 0;
+}
+
+static int __init riscv64_ghash_mod_init(void)
+{
+	int ret = 0;
+
+#ifdef CONFIG_RISCV_ISA_ZBC
+	if (riscv_isa_extension_available(NULL, ZBC)) {
+		ret = riscv64_ghash_register(&riscv64_zbc_ghash_alg);
+		if (ret < 0)
+			return ret;
+
+		if (riscv_isa_extension_available(NULL, ZBB)) {
+			ret = riscv64_ghash_register(&riscv64_zbc_zbb_ghash_alg);
+			if (ret < 0)
+				return ret;
+		}
+
+		if (riscv_isa_extension_available(NULL, ZBKB)) {
+			ret = riscv64_ghash_register(&riscv64_zbc_zbkb_ghash_alg);
+			if (ret < 0)
+				return ret;
+		}
+	}
+#endif
+
+	return 0;
+}
+
+static void __exit riscv64_ghash_mod_fini(void)
+{
+	int i;
+
+	for (i = num_riscv64_ghashes - 1; i >= 0 ; i--)
+		crypto_unregister_shash(riscv64_ghashes[i]);
+
+	num_riscv64_ghashes = 0;
+}
+
+module_init(riscv64_ghash_mod_init);
+module_exit(riscv64_ghash_mod_fini);
+
+MODULE_DESCRIPTION("GSM GHASH (accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("ghash");
diff --git a/arch/riscv/crypto/ghash-riscv64-zbc.pl b/arch/riscv/crypto/ghash-riscv64-zbc.pl
new file mode 100644
index 000000000000..691231ffa11c
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-zbc.pl
@@ -0,0 +1,400 @@
+#! /usr/bin/env perl
+# Copyright 2022 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License").  You may not use
+# this file except in compliance with the License.  You can obtain a copy
+# in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
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
+# void gcm_init_rv64i_zbc(u128 Htable[16], const u64 H[2]);
+# void gcm_init_rv64i_zbc__zbb(u128 Htable[16], const u64 H[2]);
+# void gcm_init_rv64i_zbc__zbkb(u128 Htable[16], const u64 H[2]);
+#
+# input:  H: 128-bit H - secret parameter E(K, 0^128)
+# output: Htable: Preprocessed key data for gcm_gmult_rv64i_zbc* and
+#                 gcm_ghash_rv64i_zbc*
+#
+# All callers of this function revert the byte-order unconditionally
+# on little-endian machines. So we need to revert the byte-order back.
+# Additionally we reverse the bits of each byte.
+
+{
+my ($Htable,$H,$VAL0,$VAL1,$TMP0,$TMP1,$TMP2) = ("a0","a1","a2","a3","t0","t1","t2");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_init_rv64i_zbc
+.type gcm_init_rv64i_zbc,\@function
+gcm_init_rv64i_zbc:
+    ld      $VAL0,0($H)
+    ld      $VAL1,8($H)
+    @{[brev8_rv64i   $VAL0, $TMP0, $TMP1, $TMP2]}
+    @{[brev8_rv64i   $VAL1, $TMP0, $TMP1, $TMP2]}
+    @{[sd_rev8_rv64i $VAL0, $Htable, 0, $TMP0]}
+    @{[sd_rev8_rv64i $VAL1, $Htable, 8, $TMP0]}
+    ret
+.size gcm_init_rv64i_zbc,.-gcm_init_rv64i_zbc
+___
+}
+
+{
+my ($Htable,$H,$VAL0,$VAL1,$TMP0,$TMP1,$TMP2) = ("a0","a1","a2","a3","t0","t1","t2");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_init_rv64i_zbc__zbb
+.type gcm_init_rv64i_zbc__zbb,\@function
+gcm_init_rv64i_zbc__zbb:
+    ld      $VAL0,0($H)
+    ld      $VAL1,8($H)
+    @{[brev8_rv64i $VAL0, $TMP0, $TMP1, $TMP2]}
+    @{[brev8_rv64i $VAL1, $TMP0, $TMP1, $TMP2]}
+    @{[rev8 $VAL0, $VAL0]}
+    @{[rev8 $VAL1, $VAL1]}
+    sd      $VAL0,0($Htable)
+    sd      $VAL1,8($Htable)
+    ret
+.size gcm_init_rv64i_zbc__zbb,.-gcm_init_rv64i_zbc__zbb
+___
+}
+
+{
+my ($Htable,$H,$TMP0,$TMP1) = ("a0","a1","t0","t1");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_init_rv64i_zbc__zbkb
+.type gcm_init_rv64i_zbc__zbkb,\@function
+gcm_init_rv64i_zbc__zbkb:
+    ld      $TMP0,0($H)
+    ld      $TMP1,8($H)
+    @{[brev8 $TMP0, $TMP0]}
+    @{[brev8 $TMP1, $TMP1]}
+    @{[rev8 $TMP0, $TMP0]}
+    @{[rev8 $TMP1, $TMP1]}
+    sd      $TMP0,0($Htable)
+    sd      $TMP1,8($Htable)
+    ret
+.size gcm_init_rv64i_zbc__zbkb,.-gcm_init_rv64i_zbc__zbkb
+___
+}
+
+################################################################################
+# void gcm_gmult_rv64i_zbc(u64 Xi[2], const u128 Htable[16]);
+# void gcm_gmult_rv64i_zbc__zbkb(u64 Xi[2], const u128 Htable[16]);
+#
+# input:  Xi: current hash value
+#         Htable: copy of H
+# output: Xi: next hash value Xi
+#
+# Compute GMULT (Xi*H mod f) using the Zbc (clmul) and Zbb (basic bit manip)
+# extensions. Using the no-Karatsuba approach and clmul for the final reduction.
+# This results in an implementation with minimized number of instructions.
+# HW with clmul latencies higher than 2 cycles might observe a performance
+# improvement with Karatsuba. HW with clmul latencies higher than 6 cycles
+# might observe a performance improvement with additionally converting the
+# reduction to shift&xor. For a full discussion of this estimates see
+# https://github.com/riscv/riscv-crypto/blob/master/doc/supp/gcm-mode-cmul.adoc
+{
+my ($Xi,$Htable,$x0,$x1,$y0,$y1) = ("a0","a1","a4","a5","a6","a7");
+my ($z0,$z1,$z2,$z3,$t0,$t1,$polymod) = ("t0","t1","t2","t3","t4","t5","t6");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_gmult_rv64i_zbc
+.type gcm_gmult_rv64i_zbc,\@function
+gcm_gmult_rv64i_zbc:
+    # Load Xi and bit-reverse it
+    ld        $x0, 0($Xi)
+    ld        $x1, 8($Xi)
+    @{[brev8_rv64i $x0, $z0, $z1, $z2]}
+    @{[brev8_rv64i $x1, $z0, $z1, $z2]}
+
+    # Load the key (already bit-reversed)
+    ld        $y0, 0($Htable)
+    ld        $y1, 8($Htable)
+
+    # Load the reduction constant
+    la        $polymod, Lpolymod
+    lbu       $polymod, 0($polymod)
+
+    # Multiplication (without Karatsuba)
+    @{[clmulh $z3, $x1, $y1]}
+    @{[clmul  $z2, $x1, $y1]}
+    @{[clmulh $t1, $x0, $y1]}
+    @{[clmul  $z1, $x0, $y1]}
+    xor       $z2, $z2, $t1
+    @{[clmulh $t1, $x1, $y0]}
+    @{[clmul  $t0, $x1, $y0]}
+    xor       $z2, $z2, $t1
+    xor       $z1, $z1, $t0
+    @{[clmulh $t1, $x0, $y0]}
+    @{[clmul  $z0, $x0, $y0]}
+    xor       $z1, $z1, $t1
+
+    # Reduction with clmul
+    @{[clmulh $t1, $z3, $polymod]}
+    @{[clmul  $t0, $z3, $polymod]}
+    xor       $z2, $z2, $t1
+    xor       $z1, $z1, $t0
+    @{[clmulh $t1, $z2, $polymod]}
+    @{[clmul  $t0, $z2, $polymod]}
+    xor       $x1, $z1, $t1
+    xor       $x0, $z0, $t0
+
+    # Bit-reverse Xi back and store it
+    @{[brev8_rv64i $x0, $z0, $z1, $z2]}
+    @{[brev8_rv64i $x1, $z0, $z1, $z2]}
+    sd        $x0, 0($Xi)
+    sd        $x1, 8($Xi)
+    ret
+.size gcm_gmult_rv64i_zbc,.-gcm_gmult_rv64i_zbc
+___
+}
+
+{
+my ($Xi,$Htable,$x0,$x1,$y0,$y1) = ("a0","a1","a4","a5","a6","a7");
+my ($z0,$z1,$z2,$z3,$t0,$t1,$polymod) = ("t0","t1","t2","t3","t4","t5","t6");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_gmult_rv64i_zbc__zbkb
+.type gcm_gmult_rv64i_zbc__zbkb,\@function
+gcm_gmult_rv64i_zbc__zbkb:
+    # Load Xi and bit-reverse it
+    ld        $x0, 0($Xi)
+    ld        $x1, 8($Xi)
+    @{[brev8  $x0, $x0]}
+    @{[brev8  $x1, $x1]}
+
+    # Load the key (already bit-reversed)
+    ld        $y0, 0($Htable)
+    ld        $y1, 8($Htable)
+
+    # Load the reduction constant
+    la        $polymod, Lpolymod
+    lbu       $polymod, 0($polymod)
+
+    # Multiplication (without Karatsuba)
+    @{[clmulh $z3, $x1, $y1]}
+    @{[clmul  $z2, $x1, $y1]}
+    @{[clmulh $t1, $x0, $y1]}
+    @{[clmul  $z1, $x0, $y1]}
+    xor       $z2, $z2, $t1
+    @{[clmulh $t1, $x1, $y0]}
+    @{[clmul  $t0, $x1, $y0]}
+    xor       $z2, $z2, $t1
+    xor       $z1, $z1, $t0
+    @{[clmulh $t1, $x0, $y0]}
+    @{[clmul  $z0, $x0, $y0]}
+    xor       $z1, $z1, $t1
+
+    # Reduction with clmul
+    @{[clmulh $t1, $z3, $polymod]}
+    @{[clmul  $t0, $z3, $polymod]}
+    xor       $z2, $z2, $t1
+    xor       $z1, $z1, $t0
+    @{[clmulh $t1, $z2, $polymod]}
+    @{[clmul  $t0, $z2, $polymod]}
+    xor       $x1, $z1, $t1
+    xor       $x0, $z0, $t0
+
+    # Bit-reverse Xi back and store it
+    @{[brev8  $x0, $x0]}
+    @{[brev8  $x1, $x1]}
+    sd        $x0, 0($Xi)
+    sd        $x1, 8($Xi)
+    ret
+.size gcm_gmult_rv64i_zbc__zbkb,.-gcm_gmult_rv64i_zbc__zbkb
+___
+}
+
+################################################################################
+# void gcm_ghash_rv64i_zbc(u64 Xi[2], const u128 Htable[16],
+#                          const u8 *inp, size_t len);
+# void gcm_ghash_rv64i_zbc__zbkb(u64 Xi[2], const u128 Htable[16],
+#                                const u8 *inp, size_t len);
+#
+# input:  Xi: current hash value
+#         Htable: copy of H
+#         inp: pointer to input data
+#         len: length of input data in bytes (mutiple of block size)
+# output: Xi: Xi+1 (next hash value Xi)
+{
+my ($Xi,$Htable,$inp,$len,$x0,$x1,$y0,$y1) = ("a0","a1","a2","a3","a4","a5","a6","a7");
+my ($z0,$z1,$z2,$z3,$t0,$t1,$polymod) = ("t0","t1","t2","t3","t4","t5","t6");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_ghash_rv64i_zbc
+.type gcm_ghash_rv64i_zbc,\@function
+gcm_ghash_rv64i_zbc:
+    # Load Xi and bit-reverse it
+    ld        $x0, 0($Xi)
+    ld        $x1, 8($Xi)
+    @{[brev8_rv64i $x0, $z0, $z1, $z2]}
+    @{[brev8_rv64i $x1, $z0, $z1, $z2]}
+
+    # Load the key (already bit-reversed)
+    ld        $y0, 0($Htable)
+    ld        $y1, 8($Htable)
+
+    # Load the reduction constant
+    la        $polymod, Lpolymod
+    lbu       $polymod, 0($polymod)
+
+Lstep:
+    # Load the input data, bit-reverse them, and XOR them with Xi
+    ld        $t0, 0($inp)
+    ld        $t1, 8($inp)
+    add       $inp, $inp, 16
+    add       $len, $len, -16
+    @{[brev8_rv64i $t0, $z0, $z1, $z2]}
+    @{[brev8_rv64i $t1, $z0, $z1, $z2]}
+    xor       $x0, $x0, $t0
+    xor       $x1, $x1, $t1
+
+    # Multiplication (without Karatsuba)
+    @{[clmulh $z3, $x1, $y1]}
+    @{[clmul  $z2, $x1, $y1]}
+    @{[clmulh $t1, $x0, $y1]}
+    @{[clmul  $z1, $x0, $y1]}
+    xor       $z2, $z2, $t1
+    @{[clmulh $t1, $x1, $y0]}
+    @{[clmul  $t0, $x1, $y0]}
+    xor       $z2, $z2, $t1
+    xor       $z1, $z1, $t0
+    @{[clmulh $t1, $x0, $y0]}
+    @{[clmul  $z0, $x0, $y0]}
+    xor       $z1, $z1, $t1
+
+    # Reduction with clmul
+    @{[clmulh $t1, $z3, $polymod]}
+    @{[clmul  $t0, $z3, $polymod]}
+    xor       $z2, $z2, $t1
+    xor       $z1, $z1, $t0
+    @{[clmulh $t1, $z2, $polymod]}
+    @{[clmul  $t0, $z2, $polymod]}
+    xor       $x1, $z1, $t1
+    xor       $x0, $z0, $t0
+
+    # Iterate over all blocks
+    bnez      $len, Lstep
+
+    # Bit-reverse final Xi back and store it
+    @{[brev8_rv64i $x0, $z0, $z1, $z2]}
+    @{[brev8_rv64i $x1, $z0, $z1, $z2]}
+    sd        $x0, 0($Xi)
+    sd        $x1, 8($Xi)
+    ret
+.size gcm_ghash_rv64i_zbc,.-gcm_ghash_rv64i_zbc
+___
+}
+
+{
+my ($Xi,$Htable,$inp,$len,$x0,$x1,$y0,$y1) = ("a0","a1","a2","a3","a4","a5","a6","a7");
+my ($z0,$z1,$z2,$z3,$t0,$t1,$polymod) = ("t0","t1","t2","t3","t4","t5","t6");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_ghash_rv64i_zbc__zbkb
+.type gcm_ghash_rv64i_zbc__zbkb,\@function
+gcm_ghash_rv64i_zbc__zbkb:
+    # Load Xi and bit-reverse it
+    ld        $x0, 0($Xi)
+    ld        $x1, 8($Xi)
+    @{[brev8  $x0, $x0]}
+    @{[brev8  $x1, $x1]}
+
+    # Load the key (already bit-reversed)
+    ld        $y0, 0($Htable)
+    ld        $y1, 8($Htable)
+
+    # Load the reduction constant
+    la        $polymod, Lpolymod
+    lbu       $polymod, 0($polymod)
+
+Lstep_zkbk:
+    # Load the input data, bit-reverse them, and XOR them with Xi
+    ld        $t0, 0($inp)
+    ld        $t1, 8($inp)
+    add       $inp, $inp, 16
+    add       $len, $len, -16
+    @{[brev8  $t0, $t0]}
+    @{[brev8  $t1, $t1]}
+    xor       $x0, $x0, $t0
+    xor       $x1, $x1, $t1
+
+    # Multiplication (without Karatsuba)
+    @{[clmulh $z3, $x1, $y1]}
+    @{[clmul  $z2, $x1, $y1]}
+    @{[clmulh $t1, $x0, $y1]}
+    @{[clmul  $z1, $x0, $y1]}
+    xor       $z2, $z2, $t1
+    @{[clmulh $t1, $x1, $y0]}
+    @{[clmul  $t0, $x1, $y0]}
+    xor       $z2, $z2, $t1
+    xor       $z1, $z1, $t0
+    @{[clmulh $t1, $x0, $y0]}
+    @{[clmul  $z0, $x0, $y0]}
+    xor       $z1, $z1, $t1
+
+    # Reduction with clmul
+    @{[clmulh $t1, $z3, $polymod]}
+    @{[clmul  $t0, $z3, $polymod]}
+    xor       $z2, $z2, $t1
+    xor       $z1, $z1, $t0
+    @{[clmulh $t1, $z2, $polymod]}
+    @{[clmul  $t0, $z2, $polymod]}
+    xor       $x1, $z1, $t1
+    xor       $x0, $z0, $t0
+
+    # Iterate over all blocks
+    bnez      $len, Lstep_zkbk
+
+    # Bit-reverse final Xi back and store it
+    @{[brev8  $x0, $x0]}
+    @{[brev8  $x1, $x1]}
+    sd $x0,  0($Xi)
+    sd $x1,  8($Xi)
+    ret
+.size gcm_ghash_rv64i_zbc__zbkb,.-gcm_ghash_rv64i_zbc__zbkb
+___
+}
+
+$code .= <<___;
+.p2align 3
+Lbrev8_const:
+    .dword  0xAAAAAAAAAAAAAAAA
+    .dword  0xCCCCCCCCCCCCCCCC
+    .dword  0xF0F0F0F0F0F0F0F0
+.size Lbrev8_const,.-Lbrev8_const
+
+Lpolymod:
+    .byte 0x87
+.size Lpolymod,.-Lpolymod
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
diff --git a/arch/riscv/crypto/riscv.pm b/arch/riscv/crypto/riscv.pm
new file mode 100644
index 000000000000..b0c786a13ca0
--- /dev/null
+++ b/arch/riscv/crypto/riscv.pm
@@ -0,0 +1,231 @@
+#! /usr/bin/env perl
+# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License").  You may not use
+# this file except in compliance with the License.  You can obtain a copy
+# in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+
+use strict;
+use warnings;
+
+# Set $have_stacktrace to 1 if we have Devel::StackTrace
+my $have_stacktrace = 0;
+if (eval {require Devel::StackTrace;1;}) {
+    $have_stacktrace = 1;
+}
+
+my @regs = map("x$_",(0..31));
+# Mapping from the RISC-V psABI ABI mnemonic names to the register number.
+my @regaliases = ('zero','ra','sp','gp','tp','t0','t1','t2','s0','s1',
+    map("a$_",(0..7)),
+    map("s$_",(2..11)),
+    map("t$_",(3..6))
+);
+
+my %reglookup;
+@reglookup{@regs} = @regs;
+@reglookup{@regaliases} = @regs;
+
+# Takes a register name, possibly an alias, and converts it to a register index
+# from 0 to 31
+sub read_reg {
+    my $reg = lc shift;
+    if (!exists($reglookup{$reg})) {
+        my $trace = "";
+        if ($have_stacktrace) {
+            $trace = Devel::StackTrace->new->as_string;
+        }
+        die("Unknown register ".$reg."\n".$trace);
+    }
+    my $regstr = $reglookup{$reg};
+    if (!($regstr =~ /^x([0-9]+)$/)) {
+        my $trace = "";
+        if ($have_stacktrace) {
+            $trace = Devel::StackTrace->new->as_string;
+        }
+        die("Could not process register ".$reg."\n".$trace);
+    }
+    return $1;
+}
+
+# Helper functions
+
+sub brev8_rv64i {
+    # brev8 without `brev8` instruction (only in Zbkb)
+    # Bit-reverses the first argument and needs two scratch registers
+    my $val = shift;
+    my $t0 = shift;
+    my $t1 = shift;
+    my $brev8_const = shift;
+    my $seq = <<___;
+        la      $brev8_const, Lbrev8_const
+
+        ld      $t0, 0($brev8_const)  # 0xAAAAAAAAAAAAAAAA
+        slli    $t1, $val, 1
+        and     $t1, $t1, $t0
+        and     $val, $val, $t0
+        srli    $val, $val, 1
+        or      $val, $t1, $val
+
+        ld      $t0, 8($brev8_const)  # 0xCCCCCCCCCCCCCCCC
+        slli    $t1, $val, 2
+        and     $t1, $t1, $t0
+        and     $val, $val, $t0
+        srli    $val, $val, 2
+        or      $val, $t1, $val
+
+        ld      $t0, 16($brev8_const) # 0xF0F0F0F0F0F0F0F0
+        slli    $t1, $val, 4
+        and     $t1, $t1, $t0
+        and     $val, $val, $t0
+        srli    $val, $val, 4
+        or      $val, $t1, $val
+___
+    return $seq;
+}
+
+sub sd_rev8_rv64i {
+    # rev8 without `rev8` instruction (only in Zbb or Zbkb)
+    # Stores the given value byte-reversed and needs one scratch register
+    my $val = shift;
+    my $addr = shift;
+    my $off = shift;
+    my $tmp = shift;
+    my $off0 = ($off + 0);
+    my $off1 = ($off + 1);
+    my $off2 = ($off + 2);
+    my $off3 = ($off + 3);
+    my $off4 = ($off + 4);
+    my $off5 = ($off + 5);
+    my $off6 = ($off + 6);
+    my $off7 = ($off + 7);
+    my $seq = <<___;
+        sb      $val, $off7($addr)
+        srli    $tmp, $val, 8
+        sb      $tmp, $off6($addr)
+        srli    $tmp, $val, 16
+        sb      $tmp, $off5($addr)
+        srli    $tmp, $val, 24
+        sb      $tmp, $off4($addr)
+        srli    $tmp, $val, 32
+        sb      $tmp, $off3($addr)
+        srli    $tmp, $val, 40
+        sb      $tmp, $off2($addr)
+        srli    $tmp, $val, 48
+        sb      $tmp, $off1($addr)
+        srli    $tmp, $val, 56
+        sb      $tmp, $off0($addr)
+___
+    return $seq;
+}
+
+# Scalar crypto instructions
+
+sub aes64ds {
+    # Encoding for aes64ds rd, rs1, rs2 instruction on RV64
+    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
+    my $template = 0b0011101_00000_00000_000_00000_0110011;
+    my $rd = read_reg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7));
+}
+
+sub aes64dsm {
+    # Encoding for aes64dsm rd, rs1, rs2 instruction on RV64
+    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
+    my $template = 0b0011111_00000_00000_000_00000_0110011;
+    my $rd = read_reg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7));
+}
+
+sub aes64es {
+    # Encoding for aes64es rd, rs1, rs2 instruction on RV64
+    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
+    my $template = 0b0011001_00000_00000_000_00000_0110011;
+    my $rd = read_reg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7));
+}
+
+sub aes64esm {
+    # Encoding for aes64esm rd, rs1, rs2 instruction on RV64
+    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
+    my $template = 0b0011011_00000_00000_000_00000_0110011;
+    my $rd = read_reg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7));
+}
+
+sub aes64im {
+    # Encoding for aes64im rd, rs1 instruction on RV64
+    #                XXXXXXXXXXXX_ rs1 _XXX_ rd  _XXXXXXX
+    my $template = 0b001100000000_00000_001_00000_0010011;
+    my $rd = read_reg shift;
+    my $rs1 = read_reg shift;
+    return ".word ".($template | ($rs1 << 15) | ($rd << 7));
+}
+
+sub aes64ks1i {
+    # Encoding for aes64ks1i rd, rs1, rnum instruction on RV64
+    #                XXXXXXXX_rnum_ rs1 _XXX_ rd  _XXXXXXX
+    my $template = 0b00110001_0000_00000_001_00000_0010011;
+    my $rd = read_reg shift;
+    my $rs1 = read_reg shift;
+    my $rnum = shift;
+    return ".word ".($template | ($rnum << 20) | ($rs1 << 15) | ($rd << 7));
+}
+
+sub aes64ks2 {
+    # Encoding for aes64ks2 rd, rs1, rs2 instruction on RV64
+    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
+    my $template = 0b0111111_00000_00000_000_00000_0110011;
+    my $rd = read_reg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7));
+}
+
+sub brev8 {
+    # brev8 rd, rs
+    my $template = 0b011010000111_00000_101_00000_0010011;
+    my $rd = read_reg shift;
+    my $rs = read_reg shift;
+    return ".word ".($template | ($rs << 15) | ($rd << 7));
+}
+
+sub clmul {
+    # Encoding for clmul rd, rs1, rs2 instruction on RV64
+    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
+    my $template = 0b0000101_00000_00000_001_00000_0110011;
+    my $rd = read_reg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7));
+}
+
+sub clmulh {
+    # Encoding for clmulh rd, rs1, rs2 instruction on RV64
+    #                XXXXXXX_ rs2 _ rs1 _XXX_ rd  _XXXXXXX
+    my $template = 0b0000101_00000_00000_011_00000_0110011;
+    my $rd = read_reg shift;
+    my $rs1 = read_reg shift;
+    my $rs2 = read_reg shift;
+    return ".word ".($template | ($rs2 << 20) | ($rs1 << 15) | ($rd << 7));
+}
+
+sub rev8 {
+    # Encoding for rev8 rd, rs instruction on RV64
+    #               XXXXXXXXXXXXX_ rs  _XXX_ rd  _XXXXXXX
+    my $template = 0b011010111000_00000_101_00000_0010011;
+    my $rd = read_reg shift;
+    my $rs = read_reg shift;
+    return ".word ".($template | ($rs << 15) | ($rd << 7));
+}
+
+1;
-- 
2.39.0

