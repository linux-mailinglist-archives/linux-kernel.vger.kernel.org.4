Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E3F66579D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbjAKJgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjAKJew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:34:52 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC825F82;
        Wed, 11 Jan 2023 01:33:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so1385441pjl.0;
        Wed, 11 Jan 2023 01:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85yiqfm+Sjk5zm51MbyH9eN3BN60wR2dMPCLJCCbWMo=;
        b=dpwwfQr6TQTgB4Xz8pWz2wG1bJPuuxUZ07MYcfJyQsflXChpr+sFHRua5IwsBAHhWZ
         WqdX2O++0jSqxack+vbC9MIWvQojyG4AgDBwA56e/qXHK5hJM89CBd9oezOZF2jaTyUl
         jx8eBR4kcKDjDLfeqtCCEnn6VdAKof63hJmD5p1l6WjVaPT+1eQNToXhXcCQYYV6QNEA
         wAuQ8FGFSnjpvqmDrte8hmfOCjU1r0vpb08wkmjZKxlkPvq0HoGbqiBvPmWl25YGDttd
         iNqPDuQ1Sq+xyR6TgN22ubALQB1Gy3hnjcr7Sp1tZ+jEOtHptlQQhrXQFtb1SoA717Yi
         5AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85yiqfm+Sjk5zm51MbyH9eN3BN60wR2dMPCLJCCbWMo=;
        b=puQVdlUV7W8A4Np0HDga8qI1Q0SgpxR4JnWIga4cmrWUMmzmy25yKBi0nn+NFMrPka
         EUy3rhrCNBXpRJquS1e7vHkQOmhrTRS/4QofuTOe8ha2eEJiXijQr/DjlzfNyq4xOx8Z
         /lepRlG9ODwydghDPOACRwQ1ZxS5mTigDLgdF1DwklLSw4gNa/dFDKsNynJ6p7+fByRP
         wT72FMp+SLoxgLqMYtNEVAgTdZEVN1fjFoUnXiIi6FArkjL8Okgdmc00fa1WUFDDkD+o
         et8RK4FLTgQTO3eNBXtbuWEVmTwPG9A2WV12v6kEqvqb3Zkrc7WMWnUy9SbQXDN3KMFF
         ytJQ==
X-Gm-Message-State: AFqh2kp8FClE9fjg4saiah50GA042qGcsn8u8mftYaTeSsoPhp3btAkO
        gXQQgCyPnlbihZRccQfY2EI=
X-Google-Smtp-Source: AMrXdXv2mJX4ZIT0SdeAny4PWpPNMzBOzG+m7SnSFG95foSUH2B9RkPRgVu9JkDRmZnSRsHOrpMWkA==
X-Received: by 2002:a17:902:d893:b0:193:b7e:2bf8 with SMTP id b19-20020a170902d89300b001930b7e2bf8mr17638436plz.59.1673429599667;
        Wed, 11 Jan 2023 01:33:19 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902714600b001769e6d4fafsm2001341plm.57.2023.01.11.01.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:33:19 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org, bp@alien8.de,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, ctcchien@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v18 3/3] EDAC/npcm: Add NPCM memory controller driver
Date:   Wed, 11 Jan 2023 17:32:45 +0800
Message-Id: <20230111093245.318745-4-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111093245.318745-1-milkfafa@gmail.com>
References: <20230111093245.318745-1-milkfafa@gmail.com>
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

Add driver for memory controller present on Nuvoton NPCM SoCs. The
memory controller supports single bit error correction and double bit
error detection.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 MAINTAINERS              |   8 +
 drivers/edac/Kconfig     |  11 +
 drivers/edac/Makefile    |   1 +
 drivers/edac/npcm_edac.c | 543 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 563 insertions(+)
 create mode 100644 drivers/edac/npcm_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..7b41be30e6b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7557,6 +7557,14 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/mpc85xx_edac.[ch]
 
