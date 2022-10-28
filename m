Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7AE61136A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJ1Npc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJ1Noy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:44:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E33A18B2A;
        Fri, 28 Oct 2022 06:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 225AAB82A34;
        Fri, 28 Oct 2022 13:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25E3C433D6;
        Fri, 28 Oct 2022 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964680;
        bh=5FuhaNPMo2qLoAJe3a2mSN3uSh2NjdtjTMRQLgn4Nzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5JhEQeBstctgYFHw3gK9iWt9WILAaJnkHNAnf/hfVUBaHRmDc1Hwb7nqictBuRJt
         mGAC6KFUJQX8tCMh1AJMBf0yKGhQ15gyOvkFPcyjZ923PeHPbDyxWzODoGvIIfLG8i
         F44NxkX9VvGMk9JigJS0brRL5GkptTRHryWmvJ19o6+XX8zuD1Y3bfGdMVCXi23ti/
         ssEYld/t+JLA+H3n64hvxT8IZgrkQ/RYln57Sit3Ilt/K1eE7YQuD5QQvIZfis4sZp
         QQknyf5JjWgTTfOoUrTQErYNbGW6A8A2/T9MyMSac5B43ez6vzrv7E+CumvY2z6cre
         3xQRy2KGpvu6g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPet-000526-1g; Fri, 28 Oct 2022 15:44:27 +0200
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
Subject: [PATCH v2 03/13] phy: qcom-qmp-usb: move device-id table
Date:   Fri, 28 Oct 2022 15:43:57 +0200
Message-Id: <20221028134407.19300-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028134407.19300-1-johan+linaro@kernel.org>
References: <20221028134407.19300-1-johan+linaro@kernel.org>
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
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 126 ++++++++++++------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 41a4548f3f99..4591128743c7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2501,69 +2501,6 @@ int qmp_usb_create(struct device *dev, struct device_node *np, int id,
 	return 0;
 }
 
-static const struct of_device_id qmp_usb_of_match_table[] = {
-	{
-		.compatible = "qcom,ipq6018-qmp-usb3-phy",
-		.data = &ipq8074_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,ipq8074-qmp-usb3-phy",
-		.data = &ipq8074_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,msm8996-qmp-usb3-phy",
-		.data = &msm8996_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,msm8998-qmp-usb3-phy",
-		.data = &msm8998_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,qcm2290-qmp-usb3-phy",
-		.data = &qcm2290_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,sc7180-qmp-usb3-phy",
-		.data = &sc7180_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,sc8180x-qmp-usb3-phy",
-		.data = &sm8150_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,sc8280xp-qmp-usb3-uni-phy",
-		.data = &sc8280xp_usb3_uniphy_cfg,
-	}, {
-		.compatible = "qcom,sdm845-qmp-usb3-phy",
-		.data = &qmp_v3_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,sdm845-qmp-usb3-uni-phy",
-		.data = &qmp_v3_usb3_uniphy_cfg,
-	}, {
-		.compatible = "qcom,sdx55-qmp-usb3-uni-phy",
-		.data = &sdx55_usb3_uniphy_cfg,
-	}, {
-		.compatible = "qcom,sdx65-qmp-usb3-uni-phy",
-		.data = &sdx65_usb3_uniphy_cfg,
-	}, {
-		.compatible = "qcom,sm8150-qmp-usb3-phy",
-		.data = &sm8150_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,sm8150-qmp-usb3-uni-phy",
-		.data = &sm8150_usb3_uniphy_cfg,
-	}, {
-		.compatible = "qcom,sm8250-qmp-usb3-phy",
-		.data = &sm8250_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,sm8250-qmp-usb3-uni-phy",
-		.data = &sm8250_usb3_uniphy_cfg,
-	}, {
-		.compatible = "qcom,sm8350-qmp-usb3-phy",
-		.data = &sm8350_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,sm8350-qmp-usb3-uni-phy",
-		.data = &sm8350_usb3_uniphy_cfg,
-	}, {
-		.compatible = "qcom,sm8450-qmp-usb3-phy",
-		.data = &sm8350_usb3phy_cfg,
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, qmp_usb_of_match_table);
-
 static const struct dev_pm_ops qmp_usb_pm_ops = {
 	SET_RUNTIME_PM_OPS(qmp_usb_runtime_suspend,
 			   qmp_usb_runtime_resume, NULL)
@@ -2665,6 +2602,69 @@ static int qmp_usb_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct of_device_id qmp_usb_of_match_table[] = {
+	{
+		.compatible = "qcom,ipq6018-qmp-usb3-phy",
+		.data = &ipq8074_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,ipq8074-qmp-usb3-phy",
+		.data = &ipq8074_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,msm8996-qmp-usb3-phy",
+		.data = &msm8996_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,msm8998-qmp-usb3-phy",
+		.data = &msm8998_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,qcm2290-qmp-usb3-phy",
+		.data = &qcm2290_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sc7180-qmp-usb3-phy",
+		.data = &sc7180_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sc8180x-qmp-usb3-phy",
+		.data = &sm8150_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sc8280xp-qmp-usb3-uni-phy",
+		.data = &sc8280xp_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sdm845-qmp-usb3-phy",
+		.data = &qmp_v3_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sdm845-qmp-usb3-uni-phy",
+		.data = &qmp_v3_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sdx55-qmp-usb3-uni-phy",
+		.data = &sdx55_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sdx65-qmp-usb3-uni-phy",
+		.data = &sdx65_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sm8150-qmp-usb3-phy",
+		.data = &sm8150_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sm8150-qmp-usb3-uni-phy",
+		.data = &sm8150_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-usb3-phy",
+		.data = &sm8250_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-usb3-uni-phy",
+		.data = &sm8250_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sm8350-qmp-usb3-phy",
+		.data = &sm8350_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sm8350-qmp-usb3-uni-phy",
+		.data = &sm8350_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sm8450-qmp-usb3-phy",
+		.data = &sm8350_usb3phy_cfg,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qmp_usb_of_match_table);
+
 static struct platform_driver qmp_usb_driver = {
 	.probe		= qmp_usb_probe,
 	.driver = {
-- 
2.37.3

