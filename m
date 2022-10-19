Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8996052BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiJSWDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiJSWC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:02:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCE11BFBBA;
        Wed, 19 Oct 2022 15:02:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a3so31254264wrt.0;
        Wed, 19 Oct 2022 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoyfDBE4YJVNlQXJiqHfDbpYrvavEToERgModCYKr+w=;
        b=Ke4uC15X2qxYtveQPuRsUUKxN5IyC0zVTSUn//nT7JP/AKHDjseOpFKk7wS3IHXx6s
         tV7m+/yjxSPwiszoFNLry4FnmxIAABHk988O1CfYw43rJHyb8QQFhXFaaqjNU5LthLnN
         KKEoMu6nZkTskzmwvyhnUo8oSp2JqRh9BMZT2L7MpacHG2IBssPunxwGmkmq442m4GCv
         evAerHchDBXTor4jV1RNbsGQbMzEMM4B6T9Yed6CiAKzoDYweRzQ6Pz4OcBIBpViixpJ
         Ml73p+f77IQkFxgUcrkfKuZD43PhE2xPXQuTTY3aAXouMfCN1VdtbEWqC74H6SIYQ8P9
         ArEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoyfDBE4YJVNlQXJiqHfDbpYrvavEToERgModCYKr+w=;
        b=B7sD07ZlSmfB+psPNk6nZFeyxbG6a2EriqxdN2igI2f37hCrM22zkGN4CAcjhe7QER
         pH3/bGVdkTTkRZAFlP1oVRr/lYioNzvYkpLNI3PoRXF6MEOqXtJnlZwe4u9T4TYXqCNI
         FO3ihS5uwj426/OazGIGBPYFc+LRrfv6Rmdo8MooC2q5u87aOV3BATfDkodWISC2P6yZ
         C4JvxexZmTwlGQLZ/E7QMp+txMv/TTt5KeXYNPxyONdjifJC4hktf/ySbIV7kzT3M3/v
         9dO9fNS4Ai1jMJ78VIreiUKRPUN/rPghXM05kqhMtkr4Na8kpjwcjwJIDgbGcei85f9g
         0gCw==
X-Gm-Message-State: ACrzQf2Ycr8apZs1Gmunnf/45mp8rHFf96qdXzx/Z/jpV+zUzfX/1eWa
        Jd0moKwLrbiOr+B+UO0UEWY=
X-Google-Smtp-Source: AMsMyM4Y703ljlehwSxnxh1erirNvV+AalRjOgONV4+LShotB1ZXCnqLd2qPuUWiuZc94EcIwi5AVQ==
X-Received: by 2002:a5d:5405:0:b0:22e:7631:eee8 with SMTP id g5-20020a5d5405000000b0022e7631eee8mr6378482wrv.169.1666216975777;
        Wed, 19 Oct 2022 15:02:55 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d8c7:b527:b960:aa04])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d6247000000b0022c906ffedasm14807824wrv.70.2022.10.19.15.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:02:55 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.co>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for RZ/Five SoC
Date:   Wed, 19 Oct 2022 23:02:42 +0100
Message-Id: <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On the AX45MP core, cache coherency is a specification option so it may
not be supported. In this case DMA will fail. As a workaround, firstly we
allocate a global dma coherent pool from which DMA allocations are taken
and marked as non-cacheable + bufferable using the PMA region as specified
in the device tree. Synchronization callbacks are implemented to
synchronize when doing DMA transactions.

The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
block that allows dynamic adjustment of memory attributes in the runtime.
It contains a configurable amount of PMA entries implemented as CSR
registers to control the attributes of memory locations in interest.

Below are the memory attributes supported:
* Device, Non-bufferable
* Device, bufferable
* Memory, Non-cacheable, Non-bufferable
* Memory, Non-cacheable, Bufferable
* Memory, Write-back, No-allocate
* Memory, Write-back, Read-allocate
* Memory, Write-back, Write-allocate
* Memory, Write-back, Read and Write-allocate

This patch adds support to configure the memory attributes of the memory
regions as passed from the l2 cache node and exposes the cache management
ops.

More info about PMA (section 10.3):
http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf

This feature is based on the work posted [0] by Vincent Chen
<vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.

