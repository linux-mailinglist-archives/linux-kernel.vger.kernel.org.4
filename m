Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC89611316
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiJ1NiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiJ1Ngx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:36:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7861D8F3E;
        Fri, 28 Oct 2022 06:36:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64A0CB82A32;
        Fri, 28 Oct 2022 13:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D599DC433B5;
        Fri, 28 Oct 2022 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964208;
        bh=lRsIeDE32txxDgHrud50FwieDzQk0o7XsNx3fuKa/K8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8ydrud/TbG1bxP20NM9JP9aGmFglm7HgtrjO6rrnLFzyjsYdmajBFoPalOj3B077
         I6eyT6A9PH3ZMCBFvYVGgGo7H8gX0WUEtoyiuPkRtNaHqvlkT0jk7WWRgnibvhR9wv
         CK3SSUIf6kdvP/VVOmmLqLNmzUL7RBDlJcRTLDMHtpXR4P4st7mxGtU5y9yF1IwaXb
         bkYrHUjOHSK+sA6LoWyTIbe7lU5d1PYTsHhemgcbZznl2UEqrqoMdd73LYthTxTQn6
         sZoSn0qxcqekcEt6o4GP0UxNKRTGyw3hZcHkcckyLTGURI6VnAP1sSB25fB3Iun0P0
         7oMFixD3rBQsw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPXH-0004qx-07; Fri, 28 Oct 2022 15:36:35 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v4 02/16] phy: qcom-qmp-pcie: move device-id table
Date:   Fri, 28 Oct 2022 15:35:49 +0200
Message-Id: <20221028133603.18470-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028133603.18470-1-johan+linaro@kernel.org>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.37.3

