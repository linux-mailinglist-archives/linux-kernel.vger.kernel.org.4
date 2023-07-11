Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE71D74F3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjGKPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjGKPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:43:05 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBFF1BE1;
        Tue, 11 Jul 2023 08:42:33 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qJFR3-0000g0-Sx; Tue, 11 Jul 2023 17:37:53 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     aou@eecs.berkeley.edu, heiko@sntech.de,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu, ebiggers@kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Subject: [PATCH v4 12/12] RISC-V: crypto: add Zvksh accelerated SM3 hash implementation
Date:   Tue, 11 Jul 2023 17:37:43 +0200
Message-Id: <20230711153743.1970625-13-heiko@sntech.de>
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

Add support for the SM3 hash function implemented using the special
instructions provided by the Zvksh vector crypto instructions.

Co-developed-by: Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Signed-off-by: Charalampos Mitrodimas <charalampos.mitrodimas@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/Kconfig              |  11 ++
 arch/riscv/crypto/Makefile             |   8 +-
 arch/riscv/crypto/sm3-riscv64-glue.c   | 112 ++++++++++++
 arch/riscv/crypto/sm3-riscv64-zvksh.pl | 225 +++++++++++++++++++++++++
 4 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index d1e22482f7c4..0c4e575ba8d6 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -53,6 +53,17 @@ config CRYPTO_SHA512_RISCV64
 	  Architecture: riscv64
 	  - Zvknhb vector crypto extension
 
+config CRYPTO_SM3_RISCV64
+	tristate "Hash functions: SM3 (ShangMi 3)"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_HASH
+	select CRYPTO_SM3
+	help
+	  SHA-512 secure hash algorithm (FIPS 180)
+
+	  Architecture: riscv64
+	  - Zvknhb vector crypto extension
+
 config CRYPTO_SM4_RISCV64
 	tristate "Ciphers: SM4 (ShangMi 4)"
 	depends on 64BIT && RISCV_ISA_V
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 1a9f31b185de..f7faba6c12c9 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -21,6 +21,9 @@ sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvbb-zvknha.o
 obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
 sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvbb-zvknhb.o
 
+obj-$(CONFIG_CRYPTO_SM3_RISCV64) += sm3-riscv64.o
+sm3-riscv64-y := sm3-riscv64-glue.o sm3-riscv64-zvksh.o
+
 obj-$(CONFIG_CRYPTO_SM4_RISCV64) += sm4-riscv64.o
 sm4-riscv64-y := sm4-riscv64-glue.o sm4-riscv64-zvksed.o
 
@@ -45,10 +48,13 @@ $(obj)/sha256-riscv64-zvbb-zvknha.S: $(src)/sha256-riscv64-zvbb-zvknha.pl
 $(obj)/sha512-riscv64-zvbb-zvknhb.S: $(src)/sha512-riscv64-zvbb-zvknhb.pl
 	$(call cmd,perlasm)
 
+$(obj)/sm3-riscv64-zvksh.S: $(src)/sm3-riscv64-zvksh.pl
+	$(call cmd,perlasm)
+
 $(obj)/sm4-riscv64-zvksed.S: $(src)/sm4-riscv64-zvksed.pl
 	$(call cmd,perlasm)
 
 clean-files += aes-riscv64-zvkned.S
 clean-files += ghash-riscv64-zbc.S ghash-riscv64-zvkb.S ghash-riscv64-zvkg.S
 clean-files += sha256-riscv64-zvknha.S sha512-riscv64-zvknhb.S