[0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-email-vincentc@andestech.com/

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/include/asm/cacheflush.h    |   8 +
 arch/riscv/include/asm/errata_list.h   |   2 +
 arch/riscv/mm/dma-noncoherent.c        |  20 ++
 drivers/soc/renesas/Kconfig            |   5 +
 drivers/soc/renesas/Makefile           |   4 +
 drivers/soc/renesas/rzf/Kconfig        |   6 +
 drivers/soc/renesas/rzf/Makefile       |   3 +
 drivers/soc/renesas/rzf/ax45mp_cache.c | 431 +++++++++++++++++++++++++
 drivers/soc/renesas/rzf/ax45mp_sbi.h   |  29 ++
 9 files changed, 508 insertions(+)
 create mode 100644 drivers/soc/renesas/rzf/Kconfig
 create mode 100644 drivers/soc/renesas/rzf/Makefile
 create mode 100644 drivers/soc/renesas/rzf/ax45mp_cache.c
 create mode 100644 drivers/soc/renesas/rzf/ax45mp_sbi.h

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 8a5c246b0a21..40aa790be9a3 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -65,6 +65,14 @@ static inline void riscv_noncoherent_supported(void) {}
 #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
 #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_LOCAL)
 
+#ifdef CONFIG_AX45MP_L2_CACHE
+void ax45mp_cpu_dma_inval_range(void *vaddr, size_t end);
+void ax45mp_cpu_dma_wb_range(void *vaddr, size_t end);
+
+#define ALT_CMO_OP(_op, _start, _size, _cachesize)	\
+		   _op(_start, _size)
+#endif
+
 #include <asm-generic/cacheflush.h>
 
 #endif /* _ASM_RISCV_CACHEFLUSH_H */
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 19a771085781..d9cbf60c3b65 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -89,6 +89,7 @@ asm volatile(ALTERNATIVE(						\
 #define ALT_THEAD_PMA(_val)
 #endif
 
+#ifdef CONFIG_ERRATA_THEAD_CMO
 /*
  * dcache.ipa rs1 (invalidate, physical address)
  * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
@@ -143,5 +144,6 @@ asm volatile(ALTERNATIVE_2(						\
 	: "a0")
 
 #endif /* __ASSEMBLY__ */
+#endif
 
 #endif
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index b0add983530a..5270acca6766 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -24,13 +24,25 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 
 	switch (dir) {
 	case DMA_TO_DEVICE:
+#ifdef CONFIG_ERRATA_THEAD_CMO
 		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+#elif CONFIG_AX45MP_L2_CACHE
+		ALT_CMO_OP(ax45mp_cpu_dma_wb_range, vaddr, size, 0x0);
+#endif
 		break;
 	case DMA_FROM_DEVICE:
+#ifdef CONFIG_ERRATA_THEAD_CMO
 		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+#elif CONFIG_AX45MP_L2_CACHE
+		ALT_CMO_OP(ax45mp_cpu_dma_inval_range, vaddr, size, 0x0);
+#endif
 		break;
 	case DMA_BIDIRECTIONAL:
+#ifdef CONFIG_ERRATA_THEAD_CMO
 		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+#elif CONFIG_AX45MP_L2_CACHE
+		ALT_CMO_OP(ax45mp_cpu_dma_wb_range, vaddr, size, 0x0);
+#endif
 		break;
 	default:
 		break;
@@ -47,7 +59,11 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
+#ifdef CONFIG_ERRATA_THEAD_CMO
 		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+#elif CONFIG_AX45MP_L2_CACHE
+		ALT_CMO_OP(ax45mp_cpu_dma_inval_range, vaddr, size, 0x0);
+#endif
 		break;
 	default:
 		break;
@@ -56,14 +72,17 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
+#ifdef CONFIG_ERRATA_THEAD_CMO
 	void *flush_addr = page_address(page);
 
 	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
+#endif
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		const struct iommu_ops *iommu, bool coherent)
 {
+#ifdef CONFIG_ERRATA_THEAD_CMO
 	WARN_TAINT(!coherent && riscv_cbom_block_size > ARCH_DMA_MINALIGN,
 		   TAINT_CPU_OUT_OF_SPEC,
 		   "%s %s: ARCH_DMA_MINALIGN smaller than riscv,cbom-block-size (%d < %d)",
@@ -75,6 +94,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		   dev_driver_string(dev), dev_name(dev));
 
 	dev->dma_coherent = coherent;
+#endif
 }
 
 #ifdef CONFIG_RISCV_ISA_ZICBOM
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 660498252ec5..ba2981eaeb34 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -340,9 +340,14 @@ if RISCV
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
 	select ARCH_RZG2L
+	select AX45MP_L2_CACHE
+	select DMA_GLOBAL_POOL
+	select RISCV_DMA_NONCOHERENT
 	help
 	  This enables support for the Renesas RZ/Five SoC.
 
+source "drivers/soc/renesas/rzf/Kconfig"
+
 endif # RISCV
 
 config RST_RCAR
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 535868c9c7e4..a20cc7ad5b12 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -31,6 +31,10 @@ ifdef CONFIG_SMP
 obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
 
+ifdef CONFIG_RISCV
+obj-y += rzf/
+endif
+
 # Family
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
 obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
diff --git a/drivers/soc/renesas/rzf/Kconfig b/drivers/soc/renesas/rzf/Kconfig
new file mode 100644
index 000000000000..1e8198da3ba7
--- /dev/null
+++ b/drivers/soc/renesas/rzf/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config AX45MP_L2_CACHE
+	bool "AX45MP L2 Cache controller"
+	help
+	  Support for the L2 cache controller on AX45MP platforms.
diff --git a/drivers/soc/renesas/rzf/Makefile b/drivers/soc/renesas/rzf/Makefile
new file mode 100644
index 000000000000..2012e7fb978d
--- /dev/null
+++ b/drivers/soc/renesas/rzf/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_AX45MP_L2_CACHE) += ax45mp_cache.o
diff --git a/drivers/soc/renesas/rzf/ax45mp_cache.c b/drivers/soc/renesas/rzf/ax45mp_cache.c
new file mode 100644
index 000000000000..2a1b82fc68d1
--- /dev/null
+++ b/drivers/soc/renesas/rzf/ax45mp_cache.c
@@ -0,0 +1,431 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PMA setup and non-coherent cache functions for AX45MP
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <linux/cacheflush.h>
+#include <linux/cacheinfo.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <asm/sbi.h>
+
+#include "ax45mp_sbi.h"
+
+/* L2 cache registers */
+#define AX45MP_L2C_REG_CTL_OFFSET		0x8
+#define AX45MP_L2C_IPREPETCH_OFF		3
+#define AX45MP_L2C_DPREPETCH_OFF		5
+#define AX45MP_L2C_IPREPETCH_MSK		(3 << AX45MP_L2C_IPREPETCH_OFF)
+#define AX45MP_L2C_DPREPETCH_MSK		(3 << AX45MP_L2C_DPREPETCH_OFF)
+#define AX45MP_L2C_TRAMOCTL_OFF			8
+#define AX45MP_L2C_TRAMICTL_OFF			10
+#define AX45MP_L2C_TRAMOCTL_MSK			(3 << AX45MP_L2C_TRAMOCTL_OFF)
+#define AX45MP_L2C_TRAMICTL_MSK			BIT(AX45MP_L2C_TRAMICTL_OFF)
+#define AX45MP_L2C_DRAMOCTL_OFF			11
+#define AX45MP_L2C_DRAMICTL_OFF			13
+#define AX45MP_L2C_DRAMOCTL_MSK			(3 << AX45MP_L2C_DRAMOCTL_OFF)
+#define AX45MP_L2C_DRAMICTL_MSK			BIT(AX45MP_L2C_DRAMICTL_OFF)
+
+#define AX45MP_L2C_REG_C0_CMD_OFFSET		0x40
+#define AX45MP_L2C_REG_C0_ACC_OFFSET		0x48
+#define AX45MP_L2C_REG_STATUS_OFFSET		0x80
+
+/* D-cache operation */
+#define AX45MP_CCTL_L1D_VA_INVAL		0
+#define AX45MP_CCTL_L1D_VA_WB			1
+
+/* L2 cache */
+#define AX45MP_L2_CACHE_CTL_CEN_MASK		1
+
+/* L2 CCTL status */
+#define AX45MP_CCTL_L2_STATUS_IDLE		0
+
+/* L2 CCTL status cores mask */
+#define AX45MP_CCTL_L2_STATUS_C0_MASK		0xf
+
+/* L2 cache operation */
+#define AX45MP_CCTL_L2_PA_INVAL			0x8
+#define AX45MP_CCTL_L2_PA_WB			0x9
+
+#define AX45MP_L2C_HPM_PER_CORE_OFFSET		0x8
+#define AX45MP_L2C_REG_PER_CORE_OFFSET		0x10
+#define AX45MP_CCTL_L2_STATUS_PER_CORE_OFFSET	4
+
+#define AX45MP_L2C_REG_CN_CMD_OFFSET(n)	\
+	(AX45MP_L2C_REG_C0_CMD_OFFSET + ((n) * AX45MP_L2C_REG_PER_CORE_OFFSET))
+#define AX45MP_L2C_REG_CN_ACC_OFFSET(n)	\
+	(AX45MP_L2C_REG_C0_ACC_OFFSET + ((n) * AX45MP_L2C_REG_PER_CORE_OFFSET))
+#define AX45MP_CCTL_L2_STATUS_CN_MASK(n)	\
+	(AX45MP_CCTL_L2_STATUS_C0_MASK << ((n) * AX45MP_CCTL_L2_STATUS_PER_CORE_OFFSET))
+
+#define AX45MP_MICM_CFG_ISZ_OFFSET		6
+#define AX45MP_MICM_CFG_ISZ_MASK		(0x7  << AX45MP_MICM_CFG_ISZ_OFFSET)
+
+#define AX45MP_MDCM_CFG_DSZ_OFFSET		6
+#define AX45MP_MDCM_CFG_DSZ_MASK		(0x7  << AX45MP_MDCM_CFG_DSZ_OFFSET)
+
+#define AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM	0x80b
+#define AX45MP_CCTL_REG_UCCTLCOMMAND_NUM	0x80c
+
+#define AX45MP_MCACHE_CTL_CCTL_SUEN_OFFSET	8
+#define AX45MP_MMSC_CFG_CCTLCSR_OFFSET		16
+#define AX45MP_MISA_20_OFFSET			20
+
+#define AX45MP_MCACHE_CTL_CCTL_SUEN_MASK	(0x1 << AX45MP_MCACHE_CTL_CCTL_SUEN_OFFSET)
+#define AX45MP_MMSC_CFG_CCTLCSR_MASK		(0x1 << AX45MP_MMSC_CFG_CCTLCSR_OFFSET)
+#define AX45MP_MISA_20_MASK			(0x1 << AX45MP_MISA_20_OFFSET)
+
+#define AX45MP_MAX_CACHE_LINE_SIZE		256
+
+#define AX45MP_MAX_PMA_REGIONS			16
+
+struct ax45mp_priv {
+	void __iomem *l2c_base;
+	unsigned int ax45mp_cache_line_size;
+	bool l2cache_enabled;
+	bool ucctl_ok;
+};
+
+static struct ax45mp_priv *ax45mp_priv;
+static DEFINE_STATIC_KEY_FALSE(ax45mp_l2c_configured);
+
+/* PMA setup */
+static long ax45mp_sbi_set_pma(unsigned long start,
+			       unsigned long size,
+			       unsigned long flags,
+			       unsigned int entry_id)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_SET_PMA,
+			start, start + size, size, entry_id,
+			flags, 0);
+
+	return ret.value;
+}
+
+static int ax45mp_configure_pma_regions(struct device_node *np)
+{
+	const char *propname = "andestech,pma-regions";
+	u64 start, size, flags;
+	unsigned int entry_id;
+	unsigned int i;
+	int count;
+	int ret;
+
+	count = of_property_count_elems_of_size(np, propname,
+						sizeof(u32) * 6);
+	if (count <= 0)
+		return 0;
+
+	if (count > AX45MP_MAX_PMA_REGIONS)
+		return -EINVAL;
+
+	for (i = 0, entry_id = 0 ; entry_id < count ; i += 3, entry_id++) {
+		of_property_read_u64_index(np, propname, i, &start);
+		of_property_read_u64_index(np, propname, i + 1, &size);
+		of_property_read_u64_index(np, propname, i + 2, &flags);
+		ret = ax45mp_sbi_set_pma(start, size, flags, entry_id);
+		if (!ret)
+			pr_err("Failed to setup PMA region 0x%llx - 0x%llx",
+			       start, start + size);
+	}
+
+	return 0;
+}
+
+/* L2 Cache operations */
+static uint32_t ax45mp_cpu_get_mcache_ctl_status(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_GET_MCACHE_CTL_STATUS,
+			0, 0, 0, 0, 0, 0);
+	return ret.value;
+}
+
+static uint32_t ax45mp_cpu_get_micm_cfg_status(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_GET_MICM_CTL_STATUS,
+			0, 0, 0, 0, 0, 0);
+	return ret.value;
+}
+
+static uint32_t ax45mp_cpu_get_mdcm_cfg_status(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_GET_MDCM_CTL_STATUS,
+			0, 0, 0, 0, 0, 0);
+	return ret.value;
+}
+
+static uint32_t ax45mp_cpu_get_mmsc_cfg_status(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_GET_MMSC_CTL_STATUS,
+			0, 0, 0, 0, 0, 0);
+	return ret.value;
+}
+
+static uint32_t ax45mp_cpu_get_misa_cfg_status(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_GET_MISA_CTL_STATUS,
+			0, 0, 0, 0, 0, 0);
+	return ret.value;
+}
+
+static inline uint32_t ax45mp_cpu_l2c_get_cctl_status(void)
+{
+	return readl((void *)(ax45mp_priv->l2c_base + AX45MP_L2C_REG_STATUS_OFFSET));
+}
+
+static inline uint32_t ax45mp_cpu_l2c_ctl_status(void)
+{
+	return readl((void *)(ax45mp_priv->l2c_base + AX45MP_L2C_REG_CTL_OFFSET));
+}
+
+static bool ax45mp_cpu_cache_controlable(void)
+{
+	return (((ax45mp_cpu_get_micm_cfg_status() & AX45MP_MICM_CFG_ISZ_MASK) ||
+		 (ax45mp_cpu_get_mdcm_cfg_status() & AX45MP_MDCM_CFG_DSZ_MASK)) &&
+		(ax45mp_cpu_get_misa_cfg_status() & AX45MP_MISA_20_MASK) &&
+		(ax45mp_cpu_get_mmsc_cfg_status() & AX45MP_MMSC_CFG_CCTLCSR_MASK) &&
+		(ax45mp_cpu_get_mcache_ctl_status() & AX45MP_MCACHE_CTL_CCTL_SUEN_MASK));
+}
+
+static void ax45mp_cpu_dcache_wb_range(unsigned long start,
+				       unsigned long end,
+				       int line_size)
+{
+	void __iomem *base = ax45mp_priv->l2c_base;
+	unsigned long pa;
+	int mhartid = 0;
+#ifdef CONFIG_SMP
+	mhartid = smp_processor_id();
+#endif
+
+	while (end > start) {
+		if (ax45mp_priv->ucctl_ok) {
+			csr_write(AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM, start);
+			csr_write(AX45MP_CCTL_REG_UCCTLCOMMAND_NUM, AX45MP_CCTL_L1D_VA_WB);
+		}
+
+		if (ax45mp_priv->l2cache_enabled) {
+			pa = virt_to_phys((void *)start);
+			writel(pa, (void *)(base + AX45MP_L2C_REG_CN_ACC_OFFSET(mhartid)));
+			writel(AX45MP_CCTL_L2_PA_WB,
+			       (void *)(base + AX45MP_L2C_REG_CN_CMD_OFFSET(mhartid)));
+			while ((ax45mp_cpu_l2c_get_cctl_status() &
+				AX45MP_CCTL_L2_STATUS_CN_MASK(mhartid)) !=
+				AX45MP_CCTL_L2_STATUS_IDLE)
+				;
+		}
+
+		start += line_size;
+	}
+}
+
+static void ax45mp_cpu_dcache_inval_range(unsigned long start,
+					  unsigned long end,
+					  int line_size)
+{
+	void __iomem *base = ax45mp_priv->l2c_base;
+	unsigned long pa;
+	int mhartid = 0;
+#ifdef CONFIG_SMP
+	mhartid = smp_processor_id();
+#endif
+
+	while (end > start) {
+		if (ax45mp_priv->ucctl_ok) {
+			csr_write(AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM, start);
+			csr_write(AX45MP_CCTL_REG_UCCTLCOMMAND_NUM, AX45MP_CCTL_L1D_VA_INVAL);
+		}
+
+		if (ax45mp_priv->l2cache_enabled) {
+			pa = virt_to_phys((void *)start);
+			writel(pa, (void *)(base + AX45MP_L2C_REG_CN_ACC_OFFSET(mhartid)));
+			writel(AX45MP_CCTL_L2_PA_INVAL,
+			       (void *)(base + AX45MP_L2C_REG_CN_CMD_OFFSET(mhartid)));
+			while ((ax45mp_cpu_l2c_get_cctl_status() &
+				AX45MP_CCTL_L2_STATUS_CN_MASK(mhartid)) !=
+				AX45MP_CCTL_L2_STATUS_IDLE)
+				;
+		}
+
+		start += line_size;
+	}
+}
+
+void ax45mp_cpu_dma_inval_range(void *vaddr, size_t size)
+{
+	char cache_buf[2][AX45MP_MAX_CACHE_LINE_SIZE] = { 0 };
+	unsigned long start = (unsigned long)vaddr;
+	unsigned long end = start + size;
+	unsigned long old_start = start;
+	unsigned long old_end = end;
+	unsigned long line_size;
+	unsigned long flags;
+
+	if (static_branch_unlikely(&ax45mp_l2c_configured) && !ax45mp_priv)
+		return;
+
+	if (unlikely(start == end))
+		return;
+
+	line_size = ax45mp_priv->ax45mp_cache_line_size;
+
+	start = start & (~(line_size - 1));
+	end = ((end + line_size - 1) & (~(line_size - 1)));
+
+	local_irq_save(flags);
+	if (unlikely(start != old_start))
+		memcpy(&cache_buf[0][0], (void *)start, line_size);
+
+	if (unlikely(end != old_end))
+		memcpy(&cache_buf[1][0], (void *)(old_end & (~(line_size - 1))), line_size);
+
+	ax45mp_cpu_dcache_inval_range(start, end, line_size);
+
+	if (unlikely(start != old_start))
+		memcpy((void *)start, &cache_buf[0][0], (old_start & (line_size - 1)));
+
+	if (unlikely(end != old_end))
+		memcpy((void *)(old_end + 1),
+		       &cache_buf[1][(old_end & (line_size - 1)) + 1],
+		       end - old_end - 1);
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(ax45mp_cpu_dma_inval_range);
+
+void ax45mp_cpu_dma_wb_range(void *vaddr, size_t size)
+{
+	unsigned long start = (unsigned long)vaddr;
+	unsigned long end = start + size;
+	unsigned long line_size;
+	unsigned long flags;
+
+	if (static_branch_unlikely(&ax45mp_l2c_configured) && !ax45mp_priv)
+		return;
+
+	line_size = ax45mp_priv->ax45mp_cache_line_size;
+	local_irq_save(flags);
+	start = start & (~(line_size - 1));
+	ax45mp_cpu_dcache_wb_range(start, end, line_size);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(ax45mp_cpu_dma_wb_range);
+
+static int ax45mp_configure_l2_cache(struct device_node *np)
+{
+	u8 ram_ctl[2];
+	u32 cache_ctl;
+	u32 prefetch;
+	int ret;
+
+	cache_ctl = ax45mp_cpu_l2c_ctl_status();
+
+	/* Instruction and data fetch prefetch depth */
+	ret = of_property_read_u32(np, "andestech,inst-prefetch", &prefetch);
+	if (!ret) {
+		cache_ctl &= ~AX45MP_L2C_IPREPETCH_MSK;
+		cache_ctl |= (prefetch << AX45MP_L2C_IPREPETCH_OFF);
+	}
+
+	ret = of_property_read_u32(np, "andestech,data-prefetch", &prefetch);
+	if (!ret) {
+		cache_ctl &= ~AX45MP_L2C_DPREPETCH_MSK;
+		cache_ctl |= (prefetch << AX45MP_L2C_DPREPETCH_OFF);
+	}
+
+	/* tag RAM and data RAM setup and output cycle */
+	ret = of_property_read_u8_array(np, "andestech,tag-ram-ctl", ram_ctl, 2);
+	if (!ret) {
+		cache_ctl &= ~(AX45MP_L2C_TRAMOCTL_MSK | AX45MP_L2C_TRAMICTL_MSK);
+		cache_ctl |= ram_ctl[0] << AX45MP_L2C_TRAMOCTL_OFF;
+		cache_ctl |= ram_ctl[1] << AX45MP_L2C_TRAMICTL_OFF;
+	}
+
+	ret = of_property_read_u8_array(np, "andestech,data-ram-ctl", ram_ctl, 2);
+	if (!ret) {
+		cache_ctl &= ~(AX45MP_L2C_DRAMOCTL_MSK | AX45MP_L2C_DRAMICTL_MSK);
+		cache_ctl |= ram_ctl[0] << AX45MP_L2C_DRAMOCTL_OFF;
+		cache_ctl |= ram_ctl[1] << AX45MP_L2C_DRAMICTL_OFF;
+	}
+
+	writel(cache_ctl, ax45mp_priv->l2c_base + AX45MP_L2C_REG_CTL_OFFSET);
+
+	ret = of_property_read_u32(np, "cache-line-size", &ax45mp_priv->ax45mp_cache_line_size);
+	if (ret) {
+		pr_err("Failed to get cache-line-size defaulting to 64 bytes\n");
+		ax45mp_priv->ax45mp_cache_line_size = SZ_64;
+	}
+
+	ax45mp_priv->ucctl_ok = ax45mp_cpu_cache_controlable();
+	ax45mp_priv->l2cache_enabled = ax45mp_cpu_l2c_ctl_status() & AX45MP_L2_CACHE_CTL_CEN_MASK;
+
+	return 0;
+}
+
+static const struct of_device_id ax45mp_cache_ids[] = {
+	{ .compatible = "andestech,ax45mp-cache" },
+	{ /* sentinel */ }
+};
+
+static int ax45mp_l2c_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	ax45mp_priv = devm_kzalloc(&pdev->dev, sizeof(*ax45mp_priv), GFP_KERNEL);
+	if (!ax45mp_priv)
+		return -ENOMEM;
+
+	ax45mp_priv->l2c_base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
+	if (!ax45mp_priv->l2c_base) {
+		ret = -ENOMEM;
+		goto l2c_err;
+	}
+
+	ret = ax45mp_configure_l2_cache(np);
+	if (ret)
+		goto l2c_err;
+
+	ret = ax45mp_configure_pma_regions(np);
+	if (ret)
+		goto l2c_err;
+
+	static_branch_disable(&ax45mp_l2c_configured);
+
+	return 0;
+
+l2c_err:
+	devm_kfree(&pdev->dev, ax45mp_priv);
+	ax45mp_priv = NULL;
+	return ret;
+}
+
+static struct platform_driver ax45mp_l2c_driver = {
+	.driver = {
+		.name = "ax45mp-l2c",
+		.of_match_table = ax45mp_cache_ids,
+	},
+	.probe = ax45mp_l2c_probe,
+};
+
+static int __init ax45mp_cache_init(void)
+{
+	static_branch_enable(&ax45mp_l2c_configured);
+	return platform_driver_register(&ax45mp_l2c_driver);
+}
+arch_initcall(ax45mp_cache_init);
diff --git a/drivers/soc/renesas/rzf/ax45mp_sbi.h b/drivers/soc/renesas/rzf/ax45mp_sbi.h
new file mode 100644
index 000000000000..1604874954d0
--- /dev/null
+++ b/drivers/soc/renesas/rzf/ax45mp_sbi.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __AX45MP_SBI_H
+#define __AX45MP_SBI_H
+
+#define SBI_EXT_ANDES		0x0900031E
+
+enum ax45mp_sbi_ext_fid {
+	AX45MP_SBI_EXT_GET_MCACHE_CTL_STATUS = 0,
+	AX45MP_SBI_EXT_GET_MMISC_CTL_STATUS,
+	AX45MP_SBI_EXT_SET_MCACHE_CTL,
+	AX45MP_SBI_EXT_SET_MMISC_CTL,
+	AX45MP_SBI_EXT_ICACHE_OP,
+	AX45MP_SBI_EXT_DCACHE_OP,
+	AX45MP_SBI_EXT_L1CACHE_I_PREFETCH,
+	AX45MP_SBI_EXT_L1CACHE_D_PREFETCH,
+	AX45MP_SBI_EXT_NON_BLOCKING_LOAD_STORE,
+	AX45MP_SBI_EXT_WRITE_AROUND,
+	AX45MP_SBI_EXT_SET_PMA,
+	AX45MP_SBI_EXT_FREE_PMA,
+	AX45MP_SBI_EXT_PROBE_PMA,
+	AX45MP_SBI_EXT_DCACHE_WBINVAL_ALL,
+	AX45MP_SBI_EXT_GET_MICM_CTL_STATUS,
+	AX45MP_SBI_EXT_GET_MDCM_CTL_STATUS,
+	AX45MP_SBI_EXT_GET_MMSC_CTL_STATUS,
+	AX45MP_SBI_EXT_GET_MISA_CTL_STATUS,
+};
+
+#endif
-- 
2.25.1

