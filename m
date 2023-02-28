Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715326A500C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjB1AL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjB1AL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:11:27 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2691C303
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:10:59 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pWnVC-000552-9c; Tue, 28 Feb 2023 01:05:54 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     greentime.hu@sifive.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH RFC v2 16/16] RISC-V: crypto: add Zvksh accelerated SM3 hash implementation
Date:   Tue, 28 Feb 2023 01:05:44 +0100
Message-Id: <20230228000544.2234136-17-heiko@sntech.de>
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

Add support for the SM3 hash function implemented using the special
instructions provided by the Zvksh vector crypto instructions.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/Kconfig              |  11 ++
 arch/riscv/crypto/Makefile             |   8 +-
 arch/riscv/crypto/sm3-riscv64-glue.c   | 112 ++++++++++++++
 arch/riscv/crypto/sm3-riscv64-zvksh.pl | 195 +++++++++++++++++++++++++
 4 files changed, 325 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index a78c4fcb4127..9e50e7236036 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -51,6 +51,17 @@ config CRYPTO_SHA512_RISCV64
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
index c721da42af4c..79ff81a05d8b 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -21,6 +21,9 @@ sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknhb.o
 obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
 sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb.o
 
+obj-$(CONFIG_CRYPTO_SM3_RISCV64) += sm3-riscv64.o
+sm3-riscv64-y := sm3-riscv64-glue.o sm3-riscv64-zvksh.o
+
 obj-$(CONFIG_CRYPTO_SM4_RISCV64) += sm4-riscv64.o
 sm4-riscv64-y := sm4-riscv64-glue.o sm4-riscv64-zvksed.o
 
