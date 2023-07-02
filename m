Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09A74525D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGBUfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGBUfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:35:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF274E54;
        Sun,  2 Jul 2023 13:34:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31438512cafso146448f8f.2;
        Sun, 02 Jul 2023 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688330094; x=1690922094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJjSJrFD46rql5SQeLkNxGE/SD7DDj1gOMvfywUg8kE=;
        b=DKYNThji4fHZYvAL5uJx15V2GgkZCF9YK9Rq31Zsd8kuUKdHofjX7ZSoh32NOaOmnb
         AomhXEqCRAwImMV+qbXVfPA2l0dz6oHO38Kg6Tpabk1mW7dn8VnaE35V9MNR2GJii8DR
         ta1SSwuNsdr/flAVWupy+xecDS45KAxbM9Tig08eaVHYm28yz+ZFx76Hg7Ep4tURxqwe
         OOHWz3ovWYdtmfTQ23tFAeAVAOtKpOCdfLq9hwB0EklT+kczl+SbwxUzHo2LXQr0D3Gj
         osMB33EC3qDc8FKOGu4Ob9yNASz3ARj6UWc8AVHJ/kwc69bomeOlbUBHvD1Gj2+6xaAI
         BqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688330094; x=1690922094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJjSJrFD46rql5SQeLkNxGE/SD7DDj1gOMvfywUg8kE=;
        b=cPtIkZQ4l37LQqMHN304MyOqzKOpK7ZVHIB6wueuzOgJL+TbZJ1+lD1K+EanxvxZln
         oDk4okrcGRkeNrL/Gnf5KgAxQvZU4E26bdx7kFmDp2GjW8tDMjQDLo5dqPUGdo5Ie8Ky
         dRKwsdRCpC5xOqMVnhc+6GBBTo7OrsN9TUbdtsWTiIwyhjzBnZ+DSsBDMnqyJo9NTvfM
         i5I0JrvZJIbsS88BkAwrZeBHxheqiHLA8ZP4yQ4/WzZsa4GYB4p9+wiSsug3jQa9Vfvw
         NAAQfHFcV/uv40ZrcjATnn5axsd7OTCi4UuGRXixwVB6Z+YxO6BGqPwzVS9WlWcTzH6D
         I2Dw==
X-Gm-Message-State: ABy/qLZwnrG10p1RgoqgP7yduYPiGmYZ3A+G2LxkzEKMZof/2/5wrtDd
        DcuSB3418unLVaVvPalrf1A=
X-Google-Smtp-Source: APBJJlFn18kQm5JPRKao2mRHhRAEAM3sOtcZJ+g0yVJQR4RfiYh0Aa1Df+2TzrcScnsR36vcGPCB6g==
X-Received: by 2002:a5d:56d2:0:b0:30f:d1e3:22b7 with SMTP id m18-20020a5d56d2000000b0030fd1e322b7mr7170502wrw.6.1688330094158;
        Sun, 02 Jul 2023 13:34:54 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:b4ae:ae48:2e1b:1dcd])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b0030647449730sm24000478wrv.74.2023.07.02.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:34:53 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v10 5/6] cache: Add L2 cache management for Andes AX45MP RISC-V core
Date:   Sun,  2 Jul 2023 21:34:28 +0100
Message-Id: <20230702203429.237615-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

I/O Coherence Port (IOCP) provides an AXI interface for connecting
external non-caching masters, such as DMA controllers. The accesses
from IOCP are coherent with D-Caches and L2 Cache.

IOCP is a specification option and is disabled on the Renesas RZ/Five
SoC due to this reason IP blocks using DMA will fail.

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

More info about PMA (section 10.3):
Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf

As a workaround for SoCs with IOCP disabled CMO needs to be handled by
software. Firstly OpenSBI configures the memory region as
"Memory, Non-cacheable, Bufferable" and passes this region as a global
shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
allocations happen from this region and synchronization callbacks are
implemented to synchronize when doing DMA transactions.

