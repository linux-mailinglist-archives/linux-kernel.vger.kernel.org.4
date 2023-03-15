Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85296BA81C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjCOGoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjCOGnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:43:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30DD3029D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cn6so5161696pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ4Ik+ZoB8puIUL4lEznFsK6NoJYzy77sft3aaSqBZo=;
        b=AV8UR5r1AV0UHjp08qF6vyDL+7vrNN6T6xvzXPSempXyWloqZ738Br7f1QYvth6ssR
         xPf3G3XLxkXOC7apyNZygEIpgTGjLs9oVyW6WCfm9WLtp+xxSv7+feNktoSvU/BVjIBm
         WHzJ8u34GQYZfVB0q/C2CQ0XoiwwgDoBPY28+VVxhdMm/bMzjuG8F7WYOlebqWrY3znc
         vsvFj/l3dv7Q7rw603+qmihOc5ZcJ/X4+M8/HgWB7JMjnF26apMq4meI/WZIXDfkNFK3
         xWYJ2gzCH5Ln3Ohv94tflr9ER9Exmq8oZDSW3JiIYqdrJ7WYWhIFWOlrwYW8c1CvU51L
         4/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ4Ik+ZoB8puIUL4lEznFsK6NoJYzy77sft3aaSqBZo=;
        b=GW2FjKwjrlof4O5jrVihW2HWHJ79fBXtFOJ5qJiLB0DB/YLe1uQIvdm/fYzPrCfuVU
         p1yZvn7ITtllMxqExBmw289sgR5PBOoj/2XBv4/55lDM+abm2gpNLmi5pHJwcrG0QTWU
         HuHkoKvg4Qf4ZLIxCACpMCo/u6BOLqiTNUfPHhAjB9RF61jG6N5VXMvAQwIqnasTmHgB
         yR1ZyEZzkThvigmm77+L4Y7yjQEmm90LCugu/8BZJAz3hPT2WZi+6ay2MEJ2fxeo548i
         31mnuPYHLWuPniWKq1wvcAhuuNw9qbDL6Gzootv5CSTxvs/wNRQVDJnPb1efDnUZt4dX
         z93g==
X-Gm-Message-State: AO0yUKVOOg8Etji/bdHjjUZRR+d4NdmYDfVNaLPMLYf33wBkLkozkSMW
        ySS0x3As35tXNLi3YuNLaeTB
X-Google-Smtp-Source: AK7set8Yb4ka/j5rCCzJaordlG2xUICDvGFogi5L0zWFLp7vu28Sn+ugDKBvAOEN+SEVeGChEm7ExQ==
X-Received: by 2002:a17:90b:380f:b0:239:ea16:5b13 with SMTP id mq15-20020a17090b380f00b00239ea165b13mr41672460pjb.14.1678862611211;
        Tue, 14 Mar 2023 23:43:31 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a6a8400b002367325203fsm550747pjj.50.2023.03.14.23.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:43:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 06/18] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.1.0
Date:   Wed, 15 Mar 2023 12:12:43 +0530
Message-Id: <20230315064255.15591-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
References: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the resets are asserted and deasserted at the same time. So the bulk
reset APIs can be used to handle them together. This simplifies the code
a lot.

While at it, let's also move the qcom_pcie_resources_2_1_0 struct below
qcom_pcie_resources_1_0_0 to keep it sorted.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 129 +++++++------------------
 1 file changed, 34 insertions(+), 95 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4179ac973147..2d9116464842 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -143,22 +143,8 @@
 
 #define PERST_DELAY_US				1000
 
