Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F468CA8A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBFXaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBFX34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:29:56 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61926BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:29:53 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pPARn-0002Mb-EY; Mon, 06 Feb 2023 23:58:51 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     greentime.hu@sifive.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH RFC 12/12] RISC-V: crypto: add a vector-crypto-accelerated SHA256 implementation
Date:   Mon,  6 Feb 2023 23:58:46 +0100
Message-Id: <20230206225846.1381789-13-heiko@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206225846.1381789-1-heiko@sntech.de>
References: <20230206225846.1381789-1-heiko@sntech.de>
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
 arch/riscv/crypto/Kconfig                  |  10 +
 arch/riscv/crypto/Makefile                 |   7 +
 arch/riscv/crypto/sha256-riscv64-glue.c    | 103 +++++
 arch/riscv/crypto/sha256-riscv64-zvknha.pl | 502 +++++++++++++++++++++
 4 files changed, 622 insertions(+)
 create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 84da19bdde8b..c4e7d7526f1a 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -15,4 +15,14 @@ config CRYPTO_GHASH_RISCV64
 	  - ZVKB vector crypto extension
 	  - ZVKG vector crypto extension
 
+config CRYPTO_SHA256_RISCV64
+	tristate "Hash functions: SHA-256"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_HASH
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
index 000000000000..bde46907a823
--- /dev/null
+++ b/arch/riscv/crypto/sha256-riscv64-glue.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux/riscv64 port of the OpenSSL SHA256 implementation for RISCV64
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
+EXPORT_SYMBOL(sha256_block_data_order_zvknha);
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
+		return crypto_sha256_update(desc, data, len);
+	}
+}
+
+static int riscv64_sha256_finup(struct shash_desc *desc, const u8 *data,
+			unsigned int len, u8 *out)
+{
+	if (!crypto_simd_usable())
+		return crypto_sha256_finup(desc, data, len, out);
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
+	if (riscv_isa_extension_available(NULL, ZVKNHA) ||
+	    riscv_isa_extension_available(NULL, ZVKNHB))
+		return crypto_register_shash(&sha256_alg);
+
+	return 0;
+}
+
+static void __exit sha256_mod_fini(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKNHA) ||
+	    riscv_isa_extension_available(NULL, ZVKNHB))
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
index 000000000000..c15978926287
--- /dev/null
+++ b/arch/riscv/crypto/sha256-riscv64-zvknha.pl
@@ -0,0 +1,502 @@
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
+# - RISC-V vector ('V')
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
+my ($H, $INP, $KT, $LEN, $STRIDE) = ("a0", "a1", "a2", "a3", "t3");
+
+################################################################################
+# void sha256_block_data_order(void *c, const void *p, size_t len)
+$code .= <<___;
+.p2align 2
+.globl sha256_block_data_order_zvknha
+.type   sha256_block_data_order_zvknha,\@function
+sha256_block_data_order_zvknha:
+
+    # $LEN is stored in a2
+    mv $LEN, a2
+
+    # Register use in this function:
+    #
+    # SCALARS:
+    #  a0 (i.e., x10): initially the address of the first byte of `hash`,
+    #      modified during the logic.
+    #  a1: initially the address of the first byte of the message block,
+    #      modified during the initial load.
+    #  a2: initially the address of the first byte of the round constants
+    #      'Kt', incremented during the rounds.
+    #
+    # VECTORS
+    #  v10 - v13 (512-bits / 4*128 bits / 4*4*32 bits), hold the message
+    #             schedule words (Wt). They start with the message block
+    #             content (W0 to W15), then further words in the message
+    #             schedule generated via vsha2ms from previous Wt.
+    #   Initially:
+    #     v10 = W[  3:0] = { W3,  W2,  W1,  W0}
+    #     v11 = W[  7:4] = { W7,  W6,  W5,  W4}
+    #     v12 = W[ 11:8] = {W11, W10,  W9,  W8}
+    #     v13 = W[15:12] = {W15, W14, W13, W12}
+    #
+    #  v16 - v17 hold the working state variables (a, b, ..., h)
+    #    v16 = {a[t],b[t],e[t],f[t]}
+    #    v17 = {c[t],d[t],g[t],h[t]}
+    #   Initially:
+    #    v16 = {H5i-1, H4i-1, H1i-1 , H0i-1}
+    #    v17 = {H7i-i, H6i-1, H3i-1 , H2i-1}
+    #
+    #  v0 = masks for vrgather/vmerge. Single value during the 16 rounds.
+    #
+    #  v14 = temporary, Wt+Kt
+    #  v15 = temporary, Kt
+    #
+    #  v18/v19 = temporaries, in the epilogue, to re-arrange
+    #            and byte-swap v16/v17
+    #
+    #  v26/v27 = hold the initial values of the hash, byte-swapped.
+    #
+    #  v30/v31 = used to generate masks, vrgather indices.
+    #
+    # During most of the function the vector state is configured so that each
+    # vector is interpreted as containing four 32 bits (e32) elements (128 bits).
+
+    # Set vectors as 4 * 32 bits
+    #
+    # e32: vector of 32b/4B elements
+    # m1: LMUL=1
+    # ta: tail agnostic (don't care about those lanes)
+    # ma: mask agnostic (don't care about those lanes)
+    # x0 is not written, we known the number of vector elements, 4.
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+
+    # Load H[0..8] to produce
+    #  v26 = v16 = {a[t],b[t],e[t],f[t]}
+    #  v27 = v17 = {c[t],d[t],g[t],h[t]}
+    #
+    # To minimize per-block work, H is provided as {f,e,b,a, h,g,d,c}
+    # with the bytes in little endian order, i.e., not in NIST endianness
+    # or order.
+    @{[vle32_v $V16, $H]}
+    @{[vmv_v_v $V26, $V16]}
+    addi $H, $H, 16
+    @{[vle32_v $V17, $H]}
+    @{[vmv_v_v $V27, $V17]}
+    addi $H, $H, -16
+
+    @{[vslideup_vi $V16, $V27, 2]}
+    @{[vslidedown_vi $V17, $V26, 2]}
+    @{[vslidedown_vi $V26, $V27, 2]}
+    @{[vslideup_vi $V17, $V26, 2]}
+
+    @{[vse32_v $V16, $H]}
+    addi $H, $H, 16
+    @{[vse32_v $V17, $H]}
+    addi $H, $H, -16
+    @{[vmv_v_v $V26, $V16]}
+
+    li $STRIDE, -4
+
+    addi $H, $H, 12
+    @{[vlse32_v $V16, $H, $STRIDE]}
+    @{[vmv_v_v $V26, $V16]}
+
+    addi $H, $H, 16
+    @{[vlse32_v $V17, $H, $STRIDE]}
+    @{[vmv_v_v $V27, $V17]}
+    addi $H, $H, -28
+
+
+    # Load the 512-bits of the message block in v10-v13 and perform
+    # an endian swap on each 4 bytes element.
+    #
+    # If Zvkb is not implemented, one can use vrgather with the right index
+    # sequence. It requires loading in separate registers since the destination
+    # of vrgather cannot overlap the source.
+    #    # We generate the lane (byte) index sequence
+    #    #    v24 = [3 2 1 0   7 6 5 4  11 10 9 8   15 14 13 12]
+    #    # <https://oeis.org/A004444> gives us "N ^ 3" as a nice formula to generate
+    #    # this sequence. 'vid' gives us the N.
+    #    #
+    #    # We switch the vector type to SEW=8 temporarily.
+    #    vsetivli x0, 16, e8, m1, ta, ma
+    #    vid.v v24
+    #    vxor.vi v24, v24, 0x3
+    #    # Byteswap the bytes in each word of the text.
+    #    vrgather.vv v10, v20, v24
+    #    vrgather.vv v11, v21, v24
+    #    vrgather.vv v12, v22, v24
+    #    vrgather.vv v13, v23, v24
+    #    # Switch back to SEW=32
+    #    vsetivli x0, 4, e32, m1, ta, ma
+
+L_round_loop:
+    la $KT, $K256 # Load round constants K256
+
+    # First loop part
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
+    # Overview of the logic in each "quad round".
+    #
+    # The code below repeats 16 times the logic implementing four rounds
+    # of the SHA-256 core loop as documented by NIST. 16 "quad rounds"
+    # to implementing the 64 single rounds.
+    #
+    #    # Load four word (u32) constants (K[t+3], K[t+2], K[t+1], K[t+0])
+    #    # Output:
+    #    #   v15 = {K[t+3], K[t+2], K[t+1], K[t+0]}
+    #    vl1re32.v v15, (a2)
+    #
+    #    # Increment word contant address by stride (16 bytes, 4*4B, 128b)
+    #    addi a2, a2, 16
+    #
+    #    # Add constants to message schedule words:
+    #    #  Input
+    #    #    v15 = {K[t+3], K[t+2], K[t+1], K[t+0]}
+    #    #    v10 = {W[t+3], W[t+2], W[t+1], W[t+0]}; // Vt0 = W[3:0];
+    #    #  Output
+    #    #    v14 = {W[t+3]+K[t+3], W[t+2]+K[t+2], W[t+1]+K[t+1], W[t+0]+K[t+0]}
+    #    vadd.vv v14, v15, v10
+    #
+    #    #  2 rounds of working variables updates.
+    #    #     v17[t+4] <- v17[t], v16[t], v14[t]
+    #    #  Input:
+    #    #    v17 = {c[t],d[t],g[t],h[t]}   " = v17[t] "
+    #    #    v16 = {a[t],b[t],e[t],f[t]}
+    #    #    v14 = {W[t+3]+K[t+3], W[t+2]+K[t+2], W[t+1]+K[t+1], W[t+0]+K[t+0]}
+    #    #  Output:
+    #    #    v17 = {f[t+2],e[t+2],b[t+2],a[t+2]}  " = v16[t+2] "
+    #    #        = {h[t+4],g[t+4],d[t+4],c[t+4]}  " = v17[t+4] "
+    #    vsha2cl.vv v17, v16, v14
+    #
+    #    #  2 rounds of working variables updates.
+    #    #     v16[t+4] <- v16[t], v16[t+2], v14[t]
+    #    #  Input
+    #    #   v16 = {a[t],b[t],e[t],f[t]}       " = v16[t] "
+    #    #       = {h[t+2],g[t+2],d[t+2],c[t+2]}   " = v17[t+2] "
+    #    #   v17 = {f[t+2],e[t+2],b[t+2],a[t+2]}   " = v16[t+2] "
+    #    #   v14 = {W[t+3]+K[t+3], W[t+2]+K[t+2], W[t+1]+K[t+1], W[t+0]+K[t+0]}
+    #    #  Output:
+    #    #   v16 = {f[t+4],e[t+4],b[t+4],a[t+4]}   " = v16[t+4] "
+    #    vsha2ch.vv v16, v17, v14
+    #
+    #    # Combine 2QW into 1QW
+    #    #
+    #    # To generate the next 4 words, "new_v10"/"v14" from v10-v13, vsha2ms needs
+    #    #     v10[0..3], v11[0], v12[1..3], v13[0, 2..3]
+    #    # and it can only take 3 vectors as inputs. Hence we need to combine
+    #    # v11[0] and v12[1..3] in a single vector.
+    #    #
+    #    # vmerge Vt4, Vt1, Vt2, V0
+    #    # Input
+    #    #  V0 = mask // first word from v12, 1..3 words from v11
+    #    #  V12 = {Wt-8, Wt-7, Wt-6, Wt-5}
+    #    #  V11 = {Wt-12, Wt-11, Wt-10, Wt-9}
+    #    # Output
+    #    #  Vt4 = {Wt-12, Wt-7, Wt-6, Wt-5}
+    #    vmerge.vvm v14, v12, v11, v0
+    #
+    #    # Generate next Four Message Schedule Words (hence allowing for 4 more rounds)
+    #    # Input
+    #    #  V10 = {W[t+ 3], W[t+ 2], W[t+ 1], W[t+ 0]}     W[ 3: 0]
+    #    #  V13 = {W[t+15], W[t+14], W[t+13], W[t+12]}     W[15:12]
+    #    #  V14 = {W[t+11], W[t+10], W[t+ 9], W[t+ 4]}     W[11: 9,4]
+    #    # Output (next four message schedule words)
+    #    #  v10 = {W[t+19],  W[t+18],  W[t+17],  W[t+16]}  W[19:16]
+    #    vsha2ms.vv v10, v14, v13
+    #
+    # BEFORE
+    #  v10 - v13 hold the message schedule words (initially the block words)
+    #    v10 = W[ 3: 0]   "oldest"
+    #    v11 = W[ 7: 4]
+    #    v12 = W[11: 8]
+    #    v13 = W[15:12]   "newest"
+    #
+    #  vt6 - vt7 hold the working state variables
+    #    v16 = {a[t],b[t],e[t],f[t]}   // initially {H5,H4,H1,H0}
+    #    v17 = {c[t],d[t],g[t],h[t]}   // initially {H7,H6,H3,H2}
+    #
+    # AFTER
+    #  v10 - v13 hold the message schedule words (initially the block words)
+    #    v11 = W[ 7: 4]   "oldest"
+    #    v12 = W[11: 8]
+    #    v13 = W[15:12]
+    #    v10 = W[19:16]   "newest"
+    #
+    #  v16 and v17 hold the working state variables
+    #    v16 = {a[t+4],b[t+4],e[t+4],f[t+4]}
+    #    v17 = {c[t+4],d[t+4],g[t+4],h[t+4]}
+    #
+    #  The group of vectors v10,v11,v12,v13 is "rotated" by one in each quad-round,
+    #  hence the uses of those vectors rotate in each round, and we get back to the
+    #  initial configuration every 4 quad-rounds. We could avoid those changes at
+    #  the cost of moving those vectors at the end of each quad-rounds.
+
+    #--------------------------------------------------------------------------------
+    # Quad-round 0 (+0, Wt from oldest to newest in v10->v11->v12->v13)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+    @{[vsha2ms_vv $V10, $V14, $V13]}  # Generate W[19:16]
+    #--------------------------------------------------------------------------------
+    # Quad-round 1 (+1, v11->v12->v13->v10)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+    @{[vsha2ms_vv $V11, $V14, $V10]}  # Generate W[23:20]
+    #--------------------------------------------------------------------------------
+    # Quad-round 2 (+2, v12->v13->v10->v11)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+    @{[vsha2ms_vv $V12, $V14, $V11]}  # Generate W[27:24]
+    #--------------------------------------------------------------------------------
+    # Quad-round 3 (+3, v13->v10->v11->v12)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V11, $V10, $V0]}
+    @{[vsha2ms_vv $V13, $V14, $V12]}  # Generate W[31:28]
+
+    #--------------------------------------------------------------------------------
+    # Quad-round 4 (+0, v10->v11->v12->v13)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+    @{[vsha2ms_vv $V10, $V14, $V13]}  # Generate W[35:32]
+    #--------------------------------------------------------------------------------
+    # Quad-round 5 (+1, v11->v12->v13->v10)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+    @{[vsha2ms_vv $V11, $V14, $V10]}  # Generate W[39:36]
+    #--------------------------------------------------------------------------------
+    # Quad-round 6 (+2, v12->v13->v10->v11)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+    @{[vsha2ms_vv $V12, $V14, $V11]}  # Generate W[43:40]
+    #--------------------------------------------------------------------------------
+    # Quad-round 7 (+3, v13->v10->v11->v12)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V11, $V10, $V0]}
+    @{[vsha2ms_vv $V13, $V14, $V12]}  # Generate W[47:44]
+
+    #--------------------------------------------------------------------------------
+    # Quad-round 8 (+0, v10->v11->v12->v13)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+    @{[vsha2ms_vv $V10, $V14, $V13]}  # Generate W[51:48]
+    #--------------------------------------------------------------------------------
+    # Quad-round 9 (+1, v11->v12->v13->v10)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+    @{[vsha2ms_vv $V11, $V14, $V10]}  # Generate W[55:52]
+    #--------------------------------------------------------------------------------
+    # Quad-round 10 (+2, v12->v13->v10->v11)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+    @{[vsha2ms_vv $V12, $V14, $V11]}  # Generate W[59:56]
+    #--------------------------------------------------------------------------------
+    # Quad-round 11 (+3, v13->v10->v11->v12)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V11, $V10, $V0]}
+    @{[vsha2ms_vv $V13, $V14, $V12]}  # Generate W[63:60]
+
+    #--------------------------------------------------------------------------------
+    # Quad-round 12 (+0, v10->v11->v12->v13)
+    # Note that we stop generating new message schedule words (Wt, v10-13)
+    # as we already generated all the words we end up consuming (i.e., W[63:60]).
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    #--------------------------------------------------------------------------------
+    # Quad-round 13 (+1, v11->v12->v13->v10)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    #--------------------------------------------------------------------------------
+    # Quad-round 14 (+2, v12->v13->v10->v11)
+    @{[vl1re32_v $V15, $KT]}
+    addi $KT, $KT, 16
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+    #--------------------------------------------------------------------------------
+    # Quad-round 15 (+3, v13->v10->v11->v12)
+    @{[vl1re32_v $V15, $KT]}
+    # No kt increment needed.
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vslidedown_vi $V14, $V14, 2]}
+    @{[vsha2cl_vv $V16, $V17, $V14]}
+
+    # H' = H+{a',b',c',...,h'}
+    @{[vadd_vv $V16, $V26, $V16]}
+    @{[vadd_vv $V17, $V27, $V17]}
+    @{[vmv_v_v $V26, $V16]}
+    @{[vmv_v_v $V27, $V17]}
+    bnez $LEN, L_round_loop
+
+L_end:
+    @{[vmv_v_v $V26, $V16]}
+    @{[vmv_v_v $V27, $V17]}
+
+    addi $H, $H, 12
+    @{[vsse32_v $V16, $H, $STRIDE]}
+    @{[vmv_v_v $V26, $V16]}
+
+    addi $H, $H, 16
+    @{[vsse32_v $V17, $H, $STRIDE]}
+    @{[vmv_v_v $V27, $V17]}
+    addi $H, $H, -28
+
+    @{[vle32_v $V16, $H]}
+    @{[vmv_v_v $V26, $V16]}
+    addi $H, $H, 16
+    @{[vle32_v $V17, $H]}
+    @{[vmv_v_v $V27, $V17]}
+    addi $H, $H, -16
+
+    @{[vslideup_vi $V16, $V27, 2]}
+    @{[vslidedown_vi $V17, $V26, 2]}
+    @{[vslidedown_vi $V26, $V27, 2]}
+    @{[vslideup_vi $V17, $V26, 2]}
+
+    @{[vse32_v $V16, $H]}
+    addi $H, $H, 16
+    @{[vse32_v $V17, $H]}
+    ret
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
+___
+
+print $code;
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.39.0

