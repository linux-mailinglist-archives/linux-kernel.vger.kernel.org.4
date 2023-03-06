Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B116AC534
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCFPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCFPdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:33:33 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B342C9EC0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:32:57 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v11so10763397plz.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 07:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98/PwVeFNeIxQrm0IqUyAA3dXph0wAaYOEANDm444S8=;
        b=A1e/RScdJkJm9bV3vORIbmXntCvyiLZ0oPFG+OkSsOq3JHkUdZkeZ4dZAPITPeroUu
         QICTLjQcp0mVKXKoWW3KGaSBVEG8xBHpujXfemnnD4heJYu8vk765X9zJ27asNqA5KHz
         h0SyW9RZhIuih7nkfYBazhZi+pviJablbY+K2qG/enrTFAfnLGSsfy/dTx9Zf5hjuRZM
         7j/gvZJQMHoifMJ6XAxXiBReKp+K8aopKrubS9qOSQiA5/F67qr0tCicqv4M36Ft6iIh
         kUWJ55Ig9Y+hGYd1TnGHGmeP7sBB8N08qNrP6LWxU3zGVIQnR+uIEpG1V0uLemOoJ92t
         qqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98/PwVeFNeIxQrm0IqUyAA3dXph0wAaYOEANDm444S8=;
        b=j+U0KyvZipPUTiXqMm9yxqSVfOMMfpAV+uYtUFfgSB5Y/4M1XvO+KeF8GWYh/A6QrM
         zCoc/VdmmkLXaakNmHOb/3WXPk1IvxyWiClLRYiyglyiOhzbd1UhGyeZvyEPbRx3uvDq
         zR9z21mNJzqpYWspbTwWvx8WVe2kI2flTmQjYdr1VZ6eS2Fm3n9xtdDR9GY7zFEHvk49
         qXTWpdbwOgek5pAwYeN/rOmcU9Q4WTW1bvPJ+hBu7d7WwHZTZkzQvqmqX2F9zRW2UgA2
         ZpW+IpZARkq9IMVYk5zQEIcvBW8vbf8avV0eIJwXU8wo3SSa3mSnCHsH+HdAeD8oUaeZ
         DLBQ==
X-Gm-Message-State: AO0yUKVRXSlToDxV2wJQDB2S44YGSC/4f7V5n5bnINGS83K59OK+u4uh
        NZFit/6OMgZ69KtU7nv2O1W5
X-Google-Smtp-Source: AK7set/IwLf6A0+z3yMo6tDIwKR7A+i6IcvpEVK/5fVmZgnPXiP8s6rMFStPAIVtr/yo3nM6hcz/BQ==
X-Received: by 2002:a17:902:e842:b0:19a:b4a9:9ddb with SMTP id t2-20020a170902e84200b0019ab4a99ddbmr14567372plg.49.1678116775561;
        Mon, 06 Mar 2023 07:32:55 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:32:54 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/19] PCI: qcom: Add missing macros for register fields
Date:   Mon,  6 Mar 2023 21:02:07 +0530
Message-Id: <20230306153222.157667-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the registers are changed using hardcoded bitfields without macros.
This provides no information on what the register setting is about. So add
the macros to those fields for making the code more understandable.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 42 +++++++++++++++-----------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e9f4c70b719a..926a531fda3a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -63,6 +63,7 @@
 #define MISC_CONTROL_1_REG			0x8BC
 
 /* PARF_SYS_CTRL register fields */
+#define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -87,6 +88,7 @@
 /* PARF_PHY_CTRL register fields */
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		FIELD_PREP(PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK, x)
+#define PHY_TEST_PWR_DOWN			BIT(0)
 
 /* PARF_PHY_REFCLK register fields */
 #define PHY_REFCLK_SSP_EN			BIT(16)
@@ -103,6 +105,12 @@
 #define MSTR_AXI_CLK_EN				BIT(1)
 #define BYPASS					BIT(4)
 
+/* PARF_AXI_MSTR_WR_ADDR_HALT register fields */
+#define EN					BIT(31)
+
+/* PARF_LTSSM register fields */
+#define LTSSM_EN				BIT(8)
+
 /* PARF_DEVICE_TYPE register fields */
 #define DEVICE_TYPE_RC				0x4
 
@@ -440,7 +448,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
@@ -595,7 +603,7 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		u32 val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 
-		val |= BIT(31);
+		val |= EN;
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
@@ -608,7 +616,7 @@ static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 
 	/* enable link training */
 	val = readl(pcie->parf + PARF_LTSSM);
-	val |= BIT(8);
+	val |= LTSSM_EN;
 	writel(val, pcie->parf + PARF_LTSSM);
 }
 
@@ -715,7 +723,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	/* change DBI base address */
@@ -723,15 +731,15 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
-	val &= ~BIT(29);
+	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
 	writel(val, pcie->parf + PARF_SYS_CTRL);
 
 	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BIT(4);
+	val |= BYPASS;
 	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
 	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= BIT(31);
+	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
@@ -994,7 +1002,7 @@ static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	/* change DBI base address */
@@ -1002,15 +1010,15 @@ static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
-	val &= ~BIT(29);
+	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
 	writel(val, pcie->parf + PARF_SYS_CTRL);
 
 	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BIT(4);
+	val |= BYPASS;
 	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
 	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= BIT(31);
+	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
@@ -1159,7 +1167,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
 
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
@@ -1275,7 +1283,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	/* change DBI base address */
@@ -1283,11 +1291,11 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
-	val &= ~BIT(29);
+	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;
 	writel(val, pcie->parf + PARF_SYS_CTRL);
 
 	val = readl(pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
-	val |= BIT(4);
+	val |= BYPASS;
 	writel(val, pcie->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
 	/* Enable L1 and L1SS */
@@ -1297,7 +1305,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
-		val |= BIT(31);
+		val |= EN;
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
@@ -1390,7 +1398,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
 
 	val = readl(pcie->parf + PARF_PHY_CTRL);
-	val &= ~BIT(0);
+	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
 	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
-- 
2.25.1

