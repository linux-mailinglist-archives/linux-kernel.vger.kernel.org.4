Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D9E6A23F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBXVxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBXVxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:53:13 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BA8FF25;
        Fri, 24 Feb 2023 13:53:08 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id l13so1027048qtv.3;
        Fri, 24 Feb 2023 13:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNU1Zv7TJOF/5G3n38ugwny+VjhesmfAl/KetLKdMNs=;
        b=BapQ/qVNNAAEDfBUEZQ2Ow6ULB3WFraJmQHRGKyXFU/VUiKolxHggMn2k3VHwM2x9+
         Hhh5V9sHpUhxGE8udXhHeY+pz09/rLPTBCcUJXncQ17/185P3nvc1HQB19p/HUsYE1jn
         SGEI/ylAgT4w1ev1ZeeQULJRp0Y+NMfdpHmGTfrd/59oAz6Tfst0b+MvvpwUj0ttYeU4
         mlVqV/N1JKZ3KkWkJsV2FC2hkNYAY58JVIHzsAKNq1zHICFOtLp34e8ZCB3sErH4gv04
         G6abrFSANZYNAYjAVEA5/4+P5A0N3IGK5GD0bJfOEgNGf3XC8pAyvL4jG4Fp0g1B47qE
         QjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNU1Zv7TJOF/5G3n38ugwny+VjhesmfAl/KetLKdMNs=;
        b=fuxetOeB06TFAziRSAa3Y6vd8aCX5C4pQugjVQuATFPi0Whv4N+8f3X1J1tXLYSdXl
         E0GgGOmboOL46HT+vgh+LBoslYpz7sEYYK6xqP27++TDQq3I8d9V1+yq9LwpltsEWkRZ
         mehv0BHvkeFz3YRjRFdNbcUtBSjkS+cqlaAV15jGjLN5Ox0W1mXKvOZzl05qxoIfw8/J
         tv9b+j9DJ2CAM44i00SDcA87BfwoQ22SEUaBssNYJEtoq9oBGjhVOqkepB/qjHYclx8I
         Si4yGU1dvof8DK8rgdMcbWWej61jHgJnlbO6RQwEWwoxb33tTZLyuflgy6dDbDd5URQc
         xDLw==
X-Gm-Message-State: AO0yUKWu+5O8/IQvHkqeiQzzG3j1ZW5UMUkYXAr4u8ek1egEqXw037zj
        vpIEvvtV+EiT3JIIsR4I5qLL0i3mqgg=
X-Google-Smtp-Source: AK7set/rNylqkG0HRNC8hBxtCimTH5uwtiG+Y4F/E8WdEMjQuRK1MAtyZMDcPIF1Egnw/94Miw51AA==
X-Received: by 2002:ac8:5b44:0:b0:3b8:6ae9:b108 with SMTP id n4-20020ac85b44000000b003b86ae9b108mr17240790qtw.27.1677275587382;
        Fri, 24 Feb 2023 13:53:07 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x30-20020ac84d5e000000b003bfb62a377fsm319592qtv.3.2023.02.24.13.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 13:53:06 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     drv@mailo.com, ssengar@microsoft.com,
        kumarpraveen@linux.microsoft.com, christophe.jaillet@wanadoo.fr,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Miaoqian Lin <linmq006@gmail.com>, Liang He <windhl@126.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH] soc: bcm: brcmstb: Remove bare-metal ARM suspend/resume code
Date:   Fri, 24 Feb 2023 13:52:39 -0800
Message-Id: <20230224215249.239405-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since 2018 these platforms have supported entry via the ARM Trusted
Firmware using the standard PSCI SYSTEM_SUSPEND function calls. Remove
this legacy code.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/Kconfig       |   4 +-
 drivers/soc/bcm/brcmstb/pm/Makefile   |   1 -
 drivers/soc/bcm/brcmstb/pm/aon_defs.h | 105 ----
 drivers/soc/bcm/brcmstb/pm/pm-arm.c   | 874 --------------------------
 drivers/soc/bcm/brcmstb/pm/s2-arm.S   |  69 --
 5 files changed, 1 insertion(+), 1052 deletions(-)
 delete mode 100644 drivers/soc/bcm/brcmstb/pm/aon_defs.h
 delete mode 100644 drivers/soc/bcm/brcmstb/pm/pm-arm.c
 delete mode 100644 drivers/soc/bcm/brcmstb/pm/s2-arm.S

diff --git a/drivers/soc/bcm/brcmstb/Kconfig b/drivers/soc/bcm/brcmstb/Kconfig
index 38e476905d96..c68d0e5267c4 100644
--- a/drivers/soc/bcm/brcmstb/Kconfig
+++ b/drivers/soc/bcm/brcmstb/Kconfig
@@ -4,8 +4,6 @@ if SOC_BRCMSTB
 config BRCMSTB_PM
 	bool "Support suspend/resume for STB platforms"
 	default y
-	depends on PM
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
-	select ARM_CPU_SUSPEND if ARM
+	depends on PM && BMIPS_GENERIC
 
 endif # SOC_BRCMSTB
diff --git a/drivers/soc/bcm/brcmstb/pm/Makefile b/drivers/soc/bcm/brcmstb/pm/Makefile
index f849cfa69446..9133a9ee0782 100644
--- a/drivers/soc/bcm/brcmstb/pm/Makefile
+++ b/drivers/soc/bcm/brcmstb/pm/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ARM)		+= s2-arm.o pm-arm.o
 obj-$(CONFIG_BMIPS_GENERIC)	+= s2-mips.o s3-mips.o pm-mips.o
