Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D806606D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjAFS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbjAFS6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:58:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E7081D5C;
        Fri,  6 Jan 2023 10:58:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso4198389wmb.3;
        Fri, 06 Jan 2023 10:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zZc63Q9s6eEF2yJbj0/sv/zA/WxW442NyAZuuADZrk=;
        b=LrkV5Z1RiU1UU25ZGLEKxB+vI86aiyHmCexE68MjtKg8jvqUcTGYc4RFYwBdIQ+aYe
         P9fC83npdI4gTwvpfk8qxJcOTxe60hprtD/6jFYpPrM8hS6cGz0X7HaSzRXPUu+2t4Bb
         DkRlCrcvj0PHI/SANdlhiBnHBdOigt90T3tvqYgewLOLLEPgFj8X2vKqED42JBYUJtC4
         GSlcVxTqlpWK9E6/eNd62/laAFTBOSIldhknJfNJg0ukwdmZMcYXpSqFgQBQyxnL8rxv
         uWN9xQFbYEAs3tgNR9SIQuVHrOV7ds237MiliyLD8YunDjHH39nDGXggs32cg0K1dxQl
         d7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zZc63Q9s6eEF2yJbj0/sv/zA/WxW442NyAZuuADZrk=;
        b=1F6vX+CETQe8jmem9wFYlPFi66JbwVpdKTUrWE1Uliyn1xghwehmR00iOs6ABeALJn
         BPr1PVAwe1IPTg/eiGN6+Ko0K5TueRo3cnmJVc7IawStRP8mM+2EJk/QiuPD3Rk9wwRM
         LGDTJSBWvaee/EGgpDrHooy5M8FVY0DlP2p+RRkrYYVCHssyk/tuQUF4nZCZJX3AKTfZ
         X/PqIblQyQkOKHiQkR/NFftQqQjpIe0pUyI4DbReEWvTyyn33fKPtwY6WtuUorV8lZR0
         KIaswZNETxqhW015vOyZTB4qkR01+x62L/HgnzytjZ+EKB77g6KxACtYcGF3z4i3m2H1
         /qWA==
X-Gm-Message-State: AFqh2krq0VbpInIVhxcEZS1Y6VTzV66jJKUP6VQmgE0emeL0e7FMNQOb
        VKNn4T/Qf4GkOli3+7g0qis=
X-Google-Smtp-Source: AMrXdXsNSKLpk186MicIEaKm8PUmiGcq+1HnGVs1X3M4ej7r4RkWzCSREteRS2drQ97VC2MJ7zf/lg==
X-Received: by 2002:a05:600c:4f83:b0:3d3:49db:d95 with SMTP id n3-20020a05600c4f8300b003d349db0d95mr39897580wmq.37.1673031486662;
        Fri, 06 Jan 2023 10:58:06 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:79e8:5b4e:615a:91cd])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b003c5571c27a1sm3162773wmq.32.2023.01.06.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:58:06 -0800 (PST)
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
        linux-kernel@vger.kernel.org (open list),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jason M Bills <jason.m.bills@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v6 5/6] cache: Add L2 cache management for Andes AX45MP RISC-V core
