Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6D6A5007
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjB1AJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjB1AJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:09:56 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8FE1D93D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:09:17 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pWnVB-000552-MN; Tue, 28 Feb 2023 01:05:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     greentime.hu@sifive.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH RFC v2 14/16] RISC-V: crypto: add Zvkned accelerated AES encryption implementation
Date:   Tue, 28 Feb 2023 01:05:42 +0100
Message-Id: <20230228000544.2234136-15-heiko@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230228000544.2234136-1-heiko@sntech.de>
References: <20230228000544.2234136-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

This adds an AES implementation using the Zvkned vector crypto instructions.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/Kconfig               |  14 +
 arch/riscv/crypto/Makefile              |   7 +
 arch/riscv/crypto/aes-riscv-glue.c      | 169 ++++++++
 arch/riscv/crypto/aes-riscv64-zvkned.pl | 500 ++++++++++++++++++++++++
 4 files changed, 690 insertions(+)
 create mode 100644 arch/riscv/crypto/aes-riscv-glue.c
 create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index da6244f0c0c4..c8abb29bb49b 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -2,6 +2,20 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
 
+config CRYPTO_AES_RISCV
+	tristate "Ciphers: AES (RISCV)"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_AES
+	help
+	  Block ciphers: AES cipher algorithms (FIPS-197)
+	  Length-preserving ciphers: AES with ECB, CBC, CTR, CTS,
+	    XCTR, and XTS modes
+	  AEAD cipher: AES with CBC, ESSIV, and SHA-256
+	    for fscrypt and dm-crypt
+
+	  Architecture: riscv using one of
+	  - Zvkns
+
 config CRYPTO_GHASH_RISCV64
 	tristate "Hash functions: GHASH"
 	depends on 64BIT && (RISCV_ISA_ZBC || RISCV_ISA_V)
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 3c94753affdf..e5c702dff883 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -3,6 +3,9 @@
 # linux/arch/riscv/crypto/Makefile
 #
 
+obj-$(CONFIG_CRYPTO_AES_RISCV) += aes-riscv.o
+aes-riscv-y := aes-riscv-glue.o aes-riscv64-zvkned.o
+
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o
 ifdef CONFIG_RISCV_ISA_ZBC
@@ -21,6 +24,9 @@ sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb.o
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
+$(obj)/aes-riscv64-zvkned.S: $(src)/aes-riscv64-zvkned.pl
+	$(call cmd,perlasm)
+
 $(obj)/ghash-riscv64-zbc.S: $(src)/ghash-riscv64-zbc.pl
 	$(call cmd,perlasm)
 
@@ -36,5 +42,6 @@ $(obj)/sha256-riscv64-zvknhb.S: $(src)/sha256-riscv64-zvknha.pl
 $(obj)/sha512-riscv64-zvknhb.S: $(src)/sha512-riscv64-zvknhb.pl
 	$(call cmd,perlasm)
 
+clean-files += aes-riscv64-zvkned.S
 clean-files += ghash-riscv64-zbc.S ghash-riscv64-zvkb.S ghash-riscv64-zvkg.S
 clean-files += sha256-riscv64-zvknha.S sha512-riscv64-zvknhb.S