+EDAC-NPCM
+M:	Marvin Lin <kflin@nuvoton.com>
+M:	Stanley Chu <yschu@nuvoton.com>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-memory-controller.yaml
+F:	drivers/edac/npcm_edac.c
+
 EDAC-PASEMI
 M:	Egor Martovetsky <egor@pasemi.com>
 L:	linux-edac@vger.kernel.org
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 4cfdefbd744d..aa575f5b3125 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -542,4 +542,15 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_NPCM
+	tristate "Nuvoton NPCM DDR Memory Controller"
+	depends on (ARCH_NPCM || COMPILE_TEST)
+	help
+	  Support for error detection and correction on the Nuvoton NPCM DDR
+	  memory controller.
+
+	  The memory controller supports single bit error correction, double bit
+	  error detection (in-line ECC in which a section 1/8th of the memory
+	  device used to store data is used for ECC storage).
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 2d1641a27a28..db3c59d3ad84 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
+obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
diff --git a/drivers/edac/npcm_edac.c b/drivers/edac/npcm_edac.c
new file mode 100644
index 000000000000..12b95be3e989
--- /dev/null
+++ b/drivers/edac/npcm_edac.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2022 Nuvoton Technology Corporation
+
+#include <linux/debugfs.h>
+#include <linux/iopoll.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include "edac_module.h"
+
+#define EDAC_MOD_NAME			"npcm-edac"
+#define EDAC_MSG_SIZE			256
+
+/* chip serials */
+#define NPCM7XX_CHIP			BIT(0)
+#define NPCM8XX_CHIP			BIT(1)
+
+/* syndrome values */
+#define UE_SYNDROME			0x03
+
+/* error injection */
+#define ERROR_TYPE_CORRECTABLE		0
+#define ERROR_TYPE_UNCORRECTABLE	1
+#define ERROR_LOCATION_DATA		0
+#define ERROR_LOCATION_CHECKCODE	1
+#define ERROR_BIT_DATA_MAX		63
+#define ERROR_BIT_CHECKCODE_MAX		7
+
+static char data_synd[] = {
+	0xf4, 0xf1, 0xec, 0xea, 0xe9, 0xe6, 0xe5, 0xe3,
+	0xdc, 0xda, 0xd9, 0xd6, 0xd5, 0xd3, 0xce, 0xcb,
+	0xb5, 0xb0, 0xad, 0xab, 0xa8, 0xa7, 0xa4, 0xa2,
+	0x9d, 0x9b, 0x98, 0x97, 0x94, 0x92, 0x8f, 0x8a,
+	0x75, 0x70, 0x6d, 0x6b, 0x68, 0x67, 0x64, 0x62,
+	0x5e, 0x5b, 0x58, 0x57, 0x54, 0x52, 0x4f, 0x4a,
+	0x34, 0x31, 0x2c, 0x2a, 0x29, 0x26, 0x25, 0x23,
+	0x1c, 0x1a, 0x19, 0x16, 0x15, 0x13, 0x0e, 0x0b
+};
+
+static struct regmap *npcm_regmap;
+
+struct npcm_platform_data {
+	/* chip serials */
+	int chip;
+
+	/* memory controller registers */
+	u32 ctl_ecc_en;
+	u32 ctl_int_status;
+	u32 ctl_int_ack;
+	u32 ctl_int_mask_master;
+	u32 ctl_int_mask_ecc;
+	u32 ctl_ce_addr_l;
+	u32 ctl_ce_addr_h;
+	u32 ctl_ce_data_l;
+	u32 ctl_ce_data_h;
+	u32 ctl_ce_synd;
+	u32 ctl_ue_addr_l;
+	u32 ctl_ue_addr_h;
+	u32 ctl_ue_data_l;
+	u32 ctl_ue_data_h;
+	u32 ctl_ue_synd;
+	u32 ctl_source_id;
+	u32 ctl_controller_busy;
+	u32 ctl_xor_check_bits;
+
+	/* masks and shifts */
+	u32 ecc_en_mask;
+	u32 int_status_ce_mask;
+	u32 int_status_ue_mask;
+	u32 int_ack_ce_mask;
+	u32 int_ack_ue_mask;
+	u32 int_mask_master_non_ecc_mask;
+	u32 int_mask_master_global_mask;
+	u32 int_mask_ecc_non_event_mask;
+	u32 ce_addr_h_mask;
+	u32 ce_synd_mask;
+	u32 ce_synd_shift;
+	u32 ue_addr_h_mask;
+	u32 ue_synd_mask;
+	u32 ue_synd_shift;
+	u32 source_id_ce_mask;
+	u32 source_id_ce_shift;
+	u32 source_id_ue_mask;
+	u32 source_id_ue_shift;
+	u32 controller_busy_mask;
+	u32 xor_check_bits_mask;
+	u32 xor_check_bits_shift;
+	u32 writeback_en_mask;
+	u32 fwc_mask;
+};
+
+struct priv_data {
+	void __iomem *reg;
+	char message[EDAC_MSG_SIZE];
+	const struct npcm_platform_data *pdata;
+
+	/* error injection */
+	struct dentry *debugfs;
+	u8 error_type;
+	u8 location;
+	u8 bit;
+};
+
+static void handle_ce(struct mem_ctl_info *mci)
+{
+	struct priv_data *priv = mci->pvt_info;
+	const struct npcm_platform_data *pdata;
+	u32 val_h = 0, val_l, id, synd;
+	u64 addr = 0, data = 0;
+
+	pdata = priv->pdata;
+	regmap_read(npcm_regmap, pdata->ctl_ce_addr_l, &val_l);
+	if (pdata->chip == NPCM8XX_CHIP) {
+		regmap_read(npcm_regmap, pdata->ctl_ce_addr_h, &val_h);
+		val_h &= pdata->ce_addr_h_mask;
+	}
+	addr = ((addr | val_h) << 32) | val_l;
+
+	regmap_read(npcm_regmap, pdata->ctl_ce_data_l, &val_l);
+	if (pdata->chip == NPCM8XX_CHIP)
+		regmap_read(npcm_regmap, pdata->ctl_ce_data_h, &val_h);
+	data = ((data | val_h) << 32) | val_l;
+
+	regmap_read(npcm_regmap, pdata->ctl_source_id, &id);
+	id = (id & pdata->source_id_ce_mask) >> pdata->source_id_ce_shift;
+
+	regmap_read(npcm_regmap, pdata->ctl_ce_synd, &synd);
+	synd = (synd & pdata->ce_synd_mask) >> pdata->ce_synd_shift;
+
+	snprintf(priv->message, EDAC_MSG_SIZE,
+		 "addr = 0x%llx, data = 0x%llx, id = 0x%x", addr, data, id);
+
+	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1, addr >> PAGE_SHIFT,
+			     addr & ~PAGE_MASK, synd, 0, 0, -1, priv->message, "");
+}
+
+static void handle_ue(struct mem_ctl_info *mci)
+{
+	struct priv_data *priv = mci->pvt_info;
+	const struct npcm_platform_data *pdata;
+	u32 val_h = 0, val_l, id, synd;
+	u64 addr = 0, data = 0;
+
+	pdata = priv->pdata;
+	regmap_read(npcm_regmap, pdata->ctl_ue_addr_l, &val_l);
+	if (pdata->chip == NPCM8XX_CHIP) {
+		regmap_read(npcm_regmap, pdata->ctl_ue_addr_h, &val_h);
+		val_h &= pdata->ue_addr_h_mask;
+	}
+	addr = ((addr | val_h) << 32) | val_l;
+
+	regmap_read(npcm_regmap, pdata->ctl_ue_data_l, &val_l);
+	if (pdata->chip == NPCM8XX_CHIP)
+		regmap_read(npcm_regmap, pdata->ctl_ue_data_h, &val_h);
+	data = ((data | val_h) << 32) | val_l;
+
+	regmap_read(npcm_regmap, pdata->ctl_source_id, &id);
+	id = (id & pdata->source_id_ue_mask) >> pdata->source_id_ue_shift;
+
+	regmap_read(npcm_regmap, pdata->ctl_ue_synd, &synd);
+	synd = (synd & pdata->ue_synd_mask) >> pdata->ue_synd_shift;
+
+	snprintf(priv->message, EDAC_MSG_SIZE,
+		 "addr = 0x%llx, data = 0x%llx, id = 0x%x", addr, data, id);
+
+	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1, addr >> PAGE_SHIFT,
+			     addr & ~PAGE_MASK, synd, 0, 0, -1, priv->message, "");
+}
+
+static irqreturn_t edac_ecc_isr(int irq, void *dev_id)
+{
+	const struct npcm_platform_data *pdata;
+	struct mem_ctl_info *mci = dev_id;
+	u32 status;
+
+	pdata = ((struct priv_data *)mci->pvt_info)->pdata;
+	regmap_read(npcm_regmap, pdata->ctl_int_status, &status);
+	if (status & pdata->int_status_ce_mask) {
+		handle_ce(mci);
+
+		/* acknowledge the CE interrupt */
+		regmap_write(npcm_regmap, pdata->ctl_int_ack,
+			     pdata->int_ack_ce_mask);
+		return IRQ_HANDLED;
+	} else if (status & pdata->int_status_ue_mask) {
+		handle_ue(mci);
+
+		/* acknowledge the UE interrupt */
+		regmap_write(npcm_regmap, pdata->ctl_int_ack,
+			     pdata->int_ack_ue_mask);
+		return IRQ_HANDLED;
+	}
+
+	WARN_ON_ONCE(1);
+	return IRQ_NONE;
+}
+
+static ssize_t force_ecc_error(struct file *file, const char __user *data,
+			       size_t count, loff_t *ppos)
+{
+	struct device *dev = file->private_data;
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct priv_data *priv = mci->pvt_info;
+	const struct npcm_platform_data *pdata;
+	u32 val, syndrome;
+	int ret;
+
+	pdata = priv->pdata;
+	edac_printk(KERN_INFO, EDAC_MOD_NAME,
+		    "force an ECC error, type = %d, location = %d, bit = %d\n",
+		    priv->error_type, priv->location, priv->bit);
+
+	/* ensure no pending writes */
+	ret = regmap_read_poll_timeout(npcm_regmap, pdata->ctl_controller_busy,
+				       val, !(val & pdata->controller_busy_mask),
+				       1000, 10000);
+	if (ret) {
+		edac_printk(KERN_INFO, EDAC_MOD_NAME,
+			    "wait pending writes timeout\n");
+		return count;
+	}
+
+	regmap_read(npcm_regmap, pdata->ctl_xor_check_bits, &val);
+	val &= ~pdata->xor_check_bits_mask;
+
+	/* write syndrome to XOR_CHECK_BITS */
+	if (priv->error_type == ERROR_TYPE_CORRECTABLE) {
+		if (priv->location == ERROR_LOCATION_DATA &&
+		    priv->bit > ERROR_BIT_DATA_MAX) {
+			edac_printk(KERN_INFO, EDAC_MOD_NAME,
+				    "data bit should not exceed %d (%d)\n",
+				    ERROR_BIT_DATA_MAX, priv->bit);
+			return count;
+		}
+
+		if (priv->location == ERROR_LOCATION_CHECKCODE &&
+		    priv->bit > ERROR_BIT_CHECKCODE_MAX) {
+			edac_printk(KERN_INFO, EDAC_MOD_NAME,
+				    "checkcode bit should not exceed %d (%d)\n",
+				    ERROR_BIT_CHECKCODE_MAX, priv->bit);
+			return count;
+		}
+
+		syndrome = priv->location ? 1 << priv->bit
+					  : data_synd[priv->bit];
+
+		regmap_write(npcm_regmap, pdata->ctl_xor_check_bits,
+			     val | (syndrome << pdata->xor_check_bits_shift) |
+			     pdata->writeback_en_mask);
+	} else if (priv->error_type == ERROR_TYPE_UNCORRECTABLE) {
+		regmap_write(npcm_regmap, pdata->ctl_xor_check_bits,
+			     val | (UE_SYNDROME << pdata->xor_check_bits_shift));
+	}
+
+	/* force write check */
+	regmap_update_bits(npcm_regmap, pdata->ctl_xor_check_bits,
+			   pdata->fwc_mask, pdata->fwc_mask);
+
+	return count;
+}
+
+static const struct file_operations force_ecc_error_fops = {
+	.open = simple_open,
+	.write = force_ecc_error,
+	.llseek = generic_file_llseek,
+};
+
+/*
+ * Setup debugfs for error injection.
+ *
+ * Nodes:
+ *   error_type		- 0: CE, 1: UE
+ *   location		- 0: data, 1: checkcode
+ *   bit		- 0 ~ 63 for data and 0 ~ 7 for checkcode
+ *   force_ecc_error	- trigger
+ *
+ * Examples:
+ *   1. Inject a correctable error (CE) at checkcode bit 7.
+ *      ~# echo 0 > /sys/kernel/debug/edac/npcm-edac/error_type
+ *      ~# echo 1 > /sys/kernel/debug/edac/npcm-edac/location
+ *      ~# echo 7 > /sys/kernel/debug/edac/npcm-edac/bit
+ *      ~# echo 1 > /sys/kernel/debug/edac/npcm-edac/force_ecc_error
+ *
+ *   2. Inject an uncorrectable error (UE).
+ *      ~# echo 1 > /sys/kernel/debug/edac/npcm-edac/error_type
+ *      ~# echo 1 > /sys/kernel/debug/edac/npcm-edac/force_ecc_error
+ */
+static void setup_debugfs(struct mem_ctl_info *mci)
+{
+	struct priv_data *priv = mci->pvt_info;
+
+	priv->debugfs = edac_debugfs_create_dir(mci->mod_name);
+	if (!priv->debugfs)
+		return;
+
+	edac_debugfs_create_x8("error_type", 0644, priv->debugfs, &priv->error_type);
+	edac_debugfs_create_x8("location", 0644, priv->debugfs, &priv->location);
+	edac_debugfs_create_x8("bit", 0644, priv->debugfs, &priv->bit);
+	edac_debugfs_create_file("force_ecc_error", 0200, priv->debugfs,
+				 &mci->dev, &force_ecc_error_fops);
+}
+
+static int setup_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
+{
+	const struct npcm_platform_data *pdata;
+	int ret, irq;
+
+	pdata = ((struct priv_data *)mci->pvt_info)->pdata;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		edac_printk(KERN_ERR, EDAC_MOD_NAME, "IRQ not defined in DTS\n");
+		return irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, edac_ecc_isr, 0,
+			       dev_name(&pdev->dev), mci);
+	if (ret < 0) {
+		edac_printk(KERN_ERR, EDAC_MOD_NAME, "failed to request IRQ\n");
+		return ret;
+	}
+
+	/* enable the functional group of ECC and mask the others */
+	regmap_write(npcm_regmap, pdata->ctl_int_mask_master,
+		     pdata->int_mask_master_non_ecc_mask);
+
+	if (pdata->chip == NPCM8XX_CHIP)
+		regmap_write(npcm_regmap, pdata->ctl_int_mask_ecc,
+			     pdata->int_mask_ecc_non_event_mask);
+
+	return 0;
+}
+
+static const struct regmap_config npcm_regmap_cfg = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+};
+
+static int edac_probe(struct platform_device *pdev)
+{
+	const struct npcm_platform_data *pdata;
+	struct device *dev = &pdev->dev;
+	struct edac_mc_layer layers[1];
+	struct mem_ctl_info *mci;
+	struct priv_data *priv;
+	void __iomem *reg;
+	u32 val;
+	int rc;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	npcm_regmap = devm_regmap_init_mmio(dev, reg, &npcm_regmap_cfg);
+	if (IS_ERR(npcm_regmap))
+		return PTR_ERR(npcm_regmap);
+
+	pdata = of_device_get_match_data(dev);
+	if (!pdata)
+		return -EINVAL;
+
+	/* bail out if ECC is not enabled */
+	regmap_read(npcm_regmap, pdata->ctl_ecc_en, &val);
+	if (!(val & pdata->ecc_en_mask)) {
+		edac_printk(KERN_ERR, EDAC_MOD_NAME, "ECC is not enabled\n");
+		return -EPERM;
+	}
+
+	edac_op_state = EDAC_OPSTATE_INT;
+
+	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
+	layers[0].size = 1;
+
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+			    sizeof(struct priv_data));
+	if (!mci)
+		return -ENOMEM;
+
+	mci->pdev = &pdev->dev;
+	priv = mci->pvt_info;
+	priv->reg = reg;
+	priv->pdata = pdata;
+	platform_set_drvdata(pdev, mci);
+
+	mci->mtype_cap = MEM_FLAG_DDR4;
+	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
+	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
+	mci->scrub_mode = SCRUB_HW_SRC;
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->ctl_name = "npcm_ddr_controller";
+	mci->dev_name = dev_name(&pdev->dev);
+	mci->mod_name = EDAC_MOD_NAME;
+	mci->ctl_page_to_phys = NULL;
+
+	rc = setup_irq(mci, pdev);
+	if (rc)
+		goto free_edac_mc;
+
+	rc = edac_mc_add_mc(mci);
+	if (rc)
+		goto free_edac_mc;
+
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG) && pdata->chip == NPCM8XX_CHIP)
+		setup_debugfs(mci);
+
+	return rc;
+
+free_edac_mc:
+	edac_mc_free(mci);
+	return rc;
+}
+
+static int edac_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct priv_data *priv = mci->pvt_info;
+	const struct npcm_platform_data *pdata;
+
+	pdata = priv->pdata;
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG) && pdata->chip == NPCM8XX_CHIP)
+		edac_debugfs_remove_recursive(priv->debugfs);
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	regmap_write(npcm_regmap, pdata->ctl_int_mask_master,
+		     pdata->int_mask_master_global_mask);
+	regmap_update_bits(npcm_regmap, pdata->ctl_ecc_en, pdata->ecc_en_mask, 0);
+
+	return 0;
+}
+
+static const struct npcm_platform_data npcm750_edac = {
+	.chip				= NPCM7XX_CHIP,
+
+	/* memory controller registers */
+	.ctl_ecc_en			= 0x174,
+	.ctl_int_status			= 0x1d0,
+	.ctl_int_ack			= 0x1d4,
+	.ctl_int_mask_master		= 0x1d8,
+	.ctl_ce_addr_l			= 0x188,
+	.ctl_ce_data_l			= 0x190,
+	.ctl_ce_synd			= 0x18c,
+	.ctl_ue_addr_l			= 0x17c,
+	.ctl_ue_data_l			= 0x184,
+	.ctl_ue_synd			= 0x180,
+	.ctl_source_id			= 0x194,
+
+	/* masks and shifts */
+	.ecc_en_mask			= BIT(24),
+	.int_status_ce_mask		= GENMASK(4, 3),
+	.int_status_ue_mask		= GENMASK(6, 5),
+	.int_ack_ce_mask		= GENMASK(4, 3),
+	.int_ack_ue_mask		= GENMASK(6, 5),
+	.int_mask_master_non_ecc_mask	= GENMASK(30, 7) | GENMASK(2, 0),
+	.int_mask_master_global_mask	= BIT(31),
+	.ce_synd_mask			= GENMASK(6, 0),
+	.ce_synd_shift			= 0,
+	.ue_synd_mask			= GENMASK(6, 0),
+	.ue_synd_shift			= 0,
+	.source_id_ce_mask		= GENMASK(29, 16),
+	.source_id_ce_shift		= 16,
+	.source_id_ue_mask		= GENMASK(13, 0),
+	.source_id_ue_shift		= 0,
+};
+
+static const struct npcm_platform_data npcm845_edac = {
+	.chip =				NPCM8XX_CHIP,
+
+	/* memory controller registers */
+	.ctl_ecc_en			= 0x16c,
+	.ctl_int_status			= 0x228,
+	.ctl_int_ack			= 0x244,
+	.ctl_int_mask_master		= 0x220,
+	.ctl_int_mask_ecc		= 0x260,
+	.ctl_ce_addr_l			= 0x18c,
+	.ctl_ce_addr_h			= 0x190,
+	.ctl_ce_data_l			= 0x194,
+	.ctl_ce_data_h			= 0x198,
+	.ctl_ce_synd			= 0x190,
+	.ctl_ue_addr_l			= 0x17c,
+	.ctl_ue_addr_h			= 0x180,
+	.ctl_ue_data_l			= 0x184,
+	.ctl_ue_data_h			= 0x188,
+	.ctl_ue_synd			= 0x180,
+	.ctl_source_id			= 0x19c,
+	.ctl_controller_busy		= 0x20c,
+	.ctl_xor_check_bits		= 0x174,
+
+	/* masks and shifts */
+	.ecc_en_mask			= GENMASK(17, 16),
+	.int_status_ce_mask		= GENMASK(1, 0),
+	.int_status_ue_mask		= GENMASK(3, 2),
+	.int_ack_ce_mask		= GENMASK(1, 0),
+	.int_ack_ue_mask		= GENMASK(3, 2),
+	.int_mask_master_non_ecc_mask	= GENMASK(30, 3) | GENMASK(1, 0),
+	.int_mask_master_global_mask	= BIT(31),
+	.int_mask_ecc_non_event_mask	= GENMASK(8, 4),
+	.ce_addr_h_mask			= GENMASK(1, 0),
+	.ce_synd_mask			= GENMASK(15, 8),
+	.ce_synd_shift			= 8,
+	.ue_addr_h_mask			= GENMASK(1, 0),
+	.ue_synd_mask			= GENMASK(15, 8),
+	.ue_synd_shift			= 8,
+	.source_id_ce_mask		= GENMASK(29, 16),
+	.source_id_ce_shift		= 16,
+	.source_id_ue_mask		= GENMASK(13, 0),
+	.source_id_ue_shift		= 0,
+	.controller_busy_mask		= BIT(0),
+	.xor_check_bits_mask		= GENMASK(23, 16),
+	.xor_check_bits_shift		= 16,
+	.writeback_en_mask		= BIT(24),
+	.fwc_mask			= BIT(8),
+};
+
+static const struct of_device_id npcm_edac_of_match[] = {
+	{
+		.compatible = "nuvoton,npcm750-memory-controller",
+		.data = &npcm750_edac
+	},
+	{
+		.compatible = "nuvoton,npcm845-memory-controller",
+		.data = &npcm845_edac
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, npcm_edac_of_match);
+
+static struct platform_driver npcm_edac_driver = {
+	.driver = {
+		.name = "npcm-edac",
+		.of_match_table = npcm_edac_of_match,
+	},
+	.probe = edac_probe,
+	.remove = edac_remove,
+};
+
+module_platform_driver(npcm_edac_driver);
+
+MODULE_AUTHOR("Medad CChien <medadyoung@gmail.com>");
+MODULE_AUTHOR("Marvin Lin <kflin@nuvoton.com>");
+MODULE_DESCRIPTION("Nuvoton NPCM EDAC Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

