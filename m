Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C54D61DB60
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiKEPC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiKEPCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:02:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA291055E;
        Sat,  5 Nov 2022 08:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A061960B4A;
        Sat,  5 Nov 2022 15:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01083C433B5;
        Sat,  5 Nov 2022 15:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660570;
        bh=eVTTvAzbKTl5nJxTY0KfBfBle3JTOhre2q4tdbvgPEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txblBFZFX5poDLWVqSVokTVR9xiRHl0vjxAyZRkI07GoYXJ67id57LaXdTkYM9FPY
         pNbg80cLTzRK3h18yP6+hNQCfdn1OJ3knuZ4Xd0Ie2zqjxbVv5Pyf/7c70LYkP+1MM
         iHATTziuvHNEpxEPW2tfTv/fsDJJN5XHEPlilbXrWSC8na+rZoFh1c05DFhhY+eTLU
         kTJz5/oBdKSbI30H5w9GRCL+Rwr7BEIr+3gsyJA53Yg19u79F2Z2+D/FxsbTdBEkxw
         pCUsRq1hL6S/TruTksb9CMFPCB1sz0eJtbgRfUjhc7tCPFJArRkm0cICB76fGVbN0V
         mEZdzqJa4vi9g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orKgo-0005KJ-Pj; Sat, 05 Nov 2022 16:02:30 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 02/16] phy: qcom-qmp-pcie: move device-id table
Date:   Sat,  5 Nov 2022 15:59:25 +0100
Message-Id: <20221105145939.20318-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221105145939.20318-1-johan+linaro@kernel.org>
References: <20221105145939.20318-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the device-id table below probe() and next to the driver structure
to keep the driver callback functions grouped together.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 90 ++++++++++++------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 4e5111d19692..e66f6adc404b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2280,51 +2280,6 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 	return 0;
 }
 
-static const struct of_device_id qmp_pcie_of_match_table[] = {
-	{
-		.compatible = "qcom,ipq6018-qmp-pcie-phy",
-		.data = &ipq6018_pciephy_cfg,
-	}, {
-		.compatible = "qcom,ipq8074-qmp-gen3-pcie-phy",
-		.data = &ipq8074_pciephy_gen3_cfg,
-	}, {
-		.compatible = "qcom,ipq8074-qmp-pcie-phy",
-		.data = &ipq8074_pciephy_cfg,
-	}, {
-		.compatible = "qcom,msm8998-qmp-pcie-phy",
-		.data = &msm8998_pciephy_cfg,
-	}, {
-		.compatible = "qcom,sc8180x-qmp-pcie-phy",
-		.data = &sc8180x_pciephy_cfg,
-	}, {
-		.compatible = "qcom,sdm845-qhp-pcie-phy",
-		.data = &sdm845_qhp_pciephy_cfg,
-	}, {
-		.compatible = "qcom,sdm845-qmp-pcie-phy",
-		.data = &sdm845_qmp_pciephy_cfg,
-	}, {
-		.compatible = "qcom,sdx55-qmp-pcie-phy",
-		.data = &sdx55_qmp_pciephy_cfg,
-	}, {
-		.compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy",
-		.data = &sm8250_qmp_gen3x1_pciephy_cfg,
-	}, {
-		.compatible = "qcom,sm8250-qmp-gen3x2-pcie-phy",
-		.data = &sm8250_qmp_gen3x2_pciephy_cfg,
-	}, {
-		.compatible = "qcom,sm8250-qmp-modem-pcie-phy",
-		.data = &sm8250_qmp_gen3x2_pciephy_cfg,
-	}, {
-		.compatible = "qcom,sm8450-qmp-gen3x1-pcie-phy",
-		.data = &sm8450_qmp_gen3x1_pciephy_cfg,
-	}, {
-		.compatible = "qcom,sm8450-qmp-gen4x2-pcie-phy",
-		.data = &sm8450_qmp_gen4x2_pciephy_cfg,
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, qmp_pcie_of_match_table);
-
 static int qmp_pcie_probe(struct platform_device *pdev)
 {
 	struct qcom_qmp *qmp;
@@ -2408,6 +2363,51 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct of_device_id qmp_pcie_of_match_table[] = {
+	{
+		.compatible = "qcom,ipq6018-qmp-pcie-phy",
+		.data = &ipq6018_pciephy_cfg,
+	}, {
+		.compatible = "qcom,ipq8074-qmp-gen3-pcie-phy",
+		.data = &ipq8074_pciephy_gen3_cfg,
+	}, {
+		.compatible = "qcom,ipq8074-qmp-pcie-phy",
+		.data = &ipq8074_pciephy_cfg,
+	}, {
+		.compatible = "qcom,msm8998-qmp-pcie-phy",
+		.data = &msm8998_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sc8180x-qmp-pcie-phy",
+		.data = &sc8180x_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sdm845-qhp-pcie-phy",
+		.data = &sdm845_qhp_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sdm845-qmp-pcie-phy",
+		.data = &sdm845_qmp_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sdx55-qmp-pcie-phy",
+		.data = &sdx55_qmp_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy",
+		.data = &sm8250_qmp_gen3x1_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-gen3x2-pcie-phy",
+		.data = &sm8250_qmp_gen3x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-modem-pcie-phy",
+		.data = &sm8250_qmp_gen3x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8450-qmp-gen3x1-pcie-phy",
+		.data = &sm8450_qmp_gen3x1_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sm8450-qmp-gen4x2-pcie-phy",
+		.data = &sm8450_qmp_gen4x2_pciephy_cfg,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qmp_pcie_of_match_table);
+
 static struct platform_driver qmp_pcie_driver = {
 	.probe		= qmp_pcie_probe,
 	.driver = {
-- 
2.37.4

