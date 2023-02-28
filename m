Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68C96A5000
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjB1AJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjB1AJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:09:11 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28A3AB5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:08:41 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pWnVB-000552-D7; Tue, 28 Feb 2023 01:05:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     greentime.hu@sifive.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH RFC v2 13/16] RISC-V: crypto: add a vector-crypto-accelerated SHA512 implementation
Date:   Tue, 28 Feb 2023 01:05:41 +0100
Message-Id: <20230228000544.2234136-14-heiko@sntech.de>
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

This adds an accelerated SHA512 algorithm using either the Zvknhb
vector crypto extension.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/Kconfig                  |  11 +
 arch/riscv/crypto/Makefile                 |   8 +-
 arch/riscv/crypto/sha512-riscv64-glue.c    | 104 ++++++
 arch/riscv/crypto/sha512-riscv64-zvknhb.pl | 347 +++++++++++++++++++++
 4 files changed, 469 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sha512-riscv64-zvknhb.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 8645e02171f7..da6244f0c0c4 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -26,4 +26,15 @@ config CRYPTO_SHA256_RISCV64
 	  Architecture: riscv64 using
 	  - Zvknha or Zvknhb vector crypto extensions
 
+config CRYPTO_SHA512_RISCV64
+	tristate "Hash functions: SHA-512"
+	depends on 64BIT && RISCV_ISA_V
+	select CRYPTO_HASH
+	select CRYPTO_SHA512
+	help
+	  SHA-512 secure hash algorithm (FIPS 180)
+
+	  Architecture: riscv64
+	  - Zvknhb vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 02b3b4c32672..3c94753affdf 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -15,6 +15,9 @@ endif
 obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
 sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknhb.o
 
+obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
+sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -30,5 +33,8 @@ $(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
 $(obj)/sha256-riscv64-zvknhb.S: $(src)/sha256-riscv64-zvknha.pl
 	$(call cmd,perlasm)
 
+$(obj)/sha512-riscv64-zvknhb.S: $(src)/sha512-riscv64-zvknhb.pl
+	$(call cmd,perlasm)
+
 clean-files += ghash-riscv64-zbc.S ghash-riscv64-zvkb.S ghash-riscv64-zvkg.S
-clean-files += sha256-riscv64-zvknha.S
+clean-files += sha256-riscv64-zvknha.S sha512-riscv64-zvknhb.S
diff --git a/arch/riscv/crypto/sha512-riscv64-glue.c b/arch/riscv/crypto/sha512-riscv64-glue.c
new file mode 100644
index 000000000000..fc35ba269bbc
--- /dev/null
+++ b/arch/riscv/crypto/sha512-riscv64-glue.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux/riscv64 port of the OpenSSL SHA512 implementation for RISCV64
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
+#include <crypto/sha512_base.h>
+
+asmlinkage void sha512_block_data_order_zvknhb(u64 *digest, const void *data,
+					unsigned int num_blks);
+
+static void __sha512_block_data_order(struct sha512_state *sst, u8 const *src,
+				      int blocks)
+{
+	sha512_block_data_order_zvknhb(sst->state, src, blocks);
+}
+
+static int sha512_update(struct shash_desc *desc, const u8 *data,
+			 unsigned int len)
+{
+	if (crypto_simd_usable()) {
+		int ret;
+
+		kernel_rvv_begin();
+		ret = sha512_base_do_update(desc, data, len,
+					    __sha512_block_data_order);
+		kernel_rvv_end();
+		return ret;
+	} else { 
+		return crypto_sha512_update(desc, data, len);
+	}
+}
+
+static int sha512_finup(struct shash_desc *desc, const u8 *data,
+			unsigned int len, u8 *out)
+{
+	if (!crypto_simd_usable())
+		return crypto_sha512_finup(desc, data, len, out);
+
+	kernel_rvv_begin();
+	if (len)
+		sha512_base_do_update(desc, data, len,
+				      __sha512_block_data_order);
+
+	sha512_base_do_finalize(desc, __sha512_block_data_order);
+	kernel_rvv_end();
+
+	return sha512_base_finish(desc, out);
+}
+
+static int sha512_final(struct shash_desc *desc, u8 *out)
+{
+	return sha512_finup(desc, NULL, 0, out);
+}
+
+static struct shash_alg sha512_alg = {
+	.digestsize		= SHA512_DIGEST_SIZE,
+	.init			= sha512_base_init,
+	.update			= sha512_update,
+	.final			= sha512_final,
+	.finup			= sha512_finup,
+	.descsize		= sizeof(struct sha512_state),
+	.base.cra_name		= "sha512",
+	.base.cra_driver_name	= "sha512-riscv64-zvknhb",
+	.base.cra_priority	= 150,
+	.base.cra_blocksize	= SHA512_BLOCK_SIZE,
+	.base.cra_module	= THIS_MODULE,
+};
+
+static int __init sha512_mod_init(void)
+{
+	/* sha512 needs at least a vlen of 256 to work correctly */
+	if (riscv_isa_extension_available(NULL, ZVKNHB) &&
+	    riscv_isa_extension_available(NULL, ZVKB) &&
+	    riscv_vector_vlen() >= 256)
+		return crypto_register_shash(&sha512_alg);
+
+	return 0;
+}
+
+static void __exit sha512_mod_fini(void)
+{
+	if (riscv_isa_extension_available(NULL, ZVKNHB) &&
+	    riscv_isa_extension_available(NULL, ZVKB) &&
+	    riscv_vector_vlen() >= 256)
+		crypto_unregister_shash(&sha512_alg);
+}
+
+module_init(sha512_mod_init);
+module_exit(sha512_mod_fini);
+
+MODULE_DESCRIPTION("SHA-512 secure hash for riscv64");
+MODULE_AUTHOR("Andy Polyakov <appro@openssl.org>");
+MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_CRYPTO("sha512");
diff --git a/arch/riscv/crypto/sha512-riscv64-zvknhb.pl b/arch/riscv/crypto/sha512-riscv64-zvknhb.pl
new file mode 100644
index 000000000000..f7d609003358
--- /dev/null
+++ b/arch/riscv/crypto/sha512-riscv64-zvknhb.pl
@@ -0,0 +1,347 @@
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
+# - Vector SHA-2 Secure Hash ('Zvknhb')
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
+my $K512 = "K512";
+
+# Function arguments
+my ($H, $INP, $LEN, $KT, $STRIDE) = ("a0", "a1", "a2", "a3", "t3");
+
+################################################################################
+# void sha512_block_data_order(void *c, const void *p, size_t len)
+$code .= <<___;
+.p2align 2
+.globl sha512_block_data_order_zvknhb
+.type sha512_block_data_order_zvknhb,\@function
+sha512_block_data_order_zvknhb:
+    @{[vsetivli__x0_4_e64_m1_ta_ma]}
+
+    # H is stored as {a,b,c,d},{e,f,g,h}, but we need {f,e,b,a},{h,g,d,c}
+    # We achieve this by reading with a negative stride followed by
+    # element sliding.
+    li $STRIDE, -8
+    addi $H, $H, 24
+    @{[vlse64_v $V16, $H, $STRIDE]} # {d,c,b,a}
+    addi $H, $H, 32
+    @{[vlse64_v $V17, $H, $STRIDE]} # {h,g,f,e}
+    # Keep H advanced by 24
+    addi $H, $H, -32
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
+    la $KT, $K512 # Load round constants K512
+
+    # Load the 1024-bits of the message block in v10-v13 and perform
+    # an endian swap on each 4 bytes element.
+    @{[vle64_v $V10, $INP]}
+    @{[vrev8_v $V10, $V10]}
+    add $INP, $INP, 32
+    @{[vle64_v $V11, $INP]}
+    @{[vrev8_v $V11, $V11]}
+    add $INP, $INP, 32
+    @{[vle64_v $V12, $INP]}
+    @{[vrev8_v $V12, $V12]}
+    add $INP, $INP, 32
+    @{[vle64_v $V13, $INP]}
+    @{[vrev8_v $V13, $V13]}
+    add $INP, $INP, 32
+
+    # Decrement length by 1
+    add $LEN, $LEN, -1
+
+    # Set v0 up for the vmerge that replaces the first word (idx==0)
+    @{[vid_v $V0]}
+    @{[vmseq_vi $V0, $V0, 0x0]} # v0.mask[i] = (i == 0 ? 1 : 0)
+
+    # Quad-round 0 (+0, v10->v11->v12->v13)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+    @{[vsha2ms_vv $V10, $V14, $V13]}
+
+    # Quad-round 1 (+1, v11->v12->v13->v10)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+    @{[vsha2ms_vv $V11, $V14, $V10]}
+
+    # Quad-round 2 (+2, v12->v13->v10->v11)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+    @{[vsha2ms_vv $V12, $V14, $V11]}
+
+    # Quad-round 3 (+3, v13->v10->v11->v12)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V11, $V10, $V0]}
+    @{[vsha2ms_vv $V13, $V14, $V12]}
+
+    # Quad-round 4 (+0, v10->v11->v12->v13)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+    @{[vsha2ms_vv $V10, $V14, $V13]}
+
+    # Quad-round 5 (+1, v11->v12->v13->v10)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+    @{[vsha2ms_vv $V11, $V14, $V10]}
+
+    # Quad-round 6 (+2, v12->v13->v10->v11)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+    @{[vsha2ms_vv $V12, $V14, $V11]}
+
+    # Quad-round 7 (+3, v13->v10->v11->v12)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V11, $V10, $V0]}
+    @{[vsha2ms_vv $V13, $V14, $V12]}
+
+    # Quad-round 8 (+0, v10->v11->v12->v13)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+    @{[vsha2ms_vv $V10, $V14, $V13]}
+
+    # Quad-round 9 (+1, v11->v12->v13->v10)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+    @{[vsha2ms_vv $V11, $V14, $V10]}
+
+    # Quad-round 10 (+2, v12->v13->v10->v11)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+    @{[vsha2ms_vv $V12, $V14, $V11]}
+
+    # Quad-round 11 (+3, v13->v10->v11->v12)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V11, $V10, $V0]}
+    @{[vsha2ms_vv $V13, $V14, $V12]}
+
+    # Quad-round 12 (+0, v10->v11->v12->v13)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+    @{[vsha2ms_vv $V10, $V14, $V13]}
+
+    # Quad-round 13 (+1, v11->v12->v13->v10)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+    @{[vsha2ms_vv $V11, $V14, $V10]}
+
+    # Quad-round 14 (+2, v12->v13->v10->v11)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+    @{[vsha2ms_vv $V12, $V14, $V11]}
+
+    # Quad-round 15 (+3, v13->v10->v11->v12)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V13]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V11, $V10, $V0]}
+    @{[vsha2ms_vv $V13, $V14, $V12]}
+
+    # Quad-round 16 (+0, v10->v11->v12->v13)
+    # Note that we stop generating new message schedule words (Wt, v10-13)
+    # as we already generated all the words we end up consuming (i.e., W[79:76]).
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V10]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V12, $V11, $V0]}
+
+    # Quad-round 17 (+1, v11->v12->v13->v10)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V11]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V13, $V12, $V0]}
+
+    # Quad-round 18 (+2, v12->v13->v10->v11)
+    @{[vle64_v $V15, ($KT)]}
+    addi $KT, $KT, 32
+    @{[vadd_vv $V14, $V15, $V12]}
+    @{[vsha2cl_vv $V17, $V16, $V14]}
+    @{[vsha2ch_vv $V16, $V17, $V14]}
+    @{[vmerge_vvm $V14, $V10, $V13, $V0]}
+
+    # Quad-round 19 (+3, v13->v10->v11->v12)
+    @{[vle64_v $V15, ($KT)]}
+    # No t1 increment needed.
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
+    # H is already advanced by 24
+    @{[vsse64_v $V16, $H, $STRIDE]} # {a,b,c,d}
+    addi $H, $H, 32
+    @{[vsse64_v $V17, $H, $STRIDE]} # {e,f,g,h}
+
+    ret
+.size sha512_block_data_order_zvknhb,.-sha512_block_data_order_zvknhb
+
+.p2align 3
+.type $K512,\@object
+$K512:
+    .dword 0x428a2f98d728ae22, 0x7137449123ef65cd
+    .dword 0xb5c0fbcfec4d3b2f, 0xe9b5dba58189dbbc
+    .dword 0x3956c25bf348b538, 0x59f111f1b605d019
+    .dword 0x923f82a4af194f9b, 0xab1c5ed5da6d8118
+    .dword 0xd807aa98a3030242, 0x12835b0145706fbe
+    .dword 0x243185be4ee4b28c, 0x550c7dc3d5ffb4e2
+    .dword 0x72be5d74f27b896f, 0x80deb1fe3b1696b1
+    .dword 0x9bdc06a725c71235, 0xc19bf174cf692694
+    .dword 0xe49b69c19ef14ad2, 0xefbe4786384f25e3
+    .dword 0x0fc19dc68b8cd5b5, 0x240ca1cc77ac9c65
+    .dword 0x2de92c6f592b0275, 0x4a7484aa6ea6e483
+    .dword 0x5cb0a9dcbd41fbd4, 0x76f988da831153b5
+    .dword 0x983e5152ee66dfab, 0xa831c66d2db43210
+    .dword 0xb00327c898fb213f, 0xbf597fc7beef0ee4
+    .dword 0xc6e00bf33da88fc2, 0xd5a79147930aa725
+    .dword 0x06ca6351e003826f, 0x142929670a0e6e70
+    .dword 0x27b70a8546d22ffc, 0x2e1b21385c26c926
+    .dword 0x4d2c6dfc5ac42aed, 0x53380d139d95b3df
+    .dword 0x650a73548baf63de, 0x766a0abb3c77b2a8
+    .dword 0x81c2c92e47edaee6, 0x92722c851482353b
+    .dword 0xa2bfe8a14cf10364, 0xa81a664bbc423001
+    .dword 0xc24b8b70d0f89791, 0xc76c51a30654be30
+    .dword 0xd192e819d6ef5218, 0xd69906245565a910
+    .dword 0xf40e35855771202a, 0x106aa07032bbd1b8
+    .dword 0x19a4c116b8d2d0c8, 0x1e376c085141ab53
+    .dword 0x2748774cdf8eeb99, 0x34b0bcb5e19b48a8
+    .dword 0x391c0cb3c5c95a63, 0x4ed8aa4ae3418acb
+    .dword 0x5b9cca4f7763e373, 0x682e6ff3d6b2b8a3
+    .dword 0x748f82ee5defb2fc, 0x78a5636f43172f60
+    .dword 0x84c87814a1f0ab72, 0x8cc702081a6439ec
+    .dword 0x90befffa23631e28, 0xa4506cebde82bde9
+    .dword 0xbef9a3f7b2c67915, 0xc67178f2e372532b
+    .dword 0xca273eceea26619c, 0xd186b8c721c0c207
+    .dword 0xeada7dd6cde0eb1e, 0xf57d4f7fee6ed178
+    .dword 0x06f067aa72176fba, 0x0a637dc5a2c898a6
+    .dword 0x113f9804bef90dae, 0x1b710b35131c471b
+    .dword 0x28db77f523047d84, 0x32caab7b40c72493
+    .dword 0x3c9ebe0a15c9bebc, 0x431d67c49c100d4c
+    .dword 0x4cc5d4becb3e42b6, 0x597f299cfc657e2a
+    .dword 0x5fcb6fab3ad6faec, 0x6c44198c4a475817
+.size $K512,.-$K512
+___
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.39.0