diff --git a/drivers/soc/bcm/brcmstb/pm/aon_defs.h b/drivers/soc/bcm/brcmstb/pm/aon_defs.h
deleted file mode 100644
index f695262ac930..000000000000
--- a/drivers/soc/bcm/brcmstb/pm/aon_defs.h
+++ /dev/null
@@ -1,105 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Always ON (AON) register interface between bootloader and Linux
- *
- * Copyright © 2014-2017 Broadcom
- */
-
-#ifndef __BRCMSTB_AON_DEFS_H__
-#define __BRCMSTB_AON_DEFS_H__
-
-#include <linux/compiler.h>
-
-/* Magic number in upper 16-bits */
-#define BRCMSTB_S3_MAGIC_MASK                   0xffff0000
-#define BRCMSTB_S3_MAGIC_SHORT                  0x5AFE0000
-
-enum {
-	/* Restore random key for AES memory verification (off = fixed key) */
-	S3_FLAG_LOAD_RANDKEY		= (1 << 0),
-
-	/* Scratch buffer page table is present */
-	S3_FLAG_SCRATCH_BUFFER_TABLE	= (1 << 1),
-
-	/* Skip all memory verification */
-	S3_FLAG_NO_MEM_VERIFY		= (1 << 2),
-
-	/*
-	 * Modification of this bit reserved for bootloader only.
-	 * 1=PSCI started Linux, 0=Direct jump to Linux.
-	 */
-	S3_FLAG_PSCI_BOOT		= (1 << 3),
-
-	/*
-	 * Modification of this bit reserved for bootloader only.
-	 * 1=64 bit boot, 0=32 bit boot.
-	 */
-	S3_FLAG_BOOTED64		= (1 << 4),
-};
-
-#define BRCMSTB_HASH_LEN			(128 / 8) /* 128-bit hash */
-
-#define AON_REG_MAGIC_FLAGS			0x00
-#define AON_REG_CONTROL_LOW			0x04
-#define AON_REG_CONTROL_HIGH			0x08
-#define AON_REG_S3_HASH				0x0c /* hash of S3 params */
-#define AON_REG_CONTROL_HASH_LEN		0x1c
-#define AON_REG_PANIC				0x20
-
-#define BRCMSTB_S3_MAGIC		0x5AFEB007
-#define BRCMSTB_PANIC_MAGIC		0x512E115E
-#define BOOTLOADER_SCRATCH_SIZE		64
-#define BRCMSTB_DTU_STATE_MAP_ENTRIES	(8*1024)
-#define BRCMSTB_DTU_CONFIG_ENTRIES	(512)
-#define BRCMSTB_DTU_COUNT		(2)
-
-#define IMAGE_DESCRIPTORS_BUFSIZE	(2 * 1024)
-#define S3_BOOTLOADER_RESERVED		(S3_FLAG_PSCI_BOOT | S3_FLAG_BOOTED64)
-
-struct brcmstb_bootloader_dtu_table {
-	uint32_t	dtu_state_map[BRCMSTB_DTU_STATE_MAP_ENTRIES];
-	uint32_t	dtu_config[BRCMSTB_DTU_CONFIG_ENTRIES];
-};
-
-/*
- * Bootloader utilizes a custom parameter block left in DRAM for handling S3
- * warm resume
- */
-struct brcmstb_s3_params {
-	/* scratch memory for bootloader */
-	uint8_t scratch[BOOTLOADER_SCRATCH_SIZE];
-
-	uint32_t magic; /* BRCMSTB_S3_MAGIC */
-	uint64_t reentry; /* PA */
-
-	/* descriptors */
-	uint32_t hash[BRCMSTB_HASH_LEN / 4];
-
-	/*
-	 * If 0, then ignore this parameter (there is only one set of
-	 *   descriptors)
-	 *
-	 * If non-0, then a second set of descriptors is stored at:
-	 *
-	 *   descriptors + desc_offset_2
-	 *
-	 * The MAC result of both descriptors is XOR'd and stored in @hash
-	 */
-	uint32_t desc_offset_2;
-
-	/*
-	 * (Physical) address of a brcmstb_bootloader_scratch_table, for
-	 * providing a large DRAM buffer to the bootloader
-	 */
-	uint64_t buffer_table;
-
-	uint32_t spare[70];
-
-	uint8_t descriptors[IMAGE_DESCRIPTORS_BUFSIZE];
-	/*
-	 * Must be last member of struct. See brcmstb_pm_s3_finish() for reason.
-	 */
-	struct brcmstb_bootloader_dtu_table dtu[BRCMSTB_DTU_COUNT];
-} __packed;
-
-#endif /* __BRCMSTB_AON_DEFS_H__ */
diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
deleted file mode 100644
index d681cd24c6e1..000000000000
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ /dev/null
@@ -1,874 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * ARM-specific support for Broadcom STB S2/S3/S5 power management
- *
- * S2: clock gate CPUs and as many peripherals as possible
- * S3: power off all of the chip except the Always ON (AON) island; keep DDR is
- *     self-refresh
- * S5: (a.k.a. S3 cold boot) much like S3, except DDR is powered down, so we
- *     treat this mode like a soft power-off, with wakeup allowed from AON
- *
- * Copyright © 2014-2017 Broadcom
- */
-
-#define pr_fmt(fmt) "brcmstb-pm: " fmt
-
-#include <linux/bitops.h>
-#include <linux/compiler.h>
-#include <linux/delay.h>
-#include <linux/dma-mapping.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/kconfig.h>
-#include <linux/kernel.h>
-#include <linux/memblock.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/panic_notifier.h>
-#include <linux/platform_device.h>
-#include <linux/pm.h>
-#include <linux/printk.h>
-#include <linux/proc_fs.h>
-#include <linux/sizes.h>
-#include <linux/slab.h>
-#include <linux/sort.h>
-#include <linux/suspend.h>
-#include <linux/types.h>
-#include <linux/uaccess.h>
-#include <linux/soc/brcmstb/brcmstb.h>
-
-#include <asm/fncpy.h>
-#include <asm/setup.h>
-#include <asm/suspend.h>
-
-#include "pm.h"
-#include "aon_defs.h"
-
-#define SHIMPHY_DDR_PAD_CNTRL		0x8c
-
-/* Method #0 */
-#define SHIMPHY_PAD_PLL_SEQUENCE	BIT(8)
-#define SHIMPHY_PAD_GATE_PLL_S3		BIT(9)
-
-/* Method #1 */
-#define PWRDWN_SEQ_NO_SEQUENCING	0
-#define PWRDWN_SEQ_HOLD_CHANNEL		1
-#define	PWRDWN_SEQ_RESET_PLL		2
-#define PWRDWN_SEQ_POWERDOWN_PLL	3
-
-#define SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK	0x00f00000
-#define SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT	20
-
-#define	DDR_FORCE_CKE_RST_N		BIT(3)
-#define	DDR_PHY_RST_N			BIT(2)
-#define	DDR_PHY_CKE			BIT(1)
-
-#define	DDR_PHY_NO_CHANNEL		0xffffffff
-
-#define MAX_NUM_MEMC			3
-
-struct brcmstb_memc {
-	void __iomem *ddr_phy_base;
-	void __iomem *ddr_shimphy_base;
-	void __iomem *ddr_ctrl;
-};
-
-struct brcmstb_pm_control {
-	void __iomem *aon_ctrl_base;
-	void __iomem *aon_sram;
-	struct brcmstb_memc memcs[MAX_NUM_MEMC];
-
-	void __iomem *boot_sram;
-	size_t boot_sram_len;
-
-	bool support_warm_boot;
-	size_t pll_status_offset;
-	int num_memc;
-
-	struct brcmstb_s3_params *s3_params;
-	dma_addr_t s3_params_pa;
-	int s3entry_method;
-	u32 warm_boot_offset;
-	u32 phy_a_standby_ctrl_offs;
-	u32 phy_b_standby_ctrl_offs;
-	bool needs_ddr_pad;
-	struct platform_device *pdev;
-};
-
-enum bsp_initiate_command {
-	BSP_CLOCK_STOP		= 0x00,
-	BSP_GEN_RANDOM_KEY	= 0x4A,
-	BSP_RESTORE_RANDOM_KEY	= 0x55,
-	BSP_GEN_FIXED_KEY	= 0x63,
-};
-
-#define PM_INITIATE		0x01
-#define PM_INITIATE_SUCCESS	0x00
-#define PM_INITIATE_FAIL	0xfe
-
-static struct brcmstb_pm_control ctrl;
-
-noinline int brcmstb_pm_s3_finish(void);
-
-static int (*brcmstb_pm_do_s2_sram)(void __iomem *aon_ctrl_base,
-		void __iomem *ddr_phy_pll_status);
-
-static int brcmstb_init_sram(struct device_node *dn)
-{
-	void __iomem *sram;
-	struct resource res;
-	int ret;
-
-	ret = of_address_to_resource(dn, 0, &res);
-	if (ret)
-		return ret;
-
-	/* Uncached, executable remapping of SRAM */
-	sram = __arm_ioremap_exec(res.start, resource_size(&res), false);
-	if (!sram)
-		return -ENOMEM;
-
-	ctrl.boot_sram = sram;
-	ctrl.boot_sram_len = resource_size(&res);
-
-	return 0;
-}
-
-static const struct of_device_id sram_dt_ids[] = {
-	{ .compatible = "mmio-sram" },
-	{ /* sentinel */ }
-};
-
-static int do_bsp_initiate_command(enum bsp_initiate_command cmd)
-{
-	void __iomem *base = ctrl.aon_ctrl_base;
-	int ret;
-	int timeo = 1000 * 1000; /* 1 second */
-
-	writel_relaxed(0, base + AON_CTRL_PM_INITIATE);
-	(void)readl_relaxed(base + AON_CTRL_PM_INITIATE);
-
-	/* Go! */
-	writel_relaxed((cmd << 1) | PM_INITIATE, base + AON_CTRL_PM_INITIATE);
-
-	/*
-	 * If firmware doesn't support the 'ack', then just assume it's done
-	 * after 10ms. Note that this only works for command 0, BSP_CLOCK_STOP
-	 */
-	if (of_machine_is_compatible("brcm,bcm74371a0")) {
-		(void)readl_relaxed(base + AON_CTRL_PM_INITIATE);
-		mdelay(10);
-		return 0;
-	}
-
-	for (;;) {
-		ret = readl_relaxed(base + AON_CTRL_PM_INITIATE);
-		if (!(ret & PM_INITIATE))
-			break;
-		if (timeo <= 0) {
-			pr_err("error: timeout waiting for BSP (%x)\n", ret);
-			break;
-		}
-		timeo -= 50;
-		udelay(50);
-	}
-
-	return (ret & 0xff) != PM_INITIATE_SUCCESS;
-}
-
-static int brcmstb_pm_handshake(void)
-{
-	void __iomem *base = ctrl.aon_ctrl_base;
-	u32 tmp;
-	int ret;
-
-	/* BSP power handshake, v1 */
-	tmp = readl_relaxed(base + AON_CTRL_HOST_MISC_CMDS);
-	tmp &= ~1UL;
-	writel_relaxed(tmp, base + AON_CTRL_HOST_MISC_CMDS);
-	(void)readl_relaxed(base + AON_CTRL_HOST_MISC_CMDS);
-
-	ret = do_bsp_initiate_command(BSP_CLOCK_STOP);
-	if (ret)
-		pr_err("BSP handshake failed\n");
-
-	/*
-	 * HACK: BSP may have internal race on the CLOCK_STOP command.
-	 * Avoid touching the BSP for a few milliseconds.
-	 */
-	mdelay(3);
-
-	return ret;
-}
-
-static inline void shimphy_set(u32 value, u32 mask)
-{
-	int i;
-
-	if (!ctrl.needs_ddr_pad)
-		return;
-
-	for (i = 0; i < ctrl.num_memc; i++) {
-		u32 tmp;
-
-		tmp = readl_relaxed(ctrl.memcs[i].ddr_shimphy_base +
-			SHIMPHY_DDR_PAD_CNTRL);
-		tmp = value | (tmp & mask);
-		writel_relaxed(tmp, ctrl.memcs[i].ddr_shimphy_base +
-			SHIMPHY_DDR_PAD_CNTRL);
-	}
-	wmb(); /* Complete sequence in order. */
-}
-
-static inline void ddr_ctrl_set(bool warmboot)
-{
-	int i;
-
-	for (i = 0; i < ctrl.num_memc; i++) {
-		u32 tmp;
-
-		tmp = readl_relaxed(ctrl.memcs[i].ddr_ctrl +
-				ctrl.warm_boot_offset);
-		if (warmboot)
-			tmp |= 1;
-		else
-			tmp &= ~1; /* Cold boot */
-		writel_relaxed(tmp, ctrl.memcs[i].ddr_ctrl +
-				ctrl.warm_boot_offset);
-	}
-	/* Complete sequence in order */
-	wmb();
-}
-
-static inline void s3entry_method0(void)
-{
-	shimphy_set(SHIMPHY_PAD_GATE_PLL_S3 | SHIMPHY_PAD_PLL_SEQUENCE,
-		    0xffffffff);
-}
-
-static inline void s3entry_method1(void)
-{
-	/*
-	 * S3 Entry Sequence
-	 * -----------------
-	 * Step 1: SHIMPHY_ADDR_CNTL_0_DDR_PAD_CNTRL [ S3_PWRDWN_SEQ ] = 3
-	 * Step 2: MEMC_DDR_0_WARM_BOOT [ WARM_BOOT ] = 1
-	 */
-	shimphy_set((PWRDWN_SEQ_POWERDOWN_PLL <<
-		    SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT),
-		    ~SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK);
-
-	ddr_ctrl_set(true);
-}
-
-static inline void s5entry_method1(void)
-{
-	int i;
-
-	/*
-	 * S5 Entry Sequence
-	 * -----------------
-	 * Step 1: SHIMPHY_ADDR_CNTL_0_DDR_PAD_CNTRL [ S3_PWRDWN_SEQ ] = 3
-	 * Step 2: MEMC_DDR_0_WARM_BOOT [ WARM_BOOT ] = 0
-	 * Step 3: DDR_PHY_CONTROL_REGS_[AB]_0_STANDBY_CONTROL[ CKE ] = 0
-	 *	   DDR_PHY_CONTROL_REGS_[AB]_0_STANDBY_CONTROL[ RST_N ] = 0
-	 */
-	shimphy_set((PWRDWN_SEQ_POWERDOWN_PLL <<
-		    SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT),
-		    ~SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK);
-
-	ddr_ctrl_set(false);
-
-	for (i = 0; i < ctrl.num_memc; i++) {
-		u32 tmp;
-
-		/* Step 3: Channel A (RST_N = CKE = 0) */
-		tmp = readl_relaxed(ctrl.memcs[i].ddr_phy_base +
-				  ctrl.phy_a_standby_ctrl_offs);
-		tmp &= ~(DDR_PHY_RST_N | DDR_PHY_RST_N);
-		writel_relaxed(tmp, ctrl.memcs[i].ddr_phy_base +
-			     ctrl.phy_a_standby_ctrl_offs);
-
-		/* Step 3: Channel B? */
-		if (ctrl.phy_b_standby_ctrl_offs != DDR_PHY_NO_CHANNEL) {
-			tmp = readl_relaxed(ctrl.memcs[i].ddr_phy_base +
-					  ctrl.phy_b_standby_ctrl_offs);
-			tmp &= ~(DDR_PHY_RST_N | DDR_PHY_RST_N);
-			writel_relaxed(tmp, ctrl.memcs[i].ddr_phy_base +
-				     ctrl.phy_b_standby_ctrl_offs);
-		}
-	}
-	/* Must complete */
-	wmb();
-}
-
-/*
- * Run a Power Management State Machine (PMSM) shutdown command and put the CPU
- * into a low-power mode
- */
-static void brcmstb_do_pmsm_power_down(unsigned long base_cmd, bool onewrite)
-{
-	void __iomem *base = ctrl.aon_ctrl_base;
-
-	if ((ctrl.s3entry_method == 1) && (base_cmd == PM_COLD_CONFIG))
-		s5entry_method1();
-
-	/* pm_start_pwrdn transition 0->1 */
-	writel_relaxed(base_cmd, base + AON_CTRL_PM_CTRL);
-
-	if (!onewrite) {
-		(void)readl_relaxed(base + AON_CTRL_PM_CTRL);
-
-		writel_relaxed(base_cmd | PM_PWR_DOWN, base + AON_CTRL_PM_CTRL);
-		(void)readl_relaxed(base + AON_CTRL_PM_CTRL);
-	}
-	wfi();
-}
-
-/* Support S5 cold boot out of "poweroff" */
-static void brcmstb_pm_poweroff(void)
-{
-	brcmstb_pm_handshake();
-
-	/* Clear magic S3 warm-boot value */
-	writel_relaxed(0, ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
-	(void)readl_relaxed(ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
-
-	/* Skip wait-for-interrupt signal; just use a countdown */
-	writel_relaxed(0x10, ctrl.aon_ctrl_base + AON_CTRL_PM_CPU_WAIT_COUNT);
-	(void)readl_relaxed(ctrl.aon_ctrl_base + AON_CTRL_PM_CPU_WAIT_COUNT);
-
-	if (ctrl.s3entry_method == 1) {
-		shimphy_set((PWRDWN_SEQ_POWERDOWN_PLL <<
-			     SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT),
-			     ~SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK);
-		ddr_ctrl_set(false);
-		brcmstb_do_pmsm_power_down(M1_PM_COLD_CONFIG, true);
-		return; /* We should never actually get here */
-	}
-
-	brcmstb_do_pmsm_power_down(PM_COLD_CONFIG, false);
-}
-
-static void *brcmstb_pm_copy_to_sram(void *fn, size_t len)
-{
-	unsigned int size = ALIGN(len, FNCPY_ALIGN);
-
-	if (ctrl.boot_sram_len < size) {
-		pr_err("standby code will not fit in SRAM\n");
-		return NULL;
-	}
-
-	return fncpy(ctrl.boot_sram, fn, size);
-}
-
-/*
- * S2 suspend/resume picks up where we left off, so we must execute carefully
- * from SRAM, in order to allow DDR to come back up safely before we continue.
- */
-static int brcmstb_pm_s2(void)
-{
-	/* A previous S3 can set a value hazardous to S2, so make sure. */
-	if (ctrl.s3entry_method == 1) {
-		shimphy_set((PWRDWN_SEQ_NO_SEQUENCING <<
-			    SHIMPHY_PAD_S3_PWRDWN_SEQ_SHIFT),
-			    ~SHIMPHY_PAD_S3_PWRDWN_SEQ_MASK);
-		ddr_ctrl_set(false);
-	}
-
-	brcmstb_pm_do_s2_sram = brcmstb_pm_copy_to_sram(&brcmstb_pm_do_s2,
-			brcmstb_pm_do_s2_sz);
-	if (!brcmstb_pm_do_s2_sram)
-		return -EINVAL;
-
-	return brcmstb_pm_do_s2_sram(ctrl.aon_ctrl_base,
-			ctrl.memcs[0].ddr_phy_base +
-			ctrl.pll_status_offset);
-}
-
-/*
- * This function is called on a new stack, so don't allow inlining (which will
- * generate stack references on the old stack). It cannot be made static because
- * it is referenced from brcmstb_pm_s3()
- */
-noinline int brcmstb_pm_s3_finish(void)
-{
-	struct brcmstb_s3_params *params = ctrl.s3_params;
-	dma_addr_t params_pa = ctrl.s3_params_pa;
-	phys_addr_t reentry = virt_to_phys(&cpu_resume_arm);
-	enum bsp_initiate_command cmd;
-	u32 flags;
-
-	/*
-	 * Clear parameter structure, but not DTU area, which has already been
-	 * filled in. We know DTU is a the end, so we can just subtract its
-	 * size.
-	 */
-	memset(params, 0, sizeof(*params) - sizeof(params->dtu));
-
-	flags = readl_relaxed(ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
-
-	flags &= S3_BOOTLOADER_RESERVED;
-	flags |= S3_FLAG_NO_MEM_VERIFY;
-	flags |= S3_FLAG_LOAD_RANDKEY;
-
-	/* Load random / fixed key */
-	if (flags & S3_FLAG_LOAD_RANDKEY)
-		cmd = BSP_GEN_RANDOM_KEY;
-	else
-		cmd = BSP_GEN_FIXED_KEY;
-	if (do_bsp_initiate_command(cmd)) {
-		pr_info("key loading failed\n");
-		return -EIO;
-	}
-
-	params->magic = BRCMSTB_S3_MAGIC;
-	params->reentry = reentry;
-
-	/* No more writes to DRAM */
-	flush_cache_all();
-
-	flags |= BRCMSTB_S3_MAGIC_SHORT;
-
-	writel_relaxed(flags, ctrl.aon_sram + AON_REG_MAGIC_FLAGS);
-	writel_relaxed(lower_32_bits(params_pa),
-		       ctrl.aon_sram + AON_REG_CONTROL_LOW);
-	writel_relaxed(upper_32_bits(params_pa),
-		       ctrl.aon_sram + AON_REG_CONTROL_HIGH);
-
-	switch (ctrl.s3entry_method) {
-	case 0:
-		s3entry_method0();
-		brcmstb_do_pmsm_power_down(PM_WARM_CONFIG, false);
-		break;
-	case 1:
-		s3entry_method1();
-		brcmstb_do_pmsm_power_down(M1_PM_WARM_CONFIG, true);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* Must have been interrupted from wfi()? */
-	return -EINTR;
-}
-
-static int brcmstb_pm_do_s3(unsigned long sp)
-{
-	unsigned long save_sp;
-	int ret;
-
-	asm volatile (
-		"mov	%[save], sp\n"
-		"mov	sp, %[new]\n"
-		"bl	brcmstb_pm_s3_finish\n"
-		"mov	%[ret], r0\n"
-		"mov	%[new], sp\n"
-		"mov	sp, %[save]\n"
-		: [save] "=&r" (save_sp), [ret] "=&r" (ret)
-		: [new] "r" (sp)
-	);
-
-	return ret;
-}
-
-static int brcmstb_pm_s3(void)
-{
-	void __iomem *sp = ctrl.boot_sram + ctrl.boot_sram_len;
-
-	return cpu_suspend((unsigned long)sp, brcmstb_pm_do_s3);
-}
-
-static int brcmstb_pm_standby(bool deep_standby)
-{
-	int ret;
-
-	if (brcmstb_pm_handshake())
-		return -EIO;
-
-	if (deep_standby)
-		ret = brcmstb_pm_s3();
-	else
-		ret = brcmstb_pm_s2();
-	if (ret)
-		pr_err("%s: standby failed\n", __func__);
-
-	return ret;
-}
-
-static int brcmstb_pm_enter(suspend_state_t state)
-{
-	int ret = -EINVAL;
-
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-		ret = brcmstb_pm_standby(false);
-		break;
-	case PM_SUSPEND_MEM:
-		ret = brcmstb_pm_standby(true);
-		break;
-	}
-
-	return ret;
-}
-
-static int brcmstb_pm_valid(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-		return true;
-	case PM_SUSPEND_MEM:
-		return ctrl.support_warm_boot;
-	default:
-		return false;
-	}
-}
-
-static const struct platform_suspend_ops brcmstb_pm_ops = {
-	.enter		= brcmstb_pm_enter,
-	.valid		= brcmstb_pm_valid,
-};
-
-static const struct of_device_id aon_ctrl_dt_ids[] = {
-	{ .compatible = "brcm,brcmstb-aon-ctrl" },
-	{}
-};
-
-struct ddr_phy_ofdata {
-	bool supports_warm_boot;
-	size_t pll_status_offset;
-	int s3entry_method;
-	u32 warm_boot_offset;
-	u32 phy_a_standby_ctrl_offs;
-	u32 phy_b_standby_ctrl_offs;
-};
-
-static struct ddr_phy_ofdata ddr_phy_71_1 = {
-	.supports_warm_boot = true,
-	.pll_status_offset = 0x0c,
-	.s3entry_method = 1,
-	.warm_boot_offset = 0x2c,
-	.phy_a_standby_ctrl_offs = 0x198,
-	.phy_b_standby_ctrl_offs = DDR_PHY_NO_CHANNEL
-};
-
-static struct ddr_phy_ofdata ddr_phy_72_0 = {
-	.supports_warm_boot = true,
-	.pll_status_offset = 0x10,
-	.s3entry_method = 1,
-	.warm_boot_offset = 0x40,
-	.phy_a_standby_ctrl_offs = 0x2a4,
-	.phy_b_standby_ctrl_offs = 0x8a4
-};
-
-static struct ddr_phy_ofdata ddr_phy_225_1 = {
-	.supports_warm_boot = false,
-	.pll_status_offset = 0x4,
-	.s3entry_method = 0
-};
-
-static struct ddr_phy_ofdata ddr_phy_240_1 = {
-	.supports_warm_boot = true,
-	.pll_status_offset = 0x4,
-	.s3entry_method = 0
-};
-
-static const struct of_device_id ddr_phy_dt_ids[] = {
-	{
-		.compatible = "brcm,brcmstb-ddr-phy-v71.1",
-		.data = &ddr_phy_71_1,
-	},
-	{
-		.compatible = "brcm,brcmstb-ddr-phy-v72.0",
-		.data = &ddr_phy_72_0,
-	},
-	{
-		.compatible = "brcm,brcmstb-ddr-phy-v225.1",
-		.data = &ddr_phy_225_1,
-	},
-	{
-		.compatible = "brcm,brcmstb-ddr-phy-v240.1",
-		.data = &ddr_phy_240_1,
-	},
-	{
-		/* Same as v240.1, for the registers we care about */
-		.compatible = "brcm,brcmstb-ddr-phy-v240.2",
-		.data = &ddr_phy_240_1,
-	},
-	{}
-};
-
-struct ddr_seq_ofdata {
-	bool needs_ddr_pad;
-	u32 warm_boot_offset;
-};
-
-static const struct ddr_seq_ofdata ddr_seq_b22 = {
-	.needs_ddr_pad = false,
-	.warm_boot_offset = 0x2c,
-};
-
-static const struct ddr_seq_ofdata ddr_seq = {
-	.needs_ddr_pad = true,
-};
-
-static const struct of_device_id ddr_shimphy_dt_ids[] = {
-	{ .compatible = "brcm,brcmstb-ddr-shimphy-v1.0" },
-	{}
-};
-
-static const struct of_device_id brcmstb_memc_of_match[] = {
-	{
-		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.1",
-		.data = &ddr_seq,
-	},
-	{
-		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.2",
-		.data = &ddr_seq_b22,
-	},
-	{
-		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.3",
-		.data = &ddr_seq_b22,
-	},
-	{
-		.compatible = "brcm,brcmstb-memc-ddr-rev-b.3.0",
-		.data = &ddr_seq_b22,
-	},
-	{
-		.compatible = "brcm,brcmstb-memc-ddr-rev-b.3.1",
-		.data = &ddr_seq_b22,
-	},
-	{
-		.compatible = "brcm,brcmstb-memc-ddr",
-		.data = &ddr_seq,
-	},
-	{},
-};
-
-static void __iomem *brcmstb_ioremap_match(const struct of_device_id *matches,
-					   int index, const void **ofdata)
-{
-	struct device_node *dn;
-	const struct of_device_id *match;
-
-	dn = of_find_matching_node_and_match(NULL, matches, &match);
-	if (!dn)
-		return ERR_PTR(-EINVAL);
-
-	if (ofdata)
-		*ofdata = match->data;
-
-	return of_io_request_and_map(dn, index, dn->full_name);
-}
-/*
- * The AON is a small domain in the SoC that can retain its state across
- * various system wide sleep states and specific reset conditions; the
- * AON DATA RAM is a small RAM of a few words (< 1KB) which can store
- * persistent information across such events.
- *
- * The purpose of the below panic notifier is to help with notifying
- * the bootloader that a panic occurred and so that it should try its
- * best to preserve the DRAM contents holding that buffer for recovery
- * by the kernel as opposed to wiping out DRAM clean again.
- *
- * Reference: comment from Florian Fainelli, at
- * https://lore.kernel.org/lkml/781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com
- */
-static int brcmstb_pm_panic_notify(struct notifier_block *nb,
-		unsigned long action, void *data)
-{
-	writel_relaxed(BRCMSTB_PANIC_MAGIC, ctrl.aon_sram + AON_REG_PANIC);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block brcmstb_pm_panic_nb = {
-	.notifier_call = brcmstb_pm_panic_notify,
-};
-
-static int brcmstb_pm_probe(struct platform_device *pdev)
-{
-	const struct ddr_phy_ofdata *ddr_phy_data;
-	const struct ddr_seq_ofdata *ddr_seq_data;
-	const struct of_device_id *of_id = NULL;
-	struct device_node *dn;
-	void __iomem *base;
-	int ret, i, s;
-
-	/* AON ctrl registers */
-	base = brcmstb_ioremap_match(aon_ctrl_dt_ids, 0, NULL);
-	if (IS_ERR(base)) {
-		pr_err("error mapping AON_CTRL\n");
-		ret = PTR_ERR(base);
-		goto aon_err;
-	}
-	ctrl.aon_ctrl_base = base;
-
-	/* AON SRAM registers */
-	base = brcmstb_ioremap_match(aon_ctrl_dt_ids, 1, NULL);
-	if (IS_ERR(base)) {
-		/* Assume standard offset */
-		ctrl.aon_sram = ctrl.aon_ctrl_base +
-				     AON_CTRL_SYSTEM_DATA_RAM_OFS;
-		s = 0;
-	} else {
-		ctrl.aon_sram = base;
-		s = 1;
-	}
-
-	writel_relaxed(0, ctrl.aon_sram + AON_REG_PANIC);
-
-	/* DDR PHY registers */
-	base = brcmstb_ioremap_match(ddr_phy_dt_ids, 0,
-				     (const void **)&ddr_phy_data);
-	if (IS_ERR(base)) {
-		pr_err("error mapping DDR PHY\n");
-		ret = PTR_ERR(base);
-		goto ddr_phy_err;
-	}
-	ctrl.support_warm_boot = ddr_phy_data->supports_warm_boot;
-	ctrl.pll_status_offset = ddr_phy_data->pll_status_offset;
-	/* Only need DDR PHY 0 for now? */
-	ctrl.memcs[0].ddr_phy_base = base;
-	ctrl.s3entry_method = ddr_phy_data->s3entry_method;
-	ctrl.phy_a_standby_ctrl_offs = ddr_phy_data->phy_a_standby_ctrl_offs;
-	ctrl.phy_b_standby_ctrl_offs = ddr_phy_data->phy_b_standby_ctrl_offs;
-	/*
-	 * Slightly gross to use the phy ver to get a memc,
-	 * offset but that is the only versioned things so far
-	 * we can test for.
-	 */
-	ctrl.warm_boot_offset = ddr_phy_data->warm_boot_offset;
-
-	/* DDR SHIM-PHY registers */
-	for_each_matching_node(dn, ddr_shimphy_dt_ids) {
-		i = ctrl.num_memc;
-		if (i >= MAX_NUM_MEMC) {
-			of_node_put(dn);
-			pr_warn("too many MEMCs (max %d)\n", MAX_NUM_MEMC);
-			break;
-		}
-
-		base = of_io_request_and_map(dn, 0, dn->full_name);
-		if (IS_ERR(base)) {
-			of_node_put(dn);
-			if (!ctrl.support_warm_boot)
-				break;
-
-			pr_err("error mapping DDR SHIMPHY %d\n", i);
-			ret = PTR_ERR(base);
-			goto ddr_shimphy_err;
-		}
-		ctrl.memcs[i].ddr_shimphy_base = base;
-		ctrl.num_memc++;
-	}
-
-	/* Sequencer DRAM Param and Control Registers */
-	i = 0;
-	for_each_matching_node(dn, brcmstb_memc_of_match) {
-		base = of_iomap(dn, 0);
-		if (!base) {
-			of_node_put(dn);
-			pr_err("error mapping DDR Sequencer %d\n", i);
-			ret = -ENOMEM;
-			goto brcmstb_memc_err;
-		}
-
-		of_id = of_match_node(brcmstb_memc_of_match, dn);
-		if (!of_id) {
-			iounmap(base);
-			of_node_put(dn);
-			ret = -EINVAL;
-			goto brcmstb_memc_err;
-		}
-
-		ddr_seq_data = of_id->data;
-		ctrl.needs_ddr_pad = ddr_seq_data->needs_ddr_pad;
-		/* Adjust warm boot offset based on the DDR sequencer */
-		if (ddr_seq_data->warm_boot_offset)
-			ctrl.warm_boot_offset = ddr_seq_data->warm_boot_offset;
-
-		ctrl.memcs[i].ddr_ctrl = base;
-		i++;
-	}
-
-	pr_debug("PM: supports warm boot:%d, method:%d, wboffs:%x\n",
-		ctrl.support_warm_boot, ctrl.s3entry_method,
-		ctrl.warm_boot_offset);
-
-	dn = of_find_matching_node(NULL, sram_dt_ids);
-	if (!dn) {
-		pr_err("SRAM not found\n");
-		ret = -EINVAL;
-		goto brcmstb_memc_err;
-	}
-
-	ret = brcmstb_init_sram(dn);
-	of_node_put(dn);
-	if (ret) {
-		pr_err("error setting up SRAM for PM\n");
-		goto brcmstb_memc_err;
-	}
-
-	ctrl.pdev = pdev;
-
-	ctrl.s3_params = kmalloc(sizeof(*ctrl.s3_params), GFP_KERNEL);
-	if (!ctrl.s3_params) {
-		ret = -ENOMEM;
-		goto s3_params_err;
-	}
-	ctrl.s3_params_pa = dma_map_single(&pdev->dev, ctrl.s3_params,
-					   sizeof(*ctrl.s3_params),
-					   DMA_TO_DEVICE);
-	if (dma_mapping_error(&pdev->dev, ctrl.s3_params_pa)) {
-		pr_err("error mapping DMA memory\n");
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &brcmstb_pm_panic_nb);
-
-	pm_power_off = brcmstb_pm_poweroff;
-	suspend_set_ops(&brcmstb_pm_ops);
-
-	return 0;
-
-out:
-	kfree(ctrl.s3_params);
-s3_params_err:
-	iounmap(ctrl.boot_sram);
-brcmstb_memc_err:
-	for (i--; i >= 0; i--)
-		iounmap(ctrl.memcs[i].ddr_ctrl);
-ddr_shimphy_err:
-	for (i = 0; i < ctrl.num_memc; i++)
-		iounmap(ctrl.memcs[i].ddr_shimphy_base);
-
-	iounmap(ctrl.memcs[0].ddr_phy_base);
-ddr_phy_err:
-	iounmap(ctrl.aon_ctrl_base);
-	if (s)
-		iounmap(ctrl.aon_sram);
-aon_err:
-	pr_warn("PM: initialization failed with code %d\n", ret);
-
-	return ret;
-}
-
-static struct platform_driver brcmstb_pm_driver = {
-	.driver = {
-		.name	= "brcmstb-pm",
-		.of_match_table = aon_ctrl_dt_ids,
-	},
-};
-
-static int __init brcmstb_pm_init(void)
-{
-	return platform_driver_probe(&brcmstb_pm_driver,
-				     brcmstb_pm_probe);
-}
-module_init(brcmstb_pm_init);
diff --git a/drivers/soc/bcm/brcmstb/pm/s2-arm.S b/drivers/soc/bcm/brcmstb/pm/s2-arm.S
deleted file mode 100644
index 0d693795de27..000000000000
--- a/drivers/soc/bcm/brcmstb/pm/s2-arm.S
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright © 2014-2017 Broadcom
- */
-
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-
-#include "pm.h"
-
-	.arch armv7-a
-	.text
-	.align	3
-
-#define AON_CTRL_REG		r10
-#define DDR_PHY_STATUS_REG	r11
-
-/*
- * r0: AON_CTRL base address
- * r1: DDRY PHY PLL status register address
- */
-ENTRY(brcmstb_pm_do_s2)
-	stmfd	sp!, {r4-r11, lr}
-	mov	AON_CTRL_REG, r0
-	mov	DDR_PHY_STATUS_REG, r1
-
-	/* Flush memory transactions */
-	dsb
-
-	/* Cache DDR_PHY_STATUS_REG translation */
-	ldr	r0, [DDR_PHY_STATUS_REG]
-
-	/* power down request */
-	ldr	r0, =PM_S2_COMMAND
-	ldr	r1, =0
-	str	r1, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
-	ldr	r1, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
-	str	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
-	ldr	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
-
-	/* Wait for interrupt */
-	wfi
-	nop
-
-	/* Bring MEMC back up */
-1:	ldr	r0, [DDR_PHY_STATUS_REG]
-	ands	r0, #1
-	beq	1b
-
-	/* Power-up handshake */
-	ldr	r0, =1
-	str	r0, [AON_CTRL_REG, #AON_CTRL_HOST_MISC_CMDS]
-	ldr	r0, [AON_CTRL_REG, #AON_CTRL_HOST_MISC_CMDS]
-
-	ldr	r0, =0
-	str	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
-	ldr	r0, [AON_CTRL_REG, #AON_CTRL_PM_CTRL]
-
-	/* Return to caller */
-	ldr	r0, =0
-	ldmfd	sp!, {r4-r11, pc}
-
-	ENDPROC(brcmstb_pm_do_s2)
-
-	/* Place literal pool here */
-	.ltorg
-
-ENTRY(brcmstb_pm_do_s2_sz)
-	.word   . - brcmstb_pm_do_s2
-- 
2.34.1

