Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3E627BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbiKNLIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbiKNLH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED42720BFA;
        Mon, 14 Nov 2022 03:07:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3774DB80DEC;
        Mon, 14 Nov 2022 11:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12FFC43470;
        Mon, 14 Nov 2022 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424033;
        bh=gb5CrES5i1MPh8b3132Uh6ovMit58esVSHhwegvZhXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPXUbtH363d6xWDkySjUNZHgid1Q3I3xjwHiHYSYjRVKFIIGxrb7ai2GP1ihrhCQE
         bO5lOMPlY+K9NRYimuchRFYPajLQj0CPBFZSfmiEgPssRscgLMZMeTd7ktaybgDRcc
         rgXP3ku1jAVPahbPiMDbtowcAYh++tCDOrwNE7a9O5fsumipIaFLAonXR/lz8TqfdI
         PsLcih/q83m43h6+nPvxsNP9mqffhfUYz9eq6Gs3+FoG6j+nk2hRCMvlLuC/ns0mWy
         XYRiujCLkVKUtJSIM/DsEpavzGwoPPm8yRvkzz+bJ+DX3k864omsP0N6O0IfNBCadW
         cFb9JS7WwpN7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIX-0001ET-U7; Mon, 14 Nov 2022 12:06:41 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 02/22] phy: qcom-qmp-combo: move device-id table
Date:   Mon, 14 Nov 2022 12:06:01 +0100
Message-Id: <20221114110621.4639-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221114110621.4639-1-johan+linaro@kernel.org>
References: <20221114110621.4639-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the device-id table after probe() and next to the driver structure
to keep the driver callback functions grouped together.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 50 +++++++++++------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index d6a031bcfc30..e7c8c4417142 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2646,31 +2646,6 @@ static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
 	return 0;
 }
 
-static const struct of_device_id qmp_combo_of_match_table[] = {
-	{
-		.compatible = "qcom,sc7180-qmp-usb3-dp-phy",
-		.data = &sc7180_usb3dpphy_cfg,
-	},
-	{
-		.compatible = "qcom,sc8180x-qmp-usb3-dp-phy",
-		.data = &sc8180x_usb3dpphy_cfg,
-	},
-	{
-		.compatible = "qcom,sc8280xp-qmp-usb43dp-phy",
-		.data = &sc8280xp_usb43dpphy_combo_cfg,
-	},
-	{
-		.compatible = "qcom,sdm845-qmp-usb3-dp-phy",
-		.data = &sdm845_usb3dpphy_cfg,
-	},
-	{
-		.compatible = "qcom,sm8250-qmp-usb3-dp-phy",
-		.data = &sm8250_usb3dpphy_cfg,
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, qmp_combo_of_match_table);
-
 static const struct dev_pm_ops qmp_combo_pm_ops = {
 	SET_RUNTIME_PM_OPS(qmp_combo_runtime_suspend,
 			   qmp_combo_runtime_resume, NULL)
@@ -2815,6 +2790,31 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct of_device_id qmp_combo_of_match_table[] = {
+	{
+		.compatible = "qcom,sc7180-qmp-usb3-dp-phy",
+		.data = &sc7180_usb3dpphy_cfg,
+	},
+	{
+		.compatible = "qcom,sc8180x-qmp-usb3-dp-phy",
+		.data = &sc8180x_usb3dpphy_cfg,
+	},
+	{
+		.compatible = "qcom,sc8280xp-qmp-usb43dp-phy",
+		.data = &sc8280xp_usb43dpphy_combo_cfg,
+	},
+	{
+		.compatible = "qcom,sdm845-qmp-usb3-dp-phy",
+		.data = &sdm845_usb3dpphy_cfg,
+	},
+	{
+		.compatible = "qcom,sm8250-qmp-usb3-dp-phy",
+		.data = &sm8250_usb3dpphy_cfg,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qmp_combo_of_match_table);
+
 static struct platform_driver qmp_combo_driver = {
 	.probe		= qmp_combo_probe,
 	.driver = {
-- 
2.37.4

