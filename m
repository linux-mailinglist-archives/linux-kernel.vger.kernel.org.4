Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8366A5B484E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIJTpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 15:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiIJToU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 15:44:20 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08B45422CB;
        Sat, 10 Sep 2022 12:43:48 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id E512DDC7;
        Sat, 10 Sep 2022 22:46:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com E512DDC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839204;
        bh=3FE9Ja6dIdq52+yDjkeRftC8U1bvC0LxjX1pOa168Go=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=JasfJddh0oikqK77h2sGSEocpi1AJqqiGluVhcFbfYxlWeLqqRscqs7FurpTdkELF
         L263eRhwOfWGLp1QsjliqLPoPx1rayt48+hBP0RPmdphJvOykhIVZ2d7IQMfNaYD8Z
         10oIoztPxuphYAnCKha33G8Eh5gfAUvW+r3+YiMI=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:42:54 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 19/19] EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros
Date:   Sat, 10 Sep 2022 22:42:37 +0300
Message-ID: <20220910194237.10142-20-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the very handy helpers denoted in the subject the driver
has been created with the open-coded {mask,shift} statements. It makes the
code bulky, prone to mistakes and much harder to read. Seeing there are
many places in the driver implementing the CSR fields get/set pattern
let's use the FIELD_GET()/FIELD_PREP() macros introduced in the kernel
specifically for that case. In addition we suggest to use the BIT() and
GENMASK() macros to generate the CSR flags/masks. While at it unify the
row, column, rank, bank and bank group macros names to be looking in the
same way as the fields of the snps_ecc_error_info structure.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 123 +++++++++++++++++------------------
 1 file changed, 60 insertions(+), 63 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 49bb28af448b..7833bcff3e2e 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -91,22 +92,19 @@
 #define DDR_MSTR_DEV_X8			0x1
 #define DDR_MSTR_DEV_X16		0x2
 #define DDR_MSTR_DEV_X32		0x3
-#define DDR_MSTR_BUSWIDTH_MASK		0x3000
-#define DDR_MSTR_BUSWIDTH_SHIFT		12
+#define DDR_MSTR_BUSWIDTH_MASK		GENMASK(13, 12)
 #define DDRCTL_EWDTH_16			2
 #define DDRCTL_EWDTH_32			1
 #define DDRCTL_EWDTH_64			0
 
 /* ECC CFG0 register definitions */
-#define ECC_CFG0_MODE_MASK		0x7
+#define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
 #define ECC_CFG0_MODE_SECDED		0x4
 
 /* ECC status register definitions */
-#define ECC_STAT_UECNT_MASK		0xF0000
-#define ECC_STAT_UECNT_SHIFT		16
-#define ECC_STAT_CECNT_MASK		0xF00
-#define ECC_STAT_CECNT_SHIFT		8
-#define ECC_STAT_BITNUM_MASK		0x7F
+#define ECC_STAT_UE_MASK		GENMASK(23, 16)
+#define ECC_STAT_CE_MASK		GENMASK(15, 8)
+#define ECC_STAT_BITNUM_MASK		GENMASK(6, 0)
 
 /* ECC control/clear register definitions */
 #define ECC_CTRL_CLR_CE_ERR		BIT(0)
@@ -117,49 +115,41 @@
 #define ECC_CTRL_EN_UE_IRQ		BIT(9)
 
 /* ECC error count register definitions */
-#define ECC_ERRCNT_UECNT_MASK		0xFFFF0000
-#define ECC_ERRCNT_UECNT_SHIFT		16
-#define ECC_ERRCNT_CECNT_MASK		0xFFFF
+#define ECC_ERRCNT_UECNT_MASK		GENMASK(31, 16)
+#define ECC_ERRCNT_CECNT_MASK		GENMASK(15, 0)
 
 /* DDR QOS Interrupt register definitions */
 #define DDR_QOS_IRQ_STAT_OFST		0x20200
