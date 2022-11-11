Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FCA6256AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiKKJ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiKKJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:26:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EAE78796;
        Fri, 11 Nov 2022 01:26:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61F8361F14;
        Fri, 11 Nov 2022 09:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EB8C4167D;
        Fri, 11 Nov 2022 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668158765;
        bh=T9qqTTBL27ycLB1W/KzDlhrr+fxrApzTdIw4MN0Ey6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHKfKYMGVMadIo0eJUaMr8jltPskcAKWZ6BW0NJje0uRDKWt3NAeTlWUvz5axT5c8
         54PhJJ5Tr84XIBhuv69S+ufmb67UjYzV4vIdFqvlsE+fAM8UcaonjXhy4z+qmz1+9O
         ZupfEOgejTyJWkHJ80E4i3+a9QdmZqfVvMQirgn7nxqsJWFqs55bQAdXw4RqkOmLmr
         APHoZ4x4alf1lGbC/DJtUx3HBzvzum4ekX5nXGxP8AOSMHTIb5gyHx99R3Mgj+R0xp
         i2zzqhDIgLx7+x9CLx4UiHxqi4KydB1GIoy0+0ffy7blRrASkZhalXwTeaPlCVqeN7
         kPYhGalitvkCg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQI5-0002lB-80; Fri, 11 Nov 2022 10:25:37 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 09/14] phy: qcom-qmp-combo: add clock registration helper
Date:   Fri, 11 Nov 2022 10:24:52 +0100
Message-Id: <20221111092457.10546-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111092457.10546-1-johan+linaro@kernel.org>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
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

In preparation for supporting devicetree bindings which do not use child
nodes, add a clock registration helper to handle the registration of
both the USB and DP clocks.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index d513b8924aee..4309ae6db997 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2459,6 +2459,22 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
+static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *usb_np,
+					struct device_node *dp_np)
+{
+	int ret;
+
+	ret = phy_pipe_clk_register(qmp, usb_np);
+	if (ret)
+		return ret;
+
+	ret = phy_dp_clks_register(qmp, dp_np);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int qmp_combo_parse_dt_lecacy_dp(struct qmp_combo *qmp, struct device_node *np)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -2618,11 +2634,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_node_put;
 
-	ret = phy_pipe_clk_register(qmp, usb_np);
-	if (ret)
-		goto err_node_put;
-
-	ret = phy_dp_clks_register(qmp, dp_np);
+	ret = qmp_combo_register_clocks(qmp, usb_np, dp_np);
 	if (ret)
 		goto err_node_put;
 
-- 
2.37.4

