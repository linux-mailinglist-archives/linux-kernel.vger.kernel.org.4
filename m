Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B266E5784
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjDRCcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDRCcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E131FD4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 438FA62C4B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41B2C433D2;
        Tue, 18 Apr 2023 02:32:39 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Min Zhou <zhoumin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: crypto: Add crc32 and crc32c hw acceleration
Date:   Tue, 18 Apr 2023 10:32:13 +0800
Message-Id: <20230418023213.1995119-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Zhou <zhoumin@loongson.cn>

With a blatant copy of some MIPS bits we introduce the crc32 and crc32c
hw accelerated module to LoongArch.

LoongArch has provided these instructions to calculate crc32 and crc32c:
        * crc.w.b.w    crcc.w.b.w
        * crc.w.h.w    crcc.w.h.w
        * crc.w.w.w    crcc.w.w.w
        * crc.w.d.w    crcc.w.d.w

So we can make use of these instructions to improve the performance of
calculation for crc32(c) checksums.

As can be seen from the following test results, crc32(c) instructions
can improve the performance by 58%.

                  Software implemention    Hardware acceleration
  Buffer size     time cost (seconds)      time cost (seconds)    Accel.
   100 KB                0.000845                 0.000534        59.1%
     1 MB                0.007758                 0.004836        59.4%
    10 MB                0.076593                 0.047682        59.4%
   100 MB                0.756734                 0.479126        58.5%
  1000 MB                7.563841                 4.778266        58.5%

Signed-off-by: Min Zhou <zhoumin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Makefile                 |   2 +
 arch/loongarch/crypto/Kconfig           |  14 ++
 arch/loongarch/crypto/Makefile          |   6 +
 arch/loongarch/crypto/crc32-loongarch.c | 304 ++++++++++++++++++++++++
 crypto/Kconfig                          |   3 +
 5 files changed, 329 insertions(+)
 create mode 100644 arch/loongarch/crypto/Kconfig
 create mode 100644 arch/loongarch/crypto/Makefile
 create mode 100644 arch/loongarch/crypto/crc32-loongarch.c

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index f71edf574101..a27e264bdaa5 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -115,6 +115,8 @@ endif
 libs-y += arch/loongarch/lib/
 libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+drivers-y		+= arch/loongarch/crypto/
+
 # suspend and hibernation support
 drivers-$(CONFIG_PM)	+= arch/loongarch/power/
 