Date:   Fri,  6 Jan 2023 18:55:25 +0000
Message-Id: <20230106185526.260163-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/Kconfig              |   2 +
 drivers/Makefile             |   1 +
 drivers/cache/Kconfig        |  10 ++
 drivers/cache/Makefile       |   3 +
 drivers/cache/ax45mp_cache.c | 279 +++++++++++++++++++++++++++++++++++
 5 files changed, 295 insertions(+)
 create mode 100644 drivers/cache/Kconfig
 create mode 100644 drivers/cache/Makefile
 create mode 100644 drivers/cache/ax45mp_cache.c

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
index bdf1c66141c9..9fc91d2bbe4c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -6,6 +6,7 @@
 # Rewritten to use lists instead of if-statements.
 #
 
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
index 000000000000..556e6875627c
--- /dev/null
+++ b/drivers/cache/ax45mp_cache.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * non-coherent cache functions for Andes AX45MP
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <asm/dma-noncoherent.h>
+#include <linux/cacheflush.h>
+#include <linux/cacheinfo.h>
+#include <linux/dma-direction.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <asm/cacheflush.h>
+#include <asm/sbi.h>
+
+/* L2 cache registers */
+#define AX45MP_L2C_REG_CTL_OFFSET		0x8
+
+#define AX45MP_L2C_REG_C0_CMD_OFFSET		0x40
+#define AX45MP_L2C_REG_C0_ACC_OFFSET		0x48
+#define AX45MP_L2C_REG_STATUS_OFFSET		0x80
+
+/* D-cache operation */
+#define AX45MP_CCTL_L1D_VA_INVAL		0
+#define AX45MP_CCTL_L1D_VA_WB			1
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
+/*
+ * Software trigger CCTL operation (cache maintenance operations) by writing
+ * to ucctlcommand and ucctlbeginaddr registers and write-back an L2 cache
+ * entry.
+ */
+static void ax45mp_cpu_dcache_wb_range(void *start, void *end, int line_size)
+{
+	void __iomem *base = ax45mp_priv->l2c_base;
+	int mhartid = smp_processor_id();
+	unsigned long pa;
+
+	while (end > start) {
+		csr_write(AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM, start);
+		csr_write(AX45MP_CCTL_REG_UCCTLCOMMAND_NUM, AX45MP_CCTL_L1D_VA_WB);
+
+		pa = virt_to_phys(start);
+		writel(pa, base + AX45MP_L2C_REG_CN_ACC_OFFSET(mhartid));
+		writel(AX45MP_CCTL_L2_PA_WB,
+		       base + AX45MP_L2C_REG_CN_CMD_OFFSET(mhartid));
+		while ((ax45mp_cpu_l2c_get_cctl_status() &
+			AX45MP_CCTL_L2_STATUS_CN_MASK(mhartid)) !=
+			AX45MP_CCTL_L2_STATUS_IDLE)
+			;
+
+		start += line_size;
+	}
+}
+
+/*
+ * Software trigger CCTL operation by writing to ucctlcommand and ucctlbeginaddr
+ * registers and invalidate the L2 cache entry.
+ */
+static void ax45mp_cpu_dcache_inval_range(void *start, void *end, int line_size)
+{
+	void __iomem *base = ax45mp_priv->l2c_base;
+	int mhartid = smp_processor_id();
+	unsigned long pa;
+
+	while (end > start) {
+		csr_write(AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM, start);
+		csr_write(AX45MP_CCTL_REG_UCCTLCOMMAND_NUM, AX45MP_CCTL_L1D_VA_INVAL);
+
+		pa = virt_to_phys(start);
+		writel(pa, base + AX45MP_L2C_REG_CN_ACC_OFFSET(mhartid));
+		writel(AX45MP_CCTL_L2_PA_INVAL,
+		       base + AX45MP_L2C_REG_CN_CMD_OFFSET(mhartid));
+		while ((ax45mp_cpu_l2c_get_cctl_status() &
+			AX45MP_CCTL_L2_STATUS_CN_MASK(mhartid)) !=
+			AX45MP_CCTL_L2_STATUS_IDLE)
+			;
+
+		start += line_size;
+	}
+}
+
+static void ax45mp_cpu_dma_inval_range(void *vaddr, size_t size)
+{
+	char cache_buf[2][AX45MP_CACHE_LINE_SIZE];
+	unsigned long start = (unsigned long)vaddr;
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
+	ax45mp_cpu_dcache_inval_range(vaddr, (void *)end, line_size);
+
+	if (unlikely(start != old_start))
+		memcpy((void *)start, &cache_buf[0][0], (old_start & (line_size - 1)));
+
+	local_irq_restore(flags);
+}
+
+static void ax45mp_cpu_dma_wb_range(void *vaddr, size_t size)
+{
+	unsigned long start = (unsigned long)vaddr;
+	unsigned long end = start + size;
+	unsigned long line_size;
+	unsigned long flags;
+
+	line_size = ax45mp_priv->ax45mp_cache_line_size;
+	local_irq_save(flags);
+	start = start & (~(line_size - 1));
+	ax45mp_cpu_dcache_wb_range(vaddr, (void *)end, line_size);
+	local_irq_restore(flags);
+}
+
+static void ax45mp_no_iocp_cmo(void *vaddr, size_t size,
+			       enum dma_data_direction dir,
+			       enum dma_noncoherent_ops ops)
+{
+	/* We have nothing to do in case of NON_COHERENT_DMA_PREP */
+	if (ops != NON_COHERENT_SYNC_DMA_FOR_DEVICE &&
+	    ops != NON_COHERENT_SYNC_DMA_FOR_CPU)
+		return;
+
+	/*
+	 * In case of DMA_FROM_DEVICE invalidate the L2 cache entries and
+	 * in case of DMA_TO_DEVICE and DMA_BIDIRECTIONAL write-back an L2
+	 * cache entries.
+	 */
+	if (ops == NON_COHERENT_SYNC_DMA_FOR_DEVICE) {
+		switch (dir) {
+		case DMA_FROM_DEVICE:
+			ax45mp_cpu_dma_inval_range(vaddr, size);
+			break;
+		case DMA_TO_DEVICE:
+		case DMA_BIDIRECTIONAL:
+			ax45mp_cpu_dma_wb_range(vaddr, size);
+			break;
+		default:
+			break;
+		}
+
+		return;
+	}
+
+	/*
+	 * ops == NON_COHERENT_SYNC_DMA_FOR_CPU
+	 *
+	 * in case of DMA_BIDIRECTIONAL and DMA_FROM_DEVICE invalidate the L2
+	 * cache entries.
+	 */
+	if (dir == DMA_BIDIRECTIONAL || dir == DMA_FROM_DEVICE)
+		ax45mp_cpu_dma_inval_range(vaddr, size);
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
+static int ax45mp_l2c_probe(struct platform_device *pdev)
+{
+	struct riscv_cache_ops ax45mp_cmo_ops;
+
+	/*
+	 * riscv_cbom_block_size is set very much earlier so we can
+	 * definitely rely on it and only if its being set we continue
+	 * further in the probe path.
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
+	memset(&ax45mp_cmo_ops, 0x0, sizeof(ax45mp_cmo_ops));
+	ax45mp_cmo_ops.riscv_dma_noncoherent_cmo_ops = &ax45mp_no_iocp_cmo;
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
+
+MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
+MODULE_DESCRIPTION("Andes AX45MP L2 cache driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

