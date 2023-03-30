Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15246D1034
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjC3UnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjC3Um7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:42:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB9113CB;
        Thu, 30 Mar 2023 13:42:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso14146272wmb.0;
        Thu, 30 Mar 2023 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680208966; x=1682800966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QehaLiQpEBUYbGar4AMt5h2UaS7T6TLYAHGemBGfcA4=;
        b=cHKgkBKvm94eZRCrF4Ci8BUn2T2JOmsF4tM2L93nd+LK6evTUrxtmiHYBvlr3Pbthu
         awy0yW4XZBKkFhcdyqatUM3cgkU2AffOK8OUxO9PKu2oABuVUfxxoOPgH4vzlNhTVCSh
         975LaptVRWY1G3PpiAsjHPV6KblhoWldyQ1xtCoJS+pVyiW6OeX6URVfI5ixGYvAMO+v
         TlQ8kR/wQu+m4t17COg3Xt7byDjFldhyFntLgAyJAt/IGs+0gT072hq0MY6lKF74+IKI
         H3ZfiJNGAvstO1mTUA3n1RD97OF6EmqC8nfS6CUWZyfhOJRVi+0X7cPO+yi/A+h5RaoY
         XiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208966; x=1682800966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QehaLiQpEBUYbGar4AMt5h2UaS7T6TLYAHGemBGfcA4=;
        b=jKXGklTTz0/3zAxBhZA8knzjBauWa6e26k/XfLPWZkDllOU0ZouYYgNjoXK96PBSln
         V54b2lQWAP0ADnqoNXm1SfTj7jMC8EIwLfTXCMRM5cWRewKMPaiG/GFJoB+rX1GTZlJT
         gwSXVxOw3aRNhG4h6qww/T0Ut8Gsx2nzTF6NH/o1tw1elK5GzZ1XPbJNJkza+1BPCtld
         rqNuyNCz9qo5NcPwPIV7v9+K+Dt70EaeCV50+yH2VaE84yYuJPWkU405V+j1EzRSSDGK
         YUbeFsMRFMT9DpBDU+bzwqrfb7lhyq6aoOZHjoy45TnnyiL9aTGZTc7+w8nGAN9OJRTp
         yj0g==
X-Gm-Message-State: AAQBX9czM4Ucbdr/OFps9rn3TVoK9KlEX+JpIS75EDTs9luPlLE74mZ1
        4iTN2ajwjPEBi0fRyII74wY=
X-Google-Smtp-Source: AKy350aBMPyXNAhO5Nl8FX9Bi1ycWaMuZ7J3CXvZnt0geBpx5vVMDFwEs1H0NF9kJxsQmqnXn5uM4A==
X-Received: by 2002:a1c:720f:0:b0:3ed:eab9:976a with SMTP id n15-20020a1c720f000000b003edeab9976amr5448020wmc.5.1680208965794;
        Thu, 30 Mar 2023 13:42:45 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:30f2:5b7:ab32:c3f])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4b0c000000b002cfed482e9asm297981wrq.61.2023.03.30.13.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:42:45 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 5/6] cache: Add L2 cache management for Andes AX45MP RISC-V core
Date:   Thu, 30 Mar 2023 21:42:16 +0100
Message-Id: <20230330204217.47666-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---
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
 MAINTAINERS                  |   8 ++
 drivers/Kconfig              |   2 +
 drivers/Makefile             |   1 +
 drivers/cache/Kconfig        |  10 ++
 drivers/cache/Makefile       |   3 +
 drivers/cache/ax45mp_cache.c | 229 +++++++++++++++++++++++++++++++++++
 6 files changed, 253 insertions(+)
 create mode 100644 drivers/cache/Kconfig
 create mode 100644 drivers/cache/Makefile
 create mode 100644 drivers/cache/ax45mp_cache.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 258fa89de965..921a96859530 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19897,6 +19897,14 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 F:	drivers/staging/
 
+STANDALONE CACHE CONTROLLER DRIVERS
+M:	Conor Dooley <conor@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
+F:	drivers/cache
+F:	include/cache
+
 STARFIRE/DURALAN NETWORK DRIVER
 M:	Ion Badulescu <ionut@badula.org>
 S:	Odd Fixes
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 968bd0a6fd78..44abd2cba3a3 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -15,6 +15,8 @@ source "drivers/base/Kconfig"
 
 source "drivers/bus/Kconfig"
 