diff --git a/arch/loongarch/crypto/Kconfig b/arch/loongarch/crypto/Kconfig
new file mode 100644
index 000000000000..200a6e8b43b1
--- /dev/null
+++ b/arch/loongarch/crypto/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Accelerated Cryptographic Algorithms for CPU (loongarch)"
+
+config CRYPTO_CRC32_LOONGARCH
+	tristate "CRC32c and CRC32"
+	select CRC32
+	select CRYPTO_HASH
+	help
+	  CRC32c and CRC32 CRC algorithms
+
+	  Architecture: LoongArch with CRC32 instructions
+
+endmenu
diff --git a/arch/loongarch/crypto/Makefile b/arch/loongarch/crypto/Makefile
new file mode 100644
index 000000000000..d22613d27ce9
--- /dev/null
+++ b/arch/loongarch/crypto/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for LoongArch crypto files..
+#
+
+obj-$(CONFIG_CRYPTO_CRC32_LOONGARCH) += crc32-loongarch.o
diff --git a/arch/loongarch/crypto/crc32-loongarch.c b/arch/loongarch/crypto/crc32-loongarch.c
new file mode 100644
index 000000000000..1f2a2c3839bc
--- /dev/null
+++ b/arch/loongarch/crypto/crc32-loongarch.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * crc32.c - CRC32 and CRC32C using LoongArch crc* instructions
+ *
+ * Module based on mips/crypto/crc32-mips.c
+ *
+ * Copyright (C) 2014 Linaro Ltd <yazen.ghannam@linaro.org>
+ * Copyright (C) 2018 MIPS Tech, LLC
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/module.h>
+#include <crypto/internal/hash.h>
+
+#include <asm/cpu-features.h>
+#include <asm/unaligned.h>
+
+#define _CRC32(crc, value, size, type)			\
+do {							\
+	__asm__ __volatile__(				\
+		#type ".w." #size ".w" " %0, %1, %0\n\t"\
+		: "+r" (crc)				\
+		: "r" (value)				\
+		: "memory");				\
+} while (0)
+
+#define CRC32(crc, value, size)		_CRC32(crc, value, size, crc)
+#define CRC32C(crc, value, size)	_CRC32(crc, value, size, crcc)
+
+static u32 crc32_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
+{
+	u32 crc = crc_;
+
+	while (len >= sizeof(u64)) {
+		u64 value = get_unaligned_le64(p);
+
+		CRC32(crc, value, d);
+		p += sizeof(u64);
+		len -= sizeof(u64);
+	}
+
+	if (len & sizeof(u32)) {
+		u32 value = get_unaligned_le32(p);
+
+		CRC32(crc, value, w);
+		p += sizeof(u32);
+		len -= sizeof(u32);
+	}
+
+	if (len & sizeof(u16)) {
+		u16 value = get_unaligned_le16(p);
+
+		CRC32(crc, value, h);
+		p += sizeof(u16);
+	}
+
+	if (len & sizeof(u8)) {
+		u8 value = *p++;
+
+		CRC32(crc, value, b);
+	}
+
+	return crc;
+}
+
+static u32 crc32c_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
+{
+	u32 crc = crc_;
+
+	while (len >= sizeof(u64)) {
+		u64 value = get_unaligned_le64(p);
+
+		CRC32C(crc, value, d);
+		p += sizeof(u64);
+		len -= sizeof(u64);
+	}
+
+	if (len & sizeof(u32)) {
+		u32 value = get_unaligned_le32(p);
+
+		CRC32C(crc, value, w);
+		p += sizeof(u32);
+		len -= sizeof(u32);
+	}
+
+	if (len & sizeof(u16)) {
+		u16 value = get_unaligned_le16(p);
+
+		CRC32C(crc, value, h);
+		p += sizeof(u16);
+	}
+
+	if (len & sizeof(u8)) {
+		u8 value = *p++;
+
+		CRC32C(crc, value, b);
+	}
+
+	return crc;
+}
+
+#define CHKSUM_BLOCK_SIZE	1
+#define CHKSUM_DIGEST_SIZE	4
+
+struct chksum_ctx {
+	u32 key;
+};
+
+struct chksum_desc_ctx {
+	u32 crc;
+};
+
+static int chksum_init(struct shash_desc *desc)
+{
+	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
+	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	ctx->crc = mctx->key;
+
+	return 0;
+}
+
+/*
+ * Setting the seed allows arbitrary accumulators and flexible XOR policy
+ * If your algorithm starts with ~0, then XOR with ~0 before you set the seed.
+ */
+static int chksum_setkey(struct crypto_shash *tfm, const u8 *key, unsigned int keylen)
+{
+	struct chksum_ctx *mctx = crypto_shash_ctx(tfm);
+
+	if (keylen != sizeof(mctx->key))
+		return -EINVAL;
+
+	mctx->key = get_unaligned_le32(key);
+
+	return 0;
+}
+
+static int chksum_update(struct shash_desc *desc, const u8 *data, unsigned int length)
+{
+	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	ctx->crc = crc32_loongarch_hw(ctx->crc, data, length);
+	return 0;
+}
+
+static int chksumc_update(struct shash_desc *desc, const u8 *data, unsigned int length)
+{
+	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	ctx->crc = crc32c_loongarch_hw(ctx->crc, data, length);
+	return 0;
+}
+
+static int chksum_final(struct shash_desc *desc, u8 *out)
+{
+	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	put_unaligned_le32(ctx->crc, out);
+	return 0;
+}
+
+static int chksumc_final(struct shash_desc *desc, u8 *out)
+{
+	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	put_unaligned_le32(~ctx->crc, out);
+	return 0;
+}
+
+static int __chksum_finup(u32 crc, const u8 *data, unsigned int len, u8 *out)
+{
+	put_unaligned_le32(crc32_loongarch_hw(crc, data, len), out);
+	return 0;
+}
+
+static int __chksumc_finup(u32 crc, const u8 *data, unsigned int len, u8 *out)
+{
+	put_unaligned_le32(~crc32c_loongarch_hw(crc, data, len), out);
+	return 0;
+}
+
+static int chksum_finup(struct shash_desc *desc, const u8 *data, unsigned int len, u8 *out)
+{
+	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	return __chksum_finup(ctx->crc, data, len, out);
+}
+
+static int chksumc_finup(struct shash_desc *desc, const u8 *data, unsigned int len, u8 *out)
+{
+	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	return __chksumc_finup(ctx->crc, data, len, out);
+}
+
+static int chksum_digest(struct shash_desc *desc, const u8 *data, unsigned int length, u8 *out)
+{
+	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
+
+	return __chksum_finup(mctx->key, data, length, out);
+}
+
+static int chksumc_digest(struct shash_desc *desc, const u8 *data, unsigned int length, u8 *out)
+{
+	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
+
+	return __chksumc_finup(mctx->key, data, length, out);
+}
+
+static int chksum_cra_init(struct crypto_tfm *tfm)
+{
+	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
+
+	mctx->key = 0;
+	return 0;
+}
+
+static int chksumc_cra_init(struct crypto_tfm *tfm)
+{
+	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
+
+	mctx->key = ~0;
+	return 0;
+}
+
+static struct shash_alg crc32_alg = {
+	.digestsize		=	CHKSUM_DIGEST_SIZE,
+	.setkey			=	chksum_setkey,
+	.init			=	chksum_init,
+	.update			=	chksum_update,
+	.final			=	chksum_final,
+	.finup			=	chksum_finup,
+	.digest			=	chksum_digest,
+	.descsize		=	sizeof(struct chksum_desc_ctx),
+	.base			=	{
+		.cra_name		=	"crc32",
+		.cra_driver_name	=	"crc32-loongarch",
+		.cra_priority		=	300,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
+		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
+		.cra_alignmask		=	0,
+		.cra_ctxsize		=	sizeof(struct chksum_ctx),
+		.cra_module		=	THIS_MODULE,
+		.cra_init		=	chksum_cra_init,
+	}
+};
+
+static struct shash_alg crc32c_alg = {
+	.digestsize		=	CHKSUM_DIGEST_SIZE,
+	.setkey			=	chksum_setkey,
+	.init			=	chksum_init,
+	.update			=	chksumc_update,
+	.final			=	chksumc_final,
+	.finup			=	chksumc_finup,
+	.digest			=	chksumc_digest,
+	.descsize		=	sizeof(struct chksum_desc_ctx),
+	.base			=	{
+		.cra_name		=	"crc32c",
+		.cra_driver_name	=	"crc32c-loongarch",
+		.cra_priority		=	300,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
+		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
+		.cra_alignmask		=	0,
+		.cra_ctxsize		=	sizeof(struct chksum_ctx),
+		.cra_module		=	THIS_MODULE,
+		.cra_init		=	chksumc_cra_init,
+	}
+};
+
+static int __init crc32_mod_init(void)
+{
+	int err;
+
+	if (!cpu_has(CPU_FEATURE_CRC32))
+		return 0;
+
+	err = crypto_register_shash(&crc32_alg);
+	if (err)
+		return err;
+
+	err = crypto_register_shash(&crc32c_alg);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void __exit crc32_mod_exit(void)
+{
+	if (!cpu_has(CPU_FEATURE_CRC32))
+		return;
+
+	crypto_unregister_shash(&crc32_alg);
+	crypto_unregister_shash(&crc32c_alg);
+}
+
+module_init(crc32_mod_init);
+module_exit(crc32_mod_exit);
+
+MODULE_AUTHOR("Min Zhou <zhoumin@loongson.cn>");
+MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
+MODULE_DESCRIPTION("CRC32 and CRC32C using LoongArch crc* instructions");
+MODULE_LICENSE("GPL v2");
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 9c86f7045157..a0e080d5f6ae 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1395,6 +1395,9 @@ endif
 if ARM64
 source "arch/arm64/crypto/Kconfig"
 endif
+if LOONGARCH
+source "arch/loongarch/crypto/Kconfig"
+endif
 if MIPS
 source "arch/mips/crypto/Kconfig"
 endif
-- 
2.39.1