-#define DDR_QOSUE_MASK			0x4
-#define	DDR_QOSCE_MASK			0x2
-#define	ECC_CE_UE_INTR_MASK		0x6
+#define DDR_QOSUE_MASK			BIT(2)
+#define DDR_QOSCE_MASK			BIT(1)
+#define ECC_CE_UE_INTR_MASK		(DDR_QOSUE_MASK | DDR_QOSCE_MASK)
 #define DDR_QOS_IRQ_EN_OFST		0x20208
 #define DDR_QOS_IRQ_DB_OFST		0x2020C
 
 /* ECC Corrected Error Register Mask and Shifts*/
-#define ECC_CEADDR0_RW_MASK		0x3FFFF
-#define ECC_CEADDR0_RNK_MASK		BIT(24)
-#define ECC_CEADDR1_BNKGRP_MASK		0x3000000
-#define ECC_CEADDR1_BNKNR_MASK		0x70000
-#define ECC_CEADDR1_COL_MASK		0xFFF
-#define ECC_CEADDR1_BNKGRP_SHIFT	24
-#define ECC_CEADDR1_BNKNR_SHIFT		16
+#define ECC_CEADDR0_RANK_MASK		GENMASK(27, 24)
+#define ECC_CEADDR0_ROW_MASK		GENMASK(17, 0)
+#define ECC_CEADDR1_BANKGRP_MASK	GENMASK(25, 24)
+#define ECC_CEADDR1_BANK_MASK		GENMASK(23, 16)
+#define ECC_CEADDR1_COL_MASK		GENMASK(11, 0)
 
 /* ECC Poison register shifts */
-#define ECC_POISON0_RANK_SHIFT		24
-#define ECC_POISON0_RANK_MASK		BIT(24)
-#define ECC_POISON0_COLUMN_SHIFT	0
-#define ECC_POISON0_COLUMN_MASK		0xFFF
-#define ECC_POISON1_BG_SHIFT		28
-#define ECC_POISON1_BG_MASK		0x30000000
-#define ECC_POISON1_BANKNR_SHIFT	24
-#define ECC_POISON1_BANKNR_MASK		0x7000000
-#define ECC_POISON1_ROW_SHIFT		0
-#define ECC_POISON1_ROW_MASK		0x3FFFF
+#define ECC_POISON0_RANK_MASK		GENMASK(27, 24)
+#define ECC_POISON0_COL_MASK		GENMASK(11, 0)
+#define ECC_POISON1_BANKGRP_MASK	GENMASK(29, 28)
+#define ECC_POISON1_BANK_MASK		GENMASK(26, 24)
+#define ECC_POISON1_ROW_MASK		GENMASK(17, 0)
 
 /* DDR Memory type defines */
-#define MEM_TYPE_DDR3			0x1
-#define MEM_TYPE_LPDDR3			0x8
-#define MEM_TYPE_DDR2			0x4
-#define MEM_TYPE_DDR4			0x10
-#define MEM_TYPE_LPDDR4			0x20
+#define MEM_TYPE_DDR3			BIT(0)
+#define MEM_TYPE_DDR2			BIT(2)
+#define MEM_TYPE_LPDDR3			BIT(3)
+#define MEM_TYPE_DDR4			BIT(4)
+#define MEM_TYPE_LPDDR4			BIT(5)
 
 /* DDRC ECC CE & UE poison mask */
-#define ECC_CEPOISON_MASK		0x3
-#define ECC_UEPOISON_MASK		0x1
+#define ECC_CEPOISON_MASK		GENMASK(1, 0)
+#define ECC_UEPOISON_MASK		BIT(0)
 
 /* DDRC Device config shifts/masks */
 #define DDR_MAX_ROW_SHIFT		18
@@ -304,38 +294,40 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	if (!regval)
 		return 1;
 
-	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
+	p->ceinfo.bitpos = FIELD_GET(ECC_STAT_BITNUM_MASK, regval);
 
 	regval = readl(base + ECC_ERRCNT_OFST);