-#define QCOM_PCIE_2_1_0_MAX_SUPPLY		3
-#define QCOM_PCIE_2_1_0_MAX_CLOCKS		5
-
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
-struct qcom_pcie_resources_2_1_0 {
-	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
-	struct reset_control *pci_reset;
-	struct reset_control *axi_reset;
-	struct reset_control *ahb_reset;
-	struct reset_control *por_reset;
-	struct reset_control *phy_reset;
-	struct reset_control *ext_reset;
-	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
-};
-
 struct qcom_pcie_resources_1_0_0 {
 	struct clk *iface;
 	struct clk *aux;
@@ -168,6 +154,16 @@ struct qcom_pcie_resources_1_0_0 {
 	struct regulator *vdda;
 };
 
+#define QCOM_PCIE_2_1_0_MAX_CLOCKS		5
+#define QCOM_PCIE_2_1_0_MAX_RESETS		6
+#define QCOM_PCIE_2_1_0_MAX_SUPPLY		3
+struct qcom_pcie_resources_2_1_0 {
+	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
+	struct reset_control_bulk_data resets[QCOM_PCIE_2_1_0_MAX_RESETS];
+	int num_resets;
+	struct regulator_bulk_data supplies[QCOM_PCIE_2_1_0_MAX_SUPPLY];
+};
+
 #define QCOM_PCIE_2_3_2_MAX_SUPPLY	2
 struct qcom_pcie_resources_2_3_2 {
 	struct clk *aux_clk;
@@ -295,6 +291,7 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	bool is_apq = of_device_is_compatible(dev->of_node, "qcom,pcie-apq8064");
 	int ret;
 
 	res->supplies[0].supply = "vdda";
@@ -321,28 +318,20 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
-	if (IS_ERR(res->pci_reset))
-		return PTR_ERR(res->pci_reset);
-
-	res->axi_reset = devm_reset_control_get_exclusive(dev, "axi");
-	if (IS_ERR(res->axi_reset))
-		return PTR_ERR(res->axi_reset);
-
-	res->ahb_reset = devm_reset_control_get_exclusive(dev, "ahb");
-	if (IS_ERR(res->ahb_reset))
-		return PTR_ERR(res->ahb_reset);
+	res->resets[0].id = "pci";
+	res->resets[1].id = "axi";
+	res->resets[2].id = "ahb";
+	res->resets[3].id = "por";
+	res->resets[4].id = "phy";
+	res->resets[5].id = "ext";
 
-	res->por_reset = devm_reset_control_get_exclusive(dev, "por");
-	if (IS_ERR(res->por_reset))
-		return PTR_ERR(res->por_reset);
-
-	res->ext_reset = devm_reset_control_get_optional_exclusive(dev, "ext");
-	if (IS_ERR(res->ext_reset))
-		return PTR_ERR(res->ext_reset);
+	/* ext is optional on APQ8016 */
+	res->num_resets = is_apq ? 5 : 6;
+	ret = devm_reset_control_bulk_get_exclusive(dev, res->num_resets, res->resets);
+	if (ret < 0)
+		return ret;
 
-	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
-	return PTR_ERR_OR_ZERO(res->phy_reset);
+	return 0;
 }
 
 static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
@@ -350,12 +339,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
 
 	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
-	reset_control_assert(res->pci_reset);
-	reset_control_assert(res->axi_reset);
-	reset_control_assert(res->ahb_reset);
-	reset_control_assert(res->por_reset);
-	reset_control_assert(res->ext_reset);
-	reset_control_assert(res->phy_reset);
+	reset_control_bulk_assert(res->num_resets, res->resets);
 
 	writel(1, pcie->parf + PARF_PHY_CTRL);
 
@@ -370,12 +354,11 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 	int ret;
 
 	/* reset the PCIe interface as uboot can leave it undefined state */
-	reset_control_assert(res->pci_reset);
-	reset_control_assert(res->axi_reset);
-	reset_control_assert(res->ahb_reset);
-	reset_control_assert(res->por_reset);
-	reset_control_assert(res->ext_reset);
-	reset_control_assert(res->phy_reset);
+	ret = reset_control_bulk_assert(res->num_resets, res->resets);
+	if (ret < 0) {
+		dev_err(dev, "cannot assert resets\n");
+		return ret;
+	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
 	if (ret < 0) {
@@ -383,58 +366,14 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = reset_control_deassert(res->ahb_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert ahb reset\n");
-		goto err_deassert_ahb;
-	}
-
-	ret = reset_control_deassert(res->ext_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert ext reset\n");
-		goto err_deassert_ext;
-	}
-
-	ret = reset_control_deassert(res->phy_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert phy reset\n");
-		goto err_deassert_phy;
-	}
-
-	ret = reset_control_deassert(res->pci_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert pci reset\n");
-		goto err_deassert_pci;
-	}
-
-	ret = reset_control_deassert(res->por_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert por reset\n");
-		goto err_deassert_por;
-	}
-
-	ret = reset_control_deassert(res->axi_reset);
-	if (ret) {
-		dev_err(dev, "cannot deassert axi reset\n");
-		goto err_deassert_axi;
+	ret = reset_control_bulk_deassert(res->num_resets, res->resets);
+	if (ret < 0) {
+		dev_err(dev, "cannot deassert resets\n");
+		regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+		return ret;
 	}
 
 	return 0;
-
-err_deassert_axi:
-	reset_control_assert(res->por_reset);
-err_deassert_por:
-	reset_control_assert(res->pci_reset);
-err_deassert_pci:
-	reset_control_assert(res->phy_reset);
-err_deassert_phy:
-	reset_control_assert(res->ext_reset);
-err_deassert_ext:
-	reset_control_assert(res->ahb_reset);
-err_deassert_ahb:
-	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-
-	return ret;
 }
 
 static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
-- 
2.25.1

