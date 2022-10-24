Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25DF609EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiJXKHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiJXKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:07:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B6E3BC59;
        Mon, 24 Oct 2022 03:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96850B810BC;
        Mon, 24 Oct 2022 10:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369D3C433C1;
        Mon, 24 Oct 2022 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666606023;
        bh=+eicq563sf78FfC0LYPYXOJGdE04LCFvaivbb6IWJvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=In6a8DMtpy0CcgBzWqRRH6u57ckKOHV0BMtNxLYpyAH/5t3vvljW/XO6ZogicdFKw
         bG9cp6xuVHxwyC+VPQkpLtyJvRt6VJ2kWKCG1NJdTsA2ecwfewfO8LQAbiDnSQDlJv
         66MaX0PCADuCPJHFKzYc+/RlnNwGPUPSUmt2HmSZk/N1goMLJyoc8zBKaWNI6R8MsH
         Vwu84sQt3+3wxcBEt5KCFNtxvJi+07Jc9Wfio2r+UCbyVScEWuEQ5XUhbci84UnFhq
         Vrl04+uZYx/t+1eFPaxhEf1pKZ0jYunftVV0dz8cxAAV6850AQzxwWISle6cr//0Fl
         DBFVWfS8skSQQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omuM2-0005M8-RK; Mon, 24 Oct 2022 12:06:46 +0200
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
Subject: [PATCH 02/13] phy: qcom-qmp-usb: sort device-id table
Date:   Mon, 24 Oct 2022 12:06:21 +0200
Message-Id: <20221024100632.20549-3-johan+linaro@kernel.org>
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

Sort the device-id table by compatible string to make it easier to find
and add new entries.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 26 ++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 82af28f4a91b..41a4548f3f99 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2503,14 +2503,20 @@ int qmp_usb_create(struct device *dev, struct device_node *np, int id,
 
 static const struct of_device_id qmp_usb_of_match_table[] = {
 	{
+		.compatible = "qcom,ipq6018-qmp-usb3-phy",
+		.data = &ipq8074_usb3phy_cfg,
+	}, {
 		.compatible = "qcom,ipq8074-qmp-usb3-phy",
 		.data = &ipq8074_usb3phy_cfg,
 	}, {
 		.compatible = "qcom,msm8996-qmp-usb3-phy",
 		.data = &msm8996_usb3phy_cfg,
 	}, {
-		.compatible = "qcom,ipq6018-qmp-usb3-phy",
-		.data = &ipq8074_usb3phy_cfg,
+		.compatible = "qcom,msm8998-qmp-usb3-phy",
+		.data = &msm8998_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,qcm2290-qmp-usb3-phy",
+		.data = &qcm2290_usb3phy_cfg,
 	}, {
 		.compatible = "qcom,sc7180-qmp-usb3-phy",
 		.data = &sc7180_usb3phy_cfg,
@@ -2527,8 +2533,11 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
 		.compatible = "qcom,sdm845-qmp-usb3-uni-phy",
 		.data = &qmp_v3_usb3_uniphy_cfg,
 	}, {
-		.compatible = "qcom,msm8998-qmp-usb3-phy",
-		.data = &msm8998_usb3phy_cfg,
+		.compatible = "qcom,sdx55-qmp-usb3-uni-phy",
+		.data = &sdx55_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sdx65-qmp-usb3-uni-phy",
+		.data = &sdx65_usb3_uniphy_cfg,
 	}, {
 		.compatible = "qcom,sm8150-qmp-usb3-phy",
 		.data = &sm8150_usb3phy_cfg,
@@ -2541,12 +2550,6 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8250-qmp-usb3-uni-phy",
 		.data = &sm8250_usb3_uniphy_cfg,
-	}, {
-		.compatible = "qcom,sdx55-qmp-usb3-uni-phy",
-		.data = &sdx55_usb3_uniphy_cfg,
-	}, {
-		.compatible = "qcom,sdx65-qmp-usb3-uni-phy",
-		.data = &sdx65_usb3_uniphy_cfg,
 	}, {
 		.compatible = "qcom,sm8350-qmp-usb3-phy",
 		.data = &sm8350_usb3phy_cfg,
@@ -2556,9 +2559,6 @@ static const struct of_device_id qmp_usb_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8450-qmp-usb3-phy",
 		.data = &sm8350_usb3phy_cfg,
-	}, {
-		.compatible = "qcom,qcm2290-qmp-usb3-phy",
-		.data = &qcm2290_usb3phy_cfg,
 	},
 	{ },
 };
-- 
2.37.3

