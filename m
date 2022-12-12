Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763B0649E46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiLLL4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiLLLzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:55:42 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8446BF59B;
        Mon, 12 Dec 2022 03:55:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso3367756wmp.3;
        Mon, 12 Dec 2022 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh+9/xHgNFOjN/E+Z8R9Bh3cZLl5EhdaXnzgP5J+TsQ=;
        b=Xp++TjtunFlM5K365cxRFO0X/a5Lh+i4DqQvh1Dfkenb8uz4bh1ZK8kjsW60vIGuFy
         EbroWbeCAHtRAxq7+cVX5GRHTKprWgJz3CD3Dz2LuL0Hj14XGotlSjgXc6a50IIGs0ne
         o56/w9K9izju8AaxhMHVFH/YHtr6KfvWMy/zVcRykdZiuanqA9iOdFhh/eFgs2s0v0Mn
         jnJyOPDKnQIGZqxzXGWgE72VH3Mircqy3AFjhoVh7z9NbYOiaBWEX5NHMkLVPxhUICIm
         IV2TQQWFqDFi3A2bGFEKPegsvhYb339NXYThqu0CgzyIIMbshCO3JOL1uauhUqUABRAX
         w9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mh+9/xHgNFOjN/E+Z8R9Bh3cZLl5EhdaXnzgP5J+TsQ=;
        b=JrLVfwHJV7AX1hOj0QTd4al2OVxs1LC4p5o8GvZR4dwz2M+so1ep1wD4Wm8bDbtfQv
         XFv87O8R2u4otAQriKQYz46jzp1YoKA8tS8EX0nhlBBJK8UvleXtwOxfUhWCo/9LTfru
         X8vqZSXWkh7zxZe0ULreB+/97SSgo8IWV5mD8pXIlQ0jmyk60tx+0lJC/wi+7hiZtfjE
         PBBmuVwgtK3iTcD2G37zoG5wQ8MOX2TGYwch/2rX8fumxzrlYxL+XYxOVCu/q3MjG/DV
         ZB5w/tqQ/DMTrnL0fOFn+aecEdp0WKNMBN1s5LUembidraDAkiTc46Ss/i8kqzIrd/Iq
         9adQ==
X-Gm-Message-State: ANoB5pk5DKX1McOFjgbOp/nuf7A7prFYJQdZA/beh51rJzIhgweGyxM5
        +0nhlKo2Lz2eARoDElxFaYJWOsPlpWp3qw==
X-Google-Smtp-Source: AA0mqf5b9OpXtHwUiJzPBsDHAomosygKuhdsaFihb47XpTu2YIvSE8vsrGMpKfFetH2YrdT/dfhauA==
X-Received: by 2002:a05:600c:1f1b:b0:3d0:82c0:5070 with SMTP id bd27-20020a05600c1f1b00b003d082c05070mr12303394wmb.41.1670846136864;
        Mon, 12 Dec 2022 03:55:36 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1484:ef11:b25c:4612])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b003b4cba4ef71sm9793820wmq.41.2022.12.12.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:55:36 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five SoC
Date:   Mon, 12 Dec 2022 11:55:05 +0000
Message-Id: <20221212115505.36770-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 arch/riscv/include/asm/cacheflush.h       |   8 +
 arch/riscv/include/asm/errata_list.h      |  28 ++-
 drivers/soc/renesas/Kconfig               |   6 +
 drivers/soc/renesas/Makefile              |   2 +
 drivers/soc/renesas/rzfive/Kconfig        |   6 +
 drivers/soc/renesas/rzfive/Makefile       |   3 +
 drivers/soc/renesas/rzfive/ax45mp_cache.c | 256 ++++++++++++++++++++++
 7 files changed, 303 insertions(+), 6 deletions(-)
 create mode 100644 drivers/soc/renesas/rzfive/Kconfig
 create mode 100644 drivers/soc/renesas/rzfive/Makefile
 create mode 100644 drivers/soc/renesas/rzfive/ax45mp_cache.c

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index e22019668b9e..d0e15636866c 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -68,6 +68,14 @@ static inline void riscv_noncoherent_supported(void) {}
 #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
 #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_LOCAL)
 