@@ -45,10 +48,13 @@ $(obj)/sha256-riscv64-zvknhb.S: $(src)/sha256-riscv64-zvknha.pl
 $(obj)/sha512-riscv64-zvknhb.S: $(src)/sha512-riscv64-zvknhb.pl
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
index 000000000000..455f73c27d1f
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
+	    riscv_isa_extension_available(NULL, ZVKB) &&
+	    riscv_vector_vlen() >= 256)
+		return crypto_register_shash(&sm3_alg);
+
+	return 0;
+}
+
+static void __exit sm3_mod_fini(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKSH) &&
+	    riscv_isa_extension_available(NULL, ZVKB) &&
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
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("sm3");
diff --git a/arch/riscv/crypto/sm3-riscv64-zvksh.pl b/arch/riscv/crypto/sm3-riscv64-zvksh.pl
new file mode 100644
index 000000000000..d6006ef32e4e
--- /dev/null
+++ b/arch/riscv/crypto/sm3-riscv64-zvksh.pl
@@ -0,0 +1,195 @@
+#! /usr/bin/env perl
+# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License").  You may not use
+# this file except in compliance with the License.  You can obtain a copy
+# in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+
+# The generated code of this file depends on the following RISC-V extensions:
+# - RV64I
+# - RISC-V vector ('V') with VLEN >= 256
+# - Vector Bit-manipulation used in Cryptography ('Zvkb')
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
+    @{[vle32_v $V3, $INPUT]} # v3 := {w0, ..., w7}
+    add $INPUT, $INPUT, 32
+
+    @{[vle32_v $V4, $INPUT]} # v4 := {w8, ..., w15}
+    add $INPUT, $INPUT, 32
+
+    add $NUM, $NUM, -1
+
+    # As vsm3c consumes only w0, w1, w4, w5 we need to slide the input
+    # 2 elements down so we process elements w2, w3, w6, w7
+    # This will be repeated for each odd round.
+    @{[vslidedown_vi $V2, $V3, 2]} # v2 := {w2, ..., w7, 0, 0}
+
+    @{[vsm3c_vi $V0, $V3, 0]}
+    @{[vsm3c_vi $V0, $V2, 1]}
+
+    # Prepare a vector with {w4, ..., w11}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w4, ..., w7, 0, 0, 0, 0}
+    @{[vslideup_vi $V2, $V4, 4]}   # v2 := {w4, w5, w6, w7, w8, w9, w10, w11}
+
+    @{[vsm3c_vi $V0, $V2, 2]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w6, w7, w8, w9, w10, w11, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 3]}
+
+    @{[vsm3c_vi $V0, $V4, 4]}
+    @{[vslidedown_vi $V2, $V4, 2]} # v2 := {w10, w11, w12, w13, w14, w15, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 5]}
+
+    @{[vsm3me_vv $V3, $V4, $V3]}  # v3 := {w16, w17, w18, w19, w20, w21, w22, w23}
+
+    # Prepare a register with {w12, w13, w14, w15, w16, w17, w18, w19}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w12, w13, w14, w15, 0, 0, 0, 0}
+    @{[vslideup_vi $V2, $V3, 4]}   # v2 := {w12, w13, w14, w15, w16, w17, w18, w19}
+
+    @{[vsm3c_vi $V0, $V2, 6]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w14, w15, w16, w17, w18, w19, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 7]}
+
+    @{[vsm3c_vi $V0, $V3, 8]}
+    @{[vslidedown_vi $V2, $V3, 2]} # v2 := {w18, w19, w20, w21, w22, w23, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 9]}
+
+    @{[vsm3me_vv $V4, $V3, $V4]} # v4 := {w24, w25, w26, w27, w28, w29, w30, w31}
+
+    # Prepare a register with {w20, w21, w22, w23, w24, w25, w26, w27}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w20, w21, w22, w23, 0, 0, 0, 0}
+    @{[vslideup_vi $V2, $V4, 4]}   # v2 := {w20, w21, w22, w23, w24, w25, w26, w27}
+
+    @{[vsm3c_vi $V0, $V2, 10]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w22, w23, w24, w25, w26, w27, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 11]}
+
+    @{[vsm3c_vi $V0, $V4, 12]}
+    @{[vslidedown_vi $V2, $V4, 2]} # v2 := {w26, w27, w28, w29, w30, w31, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 13]}
+
+    @{[vsm3me_vv $V3, $V4, $V3]} # v3 := {w32, w33, w34, w35, w36, w37, w38, w39}
+
+    # Prepare a register with {w28, w29, w30, w31, w32, w33, w34, w35}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w28, w29, w30, w31, 0, 0, 0, 0}
+    @{[vslideup_vi $V2, $V3, 4]}   # v2 := {w28, w29, w30, w31, w32, w33, w34, w35}
+
+    @{[vsm3c_vi $V0, $V2, 14]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w30, w31, w32, w33, w34, w35, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 15]}
+
+    @{[vsm3c_vi $V0, $V3, 16]}
+    @{[vslidedown_vi $V2, $V3, 2]} # v2 := {w34, w35, w36, w37, w38, w39, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 17]}
+
+    @{[vsm3me_vv $V4, $V3, $V4]}   # v4 := {w40, w41, w42, w43, w44, w45, w46, w47}
+
+    # Prepare a register with {w36, w37, w38, w39, w40, w41, w42, w43}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w36, w37, w38, w39, 0, 0, 0, 0}
+    @{[vslideup_vi $V2, $V4, 4]}   # v2 := {w36, w37, w38, w39, w40, w41, w42, w43}
+
+    @{[vsm3c_vi $V0, $V2, 18]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w38, w39, w40, w41, w42, w43, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 19]}
+
+    @{[vsm3c_vi $V0, $V4, 20]}
+    @{[vslidedown_vi $V2, $V4, 2]} # v2 := {w42, w43, w44, w45, w46, w47, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 21]}
+
+    @{[vsm3me_vv $V3, $V4, $V3]}   # v3 := {w48, w49, w50, w51, w52, w53, w54, w55}
+
+    # Prepare a register with {w44, w45, w46, w47, w48, w49, w50, w51}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w44, w45, w46, w47, 0, 0, 0, 0}
+    @{[vslideup_vi $V2, $V3, 4]}   # v2 := {w44, w45, w46, w47, w48, w49, w50, w51}
+
+    @{[vsm3c_vi $V0, $V2, 22]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w46, w47, w48, w49, w50, w51, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 23]}
+
+    @{[vsm3c_vi $V0, $V3, 24]}
+    @{[vslidedown_vi $V2, $V3, 2]} # v2 := {w50, w51, w52, w53, w54, w55, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 25]}
+
+    @{[vsm3me_vv $V4, $V3, $V4]}   # v4 := {w56, w57, w58, w59, w60, w61, w62, w63}
+
+    # Prepare a register with {w52, w53, w54, w55, w56, w57, w58, w59}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w52, w53, w54, w55, 0, 0, 0, 0}
+    @{[vslideup_vi $V2, $V4, 4]}   # v2 := {w52, w53, w54, w55, w56, w57, w58, w59}
+
+    @{[vsm3c_vi $V0, $V2, 26]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w54, w55, w56, w57, w58, w59, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 27]}
+
+    @{[vsm3c_vi $V0, $V4, 28]}
+    @{[vslidedown_vi $V2, $V4, 2]} # v2 := {w58, w59, w60, w61, w62, w63, 0, 0}
+    @{[vsm3c_vi $V0, $V2, 29]}
+
+    @{[vsm3me_vv $V3, $V4, $V3]}   # v3 := {w64, w65, w66, w67, w68, w69, w70, w71}
+
+    # Prepare a register with {w60, w61, w62, w63, w64, w65, w66, w67}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w60, w61, w62, w63, 0, 0, 0, 0}
+    @{[vslideup_vi $V2, $V3, 4]}   # v2 := {w60, w61, w62, w63, w64, w65, w66, w67}
+
+    @{[vsm3c_vi $V0, $V2, 30]}
+    @{[vslidedown_vi $V2, $V2, 2]} # v2 := {w62, w63, w64, w65, w66, w67, 0, 0}
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
2.39.0

