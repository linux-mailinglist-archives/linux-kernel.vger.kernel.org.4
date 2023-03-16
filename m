Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC86BC86C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjCPIME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjCPIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:11:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF22A591B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:11:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u5so878591plq.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMQW4/oxLFiPbOOSfkN2DKJZnBx/fYxYW5HfAtqmjC0=;
        b=gxjW5cC0nCRV08nM0YBIn6F/iulACVeCYT/UNnAv0j4ADvPap2ahsgectqA2BmIiPu
         G4hqo995pB7c8xSC9OyUodd97DpBV3A//dHSJRIjWC+HgkJvJybHwCdzyT+yWjfWzH6R
         92HaZ/6CqAwI70HVSR5YNCO+baVUAkcEw7udSRZ471SGrnGT/yNYBv9mez3hJXanc06w
         DN0MxIRRbO/NErAQa2F1G6i1HiAvKArM4PzmJzxWAW0JsYn5CnfCeq22ivdMQ4MPZbXZ
         FHhPwkvZNyj8ACQ82b+Q1I/3o0Xyf95Rk1uf3vejZ7aKDzfTzP7U3dPnvERKix5umGgq
         Qhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMQW4/oxLFiPbOOSfkN2DKJZnBx/fYxYW5HfAtqmjC0=;
        b=7XF3f7cq06jjVOb0mv8JbclAMxSejO5rzn5qOOO8UETBjPEciHMJtcFVkN0xM4RZA9
         6ngXcX97aW5xz0gtDI0Ji3ApmDC90u9yuJlSe7qpdX+2ZB8tXNu2dQpLpTBYi5Inp0XO
         jkshOuRyzfSJySXttsc1ONEiCu/0EJ5vQK+HcfM7ILK+0pQDWJ52iIby/dDAmDGo4rVx
         aT2KMaSSPgCJfTqdkvK90ACj2PHSN7Q7m1927SJ/JkqdA4/6ECE4g++JxVppfvWXqdZu
         tdNdX9mX8PY0B+Y+rmRjkL5NSpyc+mYHVbbdT0WexKGy7TpJ8MADP/BWT8f4dfbv051M
         Dokg==
X-Gm-Message-State: AO0yUKXMBOrOUpkrOzz65+FO02wm9tC5t5p+CH3+HGx6uLqmetL4aymQ
        QJ+S21+A9zV18cIjDPjvI5Dx
X-Google-Smtp-Source: AK7set8bQz60LduhzXZ0vGOIu//PMh4fLUfYloft5cwCet8hTjEy5YuBgFKY1dAqmrq2j9EU8CRQHA==
X-Received: by 2002:a05:6a20:12c2:b0:d4:f4c1:ec33 with SMTP id v2-20020a056a2012c200b000d4f4c1ec33mr3437715pzg.6.1678954305457;
        Thu, 16 Mar 2023 01:11:45 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:11:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 03/19] PCI: qcom: Sort and group registers and bitfield definitions
Date:   Thu, 16 Mar 2023 13:41:01 +0530
Message-Id: <20230316081117.14288-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorting the registers and their bit definitions will make it easier to add
more definitions in the future and it also helps in maintenance.

While at it, let's also group the registers and bit definitions separately
as done in the pcie-qcom-ep driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 108 ++++++++++++++-----------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5855ad8e9c1c..a33653d576b6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -33,7 +33,36 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+/* PARF registers */
 #define PARF_SYS_CTRL				0x00
+#define PARF_PM_CTRL				0x20
+#define PARF_PCS_DEEMPH				0x34
+#define PARF_PCS_SWING				0x38
+#define PARF_PHY_CTRL				0x40
+#define PARF_PHY_REFCLK				0x4C
+#define PARF_CONFIG_BITS			0x50
+#define PARF_DBI_BASE_ADDR			0x168
+#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16C /* Register offset specific to IP ver 2.3.3 */
+#define PARF_MHI_CLOCK_RESET_CTRL		0x174
+#define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
+#define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1A8
+#define PARF_Q2A_FLUSH				0x1AC
+#define PARF_LTSSM				0x1B0
+#define PARF_SID_OFFSET				0x234
+#define PARF_BDF_TRANSLATE_CFG			0x24C
+#define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PARF_DEVICE_TYPE			0x1000
+#define PARF_BDF_TO_SID_TABLE_N			0x2000
+
+/* ELBI registers */
+#define ELBI_SYS_CTRL				0x04
+
+/* DBI registers */
+#define AXI_MSTR_RESP_COMP_CTRL0		0x818
+#define AXI_MSTR_RESP_COMP_CTRL1		0x81c
+#define MISC_CONTROL_1_REG			0x8BC
+
+/* PARF_SYS_CTRL register fields */
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -43,45 +72,56 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
-#define PARF_PM_CTRL				0x20
+/* PARF_PM_CTRL register fields */
 #define REQ_NOT_ENTR_L1				BIT(5)
 