+source "drivers/cache/Kconfig"
+
 source "drivers/connector/Kconfig"
 
 source "drivers/firmware/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 20b118dca999..db5a8115093f 100644
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
index 000000000000..5478adff3d88
--- /dev/null
+++ b/drivers/cache/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+menu "Cache Drivers"
+
+config AX45MP_L2_CACHE
+	bool "Andes Technology AX45MP L2 Cache controller"
+	depends on RISCV && RISCV_DMA_NONCOHERENT
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
index 000000000000..cb230b544be8
--- /dev/null
+++ b/drivers/cache/ax45mp_cache.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * non-coherent cache functions for Andes AX45MP
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <asm/dma-noncoherent.h>
+#include <linux/cacheflush.h>
+#include <linux/cacheinfo.h>
+#include <linux/dma-direction.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
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
+static struct ax45mp_priv *ax45mp_priv;
+
+/* L2 Cache operations */
+static inline uint32_t ax45mp_cpu_l2c_get_cctl_status(void)
+{
+	return readl(ax45mp_priv->l2c_base + AX45MP_L2C_REG_STATUS_OFFSET);
+}
+
+static void ax45mp_cpu_cache_operation(unsigned long start, unsigned long end,
+				       unsigned long line_size, unsigned int l1_op,
+				       unsigned int l2_op)
+{
+	void __iomem *base = ax45mp_priv->l2c_base;
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
+static inline void ax45mp_cpu_dcache_wb_range(unsigned long start, unsigned long end,
+					      unsigned long line_size)
+{
+	ax45mp_cpu_cache_operation(start, end, line_size,
+				   AX45MP_CCTL_L1D_VA_WB,
+				   AX45MP_CCTL_L2_PA_WB);
+}
+
+/* Invalidate the L1 and L2 cache entry */
+static inline void ax45mp_cpu_dcache_inval_range(unsigned long start, unsigned long end,
+						 unsigned long line_size)
+{
+	ax45mp_cpu_cache_operation(start, end, line_size,
+				   AX45MP_CCTL_L1D_VA_INVAL,
+				   AX45MP_CCTL_L2_PA_INVAL);
+}
+
+static void ax45mp_cpu_dma_inval_range(unsigned long vaddr, unsigned long size)
+{
+	char cache_buf[2][AX45MP_CACHE_LINE_SIZE];
+	unsigned long start = vaddr;
+	unsigned long end = start + size;
+	unsigned long old_start = start;
+	unsigned long old_end = end;
+	unsigned long line_size;
+	unsigned long flags;
+
+	if (unlikely(start == end))
+		return;
+
+	line_size = ax45mp_priv->ax45mp_cache_line_size;
+
+	memset(&cache_buf, 0x0, sizeof(cache_buf));
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
+	local_irq_restore(flags);
+}
+
+static void ax45mp_cpu_dma_wb_range(unsigned long vaddr, unsigned long size)
+{
+	unsigned long start = vaddr;
+	unsigned long end = start + size;
+	unsigned long line_size;
+	unsigned long flags;
+
+	line_size = ax45mp_priv->ax45mp_cache_line_size;
+	local_irq_save(flags);
+	start = start & (~(line_size - 1));
+	ax45mp_cpu_dcache_wb_range(start, end, line_size);
+	local_irq_restore(flags);
+}
+
+static void ax45mp_cpu_dma_flush_range(unsigned long vaddr, unsigned long size)
+{
+	ax45mp_cpu_dma_wb_range(vaddr, size);
+	ax45mp_cpu_dma_inval_range(vaddr, size);
+}
+
+static void ax45mp_get_l2_line_size(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = of_property_read_u32(np, "cache-line-size", &ax45mp_priv->ax45mp_cache_line_size);
+	if (ret) {
+		dev_err(dev, "Failed to get cache-line-size, defaulting to 64 bytes\n");
+		ax45mp_priv->ax45mp_cache_line_size = AX45MP_CACHE_LINE_SIZE;
+	}
+
+	if (ax45mp_priv->ax45mp_cache_line_size != AX45MP_CACHE_LINE_SIZE) {
+		dev_err(dev, "Expected cache-line-size to be 64 bytes (found:%u). Defaulting to 64 bytes\n",
+			ax45mp_priv->ax45mp_cache_line_size);
+		ax45mp_priv->ax45mp_cache_line_size = AX45MP_CACHE_LINE_SIZE;
+	}
+}
+
+static const struct riscv_cache_ops ax45mp_cmo_ops = {
+	.clean_range = &ax45mp_cpu_dma_wb_range,
+	.inv_range = &ax45mp_cpu_dma_inval_range,
+	.flush_range = &ax45mp_cpu_dma_flush_range,
+};
+
+static int ax45mp_l2c_probe(struct platform_device *pdev)
+{
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
+	ax45mp_priv = devm_kzalloc(&pdev->dev, sizeof(*ax45mp_priv), GFP_KERNEL);
+	if (!ax45mp_priv)
+		return -ENOMEM;
+
+	ax45mp_priv->l2c_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ax45mp_priv->l2c_base))
+		return PTR_ERR(ax45mp_priv->l2c_base);
+
+	ax45mp_get_l2_line_size(pdev);
+
+	riscv_noncoherent_register_cache_ops(&ax45mp_cmo_ops);
+
+	return 0;
+}
+
+static const struct of_device_id ax45mp_cache_ids[] = {
+	{ .compatible = "andestech,ax45mp-cache" },
+	{ /* sentinel */ }
+};
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
+	return platform_driver_register(&ax45mp_l2c_driver);
+}
+arch_initcall(ax45mp_cache_init);
-- 
2.25.1

