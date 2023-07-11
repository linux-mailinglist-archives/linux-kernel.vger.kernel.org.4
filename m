Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE674F3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjGKPnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjGKPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:42:51 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8631BC3;
        Tue, 11 Jul 2023 08:41:55 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJFR3-0000g0-95; Tue, 11 Jul 2023 17:37:53 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, heiko@sntech.de,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, ebiggers@kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 11/12] RISC-V: crypto: add Zvksed accelerated SM4 encryption implementation
Date:   Tue, 11 Jul 2023 17:37:42 +0200
Message-Id: <20230711153743.1970625-12-heiko@sntech.de>
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

Add support for the SM4 symmetric cipher implemented using the special
instructions provided by the Zvksed vector crypto instructions.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/Kconfig               |  17 ++
 arch/riscv/crypto/Makefile              |   7 +
 arch/riscv/crypto/sm4-riscv64-glue.c    | 162 +++++++++++++
 arch/riscv/crypto/sm4-riscv64-zvksed.pl | 300 ++++++++++++++++++++++++
 4 files changed, 486 insertions(+)
 create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 8579ce43546d..d1e22482f7c4 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -53,4 +53,21 @@ config CRYPTO_SHA512_RISCV64
 	  Architecture: riscv64
 	  - Zvknhb vector crypto extension
 
+config CRYPTO_SM4_RISCV64
+	tristate "Ciphers: SM4 (ShangMi 4)"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_ALGAPI
+	select CRYPTO_SM4
+	select CRYPTO_SM4_GENERIC
+	help
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016,
+	  ISO/IEC 18033-3:2010/Amd 1:2021)
+
+	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
+	  Organization of State Commercial Administration of China (OSCCA)
+	  as an authorized cryptographic algorithms for the use within China.
+
+	  Architecture: riscv64
+	  - Zvksed vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 38ee741a9777..1a9f31b185de 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -21,6 +21,9 @@ sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvbb-zvknha.o
 obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
 sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvbb-zvknhb.o
 
+obj-$(CONFIG_CRYPTO_SM4_RISCV64) += sm4-riscv64.o
+sm4-riscv64-y := sm4-riscv64-glue.o sm4-riscv64-zvksed.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -42,6 +45,10 @@ $(obj)/sha256-riscv64-zvbb-zvknha.S: $(src)/sha256-riscv64-zvbb-zvknha.pl
 $(obj)/sha512-riscv64-zvbb-zvknhb.S: $(src)/sha512-riscv64-zvbb-zvknhb.pl
 	$(call cmd,perlasm)
 
+$(obj)/sm4-riscv64-zvksed.S: $(src)/sm4-riscv64-zvksed.pl
+	$(call cmd,perlasm)
+
 clean-files += aes-riscv64-zvkned.S
 clean-files += ghash-riscv64-zbc.S ghash-riscv64-zvkb.S ghash-riscv64-zvkg.S
 clean-files += sha256-riscv64-zvknha.S sha512-riscv64-zvknhb.S