Example PMA region passes as a DT node from OpenSBI:
    reserved-memory {
        #address-cells = <2>;
        #size-cells = <2>;
        ranges;

        pma_resv0@58000000 {
            compatible = "shared-dma-pool";
            reg = <0x0 0x58000000 0x0 0x08000000>;
            no-map;
            linux,dma-default;
        };
    };

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
---
v8 -> v9
* Updated function pointers

v8 -> v9
* Dropped exporting CMO functions as we no more used ALTERNATIVE_X() macro
* Now using the riscv_noncoherent_register_cache_ops() for registering
  CMO ops
* Added RB tag from Conor

v7 -> v8
* Dropped function pointer usage
* Now exporting the functions for clean/inval/flush
* Switched to using early_initcall instead of arch_initcall
* Dropped entry for "include/cache" from MAINTAINERS
* Dropped dependency of RISCV on AX45MP_L2_CACHE
* Returning error in case of cache line mismatch
* Renamed clean/inval/flush functions

v6 -> v7
* Implemented flush callback
* Dropped using riscv_dma_noncoherent_cmo_ops

v5 -> v6
* Moved driver to cache folder
* Switched to new API for CMO

v4 -> v5
* Dropped code for configuring L2 cache
* Dropped code for configuring PMA
* Updated commit message
* Added comments
* Changed static branch enable/disable order

RFC v3 -> v4
* Made use of runtime patching instead of compile time
* Now just exposing single function ax45mp_no_iocp_cmo() for CMO handling
* Added a check to make sure cache line size is always 64 bytes
* Renamed folder rzf -> rzfive
* Improved Kconfig description
* Dropped L2 cache configuration
* Dropped unnecessary casts
* Fixed comments pointed by Geert.
---
 MAINTAINERS                  |   7 ++
 drivers/Kconfig              |   2 +
 drivers/Makefile             |   1 +
 drivers/cache/Kconfig        |  11 ++
 drivers/cache/Makefile       |   3 +
 drivers/cache/ax45mp_cache.c | 213 +++++++++++++++++++++++++++++++++++
 6 files changed, 237 insertions(+)
 create mode 100644 drivers/cache/Kconfig
 create mode 100644 drivers/cache/Makefile
 create mode 100644 drivers/cache/ax45mp_cache.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 55ac73793856..899452038a5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20073,6 +20073,13 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 F:	drivers/staging/
 
+STANDALONE CACHE CONTROLLER DRIVERS
+M:	Conor Dooley <conor@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
+F:	drivers/cache
+
 STARFIRE/DURALAN NETWORK DRIVER
 M:	Ion Badulescu <ionut@badula.org>
 S:	Odd Fixes
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 514ae6b24cb2..2ae1b6707c2c 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -15,6 +15,8 @@ source "drivers/base/Kconfig"
 
 source "drivers/bus/Kconfig"
 
+source "drivers/cache/Kconfig"
+
 source "drivers/connector/Kconfig"
 
 source "drivers/firmware/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 7241d80a7b29..23eb201fe18a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -11,6 +11,7 @@ ifdef building_out_of_srctree
 MAKEFLAGS += --include-dir=$(srctree)
 endif
 
+obj-y				+= cache/
 obj-y				+= irqchip/
 obj-y				+= bus/
 
diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
new file mode 100644
index 000000000000..a57677f908f3
--- /dev/null
+++ b/drivers/cache/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+menu "Cache Drivers"
+
+config AX45MP_L2_CACHE
+	bool "Andes Technology AX45MP L2 Cache controller"
+	depends on RISCV_DMA_NONCOHERENT
+	select RISCV_NONSTANDARD_CACHE_OPS
+	help
+	  Support for the L2 cache controller on Andes Technology AX45MP platforms.
+
+endmenu
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
new file mode 100644
index 000000000000..2012e7fb978d
--- /dev/null
+++ b/drivers/cache/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_AX45MP_L2_CACHE) += ax45mp_cache.o
diff --git a/drivers/cache/ax45mp_cache.c b/drivers/cache/ax45mp_cache.c
new file mode 100644
index 000000000000..863bf0bfef98
--- /dev/null
+++ b/drivers/cache/ax45mp_cache.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * non-coherent cache functions for Andes AX45MP
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <linux/cacheflush.h>
+#include <linux/cacheinfo.h>
+#include <linux/dma-direction.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <asm/dma-noncoherent.h>
+
+/* L2 cache registers */
+#define AX45MP_L2C_REG_CTL_OFFSET		0x8
+
+#define AX45MP_L2C_REG_C0_CMD_OFFSET		0x40
+#define AX45MP_L2C_REG_C0_ACC_OFFSET		0x48
+#define AX45MP_L2C_REG_STATUS_OFFSET		0x80
+
+/* D-cache operation */
+#define AX45MP_CCTL_L1D_VA_INVAL		0 /* Invalidate an L1 cache entry */
+#define AX45MP_CCTL_L1D_VA_WB			1 /* Write-back an L1 cache entry */
+
+/* L2 CCTL status */
+#define AX45MP_CCTL_L2_STATUS_IDLE		0
+
+/* L2 CCTL status cores mask */
+#define AX45MP_CCTL_L2_STATUS_C0_MASK		0xf
+
+/* L2 cache operation */
+#define AX45MP_CCTL_L2_PA_INVAL			0x8 /* Invalidate an L2 cache entry */
+#define AX45MP_CCTL_L2_PA_WB			0x9 /* Write-back an L2 cache entry */
+
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
+#define AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM	0x80b
+#define AX45MP_CCTL_REG_UCCTLCOMMAND_NUM	0x80c
+
+#define AX45MP_CACHE_LINE_SIZE			64
+
+struct ax45mp_priv {
+	void __iomem *l2c_base;
+	u32 ax45mp_cache_line_size;
+};
+
+static struct ax45mp_priv ax45mp_priv;
+
+/* L2 Cache operations */
+static inline uint32_t ax45mp_cpu_l2c_get_cctl_status(void)
+{
+	return readl(ax45mp_priv.l2c_base + AX45MP_L2C_REG_STATUS_OFFSET);
+}
+
+static void ax45mp_cpu_cache_operation(unsigned long start, unsigned long end,
+				       unsigned int l1_op, unsigned int l2_op)
+{
+	unsigned long line_size = ax45mp_priv.ax45mp_cache_line_size;
+	void __iomem *base = ax45mp_priv.l2c_base;
+	int mhartid = smp_processor_id();
+	unsigned long pa;
+
+	while (end > start) {
+		csr_write(AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM, start);
+		csr_write(AX45MP_CCTL_REG_UCCTLCOMMAND_NUM, l1_op);
+
+		pa = virt_to_phys((void *)start);
+		writel(pa, base + AX45MP_L2C_REG_CN_ACC_OFFSET(mhartid));
+		writel(l2_op, base + AX45MP_L2C_REG_CN_CMD_OFFSET(mhartid));
+		while ((ax45mp_cpu_l2c_get_cctl_status() &
+			AX45MP_CCTL_L2_STATUS_CN_MASK(mhartid)) !=
+			AX45MP_CCTL_L2_STATUS_IDLE)
+			;
+
+		start += line_size;
+	}
+}
+
+/* Write-back L1 and L2 cache entry */
+static inline void ax45mp_cpu_dcache_wb_range(unsigned long start, unsigned long end)
+{
+	ax45mp_cpu_cache_operation(start, end, AX45MP_CCTL_L1D_VA_WB,
+				   AX45MP_CCTL_L2_PA_WB);
+}
+
+/* Invalidate the L1 and L2 cache entry */
+static inline void ax45mp_cpu_dcache_inval_range(unsigned long start, unsigned long end)
+{
+	ax45mp_cpu_cache_operation(start, end, AX45MP_CCTL_L1D_VA_INVAL,
+				   AX45MP_CCTL_L2_PA_INVAL);
+}
+
+static void ax45mp_dma_cache_inv(phys_addr_t paddr, unsigned long size)
+{
+	unsigned long start = (unsigned long)phys_to_virt(paddr);
+	unsigned long end = start + size;
+	unsigned long line_size;
+	unsigned long flags;
+
+	if (unlikely(start == end))
+		return;
+
+	line_size = ax45mp_priv.ax45mp_cache_line_size;
+
+	start = start & (~(line_size - 1));
+	end = ((end + line_size - 1) & (~(line_size - 1)));
+
+	local_irq_save(flags);
+
+	ax45mp_cpu_dcache_inval_range(start, end);
+
+	local_irq_restore(flags);
+}
+
+static void ax45mp_dma_cache_wback(phys_addr_t paddr, unsigned long size)
+{
+	unsigned long start = (unsigned long)phys_to_virt(paddr);
+	unsigned long end = start + size;
+	unsigned long line_size;
+	unsigned long flags;
+
+	line_size = ax45mp_priv.ax45mp_cache_line_size;
+	start = start & (~(line_size - 1));
+	local_irq_save(flags);
+	ax45mp_cpu_dcache_wb_range(start, end);
+	local_irq_restore(flags);
+}
+
+static void ax45mp_dma_cache_wback_inv(phys_addr_t paddr, unsigned long size)
+{
+	ax45mp_dma_cache_wback(paddr, size);
+	ax45mp_dma_cache_inv(paddr, size);
+}
+
+static int ax45mp_get_l2_line_size(struct device_node *np)
+{
+	int ret;
+
+	ret = of_property_read_u32(np, "cache-line-size", &ax45mp_priv.ax45mp_cache_line_size);
+	if (ret) {
+		pr_err("Failed to get cache-line-size, defaulting to 64 bytes\n");
+		return ret;
+	}
+
+	if (ax45mp_priv.ax45mp_cache_line_size != AX45MP_CACHE_LINE_SIZE) {
+		pr_err("Expected cache-line-size to be 64 bytes (found:%u)\n",
+		       ax45mp_priv.ax45mp_cache_line_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct riscv_cache_ops ax45mp_cmo_ops = {
+	.wback = &ax45mp_dma_cache_wback,
+	.inv = &ax45mp_dma_cache_inv,
+	.wback_inv = &ax45mp_dma_cache_wback_inv,
+};
+
+static const struct of_device_id ax45mp_cache_ids[] = {
+	{ .compatible = "andestech,ax45mp-cache" },
+	{ /* sentinel */ }
+};
+
+static int __init ax45mp_cache_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	int ret;
+
+	np = of_find_matching_node(NULL, ax45mp_cache_ids);
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return ret;
+
+	/*
+	 * If IOCP is present on the Andes AX45MP core riscv_cbom_block_size
+	 * will be 0 for sure, so we can definitely rely on it. If
+	 * riscv_cbom_block_size = 0 we don't need to handle CMO using SW any
+	 * more so we just return success here and only if its being set we
+	 * continue further in the probe path.
+	 */
+	if (!riscv_cbom_block_size)
+		return 0;
+
+	ax45mp_priv.l2c_base = ioremap(res.start, resource_size(&res));
+	if (!ax45mp_priv.l2c_base)
+		return -ENOMEM;
+
+	ret = ax45mp_get_l2_line_size(np);
+	if (ret) {
+		iounmap(ax45mp_priv.l2c_base);
+		return ret;
+	}
+
+	riscv_noncoherent_register_cache_ops(&ax45mp_cmo_ops);
+
+	return 0;
+}
+early_initcall(ax45mp_cache_init);
-- 
2.34.1