-	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
-	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
+	p->ce_cnt = FIELD_GET(ECC_ERRCNT_CECNT_MASK, regval);
+	p->ue_cnt = FIELD_GET(ECC_ERRCNT_UECNT_MASK, regval);
 	if (!p->ce_cnt)
 		goto ue_err;
 
 	regval = readl(base + ECC_CEADDR0_OFST);
-	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	p->ceinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+
 	regval = readl(base + ECC_CEADDR1_OFST);
-	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
-					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ceinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
-					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
+	p->ceinfo.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	p->ceinfo.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	p->ceinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+
 	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
 		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
 		 readl(base + ECC_CSYND2_OFST));
+
 ue_err:
 	if (!p->ue_cnt)
 		goto out;
 
 	regval = readl(base + ECC_UEADDR0_OFST);
-	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	p->ueinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+
 	regval = readl(base + ECC_UEADDR1_OFST);
-	p->ueinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
-					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
-					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ueinfo.col = (regval & ECC_CEADDR1_COL_MASK);
+	p->ueinfo.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	p->ueinfo.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	p->ueinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 
 out:
@@ -510,7 +502,8 @@ static bool snps_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
-	regval = readl(base + ECC_CFG0_OFST) & ECC_CFG0_MODE_MASK;
+	regval = readl(base + ECC_CFG0_OFST);
+	regval = FIELD_GET(ECC_CFG0_MODE_MASK, regval);
 
 	return (regval == ECC_CFG0_MODE_SECDED);
 }
@@ -697,13 +690,13 @@ static void snps_data_poison_setup(struct snps_edac_priv *priv)
 	if (priv->rank_shift[0])
 		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
 
-	regval = (rank << ECC_POISON0_RANK_SHIFT) & ECC_POISON0_RANK_MASK;
-	regval |= (col << ECC_POISON0_COLUMN_SHIFT) & ECC_POISON0_COLUMN_MASK;
+	regval = FIELD_PREP(ECC_POISON0_RANK_MASK, rank) |
+		 FIELD_PREP(ECC_POISON0_COL_MASK, col);
 	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
 
-	regval = (bankgrp << ECC_POISON1_BG_SHIFT) & ECC_POISON1_BG_MASK;
-	regval |= (bank << ECC_POISON1_BANKNR_SHIFT) & ECC_POISON1_BANKNR_MASK;
-	regval |= (row << ECC_POISON1_ROW_SHIFT) & ECC_POISON1_ROW_MASK;
+	regval = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, bankgrp) |
+		 FIELD_PREP(ECC_POISON1_BANK_MASK, bank) |
+		 FIELD_PREP(ECC_POISON1_ROW_MASK, row);
 	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
 }
 
@@ -742,10 +735,14 @@ static ssize_t inject_data_poison_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct snps_edac_priv *priv = mci->pvt_info;
+	const char *errstr;
+	u32 regval;
+
+	regval = readl(priv->baseaddr + ECC_CFG1_OFST);
+	errstr = FIELD_GET(ECC_CEPOISON_MASK, regval) == ECC_CEPOISON_MASK ?
+		 "Correctable Error" : "UnCorrectable Error";
 
-	return sprintf(data, "Data Poisoning: %s\n\r",
-			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
-			? ("Correctable Error") : ("UnCorrectable Error"));
+	return sprintf(data, "Data Poisoning: %s\n\r", errstr);
 }
 
 static ssize_t inject_data_poison_store(struct device *dev,
@@ -852,7 +849,7 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 	int index;
 
 	memtype = readl(priv->baseaddr + DDR_MSTR_OFST);
-	width = (memtype & DDR_MSTR_BUSWIDTH_MASK) >> DDR_MSTR_BUSWIDTH_SHIFT;
+	width = FIELD_GET(DDR_MSTR_BUSWIDTH_MASK, memtype);
 
 	priv->col_shift[0] = 0;
 	priv->col_shift[1] = 1;
-- 
2.37.2

