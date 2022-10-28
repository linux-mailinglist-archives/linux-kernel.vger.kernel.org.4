Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7DF611368
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJ1NpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJ1Noy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC3C15FEE;
        Fri, 28 Oct 2022 06:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 700C362887;
        Fri, 28 Oct 2022 13:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C8EC43470;
        Fri, 28 Oct 2022 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964680;
        bh=UCwNgODPAGFNCmo5EINRknPKXGAC2JiAxvSu6aKJpY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSaOP7SOxRLNZo6BpLvU9Jq7W4opB9AwRa+v32sv4Sk+nok+1hV8TLDx+aubQR15g
         LA+mv4W31ze09jJ83Mgn4FXixa3XrmCvjCPl969KiWw5Ay7mU6osVU6rcpYnoK150h
         P/KZmvnrwnRbIIn69wTccoLmwgtF2aA+7oVIX3PQFg/l4fRx3xQW5lEe0ruWmE81dv
         XxZv0Iiw8kpJqZX+aVgcl5pp3ocCBJpSE/JgI7RuJ+ZAnPllKLS9+skK9l3e34tEpf
         BkM4IT4ABXkO4j5KLuzttQFxV+IFQlnv51E5Ir9UtZLm3X6FYe0cXIXzDvKrnrjpYU
         sYEcE8jaHXZLA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPes-000524-Ub; Fri, 28 Oct 2022 15:44:26 +0200
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
Subject: [PATCH v2 02/13] phy: qcom-qmp-usb: sort device-id table
Date:   Fri, 28 Oct 2022 15:43:56 +0200
Message-Id: <20221028134407.19300-3-johan+linaro@kernel.org>
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

Sort the device-id table by compatible string to make it easier to find
and add new entries.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

