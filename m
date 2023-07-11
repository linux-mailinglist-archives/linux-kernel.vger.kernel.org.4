Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6DF74F3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjGKPkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjGKPjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:39:14 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD48170A;
        Tue, 11 Jul 2023 08:38:14 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJFR0-0000g0-S4; Tue, 11 Jul 2023 17:37:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, heiko@sntech.de,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, ebiggers@kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 07/12] RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
Date:   Tue, 11 Jul 2023 17:37:38 +0200
Message-Id: <20230711153743.1970625-8-heiko@sntech.de>
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

When the Zvkg vector crypto extension is available another optimized
gcm ghash variant is possible, so add it as another implementation.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/Kconfig               |   1 +
 arch/riscv/crypto/Makefile              |   7 +-
 arch/riscv/crypto/ghash-riscv64-glue.c  |  95 ++++++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl | 168 ++++++++++++++++++++++++
 4 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 41b8fdfe1d92..a1493b556993 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -15,5 +15,6 @@ config CRYPTO_GHASH_RISCV64
 	  - Zbc + Zbb extensions
 	  - Zbc + Zbkb extensions
 	  - Zvbb vector crypto extension
+	  - Zvkg vector crypto extension
 
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 81190941ba78..496e784984cc 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -9,7 +9,7 @@ ifdef CONFIG_RISCV_ISA_ZBC
 ghash-riscv64-y += ghash-riscv64-zbc.o
 endif
 ifdef CONFIG_RISCV_ISA_V
-ghash-riscv64-y += ghash-riscv64-zvbb-zvbc.o
+ghash-riscv64-y += ghash-riscv64-zvbb-zvbc.o ghash-riscv64-zvkg.o
 endif
 
 quiet_cmd_perlasm = PERLASM $@
@@ -21,4 +21,7 @@ $(obj)/ghash-riscv64-zbc.S: $(src)/ghash-riscv64-zbc.pl
 $(obj)/ghash-riscv64-zvbb-zvbc.S: $(src)/ghash-riscv64-zvbb-zvbc.pl
 	$(call cmd,perlasm)
 
-clean-files += ghash-riscv64-zbc.S ghash-riscv64-zvkb.S
+$(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
+	$(call cmd,perlasm)
+
+clean-files += ghash-riscv64-zbc.S ghash-riscv64-zvkb.S ghash-riscv64-zvkg.S
diff --git a/arch/riscv/crypto/ghash-riscv64-glue.c b/arch/riscv/crypto/ghash-riscv64-glue.c
index 2bfd1934d55b..a196e35a0751 100644
--- a/arch/riscv/crypto/ghash-riscv64-glue.c
+++ b/arch/riscv/crypto/ghash-riscv64-glue.c
@@ -45,9 +45,13 @@ static int riscv64_ghash_init(struct shash_desc *desc)
 #ifdef CONFIG_RISCV_ISA_V
 
 void gcm_init_rv64i_zvbb_zvbc(u128 Htable[16], const u64 Xi[2]);
+void gcm_init_rv64i_zvkg(u128 Htable[16], const u64 Xi[2]);
+void gcm_init_rv64i_zvkg_zvbb(u128 Htable[16], const u64 Xi[2]);
 
 void gcm_ghash_rv64i_zvbb_zvbc(u64 Xi[2], const u128 Htable[16],
 			       const u8 *inp, size_t len);
+void gcm_ghash_rv64i_zvkg(u64 Xi[2], const u128 Htable[16],
+			  const u8 *inp, size_t len);
 
 static int riscv64_zvk_ghash_setkey_zvbb_zvbc(struct crypto_shash *tfm,
 					      const u8 *key,
@@ -70,6 +74,48 @@ static int riscv64_zvk_ghash_setkey_zvbb_zvbc(struct crypto_shash *tfm,
 	return 0;
 }
 
+static int riscv64_zvk_ghash_setkey_zvkg(struct crypto_shash *tfm,
+					   const u8 *key,
+					   unsigned int keylen)
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
+	gcm_init_rv64i_zvkg(ctx->htable, k);
+	kernel_rvv_end();
+
+	ctx->ghash_func = gcm_ghash_rv64i_zvkg;
+
+	return 0;
+}
+
+static int riscv64_zvk_ghash_setkey_zvkg_zvbb(struct crypto_shash *tfm,
+					   const u8 *key,
+					   unsigned int keylen)
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
+	gcm_init_rv64i_zvkg_zvbb(ctx->htable, k);
+	kernel_rvv_end();
+
+	ctx->ghash_func = gcm_ghash_rv64i_zvkg;
+
+	return 0;
+}
+
 static inline void __ghash_block(struct riscv64_ghash_ctx *ctx,
 				 struct riscv64_ghash_desc_ctx *dctx)
 {
@@ -176,6 +222,42 @@ struct shash_alg riscv64_zvbb_zvbc_ghash_alg = {
 	},
 };
 