-clean-files += sm4-riscv64-zvksed.S
+clean-files += sm3-riscv64-zvksh.S sm4-riscv64-zvksed.S
diff --git a/arch/riscv/crypto/sm3-riscv64-glue.c b/arch/riscv/crypto/sm3-riscv64-glue.c
new file mode 100644
index 000000000000..75b2816e2f2b
--- /dev/null
+++ b/arch/riscv/crypto/sm3-riscv64-glue.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux/riscv64 port of the OpenSSL SM3 implementation for RISCV64
+ *
+ * Copyright (C) 2023 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ */
+
+#include <linux/types.h>
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <crypto/sha2.h>
+#include <crypto/sm3_base.h>
+
+asmlinkage void ossl_hwsm3_block_data_order_zvksh(u32 *digest, const void *o,
+						  unsigned int num);
+
+static void __sm3_block_data_order(struct sm3_state *sst, u8 const *src,
+				      int blocks)
+{
+	ossl_hwsm3_block_data_order_zvksh(sst->state, src, blocks);
+}
+
+static int riscv64_sm3_update(struct shash_desc *desc, const u8 *data,
+			 unsigned int len)
+{
+	if (crypto_simd_usable()) {
+		int ret;
+
+		kernel_rvv_begin();
+		ret = sm3_base_do_update(desc, data, len,
+					    __sm3_block_data_order);
+		kernel_rvv_end();
+		return ret;
+	} else {
+		sm3_update(shash_desc_ctx(desc), data, len);
+		return 0;
+	}
+}
+
+static int riscv64_sm3_finup(struct shash_desc *desc, const u8 *data,
+			unsigned int len, u8 *out)
+{
+
+	if (!crypto_simd_usable()) {
+		struct sm3_state *sctx = shash_desc_ctx(desc);
+
+		if (len)
+			sm3_update(sctx, data, len);
+		sm3_final(sctx, out);
+		return 0;
+	}
+
+	kernel_rvv_begin();
+	if (len)
+		sm3_base_do_update(desc, data, len,
+				   __sm3_block_data_order);
+
+	sm3_base_do_finalize(desc, __sm3_block_data_order);
+	kernel_rvv_end();
+
+	return sm3_base_finish(desc, out);
+}
+
+static int riscv64_sm3_final(struct shash_desc *desc, u8 *out)
+{
+	return riscv64_sm3_finup(desc, NULL, 0, out);
+}
+
+static struct shash_alg sm3_alg = {
+	.digestsize		= SM3_DIGEST_SIZE,
+	.init			= sm3_base_init,
+	.update			= riscv64_sm3_update,
+	.final			= riscv64_sm3_final,
+	.finup			= riscv64_sm3_finup,
+	.descsize		= sizeof(struct sm3_state),
+	.base.cra_name		= "sm3",
+	.base.cra_driver_name	= "sm3-riscv64-zvksh",
+	.base.cra_priority	= 150,
+	.base.cra_blocksize	= SM3_BLOCK_SIZE,
+	.base.cra_module	= THIS_MODULE,
+};
+
+static int __init sm3_mod_init(void)
+{
+	/* sm3 needs at least a vlen of 256 to work correctly */
+	if (riscv_isa_extension_available(NULL, ZVKSH) &&
+	    riscv_isa_extension_available(NULL, ZVBB) &&
+	    riscv_vector_vlen() >= 256)
+		return crypto_register_shash(&sm3_alg);
+
+	return 0;
+}
+
+static void __exit sm3_mod_fini(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKSH) &&
+	    riscv_isa_extension_available(NULL, ZVBB) &&
+	    riscv_vector_vlen() >= 256)
+		crypto_unregister_shash(&sm3_alg);
+}
+
+module_init(sm3_mod_init);
+module_exit(sm3_mod_fini);
+
+MODULE_DESCRIPTION("SM3 secure hash for riscv64");
+MODULE_AUTHOR("Andy Polyakov <appro@openssl.org>");
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sm3");
diff --git a/arch/riscv/crypto/sm3-riscv64-zvksh.pl b/arch/riscv/crypto/sm3-riscv64-zvksh.pl
new file mode 100644
index 000000000000..3c21df31793b
--- /dev/null
+++ b/arch/riscv/crypto/sm3-riscv64-zvksh.pl
@@ -0,0 +1,225 @@
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
+# - RISC-V vector ('V') with VLEN >= 256
+# - Vector Bit-manipulation used in Cryptography ('Zvbb')
+# - ShangMi Suite: SM3 Secure Hash ('Zvksh')
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
+# ossl_hwsm3_block_data_order_zvksh(SM3_CTX *c, const void *p, size_t num);
+{
+my ($CTX, $INPUT, $NUM) = ("a0", "a1", "a2");
+my ($V0, $V1, $V2, $V3, $V4) = ("v0", "v1", "v2", "v3", "v4");
+
+$code .= <<___;
+.text
+.p2align 3
+.globl ossl_hwsm3_block_data_order_zvksh
+.type ossl_hwsm3_block_data_order_zvksh,\@function
+ossl_hwsm3_block_data_order_zvksh:
+    @{[vsetivli__x0_8_e32_m1_ta_ma]}
+
+    # Load initial state of hash context (c->A-H).
+    @{[vle32_v $V0, $CTX]}
+    @{[vrev8_v $V0, $V0]}
+
+L_sm3_loop:
+    # Copy the previous state to v1.
+    # It will be XOR'ed with the current state at the end of the round.
+    @{[vmv_v_v $V1, $V0]}
+
+    # Load the 64B block in 2x32B chunks.
+    @{[vle32_v $V3, $INPUT]} # v3 := {w7, ..., w0}
+    add $INPUT, $INPUT, 32
+
+    @{[vle32_v $V4, $INPUT]} # v4 := {w15, ..., w8}
+    add $INPUT, $INPUT, 32
+
+    add $NUM, $NUM, -1
+
+    # As vsm3c consumes only w0, w1, w4, w5 we need to slide the input
+    # 2 elements down so we process elements w2, w3, w6, w7
+    # This will be repeated for each odd round.
+    @{[vslidedown_vi $V2, $V3, 2]} # v2 := {X, X, w7, ..., w2}
+
+    @{[vsm3c_vi $V0, $V3, 0]}
+    @{[vsm3c_vi $V0, $V2, 1]}
+
+    # Prepare a vector with {w11, ..., w4}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, X, X, w7, ..., w4}
+    @{[vslideup_vi $V2, $V4, 4]}   # v2 := {w11, w10, w9, w8, w7, w6, w5, w4}
+
+    @{[vsm3c_vi $V0, $V2, 2]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, w11, w10, w9, w8, w7, w6}
+    @{[vsm3c_vi $V0, $V2, 3]}
+
+    @{[vsm3c_vi $V0, $V4, 4]}
+    @{[vslidedown_vi $V2, $V4, 2]} # v2 := {X, X, w15, w14, w13, w12, w11, w10}
+    @{[vsm3c_vi $V0, $V2, 5]}
+
+    @{[vsm3me_vv $V3, $V4, $V3]}   # v3 := {w23, w22, w21, w20, w19, w18, w17, w16}
+
+    # Prepare a register with {w19, w18, w17, w16, w15, w14, w13, w12}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, X, X, w15, w14, w13, w12}
+    @{[vslideup_vi $V2, $V3, 4]}   # v2 := {w19, w18, w17, w16, w15, w14, w13, w12}
+
+    @{[vsm3c_vi $V0, $V2, 6]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, w19, w18, w17, w16, w15, w14}
+    @{[vsm3c_vi $V0, $V2, 7]}
+
+    @{[vsm3c_vi $V0, $V3, 8]}
+    @{[vslidedown_vi $V2, $V3, 2]} # v2 := {X, X, w23, w22, w21, w20, w19, w18}
+    @{[vsm3c_vi $V0, $V2, 9]}
+
+    @{[vsm3me_vv $V4, $V3, $V4]}   # v4 := {w31, w30, w29, w28, w27, w26, w25, w24}
+
+    # Prepare a register with {w27, w26, w25, w24, w23, w22, w21, w20}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, X, X, w23, w22, w21, w20}
+    @{[vslideup_vi $V2, $V4, 4]}   # v2 := {w27, w26, w25, w24, w23, w22, w21, w20}
+
+    @{[vsm3c_vi $V0, $V2, 10]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, w27, w26, w25, w24, w23, w22}
+    @{[vsm3c_vi $V0, $V2, 11]}
+
+    @{[vsm3c_vi $V0, $V4, 12]}
+    @{[vslidedown_vi $V2, $V4, 2]} # v2 := {x, X, w31, w30, w29, w28, w27, w26}
+    @{[vsm3c_vi $V0, $V2, 13]}
+
+    @{[vsm3me_vv $V3, $V4, $V3]}   # v3 := {w32, w33, w34, w35, w36, w37, w38, w39}
+
+    # Prepare a register with {w35, w34, w33, w32, w31, w30, w29, w28}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, X, X, w31, w30, w29, w28}
+    @{[vslideup_vi $V2, $V3, 4]}   # v2 := {w35, w34, w33, w32, w31, w30, w29, w28}
+
+    @{[vsm3c_vi $V0, $V2, 14]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, w35, w34, w33, w32, w31, w30}
+    @{[vsm3c_vi $V0, $V2, 15]}
+
+    @{[vsm3c_vi $V0, $V3, 16]}
+    @{[vslidedown_vi $V2, $V3, 2]} # v2 := {X, X, w39, w38, w37, w36, w35, w34}
+    @{[vsm3c_vi $V0, $V2, 17]}
+
+    @{[vsm3me_vv $V4, $V3, $V4]}   # v4 := {w47, w46, w45, w44, w43, w42, w41, w40}
+
+    # Prepare a register with {w43, w42, w41, w40, w39, w38, w37, w36}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, X, X, w39, w38, w37, w36}
+    @{[vslideup_vi $V2, $V4, 4]}   # v2 := {w43, w42, w41, w40, w39, w38, w37, w36}
+
+    @{[vsm3c_vi $V0, $V2, 18]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, w43, w42, w41, w40, w39, w38}
+    @{[vsm3c_vi $V0, $V2, 19]}
+
+    @{[vsm3c_vi $V0, $V4, 20]}
+    @{[vslidedown_vi $V2, $V4, 2]} # v2 := {X, X, w47, w46, w45, w44, w43, w42}
+    @{[vsm3c_vi $V0, $V2, 21]}
+
+    @{[vsm3me_vv $V3, $V4, $V3]}   # v3 := {w55, w54, w53, w52, w51, w50, w49, w48}
+
+    # Prepare a register with {w51, w50, w49, w48, w47, w46, w45, w44}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, X, X, w47, w46, w45, w44}
+    @{[vslideup_vi $V2, $V3, 4]}   # v2 := {w51, w50, w49, w48, w47, w46, w45, w44}
+
+    @{[vsm3c_vi $V0, $V2, 22]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, w51, w50, w49, w48, w47, w46}
+    @{[vsm3c_vi $V0, $V2, 23]}
+
+    @{[vsm3c_vi $V0, $V3, 24]}
+    @{[vslidedown_vi $V2, $V3, 2]} # v2 := {X, X, w55, w54, w53, w52, w51, w50}
+    @{[vsm3c_vi $V0, $V2, 25]}
+
+    @{[vsm3me_vv $V4, $V3, $V4]}   # v4 := {w63, w62, w61, w60, w59, w58, w57, w56}
+
+    # Prepare a register with {w59, w58, w57, w56, w55, w54, w53, w52}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, X, X, w55, w54, w53, w52}
+    @{[vslideup_vi $V2, $V4, 4]}   # v2 := {w59, w58, w57, w56, w55, w54, w53, w52}
+
+    @{[vsm3c_vi $V0, $V2, 26]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, w59, w58, w57, w56, w55, w54}
+    @{[vsm3c_vi $V0, $V2, 27]}
+
+    @{[vsm3c_vi $V0, $V4, 28]}
+    @{[vslidedown_vi $V2, $V4, 2]} # v2 := {X, X, w63, w62, w61, w60, w59, w58}
+    @{[vsm3c_vi $V0, $V2, 29]}
+
+    @{[vsm3me_vv $V3, $V4, $V3]}   # v3 := {w71, w70, w69, w68, w67, w66, w65, w64}
+
+    # Prepare a register with {w67, w66, w65, w64, w63, w62, w61, w60}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, X, X, w63, w62, w61, w60}
+    @{[vslideup_vi $V2, $V3, 4]}   # v2 := {w67, w66, w65, w64, w63, w62, w61, w60}
+
+    @{[vsm3c_vi $V0, $V2, 30]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {X, X, w67, w66, w65, w64, w63, w62}
+    @{[vsm3c_vi $V0, $V2, 31]}
+
+    # XOR in the previous state.
+    @{[vxor_vv $V0, $V0, $V1]}
+
+    bnez $NUM, L_sm3_loop     # Check if there are any more block to process
+L_sm3_end:
+    @{[vrev8_v $V0, $V0]}
+    @{[vse32_v $V0, $CTX]}
+    ret
+
+.size ossl_hwsm3_block_data_order_zvksh,.-ossl_hwsm3_block_data_order_zvksh
+___
+}
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.39.2

