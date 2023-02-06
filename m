Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DD968CA89
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjBFXaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjBFX3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:29:53 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3601A420A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:29:52 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pPARn-0002Mb-5v; Mon, 06 Feb 2023 23:58:51 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@rivosinc.com
Cc:     greentime.hu@sifive.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH RFC 11/12] RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
Date:   Mon,  6 Feb 2023 23:58:45 +0100
Message-Id: <20230206225846.1381789-12-heiko@sntech.de>
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

When the Zvkg vector crypto extension is available another optimized
gcm ghash variant is possible, so add it as another implmentation.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/crypto/Kconfig               |   1 +
 arch/riscv/crypto/Makefile              |   7 +-
 arch/riscv/crypto/ghash-riscv64-glue.c  |  80 +++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl | 172 ++++++++++++++++++++++++
 4 files changed, 258 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 404fd9b3cb7c..84da19bdde8b 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -13,5 +13,6 @@ config CRYPTO_GHASH_RISCV64
 	  Architecture: riscv64 using one of:
 	  - ZBC extension
 	  - ZVKB vector crypto extension
+	  - ZVKG vector crypto extension
 
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 8ab9a0ae8f2d..1ee0ce7d3264 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -9,7 +9,7 @@ ifdef CONFIG_RISCV_ISA_ZBC
 ghash-riscv64-y += ghash-riscv64-zbc.o
 endif
 ifdef CONFIG_RISCV_ISA_V
-ghash-riscv64-y += ghash-riscv64-zvkb.o
+ghash-riscv64-y += ghash-riscv64-zvkb.o ghash-riscv64-zvkg.o
 endif
 
 quiet_cmd_perlasm = PERLASM $@
@@ -21,4 +21,7 @@ $(obj)/ghash-riscv64-zbc.S: $(src)/ghash-riscv64-zbc.pl
 $(obj)/ghash-riscv64-zvkb.S: $(src)/ghash-riscv64-zvkb.pl
 	$(call cmd,perlasm)
 
-clean-files += ghash-riscv64-zbc.S ghash-riscv64-zvkb.S
+$(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
+	$(call cmd,perlasm)
+
+clean-files += ghash-riscv64-zbc.S ghash-riscv64-zvkb.S ghash-riscv64-zvkg.S
diff --git a/arch/riscv/crypto/ghash-riscv64-glue.c b/arch/riscv/crypto/ghash-riscv64-glue.c
index 7376a8a793aa..4fed99e98019 100644
--- a/arch/riscv/crypto/ghash-riscv64-glue.c
+++ b/arch/riscv/crypto/ghash-riscv64-glue.c
@@ -31,6 +31,10 @@ void gcm_ghash_rv64i_zbc__zbkb(u64 Xi[2], const u128 Htable[16],
 void gcm_ghash_rv64i_zvkb(u64 Xi[2], const u128 Htable[16],
 			  const u8 *inp, size_t len);
 
+/* Zvkg (vector crypto with vghmac.vv). */
+void gcm_ghash_rv64i_zvkg(u64 Xi[2], const u128 Htable[16],
+			  const u8 *inp, size_t len);
+
 struct riscv64_ghash_ctx {
 	void (*ghash_func)(u64 Xi[2], const u128 Htable[16],
 			   const u8 *inp, size_t len);
@@ -187,6 +191,63 @@ struct shash_alg riscv64_zvkb_ghash_alg = {
 	},
 };
 
+RISCV64_ZVK_SETKEY(zvkg, zvkg);
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
+RISCV64_ZVK_SETKEY(zvkg__zbb_or_zbkb, zvkg);
+struct shash_alg riscv64_zvkg_zbb_or_zbkb_ghash_alg = {
+	.digestsize = GHASH_DIGEST_SIZE,
+	.init = riscv64_ghash_init,
+	.update = riscv64_zvk_ghash_update,
+	.final = riscv64_zvk_ghash_final,
+	.setkey = riscv64_zvk_ghash_setkey_zvkg__zbb_or_zbkb,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx)
+		    + sizeof(struct ghash_desc_ctx),
+	.base = {
+		 .cra_name = "ghash",
+		 .cra_driver_name = "riscv64_zvkg_zbb_or_zbkb_ghash",
+		 .cra_priority = 302,
+		 .cra_blocksize = GHASH_BLOCK_SIZE,
+		 .cra_ctxsize = sizeof(struct riscv64_ghash_ctx),
+		 .cra_module = THIS_MODULE,
+	},
+};
+
+RISCV64_ZVK_SETKEY(zvkg__zvkb, zvkg);
+struct shash_alg riscv64_zvkg_zvkb_ghash_alg = {
+	.digestsize = GHASH_DIGEST_SIZE,
+	.init = riscv64_ghash_init,
+	.update = riscv64_zvk_ghash_update,
+	.final = riscv64_zvk_ghash_final,
+	.setkey = riscv64_zvk_ghash_setkey_zvkg__zvkb,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx)
+		    + sizeof(struct ghash_desc_ctx),
+	.base = {
+		 .cra_name = "ghash",
+		 .cra_driver_name = "riscv64_zvkg_zvkb_ghash",
+		 .cra_priority = 303,
+		 .cra_blocksize = GHASH_BLOCK_SIZE,
+		 .cra_ctxsize = sizeof(struct riscv64_ghash_ctx),
+		 .cra_module = THIS_MODULE,
+	},
+};
+
 #endif /* CONFIG_RISCV_ISA_V */
 
 #ifdef CONFIG_RISCV_ISA_ZBC