+struct shash_alg riscv64_zvkg_ghash_alg = {
+	.digestsize = GHASH_DIGEST_SIZE,
+	.init = riscv64_ghash_init,
+	.update = riscv64_zvk_ghash_update,
+	.final = riscv64_zvk_ghash_final,
+	.setkey = riscv64_zvk_ghash_setkey_zvkg,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx)
+		    + sizeof(struct ghash_desc_ctx),
+	.base = {
+		 .cra_name = "ghash",
+		 .cra_driver_name = "riscv64_zvkg_ghash",
+		 .cra_priority = 301,
+		 .cra_blocksize = GHASH_BLOCK_SIZE,
+		 .cra_ctxsize = sizeof(struct riscv64_ghash_ctx),
+		 .cra_module = THIS_MODULE,
+	},
+};
+
+struct shash_alg riscv64_zvkg_zvbb_ghash_alg = {
+	.digestsize = GHASH_DIGEST_SIZE,
+	.init = riscv64_ghash_init,
+	.update = riscv64_zvk_ghash_update,
+	.final = riscv64_zvk_ghash_final,
+	.setkey = riscv64_zvk_ghash_setkey_zvkg_zvbb,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx)
+		    + sizeof(struct ghash_desc_ctx),
+	.base = {
+		 .cra_name = "ghash",
+		 .cra_driver_name = "riscv64_zvkg_zvbb_ghash",
+		 .cra_priority = 303,
+		 .cra_blocksize = GHASH_BLOCK_SIZE,
+		 .cra_ctxsize = sizeof(struct riscv64_ghash_ctx),
+		 .cra_module = THIS_MODULE,
+	},
+};
+
 #endif /* CONFIG_RISCV_ISA_V */
 
 #ifdef CONFIG_RISCV_ISA_ZBC
@@ -417,6 +499,19 @@ static int __init riscv64_ghash_mod_init(void)
 		if (ret < 0)
 			return ret;
 	}
+
+	if (riscv_isa_extension_available(NULL, ZVKG) &&
+	    riscv_vector_vlen() >= 128) {
+		ret = riscv64_ghash_register(&riscv64_zvkg_ghash_alg);
+		if (ret < 0)
+			return ret;
+
+		if (riscv_isa_extension_available(NULL, ZVBB)) {
+			ret = riscv64_ghash_register(&riscv64_zvkg_zvbb_ghash_alg);
+			if (ret < 0)
+				return ret;
+		}
+	}
 #endif
 
 	return 0;