+clean-files += sm4-riscv64-zvksed.S
diff --git a/arch/riscv/crypto/sm4-riscv64-glue.c b/arch/riscv/crypto/sm4-riscv64-glue.c
new file mode 100644
index 000000000000..b4030690f696
--- /dev/null
+++ b/arch/riscv/crypto/sm4-riscv64-glue.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Linux/riscv64 port of the OpenSSL SM4 implementation for RISCV64
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
+#include <crypto/sm4.h>
+#include <crypto/internal/cipher.h>
+#include <crypto/internal/simd.h>
+
+struct sm4_key {
+	u32 rkey[SM4_RKEY_WORDS];
+};
+
+void rv64i_zvksed_sm4_encrypt(const u8 *in, u8 *out, const struct sm4_key *key);
+void rv64i_zvksed_sm4_decrypt(const u8 *in, u8 *out, const struct sm4_key *key);
+int rv64i_zvksed_sm4_set_encrypt_key(const u8 *userKey, struct sm4_key *key);
+int rv64i_zvksed_sm4_set_decrypt_key(const u8 *userKey, struct sm4_key *key);
+
+struct riscv_sm4_ctx {
+	struct crypto_cipher *fallback;
+	struct sm4_key enc_key;
+	struct sm4_key dec_key;
+	unsigned int keylen;
+};
+
+static int riscv64_sm4_init_zvksed(struct crypto_tfm *tfm)
+{
+	struct riscv_sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+	const char *alg = crypto_tfm_alg_name(tfm);
+	struct crypto_cipher *fallback;
+
+	fallback = crypto_alloc_cipher(alg, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(fallback)) {
+		pr_err("Failed to allocate fallback for '%s': %ld\n",
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
+static void riscv64_sm4_exit_zvksed(struct crypto_tfm *tfm)
+{
+	struct riscv_sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (ctx->fallback) {
+		crypto_free_cipher(ctx->fallback);
+		ctx->fallback = NULL;
+	}
+}
+
+static int riscv64_sm4_setkey_zvksed(struct crypto_tfm *tfm, const u8 *key,
+				     unsigned int keylen)
+{
+	struct riscv_sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+	int ret;
+
+	ctx->keylen = keylen;
+
+	kernel_rvv_begin();
+	ret = rv64i_zvksed_sm4_set_encrypt_key(key, &ctx->enc_key);
+	if (ret != 1) {
+		kernel_rvv_end();
+		return -EINVAL;
+	}
+
+	ret = rv64i_zvksed_sm4_set_decrypt_key(key, &ctx->dec_key);
+	kernel_rvv_end();
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = crypto_cipher_setkey(ctx->fallback, key, keylen);
+
+	return ret ? -EINVAL : 0;
+}
+
+static void riscv64_sm4_encrypt_zvksed(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	struct riscv_sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable()) {
+		kernel_rvv_begin();
+		rv64i_zvksed_sm4_encrypt(src, dst, &ctx->enc_key);
+		kernel_rvv_end();
+	} else {
+		crypto_cipher_encrypt_one(ctx->fallback, dst, src);
+	}
+}
+
+static void riscv64_sm4_decrypt_zvksed(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	struct riscv_sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable()) {
+		kernel_rvv_begin();
+		rv64i_zvksed_sm4_decrypt(src, dst, &ctx->dec_key);
+		kernel_rvv_end();
+	} else {
+		crypto_cipher_decrypt_one(ctx->fallback, dst, src);
+	}
+}
+
+struct crypto_alg riscv64_sm4_zvksed_alg = {
+	.cra_name = "sm4",
+	.cra_driver_name = "riscv-sm4-zvksed",
+	.cra_module = THIS_MODULE,
+	.cra_priority = 300,
+	.cra_flags = CRYPTO_ALG_TYPE_CIPHER | CRYPTO_ALG_NEED_FALLBACK,
+	.cra_blocksize = SM4_BLOCK_SIZE,
+	.cra_ctxsize = sizeof(struct riscv_sm4_ctx),
+	.cra_init = riscv64_sm4_init_zvksed,
+	.cra_exit = riscv64_sm4_exit_zvksed,
+	.cra_cipher = {
+		.cia_min_keysize = SM4_KEY_SIZE,
+		.cia_max_keysize = SM4_KEY_SIZE,
+		.cia_setkey = riscv64_sm4_setkey_zvksed,
+		.cia_encrypt = riscv64_sm4_encrypt_zvksed,
+		.cia_decrypt = riscv64_sm4_decrypt_zvksed,
+	},
+};
+
+static int __init riscv64_sm4_mod_init(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKSED) &&
+	    riscv_isa_extension_available(NULL, ZVBB) &&
+	    riscv_vector_vlen() >= 128)
+		return crypto_register_alg(&riscv64_sm4_zvksed_alg);
+
+	return 0;
+}
+
+static void __exit riscv64_sm4_mod_fini(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKSED) &&
+	    riscv_isa_extension_available(NULL, ZVBB) &&
+	    riscv_vector_vlen() >= 128)
+		crypto_unregister_alg(&riscv64_sm4_zvksed_alg);
+}
+
+module_init(riscv64_sm4_mod_init);
+module_exit(riscv64_sm4_mod_fini);
+
+MODULE_DESCRIPTION("SM4 (accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sm4");
diff --git a/arch/riscv/crypto/sm4-riscv64-zvksed.pl b/arch/riscv/crypto/sm4-riscv64-zvksed.pl
new file mode 100644
index 000000000000..fa97a58afeec
--- /dev/null
+++ b/arch/riscv/crypto/sm4-riscv64-zvksed.pl
@@ -0,0 +1,300 @@
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
+# The generated code of this file depends on the following RISC-V extensions:
+# - RV64I
+# - RISC-V vector ('V') with VLEN >= 128
+# - Vector Bit-manipulation used in Cryptography ('Zvbb')
+# - Vector ShangMi Suite: SM4 Block Cipher ('Zvksed')
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
+####
+# int rv64i_zvksed_sm4_set_encrypt_key(const unsigned char *userKey,
+#                                      SM4_KEY *key);
+#
+{
+my ($ukey,$keys,$fk)=("a0","a1","t0");
+my ($vukey,$vfk,$vk0,$vk1,$vk2,$vk3,$vk4,$vk5,$vk6,$vk7)=("v1","v2","v3","v4","v5","v6","v7","v8","v9","v10");
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvksed_sm4_set_encrypt_key
+.type rv64i_zvksed_sm4_set_encrypt_key,\@function
+rv64i_zvksed_sm4_set_encrypt_key:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    # Load the user key
+    @{[vle32_v $vukey, $ukey]}
+    @{[vrev8_v $vukey, $vukey]}
+
+    # Load the FK.
+    la $fk, FK
+    @{[vle32_v $vfk, $fk]}
+
+    # Generate round keys.
+    @{[vxor_vv $vukey, $vukey, $vfk]}
+    @{[vsm4k_vi $vk0, $vukey, 0]} # rk[0:3]
+    @{[vsm4k_vi $vk1, $vk0, 1]} # rk[4:7]
+    @{[vsm4k_vi $vk2, $vk1, 2]} # rk[8:11]
+    @{[vsm4k_vi $vk3, $vk2, 3]} # rk[12:15]
+    @{[vsm4k_vi $vk4, $vk3, 4]} # rk[16:19]
+    @{[vsm4k_vi $vk5, $vk4, 5]} # rk[20:23]
+    @{[vsm4k_vi $vk6, $vk5, 6]} # rk[24:27]
+    @{[vsm4k_vi $vk7, $vk6, 7]} # rk[28:31]
+
+    # Store round keys
+    @{[vse32_v $vk0, $keys]} # rk[0:3]
+    addi $keys, $keys, 16
+    @{[vse32_v $vk1, $keys]} # rk[4:7]
+    addi $keys, $keys, 16
+    @{[vse32_v $vk2, $keys]} # rk[8:11]
+    addi $keys, $keys, 16
+    @{[vse32_v $vk3, $keys]} # rk[12:15]
+    addi $keys, $keys, 16
+    @{[vse32_v $vk4, $keys]} # rk[16:19]
+    addi $keys, $keys, 16
+    @{[vse32_v $vk5, $keys]} # rk[20:23]
+    addi $keys, $keys, 16
+    @{[vse32_v $vk6, $keys]} # rk[24:27]
+    addi $keys, $keys, 16
+    @{[vse32_v $vk7, $keys]} # rk[28:31]
+
+    li a0, 1
+    ret
+.size rv64i_zvksed_sm4_set_encrypt_key,.-rv64i_zvksed_sm4_set_encrypt_key
+___
+}
+
+####
+# int rv64i_zvksed_sm4_set_decrypt_key(const unsigned char *userKey,
+#                                      SM4_KEY *key);
+#
+{
+my ($ukey,$keys,$fk,$stride)=("a0","a1","t0","t1");
+my ($vukey,$vfk,$vk0,$vk1,$vk2,$vk3,$vk4,$vk5,$vk6,$vk7)=("v1","v2","v3","v4","v5","v6","v7","v8","v9","v10");
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvksed_sm4_set_decrypt_key
+.type rv64i_zvksed_sm4_set_decrypt_key,\@function
+rv64i_zvksed_sm4_set_decrypt_key:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    # Load the user key
+    @{[vle32_v $vukey, $ukey]}
+    @{[vrev8_v $vukey, $vukey]}
+
+    # Load the FK.
+    la $fk, FK
+    @{[vle32_v $vfk, $fk]}
+
+    # Generate round keys.
+    @{[vxor_vv $vukey, $vukey, $vfk]}
+    @{[vsm4k_vi $vk0, $vukey, 0]} # rk[0:3]
+    @{[vsm4k_vi $vk1, $vk0, 1]} # rk[4:7]
+    @{[vsm4k_vi $vk2, $vk1, 2]} # rk[8:11]
+    @{[vsm4k_vi $vk3, $vk2, 3]} # rk[12:15]
+    @{[vsm4k_vi $vk4, $vk3, 4]} # rk[16:19]
+    @{[vsm4k_vi $vk5, $vk4, 5]} # rk[20:23]
+    @{[vsm4k_vi $vk6, $vk5, 6]} # rk[24:27]
+    @{[vsm4k_vi $vk7, $vk6, 7]} # rk[28:31]
+
+    # Store round keys in reverse order
+    addi $keys, $keys, 12
+    li $stride, -4
+    @{[vsse32_v $vk7, $keys, $stride]} # rk[31:28]
+    addi $keys, $keys, 16
+    @{[vsse32_v $vk6, $keys, $stride]} # rk[27:24]
+    addi $keys, $keys, 16
+    @{[vsse32_v $vk5, $keys, $stride]} # rk[23:20]
+    addi $keys, $keys, 16
+    @{[vsse32_v $vk4, $keys, $stride]} # rk[19:16]
+    addi $keys, $keys, 16
+    @{[vsse32_v $vk3, $keys, $stride]} # rk[15:12]
+    addi $keys, $keys, 16
+    @{[vsse32_v $vk2, $keys, $stride]} # rk[11:8]
+    addi $keys, $keys, 16
+    @{[vsse32_v $vk1, $keys, $stride]} # rk[7:4]
+    addi $keys, $keys, 16
+    @{[vsse32_v $vk0, $keys, $stride]} # rk[3:0]
+
+    li a0, 1
+    ret
+.size rv64i_zvksed_sm4_set_decrypt_key,.-rv64i_zvksed_sm4_set_decrypt_key
+___
+}
+
+####
+# void rv64i_zvksed_sm4_encrypt(const unsigned char *in, unsigned char *out,
+#                               const SM4_KEY *key);
+#
+{
+my ($in,$out,$keys,$stride)=("a0","a1","a2","t0");
+my ($vdata,$vk0,$vk1,$vk2,$vk3,$vk4,$vk5,$vk6,$vk7,$vgen)=("v1","v2","v3","v4","v5","v6","v7","v8","v9","v10");
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvksed_sm4_encrypt
+.type rv64i_zvksed_sm4_encrypt,\@function
+rv64i_zvksed_sm4_encrypt:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    # Order of elements was adjusted in set_encrypt_key()
+    @{[vle32_v $vk0, $keys]} # rk[0:3]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk1, $keys]} # rk[4:7]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk2, $keys]} # rk[8:11]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk3, $keys]} # rk[12:15]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk4, $keys]} # rk[16:19]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk5, $keys]} # rk[20:23]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk6, $keys]} # rk[24:27]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk7, $keys]} # rk[28:31]
+
+    # Load input data
+    @{[vle32_v $vdata, $in]}
+    @{[vrev8_v $vdata, $vdata]}
+
+    # Encrypt with all keys
+    @{[vsm4r_vs $vdata, $vk0]}
+    @{[vsm4r_vs $vdata, $vk1]}
+    @{[vsm4r_vs $vdata, $vk2]}
+    @{[vsm4r_vs $vdata, $vk3]}
+    @{[vsm4r_vs $vdata, $vk4]}
+    @{[vsm4r_vs $vdata, $vk5]}
+    @{[vsm4r_vs $vdata, $vk6]}
+    @{[vsm4r_vs $vdata, $vk7]}
+
+    # Save the ciphertext (in reverse element order)
+    @{[vrev8_v $vdata, $vdata]}
+    li $stride, -4
+    addi $out, $out, 12
+    @{[vsse32_v $vdata, $out, $stride]}
+
+    ret
+.size rv64i_zvksed_sm4_encrypt,.-rv64i_zvksed_sm4_encrypt
+___
+}
+
+####
+# void rv64i_zvksed_sm4_decrypt(const unsigned char *in, unsigned char *out,
+#                               const SM4_KEY *key);
+#
+{
+my ($in,$out,$keys,$stride)=("a0","a1","a2","t0");
+my ($vdata,$vk0,$vk1,$vk2,$vk3,$vk4,$vk5,$vk6,$vk7,$vgen)=("v1","v2","v3","v4","v5","v6","v7","v8","v9","v10");
+$code .= <<___;
+.p2align 3
+.globl rv64i_zvksed_sm4_decrypt
+.type rv64i_zvksed_sm4_decrypt,\@function
+rv64i_zvksed_sm4_decrypt:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    # Order of elements was adjusted in set_decrypt_key()
+    @{[vle32_v $vk7, $keys]} # rk[31:28]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk6, $keys]} # rk[27:24]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk5, $keys]} # rk[23:20]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk4, $keys]} # rk[19:16]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk3, $keys]} # rk[15:11]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk2, $keys]} # rk[11:8]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk1, $keys]} # rk[7:4]
+    addi $keys, $keys, 16
+    @{[vle32_v $vk0, $keys]} # rk[3:0]
+
+    # Load input data
+    @{[vle32_v $vdata, $in]}
+    @{[vrev8_v $vdata, $vdata]}
+
+    # Encrypt with all keys
+    @{[vsm4r_vs $vdata, $vk7]}
+    @{[vsm4r_vs $vdata, $vk6]}
+    @{[vsm4r_vs $vdata, $vk5]}
+    @{[vsm4r_vs $vdata, $vk4]}
+    @{[vsm4r_vs $vdata, $vk3]}
+    @{[vsm4r_vs $vdata, $vk2]}
+    @{[vsm4r_vs $vdata, $vk1]}
+    @{[vsm4r_vs $vdata, $vk0]}
+
+    # Save the ciphertext (in reverse element order)
+    @{[vrev8_v $vdata, $vdata]}
+    li $stride, -4
+    addi $out, $out, 12
+    @{[vsse32_v $vdata, $out, $stride]}
+
+    ret
+.size rv64i_zvksed_sm4_decrypt,.-rv64i_zvksed_sm4_decrypt
+___
+}
+
+$code .= <<___;
+# Family Key (little-endian 32-bit chunks)
+.p2align 3
+FK:
+    .word 0xA3B1BAC6, 0x56AA3350, 0x677D9197, 0xB27022DC
+.size FK,.-FK
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.39.2