diff --git a/arch/riscv/crypto/aes-riscv-glue.c b/arch/riscv/crypto/aes-riscv-glue.c
new file mode 100644
index 000000000000..f0b73058bb54
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv-glue.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Linux/riscv port of the OpenSSL AES implementation for RISCV
+ *
+ * Copyright (C) 2023 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ */
+
+#include <linux/crypto.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/aes.h>
+#include <crypto/internal/cipher.h>
+#include <crypto/internal/simd.h>
+
+struct aes_key {
+	u8 key[AES_MAX_KEYLENGTH];
+	int rounds;
+};
+
+/* variant using the zvkned vector crypto extension */
+void rv64i_zvkned_encrypt(const u8 *in, u8 *out, const struct aes_key *key);
+void rv64i_zvkned_decrypt(const u8 *in, u8 *out, const struct aes_key *key);
+int rv64i_zvkned_set_encrypt_key(const u8 *userKey, const int bits,
+				struct aes_key *key);
+int rv64i_zvkned_set_decrypt_key(const u8 *userKey, const int bits,
+				struct aes_key *key);
+
+struct riscv_aes_ctx {
+	struct crypto_cipher *fallback;
+	struct aes_key enc_key;
+	struct aes_key dec_key;
+	unsigned int keylen;
+};
+
+static int riscv64_aes_init_zvkned(struct crypto_tfm *tfm)
+{
+	struct riscv_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	const char *alg = crypto_tfm_alg_name(tfm);
+	struct crypto_cipher *fallback;
+
+	fallback = crypto_alloc_cipher(alg, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(fallback)) {
+		printk(KERN_ERR
+		       "Failed to allocate transformation for '%s': %ld\n",
+		       alg, PTR_ERR(fallback));
+		return PTR_ERR(fallback);
+	}
+
+	crypto_cipher_set_flags(fallback,
+				crypto_cipher_get_flags((struct
+							 crypto_cipher *)
+							tfm));
+	ctx->fallback = fallback;
+
+	return 0;
+}
+
+static void riscv_aes_exit(struct crypto_tfm *tfm)
+{
+	struct riscv_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (ctx->fallback) {
+		crypto_free_cipher(ctx->fallback);
+		ctx->fallback = NULL;
+	}
+}
+
+static int riscv64_aes_setkey_zvkned(struct crypto_tfm *tfm, const u8 *key,
+			 unsigned int keylen)
+{
+	struct riscv_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+	int ret;
+
+	ctx->keylen = keylen;
+
+	if (keylen == 16 || keylen == 32) {
+		kernel_rvv_begin();
+		ret = rv64i_zvkned_set_encrypt_key(key, keylen * 8, &ctx->enc_key);
+		if (ret != 1) {
+			kernel_rvv_end();
+			return -EINVAL;
+		}
+
+		ret = rv64i_zvkned_set_decrypt_key(key, keylen * 8, &ctx->dec_key);
+		kernel_rvv_end();
+		if (ret != 1)
+			return -EINVAL;
+	}
+
+	ret = crypto_cipher_setkey(ctx->fallback, key, keylen);
+
+	return ret ? -EINVAL : 0;
+}
+
+static void riscv64_aes_encrypt_zvkned(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	struct riscv_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable() && (ctx->keylen == 16 || ctx->keylen == 32)) {
+		kernel_rvv_begin();
+		rv64i_zvkned_encrypt(src, dst, &ctx->enc_key);
+		kernel_rvv_end();
+	} else {
+		crypto_cipher_encrypt_one(ctx->fallback, dst, src);
+	}
+}
+
+static void riscv64_aes_decrypt_zvkned(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	struct riscv_aes_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable() && (ctx->keylen == 16 || ctx->keylen == 32)) {
+		kernel_rvv_begin();
+		rv64i_zvkned_decrypt(src, dst, &ctx->dec_key);
+		kernel_rvv_end();
+	} else {
+		crypto_cipher_decrypt_one(ctx->fallback, dst, src);
+	}
+}
+
+struct crypto_alg riscv64_aes_zvkned_alg = {
+	.cra_name = "aes",
+	.cra_driver_name = "riscv-aes-zvkned",
+	.cra_module = THIS_MODULE,
+	.cra_priority = 300,
+	.cra_type = NULL,
+	.cra_flags = CRYPTO_ALG_TYPE_CIPHER | CRYPTO_ALG_NEED_FALLBACK,
+	.cra_alignmask = 0,
+	.cra_blocksize = AES_BLOCK_SIZE,
+	.cra_ctxsize = sizeof(struct riscv_aes_ctx),
+	.cra_init = riscv64_aes_init_zvkned,
+	.cra_exit = riscv_aes_exit,
+	.cra_cipher = {
+		.cia_min_keysize = AES_MIN_KEY_SIZE,
+		.cia_max_keysize = AES_MAX_KEY_SIZE,
+		.cia_setkey = riscv64_aes_setkey_zvkned,
+		.cia_encrypt = riscv64_aes_encrypt_zvkned,
+		.cia_decrypt = riscv64_aes_decrypt_zvkned,
+	},
+};
+
+static int __init riscv_aes_mod_init(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKNED) &&
+	    riscv_vector_vlen() >= 128)
+		return crypto_register_alg(&riscv64_aes_zvkned_alg);
+
+	return 0;
+}
+
+static void __exit riscv_aes_mod_fini(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKNED) &&
+	    riscv_vector_vlen() >= 128)
+		return crypto_unregister_alg(&riscv64_aes_zvkned_alg);
+}
+
+module_init(riscv_aes_mod_init);
+module_exit(riscv_aes_mod_fini);
+
+MODULE_DESCRIPTION("AES (accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("aes");
diff --git a/arch/riscv/crypto/aes-riscv64-zvkned.pl b/arch/riscv/crypto/aes-riscv64-zvkned.pl
new file mode 100644
index 000000000000..176588723220
--- /dev/null
+++ b/arch/riscv/crypto/aes-riscv64-zvkned.pl
@@ -0,0 +1,500 @@
+#! /usr/bin/env perl
+# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License").  You may not use
+# this file except in compliance with the License.  You can obtain a copy
+# in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+
+# - RV64I
+# - RISC-V vector ('V') with VLEN >= 128
+# - RISC-V vector crypto AES extension ('Zvkned')
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
+# int rv64i_zvkned_set_encrypt_key(const unsigned char *userKey, const int bits,
+#                                  AES_KEY *key)
+# int rv64i_zvkned_set_decrypt_key(const unsigned char *userKey, const int bits,
+#                                  AES_KEY *key)
+{
+my ($UKEY,$BITS,$KEYP) = ("a0", "a1", "a2");
+my ($T0,$T1,$T4) = ("t1", "t2", "t4");
+my ($v0,  $v1,  $v2,  $v3,  $v4,  $v5,  $v6,
+          $v7,  $v8,  $v9,  $v10, $v11, $v12,
+          $v13, $v14, $v15, $v16, $v17, $v18,
+          $v19, $v20, $v21, $v22, $v23, $v24,
+) = map("v$_",(0..24));
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_set_encrypt_key
+.type rv64i_zvkned_set_encrypt_key,\@function
+rv64i_zvkned_set_encrypt_key:
+    beqz $UKEY, L_fail_m1
+    beqz $KEYP, L_fail_m1
+
+    # Get proper routine for key size
+    li $T0, 256
+    beq $BITS, $T0, L_set_key_256
+    li $T0, 128
+    beq $BITS, $T0, L_set_key_128
+
+    j L_fail_m2
+
+.size rv64i_zvkned_set_encrypt_key,.-rv64i_zvkned_set_encrypt_key
+___
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_set_decrypt_key
+.type rv64i_zvkned_set_decrypt_key,\@function
+rv64i_zvkned_set_decrypt_key:
+    beqz $UKEY, L_fail_m1
+    beqz $KEYP, L_fail_m1
+
+    # Get proper routine for key size
+    li $T0, 256
+    beq $BITS, $T0, L_set_key_256
+    li $T0, 128
+    beq $BITS, $T0, L_set_key_128
+
+    j L_fail_m2
+
+.size rv64i_zvkned_set_decrypt_key,.-rv64i_zvkned_set_decrypt_key
+___
+
+$code .= <<___;
+.p2align 3
+L_set_key_128:
+    # Store the number of rounds
+    li $T1, 10
+    sw $T1, 240($KEYP)
+
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    # Load the key
+    @{[vle32_v $v10, ($UKEY)]}
+
+    # Generate keys for round 2-11 into registers v11-v20.
+    @{[vaeskf1_vi $v11, $v10, 1]}   # v11 <- rk2  (w[ 4, 7])
+    @{[vaeskf1_vi $v12, $v11, 2]}   # v12 <- rk3  (w[ 8,11])
+    @{[vaeskf1_vi $v13, $v12, 3]}   # v13 <- rk4  (w[12,15])
+    @{[vaeskf1_vi $v14, $v13, 4]}   # v14 <- rk5  (w[16,19])
+    @{[vaeskf1_vi $v15, $v14, 5]}   # v15 <- rk6  (w[20,23])
+    @{[vaeskf1_vi $v16, $v15, 6]}   # v16 <- rk7  (w[24,27])
+    @{[vaeskf1_vi $v17, $v16, 7]}   # v17 <- rk8  (w[28,31])
+    @{[vaeskf1_vi $v18, $v17, 8]}   # v18 <- rk9  (w[32,35])
+    @{[vaeskf1_vi $v19, $v18, 9]}   # v19 <- rk10 (w[36,39])
+    @{[vaeskf1_vi $v20, $v19, 10]}  # v20 <- rk11 (w[40,43])
+
+    # Store the round keys
+    @{[vse32_v $v10, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v11, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v12, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v13, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v14, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v15, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v16, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v17, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v18, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v19, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v20, ($KEYP)]}
+
+    li a0, 1
+    ret
+.size L_set_key_128,.-L_set_key_128
+___
+
+$code .= <<___;
+.p2align 3
+L_set_key_256:
+    # Store the number of rounds
+    li $T1, 14
+    sw $T1, 240($KEYP)
+
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    # Load the key
+    @{[vle32_v $v10, ($UKEY)]}
+    addi $UKEY, $UKEY, 16
+    @{[vle32_v $v11, ($UKEY)]}
+
+    @{[vmv_v_v $v12, $v10]}
+    @{[vaeskf2_vi $v12, $v11, 1]}
+    @{[vmv_v_v $v13, $v11]}
+    @{[vaeskf2_vi $v13, $v12, 2]}
+    @{[vmv_v_v $v14, $v12]}
+    @{[vaeskf2_vi $v14, $v13, 3]}
+    @{[vmv_v_v $v15, $v13]}
+    @{[vaeskf2_vi $v15, $v14, 4]}
+    @{[vmv_v_v $v16, $v14]}
+    @{[vaeskf2_vi $v16, $v15, 5]}
+    @{[vmv_v_v $v17, $v15]}
+    @{[vaeskf2_vi $v17, $v16, 6]}
+    @{[vmv_v_v $v18, $v16]}
+    @{[vaeskf2_vi $v18, $v17, 7]}
+    @{[vmv_v_v $v19, $v17]}
+    @{[vaeskf2_vi $v19, $v18, 8]}
+    @{[vmv_v_v $v20, $v18]}
+    @{[vaeskf2_vi $v20, $v19, 9]}
+    @{[vmv_v_v $v21, $v19]}
+    @{[vaeskf2_vi $v21, $v20, 10]}
+    @{[vmv_v_v $v22, $v20]}
+    @{[vaeskf2_vi $v22, $v21, 11]}
+    @{[vmv_v_v $v23, $v21]}
+    @{[vaeskf2_vi $v23, $v22, 12]}
+    @{[vmv_v_v $v24, $v22]}
+    @{[vaeskf2_vi $v24, $v23, 13]}
+
+    @{[vse32_v $v10, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v11, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v12, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v13, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v14, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v15, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v16, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v17, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v18, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v19, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v20, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v21, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v22, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v23, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vse32_v $v24, ($KEYP)]}
+
+    li a0, 1
+    ret
+.size L_set_key_256,.-L_set_key_256
+___
+}
+
+################################################################################
+# void rv64i_zvkned_encrypt(const unsigned char *in, unsigned char *out,
+#                           const AES_KEY *key);
+{
+my ($INP,$OUTP,$KEYP) = ("a0", "a1", "a2");
+my ($T0,$T1, $rounds, $T6) = ("a3", "a4", "t5", "t6");
+my ($v0,  $v1,  $v2,  $v3,  $v4,  $v5,  $v6,
+          $v7,  $v8,  $v9,  $v10, $v11, $v12,
+          $v13, $v14, $v15, $v16, $v17, $v18,
+          $v19, $v20, $v21, $v22, $v23, $v24,
+) = map("v$_",(0..24));
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_encrypt
+.type rv64i_zvkned_encrypt,\@function
+rv64i_zvkned_encrypt:
+    # Load number of rounds
+    lwu     $rounds, 240($KEYP)
+
+    # Get proper routine for key size
+    li $T6, 14
+    beq $rounds, $T6, L_enc_256
+    li $T6, 10
+    beq $rounds, $T6, L_enc_128
+
+    j L_fail_m2
+.size rv64i_zvkned_encrypt,.-rv64i_zvkned_encrypt
+___
+
+$code .= <<___;
+.p2align 3
+L_enc_128:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    @{[vle32_v $v10, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v11, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v12, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v13, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v14, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v15, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v16, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v17, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v18, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v19, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v20, ($KEYP)]}
+
+    @{[vle32_v $v1, ($INP)]}
+
+    @{[vaesz_vs $v1, $v10]}    # with round key w[ 0, 3]
+    @{[vaesem_vs $v1, $v11]}   # with round key w[ 4, 7]
+    @{[vaesem_vs $v1, $v12]}   # with round key w[ 8,11]
+    @{[vaesem_vs $v1, $v13]}   # with round key w[12,15]
+    @{[vaesem_vs $v1, $v14]}   # with round key w[16,19]
+    @{[vaesem_vs $v1, $v15]}   # with round key w[20,23]
+    @{[vaesem_vs $v1, $v16]}   # with round key w[24,27]
+    @{[vaesem_vs $v1, $v17]}   # with round key w[28,31]
+    @{[vaesem_vs $v1, $v18]}   # with round key w[32,35]
+    @{[vaesem_vs $v1, $v19]}   # with round key w[36,39]
+    @{[vaesef_vs $v1, $v20]}   # with round key w[40,43]
+
+    @{[vse32_v $v1, ($OUTP)]}
+
+    ret
+.size L_enc_128,.-L_enc_128
+___
+
+$code .= <<___;
+.p2align 3
+L_enc_256:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    @{[vle32_v $v10, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v11, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v12, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v13, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v14, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v15, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v16, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v17, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v18, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v19, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v20, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v21, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v22, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v23, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v24, ($KEYP)]}
+
+    @{[vle32_v $v1, ($INP)]}
+
+    @{[vaesz_vs $v1, $v10]}     # with round key w[ 0, 3]
+    @{[vaesem_vs $v1, $v11]}
+    @{[vaesem_vs $v1, $v12]}
+    @{[vaesem_vs $v1, $v13]}
+    @{[vaesem_vs $v1, $v14]}
+    @{[vaesem_vs $v1, $v15]}
+    @{[vaesem_vs $v1, $v16]}
+    @{[vaesem_vs $v1, $v17]}
+    @{[vaesem_vs $v1, $v18]}
+    @{[vaesem_vs $v1, $v19]}
+    @{[vaesem_vs $v1, $v20]}
+    @{[vaesem_vs $v1, $v21]}
+    @{[vaesem_vs $v1, $v22]}
+    @{[vaesem_vs $v1, $v23]}
+    @{[vaesef_vs $v1, $v24]}
+
+    @{[vse32_v $v1, ($OUTP)]}
+    ret
+.size L_enc_256,.-L_enc_256
+___
+}
+
+################################################################################
+# void rv64i_zvkned_decrypt(const unsigned char *in, unsigned char *out,
+#                           const AES_KEY *key);
+{
+my ($INP,$OUTP,$KEYP) = ("a0", "a1", "a2");
+my ($T0,$T1, $rounds, $T6) = ("a3", "a4", "t5", "t6");
+my ($v0,  $v1,  $v2,  $v3,  $v4,  $v5,  $v6,
+          $v7,  $v8,  $v9,  $v10, $v11, $v12,
+          $v13, $v14, $v15, $v16, $v17, $v18,
+          $v19, $v20, $v21, $v22, $v23, $v24,
+) = map("v$_",(0..24));
+
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvkned_decrypt
+.type rv64i_zvkned_decrypt,\@function
+rv64i_zvkned_decrypt:
+    # Load number of rounds
+    lwu     $rounds, 240($KEYP)
+
+    # Get proper routine for key size
+    li $T6, 14
+    beq $rounds, $T6, L_dec_256
+    li $T6, 10
+    beq $rounds, $T6, L_dec_128
+
+    j L_fail_m2
+.size rv64i_zvkned_decrypt,.-rv64i_zvkned_decrypt
+___
+
+$code .= <<___;
+.p2align 3
+L_dec_128:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    @{[vle32_v $v10, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v11, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v12, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v13, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v14, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v15, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v16, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v17, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v18, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v19, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v20, ($KEYP)]}
+
+    @{[vle32_v $v1, ($INP)]}
+
+    @{[vaesz_vs $v1, $v20]}    # with round key w[43,47]
+    @{[vaesdm_vs $v1, $v19]}   # with round key w[36,39]
+    @{[vaesdm_vs $v1, $v18]}   # with round key w[32,35]
+    @{[vaesdm_vs $v1, $v17]}   # with round key w[28,31]
+    @{[vaesdm_vs $v1, $v16]}   # with round key w[24,27]
+    @{[vaesdm_vs $v1, $v15]}   # with round key w[20,23]
+    @{[vaesdm_vs $v1, $v14]}   # with round key w[16,19]
+    @{[vaesdm_vs $v1, $v13]}   # with round key w[12,15]
+    @{[vaesdm_vs $v1, $v12]}   # with round key w[ 8,11]
+    @{[vaesdm_vs $v1, $v11]}   # with round key w[ 4, 7]
+    @{[vaesdf_vs $v1, $v10]}   # with round key w[ 0, 3]
+
+    @{[vse32_v $v1, ($OUTP)]}
+
+    ret
+.size L_dec_128,.-L_dec_128
+___
+
+$code .= <<___;
+.p2align 3
+L_dec_256:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    @{[vle32_v $v10, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v11, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v12, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v13, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v14, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v15, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v16, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v17, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v18, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v19, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v20, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v21, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v22, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v23, ($KEYP)]}
+    addi $KEYP, $KEYP, 16
+    @{[vle32_v $v24, ($KEYP)]}
+
+    @{[vle32_v $v1, ($INP)]}
+
+    @{[vaesz_vs $v1, $v24]}    # with round key w[56,59]
+    @{[vaesdm_vs $v1, $v23]}   # with round key w[52,55]
+    @{[vaesdm_vs $v1, $v22]}   # with round key w[48,51]
+    @{[vaesdm_vs $v1, $v21]}   # with round key w[44,47]
+    @{[vaesdm_vs $v1, $v20]}   # with round key w[40,43]
+    @{[vaesdm_vs $v1, $v19]}   # with round key w[36,39]
+    @{[vaesdm_vs $v1, $v18]}   # with round key w[32,35]
+    @{[vaesdm_vs $v1, $v17]}   # with round key w[28,31]
+    @{[vaesdm_vs $v1, $v16]}   # with round key w[24,27]
+    @{[vaesdm_vs $v1, $v15]}   # with round key w[20,23]
+    @{[vaesdm_vs $v1, $v14]}   # with round key w[16,19]
+    @{[vaesdm_vs $v1, $v13]}   # with round key w[12,15]
+    @{[vaesdm_vs $v1, $v12]}   # with round key w[ 8,11]
+    @{[vaesdm_vs $v1, $v11]}   # with round key w[ 4, 7]
+    @{[vaesdf_vs $v1, $v10]}   # with round key w[ 0, 3]
+
+    @{[vse32_v $v1, ($OUTP)]}
+
+    ret
+.size L_dec_256,.-L_dec_256
+___
+}
+
+$code .= <<___;
+L_fail_m1:
+    li a0, -1
+    ret
+.size L_fail_m1,.-L_fail_m1
+
+L_fail_m2:
+    li a0, -2
+    ret
+.size L_fail_m2,.-L_fail_m2
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.39.0

