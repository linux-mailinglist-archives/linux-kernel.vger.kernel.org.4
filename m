Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8BA609EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJXKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiJXKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9CC19C33;
        Mon, 24 Oct 2022 03:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0DFB61173;
        Mon, 24 Oct 2022 10:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D1BC433D6;
        Mon, 24 Oct 2022 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666606023;
        bh=0hzUAeDiWrfZBYKIvIEdXlwF8MUsk8JJpNzgiTtrLCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ix2AL/EW5Arc0bYOZSRRKXdegUidwM6qgvI3WADFJgw1frJOwJ2uKKIHxKhUOkxzh
         SZvyMtBaPr+LeCeDdaKctPPwdw/WO+/GPE076jdpkoTGPKaoOEzwRsr2cseErs7vOj
         7ZONirFV0gUBMDmqi/SYmlNj4bIhI5oJ1lGTCK757H8qD+3D2JsmmKdfepRSVcYo4/
         E2MPguc6f7MhSyOAElLf8t7u+okJUudZlPb/bBdGoL/tW9ColaijE1nqDG6sKb17jx
         egWUIwPNzGpWhxuGmz6kx/N4QB6v2mQnG+YuQed6l3XdkHADWURGYBjXTsZJjgNsKn
         i288rQ6p71zFw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omuM2-0005MA-UC; Mon, 24 Oct 2022 12:06:46 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 03/13] phy: qcom-qmp-usb: move device-id table
Date:   Mon, 24 Oct 2022 12:06:22 +0200
Message-Id: <20221024100632.20549-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024100632.20549-1-johan+linaro@kernel.org>
References: <20221024100632.20549-1-johan+linaro@kernel.org>
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

