Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3774D6A500B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjB1ALG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjB1AK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:10:56 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962672B2AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:10:18 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pWnVB-000552-3Z; Tue, 28 Feb 2023 01:05:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     greentime.hu@sifive.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH RFC v2 12/16] RISC-V: crypto: add a vector-crypto-accelerated SHA256 implementation
Date:   Tue, 28 Feb 2023 01:05:40 +0100
Message-Id: <20230228000544.2234136-13-heiko@sntech.de>
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

This adds an accelerated SHA256 algorithm using either the Zvknha
or Zvknhb vector crypto extensions. The spec says that

    Zvknhb supports SHA-256 and SHA-512. Zvknha supports only SHA-256.

so the relevant acclerating instructions are included in both.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/Kconfig                  |  11 +
 arch/riscv/crypto/Makefile                 |   7 +
 arch/riscv/crypto/sha256-riscv64-glue.c    | 114 +++++++++
 arch/riscv/crypto/sha256-riscv64-zvknha.pl | 284 +++++++++++++++++++++
 4 files changed, 416 insertions(+)
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 84da19bdde8b..8645e02171f7 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -15,4 +15,15 @@ config CRYPTO_GHASH_RISCV64
 	  - ZVKB vector crypto extension
 	  - ZVKG vector crypto extension
 
+config CRYPTO_SHA256_RISCV64
+	tristate "Hash functions: SHA-256"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_HASH
+	select CRYPTO_LIB_SHA256
+	help
+	  SHA-256 secure hash algorithm (FIPS 180)
+
+	  Architecture: riscv64 using
+	  - Zvknha or Zvknhb vector crypto extensions
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 1ee0ce7d3264..02b3b4c32672 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -12,6 +12,9 @@ ifdef CONFIG_RISCV_ISA_V
 ghash-riscv64-y += ghash-riscv64-zvkb.o ghash-riscv64-zvkg.o
 endif
 
+obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
+sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknhb.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -24,4 +27,8 @@ $(obj)/ghash-riscv64-zvkb.S: $(src)/ghash-riscv64-zvkb.pl
 $(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
 	$(call cmd,perlasm)
 
+$(obj)/sha256-riscv64-zvknhb.S: $(src)/sha256-riscv64-zvknha.pl
+	$(call cmd,perlasm)
+
 clean-files += ghash-riscv64-zbc.S ghash-riscv64-zvkb.S ghash-riscv64-zvkg.S
+clean-files += sha256-riscv64-zvknha.S
diff --git a/arch/riscv/crypto/sha256-riscv64-glue.c b/arch/riscv/crypto/sha256-riscv64-glue.c
new file mode 100644
index 000000000000..8e3bb1deaad5
--- /dev/null
+++ b/arch/riscv/crypto/sha256-riscv64-glue.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux/riscv64 port of the OpenSSL SHA256 implementation for RISCV64
+ *
+ * Copyright (C) 2022 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ */
+
+#include <linux/types.h>
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <crypto/sha2.h>
+#include <crypto/sha256_base.h>
+
+asmlinkage void sha256_block_data_order_zvknha(u32 *digest, const void *data,
+					unsigned int num_blks);
+
+static void __sha256_block_data_order(struct sha256_state *sst, u8 const *src,
+				      int blocks)
+{
+	sha256_block_data_order_zvknha(sst->state, src, blocks);
+}
+
+static int riscv64_sha256_update(struct shash_desc *desc, const u8 *data,
+			 unsigned int len)
+{
+	if (crypto_simd_usable()) {
+		int ret;
+
+		kernel_rvv_begin();
+		ret = sha256_base_do_update(desc, data, len,
+					    __sha256_block_data_order);
+		kernel_rvv_end();
+		return ret;
+	} else { 
+		sha256_update(shash_desc_ctx(desc), data, len);
+		return 0;
+	}
+}
+
+static int riscv64_sha256_finup(struct shash_desc *desc, const u8 *data,
+			unsigned int len, u8 *out)
+{
+	if (!crypto_simd_usable()) {
+		sha256_update(shash_desc_ctx(desc), data, len);
+		sha256_final(shash_desc_ctx(desc), out);
+		return 0;
+	}
+
+	kernel_rvv_begin();
+	if (len)
+		sha256_base_do_update(desc, data, len,
+				      __sha256_block_data_order);
+
+	sha256_base_do_finalize(desc, __sha256_block_data_order);
+	kernel_rvv_end();
+
+	return sha256_base_finish(desc, out);
+}
+
+static int riscv64_sha256_final(struct shash_desc *desc, u8 *out)
+{
+	return riscv64_sha256_finup(desc, NULL, 0, out);
+}
+
+static struct shash_alg sha256_alg = {
+	.digestsize		= SHA256_DIGEST_SIZE,
+	.init			= sha256_base_init,
+	.update			= riscv64_sha256_update,
+	.final			= riscv64_sha256_final,
+	.finup			= riscv64_sha256_finup,
+	.descsize		= sizeof(struct sha256_state),
+	.base.cra_name		= "sha256",
+	.base.cra_driver_name	= "sha256-riscv64-zvknha",
+	.base.cra_priority	= 150,
+	.base.cra_blocksize	= SHA256_BLOCK_SIZE,
+	.base.cra_module	= THIS_MODULE,
+};
+
+static int __init sha256_mod_init(void)
+{
+	/*
+	 * From the spec:
+	 * Zvknhb supports SHA-256 and SHA-512. Zvknha supports only SHA-256.
+	 */
+	if ((riscv_isa_extension_available(NULL, ZVKNHA) ||
+	     riscv_isa_extension_available(NULL, ZVKNHB)) &&
+	     riscv_isa_extension_available(NULL, ZVKB) &&
+	     riscv_vector_vlen() >= 128)
+
+		return crypto_register_shash(&sha256_alg);
+
+	return 0;
+}
+
+static void __exit sha256_mod_fini(void)
+{
+	if ((riscv_isa_extension_available(NULL, ZVKNHA) ||
+	     riscv_isa_extension_available(NULL, ZVKNHB)) &&
+	     riscv_isa_extension_available(NULL, ZVKB) &&
+	     riscv_vector_vlen() >= 128)
+		crypto_unregister_shash(&sha256_alg);
+}
+
+module_init(sha256_mod_init);
+module_exit(sha256_mod_fini);
+
+MODULE_DESCRIPTION("SHA-256 secure hash for riscv64");
+MODULE_AUTHOR("Andy Polyakov <appro@openssl.org>");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("sha256");
diff --git a/arch/riscv/crypto/sha256-riscv64-zvknha.pl b/arch/riscv/crypto/sha256-riscv64-zvknha.pl
new file mode 100644
index 000000000000..c4ac20d7d138
--- /dev/null
+++ b/arch/riscv/crypto/sha256-riscv64-zvknha.pl
@@ -0,0 +1,284 @@
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
+# - RISC-V vector ('V') with VLEN >= 128
+# - Vector Bit-manipulation used in Cryptography ('Zvkb')
+# - Vector SHA-2 Secure Hash ('Zvknha')
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
+my ($V0, $V10, $V11, $V12, $V13, $V14, $V15, $V16, $V17) = ("v0", "v10", "v11", "v12", "v13", "v14","v15", "v16", "v17");
+my ($V26, $V27) = ("v26", "v27");
+
+my $K256 = "K256";
+
+# Function arguments
+my ($H, $INP, $LEN, $KT, $STRIDE) = ("a0", "a1", "a2", "a3", "t3");
+
+################################################################################
+# void sha256_block_data_order(void *c, const void *p, size_t len)
+$code .= <<___;
+.p2align 2
+.globl sha256_block_data_order_zvknha
+.type   sha256_block_data_order_zvknha,\@function
+sha256_block_data_order_zvknha:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    # H is stored as {a,b,c,d},{e,f,g,h}, but we need {f,e,b,a},{h,g,d,c}
+    # We achieve this by reading with a negative stride followed by
+    # element sliding.
+    li $STRIDE, -4
+    addi $H, $H, 12
+    @{[vlse32_v $V16, $H, $STRIDE]} # {d,c,b,a}
+    addi $H, $H, 16
+    @{[vlse32_v $V17, $H, $STRIDE]} # {h,g,f,e}
+    # Keep H advanced by 12
+    addi $H, $H, -16
+
+    @{[vmv_v_v $V27, $V16]} # {d,c,b,a}
+    @{[vslidedown_vi $V26, $V16, 2]} # {b,a,0,0}
+    @{[vslidedown_vi $V16, $V17, 2]} # {f,e,0,0}
+    @{[vslideup_vi $V16, $V26, 2]} # {f,e,b,a}
+    @{[vslideup_vi $V17, $V27, 2]} # {h,g,d,c}
+
+    # Keep the old state as we need it later: H' = H+{a',b',c',...,h'}.
+    @{[vmv_v_v $V26, $V16]}
+    @{[vmv_v_v $V27, $V17]}
+
+L_round_loop:
+    la $KT, $K256 # Load round constants K256
+
+    # Load the 512-bits of the message block in v10-v13 and perform
+    # an endian swap on each 4 bytes element.
+    @{[vle32_v $V10, $INP]}
+    @{[vrev8_v $V10, $V10]}
+    add $INP, $INP, 16
+    @{[vle32_v $V11, $INP]}
+    @{[vrev8_v $V11, $V11]}
+    add $INP, $INP, 16
+    @{[vle32_v $V12, $INP]}
+    @{[vrev8_v $V12, $V12]}
+    add $INP, $INP, 16
+    @{[vle32_v $V13, $INP]}
+    @{[vrev8_v $V13, $V13]}
+    add $INP, $INP, 16
+
+    # Decrement length by 1
+    add $LEN, $LEN, -1
+
+    # Set v0 up for the vmerge that replaces the first word (idx==0)
+    @{[vid_v $V0]}
+    @{[vmseq_vi $V0, $V0, 0x0]}    # v0.mask[i] = (i == 0 ? 1 : 0)
+
+    # Quad-round 0 (+0, Wt from oldest to newest in v10->v11->v12->v13)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+    @{[vsha2ms_vv $V10, $V14, $V13]}  # Generate W[19:16]
+
+    # Quad-round 1 (+1, v11->v12->v13->v10)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+    @{[vsha2ms_vv $V11, $V14, $V10]}  # Generate W[23:20]
+
+    # Quad-round 2 (+2, v12->v13->v10->v11)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+    @{[vsha2ms_vv $V12, $V14, $V11]}  # Generate W[27:24]
+
+    # Quad-round 3 (+3, v13->v10->v11->v12)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V11, $V10, $V0]}
+    @{[vsha2ms_vv $V13, $V14, $V12]}  # Generate W[31:28]
+
+    # Quad-round 4 (+0, v10->v11->v12->v13)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+    @{[vsha2ms_vv $V10, $V14, $V13]}  # Generate W[35:32]
+
+    # Quad-round 5 (+1, v11->v12->v13->v10)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+    @{[vsha2ms_vv $V11, $V14, $V10]}  # Generate W[39:36]
+
+    # Quad-round 6 (+2, v12->v13->v10->v11)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+    @{[vsha2ms_vv $V12, $V14, $V11]}  # Generate W[43:40]
+
+    # Quad-round 7 (+3, v13->v10->v11->v12)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V11, $V10, $V0]}
+    @{[vsha2ms_vv $V13, $V14, $V12]}  # Generate W[47:44]
+
+    # Quad-round 8 (+0, v10->v11->v12->v13)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+    @{[vsha2ms_vv $V10, $V14, $V13]}  # Generate W[51:48]
+
+    # Quad-round 9 (+1, v11->v12->v13->v10)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+    @{[vsha2ms_vv $V11, $V14, $V10]}  # Generate W[55:52]
+
+    # Quad-round 10 (+2, v12->v13->v10->v11)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+    @{[vsha2ms_vv $V12, $V14, $V11]}  # Generate W[59:56]
+
+    # Quad-round 11 (+3, v13->v10->v11->v12)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V11, $V10, $V0]}
+    @{[vsha2ms_vv $V13, $V14, $V12]}  # Generate W[63:60]
+
+    # Quad-round 12 (+0, v10->v11->v12->v13)
+    # Note that we stop generating new message schedule words (Wt, v10-13)
+    # as we already generated all the words we end up consuming (i.e., W[63:60]).
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+
+    # Quad-round 13 (+1, v11->v12->v13->v10)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+
+    # Quad-round 14 (+2, v12->v13->v10->v11)
+    @{[vle32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+
+    # Quad-round 15 (+3, v13->v10->v11->v12)
+    @{[vle32_v $V15, $KT]}
+    # No kt increment needed.
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+
+    # H' = H+{a',b',c',...,h'}
+    @{[vadd_vv $V16, $V26, $V16]}
+    @{[vadd_vv $V17, $V27, $V17]}
+    @{[vmv_v_v $V26, $V16]}
+    @{[vmv_v_v $V27, $V17]}
+    bnez $LEN, L_round_loop
+
+    # v26 = v16 = {f,e,b,a}
+    # v27 = v17 = {h,g,d,c}
+    # Let's do the opposit transformation like on entry.
+
+    @{[vslideup_vi $V17, $V16, 2]} # {h,g,f,e}
+
+    @{[vslidedown_vi $V16, $V27, 2]} # {d,c,0,0}
+    @{[vslidedown_vi $V26, $V26, 2]} # {b,a,0,0}
+    @{[vslideup_vi $V16, $V26, 2]} # {d,c,b,a}
+
+    # H is already advanced by 12
+    @{[vsse32_v $V16, $H, $STRIDE]} # {a,b,c,d}
+    addi $H, $H, 16
+    @{[vsse32_v $V17, $H, $STRIDE]} # {e,f,g,h}
+
+    ret
+.size sha256_block_data_order_zvknha,.-sha256_block_data_order_zvknha
+
+.p2align 2
+.type $K256,\@object
+$K256:
+    .word 0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5
+    .word 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5
+    .word 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3
+    .word 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174
+    .word 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc
+    .word 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da
+    .word 0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7
+    .word 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967
+    .word 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13
+    .word 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85
+    .word 0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3
+    .word 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070
+    .word 0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5
+    .word 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3
+    .word 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208
+    .word 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
+.size $K256,.-$K256
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.39.0