@@ -385,6 +446,25 @@ static int __init riscv64_ghash_mod_init(void)
 		if (ret < 0)
 			return ret;
 	}
+
+	if (riscv_isa_extension_available(NULL, ZVKG)) {
+		ret = riscv64_ghash_register(&riscv64_zvkg_ghash_alg);
+		if (ret < 0)
+			return ret;
+
+		if (riscv_isa_extension_available(NULL, ZVKB)) {
+			ret = riscv64_ghash_register(&riscv64_zvkg_zvkb_ghash_alg);
+			if (ret < 0)
+				return ret;
+		}
+
+		if (riscv_isa_extension_available(NULL, ZBB) ||
+		    riscv_isa_extension_available(NULL, ZBKB)) {
+			ret = riscv64_ghash_register(&riscv64_zvkg_zbb_or_zbkb_ghash_alg);
+			if (ret < 0)
+				return ret;
+		}
+	}
 #endif
 
 	return 0;
diff --git a/arch/riscv/crypto/ghash-riscv64-zvkg.pl b/arch/riscv/crypto/ghash-riscv64-zvkg.pl
new file mode 100644
index 000000000000..1331d498f1f1
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-zvkg.pl
@@ -0,0 +1,172 @@
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
+# void gcm_init_rv64i_zvkg__zbb_or_zbkb(u128 Htable[16], const u64 H[2]);
+# void gcm_init_rv64i_zvkg__zvkb(u128 Htable[16], const u64 H[2]);
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
+    # First word
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
+my ($Htable,$H,$TMP0,$TMP1) = ("a0","a1","t0","t1");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_init_rv64i_zvkg__zbb_or_zbkb
+.type gcm_init_rv64i_zvkg__zbb_or_zbkb,\@function
+gcm_init_rv64i_zvkg__zbb_or_zbkb:
+    ld      $TMP0,0($H)
+    ld      $TMP1,8($H)
+    @{[rev8 $TMP0, $TMP0]}           #rev8    $TMP0, $TMP0
+    @{[rev8 $TMP1, $TMP1]}           #rev8    $TMP1, $TMP1
+    sd      $TMP0,0($Htable)
+    sd      $TMP1,8($Htable)
+    ret
+.size gcm_init_rv64i_zvkg__zbb_or_zbkb,.-gcm_init_rv64i_zvkg__zbb_or_zbkb
+___
+}
+
+{
+my ($Htable,$H,$V0) = ("a0","a1","v0");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_init_rv64i_zvkg__zvkb
+.type gcm_init_rv64i_zvkg__zvkb,\@function
+gcm_init_rv64i_zvkg__zvkb:
+    # All callers of this function revert the byte-order unconditionally
+    # on little-endian machines. So we need to revert the byte-order back.
+    @{[vsetivli__x0_2_e64_m1_ta_ma]} # vsetivli x0, 2, e64, m1, ta, ma
+    @{[vle64_v $V0, $H]}             # vle64.v v0, (a1)
+    @{[vrev8_v $V0, $V0]}            # vrev8.v v0, v0
+    @{[vse64_v $V0, $Htable]}        # vse64.v v0, (a0)
+    ret
+.size gcm_init_rv64i_zvkg__zvkb,.-gcm_init_rv64i_zvkg__zvkb
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
+my ($VD,$VS1,$VS2) = ("v1","v2","v3");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_gmult_rv64i_zvkg
+.type gcm_gmult_rv64i_zvkg,\@function
+gcm_gmult_rv64i_zvkg:
+    @{[vsetivli__x0_4_e32_m1_ta_ma]}
+    @{[vle32_v $VS1, $Htable]}
+    @{[vle32_v $VD, $Xi]}
+    # Use a zero-block as input
+    # This works because zero is the neutral element of XOR
+    @{[vmv_v_i $VS2, 0]}
+    @{[vghmac_vv $VD, $VS2, $VS1]}
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
+    # First loop part
+    @{[vle32_v $vinp, $inp]}
+    @{[vxor_vv $vXi, $vXi, $vinp]}
+    add $inp, $inp, 16
+    add $len, $len, -16
+    beqz $len, Lend
+
+Lstep:
+    @{[vle32_v $vinp, $inp]}
+    add $inp, $inp, 16
+    add $len, $len, -16
+    @{[vghmac_vv $vXi, $vinp, $vH]}
+    bnez $len, Lstep
+
+Lend:
+    # Final multiplication (no XOR operation)
+    @{[vmv_v_i $Vzero, 0]}
+    @{[vghmac_vv $vXi, $Vzero, $vH]}
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
2.39.0