diff --git a/arch/riscv/crypto/ghash-riscv64-zvkg.pl b/arch/riscv/crypto/ghash-riscv64-zvkg.pl
new file mode 100644
index 000000000000..d613218a286e
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-zvkg.pl
@@ -0,0 +1,168 @@
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
+# - RISC-V vector crypto GHASH extension ('Zvkg')
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
+# void gcm_init_rv64i_zvkg(u128 Htable[16], const u64 H[2]);
+# void gcm_init_rv64i_zvkg_zvbb(u128 Htable[16], const u64 H[2]);
+#
+# input: H: 128-bit H - secret parameter E(K, 0^128)
+# output: Htable: Copy of secret parameter (in normalized byte order)
+#
+# All callers of this function revert the byte-order unconditionally
+# on little-endian machines. So we need to revert the byte-order back.
+{
+my ($Htable,$H,$VAL0,$VAL1,$TMP0) = ("a0","a1","a2","a3","t0");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_init_rv64i_zvkg
+.type gcm_init_rv64i_zvkg,\@function
+gcm_init_rv64i_zvkg:
+    ld      $VAL0, 0($H)
+    ld      $VAL1, 8($H)
+    @{[sd_rev8_rv64i $VAL0, $Htable, 0, $TMP0]}
+    @{[sd_rev8_rv64i $VAL1, $Htable, 8, $TMP0]}
+    ret
+.size gcm_init_rv64i_zvkg,.-gcm_init_rv64i_zvkg
+___
+}
+
+{
+my ($Htable,$H,$V0) = ("a0","a1","v0");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_init_rv64i_zvkg_zvbb
+.type gcm_init_rv64i_zvkg_zvbb,\@function
+gcm_init_rv64i_zvkg_zvbb:
+    @{[vsetivli__x0_2_e64_m1_ta_ma]} # vsetivli x0, 2, e64, m1, ta, ma
+    @{[vle64_v $V0, $H]}             # vle64.v v0, (a1)
+    @{[vrev8_v $V0, $V0]}            # vrev8.v v0, v0
+    @{[vse64_v $V0, $Htable]}        # vse64.v v0, (a0)
+    ret
+.size gcm_init_rv64i_zvkg_zvbb,.-gcm_init_rv64i_zvkg_zvbb
+___
+}
+
+################################################################################
+# void gcm_gmult_rv64i_zvkg(u64 Xi[2], const u128 Htable[16]);
+#
+# input: Xi: current hash value
+#        Htable: copy of H
+# output: Xi: next hash value Xi
+{
+my ($Xi,$Htable) = ("a0","a1");
+my ($VD,$VS2) = ("v1","v2");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_gmult_rv64i_zvkg
+.type gcm_gmult_rv64i_zvkg,\@function
+gcm_gmult_rv64i_zvkg:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+    @{[vle32_v $VS2, $Htable]}
+    @{[vle32_v $VD, $Xi]}
+    @{[vgmul_vv $VD, $VS2]}
+    @{[vse32_v $VD, $Xi]}
+    ret
+.size gcm_gmult_rv64i_zvkg,.-gcm_gmult_rv64i_zvkg
+___
+}
+
+################################################################################
+# void gcm_ghash_rv64i_zvkg(u64 Xi[2], const u128 Htable[16],
+#                           const u8 *inp, size_t len);
+#
+# input: Xi: current hash value
+#        Htable: copy of H
+#        inp: pointer to input data
+#        len: length of input data in bytes (mutiple of block size)
+# output: Xi: Xi+1 (next hash value Xi)
+{
+my ($Xi,$Htable,$inp,$len) = ("a0","a1","a2","a3");
+my ($vXi,$vH,$vinp,$Vzero) = ("v1","v2","v3","v4");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_ghash_rv64i_zvkg
+.type gcm_ghash_rv64i_zvkg,\@function
+gcm_ghash_rv64i_zvkg:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+    @{[vle32_v $vH, $Htable]}
+    @{[vle32_v $vXi, $Xi]}
+
+Lstep:
+    @{[vle32_v $vinp, $inp]}
+    add $inp, $inp, 16
+    add $len, $len, -16
+    @{[vghsh_vv $vXi, $vH, $vinp]}
+    bnez $len, Lstep
+
+    @{[vse32_v $vXi, $Xi]}
+    ret
+
+.size gcm_ghash_rv64i_zvkg,.-gcm_ghash_rv64i_zvkg
+___
+}
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.39.2