-#define PARF_PHY_CTRL				0x40
+/* PARF_PCS_DEEMPH register fields */
+#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		((x) << 16)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	((x) << 8)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	((x) << 0)
+
+/* PARF_PCS_SWING register fields */
+#define PCS_SWING_TX_SWING_FULL(x)		((x) << 8)
+#define PCS_SWING_TX_SWING_LOW(x)		((x) << 0)
+
+/* PARF_PHY_CTRL register fields */
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
 
-#define PARF_PHY_REFCLK				0x4C
+/* PARF_PHY_REFCLK register fields */
 #define PHY_REFCLK_SSP_EN			BIT(16)
 #define PHY_REFCLK_USE_PAD			BIT(12)
 
-#define PARF_DBI_BASE_ADDR			0x168
-#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16C /* Register offset specific to IP rev 2.3.3 */
-#define PARF_MHI_CLOCK_RESET_CTRL		0x174
+/* PARF_CONFIG_BITS register fields */
+#define PHY_RX0_EQ(x)				((x) << 24)
+
+/* PARF_SLV_ADDR_SPACE_SIZE register value */
+#define SLV_ADDR_SPACE_SZ			0x10000000
+
+/* PARF_MHI_CLOCK_RESET_CTRL register fields */
 #define AHB_CLK_EN				BIT(0)
 #define MSTR_AXI_CLK_EN				BIT(1)
 #define BYPASS					BIT(4)
 
-#define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
-#define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1A8
-#define PARF_LTSSM				0x1B0
-#define PARF_SID_OFFSET				0x234
-#define PARF_BDF_TRANSLATE_CFG			0x24C
-#define PARF_DEVICE_TYPE			0x1000
-#define PARF_BDF_TO_SID_TABLE_N			0x2000
+/* PARF_DEVICE_TYPE register fields */
+#define DEVICE_TYPE_RC				0x4
 
-#define ELBI_SYS_CTRL				0x04
+/* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
 
-#define AXI_MSTR_RESP_COMP_CTRL0		0x818
+/* AXI_MSTR_RESP_COMP_CTRL0 register fields */
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_4K	0x5
-#define AXI_MSTR_RESP_COMP_CTRL1		0x81c
+
+/* AXI_MSTR_RESP_COMP_CTRL1 register fields */
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
-#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, \
-						250)
-#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, \
-						1)
+/* MISC_CONTROL_1_REG register fields */
+#define DBI_RO_WR_EN				1
+
+/* PCI_EXP_SLTCAP register fields */
+#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, 250)
+#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, 1)
 #define PCIE_CAP_SLOT_VAL			(PCI_EXP_SLTCAP_ABP | \
 						PCI_EXP_SLTCAP_PCP | \
 						PCI_EXP_SLTCAP_MRLSP | \
@@ -93,34 +133,12 @@
 						PCIE_CAP_SLOT_POWER_LIMIT_VAL | \
 						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
 
-#define PARF_Q2A_FLUSH				0x1AC
-
-#define MISC_CONTROL_1_REG			0x8BC
-#define DBI_RO_WR_EN				1
-
 #define PERST_DELAY_US				1000
-/* PARF registers */
-#define PARF_PCS_DEEMPH				0x34
-#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		((x) << 16)
-#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	((x) << 8)
-#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	((x) << 0)
-
-#define PARF_PCS_SWING				0x38
-#define PCS_SWING_TX_SWING_FULL(x)		((x) << 8)
-#define PCS_SWING_TX_SWING_LOW(x)		((x) << 0)
-
-#define PARF_CONFIG_BITS			0x50
-#define PHY_RX0_EQ(x)				((x) << 24)
-
-#define PARF_SLV_ADDR_SPACE_SIZE		0x358
-#define SLV_ADDR_SPACE_SZ			0x10000000
-
-#define DEVICE_TYPE_RC				0x4
 
-#define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
-#define QCOM_PCIE_2_1_0_MAX_CLOCKS	5
+#define QCOM_PCIE_2_1_0_MAX_SUPPLY		3
+#define QCOM_PCIE_2_1_0_MAX_CLOCKS		5
 
-#define QCOM_PCIE_CRC8_POLYNOMIAL (BIT(2) | BIT(1) | BIT(0))
+#define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
 struct qcom_pcie_resources_2_1_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
-- 
2.25.1