+#ifdef CONFIG_AX45MP_L2_CACHE
+extern asmlinkage void ax45mp_no_iocp_cmo(unsigned int cache_size, void *vaddr,
+					  size_t size, int dir, int ops);
+#else
+static inline void ax45mp_no_iocp_cmo(unsigned int cache_size, void *vaddr,
+				      size_t size, int dir, int ops) {}
+#endif
+
 #include <asm-generic/cacheflush.h>
 
 #endif /* _ASM_RISCV_CACHEFLUSH_H */
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 48e899a8e7a9..9a017142e67f 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -125,8 +125,8 @@ asm volatile(ALTERNATIVE(						\
 #define THEAD_SYNC_S	".long 0x0190000b"
 
 #define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)		\
-asm volatile(ALTERNATIVE_2(						\
-	__nops(6),							\
+asm volatile(ALTERNATIVE_3(						\
+	__nops(14),							\
 	"mv a0, %1\n\t"							\
 	"j 2f\n\t"							\
 	"3:\n\t"							\
@@ -134,7 +134,7 @@ asm volatile(ALTERNATIVE_2(						\
 	"add a0, a0, %0\n\t"						\
 	"2:\n\t"							\
 	"bltu a0, %2, 3b\n\t"						\
-	"nop", 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,		\
+	__nops(9), 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,	\
 	"mv a0, %1\n\t"							\
 	"j 2f\n\t"							\
 	"3:\n\t"							\
@@ -142,8 +142,24 @@ asm volatile(ALTERNATIVE_2(						\
 	"add a0, a0, %0\n\t"						\
 	"2:\n\t"							\
 	"bltu a0, %2, 3b\n\t"						\
-	THEAD_SYNC_S, THEAD_VENDOR_ID,					\
-			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
+	THEAD_SYNC_S "\n\t"						\
+	__nops(8), THEAD_VENDOR_ID,					\
+			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO,	\
+	"addi sp,sp,-16\n\t"						\
+	"sd s0,0(sp)\n\t"						\
+	"sd ra,8(sp)\n\t"						\
+	"addi s0,sp,16\n\t"						\
+	"mv a4,%6\n\t"							\
+	"mv a3,%5\n\t"							\
+	"mv a2,%4\n\t"							\
+	"mv a1,%3\n\t"							\
+	"mv a0,%0\n\t"							\
+	"call ax45mp_no_iocp_cmo\n\t"					\
+	"ld ra,8(sp)\n\t"						\
+	"ld s0,0(sp)\n\t"						\
+	"addi sp,sp,16\n\t",						\
+	ANDESTECH_VENDOR_ID, ERRATA_ANDESTECH_NO_IOCP,			\
+	CONFIG_ERRATA_ANDES_CMO)					\
 	: : "r"(_cachesize),						\
 	    "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
 	    "r"((unsigned long)(_start) + (_size)),			\
@@ -151,7 +167,7 @@ asm volatile(ALTERNATIVE_2(						\
 	    "r"((unsigned long)(_size)),				\
 	    "r"((unsigned long)(_dir)),					\
 	    "r"((unsigned long)(_ops))					\
-	: "a0")
+	: "a0", "a1", "a2", "a3", "a4", "memory")
 
 #define THEAD_C9XX_RV_IRQ_PMU			17
 #define THEAD_C9XX_CSR_SCOUNTEROF		0x5c5
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 660498252ec5..a6627936b79e 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -340,9 +340,15 @@ if RISCV
 config ARCH_R9A07G043
 	bool "RISC-V Platform support for RZ/Five"
 	select ARCH_RZG2L
+	select AX45MP_L2_CACHE
+	select DMA_GLOBAL_POOL
+	select ERRATA_ANDES
+	select ERRATA_ANDES_CMO
 	help
 	  This enables support for the Renesas RZ/Five SoC.
 
+source "drivers/soc/renesas/rzfive/Kconfig"
+
 endif # RISCV
 
 config RST_RCAR
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 535868c9c7e4..9df9f759a039 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -31,6 +31,8 @@ ifdef CONFIG_SMP
 obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
 
+obj-$(CONFIG_RISCV) += rzfive/
+
 # Family
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
 obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
diff --git a/drivers/soc/renesas/rzfive/Kconfig b/drivers/soc/renesas/rzfive/Kconfig
new file mode 100644
index 000000000000..b6bc00337d99
--- /dev/null
+++ b/drivers/soc/renesas/rzfive/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config AX45MP_L2_CACHE
+	bool "Andes Technology AX45MP L2 Cache controller"
+	help
+	  Support for the L2 cache controller on Andes Technology AX45MP platforms.
diff --git a/drivers/soc/renesas/rzfive/Makefile b/drivers/soc/renesas/rzfive/Makefile
new file mode 100644
index 000000000000..2012e7fb978d
--- /dev/null
+++ b/drivers/soc/renesas/rzfive/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_AX45MP_L2_CACHE) += ax45mp_cache.o
diff --git a/drivers/soc/renesas/rzfive/ax45mp_cache.c b/drivers/soc/renesas/rzfive/ax45mp_cache.c
new file mode 100644
index 000000000000..d98f71b86b9b
--- /dev/null
+++ b/drivers/soc/renesas/rzfive/ax45mp_cache.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * non-coherent cache functions for Andes AX45MP
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
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
+static DEFINE_STATIC_KEY_FALSE(ax45mp_l2c_configured);
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
+void ax45mp_no_iocp_cmo(unsigned int cache_size, void *vaddr, size_t size, int dir, int ops)
+{
+	if (ops == NON_COHERENT_DMA_PREP)
+		return;
+
+	if (!static_branch_unlikely(&ax45mp_l2c_configured))
+		return;
+
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
+		return;
+	}
+
+	/* op == NON_COHERENT_SYNC_DMA_FOR_CPU */
+	if (dir == DMA_BIDIRECTIONAL || dir == DMA_FROM_DEVICE)
+		ax45mp_cpu_dma_inval_range(vaddr, size);
+}
+EXPORT_SYMBOL(ax45mp_no_iocp_cmo);
+
+static void ax45mp_configure_l2_cache(struct platform_device *pdev)
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
+	ax45mp_priv = devm_kzalloc(&pdev->dev, sizeof(*ax45mp_priv), GFP_KERNEL);
+	if (!ax45mp_priv)
+		return -ENOMEM;
+
+	ax45mp_priv->l2c_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ax45mp_priv->l2c_base))
+		return PTR_ERR(ax45mp_priv->l2c_base);
+
+	ax45mp_configure_l2_cache(pdev);
+
+	static_branch_enable(&ax45mp_l2c_configured);
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

